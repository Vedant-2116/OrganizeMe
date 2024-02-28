//
//  TaskListView.swift
//  OrganizeMe
//
//  Created by Vedant on 
//  101398199

import SwiftUI

struct TaskListView: View {
    @State private var tasks: [Task] = [
        Task(title: "Finish project", dueDate: Date(), type: .personal, status: .completed, priority: .high),
        Task(title: "Go to gym", dueDate: Date(), type: .personal, status: .pending, priority: .medium),
        Task(title: "Buy groceries", dueDate: Date(), type: .personal, status: .pending, priority: .low)
    ]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(tasks) { task in
                    NavigationLink(destination: TaskDetailView(task: task, updateTaskList: updateTaskList, deleteTask: {
                        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
                            tasks.remove(at: index)
                        }
                    })) {
                        TaskRow(task: task, tasks: $tasks, deleteTask: deleteTask, markTaskAsCompleted: markTaskAsCompleted)
                    }
                }
                .onDelete(perform: deleteTask)
            }
            .navigationTitle("Task List")
            .navigationBarItems(trailing:
                NavigationLink(destination: NewTaskView(onSave: addNewTask)) {
                    Image(systemName: "plus")
                }
            )
        }
    }
    
    private func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
    
    private func updateTaskList(task: Task) {
        guard let index = tasks.firstIndex(where: { $0.id == task.id }) else {
            return
        }
        tasks[index] = task
    }

    private func addNewTask(_ task: Task) {
        tasks.append(task)
    }
    
    
    
    private func markTaskAsCompleted(_ task: Task) {
        guard let index = tasks.firstIndex(where: { $0.id == task.id }) else { return }
        var updatedTask = task
        updatedTask.status = .completed
        tasks[index] = updatedTask
    }
}

struct TaskRow: View {
    var task: Task
    @Binding var tasks: [Task]
    var deleteTask: (IndexSet) -> Void
    var markTaskAsCompleted: (Task) -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(task.title)
                    .font(.headline)
                Text("Due: \(formattedDate(task.dueDate))")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text("Status: \(task.status.rawValue.capitalized)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text("Priority: \(task.priority.rawValue.capitalized)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text("Type: \(task.type.rawValue.capitalized)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
            Button(action: {
                markTaskAsCompleted(task)
            }) {
                Image(systemName: task.status == .completed ? "checkmark.square.fill" : "square")
                    .foregroundColor(task.status == .completed ? .green : .primary)
            }
        }
        .padding()
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
