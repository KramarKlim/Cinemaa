//
//  ScrollFilmsViewController.swift
//  Cinemaa
//
//  Created by Клим on 27.08.2021.
//

import UIKit

class ScrollFilmsViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var scrollView: UIScrollView!
    
    var contentWidth: CGFloat = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = "Текущие фильмы"
    }

    @IBAction func valueChanged(_ sender: UIPageControl) {
        let current = sender.currentPage
        scrollView.setContentOffset(CGPoint(x: CGFloat(current) * view.frame.size.width,
                                            y: 0), animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(floorf(Float(scrollView.contentOffset.x) / Float(scrollView.frame.size.width)))
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
            pageControl.currentPage = Int(pageNumber)
    }
    
    private func setupImage() {
        self.navigationController?.navigationBar.topItem?.title = "Текущие фильмы"

        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        
        pageControl.numberOfPages = DataManager.shared.images.count
        
        for i in 0..<DataManager.shared.images.count {
            let imageView = UIImageView()
            imageView.contentMode = .scaleToFill
            imageView.image = DataManager.shared.images[i]
            let xPos = CGFloat(i) * self.view.bounds.size.width
            imageView.frame = CGRect(x: xPos, y: 0, width: view.frame.size.width, height: scrollView.frame.size.height)
            scrollView.contentSize.width = view.frame.size.width*CGFloat(i+1)
            scrollView.addSubview(imageView)
        }
    }
}
