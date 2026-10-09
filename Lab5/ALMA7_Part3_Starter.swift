// =============================================================
//  Station ALMA-7, Part III: The Repair Fleet
//  iOS Mobile Development · Module 5 · Lab Assignment
//
//  How to use:
//   • Xcode: File → New → Playground → Blank, replace everything
//     with this file's contents.
//   • Terminal: swift ALMA7_Part3_Starter.swift
//
//  Rules:
//   • Do NOT modify the STARTER DATA section. LegacyBeacon in
//     particular must be reached with an extension, not edited.
//   • `!` (force unwrap) is forbidden: −0.5 points each.
//   • No map / filter / reduce / compactMap.
//   • The Health Rule must exist in exactly ONE place in this file.
// =============================================================


// MARK: - =================== STARTER DATA ===================
// MARK: - Do not modify anything in this section

/// Drone records recovered from the fleet registry.
/// One `kind` does not correspond to any drone type you will build.
let fleetData: [(kind: String, id: String, charge: Int)] = [
    (kind: "welder",  id: "W-1", charge: 80),
    (kind: "scanner", id: "S-1", charge: 45),
    (kind: "cargo",   id: "C-1", charge: 100),
    (kind: "welder",  id: "W-2", charge: 15),
    (kind: "scanner", id: "S-2", charge: 60),
    (kind: "tug",     id: "T-1", charge: 50)
]

/// Hull sensors. These are NOT drones — they never move and never work a shift.
let sensorData: [(id: String, charge: Int)] = [
    (id: "hull-cam", charge: 12),
    (id: "thermal",  charge: 77)
]

/// Hardware from the original station. You may not add anything to this
/// declaration — no methods, no protocols, no properties.
struct LegacyBeacon {
    let name: String
    let signalStrength: Int
}

let beacon = LegacyBeacon(name: "ALMA-BEACON", signalStrength: 8)

print("Fleet registry online: \(fleetData.count) drone records, \(sensorData.count) sensors, beacon \(beacon.name).")

// MARK: - ================= END OF STARTER DATA =================


// MARK: - =================== YOUR SOLUTION ===================
// Uncomment each declaration when you start working on it.


// MARK: Level 1 · The Power Cell
// A class lets multiple drone-related references share the same battery state.
final class PowerCell {
    private var charge: Int
    init(charge: Int) { self.charge = min(100, max(0, charge)) }
    func level() -> Int { charge }
    func spend(_ amount: Int) -> Bool {
        guard amount > 0, charge >= amount else { return false }
        charge -= amount
        return true
    }
    func recharge(by amount: Int) {
        guard amount > 0 else { return }
        charge = min(100, charge + amount)
    }
}
let testCell = PowerCell(charge: 35)
print("Cell start:", testCell.level())
print("Cell spend 10:", testCell.spend(10), "remaining:", testCell.level())
// testCell.charge = 100 // error: 'charge' is inaccessible due to 'private' protection level

// MARK: Level 2 · The Fleet
class Drone {
    let id: String
    let cell: PowerCell
    init(id: String, cell: PowerCell) { self.id = id; self.cell = cell }
    var powerCost: Int { 10 }
    var statusLine: String { "\(id): \(cell.level())% \(cell.level().powerBar)" }
    func performTask() -> Int { 0 }
    // final prevents subclasses from bypassing the spend-before-work safety ritual.
    final func runOnce() -> Int {
        guard cell.spend(powerCost) else { return 0 }
        return performTask()
    }
}
final class WelderDrone: Drone {
    override var powerCost: Int { 25 }
    override func performTask() -> Int { 40 }
    func weldSeam() -> String { "\(id): seam welded" }
}
class ScannerDrone: Drone {
    override var powerCost: Int { 10 }
    override func performTask() -> Int { 15 }
    override var statusLine: String { super.statusLine + " [scanner]" }
}
final class CargoDrone: Drone {
    override var powerCost: Int { 20 }
    override func performTask() -> Int { 25 }
}
func makeDrone(kind: String, id: String, charge: Int) -> Drone? {
    let cell = PowerCell(charge: charge)
    switch kind {
    case "welder": return WelderDrone(id: id, cell: cell)
    case "scanner": return ScannerDrone(id: id, cell: cell)
    case "cargo": return CargoDrone(id: id, cell: cell)
    default: return nil
    }
}
var fleet: [Drone] = []
for item in fleetData {
    if let drone = makeDrone(kind: item.kind, id: item.id, charge: item.charge) {
        fleet.append(drone)
    } else {
        print("WARNING: unknown drone kind \(item.kind) (\(item.id))")
    }
}
print("Fleet count:", fleet.count)
for drone in fleet { print("Created:", drone.statusLine) }

