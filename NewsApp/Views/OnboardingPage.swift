//
//  OnboardingPage.swift
//  NewsApp
//
//  Created by Öznur Ölçek on 5.09.2023.
//

import UIKit

final class OnboardingPage: UIViewController {

    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel = OnboardingViewModel()
    
    var isLogin: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        prepareCollectionView()
        prepareButtons()
        preparePageControl()
        
    }
    
    private func prepareCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func prepareButtons() {
        signUpButton.layer.cornerRadius = 16
        loginButton.layer.cornerRadius = 16
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = #colorLiteral(red: 0.9853720069, green: 0.370408535, blue: 0.369864285, alpha: 1)
    }
    
    private func preparePageControl() {
        pageControl.page = 0
        loginButton.isHidden = true
        signUpButton.isHidden = true
    }
    
    @IBAction func skipButtonAct(_ sender: Any) {
        showPageItem(at: 2)
        showItems(false)
    }
    
    @IBAction func signUpButtonAct(_ sender: Any) {
        isLogin = false
        UserDefaults.standard.set(true, forKey: "openedApp")
        let storyboard = UIStoryboard(name: "LoginPage", bundle: nil)
                
        if let vc = storyboard.instantiateViewController(withIdentifier: "LoginPage") as? LoginPage {
            
            vc.isLogin = isLogin
            
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
        
    }
    
    @IBAction func loginButtonAct(_ sender: Any) {
        isLogin = true
        UserDefaults.standard.set(true, forKey: "openedApp")
        let storyboard = UIStoryboard(name: "LoginPage", bundle: nil)
                
        if let vc = storyboard.instantiateViewController(withIdentifier: "LoginPage") as? LoginPage {
            
            vc.isLogin = isLogin
            
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
    }
    
    @IBAction func pageControlAct(_ sender: Any) {
        showPageItem(at: pageControl.currentPage)
    }
    
    private func showItems(_ isHidden: Bool) {
        skipButton.isHidden = !isHidden
        signUpButton.isHidden = isHidden
        loginButton.isHidden = isHidden
    }
    
    private func showPageItem(at index: Int) {
        showItems(index != 2)
        pageControl.page = index
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.scrollToItem(at: indexPath, at: [.centeredHorizontally, .centeredVertically], animated: true)
    }

}

//MARK: UICOllectionView
extension OnboardingPage: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems(in: section)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCell", for: indexPath) as! OnboardingCell
        cell.titleLabel.text = viewModel.cellForRow(at: indexPath).title
        cell.subTitleLabel.text = viewModel.cellForRow(at: indexPath).subTitle
        cell.imageView.image = UIImage(named: viewModel.cellForRow(at: indexPath).imageName!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: collectionView.bounds.size.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.size.width
        let page = Int(floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1)
        pageControl.page = page
        
        showItems(page != 2)
    }
    
}

//MARK: UIPageControl
extension UIPageControl {
    var page: Int {
        get {
            return currentPage
        }
        set {
            currentPage = newValue
        }
    }
}
