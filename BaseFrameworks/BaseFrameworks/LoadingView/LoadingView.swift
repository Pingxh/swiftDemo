//
//  LoadingView.swift
//  FirstAidLight
//
//  Created by Apple on 2019/6/24.
//  Copyright © 2019 huameng. All rights reserved.
//

import UIKit

/// 高度适配
///
/// - Parameter value: <#width description#>
/// - Returns: <#return value description#>
func fitRect(_ value: CGFloat) -> CGFloat {
    return value * UIScreen.main.bounds.size.width / 414.0
}

public protocol LoadingViewProtocol: NSObjectProtocol {
    func loadingReload()
}

public class LoadingView: UIView {
    
    public weak var delegate: LoadingViewProtocol?
    
    var isChanged: Bool = false
    
    var tap = UITapGestureRecognizer()
    var rotationAnimation = CABasicAnimation()
    
    lazy var imageView : UIImageView = {
        let object = UIImageView()
        object.contentMode = UIView.ContentMode.scaleAspectFill
        let bundle = Bundle.init(for: LoadingView.self)
        object.image = UIImage.init(named: "loading_image", in: bundle, compatibleWith: nil)
        return object
    }()

    lazy var infoLabel : UILabel = {
        let object = UILabel()
        object.textAlignment = NSTextAlignment.center
        object.font = UIFont.systemFont(ofSize: fitRect(16))
        object.textColor = UIColor.lightGray
        object.numberOfLines = 0
        object.text = "加载中..."
        return object
    }()

   public override init(frame: CGRect) {
        super.init(frame: frame)
        
        xh_setup()
        self.backgroundColor = UIColor.white
        NotificationCenter.default.addObserver(self, selector: #selector(doAnimation), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    func xh_setup() {

        imageView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width * 0.1, height: self.frame.size.width * 0.1)
        imageView.center = self.center
        imageView.center.y = self.center.y - imageView.frame.size.height / 2
        self.addSubview(imageView)
        
        infoLabel.frame = CGRect(x: 0, y: imageView.frame.maxY + 5, width: self.frame.size.width * 0.5, height: 40)
        var infoCenter = self.center
        infoCenter.y = imageView.frame.maxY  + 20
        infoLabel.center = infoCenter
        self.addSubview(infoLabel)
        
    }
    
    public func startAnimation() {
        
        DispatchQueue.main.async {
            self.rotationAnimation = CABasicAnimation.init(keyPath: "transform.rotation.z")
            self.rotationAnimation.fromValue = NSNumber.init(value: 0)
            self.rotationAnimation.toValue = NSNumber.init(value: Double.pi * 2.0)
            self.rotationAnimation.duration = 1.0
            self.rotationAnimation.isCumulative = true
            self.rotationAnimation.repeatCount = Float(NSIntegerMax)
            self.imageView.layer.speed = 1.0
            self.imageView.layer.add(self.rotationAnimation, forKey: "rotationAnimation")
        }
        
    }
    
    public func stopAnimation() {
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 0.0
        }) { (finish) in
            self.removeFromSuperview()
        }
    }
    
    public func changeLoadingStatus() {
        if isChanged {
            startAnimation()
            let bundle = Bundle.init(for: LoadingView.self)
            self.imageView.image = UIImage.init(named: "loading_image", in: bundle, compatibleWith: nil)
            self.infoLabel.text = "加载中..."
            
            var imgFrame = imageView.frame
            imgFrame.size.width = self.frame.size.width * 0.1
            imgFrame.size.height = self.frame.size.width * 0.1
            imageView.frame = imgFrame
            
            let size = self.infoLabel.text?.boundingSize(self.infoLabel.frame.size, textFont: UIFont.systemFont(ofSize: fitRect(16)))
            var infoFrame = self.infoLabel.frame
            infoFrame.size.height = size!.height
            self.infoLabel.frame = infoFrame
            
            var infoCenter = self.center
            infoCenter.y = imageView.frame.maxY + size!.height
            self.infoLabel.center = infoCenter

            self.removeGestureRecognizer(tap)
        } else {
            self.imageView.layer.speed = 0
            let bundle = Bundle.init(for: LoadingView.self)
            self.imageView.image = UIImage.init(named: "loading_fail1", in: bundle, compatibleWith: nil)
            var imgFrame = imageView.frame
            imgFrame.size.width = self.frame.size.width * 0.1
            imgFrame.size.height = self.frame.size.width * 0.1
            imageView.frame = imgFrame
            
            self.infoLabel.text = "请求失败，请点击空白处重试"
            let size = self.infoLabel.text?.boundingSize(self.infoLabel.frame.size, textFont: UIFont.systemFont(ofSize: fitRect(16)))
            var infoFrame = self.infoLabel.frame
            infoFrame.size.height = size!.height
            self.infoLabel.frame = infoFrame
            
            var infoCenter = self.center
            infoCenter.y = imageView.frame.maxY + size!.height
            self.infoLabel.center = infoCenter
            
            tap = UITapGestureRecognizer.init(target: self, action: #selector(reloadAgain(_:)))
            self.addGestureRecognizer(tap)
        }
        isChanged = !isChanged
    }
    
    @objc func reloadAgain(_ gesture: UITapGestureRecognizer) {
        delegate?.loadingReload()
    }
    
    @objc func doAnimation() {
        startAnimation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
