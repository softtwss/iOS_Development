// =============================================================
//  Station ALMA-7: Rescue Protocol
//  iOS Mobile Development · Module 3 · Lab Assignment
//
//  How to use:
//   • Xcode: File → New → Playground → Blank, replace everything
//     with this file's contents.
//   • Terminal: swift ALMA7_Starter.swift
//
//  Rules:
//   • Do NOT modify the STARTER CODE section.
//   • `!` (force unwrap) is forbidden: −0.5 points each.
//   • No map / filter / reduce / compactMap.
//   • Use the exact function names from the assignment PDF.
// =============================================================


// MARK: - =================== STARTER CODE ===================
// MARK: - Do not modify anything in this section

typealias Reading = (sensor: String, value: Int)

/// Splits a string at the first occurrence of the separator.
/// splitOnce("O2:87", by: ":") -> ("O2", "87")
/// splitOnce("hello", by: ":") -> nil
func splitOnce(_ line: String, by separator: Character) -> (String, String)? {
    guard let index = line.firstIndex(of: separator) else { return nil }
    let left = String(line[..<index])
    let right = String(line[line.index(after: index)...])
    return (left, right)
}

let rawLog = [
    "O2:87", "TEMP:-12", "O2:9x", "PRESS:101", "TEMP:abc", "O2:",
    "RAD:3", "O2:64", ":55", "TEMP:31", "PRESS:98", "O2:71",
    "RAD:-1", "TEMP:4", "PRESS:1o2", "O2:90"
]

class Tank {
    var level: Int
    init(level: Int) { self.level = level }
}

class Module {
    let name: String
    var oxygenTank: Tank?
    init(name: String, oxygenTank: Tank?) {
        self.name = name
        self.oxygenTank = oxygenTank
    }
}

class CrewMember {
    let name: String
    let role: String
    let priority: Int      // 1 = evacuated first
    var module: Module?    // nil = in open space
    init(name: String, role: String, priority: Int, module: Module?) {
        self.name = name
        self.role = role
        self.priority = priority
        self.module = module
    }
}

let lab  = Module(name: "Lab",  oxygenTank: Tank(level: 40))
let hab  = Module(name: "Hab",  oxygenTank: Tank(level: 12))
let dock = Module(name: "Dock", oxygenTank: nil)

let crew = [
    CrewMember(name: "Timur",   role: "Engineer",  priority: 3, module: lab),
    CrewMember(name: "Dana",    role: "Scientist", priority: 4, module: dock),
    CrewMember(name: "Aigerim", role: "Commander", priority: 1, module: hab),
    CrewMember(name: "Nurlan",  role: "Pilot",     priority: 2, module: nil)
]

var roster: [String: CrewMember] = [:]
for member in crew { roster[member.name] = member }

print("ALMA-7 systems online: \(rawLog.count) log lines, \(crew.count) crew members.")

// MARK: - ================= END OF STARTER CODE =================


// MARK: - =================== YOUR SOLUTION ===================
// Uncomment each signature when you start working on it.


// MARK: Level 1 · Decoding Telemetry

// 1.1
func parseReading(_ raw: String) -> Reading? {
    guard let parts = splitOnce(raw, by: ":"),
          !parts.0.isEmpty,
          let value = Int(parts.1),
          value >= 0 || parts.0 == "TEMP"
    else {
        return nil
    }

    return (sensor: parts.0, value: value)
}


// Tests
print(parseReading("O2:87") as Any)
print(parseReading("TEMP:-12") as Any)
print(parseReading("RAD:-1") as Any)
print(parseReading(":55") as Any)


// 1.2
func parseLog(_ lines: [String]) -> (valid: [Reading], invalidCount: Int) {
    var valid: [Reading] = []
    var invalidCount = 0

    for line in lines {
        if let reading = parseReading(line) {
            valid.append(reading)
        } else {
            invalidCount += 1
        }
    }

    return (valid, invalidCount)
}


// Tests
let logResult = parseLog(rawLog)

print("Valid readings:", logResult.valid)
print("Invalid count:", logResult.invalidCount)

let testLog = ["O2:50", "TEMP:-5", "BAD", ":20"]
print(parseLog(testLog))

let A = logResult.invalidCount
print("A =", A)

// MARK: Level 2 · Analysis

// 2.1
func select(_ readings: [Reading], where isIncluded: (Reading) -> Bool) -> [Reading] {
    var result: [Reading] = []

    for reading in readings {
        if isIncluded(reading) {
            result.append(reading)
        }
    }

    return result
}

func values(of readings: [Reading]) -> [Int] {
    var result: [Int] = []

    for reading in readings {
        result.append(reading.value)
    }

    return result
}


// O2 readings
let o2Readings = select(logResult.valid) { $0.sensor == "O2" }

