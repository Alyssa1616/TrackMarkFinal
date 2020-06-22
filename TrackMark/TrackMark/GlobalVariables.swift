//
//  GlobalVariables.swift
//  TrackMark
//
//  Created by Alyssa Feinberg on 6/21/20.
//  Copyright © 2020 Alyssa Feinberg. All rights reserved.
//


import Foundation
import Combine
import SwiftUI
import MapKit
 
class GlobalVariables: ObservableObject {
    @Published var locations = [MKPointAnnotation]()
    @Published var completelocations = [MKPointAnnotation]()
}

