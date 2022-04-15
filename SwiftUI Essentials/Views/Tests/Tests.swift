//
//  Tests.swift
//  SwiftUI Essentials
//
//  Created by Evgeniy Opryshko on 14.04.2022.
//

import SwiftUI

struct Tests: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Task.date, ascending: true)]) private var tasks: FetchedResults<Task>
    
    @State private var showingAlert = false
    @State private var showingHUD = false
    @State private var showingLoadImageOldView = false
    @State private var showingLoadImageView = false
    @State private var showingAddTask = false
    @State private var textFieldText = "Other"
    @State private var searchText = ""
    @State private var toggle = false
    
    var body: some View {
        NavigationView {
            
            ZStack {
                VStack {
                    List {
                        Section(header: Text(textFieldText)) {
                            Button("Show Alert with TextField") {
                                showingAlert.toggle()
                            }
                            Button("Show HUD") {
                                showingHUD.toggle()
                            }
                            Button {
                                showingAddTask.toggle()
                            } label: {
                                HStack {
                                    Label("Add Task", systemImage: "plus.app")
                                    Spacer()
                                    Toggle("Text", isOn: $toggle).labelsHidden()
                                }
                            }
                            Button("Show LoadImageOldView") {
                                showingLoadImageOldView.toggle()
                            }
                            Button("Show LoadImageView") {
                                showingLoadImageView.toggle()
                            }
                        }
                        
                        Section(header: Text("My tasks")) {
                            ForEach(tasks) { text in
                                Text(text.title ?? "?")
                            }
                            .onDelete(perform: deleteTasks)
                        }
                        
                    }
                    .refreshable {
                        print("refreshable")
                    }.searchable(text: $searchText)
                    //.listStyle(.grouped)
                }
                
                if showingAlert {
                    AlertControllerView(textfieldText: $textFieldText,
                                        showingAlert: $showingAlert,
                                        alertTitle: "Test", alertMessage: "Test test")
                }
                
                if showingHUD {
                    HUDProgressView(placeHolder: "Test", show: $showingHUD)
                }
            }
            
            .navigationTitle("TODO List")
            .toolbar {
                HStack {
                    Button {
                        showingAddTask.toggle()
                    } label: {
                        Label("Add Task", systemImage: "plus.app")
                    }
                    
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAddTask) {
                TestAddTask().environment(\.managedObjectContext, viewContext)
            }
            .fullScreenCover(isPresented: $showingLoadImageOldView) {
                TestLoadOldView()
            }
            .fullScreenCover(isPresented: $showingLoadImageView) {
                TestLoadView()
            }
        }
    }
    
    private func deleteTasks(at offsets: IndexSet) {
        withAnimation {
            offsets.map { tasks[$0] }.forEach(viewContext.delete)
            
            try? viewContext.save()
        }
    }
    
    //    private func addTask() {
    //        withAnimation {
    //            let newTask = Task(context: viewContext)
    //            newTask.title = "New Task"
    //            newTask.date = Date()
    //            newTask.detail = "test"
    //
    //            try? viewContext.save()
    //        }
    //    }
}

struct Tests_Previews: PreviewProvider {
    static var previews: some View {
        Tests()
    }
}
