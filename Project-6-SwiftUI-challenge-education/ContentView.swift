//
//  ContentView.swift
//  Project-6-SwiftUI-challenge-education
//
//  Created by Kevin Cuadros on 26/10/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedTable = 2
    @State private var selectedNumberOfQuestions = 5
    
    var body: some View {
        Form {
            Section("Numbers of questions") {
                Picker("Numbers of questions", selection: $selectedNumberOfQuestions) {
                    ForEach(2..<21, id: \.self){
                        if $0 % 5 == 0 {
                            Text("\($0)")
                        }
                    }
                }
                .pickerStyle(.segmented)
            }
            
            Section {
                Picker("Select multiplication table", selection: $selectedTable) {
                    ForEach(2..<13, id: \.self){
                        Text("\($0)")
                    }
                }
                .pickerStyle(.inline)
            }
            
            Section {
                HStack {
                    Spacer()
                    Button("Start"){
                        
                    }
                    .background(.indigo)
                    .foregroundStyle(.white)
                    .padding()
                    Spacer()
                }
            }
        }
        
    }
}

#Preview {
    ContentView()
}