print("O2 readings:", o2Readings)
print("O2 values:", values(of: o2Readings))


// 2.2
func stats(of values: [Int]) -> (min: Int, max: Int, average: Double)? {
    guard let first = values.first else {
        return nil
    }

    var minimum = first
    var maximum = first
    var total = 0

    for value in values {
        if value < minimum {
            minimum = value
        }

        if value > maximum {
            maximum = value
        }

        total += value
    }

    let average = Double(total) / Double(values.count)

    return (minimum, maximum, average)
}

func stats(_ values: Int...) -> (min: Int, max: Int, average: Double)? {
    stats(of: values)
}


// Tests
print("Stats test 1:", stats(3, 8, 1) as Any)
print("Stats test 2:", stats() as Any)

let o2Stats = stats(of: values(of: o2Readings))
let B = Int(o2Stats?.average ?? 0)

print("B =", B)


// 2.3 · The Closure Ladder

let sorted1 = logResult.valid.sorted(by: { (a: Reading, b: Reading) -> Bool in
    return a.value > b.value
})

let sorted2 = logResult.valid.sorted(by: { a, b in
    return a.value > b.value
})

let sorted3 = logResult.valid.sorted(by: { a, b in
    a.value > b.value
})

let sorted4 = logResult.valid.sorted(by: {
    $0.value > $1.value
})

let sorted5 = logResult.valid.sorted {
    $0.value > $1.value
}


// Verify that all five results are the same
func sameReadings(_ first: [Reading], _ second: [Reading]) -> Bool {
    guard first.count == second.count else {
        return false
    }

    for i in 0..<first.count {
        if first[i].sensor != second[i].sensor ||
            first[i].value != second[i].value {
            return false
        }
    }

    return true
}

let allSortsMatch =
    sameReadings(sorted1, sorted2) &&
    sameReadings(sorted2, sorted3) &&
    sameReadings(sorted3, sorted4) &&
    sameReadings(sorted4, sorted5)

print("All sorts match:", allSortsMatch)
print("Sorted readings:", sorted5)


// MARK: Level 3 · Temperature Stabilization


// 3.1
func heatUp(_ t: Int) -> Int {
    return t + 5
}

func coolDown(_ t: Int) -> Int {
    return t - 3
}

func hold(_ t: Int) -> Int {
    return t
}

func chooseProtocol(for temp: Int) -> (Int) -> Int {
    if temp < 18 {
        return heatUp
    } else if temp > 24 {
        return coolDown
    } else {
        return hold
    }
}


// Tests
print("Heat:", heatUp(10))
print("Cool:", coolDown(30))
print("Hold:", hold(20))


// 3.2
func runUntilStable(
    from start: Int,
    maxSteps: Int = 10
) -> (finalTemp: Int, steps: Int, isStable: Bool) {

    var temperature = start
    var steps = 0

    while (temperature < 18 || temperature > 24) && steps < maxSteps {
        let protocolFunction = chooseProtocol(for: temperature)
        temperature = protocolFunction(temperature)
        steps += 1
    }

    let isStable = temperature >= 18 && temperature <= 24

    return (temperature, steps, isStable)
}


// Tests
print("Stable test 1:", runUntilStable(from: 31))
print("Stable test 2:", runUntilStable(from: -100, maxSteps: 5))


// Find the lowest valid TEMP using our own functions
let tempReadings = select(logResult.valid) { $0.sensor == "TEMP" }
let tempValues = values(of: tempReadings)

var C = 0

if let tempStats = stats(of: tempValues) {
    C = runUntilStable(from: tempStats.min).steps
}

print("C =", C)


// MARK: Level 4 · The Crew

// 4.1
func oxygenLevel(of member: CrewMember) -> Int? {
    member.module?.oxygenTank?.level
}


// Tests
print("Timur oxygen:", oxygenLevel(of: crew[0]) as Any)
print("Dana oxygen:", oxygenLevel(of: crew[1]) as Any)


// 4.2
func status(of member: CrewMember) -> String {
    guard let level = oxygenLevel(of: member) else {
        let location = member.module?.name ?? "open space"
        return "\(member.name): no data (\(location))"
    }

    if level < 20 {
        return "\(member.name): \(level)% CRITICAL"
    } else {
        return "\(member.name): \(level)% OK"
    }
}


// Print whole crew
for member in crew {
    print(status(of: member))
}


// Extra tests
print(status(of: crew[0]))
print(status(of: crew[2]))


// 4.3
@discardableResult
func transferOxygen(
    from source: inout Int,
    to target: inout Int,
    amount: Int
) -> Int {

    if amount < 0 {
        return 0
    }

    let freeSpace = 100 - target
    let actualAmount = min(amount, source, freeSpace)

    source -= actualAmount
    target += actualAmount

    return actualAmount
}


