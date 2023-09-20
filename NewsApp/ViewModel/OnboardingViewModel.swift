//
//  OnboardingViewModel.swift
//  NewsApp
//
//  Created by Öznur Ölçek on 5.09.2023.
//

import UIKit

final class OnboardingViewModel {
    var isLogin: Bool = false
    
    
    func numberOfItems(in section: Int) -> Int {
        return onboardingArray.count
    }
    
    func cellForRow(at indexPath: IndexPath) -> OnboardingInfos {
        return onboardingArray[indexPath.row]
    }
    
}
