// =============================================================
//  Station ALMA-7, Part II: The Teleporter Incident
//  iOS Mobile Development · Module 4 · Lab Assignment
//
//  How to use:
//   • Xcode: File → New → Playground → Blank, replace everything
//     with this file's contents.
//   • Terminal: swift ALMA7_Part2_Starter.swift
//
//  Rules:
//   • Do NOT modify the STARTER DATA section.
//   • `!` (force unwrap) is forbidden: −0.5 points each.
//   • No map / filter / reduce / compactMap.
//   • Default to struct. Use class only where the task says so.
// =============================================================


// MARK: - =================== STARTER DATA ===================
// MARK: - Do not modify anything in this section

/// Splits a line into fields.
/// fields("crate:101:120")            -> ["crate", "101", "120"]
/// fields("livestock:lab mice:12:2")  -> ["livestock", "lab mice", "12", "2"]
/// fields("junk")                     -> ["junk"]
func fields(_ line: String, separatedBy separator: Character = ":") -> [String] {
    var result: [String] = []
    var current = ""
    for character in line {
        if character == separator {
            result.append(current)
            current = ""
        } else {
            current.append(character)
        }
    }
    result.append(current)
    return result
}

/// Cargo manifest as recovered from the damaged recorder.
let rawManifest = [
    "crate:101:120",
    "container:KZ-ALM-7:340",
    "livestock:lab mice:12:2",
    "???-corrupted-line",
    "crate:102:75",
    "container:KZ-ALM-9:410",
    "livestock:ficus:3:5",
    "crate:103:260",
    "crate:104:abc",
    ""
]

/// Oxygen readings. One of these deck names is not a real deck.
let deckReadings: [(deck: String, oxygen: Int)] = [
    (deck: "bridge",     oxygen: 78),
    (deck: "lab",        oxygen: 64),
    (deck: "greenhouse", oxygen: 55),
    (deck: "cargo",      oxygen: 12),
    (deck: "medbay",     oxygen: 90),
    (deck: "engine",     oxygen: 41)
]

/// Crew records, straight from the personnel file.
let crewData: [(name: String, deck: String, oxygen: Int)] = [
    (name: "Timur",   deck: "engine", oxygen: 62),
    (name: "Dana",    deck: "lab",    oxygen: 48),
    (name: "Aigerim", deck: "bridge", oxygen: 91),
    (name: "Nurlan",  deck: "cargo",  oxygen: 17)
]

print("ALMA-7 recorder online: \(rawManifest.count) manifest lines, \(deckReadings.count) readings, \(crewData.count) crew records.")

// MARK: - ================= END OF STARTER DATA =================


// MARK: - =================== YOUR SOLUTION ===================
// Uncomment each declaration when you start working on it.


// MARK: Level 1 · The Deck Register

// 1.1
// enum Deck: String, CaseIterable { }
enum Deck: String, CaseIterable {
    case bridge
    case lab
    case cargo
    case medbay
    case engine

    var evacuationPriority: Int {
        switch self {
        case .bridge:
            return 1
        case .medbay:
            return 2
        case .lab:
            return 3
        case .engine:
            return 4
        case .cargo:
            return 5
        }
    }
}

                
for deck in Deck.allCases {
    print("Deck:", deck.rawValue,
          "Priority:", deck.evacuationPriority)
}

// 1.2
// enum AlarmLevel: Int { }

enum AlarmLevel: Int {
    case green = 0
    case yellow
    case orange
    case red

    static func level(forTotalMass mass: Int) -> AlarmLevel {
        let level = min(max(mass / 500, 0), 3)
        return AlarmLevel(rawValue: level) ?? .green
    }
}

                
print("Alarm 0:", AlarmLevel.level(forTotalMass: 0))
print("Alarm 940:", AlarmLevel.level(forTotalMass: 940))
print("Alarm 4000:", AlarmLevel.level(forTotalMass: 4000))


// MARK: Level 2 · The Manifest

// 2.1
// enum ManifestEntry { }
enum ManifestEntry {
    case crate(id: Int, massKg: Int)
    case container(code: String, massKg: Int)
    case livestock(species: String, count: Int, massPerUnitKg: Int)
    case unknown(raw: String)
}


