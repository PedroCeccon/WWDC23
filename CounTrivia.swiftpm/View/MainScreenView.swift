//
//  MainScreenView.swift
//  Countrivia
//
//  Created by Pedro Ceccon on 05/04/23.
//
//  The main gameplay screen, here you can play the game and also access any other screen

import SwiftUI
import Foundation

struct MainScreenView: View {
    @EnvironmentObject var model: Model
    @State private var unlockTip = false
    @State private var tipSelected: Tip?
    @State var guessAttempt: String = ""
    @FocusState var textFieldFocus: Bool
    @State private var textFieldUp = false
    @State private var modalTip: Tip?
    @State private var gameStatus: GameStatus = .playing
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var tutorialView: Bool = false
    @State var moreInfoView: Bool = false
    @State var thanksView: Bool = false
    @State var introView: Bool = false
    
    var body: some View {
        NavigationStack{
            ZStack {
                Color.appBackground
                    .ignoresSafeArea()
                VStack(alignment: .center, spacing: 16) {
                    ZStack {
                        HStack{
                            Text("\(model.points) pts")
                                .font(.system(size: 24))
                                .padding(.horizontal, 16)
                                .background{
                                    RoundedRectangle(cornerRadius: 8)
                                        .foregroundColor(Color.appYellow)
                                        .overlay{
                                            RoundedRectangle(cornerRadius: 8).stroke(.black, lineWidth: 1)
                                        }
                                }
                        }
                        HStack{
                            Spacer()
                            Text(model.getTimeFormat())
                                .font(.system(size: 16))
                                .padding(.horizontal, 16)
                                .background{
                                    RoundedRectangle(cornerRadius: 8)
                                        .foregroundColor(Color.appRed)
                                        .overlay{
                                            RoundedRectangle(cornerRadius: 8).stroke(.black, lineWidth: 1)
                                        }
                                }
                        }
                    }
                    HStack{
                        if model.getTipValue(.outline){
                            model.countries[model.currentCountryID].outline
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .onTapGesture {
                                    modalTip = .outline
                                }
                        }
                        if model.getTipValue(.flag){
                            model.countries[model.currentCountryID].flag
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .onTapGesture {
                                    modalTip = .flag
                                }
                        }
                        
                    }
                    ForEach(Tip.allCases, id: \.self){ tip in
                        if model.getTipValue(tip){
                            TipView(tip: tip, modalTip: $modalTip)
                        }
                    }
                    
                    if !unlockTip && model.remainingTips.count>0 && gameStatus == .playing{
                        Button {
                            unlockTip.toggle()
                        } label: {
                            Text(model.points == 0 ? "Out of Points": "Unlock tip")
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
                                .overlay {
                                    RoundedRectangle(cornerRadius: 8)
                                        .foregroundColor(Color(red: 217/255, green: 217/255, blue: 217/255))
                                        .opacity(model.points == 0 ? 0.5 : 0)
                                }
                        }
                        .disabled(model.points == 0)
                    }
                        
                    HStack{
                        Text("Country:")
                            .font(.system(size: 24))
                        Spacer()
                    }
                    HStack(spacing: 16){
                        Button {
                            textFieldUp = true
                            textFieldFocus.toggle()
                        } label: {
                            HStack {
                                Text(guessAttempt.isEmpty ? "Take a guess..." : guessAttempt)
                                    .foregroundColor(guessAttempt.isEmpty ? Color(red: 138/255, green: 138/255, blue: 142/255): .black)
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
                        }
                        Button {
                            gameStatus = model.confirmAnswer(guessAttempt)
                            guessAttempt = ""
                        } label: {
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
                    }
                    if !model.attemptMessage.isEmpty{
                        Text(model.attemptMessage)
                            .multilineTextAlignment(.center)
                    }
                    Spacer()
                }
                .padding(.top, 16)
                .padding(.horizontal, 16)
                .ignoresSafeArea(.keyboard)
                if unlockTip{
                    ModalListView(tipSelected: $tipSelected, unlockTip: $unlockTip)
                }
                if textFieldUp{
                    ZStack{
                        Color(red: 79/255, green: 83/255, blue: 90/255)
                            .opacity(0.7)
                            .onTapGesture {
                                textFieldUp = false
                            }
                        VStack {
                            TextField("Take a guess...", text: $guessAttempt)
                            .disableAutocorrection(true)
                            .focused($textFieldFocus)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                            .font(Font.system(size: 24))
                            .onSubmit {
                                textFieldUp = false
                            }
                            .background{
                                RoundedRectangle(cornerRadius: 8)
                                    .foregroundColor(.white)
                                    .overlay{
                                        RoundedRectangle(cornerRadius: 8).stroke(.black, lineWidth: 1)
                                    }
                                    .shadow(radius: 2, x: -2, y: 2)
                            }
                            .offset(y: 200)
                            Spacer()
                        }
                        .padding(.horizontal, 16)
                    }
                    .ignoresSafeArea(.all, edges: .bottom)
                }
                if modalTip != nil{
                    ModalTipView(modalTip: $modalTip)
                }
                if gameStatus != .playing{
                    FinishGameModal(status: $gameStatus, moreInfoView: $moreInfoView)
                }
            }
            .onReceive(timer) { i in
                if !tutorialView && !thanksView && !introView{
                    if model.time > 0  && gameStatus == .playing{
                        model.countTime()
                    }
                    else if gameStatus == .playing{
                        closeAllModal()
                        gameStatus = .timesUp
                    }
                }
            }
            .navigationTitle("Game")
            .navigationDestination(isPresented: $tutorialView, destination: {
                TutorialView()
            })
            .navigationDestination(isPresented: $moreInfoView, destination: {
                CountryInfoView()
            })
            .navigationDestination(isPresented: $thanksView, destination: {
                ThanksAttributionsView()
            })
            .navigationDestination(isPresented: $introView, destination: {
                ContentView(firstOpen: false)
            })
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button {
                            tutorialView = true
                        } label: {
                            Text("Tutorial")
                        }
                        if gameStatus == .playing{
                            Button {
                                closeAllModal()
                                gameStatus = .revealAnswer
                            } label: {
                                Text("Reveal Answer")
                            }
                        }
                        Button {
                            gameStatus = .playing
                            closeAllModal()
                            model.newGame()
                        } label: {
                            Text("Try a Different Country")
                        }
                        Button {
                            thanksView = true
                        } label: {
                            Text("Thanks and Atributions")
                        }
                        Button {
                            introView = true
                        } label: {
                            Text("View Intro")
                        }
                    } label: {
                        HStack {
                            Label("More Options", systemImage: "ellipsis.circle")
                                .labelStyle(.iconOnly)
                            .padding(.horizontal, 16)
                        }
                    }

                }
            }
        }
    }
    
    func closeAllModal(){
        guessAttempt = ""
        modalTip = nil
        textFieldUp = false
        tipSelected = nil
        unlockTip = false
    }
}

struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
            .preferredColorScheme(.light)
            .environmentObject(Model())
    }
}
