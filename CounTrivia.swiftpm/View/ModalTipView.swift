//
//  ModalTipView.swift
//  CounTrivia
//
//  Created by Pedro Ceccon on 14/04/23.
//
//  The View that can show the tips modally, providing a better or more complete visualization to the player

import SwiftUI

struct ModalTipView: View {
    @Binding var modalTip: Tip?
    @EnvironmentObject var model: Model
    var body: some View {
        ZStack{
            Color(red: 79/255, green: 83/255, blue: 90/255)
                .opacity(0.7)
                .onTapGesture {
                    modalTip = nil
                }
            VStack{
                if modalTip == .outline{
                    model.countries[model.currentCountryID].outline
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .padding(.all, 10)
                        .background{
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundColor(.white)
                        }
                        .padding(.bottom, 100)

                }
                else if modalTip == .flag{
                    model.countries[model.currentCountryID].flag
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .padding(.bottom, 100)
                }
                else if modalTip == .landBorders{
                    VStack(alignment: .center, spacing: 10){
                        Text("Land Borders:")
                            .fontWeight(.semibold)
                            .padding(.bottom, 5)
                        ForEach(model.countries[model.currentCountryID].landBorders, id: \.self){ i in
                            Text(i)
                                .padding(.horizontal, 16)
                                .background{
                                    RoundedRectangle(cornerRadius: 8)
                                        .foregroundColor(Color(red: 229/255, green: 190/255, blue: 94/255))
                                        .overlay{
                                            RoundedRectangle(cornerRadius: 8).stroke(.black, lineWidth: 1)
                                        }
                                }
                        }
                    }
                    .padding(.horizontal, 15)
                    .padding(.vertical, 10)
                    .background{
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundColor(.white)
                    }
                    .padding(.bottom, 100)
                }
            }
            .padding(.horizontal, 16)
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
}
