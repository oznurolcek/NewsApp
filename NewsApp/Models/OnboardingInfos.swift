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
    OnboardingInfos(title: "Deneme", subTitle: "If you're reading this, it means you're ready to add that bit of extra magic to your iOS apps. It's time to sprinkle on those little bits that will give your app the edge and make your users cry with joy when they see it because it’s just so darn beautiful.", imageName: "ic_onboarding1"),
    OnboardingInfos(title: "Deneme2", subTitle: "And how can you do this I hear you ask? Well there are many ways of course, but the one that we're going to look at here is Lottie.", imageName: "ic_onboarding2"),
    OnboardingInfos(title: "Deneme3", subTitle: "By the end of this article, you will understand and be able to build your own iOS app with custom Lottie animations. And here’s what we are building together.", imageName: "ic_onboarding3")
]
