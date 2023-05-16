//
//  TutorialView.swift
//  CounTrivia
//
//  Created by Pedro Ceccon on 16/04/23.
//
//  A screen that shows the game's tutorial

import SwiftUI

struct TutorialView: View {
    @EnvironmentObject var model: Model
    
    var body: some View {
        ScrollView{
            ZStack {
                Color.appBackground
                    .ignoresSafeArea()
                VStack{
                    Text("Don't worry the timer is on hold while you read the tutorial.\n\n")
                    TutorialFirstSection()
                    TutorialSecondSection()
                    TutorialThirdSection()
                }
                .padding(.horizontal, 16)
            }
        }
        .navigationTitle("Tutorial")
        .toolbarBackground(Color.appBackground, for: .navigationBar)
    }
}
    
struct TutorialFirstSection: View {
    var body: some View {
        VStack{
            Text("Guessing the Answer:\n")
                .font(.title2)
            Text("When you start a new game, the outline of a country will appear. Your objective is to guess which country it represents before your time runs out.\n")
            Text("To make a guess, simply tap on the box labeled 'Take a guess...' if you think you have the correct answer: \n")
            HStack {
                Text("Take a guess...")
                    .foregroundColor(Color(red: 138/255, green: 138/255, blue: 142/255))
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 10)
                Spacer()
            }
            .background{
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(.white)
                    .overlay{
                        RoundedRectangle(cornerRadius: 8).stroke(.black, lineWidth: 1)
                    }
            }
            Text("\nThen you can write down your answer. To exit the textbox, simply tap the return key on your keyboard or tap somewhere on the screen out of the textbox. Then, press the 'Guess' button the confirm your answer:\n")
            Text("Guess")
                .fontWeight(.semibold)
                .foregroundColor(.black)
                .padding(.horizontal, 24)
                .padding(.vertical, 10)
                .background{
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(Color.appBlue)
                        .overlay{
                            RoundedRectangle(cornerRadius: 8).stroke(.black, lineWidth: 1)
                        }
                        .shadow(radius: 2, x: -2, y: 2)
                }
            Text("\nIf you submit a wrong or empty answer you'll receive a message underneath:\n")
            HStack(spacing: 16){
                HStack {
                    Text("Canada")
                        .foregroundColor(.black)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 10)
                    Spacer()
                }
                .background{
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(.white)
                        .overlay{
                            RoundedRectangle(cornerRadius: 8).stroke(.black, lineWidth: 1)
                        }
                }
                Text("Guess")
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 10)
                    .background{
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundColor(Color.appBlue)
                            .overlay{
                                RoundedRectangle(cornerRadius: 8).stroke(.black, lineWidth: 1)
                            }
                            .shadow(radius: 2, x: -2, y: 2)
                    }
            }
            Text("Wrong answer. Please try again.")
                .multilineTextAlignment(.center)
            Text("\nIf you submit the correct answer, a pop up will appear and you can either choose to play again or see more info about the country you just guessed.\n\n")
        }
    }
}

struct TutorialSecondSection: View {
    @EnvironmentObject var model: Model
    var body: some View {
        VStack{
            Text("Unlocking Tips:\n")
                .font(.title2)
            Text("If you're unsure about your answer, you can tap on the 'Unlock Tip' button to receive tips about the correct country.\n\n")
            Text("Unlock tip")
                .fontWeight(.semibold)
                .foregroundColor(.black)
                .padding(.horizontal, 24)
                .padding(.vertical, 10)
                .background{
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(Color.appGreen)
                        .overlay{
                            RoundedRectangle(cornerRadius: 8).stroke(.black, lineWidth: 1)
                        }
                        .shadow(radius: 2, x: -2, y: 2)
                }
            Text("\nAfter tapping on the 'Unlock Tip' button, a list of options will appear for you to choose from. Select the tip you want and tap the 'Unlock' button.\nHowever, keep in mind that unlocking a tip will cost you some points and there's not enough points to unlock every tip.\nIf you change your mind, you can tap the 'Cancel' button or tap outside the list of options to go back to the main screen of the game.\n\nIf an image gets too small you can tap it to expand it. To close it, simply tap anywhere on the screen except the image.\n\nIf a tip it's too big it might show a '+X':\n\n")
            VStack(alignment: .center, spacing: 5){
                ForEach(0...1, id: \.self){ i in
                    Text(model.countries[0].landBorders[i])
                        .padding(.horizontal, 16)
                        .background{
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundColor(Color.appYellow)
                                .overlay{
                                    RoundedRectangle(cornerRadius: 8).stroke(.black, lineWidth: 1)
                                }
                        }
                }
                Text("+\(model.countries[0].landBorders.count-2)")
                    .fontWeight(.semibold)
                    .padding(.horizontal, 16)
                    .background{
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundColor(Color.appYellow)
                            .overlay{
                                RoundedRectangle(cornerRadius: 8).stroke(.black, lineWidth: 1)
                            }
                            .shadow(radius: 2, x: -2, y: 2)
                    }
            }
            HStack {
                Text("\nSimply tap on it to expand and see the whole tip:\n")
                Spacer()
            }
            VStack(alignment: .center, spacing: 5){
                ForEach(model.countries[0].landBorders, id: \.self){ i in
                    Text(i)
                        .padding(.horizontal, 16)
                        .background{
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundColor(Color.appYellow)
                                .overlay{
                                    RoundedRectangle(cornerRadius: 8).stroke(.black, lineWidth: 1)
                                }
                        }
                }
            }
        }
    }
}

struct TutorialThirdSection: View {
    var body: some View {
        VStack{
            Text("\nMore Options:\n")
                .font(.title2)
            Text("To access more options, tap on the  ")
            +
            Text(Image(systemName: "ellipsis.circle"))
                .foregroundColor(.accentColor)
            +
            Text("  located in the top right corner of the screen. This will present you with five options:\n\nTutorial: it will take you to this page, where you can learn how to play the game. You can access it at any time and the timer will be put on hold while you're here.\n\nReveal Answer: if you want to see the answer right away.\n\nTry a Different Country: if you're having trouble with the current country, you can try a different one.\n\nThanking and Attributions: it will take to a screen where you can view the attribution of free-licensed creative works used in this app.\n\nView Intro: takes you back to the initial screen without losing the game status, and puts the timer on hold.\n")
        }
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView()
            .environmentObject(Model())
    }
}
