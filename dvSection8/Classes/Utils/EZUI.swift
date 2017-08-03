//
//  EZUIProperties.swift
//  Leaders' Summit
//
//  Created by Erson Jay Mujar on 24/11/2016.
//  Copyright © 2016 section8. All rights reserved.
//

import Foundation
import UIKit

public enum LabelStyle: Int {
    case header = 0
    case content = 1
    case none = 2
}

public enum BackgroundStyle: Int {
    case _default = 0
    case _custom = 1
}

@IBDesignable
class EZLayoutConstraint: NSLayoutConstraint {
    
    @IBInspectable
    //iPhone 4
    var 📱3¨5_constant: CGFloat = 0 {
        didSet {
            if UIScreen.main.bounds.maxY == 480 {
                constant = 📱3¨5_constant
            }
        }
    }
    
    //iPhone 5, 5C, 5S, iPod Touch 5g,SE
    @IBInspectable
    var 📱4¨0_constant: CGFloat = 0 {
        didSet {
            if UIScreen.main.bounds.maxY == 568 {
                constant = 📱4¨0_constant
            }
        }
    }
    
    //iPhone 6, iPhone 6s, iPhone 7
    @IBInspectable
    var 📱4¨7_constant: CGFloat = 0 {
        didSet {
            if UIScreen.main.bounds.maxY == 667 {
                constant = 📱4¨7_constant
            }
        }
    }
    
    //Phone 6 Plus, iPhone 6s Plus, iPhone 7 Plus
    @IBInspectable
    var 📱5¨5_constant: CGFloat = 0 {
        didSet {
            if UIScreen.main.bounds.maxY == 736 {
                constant = 📱5¨5_constant
            }
        }
    }
}

@IBDesignable
class EZUILabel: UILabel {

    @IBInspectable
    var 📱3¨5_fontSize: CGFloat {
        get {
            return font.pointSize
        }
        set {
            if UIScreen.main.bounds.maxY == 480 {
                font = font.withSize(newValue)
            }
        }
    }
    
    @IBInspectable
    var 📱4¨0_fontSize: CGFloat {
        get {
            return font.pointSize
        }
        set {
            if UIScreen.main.bounds.maxY == 568 {
                font = font.withSize(newValue)
            }
        }
    }
    
    @IBInspectable
    var 📱4¨7_fontSize: CGFloat {
        get {
            return font.pointSize
        }
        set {
            if UIScreen.main.bounds.maxY == 667 {
                font = font.withSize(newValue)
            }
        }
    }
    
    @IBInspectable
    var 📱5¨5_fontSize: CGFloat{
        get {
            return font.pointSize
        }
        set {
            if UIScreen.main.bounds.maxY == 736 {
                font = font.withSize(newValue)
            }
        }
    }
    
    var style: LabelStyle = .none
    
    @IBInspectable var labelStyle:Int {
        get {
            return self.style.rawValue
        }
        set( labelStyleIndex) {
            self.style = LabelStyle(rawValue: labelStyleIndex) ?? .none
        }
    }
    
    dynamic var headerStyleColor: UIColor {
        get { return self.textColor }
        set {
            if style == .header {
                self.textColor = newValue
            }
        }
    }
    
    dynamic var contentStyleColor: UIColor {
        get { return self.textColor }
        set {
            if style == .content {
                self.textColor = newValue
            }
        }
    }
}

@IBDesignable
open class EZUIImageView: UIImageView {
    
    fileprivate var isCircular: Bool = false
    
    @IBInspectable
    var cornerRadius:CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable
    var makeCircular: Bool {
        set {
            isCircular = newValue
            if isCircular {
                self.cornerRadius = self.frame.size.width/2
            }else{
                self.cornerRadius = 0
            }
        }
        get {
            return isCircular
        }
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        if isCircular {
            makeCircular = true
        }
    }
}

@IBDesignable
class EZUIButton: UIButton {
    
