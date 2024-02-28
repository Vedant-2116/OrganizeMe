//
//  Task.swift
//  OrganizeMe
//
//  Created by Vedant 
//  101398199
import Foundation

struct Task: Identifiable {
    let id = UUID() // Ensure each task has a unique identifier
    var title: String
    var dueDate: Date
    var type: TaskType
    var status: TaskStatus
    var priority: TaskPriority
}


enum TaskType: String, CaseIterable {
    case personal
    case work
    case study
    // Add more task types as needed
}

enum TaskStatus: String, CaseIterable {
    case pending
    case completed
}

enum TaskPriority: String, CaseIterable {
    case low
    case medium
    case high
}
