//
//  placemark.swift
//  Little-things
//
//  Created by Алексей Езерский on 11.04.2025.
//

import CoreLocation
import Contacts

extension CLLocation {
    
    /// Fetch data from Map location.
    @available(iOS, deprecated: 26.0)
    func placemark(completion: @escaping (_ placemark: CLPlacemark?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first, $1) }
    }
}
