//
//  AllowLocation.swift
//  DefhackProject
//
//  Created by Alyssa Feinberg on 6/21/20.
//  Copyright © 2020 Alyssa Feinberg. All rights reserved.
//
 
import SwiftUI
import Foundation
 
struct AllowLocation: View {
    let h = GlobalVariables()
    let currentLocationFinder = CurrentLocationFinder()
    var body: some View {
        NavigationView {
            VStack {
                Image("Logo")
                    .padding(.bottom)
                Button(action: {
                    self.currentLocationFinder.setup()
                }) {
                    Image("Allow Location").resizable().frame(width: 290.0, height: 90.0)
                }
                .buttonStyle(PlainButtonStyle())
                NavigationLink(destination: ContentView().environmentObject(h)
                    .navigationBarHidden(true)
                .navigationBarTitle("")) {
                        Image("Continue").resizable().frame(width: 290.0, height: 90.0)
                            .padding(.vertical)
                    }
                .buttonStyle(PlainButtonStyle())
                .padding(.bottom)
                Spacer()
                }
            }
        }
    }
 
 
struct AllowLocation_Previews: PreviewProvider {
    static var previews: some View {
        AllowLocation()
    }
}
