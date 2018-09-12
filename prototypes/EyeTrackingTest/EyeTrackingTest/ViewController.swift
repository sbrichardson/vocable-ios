//
//  ViewController.swift
//  EyeTrackingTest
//
//  Created by Duncan Lewis on 6/14/18.
//  Copyright © 2018 WillowTree. All rights reserved.
//

import UIKit
import SceneKit
import ARKit


class ViewController: UIViewController, ARSCNViewDelegate {

    var showDebug: Bool = true {
        didSet {
            self.configureUI()
        }
    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            self.showDebug = !self.showDebug
        }
    }


    // MARK: - Demo Interface

    @IBOutlet var buttonStackView: UIStackView!
    @IBOutlet var buttons: [UIButton]!
    var animatorsForButtons: [UIButton: UIViewPropertyAnimator] = [:]

    func updateButtonHighlightForTrackingPosition() {

        for button in self.buttons {
            if button.hitTest(self.view.convert(self.trackingView.center, to: button), with: nil) != nil {
                button.isHighlighted = true

                let animator: UIViewPropertyAnimator
                if let a = animatorsForButtons[button] {
                    animator = a
                } else {
                    let springParams = UISpringTimingParameters(dampingRatio: 1.0)
                    animator = UIViewPropertyAnimator(duration: 0.0, timingParameters: springParams)
                    animatorsForButtons[button] = animator
                }

                animator.stopAnimation(true)
                animator.addAnimations {
                    button.transform = CGAffineTransform(scaleX: 0.87, y: 0.87)
                }
                animator.startAnimation()

            } else {
                button.isHighlighted = false

                if let animator = animatorsForButtons[button] {
                    animator.stopAnimation(true)
                    animator.addAnimations {
                        button.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                    }
                    animator.startAnimation()
                }
            }
        }
    }

    func configureUI() {
        self.buttonStackView.isHidden = self.showDebug
        self.screenTrackingViewController.showDebug = self.showDebug
    }


    // MARK: - View Lifecycle

    let trackingView: UIView = UIView()
    let screenTrackingViewController: ScreenTrackingViewController = ScreenTrackingViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.screenTrackingViewController.willMove(toParent: self)
        self.screenTrackingViewController.view.frame = self.view.bounds
        self.screenTrackingViewController.view.autoresizingMask = [ .flexibleWidth, .flexibleHeight ]
        self.view.addSubview(self.screenTrackingViewController.view)
        self.addChild(self.screenTrackingViewController)
        self.screenTrackingViewController.didMove(toParent: self)

        self.view.bringSubviewToFront(self.buttonStackView)

        trackingView.frame = CGRect(x: 0.0, y: 0.0, width: 40, height: 40)
        trackingView.layer.cornerRadius = 20.0
        trackingView.backgroundColor = UIColor.purple.withAlphaComponent(0.8)
        self.view.addSubview(trackingView)

        self.configureUI()
    }


    // MARK: - ARSCNViewDelegate

    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
    }

    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
    }

    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
    }

    // MARK: - Updating Face Intersection

    /*

    func updateTrackingView(with hitTest: SCNHitTestResult?) {
        DispatchQueue.main.async {
            if let hitTest = hitTest {
                if self.trackingView.isHidden {
                    self.trackingView.isHidden = false
                }
                let unitPosition = self.unitPositionInPlane(for: hitTest)
                let screenPosition = self.screenPosition(fromUnitPosition: unitPosition)
                self.trackingView.center = screenPosition

                self.updateButtonHighlightForTrackingPosition()
            } else {
                self.trackingView.isHidden = true
            }
        }
    }
 */

}