// 2.2
// func parseEntry(_ line: String) -> ManifestEntry { }
func parseEntry(_ line: String) -> ManifestEntry {
    let parts = fields(line)

    guard let tag = parts.first else {
        return .unknown(raw: line)
    }

    switch tag {

    case "crate":
        guard parts.count == 3,
              let id = Int(parts[1]),
              let mass = Int(parts[2])
        else {
            return .unknown(raw: line)
        }

        return .crate(id: id, massKg: mass)

    case "container":
        guard parts.count == 3,
              let mass = Int(parts[2])
        else {
            return .unknown(raw: line)
        }

        return .container(
            code: parts[1],
            massKg: mass
        )

    case "livestock":
        guard parts.count == 4,
              let count = Int(parts[2]),
              let massPerUnit = Int(parts[3])
        else {
            return .unknown(raw: line)
        }

        return .livestock(
            species: parts[1],
            count: count,
            massPerUnitKg: massPerUnit
        )

    default:
        return .unknown(raw: line)
    }
}


                
print(parseEntry("crate:101:120"))
print(parseEntry("container:KZ-ALM-7:340"))
print(parseEntry("livestock:lab mice:12:2"))
print(parseEntry("bad data"))


// 2.3
// func mass(of entry: ManifestEntry) -> Int { }
func mass(of entry: ManifestEntry) -> Int {
    switch entry {

    case .crate(_, let massKg):
        return massKg

    case .container(_, let massKg):
        return massKg

    case .livestock(_, let count, let massPerUnitKg):
        return count * massPerUnitKg

    case .unknown:
        return 0
    }
}


var manifestEntries: [ManifestEntry] = []
var totalMass = 0
var unknownCount = 0

for line in rawManifest {
    let entry = parseEntry(line)

    manifestEntries.append(entry)
    totalMass += mass(of: entry)

    if case .unknown = entry {
        unknownCount += 1
    }
}

print("Total manifest mass:", totalMass)
print("Unknown entries:", unknownCount)

let A = totalMass
print("A =", A)



// MARK: Level 3 · Crew Snapshots

// 3.1
struct CrewSnapshot {
    let name: String
    var deck: Deck
    var oxygen: Int

    mutating func breathe(_ amount: Int) {
        oxygen = max(0, oxygen - amount)
    }

    mutating func move(to deck: Deck) {
        self.deck = deck
    }

    mutating func reviveInMedbay() {
        self = CrewSnapshot(
            name: name,
            deck: .medbay,
            oxygen: 100
        )
    }

    static func rookie(named name: String) -> CrewSnapshot {
        return CrewSnapshot(
            name: name,
            deck: .bridge,
            oxygen: 100
        )
    }
}


                
var rookie1 = CrewSnapshot.rookie(named: "Alex")
print("Rookie:", rookie1)

rookie1.breathe(30)
print("After breathing:", rookie1)

rookie1.move(to: .lab)
print("After move:", rookie1)

rookie1.reviveInMedbay()
print("After revive:", rookie1)


// 3.2
var crewRoster: [CrewSnapshot] = []

for record in crewData {
    guard let deck = Deck(rawValue: record.deck) else {
        print("Warning: unknown deck for \(record.name): \(record.deck)")
        continue
    }

    let member = CrewSnapshot(
        name: record.name,
        deck: deck,
        oxygen: record.oxygen
    )

    crewRoster.append(member)
}

print("Crew roster:")
for member in crewRoster {
    print(member)
}


// 3.3 · Value semantics demonstration

// 1. Copy
var original = crewRoster[0]
var copy = original

print("Copy test BEFORE:")
print("Original:", original)
print("Copy:", copy)

copy.oxygen = 10

print("Copy test AFTER:")
print("Original:", original)
print("Copy:", copy)


// 2. Plain parameter
func changeSnapshot(_ member: CrewSnapshot) {
    var localMember = member
    localMember.oxygen = 5
    print("Inside plain function:", localMember)
}

print("Plain parameter BEFORE:", original)
changeSnapshot(original)
print("Plain parameter AFTER:", original)


// 3. inout
func changeSnapshotInout(_ member: inout CrewSnapshot) {
    member.oxygen = 5
}

print("Inout BEFORE:", original)
changeSnapshotInout(&original)
print("Inout AFTER:", original)


// MARK: Level 4 · The Teleport Pod

// 4.1
final class TeleportPod {
    let id: String
    var chargeLevel: Int
    var occupant: CrewSnapshot?

    init(id: String, chargeLevel: Int) {
        self.id = id
        self.chargeLevel = chargeLevel
        self.occupant = nil
    }

