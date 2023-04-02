//
//  ViewController.swift
//  Speed Test task
//
//  Created by Ivan Behichev on 02.04.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak private var resultView: UIView!
    @IBOutlet weak private var speedTestView: SpeedTestView!
    @IBOutlet weak private var downladResultLabel: UILabel!
    @IBOutlet weak private var uploadResultLabel: UILabel!
    @IBOutlet weak private var pingResultLabel: UILabel!
    @IBOutlet weak private var connectTypeResultLabel: UILabel!
    @IBOutlet weak private var ipAdressResultLabel: UILabel!
    @IBOutlet weak private var providerResultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
//        go()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if speedTestView.percent == 1 {
            updateUI()
        }
        
    }
    
    func updateUI() {
        downladResultLabel.text = "25.3Mbps"
        uploadResultLabel.text = "5.3Mbps"
        pingResultLabel.text = "120ms"
        connectTypeResultLabel.text = "Mobile Network"
        ipAdressResultLabel.text = "168.0.0.1"
        providerResultLabel.text = "Life"
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
    
    private func go() {
        for i in 1...11 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.speedTestView.percent += 0.1
                self.speedTestView.setNeedsDisplay()
            }
            if speedTestView.percent >= 1 {
                DispatchQueue.main.async {
                    self.updateUI()
                    self.resultView.setNeedsDisplay()
                }
            }
        }
    }
}
