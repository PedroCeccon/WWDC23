//
//  ModalListView.swift
//  CounTrivia
//
//  Created by Pedro Ceccon on 12/04/23.
//
//  The View that contains the list of tips the player can unlock and presents modally

import SwiftUI

struct ModalListView: View {
    @Binding var tipSelected: Tip?
    @Binding var unlockTip: Bool
    @EnvironmentObject var model: Model
    let selectionColor: Color = Color(red: 209/255, green: 209/255, blue: 214/255)
    
    var body: some View {
        ZStack{
            Color(red: 79/255, green: 83/255, blue: 90/255)
            .opacity(0.7)
            .onTapGesture {
                tipSelected = nil
                unlockTip.toggle()
            }
            
            VStack(spacing: 50){
                
                VStack(spacing: 0){
                    ForEach(model.remainingTips, id: \.self){ tip in
                        Button {
                            tapAction(tip)
                        } label: {
                            HStack{
                                Text(tip.getName())
                                    .fontWeight(.semibold)
                                    .foregroundColor(.black)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 10)
                                Spacer()
                                if isSelected(tip){
                                    Image(systemName: "checkmark")
                                        .padding(.horizontal, 16)
                                }
                            }
                            
                            .background{
                                RoundedRectangle(cornerRadius: 8)
                                    .foregroundColor(isSelected(tip) ? selectionColor : .white)
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                }
                .background{
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                }
                HStack{
                    ZStack{
                        Button {
                            unlockSelectedTip()
                        } label: {
                            HStack{
                                Spacer()
                                Text(isSelected() ? "Unlock (-25 pts)" : "Unlock")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.black)
                                    .padding(.horizontal, 24)
                                    .padding(.vertical, 10)
                                Spacer()
                            }
                            .frame(maxWidth: 300)
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
                                    .opacity(isSelected() ? 0 : 0.5)
                            }
                        }
                        .disabled(!isSelected())
                    }
                    Spacer()
                    Button {
                        tipSelected = nil
                        unlockTip.toggle()
                    } label: {
                        Text("Cancel")
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                            .padding(.horizontal, 24)
                            .padding(.vertical, 10)
                            .background{
                                RoundedRectangle(cornerRadius: 8)
                                    .foregroundColor(Color.appRed)
                                    .overlay{
                                        RoundedRectangle(cornerRadius: 8).stroke(.black, lineWidth: 1)
                                    }
                                    .shadow(radius: 2, x: -2, y: 2)
                            }
                    }
                }
                .padding(.horizontal, 32)
            }
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
    
    func unlockSelectedTip(){
        if let tip = tipSelected{
            model.unlockTip(tip)
            tipSelected = nil
            unlockTip.toggle()
            model.points -= 25
        }
    }
    
    func tapAction(_ tip: Tip){
        if isSelected(tip){
            tipSelected = nil
        }
        else{
            tipSelected = tip
        }
    }
    
    func isSelected(_ tip: Tip?) -> Bool{
        if let selected = tip{
            if selected == tipSelected{
                return true
            }
        }
        return false
    }
    
    func isSelected() -> Bool{
        for tip in Tip.allCases{
            if let selected = tipSelected{
                if selected == tip{
                    return true
                }
            }
        }
        return false
    }
}

struct ModalListView_Previews: PreviewProvider {
    static var previews: some View {
        @State var tipSelected: Tip?
        @State var unlockTip = true
        ModalListView(tipSelected: $tipSelected, unlockTip: $unlockTip)
            .environmentObject(Model())
    }
}
