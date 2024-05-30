//
//  FontStyle.swift
//  Stardust
//
//  Created by sueun kim on 5/30/24.
//

import SwiftUI

enum FontWeight {
    case bold
    case regular
}
enum Pretendard: String {
    case bold = "Pretendard-Bold"
    case semibold = "Pretendard-SemiBold"
    case medium = "Pretendard-Medium"
    case regular = "Pretendard-Regular"
}

enum FontSize {
    static let largeTitle: CGFloat = 34
    static let title1: CGFloat = 28
    static let title2: CGFloat = 22
    static let title3: CGFloat = 20
    static let headline: CGFloat = 17
    static let body: CGFloat = 17
    static let callout: CGFloat = 16
    static let subhead: CGFloat = 15
    static let footnote: CGFloat = 13
    static let caption1: CGFloat = 12
    static let caption2: CGFloat = 11
}

enum AppFont {
    static let largeTitleBold = Font.custom(Pretendard.bold.rawValue, size: 34)
    static let largeTitleRegular = Font.custom(Pretendard.regular.rawValue, size: 34)

    static let title1Bold = Font.custom(Pretendard.bold.rawValue, size: 28)
    static let title1Regular = Font.custom(Pretendard.regular.rawValue, size: 28)

    static let title2Bold = Font.custom(Pretendard.bold.rawValue, size: 22)
    static let title2Regular = Font.custom(Pretendard.regular.rawValue, size: 22)

    static let title3Bold = Font.custom(Pretendard.semibold.rawValue, size: 20)
    static let title3Regular = Font.custom(Pretendard.regular.rawValue, size: 20)

    static let headlineBold = Font.custom(Pretendard.semibold.rawValue, size: 17)
    static let headlineRegular = Font.custom(Pretendard.semibold.rawValue, size: 17)

    static let bodyBold = Font.custom(Pretendard.semibold.rawValue, size: 17)
    static let bodyRegular = Font.custom(Pretendard.regular.rawValue, size: 17)

    static let calloutBold = Font.custom(Pretendard.semibold.rawValue, size: 16)
    static let calloutRegular = Font.custom(Pretendard.regular.rawValue, size: 16)

    static let subheadBold = Font.custom(Pretendard.semibold.rawValue, size: 15)
    static let subheadRegular = Font.custom(Pretendard.regular.rawValue, size: 15)

    static let footnoteBold = Font.custom(Pretendard.semibold.rawValue, size: 13)
    static let footnoteRegular = Font.custom(Pretendard.regular.rawValue, size: 13)

    static let caption1Bold = Font.custom(Pretendard.medium.rawValue, size: 12)
    static let caption1Regular =  Font.custom(Pretendard.regular.rawValue, size: 12)

    static let caption2Bold = Font.custom(Pretendard.semibold.rawValue, size: 11)
    static let caption2Regular = Font.custom(Pretendard.regular.rawValue, size: 11)
}


enum LineHeight{
    static let largeTitle: CGFloat = 41
    static let title1: CGFloat = 34
    static let title2: CGFloat = 28
    static let title3: CGFloat = 25
    static let headline: CGFloat = 22
    static let body: CGFloat = 22
    static let callout: CGFloat = 21
    static let subhead: CGFloat = 20
    static let footnote: CGFloat = 18
    static let caption1: CGFloat = 16
    static let caption2: CGFloat = 13
}

enum LetterSpacing {
    static let largeTitleBold: CGFloat = -0.5
    static let largeTitleRegular: CGFloat = -0.5

    static let title1Bold: CGFloat = 0.0
    static let title1Regular: CGFloat = 0.0

    static let title2Bold: CGFloat = -0.2
    static let title2Regular: CGFloat = 0.2

    static let title3Bold: CGFloat = -0.2
    static let title3Regular: CGFloat = 0.38

    static let headlineBold: CGFloat = -0.3
    static let headlineRegular: CGFloat = -0.3

    static let bodyBold: CGFloat = -0.3
    static let bodyRegular: CGFloat = -0.3

    static let calloutBold: CGFloat = -0.2
    static let calloutRegular: CGFloat = -0.2

    static let subheadBold: CGFloat = 0
    static let subheadRegular: CGFloat = -0.24

    static let footnoteBold: CGFloat = -0.08
    static let footenoteRegular: CGFloat = -0.08

    static let caption1Bold: CGFloat = 0
    static let caption1Regular: CGFloat = 0

    static let caption2Bold: CGFloat = 0
    static let caption2Regular: CGFloat = 0.06
}
