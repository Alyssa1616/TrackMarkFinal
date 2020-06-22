 
import SwiftUI
import MapKit
import AVFoundation
 
struct MapView: UIViewRepresentable {
    var locationManager = CLLocationManager()
    @Binding var centerCoordinate: CLLocationCoordinate2D
    var annotations: [MKPointAnnotation]
    @EnvironmentObject var stor: GlobalVariables
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.showsUserLocation = true
        mapView.delegate = context.coordinator
        let span = MKCoordinateSpan(latitudeDelta: 0.0013, longitudeDelta: 0.0013)
        let region = MKCoordinateRegion(center: CurrentLocationFinder().getLocation(), span: span)
        mapView.setRegion(region, animated: true)
        return mapView
    }
 
    func updateUIView(_ view: MKMapView, context: Context) {
        if annotations.count != view.annotations.count {
            view.removeAnnotations(view.annotations)
            view.addAnnotations(annotations)
        }
    }
    
    func updateUIViewPlay(_ view: MKMapView, context: Context) {
        view.showsUserLocation = true
        if annotations.count != view.annotations.count {
            view.removeAnnotations(view.annotations)
            view.addAnnotations(annotations)
        }
    }
        
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
 
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        init(_ parent: MapView) {
            self.parent = parent
        }
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            parent.centerCoordinate = mapView.centerCoordinate
        }
    }
}
extension MKPointAnnotation {
    static var example: MKPointAnnotation {
        let annotation = MKPointAnnotation()
        //annotation.title = "London"
        //annotation.subtitle = "Home to the 2012 Summer Olympics."
        annotation.coordinate = CLLocationCoordinate2D(latitude: 100.5, longitude: -0.13)
        return annotation
    }
}
 
 
struct CreateCourse: View {
    @EnvironmentObject var stor: GlobalVariables
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var locations = [MKPointAnnotation]()
    var locationManager = CLLocationManager()
    
    func setup() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
 
    var body: some View {
        NavigationView {
            ZStack {
                MapView(centerCoordinate: $centerCoordinate, annotations: locations)
                    .edgesIgnoringSafeArea(.all)
                Image("Pin")
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        NavigationLink(destination: ContentView()
                            .padding([.top, .leading])
                            .navigationBarHidden(true)
                        .navigationBarTitle("")){ Image("Back").resizable().frame(width: 130.0, height: 80.0)
                                .padding(.top)
                                .padding(.top)
                        }
                        .padding(.trailing)
                        .buttonStyle(PlainButtonStyle())
                      Spacer()
                    HStack {
                        Text("")
                        Text("")
                        Text("")
                    }
                    NavigationLink(destination: PlayCourse().navigationBarHidden(true)
                            .navigationBarTitle("")){ Image("Save & Go").resizable().frame(width: 130.0, height: 80.0)
                        .padding(.top)
                        .frame(width: 50.0, height: 70)
                        }
                        .padding(.top)
                        .buttonStyle(PlainButtonStyle())
                        HStack {
                            Text("")
                            Text("")
                        }
                        HStack {
                            Text("")
                            Text("")
                        }
                        Button(action: {
                           let newLocation = MKPointAnnotation()
                           newLocation.coordinate = self.centerCoordinate
                            self.locations.append(newLocation)
                            self.addElements()
                            
                        }) {
                            Image("Plus")
                            
                        }
                            .buttonStyle(PlainButtonStyle())
                        .padding(.top)
                      
                        .foregroundColor(.white)
                        .font(.title)
                        .clipShape(Circle())
                        .padding(.trailing)
                        }
                }
            }
        }
    }
    func addElements() {
        for x in locations {
            stor.locations.append(x)
        }
    }
}
 
 
struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(centerCoordinate: .constant(MKPointAnnotation.example.coordinate), annotations: [MKPointAnnotation.example])
       
    }
}
