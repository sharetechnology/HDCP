//
//  MainViewController.swift
//  HDCP
//
//  Created by 徐琰璋 on 16/1/4.
//  Copyright © 2016年 batonsoft. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController, UITabBarControllerDelegate {

    var hdhm01vc: HDHM01Controller!
    var hdcg01vc: HDCG01Controller!
    var hdgg01vc: HDGG01Controller!
    var hddy01vc: HDDY01Controller!
    var hdct01vc: HDCT01Controller!

    override func viewDidLoad() {

        super.viewDidLoad()
        self.delegate = self
        setupTabBarView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        let userDefualt = UserDefaults.standard;
        let indexString = userDefualt.object(forKey: Constants.HDPushIndex) as? String;
        if (indexString != nil) {
            userDefualt.removeObject(forKey: Constants.HDPushIndex);
            userDefualt.synchronize();
            let index = Int(indexString!);
            self.selectedIndex = index!;
        }
    }

    /**
     *  初始化Tabar
     */
    func setupTabBarView() {


        var navc: UINavigationController!

        /**
        *  首页
        */
        if hdhm01vc == nil {

            hdhm01vc = HDHM01Controller()
            hdhm01vc.tabBarItem = UITabBarItem(title: "菜谱", image: UIImage(named: "tab_icon_off_01")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), selectedImage: UIImage(named: "tab_icon_on_01")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal))
            hdhm01vc.title = "菜谱"
            navc = UINavigationController(rootViewController: hdhm01vc)
            self.addChild(navc)

        }


        /**
        *  逛逛
        */
        if hdgg01vc == nil {

            hdgg01vc = HDGG01Controller()
            hdgg01vc.tabBarItem = UITabBarItem(title: "逛逛", image: UIImage(named: "tab_icon_off_04")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), selectedImage: UIImage(named: "tab_icon_on_04")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal))
            hdgg01vc.title = "逛逛"
            navc = UINavigationController(rootViewController: hdgg01vc)
            self.addChild(navc)

        }

        /**
        *  分类
        */
        if hdcg01vc == nil {

            hdcg01vc = HDCG01Controller()
            hdcg01vc.tabBarItem = UITabBarItem(title: "分类", image: UIImage(named: "tab_icon_off_03")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), selectedImage: UIImage(named: "tab_icon_on_03")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal))
            hdcg01vc.title = "分类"
            navc = UINavigationController(rootViewController: hdcg01vc)
            self.addChild(navc)

        }

        /**
         *  动态
         */

        if hddy01vc == nil {

            hddy01vc = HDDY01Controller()
            hddy01vc.tabBarItem = UITabBarItem(title: "动态", image: UIImage(named: "tab_icon_off_02")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), selectedImage: UIImage(named: "tab_icon_on_02")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal))
            hddy01vc.title = "动态"
            navc = UINavigationController(rootViewController: hddy01vc)
            self.addChild(navc)

        }

        /**
        *  我的
        */
        if hdct01vc == nil {

            hdct01vc = HDCT01Controller()
            hdct01vc.tabBarItem = UITabBarItem(title: "我的", image: UIImage(named: "tab_icon_off_05")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), selectedImage: UIImage(named: "tab_icon_on_05")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal))
            hdct01vc.title = "我的"
            navc = UINavigationController(rootViewController: hdct01vc)
            self.addChild(navc)

        }

    }

    // MARK: - UITabBarController delegate

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {

    }

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {

        /**
        *  双击TabItem添加自动下拉刷新
        */
        let taSelectViewController = tabBarController.selectedViewController

        if taSelectViewController!.isEqual(viewController) {

            let navViewController = viewController as! UINavigationController
            let rootViewController = navViewController.viewControllers[0]

            if rootViewController.isKind(of: HDHM01Controller.classForCoder()) {

                /**
                *  刷新菜谱主页
                */

                NotificationCenter.default.post(name: Notification.Name(rawValue: Constants.HDREFRESHHDHM01), object: nil, userInfo: ["FLAG": Constants.HDREFRESHHDHM01])

            } else if rootViewController.isKind(of: HDGG01Controller.classForCoder()) {

                /**
                *  刷新逛逛主页
                */
                NotificationCenter.default.post(name: Notification.Name(rawValue: Constants.HDREFRESHHDGG01), object: nil, userInfo: ["FLAG": Constants.HDREFRESHHDGG01])
            }

        }

        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