// MARK: Level 3 · The Shift
func runShift(_ fleet: [Drone], rounds: Int) -> Int {
    var work = 0
    for _ in 0..<max(0, rounds) {
        for drone in fleet { work += drone.runOnce() }
    }
    return work
}
let A = runShift(fleet, rounds: 3)
var B = 0
var C = 0
for drone in fleet {
    print("After shift:", drone.statusLine)
    B += drone.cell.level()
    if drone.cell.level() >= drone.powerCost { C += 1 }
}
print("Shift work:", A, "remaining charge:", B, "ready drones:", C)

// MARK: Level 4 · Diagnostics
protocol Diagnosable {
    var componentID: String { get }
    var statusCode: Int { get }
    func diagnose() -> String
}
protocol Rechargeable {
    mutating func recharge(by amount: Int)
}
// Classes have reference semantics; their methods may change state without mutating.
extension Drone: Diagnosable, Rechargeable {
    var componentID: String { id }
    var statusCode: Int { healthCode(for: cell.level()) }
    func recharge(by amount: Int) { cell.recharge(by: amount) }
}
struct SensorModule: Diagnosable, Rechargeable {
    let componentID: String
    var chargeLevel: Int
    var statusCode: Int { healthCode(for: chargeLevel) }
    mutating func recharge(by amount: Int) {
        guard amount > 0 else { return }
        chargeLevel = min(100, max(0, chargeLevel + amount))
    }
}
func diagnosticsReport(_ components: [Diagnosable]) -> String {
    var lines: [String] = []
    for component in components { lines.append(component.diagnose()) }
    return lines.joined(separator: "\n")
}
var sensors: [SensorModule] = []
for reading in sensorData {
    sensors.append(SensorModule(componentID: reading.id, chargeLevel: reading.charge))
}
// [Drone] cannot contain SensorModule because SensorModule is not a Drone subclass.
var components: [Diagnosable] = []
for drone in fleet { components.append(drone) }
for sensor in sensors { components.append(sensor) }
print("Diagnostics (drones and sensors):\n" + diagnosticsReport(components))

// MARK: Level 5 · Shared Behaviour
extension Diagnosable {
    func diagnose() -> String { "\(componentID): code \(statusCode)" }
    // This is the ONLY implementation of the station health thresholds.
    func healthCode(for level: Int) -> Int {
        if level < 20 { return 2 }
        if level < 50 { return 1 }
        return 0
    }
}
extension LegacyBeacon: Diagnosable {
    var componentID: String { name }
    var statusCode: Int { healthCode(for: signalStrength) }
    func diagnose() -> String { "LEGACY BEACON \(componentID): code \(statusCode)" }
}
components.append(beacon)
print("Diagnostics (including beacon):\n" + diagnosticsReport(components))
var D = 0
for component in components { D += component.statusCode }
extension Int {
    var powerBar: String {
        let blocks = Swift.min(10, Swift.max(0, self / 10))
        return String(repeating: "#", count: blocks) + String(repeating: ".", count: 10 - blocks)
    }
}
print("Power bars:", 42.powerBar, (-5).powerBar, 250.powerBar)

