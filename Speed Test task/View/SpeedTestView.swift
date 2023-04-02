//
//  SpeedTestView.swift
//  Speed Test task
//
//  Created by Ivan Behichev on 02.04.2023.
//

import UIKit
protocol SpeedTestDelegate {
    func updateUI(with percent: CGFloat)
}

@IBDesignable
class SpeedTestView: UIView {
    var percent: CGFloat = 0
    var button = UIButton()
   
    var delegate: SpeedTestDelegate?
    
    override func draw(_ rect: CGRect) {
        
        let circleFrame = UIScreen.main.bounds.width - (20) * 2
        let radius = circleFrame / 2
        let center = CGPoint(x: radius, y: radius)
        let startAngle = -CGFloat.pi * 7 / 6
        let endAngle = CGFloat.pi * 1 / 6
        let circlePath = UIBezierPath(arcCenter: center,
                                      radius: radius,
                                      startAngle: startAngle,
                                      endAngle: endAngle,
                                      clockwise: true)
        
        let barsFrame = UIScreen.main.bounds.width - (20 + 20) * 2
        let barsRadius = barsFrame / 2
        
        let buttonCirlceFrame = UIScreen.main.bounds.width - (20 + 20 + 60) * 2
        let buttonCircleRadius = buttonCirlceFrame / 2
        
        let buttonCirclePath = UIBezierPath(arcCenter: center, radius: buttonCircleRadius, startAngle: -CGFloat.pi * 2 / 3, endAngle: CGFloat.pi * 3 / 2, clockwise: true)
        
        let buttonCircleLayer = CAShapeLayer()
        buttonCircleLayer.path = buttonCirclePath.cgPath
        buttonCircleLayer.fillColor = UIColor.white.cgColor
        buttonCircleLayer.shadowColor = UIColor.black.cgColor
        buttonCircleLayer.shadowOpacity = 0.5
        buttonCircleLayer.shadowOffset = CGSize(width: 0, height: 2)
        buttonCircleLayer.shadowRadius = 4
        
        button = UIButton(frame: CGRect(x: buttonCirlceFrame, y: buttonCircleRadius + 20 - buttonCircleRadius , width: buttonCircleRadius * 2, height: buttonCircleRadius * 2))
        button.center = center
        button.layer.cornerRadius = buttonCircleRadius
        button.setTitle("START", for: .normal)
        button.setTitleColor(UIColor(named: "progressColor"), for: .normal)
        button.setImage(UIImage(named: "logoButton"), for: .normal)
        button.layer.masksToBounds = true
        button.backgroundColor = .white
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -button.imageView!.frame.size.width, bottom: -button.imageView!.frame.size.height, right: 0)
        button.imageEdgeInsets = UIEdgeInsets(top: -button.titleLabel!.frame.size.height, left: 0, bottom: 0, right: -button.titleLabel!.frame.size.width)
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        
        let barsPath = UIBezierPath(arcCenter: center,
                                    radius: barsRadius,
                                    startAngle: startAngle,
                                    endAngle: endAngle,
                                    clockwise: true)
        
        let barsLayer = CAShapeLayer()
        barsLayer.path = barsPath.cgPath
        barsLayer.fillColor = UIColor.clear.cgColor
        barsLayer.strokeColor = UIColor.clear.cgColor
        
        let numbers = [0, 1, 5, 10, 20, 30, 50, 75, 100]
        let labelCount = numbers.count
        
        let step = 1.0 / CGFloat(labelCount - 1)
        let labelRadius = barsRadius - 5

        for i in 0..<labelCount {
            
            let angle = startAngle + (endAngle - startAngle) * step * CGFloat(i)
            
            let x = center.x + cos(angle) * labelRadius
            let y = center.y + sin(angle) * labelRadius
            
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
            label.center = CGPoint(x: x, y: y)
            label.textAlignment = .center
            label.text = "\(numbers[i])"
            label.textColor = .white
            addSubview(label)
        }

        let defaultCircleLayer = CAShapeLayer()
        defaultCircleLayer.path = circlePath.cgPath
        defaultCircleLayer.strokeColor = UIColor.white.cgColor
        defaultCircleLayer.lineWidth = 16
        defaultCircleLayer.strokeEnd = 1
        defaultCircleLayer.fillColor = UIColor.clear.cgColor
        defaultCircleLayer.lineCap = .round
        
        let circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.strokeColor = UIColor(named: "progressColor")?.cgColor
        circleLayer.lineWidth = 16
        circleLayer.strokeEnd = percent
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineCap = .round
        circleLayer.shadowColor = UIColor(named: "shadowColor")!.cgColor
        circleLayer.shadowOpacity = 1
        circleLayer.shadowOffset = CGSize(width: 0, height: 2)
        circleLayer.shadowRadius = 4

        layer.addSublayer(defaultCircleLayer)
        layer.addSublayer(circleLayer)
        layer.addSublayer(barsLayer)
        layer.addSublayer(buttonCircleLayer)
        buttonCircleLayer.addSublayer(button.layer)
        addSubview(button)
    }
    
    @objc func startButtonTapped() {
        print("Start button tapped")
        delegate?.updateUI(with: percent)
    }
}
