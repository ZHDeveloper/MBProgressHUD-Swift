//
//  ProgressHUD+Extension.swift
//  Demo
//
//  Created by ZhiHua Shen on 2017/7/13.
//  Copyright © 2017年 ZhiHua Shen. All rights reserved.
//

import UIKit

public enum ProgressHudStatus {
    case success
    case info
    case error
}

public protocol ProgressHudProtocol {
    
    var hudView: MBProgressHUD { get }
    
    func showWaiting(_ text: String?, detail: String?)
    func showLoading(progress: Float, text: String?, detail: String?)
    func showToast(_ text: String, offset: CGFloat, hideAfter: TimeInterval?)
    func showStatus(_ status: ProgressHudStatus, text: String?, detail: String?, hideAfter: TimeInterval?)
    func hideHUD(_ animated: Bool, afterDelay delay: TimeInterval)
}

public extension ProgressHudProtocol {
    
    fileprivate var toView: UIView {
        if self is UIViewController {
            let vc = self as! UIViewController
            return vc.view
        }
        else if self is UIView {
            return self as! UIView
        }
        else {
            return UIApplication.shared.keyWindow!
        }
    }
    
    public var hudView: MBProgressHUD {
        let tag = 9527
        let view = (toView.viewWithTag(tag) as? MBProgressHUD) ?? MBProgressHUD.showHUDAddedTo(toView, animated: true)
        view.tag = tag
        view.xOffset = 0
        view.yOffset = 0
        view.opacity = 0.4
        return view
    }
    
    public func showWaiting(_ text: String? = nil, detail: String? = nil) {
        hudView.mode = .indeterminate
        hudView.labelText = text
        hudView.detailsLabelText = detail
    }
    
    public func showLoading(progress: Float, text: String? = nil, detail: String? = nil) {
        hudView.mode = .annularDeterminate
        hudView.labelText = text
        hudView.detailsLabelText = detail
        hudView.progress = progress
    }
    
    public func showToast(_ text: String, offset: CGFloat = 0, hideAfter delay: TimeInterval? = 2) {
        hudView.mode = .text
        hudView.detailsLabelText = text
        if let delay = delay {
            hudView.hide(true, afterDelay: delay)
        }
        hudView.yOffset = offset
    }
    
    public func showSuccess(_ text: String? = nil, detail: String? = nil, hideAfter delay: TimeInterval? = 2) {
        showStatus(.success, text: text, detail: detail, hideAfter: delay)
    }
    
    /// it will show toast style while text's width more than 120
    public func showError(_ error: Error, hideAfter interval: TimeInterval? = 2) {
        
        let errorDesc = error.localizedDescription
        
        let textSize = MB_MULTILINE_TEXTSIZE(errorDesc, font: hudView.labelFont, maxSize: CGSize(width: Double(HUGE), height: Double(HUGE)), mode: .byWordWrapping)

        if textSize.width > 120 {
            let screenHeight = UIScreen.main.bounds.size.height
            let offset = screenHeight * 0.5 - 150
            showToast(errorDesc, offset: offset, hideAfter: interval)
        }
        else {
            showStatus(.error, text: errorDesc, hideAfter: interval)
        }
    }
    
    public func showInfo(_ text: String? = nil, detail: String? = nil, hideAfter delay: TimeInterval? = 2) {
        showStatus(.info, text: text, detail: detail, hideAfter: delay)
    }
    
    public func showStatus(_ status: ProgressHudStatus, text: String? = nil, detail: String? = nil, hideAfter delay: TimeInterval? = nil) {
        
        hudView.mode = .customView
        
        var imageView: UIImageView!
        
        switch status {
            case .success:
                imageView = UIImageView(image: UIImage(named: "ProgressHUD.bundle/tips_done"))
            case .info:
                imageView = UIImageView(image: UIImage(named: "ProgressHUD.bundle/tips_info"))
            case .error:
                imageView = UIImageView(image: UIImage(named: "ProgressHUD.bundle/tips_error"))
        }
        
        hudView.customView = imageView
        
        hudView.labelText = text
        hudView.detailsLabelText = detail
        
        if let delay = delay {
            hudView.hide(true, afterDelay: delay)
        }
    }
    
    public func hideHUD(_ animated: Bool = true, afterDelay delay: TimeInterval = 0) {
        hudView.hide(animated, afterDelay: delay)
    }
}

extension UIResponder: ProgressHudProtocol {}

