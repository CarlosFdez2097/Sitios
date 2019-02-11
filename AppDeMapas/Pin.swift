import MapKit
import Foundation
import UIKit

class Pin : NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var id: Int?
    
    init(pinId:Int,pinTitle:String, pinSubTitle:String, location:CLLocationCoordinate2D) {
        self.id = pinId
        self.title = pinTitle
        self.subtitle = pinSubTitle
        self.coordinate = location
    }
}
