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
    @State private var multiplyBy = 0
    @State private var showQuestions = false
    @State private var multiplyByList = Array(2...25)
    @State private var correctAnswers = 0
    @State private var options: [Int] = [Int]()

    
    var body: some View {
        NavigationStack {
            
            HStack {
                Text("Number of questions")
                    .padding()
                Spacer()
                Picker("Number of questions", selection: $selectedNumberOfQuestions) {
                    ForEach(2..<21, id: \.self) {
                        if $0 % 5 == 0 {
                            Text("\($0)")
                                .foregroundStyle(.red)
                        }
                    }
                }
                .pickerStyle(.menu)
                .accentColor(.black)
                
            }
            .frame(height: 50)
            .background(
                Color(white: 0.9, opacity: 0.7).clipShape(RoundedRectangle(cornerRadius:10))
            )
            .padding(EdgeInsets(top: 20, leading: 10, bottom: 0, trailing: 10))
            
            
            
            HStack {
                Text("Select multiplication table")
                    .padding()
                Spacer()
                Picker("Select multiplication table", selection: $selectedTable) {
                    ForEach(2..<13, id: \.self){
                        Text("\($0)")
                    }
                }
                .pickerStyle(.menu)
                .accentColor(.black)
            }
            .frame(height: 50)
            .background(
                Color(white: 0.9, opacity: 0.7).clipShape(RoundedRectangle(cornerRadius:10))
            )
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))

            Spacer()
           
            VStack {
                
                HStack {
                    Text("\(selectedTable) X \(multiplyBy)")
                        .font(.system(size: 95))
                        .fontWeight(.heavy)
                }
                
                HStack {
                    ForEach(options, id: \.self){ num in
                        Button {
                            print(num)
                        } label: {
                            Text("\(num)")
                        }
                        .frame(width: 80, height: 80)
                        .buttonBorderShape(.capsule)
                        .font(.system(size: 34))
                        .background(
                            RoundedRectangle(
                                cornerRadius: 20,
                                style: .continuous
                            ).fill(Color(white: 0.8, opacity: 0.7))
                        )
                    }
                }
                
            }
            Spacer()
            
            .toolbar {
                Button("Start",action: startGame)
            }
        }
        
        .onAppear {
            startGame()
        }
    }
    
    
    func startGame() {
        multiplyByList.shuffle()
        multiplyBy = multiplyByList[0]
        correctAnswers = selectedTable * multiplyBy
        
        options.append(correctAnswers)
        options.append(correctAnswers - 1)
        options.append(correctAnswers + 2)
        options.append(correctAnswers - 2)
        
        options.shuffle()
    }
    
    
    
    
}

#Preview {
    ContentView()
}
