 //
 //  ContentView.swift
 //  DefhackProject
 //
 //  Created by Alyssa Feinberg on 6/20/20.
 //  Copyright © 2020 Alyssa Feinberg. All rights reserved.
 //

 import SwiftUI

 struct ContentView: View {
     @State var showingPopover = false
     @EnvironmentObject var stor: GlobalVariables
     var body: some View {
         NavigationView {
             VStack {
                 Image("Logo")
                     .padding(.bottom)
                 NavigationLink(destination: CreateCourse().navigationBarHidden(true)
                     .navigationBarTitle("")) {
                 Image("Create Course")
                     .padding(.vertical)
                     .frame(width: 280.0, height: 70)
                     }
                     .buttonStyle(PlainButtonStyle())
                     .padding(.bottom)

                 Button(action: {self.showingPopover = true}) {
                         Image("SavedTracksButton")
                             .padding(.vertical)
                             .frame(width: 280.0, height: 70)
                 }.popover(isPresented: self.$showingPopover) {
                     VStack {
                         Text("Saved Tracks")
                                 .font(.title)
                                 .bold()
                                 .padding(.top)
                         List {
                             if self.stor.locations.count > 0 {
                                 ForEach(self.stor.locations, id: \.self) { item in
                                        Text("\(item)")
                         }
                             }
                             else if self.stor.locations.count == 0 {
                                 Text("You have no saved tracks")
                             }
                         }

                     }
                 }
                     .buttonStyle(PlainButtonStyle())
                     .padding(.bottom)
                 Spacer()
             }
         }
     }
 }

 struct ContentView_Previews: PreviewProvider {
     static var previews: some View {
         ContentView()
     }
 }
