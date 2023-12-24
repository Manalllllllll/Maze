//
//  GameScene.swift
//  Maze
//
//  Created by silva on 07/06/1445 AH.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var thePlayer:SKSpriteNode = SKSpriteNode()
    var chompAction:SKAction = SKAction(named:"Chomp")!
    var theCamera:SKCameraNode = SKCameraNode()
    var arrayOfAvailableSpots=[CGPoint]()
    
    override func didMove(to view: SKView) {
        
        for node in self.children{
            if(node is SKTileMapNode){
                if let theMap:SKTileMapNode=node as? SKTileMapNode{
                    setUpSceneWithMap( map: theMap)
                }
            }
        }
        
        if(self.childNode(withName: "Player") != nil ){
            thePlayer = self.childNode(withName: "Player") as! SKSpriteNode
            thePlayer.run(chompAction, withKey: "Chomp")
            
            
        }
        if (self.childNode(withName: "Camera") != nil){
            theCamera=self.childNode(withName: "Camera") as! SKCameraNode
        }
        self.camera = theCamera
    }
    
    func setUpSceneWithMap(map: SKTileMapNode){
        
        let tileMap=map
        let tileSize=tileMap.tileSize
        let halfWidth = CGFloat(tileMap.numberOfColumns)/2.0 * tileSize.width
        let halfHeight = CGFloat(tileMap.numberOfRows)/2.0 * tileSize.height
        for col in 0..<tileMap.numberOfColumns {
            for row in 0..<tileMap.numberOfRows{
                if let _ = tileMap.tileDefinition(atColumn: col, row: row){
                    //a painted tile exists
                }else{
                    // a painted tile does NOT exists here, so our charcter could move to it
                    let x = CGFloat(col) * tileSize.width - halfWidth + (tileSize.width/2)
                    let y = CGFloat(row) * tileSize.height - halfHeight + (tileSize.height/2)
                    print("no tile at \(x), \(y)")
                    let newPoint: CGPoint = CGPoint(x:x, y:y)
                    let newPointConverted:CGPoint = self.convert(newPoint, from: tileMap)
                    arrayOfAvailableSpots.append(newPointConverted)
                    let newNode:SKSpriteNode = SKSpriteNode (imageNamed:"Rectangle")
                   newNode.position = newPointConverted
                    self.addChild(newNode)
                    newNode.name = "Rectangle"
                    
                }
            }
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        theCamera.position = thePlayer.position
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
     
    }
    
    func touchMoved(toPoint pos : CGPoint) {
     
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
      
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    
}
