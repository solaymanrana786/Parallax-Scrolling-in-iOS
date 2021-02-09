//
//  ViewController.swift
//  parallax scrolling iOS
//
//  Created by Solayman Rana on 4/2/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var lblTitle: UILabel?
    var offsetValue: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        prepareNavBar()
       
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        parallaxChangeforOffset1(offset: offsetValue)
        parallaxChangeforOffset2(offset: offsetValue)
        
        if #available(iOS 12.0, *) {
            switch traitCollection.userInterfaceStyle {
            case .light, .unspecified:
                // light mode detected
                if offsetValue >= 1 {
                    navigationController?.navigationBar.barStyle = .default
                }
                break
            case .dark:
                // dark mode detected
                if offsetValue <= 1 {
                    prepareNavBar()

                }
                break
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    func prepareNavBar(){
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = .clear
        UIApplication.shared.statusBarView?.backgroundColor = .clear
        navigationController?.navigationBar.barStyle = .blackTranslucent
        let titleAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17 , weight: UIFont.Weight.medium),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        self.navigationController?.navigationBar.titleTextAttributes = titleAttributes
        lblTitle = setMultilineTitle(title: "Parallax \nScrolling")
        lblTitle?.textColor = .white
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.tableView {
            var offset = scrollView.contentOffset.y / 125
            if offset > 1 {
                offset = 1
                parallaxChangeforOffset1(offset: offset)
            }else if offset == 0 {
                navigationController?.navigationBar.barStyle = .blackTranslucent
            }else{
                parallaxChangeforOffset2(offset: offset)
            }
        }
    }
    
    func parallaxChangeforOffset1(offset: CGFloat){
        if #available(iOS 12.0, *) {
            switch traitCollection.userInterfaceStyle {
            case .light, .unspecified:
                // light mode detected
                let color = UIColor(red: 1, green: 1, blue: 1, alpha: offset)
                navigationController?.navigationBar.barStyle = .default
                let titleAttributes = [
                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17 , weight: UIFont.Weight.medium),
                    NSAttributedString.Key.foregroundColor: UIColor.black
                ]
                self.navigationController?.navigationBar.titleTextAttributes = titleAttributes
                lblTitle?.textColor = UIColor(hue: 0, saturation: 0, brightness: 1 - offset, alpha: 1)
//                lblTitle?.text = "Parallax Scrolling"
                UIApplication.shared.statusBarView?.tintColor = color
                UIApplication.shared.statusBarView?.backgroundColor = color
                self.navigationController?.navigationBar.tintColor = UIColor(hue: 0, saturation: 0, brightness: 1 - offset, alpha: 1)
                self.navigationController?.navigationBar.backgroundColor = color
                break
                
            case .dark:
                // dark mode detected
                let color = UIColor(red: 0, green: 0, blue: 0, alpha: offset)
                navigationController?.navigationBar.barStyle = .blackTranslucent
                let titleAttributes = [
                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17 , weight: UIFont.Weight.medium),
                    NSAttributedString.Key.foregroundColor: UIColor.white
                ]
                self.navigationController?.navigationBar.titleTextAttributes = titleAttributes
                lblTitle?.textColor = UIColor(hue: 0, saturation: 0, brightness: offset, alpha: 1)
                UIApplication.shared.statusBarView?.tintColor = color
                UIApplication.shared.statusBarView?.backgroundColor = color
                self.navigationController?.navigationBar.tintColor = UIColor(hue: 0, saturation: 0, brightness: offset, alpha: 1)
                self.navigationController?.navigationBar.backgroundColor = color
                break
            }
        }
    }
    
    func parallaxChangeforOffset2(offset: CGFloat){
        if #available(iOS 12.0, *) {
            switch traitCollection.userInterfaceStyle {
            case .light, .unspecified:
                // light mode detected
                let color = UIColor(red: 1, green: 1, blue: 1, alpha: offset)
                navigationController?.navigationBar.barStyle = .default
                let titleAttributes = [
                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17 , weight: UIFont.Weight.medium),
                    NSAttributedString.Key.foregroundColor: UIColor.white
                ]
                self.navigationController?.navigationBar.titleTextAttributes = titleAttributes
                lblTitle?.textColor = UIColor(hue: 0, saturation: 0, brightness: 1 - offset, alpha: 1)
                UIApplication.shared.statusBarView?.tintColor = color
                UIApplication.shared.statusBarView?.backgroundColor = color
                self.navigationController?.navigationBar.tintColor = UIColor(hue: 0, saturation: 0, brightness: 1 - offset, alpha: 1)
                self.navigationController?.navigationBar.backgroundColor = color
                break
                
            case .dark:
                // dark mode detected
                let color = UIColor(red: 0, green: 0, blue: 0, alpha: offset)
                UIApplication.shared.statusBarView?.backgroundColor = color
                self.navigationController?.navigationBar.backgroundColor = color
                break
            }
        }
    }
    
    func setMultilineTitle(title: String) -> UILabel {
        let lblTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 500, height: 50))
        lblTitle.numberOfLines = 0
        lblTitle.backgroundColor = UIColor.clear
        lblTitle.textAlignment = .center
        lblTitle.font = UIFont.boldSystemFont(ofSize: 15.0)
        lblTitle.text = title
        navigationItem.titleView = lblTitle
        
        return lblTitle
    }
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            tableView.rowHeight = 300
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCellImage") as! TableViewCellImage
            return cell
        }else {
            tableView.rowHeight = 1000
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCellText") as! TableViewCellText
            return cell
        }
    }
}

extension UIApplication {
    var statusBarView: UIView? {
        if #available(iOS 13.0, *) {
            let tag = 38482
            let keyWindow = UIApplication.shared.windows.first
            if let statusBar = keyWindow?.viewWithTag(tag) {
                return statusBar
            } else {
                guard let statusBarFrame = keyWindow?.windowScene?.statusBarManager?.statusBarFrame else {
                    return nil
                }
                let statusBarView = UIView(frame: statusBarFrame)
                statusBarView.tag = tag
                keyWindow?.addSubview(statusBarView)
                return statusBarView
            }
        } else {
            return value(forKey: "statusBar") as? UIView
        }
    }
}
