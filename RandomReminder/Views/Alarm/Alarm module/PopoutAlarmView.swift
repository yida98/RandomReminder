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
    @Binding var adding: Bool
    @Binding var alarm: Alarm?
    
    @State var scale: CGFloat = 0.95
    @State var opacity: Double = 0
    @State var showAlert: Bool = false
    
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
                                    ZStack {
                                        Text(viewModel.validDates ? "" : "Non-ascending times!")
                                            .font(.caption2)
                                            .foregroundColor(.red)
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
                                    }
                                    Spacer()
                                }
                                List {
                                    ForEach(viewModel.durationIndices, id: \.self) { index in
                                        DurationView<T>(index: index)
                                            .environmentObject(viewModel)
                                    }
                                    .onDelete(perform: { indexSet in
                                        viewModel.delete(from: indexSet)
                                    })
                                    
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
                            showAlert = true
                        } label: {
                            Text("Cancel")
                        }
                        .buttonStyle(BasicButtonStyle())
                        Button {
                            viewModel.done { alarm in
                                cancel()
                            }
                        } label: {
                            Text("Done")
                                .foregroundColor(viewModel.finished ? Color.darkGrey : Color.lightGrey)
                        }.disabled(!viewModel.finished)
                        .buttonStyle(BasicButtonStyle())

                    }.padding(.top, 20)
                }.padding(40)
            }.background(Color.white)
            .cornerRadius(20)
            .padding()
            .onAppear {
                scale = 1
                opacity = 0.5
            }
            .scaleEffect(scale)
            
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Cancel editing?"),
                primaryButton: .cancel(),
                secondaryButton: .destructive(Text("Confirm"), action: {
                    cancel()
        }))}
        .frame(width: Constants.screenSize.width, height: Constants.screenSize.height)
        .background(
            Color.black
                .opacity(opacity)
                .onTapGesture {
                    showAlert = true
                }
        )
        .animation(.easeOut(duration: 0.2))
        .ignoresSafeArea()
    }
    
    private func cancel() {
        isPresenting = false
        adding = true
        alarm = nil
    }
}

extension Date: Identifiable {
    public var id: Date { self }
}
