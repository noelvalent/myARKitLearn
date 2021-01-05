//
//  ViewController.swift
//  WorldTracking
//
//  Created by Noel Valentine on 18/04/2019.
//  Copyright © 2019 Noel Valentine. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    let configulation = ARWorldTrackingConfiguration()
    override func viewDidLoad() {
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        self.sceneView.autoenablesDefaultLighting = true
        self.sceneView.session.run(configulation)
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let a: Int = 0 
    }

    @IBAction func add(_ sender: UIButton) {
        
//        let node = SCNNode()
//        let path = UIBezierPath()
//        path.move(to: CGPoint(x: 0, y: 0))
//        path.addLine(to: CGPoint(x: 0, y: 0.2))
//        path.addLine(to: CGPoint(x: 0.2, y: 0.3))
//        path.addLine(to: CGPoint(x: 0.4, y: 0.2))
//        path.addLine(to: CGPoint(x: 0.4, y: 0.0))
//        let shape = SCNShape(path: path, extrusionDepth: 0.2)
//        node.geometry = shape
//        node.geometry?.firstMaterial?.specular.contents = UIColor.blue
//        node.geometry?.firstMaterial?.diffuse.contents = UIColor.red
//        node.position = SCNVector3(0.0,0.0,0.0)
//        self.sceneView.scene.rootNode.addChildNode(node)
        let doorNode = SCNNode(geometry: SCNPlane(width: 0.03, height: 0.06))
        doorNode.geometry?.firstMaterial?.diffuse.contents = UIColor.brown
        let boxNode = SCNNode(geometry: SCNPyramid(width: 0.1, height: 0.1, length: 0.1))
//        let boxNode = SCNNode(geometry: SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0))
        boxNode.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        let node = SCNNode()
        node.geometry = SCNPyramid(width: 0.1, height: 0.1, length: 0.1)
        node.geometry?.firstMaterial?.specular.contents = UIColor.orange
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        node.position = SCNVector3(0.2,0.3,-0.2)
        boxNode.eulerAngles = SCNVector3(Float(180.degreesToRadians), 0, 0)
        boxNode.position = SCNVector3(0, -0.05, 0)
        doorNode.position = SCNVector3(0, -0.02, 0.053)
        self.sceneView.scene.rootNode.addChildNode(node)
        node.addChildNode(boxNode)
        boxNode.addChildNode(doorNode)
        
    }
    
    @IBAction func reset(_ sender: UIButton) {
        self.restartSession()
    }
    func restartSession(){
        self.sceneView.session.pause()
        self.sceneView.scene.rootNode.enumerateChildNodes {
            (node, _) in node.removeFromParentNode()
        }
        self.sceneView.session.run(configulation, options: [.resetTracking, .removeExistingAnchors])
        
    }
    func randomNumbers(firstNumber: CGFloat, secondNumber: CGFloat)->CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNumber - secondNumber) + min(firstNumber, secondNumber)
    }
    
    
}

extension Int{
    var degreesToRadians: Double { return Double(self) * .pi/180 }
}
