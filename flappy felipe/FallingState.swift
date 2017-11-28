/*
* Copyright (c) 2015 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import SpriteKit
import GameplayKit

class FallingState: GKState {
  unowned let scene: GameScene
  
  let whackAction = SKAction.playSoundFileNamed("whack.wav", waitForCompletion: false)
  let fallingAction = SKAction.playSoundFileNamed("falling.wav", waitForCompletion: false)
  
  init(scene: SKScene) {
    self.scene = scene as! GameScene
    super.init()
  }
  
  override func didEnter(from previousState: GKState?) {
    
    // Screen shake
    let shake = SKAction.screenShakeWithNode(scene.worldNode, amount: CGPoint(x: 0, y: 7.0), oscillations: 10, duration: 1.0)
    scene.worldNode.run(shake)
    
    // Flash
    let whiteNode = SKSpriteNode(color: SKColor.white, size: scene.size)
    whiteNode.position = CGPoint(x: scene.size.width/2, y: scene.size.height/2)
    whiteNode.zPosition = Layer.flash.rawValue
    scene.worldNode.addChild(whiteNode)
    
    whiteNode.run(SKAction.removeFromParentAfterDelay(0.01))
    
    scene.run(SKAction.sequence([whackAction, SKAction.wait(forDuration: 0.1), fallingAction]))
    scene.stopSpawning()
  }
  
  override func isValidNextState(_ stateClass: AnyClass) -> Bool {
    return stateClass is GameOverState.Type
  }
  
  override func update(deltaTime seconds: TimeInterval) {
    
  }
}
