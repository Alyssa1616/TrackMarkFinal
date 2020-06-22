////
////  PlayCourse.swift
////  DefhackProject
////
////  Created by Alyssa Feinberg on 6/20/20.
////  Copyright © 2020 Alyssa Feinberg. All rights reserved.
////
////
import Foundation
import SwiftUI
 import CoreLocation
import Combine
import AVFoundation
 
struct PlayCourse: View {
    @EnvironmentObject var stor: GlobalVariables
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State var showingPopover = false
    @State var finished = false
    let h = GlobalVariables()
 
    func insideCircle() {
            let location2 = CurrentLocationFinder().getLocation()
            for x in stor.locations {
                let distance : CLLocationDistance = CLLocation.distance(from: x.coordinate, to: location2)
                if(distance < 3.0){
                    stor.completelocations.append(x)
                    if let firstIndex = stor.locations.firstIndex(of: x) {
                        stor.locations.remove(at: firstIndex)
                    }
                }
            }
        }
    func findNearestCheckPoint() -> Int {
        let location2 = CurrentLocationFinder().getLocation()
        var distance : CLLocationDistance = CLLocation.distance(from: location2, to: location2)
        if stor.locations.count > 2 {
            for x in 0...stor.locations.count - 2 {
                distance = CLLocation.distance(from: stor.locations[x].coordinate, to: location2)
                if distance > CLLocation.distance(from: stor.locations[x+1].coordinate, to: location2) {
                    distance = CLLocation.distance(from: stor.locations[x+1].coordinate, to: location2)
                }
            }
        }
        if stor.locations.count == 1 {
            if CLLocation.distance(from: stor.locations[0].coordinate, to: location2) > CLLocation.distance(from: stor.locations[1].coordinate, to: location2) {
                distance = CLLocation.distance(from: stor.locations[1].coordinate, to: location2)
            }
            else {
                distance = CLLocation.distance(from: stor.locations[0].coordinate, to: location2)
            }
        }
    if stor.locations.count == 0 {
        distance = CLLocation.distance(from: stor.locations[0].coordinate, to: location2)
    }
        return Int(distance)
        
    }
    
    var body: some View {
            ZStack {
                MapView(centerCoordinate: $centerCoordinate, annotations: stor.locations).edgesIgnoringSafeArea(.all)
                    VStack {
                    Text("Distance from nearest checkpoint: \(findNearestCheckPoint()) meters")
                        .font(.headline)
                        Spacer()
                Button(action: {self.insideCircle()
                    UIDevice.vibrate()
                }) {
                    Image("Reached A Marker").resizable().frame(width: 315.0, height: 80.0)
                }.buttonStyle(PlainButtonStyle())
 
                
                
                Button(action: {self.showingPopover = true
                    self.finished = true }) {
                        Image("Finish").resizable().frame(width: 315.0, height: 80.0)
                }.popover(isPresented: self.$showingPopover) {
                    NavigationView {
                        VStack {
                            Image("Recap").resizable().frame(width: 315.0, height: 100.0)
                            HStack {
                                Text("")
                            }
 
                            HStack {
                                Text("Congratulations on Finishing your Track!")
                                    .font(.headline)
                            }
                            Spacer()
                            NavigationLink(destination: ContentView().environmentObject(self.h)
                                .navigationBarHidden(true)
                            .navigationBarTitle("")) {
                                    Image("Main").resizable().frame(width: 290.0, height: 80.0)
                                        .padding(.vertical)
                                }
                                .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
                .buttonStyle(PlainButtonStyle())
            
            }
        }
 
    }
}
extension CLLocation {
 
    class func distance(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D) -> CLLocationDistance {
        let from = CLLocation(latitude: from.latitude, longitude: from.longitude)
        let to = CLLocation(latitude: to.latitude, longitude: to.longitude)
        return from.distance(from: to)
    }
}
extension UIDevice {
    static func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
}
 
struct PlayCourse_Previews: PreviewProvider {
    static var previews: some View {
        Text("")
    }
}