    fileprivate var isRounded: Bool = false
    
    @IBInspectable
    var cornerRadius:CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable
    var 📱3¨5_fontSize: CGFloat {
        get {
            return (titleLabel?.font.pointSize)!
        }
        set {
            if UIScreen.main.bounds.maxY == 480 {
                titleLabel?.font = titleLabel?.font.withSize(newValue)
            }
        }
    }
    
    @IBInspectable
    var 📱4¨0_fontSize: CGFloat {
        get {
            return (titleLabel?.font.pointSize)!
        }
        set {
            if UIScreen.main.bounds.maxY == 568 {
                titleLabel?.font = titleLabel?.font.withSize(newValue)
            }
        }
    }
    
    @IBInspectable
    var 📱4¨7_fontSize: CGFloat {
        get {
            return (titleLabel?.font.pointSize)!
        }
        set {
            if UIScreen.main.bounds.maxY == 667 {
                titleLabel?.font = titleLabel?.font.withSize(newValue)
            }
        }
    }
    
    @IBInspectable
    var 📱5¨5_fontSize: CGFloat {
        get {
            return (titleLabel?.font.pointSize)!
        }
        set {
            if UIScreen.main.bounds.maxY == 736 {
                titleLabel?.font = titleLabel?.font.withSize(newValue)
            }
        }
    }
    
    @IBInspectable
    var makeCornersRounded: Bool {
        set {
            self.isRounded = newValue
            if isRounded {
                self.cornerRadius = self.frame.size.height/2
            }else{
                self.cornerRadius = 0
            }
        }
        get {
            return self.isRounded
        }
    }
    
    func setBackgroundColor(color: UIColor, forState: UIControlState) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.setBackgroundImage(colorImage, for: forState)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if makeCornersRounded {
            makeCornersRounded = true
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    var style: LabelStyle = .none
    var bgStyle: BackgroundStyle = ._default
    
    @IBInspectable var labelStyle:Int {
        get {
            return self.style.rawValue
        }
        set( labelStyleIndex) {
            self.style = LabelStyle(rawValue: labelStyleIndex) ?? .none
        }
    }
    
    @IBInspectable var backgroundStyle:Int {
        get { return self.bgStyle.rawValue }
        set ( bgStyleIndex ) {
            self.bgStyle = BackgroundStyle(rawValue: bgStyleIndex) ?? ._default
        }
    }
    
    dynamic var headerStyleColor: UIColor? {
        get { return self.titleColor(for: .normal) }
        set {
            if style == .header {
                self.setTitleColor(newValue, for: .normal)
            }
        }
    }
    
    dynamic var contentStyleColor: UIColor? {
        get { return self.titleColor(for: .normal) }
        set {
            if style == .content {
                self.setTitleColor(newValue, for: .normal)
            }
        }
    }
    
    dynamic var defaultBgStyleColor: UIColor? {
        get { return self.backgroundColor }
        set {
            if bgStyle == ._default {
                self.backgroundColor = newValue
            }
        }
    }
}

@IBDesignable
class EZUIView: UIView {
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}

@IBDesignable
class EZUITextView: UITextView {
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    var style: LabelStyle = .none
    
    @IBInspectable var labelStyle:Int {
        get {
            return self.style.rawValue
        }
        set( labelStyleIndex) {
            self.style = LabelStyle(rawValue: labelStyleIndex) ?? .none
        }
    }
    
    dynamic var headerStyleColor: UIColor? {
        get { return self.textColor }
        set {
            if style == .header {
                self.textColor = newValue
            }
        }
    }
    
    dynamic var contentStyleColor: UIColor? {
        get { return self.textColor }
        set {
            if style == .content {
                self.textColor = newValue
            }
        }
    }
}

@objc public protocol EZUITextFieldDelegate {
    @objc optional func textFieldDidBackSpace(textField:EZUITextField)
}

@IBDesignable
open class EZUITextField: UITextField {
    
