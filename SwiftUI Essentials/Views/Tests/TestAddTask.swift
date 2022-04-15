//
//  TestAddTask.swift
//  SwiftUI Essentials
//
//  Created by Evgeniy Opryshko on 15.04.2022.
//

import SwiftUI

struct TestAddTask: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var title: String = ""
    @State private var detail: String = ""
    
    var body: some View {
        VStack {
            HStack {
                Button("Cancel") {
                    dismiss()
                }
                Spacer()
                Button("Done") {
                    addTask()
                }
            }
            
            Spacer()
            
            Text("Add new Task")
                .font(.callout)
                .bold()
            VStack(alignment: .leading) {
                Text("Title")
                    .font(.callout)
                    .bold()
                TextField("Enter title...", text: $title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            VStack(alignment: .leading) {
                Text("Detail")
                    .font(.callout)
                    .bold()
                TextField("Enter detail...", text: $detail)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            Spacer()
            
        }.padding(20)
    }
    
    private func addTask() {
        withAnimation {
            let newTask = Task(context: viewContext)
            newTask.title = title
            newTask.detail = detail
            newTask.date = Date()
            
            try? viewContext.save()
            
            dismiss()
        }
    }
    
}

struct TestAddTask_Previews: PreviewProvider {
    static var previews: some View {
        TestAddTask()
    }
}
