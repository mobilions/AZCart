//
//  File.swift
//  BANOUN
//
//  Created by Mobilions iOS on 02/01/24.
//

import Foundation
import SwiftUI

enum FontStyle {
    case Regular, Bold, Light, medium, semibold
}

struct Font {
    
}

//MARK: - Fonts

enum PoppinsFont: String {
    case Light = "Poppins-Light"
    case Regular = "Poppins-Regular"
    case Medium = "Poppins-Medium"
    case SemiBold = "Poppins-SemiBold"
    case Bold = "Poppins-Bold"
}

enum OpenSansFont: String {
    case Light = "OpenSans-Light"
    case Regular = "OpenSan-_Regular"
    case Medium = "OpenSans-Medium"
    case SemiBold = "OpenSans-Semibold"
    case Bold = "OpenSans-Bold"
}

func getPoppinsFont(weight: PoppinsFont) -> String{
    return String(describing: weight.rawValue)
}

func getOpenSansFont(weight: OpenSansFont) -> String{
    return String(describing: weight.rawValue)
}

func printFonts() {
    UIFont.familyNames.forEach({ familyName in
        let fontNames = UIFont.fontNames(forFamilyName: familyName)
        print(familyName, fontNames)
    })
}