    func load(_ crew: CrewSnapshot) -> Bool {
        if occupant != nil || chargeLevel < 20 {
            return false
        }

        occupant = crew
        return true
    }

    func fire() -> CrewSnapshot? {
        guard let currentOccupant = occupant else {
            return nil
        }

        chargeLevel -= 20
        occupant = nil

        return currentOccupant
    }
}


// Tests
let testPod = TeleportPod(id: "TEST", chargeLevel: 50)

print("Load test:", testPod.load(crewRoster[0]))
print("Fire test:", testPod.fire() as Any)
print("Charge:", testPod.chargeLevel)


// 4.2 · Charge ledger

let pod = TeleportPod(id: "P-1", chargeLevel: 100)

print("Initial charge:", pod.chargeLevel)

// Timur
print("Load Timur:", pod.load(crewRoster[0]))
print("After load Timur:", pod.chargeLevel)

print("Fire Timur:", pod.fire() as Any)
print("After fire Timur:", pod.chargeLevel)

// Dana
print("Load Dana:", pod.load(crewRoster[1]))
print("After load Dana:", pod.chargeLevel)

print("Fire Dana:", pod.fire() as Any)
print("After fire Dana:", pod.chargeLevel)

// Nurlan
print("Load Nurlan:", pod.load(crewRoster[3]))
print("After load Nurlan:", pod.chargeLevel)

print("Fire Nurlan:", pod.fire() as Any)
print("After fire Nurlan:", pod.chargeLevel)

// Empty pod
print("Empty fire:", pod.fire() as Any)
print("After empty fire:", pod.chargeLevel)

let C = pod.chargeLevel
print("C =", C)


// 4.3 · Reference semantics demonstration

let podReference = pod

print("Pod reference BEFORE:")
print("pod:", pod.chargeLevel)
print("podReference:", podReference.chargeLevel)

podReference.chargeLevel = 25

print("Pod reference AFTER:")
print("pod:", pod.chargeLevel)
print("podReference:", podReference.chargeLevel)


// Compare with CrewSnapshot
var snapshot1 = crewRoster[0]
var snapshot2 = snapshot1

print("Snapshot BEFORE:")
print("snapshot1:", snapshot1.oxygen)
print("snapshot2:", snapshot2.oxygen)

snapshot2.oxygen = 1

print("Snapshot AFTER:")
print("snapshot1:", snapshot1.oxygen)
print("snapshot2:", snapshot2.oxygen)

// Rule:
// Struct copies are independent values.
// Class variables can reference the same object.


// MARK: Level 5 · Station Systems


// 5.1
final class Station {
    let callSign: String

    var hullIntegrity: Int {
        willSet {
            print("Hull integrity: \(hullIntegrity) -> \(newValue)")
        }

        didSet {
            if hullIntegrity > 100 {
                hullIntegrity = 100
            } else if hullIntegrity < 0 {
                hullIntegrity = 0
            }
        }
    }

    var oxygenByDeck: [Deck: Int]

    lazy var fullDiagnostics: String = {
        print("Running full scan...")
        return "Station \(callSign): hull \(hullIntegrity)%, total oxygen \(totalOxygen)"
    }()

    var totalOxygen: Int {
        var total = 0

        for oxygen in oxygenByDeck.values {
            total += oxygen
        }

        return total
    }

    var averageOxygen: Int {
        get {
            if oxygenByDeck.isEmpty {
                return 0
            }

            return totalOxygen / oxygenByDeck.count
        }

        set {
            for deck in oxygenByDeck.keys {
                oxygenByDeck[deck] = newValue
            }
        }
    }

    init(
        callSign: String,
        hullIntegrity: Int,
        deckReadings: [(deck: String, oxygen: Int)]
    ) {
        self.callSign = callSign
        self.hullIntegrity = hullIntegrity

        var readings: [Deck: Int] = [:]

        for reading in deckReadings {
            guard let deck = Deck(rawValue: reading.deck) else {
                print("Warning: unknown deck \(reading.deck)")
                continue
            }

            readings[deck] = reading.oxygen
        }

        self.oxygenByDeck = readings
    }
}


let station = Station(
    callSign: "ALMA-7",
    hullIntegrity: 85,
    deckReadings: deckReadings
)

print("Station:", station.callSign)
print("Oxygen by deck:", station.oxygenByDeck)
print("Total oxygen:", station.totalOxygen)

