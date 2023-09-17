//
//  Onboarding.swift
//  NewsApp
//
//  Created by Öznur Ölçek on 5.09.2023.
//

import Foundation

class OnboardingInfos {
    var title: String?
    var subTitle: String?
    var imageName: String?
    
    init(title: String, subTitle: String, imageName: String) {
        self.title = title
        self.subTitle = subTitle
        self.imageName = imageName
    }
}

let onboardingArray : [OnboardingInfos] = [
    OnboardingInfos(title: "PerspectiNEWS", subTitle: "PerspectiNEWS brings you news from a new perspective.", imageName: "ic_onboarding1"),
    OnboardingInfos(title: "Save News", subTitle: "Save the news that interests you and review it again.", imageName: "ic_onboarding2"),
    OnboardingInfos(title: "Categorize News", subTitle: "Select the category that interests you and see news from that category.", imageName: "ic_onboarding3")
]
