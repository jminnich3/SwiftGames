//
//  MapPlayersView.swift
//  iOSProject
//
//  Created by COMP401 on 11/19/24.
//

//
//  GamesView.swift
//  iOSProject
//
//  Created by COMP401 on 11/19/24.
//

import SwiftUI
import MapKit



struct MapPlayersView :  UIViewRepresentable {
    
    @ObservedObject var dbService = DatabaseManager()

    var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 41.1548, longitude: -80.085), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.015))
    
    var pointsOfInterest: [MKPointAnnotation] {
            var locs = [MKPointAnnotation]()
            for user in dbService.users {
                if let lat = user.latitude, let lon = user.longitude {
                    let loc = MKPointAnnotation()
                    loc.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                    loc.title = user.username
                    locs.append(loc)
                    print("point 1")
                }
            }
            return locs
        }
    func makeUIView(context: Context) -> MKMapView {
        var map = MKMapView()
        map.delegate = context.coordinator
        
        return map
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.removeAnnotations(uiView.annotations) // first clear
        
        uiView.addAnnotations(pointsOfInterest) // add annotations
        uiView.setRegion(region, animated: true)
    }
    
    static func dismantleUIView(_ uiView: MKMapView, coordinator: ()) {
        uiView.removeAnnotations(uiView.annotations)
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(map: self)
    }
    
    
    class Coordinator : NSObject, MKMapViewDelegate {
        
        var map: MapPlayersView // the map it delegate for
        
        init(map: MapPlayersView) { // pass the map object to the delegate
            self.map = map
        }
        
        // redefine how the annotation is rendered
        func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView? {
            
//            let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: nil)
            //            let annotationView = MKUserLocationView(annotation: annotation, reuseIdentifier: nil)
            //            let annotationView = MyAnnotationView(annotation: annotation, reuseIdentifier: nil)
                       var annotationView = MKAnnotationView()
            
                        if annotation.title == "jminnich23"{
                            annotationView = MyAnnotationView(annotation: annotation, reuseIdentifier: nil, image_name: "blackjack")
                       }
            //else if annotation.title == "Dunkin'"{
//                            annotationView = MyAnnotationView(annotation: annotation, reuseIdentifier: nil, image_name: "star")
            //            }else if annotation.title == "Jin Sushi"{
            //                annotationView = MyAnnotationView(annotation: annotation, reuseIdentifier: nil, image_name: "cherry")
            //            }
            annotationView.canShowCallout = true
            annotationView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
            return annotationView
            
        }
        
    }
}
    
    
    #Preview{
        MapPlayersView()
            .ignoresSafeArea()
    }



class MyAnnotationView : MKAnnotationView{
    
    var image_name = ""
    
//    override init(annotation: (any MKAnnotation)?, reuseIdentifier: String?) {
//        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
//        self.image = UIImage(named: "apple")
//        self.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
//    }
    
    init(annotation: (any MKAnnotation)?, reuseIdentifier: String?, image_name: String) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.image_name = image_name
        self.image = UIImage(named: image_name)
        self.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
