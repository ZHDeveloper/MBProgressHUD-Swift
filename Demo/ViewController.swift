//
//  ViewController.swift
//  Demo
//
//  Created by ZhiHua Shen on 2017/7/13.
//  Copyright © 2017年 ZhiHua Shen. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            showWaiting("please waiting")
//            showWaiting("please waiting", detail: "I am request from network")
            hideHUD(true, afterDelay: 1.5)
        }
        else if indexPath.row == 1 {
            loadingExample(progress: 0.0)
        }
        else if indexPath.row == 2 {
            let offset = UIScreen.main.bounds.size.height * 0.5 - 150
            showToast("java.io.ObjectInputStream$PeekInputStream.readFully(ObjectInputStream.java:2281)", offset: offset, hideAfter: 1.5)
        }
        else if indexPath.row == 3 {
            showSuccess("LoginSuccess", hideAfter: 1.5)
        }
        else if indexPath.row == 4 {
            showInfo("DetailInfo", detail: "", hideAfter: 1.5)
        }
        else if indexPath.row == 5 {
            var info: [AnyHashable: Any] = [:]
            info[NSLocalizedDescriptionKey] = "RequestError"
//            info[NSLocalizedDescriptionKey] = "java.io.ObjectInputStream$PeekInputStream.readFully(ObjectInputStream.java:2281)"
            let error = NSError(domain: "error", code: 404, userInfo: info)
            /// it will show toast style while text's width more than 120
            showError(error)
        }
        
    }
    
    func loadingExample(progress: Float) {
        
//        let str = String(format: "%.2lf%%", progress * 100)
//        showLoading(progress: progress, text: "uploading", detail: str)
        
        showLoading(progress: progress, text: "uploading")
        
        if progress < 1 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.loadingExample(progress: progress+0.003)
            }
        }
        else {
            hideHUD(true)
        }
    }
    
    func errorExample() {
        var info: [AnyHashable: Any] = [:]
        info[NSLocalizedDescriptionKey] = "自定义错误信息自定义错误信息自定义错误信息"
        let error = NSError(domain: "error", code: 404, userInfo: info)
        
        showError(error)
    }

}

