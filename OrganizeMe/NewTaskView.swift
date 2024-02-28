//
//  NewTaskView.swift
//  OrganizeMe
//
//  Created by Vedant on 
//  101398199

import SwiftUI

struct NewTaskView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var title: String = ""
    @State private var dueDate = Date()
    @State private var selectedType: TaskType = .work // Provide default value
    @State private var selectedPriority: TaskPriority = .low // Provide default value
    @State private var selectedStatus: TaskStatus = .pending // Provide default value
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var showSuccessAlert = false // New state variable for success alert

    var onSave: (Task) -> Void

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Task Details")) {
                    TextField("Title", text: $title)
                    DatePicker("Due Date", selection: $dueDate, in: Date()...)
                }

                Section(header: Text("Task Type")) {
                    Picker(selection: $selectedType, label: Text("Type")) {
                        ForEach(TaskType.allCases, id: \.self) { type in
                            Text(type.rawValue.capitalized)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("Status")) {
                    Picker(selection: $selectedStatus, label: Text("Status")) {
                        ForEach(TaskStatus.allCases, id: \.self) { status in
                            Text(status.rawValue.capitalized)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("Priority")) {
                    Picker(selection: $selectedPriority, label: Text("Priority")) {
                        ForEach(TaskPriority.allCases, id: \.self) { priority in
                            Text(priority.rawValue.capitalized)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            .navigationTitle("New Task")
            .navigationBarItems(trailing:
                Button("Save") {
                    saveTask()
                }
            )
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            // Success alert for task added successfully
            .alert(isPresented: $showSuccessAlert) {
                Alert(title: Text("Success"), message: Text("Task added successfully"), dismissButton: .default(Text("OK")) {
                    // Dismiss the current view and navigate back to the task list
                    presentationMode.wrappedValue.dismiss()
                })
            }
        }
    }

    private func saveTask() {
        var emptyField: String? = nil

        if title.isEmpty {
            emptyField = "Title"
        } else if selectedType == .work { // Check against default value
            emptyField = "Type"
        } else if selectedPriority == .low { // Check against default value
            emptyField = "Priority"
        }

        if let emptyField = emptyField {
            alertMessage = "\(emptyField) cannot be empty"
            showAlert = true
            return
        }

        // Show success alert and create the task
        showSuccessAlert = true
        onSave(createTask())
    }

    private func createTask() -> Task {
        return Task(title: title, dueDate: dueDate, type: selectedType, status: selectedStatus, priority: selectedPriority)
    }
}


