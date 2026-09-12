import Cocoa

// MARK: - Personal Information

let firstName: String = "Assiya"
let lastName: String = "Kengesbay"

let birthYear: Int = 2006
let currentYear: Int = 2026
let age: Int = currentYear - birthYear

let isStudent: Bool = true
let height: Double = 1.58

let country: String = "Kazakhstan"
let favoriteColor: String = "Blue"

// MARK: - Hobbies and Interests

let hobby: String = "Learning programming"
let numberOfHobbies: Int = 3
let favoriteNumber: Int = 7
let isHobbyCreative: Bool = true

let favoriteActivity: String = "Hiking and listening music"

// MARK: - Future Goals

let futureGoals: String = "In the future, I want to become a professional iOS developer."
let favoriteEmoji: String = "💻"

// MARK: - Life Story

let lifeStory = """
My name is \(firstName) \(lastName). I am \(age) years old, born in \(birthYear).
I am currently a student. I am \(height) meters tall and I am from \(country).
My favorite color is \(favoriteColor).
I enjoy \(hobby), which is a creative hobby: \(isHobbyCreative).
I have \(numberOfHobbies) hobbies in total, and my favorite number is \(favoriteNumber).
My favorite activity is \(favoriteActivity).
My future goal is: \(futureGoals) \(favoriteEmoji)
"""

print(lifeStory)