let B = station.averageOxygen
print("B =", B)


// averageOxygen setter test
print("Average before:", station.averageOxygen)

station.averageOxygen = 50

print("Average after:", station.averageOxygen)
print("Oxygen after setter:", station.oxygenByDeck)


// lazy property test
print("Before first diagnostics access")
print(station.fullDiagnostics)

print("Before second diagnostics access")
print(station.fullDiagnostics)


// 5.2 · The clamp trap

station.hullIntegrity = 130
print("Hull after 130:", station.hullIntegrity)

station.hullIntegrity = -40
print("Hull after -40:", station.hullIntegrity)

station.hullIntegrity = 55
print("Hull after 55:", station.hullIntegrity)

// Assigning to hullIntegrity inside didSet does not call
// the property observers again, so it does not create an infinite loop.


// MARK: Level 6 · Incident Reports
// Three of these compile and are wrong. One does not compile.
// For each: expectation, actual behaviour, the language rule, the fix.


// Report 1
//var roster = crewRoster
//for var member in roster {
//    member.oxygen -= 10
//}
//print(roster[0].oxygen)   // author expected the crew to have lost oxygen

// Expected:
// Changing member inside the loop should change roster.
//
// Actual:
// CrewSnapshot is a struct. "member" is a copy.
// Changing the copy does not change the array.
//
// Rule:
// Structs have value semantics.
//
// Fix:
var fixedRoster = crewRoster

for index in fixedRoster.indices {
    fixedRoster[index].oxygen -= 10
}

print("Report 1 fixed:", fixedRoster[0].oxygen)


// Report 2
//let podA = TeleportPod(id: "A", chargeLevel: 100)
//let podB = podA
//podB.chargeLevel = 0
//print(podA.chargeLevel)   // author expected 100
// Expected:
// podA should stay at 100.
//
// Actual:
// TeleportPod is a class.
// podA and podB reference the same object.
//
// Rule:
// Classes have reference semantics.
//
// Fix:
let fixedPodA = TeleportPod(id: "A", chargeLevel: 100)
let fixedPodB = TeleportPod(id: "B", chargeLevel: fixedPodA.chargeLevel)

fixedPodB.chargeLevel = 0

print("Report 2 pod A:", fixedPodA.chargeLevel)
print("Report 2 pod B:", fixedPodB.chargeLevel)


// Report 3
//struct Logbook {
//    var entries: [String] = []
//    func add(_ entry: String) {
//        entries.append(entry)
//    }
//}
// Expected:
// add() should append an entry.
//
// Actual:
// It does not compile because a struct method cannot modify
// a stored property unless the method is mutating.
//
// Rule:
// A struct method that changes self must be marked mutating.
//
// Fix:
struct Logbook {
    var entries: [String] = []

    mutating func add(_ entry: String) {
        entries.append(entry)
    }
}

var logbook = Logbook()
logbook.add("Teleport started")
logbook.add("Teleport finished")

print("Report 3:", logbook.entries)


// Report 4
//let snapshot = CrewSnapshot.rookie(named: "Dana")
//snapshot.oxygen = 40
//
//let pod = TeleportPod(id: "B", chargeLevel: 50)
//pod.chargeLevel = 10

// Expected:
// Both let values may look immutable.
//
// Actual:
// A let struct cannot have its stored properties changed.
// A let class reference cannot point to another object,
// but properties of that object can still change.
//
// This would NOT compile:
// let snapshot = CrewSnapshot.rookie(named: "Dana")
// snapshot.oxygen = 40
//
// Error:
// Cannot assign to property: 'snapshot' is a 'let' constant

// Fix for the struct:
var fixedSnapshot = CrewSnapshot.rookie(named: "Dana")
fixedSnapshot.oxygen = 40

print("Report 4 snapshot:", fixedSnapshot.oxygen)


// Class:
let fixedPod = TeleportPod(id: "B", chargeLevel: 50)
fixedPod.chargeLevel = 10

print("Report 4 pod:", fixedPod.chargeLevel)


// MARK: Level 7 · Sealing the Black Box

final class FlightRecorder {

    // private blocks direct access to the stored history.
    private var entries: [String] = []

    // private(set) allows reading from outside,
    // but only this type can change the value.
    private(set) var isSealed = false

    var entryCount: Int {
        return entries.count
    }

    var transcript: String {
        var result = ""

        for entry in entries {
            if !result.isEmpty {
                result += "\n"
            }

            result += entry
        }

        return result
    }

