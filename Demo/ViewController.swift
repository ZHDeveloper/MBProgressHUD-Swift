//
//  ViewController.swift
//  Demo
//
//  Created by ZhiHua Shen on 2017/7/13.
//  Copyright © 2017年 ZhiHua Shen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        waitingExample()
        
    }
    
    func waitingExample() {
        navigationController?.showWaiting("正在登陆")
        navigationController?.hideHUD(true, afterDelay: 1.5)
    }
    
    func loadingExample(progress: Float) {
        
        let str = String(format: "%.2lf%%", progress * 100)
        showLoading(progress: progress, text: "正在上传", detail: str)
        
        if progress < 1 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                self.loadingExample(progress: progress+0.003)
            }
        }
        else {
            hideHUD(true, afterDelay: 1.5)
        }
    }
    
    func errorExample() {
        var info: [AnyHashable: Any] = [:]
        info[NSLocalizedDescriptionKey] = "自定义错误信息自定义错误信息自定义错误信息"
        let error = NSError(domain: "error", code: 404, userInfo: info)
        
        showError(error)
    }

}

