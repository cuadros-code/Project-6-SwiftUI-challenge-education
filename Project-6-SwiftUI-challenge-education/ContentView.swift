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
    @State private var numberOfQuestions = 0
    
    @State private var showCorrectIcon = false
    @State private var showErrorIcon = false
    
    @State private var showAlertEndGame = false
    
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
                            validateSelectedOption(num)
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
            .overlay {
                HStack {
                    Spacer()
                    Image("check")
                        .resizable()
                        .frame(width: 300, height: 300)
                        .opacity(showCorrectIcon ? 1 : 0)
                        .offset(x: 0, y: showCorrectIcon ? -100 : 400)
                        .animation(.easeInOut(duration: 0.5), value: showCorrectIcon)
                    
                    Spacer()
                }
                
                HStack {
                    Spacer()
                    Image("cancel")
                        .resizable()
                        .frame(width: 300, height: 300)
                        .opacity(showErrorIcon ? 1 : 0)
                        .offset(x: 0, y: showErrorIcon ? -100 : 400)
                        .animation(.easeInOut(duration: 0.5), value: showErrorIcon)
                    
                    Spacer()
                }
            }
            Spacer()
            .toolbar {
                Button("Start",action: startGame)
            }
        }
        
        .alert("End Game", isPresented: $showAlertEndGame) {
            
        }
        
        .onAppear {
            startGame()
        }
    }
    
    
    func startGame() {
        multiplyByList.shuffle()
        multiplyBy = multiplyByList[numberOfQuestions]
        correctAnswers = selectedTable * multiplyBy
        numberOfQuestions = 0
        generateOptions()
    }
    
    func validateSelectedOption(_ selected: Int) {
       
        if correctAnswers == selected {
            showCorrectIcon = true
        } else {
            showErrorIcon = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            showCorrectIcon = false
            showErrorIcon   = false
            withAnimation {
                askQuestion()
            }
        }
    }
    
    func askQuestion(){
        numberOfQuestions += 1
        multiplyBy = multiplyByList[numberOfQuestions]
        correctAnswers = selectedTable * multiplyBy
        generateOptions()
        
        if selectedNumberOfQuestions == numberOfQuestions {
            showAlertEndGame = true
        }
    }
    
    func generateOptions() {
        options = []
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
