//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Grace couch on 18/07/2024.
//

import SwiftUI

struct ContentView: View {
    let winningAnswer = ["🪨", "🗒️", "✂️"]
    let losingAnswer = ["✂️", "🪨", "🗒️"]
    @State private var winOrLose = Bool.random()
    @State private var appChoice = Int.random(in: 0...2)
    @State private var userScore = 0
    @State private var questionNumber = 1
    @State private var outcome = ""
    @State private var showingResult = false
    @State private var gameOver = false

    var body: some View {
        VStack {
            if winOrLose == true {
                Text("Win this round!")
                    .font(.title.bold())
                Text("Your apponent: \(losingAnswer[appChoice])")
                    .font(.title2)
                    .padding(6)
            } else {
                Text("Lose this round!")
                    .font(.title.bold())
                Text("Your apponent: \(winningAnswer[appChoice])")
                    .font(.title2)
                    .padding(6)
            }

            VStack(spacing: 30) {
                ForEach(winningAnswer.shuffled(), id: \.self) { choice in
                    Button {
                        answerTapped(choice: choice)
                    } label: {
                        Text(choice)
                    }
                    .font(.system(size: 100))
                }
            }
        }
        .alert(outcome, isPresented: $showingResult) {
            Button("Continue", action: nextQuestion)
        } message: {
            Text("Your score is \(userScore)")
        }
        .alert("Game over!", isPresented: $gameOver) {
            Button("Reset Game", action: gameReset)
        } message: {
            Text("You finished with score of \(userScore)/10")
        }

        Text("Score \(userScore)")
    }


    func nextQuestion() {
        appChoice = Int.random(in: 0...2)
        winOrLose = Bool.random()
    }

    func gameReset() {
        userScore = 0
        questionNumber = 1
    }

    func generalTap(choice: String) {
        if winOrLose == true {
            if choice == winningAnswer[appChoice] {
                outcome = "Correct!"
                userScore += 1
            } else {
                outcome = "Wrong!"
            }
        } else {
            if choice == losingAnswer[appChoice] {
                outcome = "Correct!"
                userScore += 1
            } else {
                outcome = "Wrong!"
            }
        }
        showingResult = true
        questionNumber += 1
    }

    func answerTapped(choice: String) {
        if questionNumber == 10 {
            gameOver = true
        } else {
            generalTap(choice: choice)
        }
    }
}

#Preview {
    ContentView()
}
