//
//  ContentView.swift
//  RandomRemainder
//
//  Created by Yida Zhang on 2021-05-02.
//

import SwiftUI
import CoreData
import UIKit

struct ContentView: View {
    @EnvironmentObject var viewModel: ContentViewModel
    
    @GestureState private var isDragging: Bool = false
    @ObservedObject var storage: Storage = Storage.shared

    var body: some View {
        VStack {
            ZStack {
    //            Circle()
    //                .fill(Color.blue)
                
                ScrollView {
                    ForEach(storage.alarms) { alarm in
                        AlarmView(alarm: alarm)
                            .padding(.bottom, 20)
                    }
                    .onDelete(perform: viewModel.deleteAlarm)
                }
                .gesture(
                    DragGesture().onChanged({ value in
                        debugPrint(value)
                    }).updating($isDragging, body: { value, state, transaction in
    //                    print(transaction)
                        state = true
                    })
                )
            }
            NavigationView {
                HStack {
                    #if os(iOS)
                    EditButton()
                    #endif
                    Spacer()
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }.padding()
            }
        }.background(Color.white)
    }

    private func addItem() {
        let newAlarm = Alarm(text: "what time is it????")
        Storage.shared.alarms.append(newAlarm)
//        withAnimation {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
