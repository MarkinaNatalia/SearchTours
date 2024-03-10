//
//  Color+CustomColor.swift
//  SearchTours
//
//  Created by Наталья on 09.03.2024.
//

import UIKit

extension UIColor {
    enum CustomColor: String {
        case orangeColor            = "OrangeColor"
        case grayColor              = "GrayColor"
        case blueColor              = "BlueColor"
        case lightGrayColor         = "LightGrayColor"
        case tourBackgroundColor    = "TourBackgroundColor"
        case nameHotelColor         = "NameHotelColor"
        case darkGreenColor         = "DarkGreenColor"
        case blackColor             = "BlackColor"
        case priceTourColor         = "PriceTourColor"
    }
}

extension UIColor {
  static func customColor(_ item: CustomColor) -> UIColor? {
      return UIColor(named: item.rawValue)
  }
}
