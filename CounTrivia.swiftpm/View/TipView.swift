//
//  TipView.swift
//  CounTrivia
//
//  Created by Pedro Ceccon on 13/04/23.
//
//  A View that format the visualization of a tip

import SwiftUI

struct TipView: View {
    var tip: Tip
    @EnvironmentObject var model: Model
    @Binding var modalTip: Tip?
    var body: some View {
        if(tip == .landBorders){
            HStack(alignment: .top){
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
        else if(tip == .trivia){
            HStack(alignment: .top){
                Text("Trivia:")
                VStack(alignment: .center, spacing: 5){
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
            }
        }
        else if(tip == .capital || tip == .continent){
            HStack{
                Text("\(tip.getName()):")
                Text(model.getTipString(tip))
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

struct TipView_Previews: PreviewProvider {
    static var previews: some View {
        @State var tip: Tip?
        TipView(tip: .landBorders, modalTip: $tip)
            .environmentObject(Model())
    }
}
