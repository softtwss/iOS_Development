import Cocoa

var array: [Int] = [1, 2, 3]
let set: Set<String> = ["John", "Sam", "Sam"]
var dict: [String: Int] = ["Mom": 1111, "Dad": 2222, "Boss": 1234]

dict["Mom"] = 1212
dict["Son"] = 3131

array.append(4)
array.remove(at: 0)
array.append(contentsOf: [5, 6])

//array.forEach { number in print("Item: \(number)") }

//print(array.count)
//print(array)

//print(array[5])
//print(dict["Dada"])


/// If - Examples

//let number = 6
//
///// Variant 1
//if number.isMultiple(of: 2) {
//    print("Even")
//} else if number.isMultiple(of: 3) {
//    print("Fizz")
//} else {
//    print("Buzz")
//}
//
///// Varian 2
//if number.isMultiple(of: 2) {
//    print("Even")
//}
//if number.isMultiple(of: 3) {
//    print("Fizz")
//} else {
//    print("Buzz")
//}
//
//if true && false { // AND
//    print("Success")
//}
//
//if true || false { // OR
//    print("Success")
//}

/// For Loops - Example
//let colors = ["Red", "Blue", "Orange", "Cyan"]

//for color in colors {
//    print(color)
//}

//for (index, color) in colors.enumerated() {
//    print("Index: \(index) - Color: \(color)")
//}

//for i in stride(from: 0, to: colors.count, by: 1) {
//    print(colors[i])
//}

//for j in stride(from: colors.count - 1, through: 0, by: -1) {
//    print(colors[j], terminator: ", ")
//}

//for i in 0...colors.count - 1 {
//    print(colors[i])
//}

//for i in stride(from: 0, to: 10, by: 1) {
//    print("i: \(i)")
//}
//
//for j in stride(from: 0, through: 10, by: 1) {
//    print("j: \(j)")
//}

var moviesByRatings = ["Spider-Man": 7, "Odyssey": 9, "Astral": 10]
let smile = "😀"
let emoji = ["⚡️", "🔋", "🚀"]

//for (title, rating) in moviesByRatings {
//    let starIcon: String = "⭐️"
//    var finalRating = ""
//    for _ in 1...rating {
//        finalRating.append(starIcon)
//    }
//
//    print("Movie: \(title) - IMDB: \(finalRating)")
//}
//var number = 11


/// While Loops
//while number < 10 {
//    number += 1 // number = number + 1
//    print("Doing...")
//}
//
//repeat {
//    number += 1
//    print("DO Doing")
//} while number < 10

/// Switch - Example

let temperature: Double = 1

switch temperature {
case 30...:
    print("😎")
case 20..<30:
    print("⛅️")
case 15..<20:
    print("☁️")
case 10..<15:
    print("🌧️")
default:
    print("❄️")
}

enum Season {
    case winter
    case spring
    case autumn
    case summer
}

let season: Season = .autumn

switch season {
case .autumn:
    break
case .spring:
    break
case .summer:
    break
case .winter:
    break
}

let char = "a"
//
//switch char {
//case "a", "e", "o", "u", "i":
//    print("Vowels")
//default:
//    print("Consonant")
//}

// Lab 2


// 1. Array Creation and Access

let fruits: [String] = ["Apple", "Banana", "Orange", "Mango", "Strawberry"]

print("Third fruit: \(fruits[2])")


// 2. Set Creation and Manipulation

var favoriteNumbers: Set<Int> = [7, 13, 21]

favoriteNumbers.insert(42)

print("Updated favorite numbers: \(favoriteNumbers)")


// 3. Dictionary Creation and Access

let programmingLanguages: [String: Int] = [
    "Swift": 2014,
    "Python": 1991,
    "Java": 1995
]

print("Swift release year: \(programmingLanguages["Swift"]!)")


// 4. Array Element Update

var colors: [String] = ["Red", "Blue", "Green", "Yellow"]

colors[1] = "Purple"

print("Updated colors: \(colors)")


// 5. Set Intersection

let firstSet: Set<Int> = [1, 2, 3, 4]
let secondSet: Set<Int> = [3, 4, 5, 6]

let intersection = firstSet.intersection(secondSet)

print("Intersection: \(intersection)")


// 6. Dictionary Update

var studentScores: [String: Int] = [
    "Assiya": 100,
    "Aruzhan": 100,
    "Madina": 100
]

studentScores.updateValue(99, forKey: "Assiya")

print("Updated student scores: \(studentScores)")


// 7. Array Merge

let firstFruits: [String] = ["apple", "banana"]
let secondFruits: [String] = ["cherry", "date"]

let mergedFruits = firstFruits + secondFruits

print("Merged fruits: \(mergedFruits)")



// 8. Dictionary Key Addition

var countryPopulations: [String: Int] = [
    "Kazakhstan": 20_000_000,
    "Japan": 124_000_000,
    "Canada": 40_000_000
]

countryPopulations["France"] = 68_000_000

print("Updated country populations: \(countryPopulations)")


// 9. Set Union and Subtract

let animals1: Set<String> = ["cat", "dog"]
let animals2: Set<String> = ["dog", "mouse"]

let unionAnimals = animals1.union(animals2)
let finalAnimals = unionAnimals.subtracting(animals2)

print("Final set: \(finalAnimals)")


// 10. Nested Collection

let studentGrades: [String: [Int]] = [
    "Assiya": [100, 100, 100],
    "Aruzhan": [100, 100, 100],
    "Madina": [100, 100, 91]
]

print("Assiya's second grade: \(studentGrades["Assiya"]![1])")
