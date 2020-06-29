//
//  XHMenuScrollView.swift
//  Demo
//
//  Created by Apple on 2020/1/11.
//  Copyright © 2020 Yioks. All rights reserved.
//

import UIKit


@objc protocol XHMenuDelegate: NSObjectProtocol {
    func menuView(menuVie: XHMenuScrollView, index: Int)
}


class XHMenuScrollView: UIScrollView {
    let labelMargin: CGFloat = 10.0
    var textWidth: CGFloat = 0.0
    var indicatorHeight: CGFloat = 2.0  // 下划线高度
    var titleLabel = UILabel()
    var labelX: CGFloat = 0.0
    var labelY: CGFloat = 0.0
    var _selectedLabel = UILabel()
    
    var isLoading: Bool = false
    
    // 存label 数组
    public var titleLabelArray = [UILabel]()

    weak var menuDelegate : XHMenuDelegate?
    // 标题数组
    var _titleArray = [String]()
    var titleArray : [String] {
        get {
            _titleArray
        }
        set {
            _titleArray = newValue
        }
    }
    // 默认字体颜色
    var _normalTextColor : UIColor = .lightGray
    var normalTextColor : UIColor {
        get {
            _normalTextColor
        }
        set {
            _normalTextColor = newValue
        }
    }
    // 选中字体颜色
    var _selectedTextColor : UIColor = .orange
    var selectedTextColor : UIColor {
        get {
            _selectedTextColor
        }
        set {
            _selectedTextColor = newValue
        }
    }
    