// MARK: Level 6 · Incident Reports
// Report 1: Author expected 30 work units. Actual: compiler error,
// "overriding declaration requires an 'override' keyword".
// Rule: overriding inherited methods requires override.
class PatchDrone: Drone {
    override func performTask() -> Int { 30 }
}
print("Report 1 fixed:", PatchDrone(id: "P-9", cell: PowerCell(charge: 40)).runOnce())
// Report 2: Author expected to customize runOnce. Actual: cannot inherit
// from final WelderDrone, and final runOnce cannot be overridden.
// Fix: use a new Drone subclass and override only the permitted methods.
final class HeavyWelder: Drone {
    override var powerCost: Int { 25 }
    override func performTask() -> Int { 60 }
}
print("Report 2 fixed:", HeavyWelder(id: "H-1", cell: PowerCell(charge: 80)).runOnce())
// Report 3: Author expected to call weldSeam through Drone.
// Actual: Drone has no member weldSeam. A downcast is required.
let reportFleet: [Drone] = [WelderDrone(id: "W-9", cell: PowerCell(charge: 100))]
let first = reportFleet[0]
if let welder = first as? WelderDrone {
    print("Report 3 fixed:", welder.weldSeam())
}
// as? returns an optional because a Drone is not necessarily a WelderDrone.
// Report 4: Author expected "thruster T-1" but gets "generic component".
// Rule: extension-only methods use static dispatch on protocol-typed values.
// Fix: add func label() -> String to the protocol requirements.
protocol Labelled {
    var componentID: String { get }
    func label() -> String
}
extension Labelled {
    func label() -> String { "generic component" }
}
struct Thruster: Labelled {
    let componentID: String
    func label() -> String { "thruster \(componentID)" }
}
let parts: [Labelled] = [Thruster(componentID: "T-1")]
print("Report 4 fixed:", parts[0].label())

// MARK: Finale · Mission Code
let missionCode = "\(A)-\(B)-\(C)-\(D)"
print("MISSION CODE: \(missionCode)")

// MARK: Bonus

// Two ways to forbid using Drone directly; a protocol-based redesign;
// two or three sentences comparing them.

// Runtime approach: precondition(type(of: self) != Drone.self) inside a base
// initializer rejects a plain Drone when the program runs (not enabled here).
// Compile-time approach: make the base initializer private and expose only
// subclass factories (requires reorganizing initialization), or replace the
// base class with a protocol that cannot be instantiated directly.

protocol DroneBlueprint {
    var id: String { get }
    var charge: Int { get set }
    var powerCost: Int { get }
    func performTask() -> Int
}
extension DroneBlueprint {
    mutating func runBlueprintOnce() -> Int {
        guard charge >= powerCost else { return 0 }
        charge -= powerCost
        return performTask()
    }
}
struct WelderBlueprint: DroneBlueprint {
    let id: String
    var charge: Int
    var powerCost: Int { 25 }
    func performTask() -> Int { 40 }
}
var blueprintFleet: [any DroneBlueprint] = [WelderBlueprint(id: "BW-1", charge: 80)]
var blueprint = WelderBlueprint(id: "BW-2", charge: 80)
print("Bonus protocol fleet:", blueprintFleet.count, "work:", blueprint.runBlueprintOnce())
// Protocol + structs avoids meaningless plain Drone objects and offers value
// semantics. The class design is preferable when drone instances must share
// mutable battery state; with structs we would need an explicit shared owner.

// MARK: - ================= DEFENSE QUESTIONS =================
/*
1. Why does a class satisfy a `mutating` protocol requirement without the
 keyword, while a struct must write it?
 
   Class instances are reference types, so a method can change their state
   without mutating. Structs are value types, so modifying self needs mutating.
 
2. One thing inheritance does that protocols cannot, and one thing
   protocols do that inheritance cannot:
   Inheritance shares stored properties and implementation through a superclass.
   Protocols let unrelated classes and structs share one interface.
 
3. What does `final` prevent, and what did it protect in runOnce()?
   final forbids overriding a method (or subclassing a final class).
   final runOnce protects the mandatory charge-before-work sequence.
 
4. In Report 4, why did the protocol extension's method win?
   label was only in the protocol extension, not a requirement, so a value
   typed as Labelled used the extension implementation (static dispatch).
   Adding label to the protocol makes the conformer's implementation dispatch.
*/


