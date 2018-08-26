//
//  ViewController.swift
//  Project27
//
//  Created by Charles Martin Reed on 8/26/18.
//  Copyright © 2018 Charles Martin Reed. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    //MARK: - PROPERTIES
    var currentDrawType = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawRectangle()
    }

    //MARK:- Drawing functions
    func drawRectangle() {
        
        //UIGraphicsImageRenderer is part of UIKit, and bridges to and from Core Graphcs
        //a renderer object and renderer context is used
        //a context is the canvas we draw upon AND it stores information about how we draw, like line thickness, etc.
        //a render lets you specify how big it is, its opaqueness, @1x, @2x, @3x pixel-point scale...
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512)) //default scale, scales with device
        
        //renders use closures to excute your drawing code in the background, without locking up the UI
        let img = renderer.image { (ctx) in
            //create a CGRect with the rect bounds, set the context fill color to red and stroke color to black, set context's line drawing width to be 10 points, add rect path to context AND draw that path.
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512)
            
            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10) //5 on the inside, 5 on the outside of rect
            
            ctx.cgContext.addRect(rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
            
        }
        
        //add our canvas to the imageView to be seen by the user
        imageView.image = img
    }
    
    func drawCircle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { (ctx) in
            //clipped image fix, indents by 5 points on each side
            let rectangle = CGRect(x: 5, y: 5, width: 502, height: 502)
            
            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)
            
            ctx.cgContext.addEllipse(in: rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        
        }
        
        imageView.image = img
    }
    
    @IBAction func redrawTapped(_ sender: Any) {
        //+=1 to the currentDrawType, set to 0 when it reaches a certain point
        //use switch/case on the property to determine which method to call
        
        currentDrawType += 1
        
        if currentDrawType > 5 {
            currentDrawType = 0
        }
        
        switch currentDrawType {
        case 0:
            drawRectangle()
            
        case 1:
            drawCircle()
            
        default:
            break
        }
    }
    
}

