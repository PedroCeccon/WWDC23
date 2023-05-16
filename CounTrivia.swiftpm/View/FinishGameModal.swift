//
//  SwiftUIView.swift
//  CounTrivia
//
//  Created by Pedro Ceccon on 13/04/23.
//
//  A View that shows the end game status to the player and let him decide wheter he wants to see more information about the country or play again

import SwiftUI

struct FinishGameModal: View {
    @Binding var status: GameStatus
    @Binding var moreInfoView: Bool
    @EnvironmentObject var model: Model
    var body: some View {
        ZStack{
            Color(red: 79/255, green: 83/255, blue: 90/255)
                .opacity(0.7)
            VStack(spacing: 50){
                Text(getText())
                    .padding(.all, 20)
                    .multilineTextAlignment(.center)
                    .background{
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundColor(.white)
                    }
                HStack{
                    ZStack{
                        Button {
                            model.newGame()
                            status = .playing
                        } label: {
                            HStack{
                                Text("Play Next")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.black)
                                    .padding(.horizontal, 24)
                                    .padding(.vertical, 10)
                            }
                            
                            .background{
                                RoundedRectangle(cornerRadius: 8)
                                    .foregroundColor(Color.appGreen)
                                    .overlay{
                                        RoundedRectangle(cornerRadius: 8).stroke(.black, lineWidth: 1)
                                    }
                                    .shadow(radius: 2, x: -2, y: 2)
                            }
                        }
                    }
                    Spacer()
                    Button {
                        if status == .timesUp{
                            status = .revealAnswer
                        }
                        else{
                            moreInfoView = true
                        }
                    } label: {
                        Text(status == .timesUp ? "Reveal Answer" : "More Info")
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                            .padding(.horizontal, 24)
                            .padding(.vertical, 10)
                            .background{
                                RoundedRectangle(cornerRadius: 8)
                                    .foregroundColor(status == .timesUp ? Color.appYellow : Color.appBlue)
                                    .overlay{
                                        RoundedRectangle(cornerRadius: 8).stroke(.black, lineWidth: 1)
                                    }
                                    .shadow(radius: 2, x: -2, y: 2)
                            }
                    }
                }
                .padding(.horizontal, 16)
            }
            .padding(.horizontal, 16)
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
    
    func getText() -> String{
        if status == .win{
            return "Congratulations!\nYou got the right answer, if you want to learn more cool stuff about \(model.countries[model.currentCountryID].name) tap the 'More Info' button, or you can just play again and try to guess a different country!"
        }
        if status == .timesUp{
            return "Times up!\nYou didn't get it this time but you can always try again."
        }
        if status == .revealAnswer{
            return "The correct answer is \(model.countries[model.currentCountryID].name)!\nIf you want to learn more about this country tap the 'More Info' button, or you can just play again and try to guess a different country!"
        }
        return ""
    }
}
