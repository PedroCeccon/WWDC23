//
//  CountryInfoView.swift
//  CounTrivia
//
//  Created by Pedro Ceccon on 17/04/23.
//
//  A screen that shows all information about the country

import SwiftUI

struct CountryInfoView: View {
    @EnvironmentObject var model: Model
    @State private var modalTip: Tip?
    var body: some View {
        ZStack{
            Color.appBackground
                .ignoresSafeArea()
            VStack{
                Text(model.countries[model.currentCountryID].name)
                    .foregroundColor(.black)
                    .font(.title)
                HStack{
                    model.countries[model.currentCountryID].outline
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .onTapGesture {
                            modalTip = .outline
                        }
                    model.countries[model.currentCountryID].flag
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .onTapGesture {
                            modalTip = .flag
                        }
                }
                .padding(.bottom, 10)
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20){
                    VStack{
                        Text("Capital:")
                        Text(model.countries[model.currentCountryID].capital)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 16)
                            .background{
                                RoundedRectangle(cornerRadius: 8)
                                    .foregroundColor(Color.appYellow)
                                    .overlay{
                                        RoundedRectangle(cornerRadius: 8).stroke(.black, lineWidth: 1)
                                    }
                            }
                        Divider()
                            .padding(.horizontal, 16)
                            .padding(.vertical, 10)
                    }
                    VStack{
                        Text("Continent:")
                        Text(model.countries[model.currentCountryID].continent)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 16)
                            .background{
                                RoundedRectangle(cornerRadius: 8)
                                    .foregroundColor(Color.appYellow)
                                    .overlay{
                                        RoundedRectangle(cornerRadius: 8).stroke(.black, lineWidth: 1)
                                    }
                            }
                        Divider()
                            .padding(.horizontal, 16)
                            .padding(.vertical, 10)
                    }
                    VStack{
                        Text("Population:")
                        Text(model.countries[model.currentCountryID].population)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 16)
                            .background{
                                RoundedRectangle(cornerRadius: 8)
                                    .foregroundColor(Color.appYellow)
                                    .overlay{
                                        RoundedRectangle(cornerRadius: 8).stroke(.black, lineWidth: 1)
                                    }
                            }
                        Divider()
                            .padding(.horizontal, 16)
                            .padding(.vertical, 10)
                    }
                    VStack{
                        Text("Area:")
                        Text(model.countries[model.currentCountryID].area)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 16)
                            .background{
                                RoundedRectangle(cornerRadius: 8)
                                    .foregroundColor(Color.appYellow)
                                    .overlay{
                                        RoundedRectangle(cornerRadius: 8).stroke(.black, lineWidth: 1)
                                    }
                            }
                        Divider()
                            .padding(.horizontal, 16)
                            .padding(.vertical, 10)
                    }
                    VStack{
                       Text("Currency:")
                       Text(model.countries[model.currentCountryID].currency)
                           .multilineTextAlignment(.center)
                           .padding(.horizontal, 16)
                           .background{
                               RoundedRectangle(cornerRadius: 8)
                                   .foregroundColor(Color.appYellow)
                                   .overlay{
                                       RoundedRectangle(cornerRadius: 8).stroke(.black, lineWidth: 1)
                                   }
                           }
                   }
                    VStack{
                        Text("Land Borders:")
                        if model.countries[model.currentCountryID].landBorders.count < 4 {
                            VStack(alignment: .center, spacing: 5){
                                ForEach(model.countries[model.currentCountryID].landBorders, id: \.self){ i in
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
                        else{
                            VStack(alignment: .center, spacing: 5){
                                ForEach(0...1, id: \.self){ i in
                                    Text(model.countries[model.currentCountryID].landBorders[i])
                                        .padding(.horizontal, 16)
                                        .background{
                                            RoundedRectangle(cornerRadius: 8)
                                                .foregroundColor(Color.appYellow)
                                                .overlay{
                                                    RoundedRectangle(cornerRadius: 8).stroke(.black, lineWidth: 1)
                                                }
                                        }
                                }
                                Text("+\(model.countries[model.currentCountryID].landBorders.count-2)")
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
                            .onTapGesture {
                                modalTip = .landBorders
                            }
                    }
                    }
                }
                Divider()
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                VStack(spacing: 5){
                    Text("Trivia:")
                    ForEach(model.countries[model.currentCountryID].trivia, id: \.self){ trivia in
                        Text(trivia)
                            .padding(.horizontal, 16)
                            .multilineTextAlignment(.center)
                            .background{
                                RoundedRectangle(cornerRadius: 8)
                                    .foregroundColor(Color.appYellow)
                                    .overlay{
                                        RoundedRectangle(cornerRadius: 8).stroke(.black, lineWidth: 1)
                                    }
                            }
                    }
                }
                Spacer()
            }
            .padding(.top, 16)
            .padding(.horizontal, 16)
            if modalTip != nil{
                ModalTipView(modalTip: $modalTip)
            }
        }
    }
}

struct CountryInfoView_Previews: PreviewProvider {
    static var previews: some View {
        CountryInfoView()
            .environmentObject(Model())
    }
}