    init(frame: CGRect, normalTextColor: UIColor, selectTextColor: UIColor) {
        super.init(frame: frame)
        self.normalTextColor = normalTextColor
        self.selectedTextColor = selectTextColor
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.backgroundColor = .clear
        self.alwaysBounceVertical = false
        self.alwaysBounceHorizontal = false  //允许水平拖拽到边缘时反弹

        // scrollview 偏移需要设置 VC.automaticallyAdjustsScrollViewInsets 为 false

        if #available(iOS 11.0, *) {
            self.contentInsetAdjustmentBehavior = .never
        } else {
            // Fallback on earlier versions
            
        }
        
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        if !isLoading {
            
            for index in 0..<_titleArray.count {
                let title = _titleArray[index]
                let labelWidth = title.boundingSize(CGSize(width: CGFloat.greatestFiniteMagnitude, height: (self.frame.size.height - indicatorHeight)), textFont: UIFont.systemFont(ofSize: 14)).width
                self.textWidth += labelWidth + 2 * labelMargin
            }
            for index in 0..<_titleArray.count {
                let title = _titleArray[index]
                let labelWidth = title.boundingSize(CGSize(width: CGFloat.greatestFiniteMagnitude, height: (self.frame.size.height - indicatorHeight)), textFont: UIFont.systemFont(ofSize: 14)).width
                
                self.titleLabel = UILabel()
                titleLabel.isUserInteractionEnabled = true
                titleLabel.text = title
                titleLabel.textAlignment = .center
                titleLabel.font = UIFont.systemFont(ofSize: 14.0)
                titleLabel.tag = index
                titleLabel.textColor = self.normalTextColor
                titleLabel.highlightedTextColor = self.selectedTextColor
                if self.textWidth < self.frame.size.width {
                    let scrollWidth = self.frame.size.width / CGFloat(_titleArray.count)
                    titleLabel.frame = CGRect(x: labelX, y: labelY, width: scrollWidth, height: self.frame.size.height)
                    labelX += scrollWidth
                } else {
                    let labelW = labelWidth + 2 * labelMargin
                    titleLabel.frame = CGRect(x: labelX, y: labelY, width: labelW, height: self.frame.size.height)
                    labelX += labelW
                }
                self.addSubview(titleLabel)
                
                self.titleLabelArray.append(titleLabel)
                
                let tap = UITapGestureRecognizer.init(target: self, action: #selector(scrollTitleDidClick(gesture:)))
                titleLabel.addGestureRecognizer(tap)
                if titleLabel.tag == 0 {
                    self.scrollTitleDidClick(gesture: tap)
                }
            }
            // UIScrollView 的 contentSize
            let scrollViewWidth = self.subviews.last?.frame.maxX
            self.contentSize = CGSize(width: scrollViewWidth!, height: 0.0)
            
            let firstLabel = self.subviews.first
            self.indicationView.center.x = firstLabel!.center.x
            self.indicationView.frame.origin.y = (firstLabel?.frame.maxY)! - 5
            addSubview(self.indicationView)
            isLoading = true
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func scrollTitleDidClick(gesture: UITapGestureRecognizer) {
        let selLabel = gesture.view as! UILabel
        let index = selLabel.tag
        if self.menuDelegate != nil {
            self.menuDelegate!.menuView(menuVie: self, index: index)
        }
        self.titleLabelSelectedHandle(selLabel: selLabel)
    }
    
    /// 处理 Label 选中方法
    /// - Parameter selLabel: <#selLabel description#>
    func titleLabelSelectedHandle(selLabel: UILabel) {
        titleLabelDidDlick(label: selLabel)
        titleLabelDidSelectedCenter(centerLabel: selLabel)
    }
    
    
    /// label 点击选中
    /// - Parameter label: <#label description#>
    func titleLabelDidDlick(label: UILabel) {
        _selectedLabel.isHighlighted = false
        _selectedLabel.textColor = self.normalTextColor
        label.isHighlighted = true
        _selectedLabel = label
        let labelWidth = self._selectedLabel.text!.boundingSize(CGSize(width: CGFloat.greatestFiniteMagnitude, height: (self.frame.size.height - self.indicatorHeight)), textFont: UIFont.systemFont(ofSize: 14)).width
        
        UIView.animate(withDuration: 0.2) {
            self.indicationView.frame.size.width = labelWidth
            self.indicationView.center.x = label.center.x
        }
    }
    
    /// label 居中显示
    /// - Parameter centerLabel: <#centerLabel description#>
    func titleLabelDidSelectedCenter(centerLabel: UILabel) {
        // 计算偏移量
        
        var offsetX = centerLabel.center.x - self.frame.size.width * 0.5
        if offsetX < 0 {
            offsetX = 0
        }
        
        var maxOffsetX = self.contentSize.width - self.frame.size.width
        if maxOffsetX < 0 {
            maxOffsetX = 0
        }
        if offsetX > maxOffsetX {
            offsetX = maxOffsetX
        }
        self.setContentOffset(CGPoint(x: offsetX, y: 0.0), animated: true)
        
    }
    
    func changeIndicationOffset(scrollView: UIScrollView) {
        let value = scrollView.contentOffset.x / scrollView.frame.size.width
        // 防止最左侧滑动偏移
        if value < 0 {
            return
        }
        let leftIndex: Int = Int(value)
        var rightIndex: Int = leftIndex + 1
        
        // 防止滑到最右侧数组越界崩溃
        if Int(rightIndex) >= getTitleLabelArray().count {
            rightIndex = self.getTitleLabelArray().count - 1
        }
        
        let scaleRight: CGFloat = value - CGFloat(leftIndex)
        let scaleLeft: CGFloat = 1 - scaleRight
        
        let leftLabel: UILabel = self.getTitleLabelArray()[leftIndex] as! UILabel
        let rightLabel: UILabel = self.getTitleLabelArray()[rightIndex] as! UILabel
        
        let leftTextSize = leftLabel.text?.boundingSize(CGSize(width: CGFloat.greatestFiniteMagnitude,height: leftLabel.frame.size.height), textFont: leftLabel.font)
        let rightTextSize = rightLabel.text?.boundingSize(CGSize(width: CGFloat.greatestFiniteMagnitude, height: rightLabel.frame.size.height), textFont: rightLabel.font)
        
        leftLabel.textColor = self.normalTextColor
        rightLabel.textColor = self.normalTextColor
        
        if scaleLeft == 1 && scaleRight == 0 {
            return
        }
        
        // 动态跟随
        self.indicationView.center.x = leftLabel.center.x + (rightLabel.center.x - leftLabel.center.x) * CGFloat(scaleRight)
        let scrollWidth = leftTextSize!.width + (CGFloat(rightTextSize!.width) - CGFloat(leftTextSize!.width)) * CGFloat(scaleRight)
        self.indicationView.frame.size.width = scrollWidth
    }
    
    func getTitleLabelArray() -> [AnyObject] {
        var mAry : [AnyObject] = []
        for label in self.subviews {
            if label.isKind(of: UILabel.self) {
                mAry.append(label)
            }
        }
        return mAry
    }

    // MARK: - 指示条
    lazy var indicationView: UIView = {
        let view = UIView.init()
        view.frame.size.width = 30.0
        view.frame.size.height = self.indicatorHeight
        view.layer.cornerRadius = self.indicatorHeight / 2
        view.backgroundColor = .orange
        return view
    }()

}
