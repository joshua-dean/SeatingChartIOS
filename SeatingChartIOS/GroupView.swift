//
//  GroupView.swift
//  SeatingChartIOS
//
//  Created by DEAN, JOSHUA on 9/13/16.
//  Copyright © 2016 DEAN, JOSHUA. All rights reserved.
//

import Foundation
import UIKit

class GroupView: UIView
{
    //var frameSize = CGSize(width: 200.0, height: 200.0)
    var currentOffset = (x: CGFloat(0), y: CGFloat(0))
    var subviewArray: [[GroupSubview]] = [] //row, subview
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(rect: CGRect)
    {
        super.init(frame: rect)
        self.frame = rect //test if necessary
        self.setNeedsDisplay(self.frame) //is context necessary? test
        self.backgroundColor = randomUIColor()
        
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(GroupView.tapped(_:)))
        self.addGestureRecognizer(tapGestureRecognizer)
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(GroupView.longPressed(_:)))
        self.addGestureRecognizer(longPressRecognizer)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let currentPoint = touch.location(in: self)
            currentOffset.x = currentPoint.x
            currentOffset.y = currentPoint.y
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            var currentPoint = touch.location(in: self.superview)
            //Swift.print("Current Point = ", currentPoint ,"CurrentOffset = ", currentOffset)
            currentPoint.x -= currentOffset.x
            currentPoint.y -= currentOffset.y
            self.frame = CGRect(origin: currentPoint, size: self.frame.size)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            _ = touch.location(in: self)
        }
    }

    func tapped(_ sender: UITapGestureRecognizer)
    {
        openMenu()
    }
    
    func longPressed(_ sender: UILongPressGestureRecognizer)
    {
        
    }
    
    /*
     MENU STUFF
     */
    func openMenu()
    {
        becomeFirstResponder()
        let menu = UIMenuController.shared

        let deleteItem = UIMenuItem(title: "Terminate", action: #selector(GroupView.deleteSelf))
        
        menu.menuItems = [deleteItem]
        
        menu.setTargetRect(CGRect(x: 0, y: 0, width: 50, height: 0), in: self)
        menu.setMenuVisible(true, animated: true)
    }
    
    override var canBecomeFirstResponder : Bool {
        return true
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool
    {
        if action == #selector(GroupView.deleteSelf)
        {
            return true
        }
        return false
        
    }
    func blankMenuItem()
    {
        //does nothing
    }
    func deleteSelf()
    {
        self.removeFromSuperview()
    }


}