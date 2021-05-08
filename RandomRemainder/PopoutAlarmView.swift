//
//  PopoutAlarmView.swift
//  RandomRemainder
//
//  Created by Yida Zhang on 2021-05-03.
//

import SwiftUI

struct PopoutAlarmView<T: PopoutViewModel>: View {
    
    @EnvironmentObject var viewModel: T
    @Binding var isPresenting: Bool
    
    var body: some View {
        VStack {
            Group {
                VStack(spacing: 20) {
                    TextField("Alarm Name", text: $viewModel.title)
                    Stepper("\(viewModel.occurence) occurences a day", value: $viewModel.occurence, in: 1...100)
                    Toggle("Randomize alerts", isOn: $viewModel.random)
                    Group {
                        Toggle( "Active all-day", isOn: $viewModel.activeAllDay)
                        
                        if !viewModel.activeAllDay {
                            ZStack {
                                VStack {
                                    HStack {
                                        Spacer()
                                        Button {
                                            viewModel.addDuration()
                                        } label: {
                                            Image(systemName: "plus")
                                                .foregroundColor(Color.gray)
                                        }
                                        .padding(.top, 6)
                                        .padding(.trailing, 6)
                                    }
                                    Spacer()
                                }
                                List {
                                    ForEach(0..<viewModel.duration.count/2, id: \.self) { index in
                                        DurationView<T>(index: index * 2)
                                            .environmentObject(viewModel)
                                    }
                                    .listRowBackground(Color.clear)
                                }.padding()
                                .padding(.top, 5)
                            }
                            .frame(maxHeight: Constants.screenSize.height / 4)
                            .background(Color.lightGrey3)
                            .cornerRadius(6)
                            .padding(6)
                        }
                    }
                    HStack(spacing: 20) {
                        Spacer()
                        Button {
                            isPresenting = false
                        } label: {
                            Text("Cancel")
                        }
                        .buttonStyle(MyButtonStyle())
                        Button {
                            viewModel.done {
                                isPresenting = false
                            }
                        } label: {
                            Text("Done")
                                .foregroundColor(viewModel.finished ? Color.darkGrey : Color.lightGrey)
                        }.disabled(!viewModel.finished)
                        .buttonStyle(MyButtonStyle())

                    }.padding(.top, 20)
                }.padding(40)
            }.background(Color.white)
            .cornerRadius(20)
            .padding()
            
        }
        .frame(width: Constants.screenSize.width, height: Constants.screenSize.height)
        .background(Color.black.opacity(0.4))
        .ignoresSafeArea()
    }
}

struct MyButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        MyButton(configuration: configuration)
    }
    
    struct MyButton: View {
        let configuration: MyButtonStyle.Configuration
        
        var body: some View {
            configuration.label
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .foregroundColor(Color.darkGrey)
                .background(configuration.isPressed ? Color.lightGrey : Color.lightGrey3)
                .cornerRadius(5)
        }
    }
    
}

extension Date: Identifiable {
    public var id: Date { self }
}
