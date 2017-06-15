//
//  Annotations.swift
//  WorldTrotter
//
//  Created by Jonathan Salin Lee on 6/12/17.
//  Copyright © 2017 Salin Studios. All rights reserved.
//

import MapKit;

class Annotation: NSObject {
    var title: String?;
    var subtitle: String?;
    var coordinate: CLLocationCoordinate2D;
    
    init(title: String?, subtitle: String?, coordinate: CLLocationCoordinate2D) {
        self.title = title;
        self.subtitle = subtitle;
        self.coordinate = coordinate;
    }
}

extension Annotation: MKAnnotation {};
