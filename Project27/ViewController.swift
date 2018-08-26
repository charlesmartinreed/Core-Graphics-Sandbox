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
    
    func drawCheckerboard() {
        //a different way of drawing rectangles is just to fill them directly with your target color
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { (ctx) in
            ctx.cgContext.setFillColor(UIColor.black.cgColor)
            //building the rectangle - every other square is black. Sine we haven't set our renderer to opaque, the non-colored squares will be transparent
            for row in 0..<8 {
                for col in 0..<8 {
                    if (row + col) % 2 == 0 {
                        //skips path/draw work seen before and just fills the rectangle using whatever the current fill color is.
                        ctx.cgContext.fill(CGRect(x: col * 64, y: row * 64, width: 64, height: 64))
                    }
                }
            }
        }
        
        imageView.image = img
    }
    
    func drawRotatedquares() {
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { (ctx) in
            //because the transformation matrix is top left corner of view, we need to mve the transform matrix to the half way point of our image in order to move the rotation point
            ctx.cgContext.translateBy(x: 256, y: 256)
            
            let rotations = 16
            let amount = Double.pi / Double(rotations)
            
            for _ in 0 ..< rotations {
                //we can apply transforms to our context BEFORE drawing
                //transforms are cumulative, that's what makes this code work to create this beautiful square
                ctx.cgContext.rotate(by: CGFloat(amount))
                ctx.cgContext.addRect(CGRect(x: -128, y: -128, width: 256, height: 256))
            }
            
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath()
        }
        
        imageView.image = img
    }
    
    func drawLines() {
        //draws boxes within boxes, always getting smaller
        //adding a line to more or less that same point inside a loop, but the loop rotates the context transform so the line end point moves as well
        //line length slowly decreases, causing space between boxes to shrink
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { (ctx) in
            ctx.cgContext.translateBy(x: 256, y: 256)
            
            var first = true
            var length: CGFloat = 256
            
            for _ in 0 ..< 256 {
                ctx.cgContext.rotate(by: CGFloat.pi / 2)
                
                if first {
                    ctx.cgContext.move(to: CGPoint(x: length, y: 50))
                    first = false
                } else {
                    ctx.cgContext.addLine(to: CGPoint(x: length, y: 50))
                }
                
                length *= 0.99
            }
            
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath()
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
            
        case 2:
            drawCheckerboard()
            
        case 3:
            drawRotatedquares()
            
        case 4:
            drawLines()
            
        default:
            break
        }
    }
    
}