    @IBInspectable
    var 📱3¨5_fontSize: CGFloat {
        get {
            return (font?.pointSize)!
        }
        set {
            if UIScreen.main.bounds.maxY == 480 {
                font = font?.withSize(newValue)
            }
        }
    }
    
    @IBInspectable
    var 📱4¨0_fontSize: CGFloat {
        get {
            return (font?.pointSize)!
        }
        set {
            if UIScreen.main.bounds.maxY == 568 {
                font = font?.withSize(newValue)
            }
        }
    }
    
    @IBInspectable
    var 📱4¨7_fontSize: CGFloat {
        get {
            return (font?.pointSize)!
        }
        set {
            if UIScreen.main.bounds.maxY == 667 {
                font = font?.withSize(newValue)
            }
        }
    }
    
    @IBInspectable
    var 📱5¨5_fontSize: CGFloat {
        get {
            return (font?.pointSize)!
        }
        set {
            if UIScreen.main.bounds.maxY == 736 {
                font = font?.withSize(newValue)
            }
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    open var ezDelegate:EZUITextFieldDelegate?
    
    open override func deleteBackward() {
        super.deleteBackward()
        self.ezDelegate?.textFieldDidBackSpace?(textField: self)
    }
    
    var style: LabelStyle = .none
    
    @IBInspectable var labelStyle:Int {
        get {
            return self.style.rawValue
        }
        set( labelStyleIndex) {
            self.style = LabelStyle(rawValue: labelStyleIndex) ?? .none
        }
    }
    
    dynamic var headerStyleColor: UIColor? {
        get { return self.textColor }
        set {
            if style == .header {
                self.textColor = newValue
                self.tintColor = newValue
            }
        }
    }
    
    dynamic var contentStyleColor: UIColor? {
        get { return self.textColor }
        set {
            if style == .content {
                self.textColor = newValue
                self.tintColor = newValue
            }
        }
    }
}

@available(iOS 9.0, *)
@IBDesignable
open class EZUIStackView: UIStackView {
    
    @IBInspectable
    //iPhone 4
    var 📱3¨5_spacing: CGFloat = 0 {
        didSet {
            if UIScreen.main.bounds.maxY == 480 {
                spacing = 📱3¨5_spacing
            }
        }
    }
    
    //iPhone 5, 5C, 5S, iPod Touch 5g,SE
    @IBInspectable
    var 📱4¨0_spacing: CGFloat = 0 {
        didSet {
            if UIScreen.main.bounds.maxY == 568 {
                spacing = 📱4¨0_spacing
            }
        }
    }
    
    //iPhone 6, iPhone 6s, iPhone 7
    @IBInspectable
    var 📱4¨7_spacing: CGFloat = 0 {
        didSet {
            if UIScreen.main.bounds.maxY == 667 {
                spacing = 📱4¨7_spacing
            }
        }
    }
    
    //Phone 6 Plus, iPhone 6s Plus, iPhone 7 Plus
    @IBInspectable
    var 📱5¨5_spacing: CGFloat = 0 {
        didSet {
            if UIScreen.main.bounds.maxY == 736 {
                spacing = 📱5¨5_spacing
            }
        }
    }
    
}

extension UILabel {
    
    func addImage(named: String, afterLabel: Bool = false) {
        let attachment: NSTextAttachment = NSTextAttachment()
        attachment.image = UIImage(named: named)
        let attachmentString: NSAttributedString = NSAttributedString(attachment: attachment)
        
        if afterLabel {
            let strLabelText: NSMutableAttributedString = NSMutableAttributedString(string: self.text!)
            strLabelText.append(attachmentString)
            self.attributedText = strLabelText
        }else {
            let strLabelText: NSAttributedString = NSAttributedString(string: self.text!)
            let mutableAttachmentString: NSMutableAttributedString = NSMutableAttributedString(attributedString: attachmentString)
            mutableAttachmentString.append(strLabelText)
            self.attributedText = mutableAttachmentString
        }
    }
}

extension UIColor {
    
    class func hexStringToUIColor (hex:String) -> UIColor {
        
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

class EZCheckbox: UIButton {
    
    var radioMode : Bool = false
    var onImage : UIImage?
    var offImage : UIImage?
    var onBgColor : UIColor?
    var offBgColor : UIColor?
    var onTextColor : UIColor?
    var offTextColor : UIColor?
    
    var payload : AnyObject?
    
    private var _isOn = false
    private var originalAlpha : CGFloat = 1.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        originalAlpha = self.alpha
    }
    
    var isOn : Bool {
        get {
            return _isOn
        }
        
        set (v) {
            _isOn = v
            if _isOn {
                setTitleColor(onTextColor, for: UIControlState())
                setImage(onImage, for: UIControlState())
                backgroundColor = onBgColor
            } else {
                setTitleColor(offTextColor, for: UIControlState())
                setImage(offImage, for: UIControlState())
                backgroundColor = offBgColor
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.alpha = 0.9
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.alpha = originalAlpha
        
        if touches.count >= 1 {
            let touch : UITouch = touches.first! as UITouch
            if self.frame.contains(touch.location(in: self.superview)) == false || touch.tapCount > 1{
                if radioMode == true {
                    isOn = !_isOn
                }
                super.touchesEnded(touches, with: event)
                return
            }
        }
        
        if radioMode == true {
            isOn = !_isOn
        }
        super.touchesEnded(touches, with: event)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        self.alpha = originalAlpha
    }
}

extension UINavigationBar {
    
    func hideBottomHairline() {
        let navigationBarImageView = hairlineImageViewInNavigationBar(self)
        navigationBarImageView?.isHidden = true
    }
    
    func showBottomHairline() {
        let navigationBarImageView = hairlineImageViewInNavigationBar(self)
        navigationBarImageView?.isHidden = false
    }
    
    fileprivate func hairlineImageViewInNavigationBar(_ view: UIView) -> UIImageView? {
        if let view  = view as? UIImageView, view.bounds.size.height <= 1.0 {
            return view
        }
        
        let subviews = (view.subviews as [UIView])
        for subview: UIView in subviews {
            if let imageView: UIImageView = hairlineImageViewInNavigationBar(subview) {
                return imageView
            }
        }
        
        return nil
    }
    
    func makeTransparent() {
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
        self.isTranslucent = true
    }
}

extension UIView {
    
    func addTopBorderWithColor(color: UIColor, width: CGFloat) -> CALayer {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
        return border
    }
    
    func addRightBorderWithColor(color: UIColor, width: CGFloat) -> CALayer {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: self.frame.size.width - width, y: 0, width: width, height: self.frame.size.height)
        self.layer.addSublayer(border)
        return border
    }
    
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) -> CALayer {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
        return border
    }
    
    func addLeftBorderWithColor(color: UIColor, width: CGFloat) -> CALayer {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
        self.layer.addSublayer(border)
        return border
    }
}

@IBDesignable class InsetLabel: UILabel {
    @IBInspectable var topInset: CGFloat = 0.0
    @IBInspectable var leftInset: CGFloat = 0.0
    @IBInspectable var bottomInset: CGFloat = 0.0
    @IBInspectable var rightInset: CGFloat = 0.0
    
    var insets: UIEdgeInsets {
        get {
            return UIEdgeInsetsMake(topInset, leftInset, bottomInset, rightInset)
        }
        set {
            topInset = newValue.top
            leftInset = newValue.left
            bottomInset = newValue.bottom
            rightInset = newValue.right
        }
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var adjSize = super.sizeThatFits(size)
        adjSize.width += leftInset + rightInset
        adjSize.height += topInset + bottomInset
        
        return adjSize
    }
    
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.width += leftInset + rightInset
        contentSize.height += topInset + bottomInset
        
        return contentSize
    }
}