    func add(_ entry: String) {
        if isSealed {
            return
        }

        entries.append(entry)
    }

    func seal() {
        isSealed = true
    }

    // fileprivate allows code elsewhere in this same file to use it.
    fileprivate func auditData() -> String {
        return "Entries: \(entries.count), sealed: \(isSealed)"
    }
}


// Free function using fileprivate helper
func auditTranscript(of recorder: FlightRecorder) -> String {
    return recorder.auditData()
}


// Tests
let recorder = FlightRecorder()

recorder.add("Crew entered teleporter")
recorder.add("Teleport successful")

print("Recorder count:", recorder.entryCount)
print("Transcript:")
print(recorder.transcript)

print("Audit:", auditTranscript(of: recorder))

recorder.seal()

print("Sealed:", recorder.isSealed)

// This should do nothing because recorder is sealed.
recorder.add("This should not be added")

print("Count after sealed add:", recorder.entryCount)


// Failed attempts:
//
// recorder.entries.removeAll()
// Error: 'entries' is inaccessible due to 'private' protection level
//
// recorder.isSealed = false
// Error: cannot assign to property: 'isSealed' setter is inaccessible


// MARK: Finale · Integrity Code

let D = AlarmLevel.level(forTotalMass: A).rawValue
let integrityCode = "\(A)-\(B)-\(C)-\(D)"
print("INTEGRITY CODE: \(integrityCode)")



// MARK: Bonus

// deinit in TeleportPod, a do-block lifetime experiment, and === identity


func samePod(_ first: TeleportPod, _ second: TeleportPod) -> Bool {
    return first === second
}


// Identity test
let identityPod1 = TeleportPod(id: "IDENTITY", chargeLevel: 50)
let identityPod2 = identityPod1
let identityPod3 = TeleportPod(id: "IDENTITY", chargeLevel: 50)

print("Same reference:", samePod(identityPod1, identityPod2))
print("Different objects:", samePod(identityPod1, identityPod3))


// Lifetime / deinit test
print("Before do block")

do {
    let temporaryPod = TeleportPod(id: "TEMP", chargeLevel: 100)
    let secondReference = temporaryPod

    print("Inside block:", temporaryPod.id)
    print("Second reference:", secondReference.id)
    print("Leaving block")
}

print("After do block")


// MARK: - ================= DEFENSE QUESTIONS =================

/*
 1. Why did CrewSnapshot get an initializer for free and TeleportPod did not?
 
 CrewSnapshot is a struct.
 Swift automatically gives it a memberwise initializer for its stored properties.

 TeleportPod is a class.
 Classes do not get the same automatic memberwise initializer,
 so I wrote init(id:chargeLevel:) myself.

 2. What does `mutating` do to self, and why do classes never need it?
 
 A struct is a value type.
 A method needs mutating when it changes its properties or replaces self.

 For example:
 mutating func move(to deck: Deck) {
     self.deck = deck
 }

 3. In Report 4 both values are `let`. What exactly does `let` freeze for a
    struct, and what does it freeze for a class?

 For a struct, let makes the whole value immutable.
 So I cannot change snapshot.oxygen.

 For a class, let makes the reference constant.
 The reference cannot point to another object,
 but the object's var properties can still change.

 That is why this works:

 let pod = TeleportPod(id: "B", chargeLevel: 50)
 pod.chargeLevel = 10

 
 4. Why must a lazy property be var? When does lazy change behaviour, not
    just performance?

 A lazy property is created only when it is accessed for the first time.
 Because its value is assigned after initialization, it must be var.

 In fullDiagnostics, "Running full scan..." is not printed when Station
 is created. It is printed only when fullDiagnostics is accessed.
 So lazy changes when that work happens.

 
 5. private vs fileprivate: where in your FlightRecorder would private be
    too strict?

 private allows access only inside FlightRecorder.

 fileprivate allows access from other code in the same Swift file.

 My auditData() is fileprivate because the free function
 auditTranscript(of:) is outside FlightRecorder but needs to call it.

 Bonus. On which line does deinit fire, and why can't === be used on
 CrewSnapshot?
 
 deinit runs after leaving the do block, when the last reference to
 temporaryPod disappears.

 === checks whether two class references point to the exact same object.

 CrewSnapshot is a struct, not a class, so it has value semantics
 and cannot be compared with ===.

*/


