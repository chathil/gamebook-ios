//
//  Colors.swift
//  Gamebook
//
//  Created by Abdul Chathil on 1/6/21.
//  Copyright © 2021 Abdul Chathil. All rights reserved.
//

import SwiftUI

extension Color {
    struct Gamebook {
        public static let primary = Color("primary")
        public static let primaryVariant = Color("primary-variant")
        public static let surfaceDark = Color("surface-dark")
        public static let backgroundDark = Color("background-dark")
        public static let onBackgroundDark = Color("on-background-dark")
        public static let onPrimary = Color("on-primary")
        public static let onSurfaceDark = Color("on-surface-dark")
    }
}

extension UIColor {
    public static let primary = UIColor(named: "primary")!
    public static let primaryVariant = UIColor(named: "primary-variant")!
    public static let surfaceDark = UIColor(named: "surface-dark")!
    public static let backgroundDark = UIColor(named: "background-dark")!
    public static let onBackgroundDark = UIColor(named: "on-background-dark")!
    public static let onPrimary = UIColor(named: "on-primary")!
    public static let onSurfaceDark = UIColor(named: "on-surface-dark")!
}
