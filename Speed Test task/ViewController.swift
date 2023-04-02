//
//  ViewController.swift
//  Speed Test task
//
//  Created by Ivan Behichev on 02.04.2023.
//

import UIKit

class ViewController: UIViewController, SpeedTestDelegate {

    @IBOutlet weak var resultView: UIView!
    @IBOutlet weak var speedTestView: SpeedTestView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        speedTestView.percent = 0.2
    }
    
    func updateUI(with percent: CGFloat) {
        speedTestView.percent += 0.1
        if speedTestView.percent >= 1 {
        }
        print(speedTestView.percent)
    }
    
    private func setupUI() {
        resultView.layer.cornerRadius = 16
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor(red: 115/255, green: 117/255, blue: 216/255, alpha: 1).cgColor,
            UIColor(red: 101/255, green: 107/255, blue: 187/255, alpha: 1).cgColor,
            UIColor(red: 73/255, green: 78/255, blue: 170/255, alpha: 1).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        view.layer.insertSublayer(gradientLayer, at: 0)
    }

}

