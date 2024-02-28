//
//  TaskDetailView.swift
//  OrganizeMe
//
//  Created by Vedant on 
//  101398199

import SwiftUI

struct TaskDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var editedTask: Task
    @State private var showAlert = false
    var updateTaskList: (Task) -> Void
    var deleteTask: () -> Void
    
    init(task: Task, updateTaskList: @escaping (Task) -> Void, deleteTask: @escaping () -> Void) {
        self._editedTask = State(initialValue: task)
        self.updateTaskList = updateTaskList
        self.deleteTask = deleteTask
    }
    
    var body: some View {
        VStack {
            Text("Task Details")
                .font(.title)
                .padding()
            
            TextField("Title", text: $editedTask.title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            DatePicker("Due Date", selection: $editedTask.dueDate, displayedComponents: [.date, .hourAndMinute])
                .datePickerStyle(WheelDatePickerStyle())
                .padding()
            
            Picker(selection: $editedTask.status, label: Text("Status")) {
                Text("Pending").tag(TaskStatus.pending)
                Text("Completed").tag(TaskStatus.completed)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            Picker(selection: $editedTask.priority, label: Text("Priority")) {
                ForEach(TaskPriority.allCases, id: \.self) { priority in
                    Text(priority.rawValue.capitalized).tag(priority)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            Spacer()
            
            HStack {
                Button(action: {
                    updateTaskList(editedTask)
                    showAlert = true // Show the alert when task is updated
                }) {
                    Text("Save")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding(.horizontal)
                
                Button(action: {
                    deleteTask()
                }) {
                    Text("Delete")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .cornerRadius(8)
                }
                .padding(.horizontal)
            }
        }
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Success"), message: Text("Task saved successfully"), dismissButton: .default(Text("OK")) {
                // Dismiss the current view and navigate back to the task list
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}
