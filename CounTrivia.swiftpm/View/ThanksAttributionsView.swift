//
//  ThanksAttribuitonsView.swift
//  CounTrivia
//
//  Created by Pedro Ceccon on 18/04/23.
//
//  A screen presenting some final words and the licenses attributions

import SwiftUI

struct ThanksAttributionsView: View {
    var body: some View {
        ZStack{
            Color.appBackground
                .ignoresSafeArea()
            VStack{
                HStack {
                    Text("Thank you for playing")
                        .font(.title)
                }
                Text("\nI've always been interested in different cultures and this became a passion project for me, I hope to extend it so I can add every country to the app.\n")
                    .multilineTextAlignment(.center)
                Divider()
                VStack(alignment: .leading){
                    Text("\nImage Attributions:\n")
                        .font(.title)
                    Text("All of the following are licensed under CC BY 4.0 \n(https://creativecommons.org/licenses/by/4.0/deed.en):\n")
                        .font(.system(size: 14))
                    HStack {
                        Text("-")
                        Text("Brazil's map outline (original: brazil-map-silhouette-outline): by Natasha Sinegina can be found in creazilla in this link: https://creazilla.com/nodes/2818-mapa-do-brasil-silhueta")
                            .font(.system(size: 12))
                    }
                    HStack {
                        Text("-")
                        Text("USA's map outline (original: america-map-silhouette-outline): by Natasha Sinegina can be found in creazilla in this link: https://creazilla.com/nodes/2996-mapa-da-america-silhueta")
                            .font(.system(size: 12))
                    }
                    HStack {
                        Text("-")
                        Text("Germany's map outline (original: germany-map-silhouette-outline): by Bob Comix can be found in creazilla in this link: https://creazilla.com/nodes/2401-mapa-da-alemanha-silhueta")
                            .font(.system(size: 12))
                    }
                    HStack {
                        Text("-")
                        Text("India's map outline (original: india-map-silhouette-outline): by Bob Comix can be found in creazilla in this link: https://creazilla.com/nodes/2246-mapa-da-india-silhueta")
                            .font(.system(size: 12))
                    }
                    HStack {
                        Text("-")
                        Text("France's map outline (original: france-map-silhouette-outline): by Natasha Sinegina can be found in creazilla in this link: https://creazilla.com/nodes/2433-mapa-da-franca-silhueta")
                            .font(.system(size: 12))
                    }
                }
                Text("\nAll other images used were made by me or are under public domain.")
                    .font(.system(size: 14))
            }
            .padding(.horizontal, 16)
        }
    }
}

struct ThanksAttributionsView_Previews: PreviewProvider {
    static var previews: some View {
        ThanksAttributionsView()
    }
}