// Transfer 30 from Lab to Hab
if let labTank = lab.oxygenTank,
   let habTank = hab.oxygenTank {

    let transferred = transferOxygen(
        from: &labTank.level,
        to: &habTank.level,
        amount: 30
    )

    print("Transferred:", transferred)
}


// D = Hab oxygen after transfer
let D = hab.oxygenTank?.level ?? 0

print("D =", D)


// 4.4
func evacuationOrder(
    _ names: String...,
    roster: [String: CrewMember]
) -> [String] {

    var found: [CrewMember] = []

    for name in names {
        guard let member = roster[name] else {
            print("Unknown crew member: \(name)")
            continue
        }

        found.append(member)
    }

    found.sort {
        $0.priority < $1.priority
    }

    var result: [String] = []

    for member in found {
        result.append(member.name)
    }

    return result
}


// Tests
let order1 = evacuationOrder(
    "Dana",
    "Ghost",
    "Aigerim",
    "Timur",
    roster: roster
)

print("Evacuation order:", order1)

let order2 = evacuationOrder(
    "Nurlan",
    "Timur",
    roster: roster
)

print("Evacuation order 2:", order2)

// MARK: Level 5 · The Saboteur's Logbook
// The saboteur's code is below, commented out (it needs your
// oxygenLevel(of:) to compile). Comment on every problem, then
// write fixed versions and a test that proves the logic bug is gone.

/*
func reportOxygen(for member: CrewMember) -> String {
    let tank = member.module!.oxygenTank!
    return "\(member.name): \(tank.level)%"
}

func firstCritical(in crew: [CrewMember]) -> String {
    var result: String?
    for member in crew {
        if oxygenLevel(of: member)! < 20 {
            result = member.name
        }
    }
    return result!
}
*/

// Problems in the original reportOxygen:
// 1. member.module! crashes when the member has no module.
//    Example: Nurlan is in open space.
//
// 2. oxygenTank! crashes when the module has no oxygen tank.
//    Example: Dana is in Dock, and Dock has no tank.
//
// Problems in the original firstCritical:
// 1. oxygenLevel(of: member)! crashes when oxygen data is nil.
//    Example: Dana or Nurlan.
//
// 2. result! crashes if there are no critical crew members.
//
// 3. The loop keeps replacing result.
//    So it returns the last critical member, not the first one.

func reportOxygen(for member: CrewMember) -> String {
    guard let level = oxygenLevel(of: member) else {
        return "\(member.name): no oxygen data"
    }

    return "\(member.name): \(level)%"
}


func firstCritical(in crew: [CrewMember]) -> String? {
    for member in crew {
        if let level = oxygenLevel(of: member),
           level < 20 {
            return member.name
        }
    }

    return nil
}


// Tests
print(reportOxygen(for: crew[0]))
print(reportOxygen(for: crew[1]))

print("First critical:", firstCritical(in: crew) as Any)


// Test for the logic bug:
// Two critical members. Correct result must be the FIRST one.
let testModule1 = Module(
    name: "Test 1",
    oxygenTank: Tank(level: 10)
)

let testModule2 = Module(
    name: "Test 2",
    oxygenTank: Tank(level: 5)
)

let testCrew = [
    CrewMember(
        name: "First",
        role: "Test",
        priority: 1,
        module: testModule1
    ),
    CrewMember(
        name: "Second",
        role: "Test",
        priority: 2,
        module: testModule2
    )
]

print("Logic test:", firstCritical(in: testCrew) as Any)


// MARK: Finale · Launch Code

// let launchCode = "\(A)-\(B)-\(C)-\(D)"
// print("LAUNCH CODE: \(launchCode)")

let launchCode = "\(A)-\(B)-\(C)-\(D)"
print("LAUNCH CODE: \(launchCode)")


// MARK: Bonus

func makeAlarm(threshold: Int) -> (Int) -> Bool {
    var count = 0

    return { level in
        if level < threshold {
            count += 1
            print("Alarm #\(count)")
            return true
        }

        return false
    }
}


// Bonus tests
let alarm = makeAlarm(threshold: 20)

print(alarm(12))   // Alarm #1, true
print(alarm(40))   // false
print(alarm(5))    // Alarm #2, true



// MARK: - ================= DEFENSE QUESTIONS =================
/*
 1. guard let vs if let beyond syntax:

 2. Why can't you pass [Int] to stats(_ values: Int...)?

 3. Why doesn't transferOxygen(from: &x, to: &x, amount: 5) compile?

 4. Why doesn't oxygenLevel(of: dana) ?? "no data" compile?

 5. Full type of chooseProtocol and how to read it:

 Bonus. Where does the alarm counter live after makeAlarm returns?

*/
