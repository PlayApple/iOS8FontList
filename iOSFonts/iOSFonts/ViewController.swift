//
//  ViewController.swift
//  iOSFonts
//
//  Created by LiuYanghui on 14/10/20.
//  Copyright (c) 2014年 LiuYanghui. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate{
    var tableView: UITableView!
    var showText: String! = ""
    var fontFamilyNames:[AnyObject]! = [AnyObject]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // data
        showText = "Hello World 中文样式 0123456789";
        fontFamilyNames = UIFont.familyNames()
        fontFamilyNames.sort({(s1:AnyObject, s2:AnyObject) -> Bool in return s2 as String > s1 as String})
        
        self.title = "Font List"
        let navRightBtn = UIBarButtonItem(title: "Input", style: UIBarButtonItemStyle.Bordered, target: self, action: Selector("onRightNavButtonClick"))
        self.navigationItem.rightBarButtonItem = navRightBtn
        
        tableView = UITableView(frame: self.view.bounds, style: UITableViewStyle.Grouped)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return fontFamilyNames.count
    }
    
    func sectionIndexTitlesForTableView(tableView: UITableView) -> [AnyObject]! {
        var list:[AnyObject]! = [AnyObject]()
        for familyName in fontFamilyNames {
            let str: String = familyName as String
            let index = advance(str.startIndex, 1)
            list.append(str.substringToIndex(index))
        }
        return list
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let fontNames = fontNamesOfSection(section)
        var count = 0
        if let _fontNames = fontNames {
            count = _fontNames.count
        }
        return count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellId = "cellID"
        var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellId) as? UITableViewCell
        if let _cell = cell {
        
        }else {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: cellId)
        }
        
        let fontName: String! = fontNameOfIndexPath(indexPath)
        cell?.textLabel?.text = showText
        cell?.textLabel?.font = UIFont(name: fontName, size: 15)
        cell?.detailTextLabel?.text = fontName
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return fontFamilyNames[section] as? String
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let fontName = fontNameOfIndexPath(indexPath)
        if fontName == "Zapfino" {
            return 80
        }
        return 50
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func onRightNavButtonClick()
    {
        println("onRightNavButtonClick-->")
        
        let dialog = UIAlertView(title: "输入文字预览字体", message: "", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "确定")
        dialog.alertViewStyle = UIAlertViewStyle.PlainTextInput
        dialog.textFieldAtIndex(0)?.text = showText
        dialog.show()
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if (buttonIndex == 1) {
            showText = alertView.textFieldAtIndex(0)?.text
            tableView.reloadData()
        }
    }
    
    private func fontNamesOfSection(section: Int) -> [AnyObject]?
    {
        if let _fontFamilynames = fontFamilyNames {
            if section < _fontFamilynames.count {
                let familyName = _fontFamilynames[section] as String
                return UIFont.fontNamesForFamilyName(familyName)
            }
        }
        return nil
    }
    
    private func fontNameOfIndexPath(indexPath: NSIndexPath) -> String?
    {
        var fontNames = fontNamesOfSection(indexPath.section)
        if let _fontNames = fontNames {
            if indexPath.row < _fontNames.count {
                return _fontNames[indexPath.row] as? String
            }
        }
        return nil
    }
    
    private func logAllFonts()
    {
        let familyNames = UIFont.familyNames()
        for familyName in familyNames {
            println("============================")
            println("familyName:\(familyName)")
            let fontNames = UIFont.fontNamesForFamilyName(familyName as String)
            for fontName in fontNames {
                println("fontName:\(fontName)")
            }
        }
    }
}

