//
//  AddressData.swift
//  SharkWeek
//
//  Created by Sam on 10/14/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import Foundation

class AddressData {
    static let shared = AddressData()
    
    let johnsAddress = Address(line1: "644 City Station", city: "Salt Lake City", state: "Utah", zipCode: "84044")
    
    let gettyAddress = Address(line1: "341 Main Street", city: "Salt Lake City", state: "Utah", zipCode: "84101")
    
    let rialtoAddress = Address(line1: "834 Glendon Court", city: "Los Angeles", state: "California", zipCode: "91030")
    
    let jdawgsAddress = Address(line1: "345 Main Street", city: "Salt Lake City", state: "Utah", zipCode: "84101")
    
    let barbacoaAddress = Address(line1: "345 Main Street", city: "Salt Lake City", state: "Utah", zipCode: "84101")
    
    let foodTruck =  Address(line1: "700 Main Street", city: "Salt Lake City", state: "Utah", zipCode: "84101")
    
}
