//
//  TrackingButton.swift
//  EyeTrackingTest
//
//  Created by Duncan Lewis on 11/6/18.
//  Copyright © 2018 WillowTree. All rights reserved.
//

import UIKit


class TrackingButton: UIButton, TrackableWidget, CircularAnimatable {
    var id: Int?
    var parent: TrackableWidget?
    
    lazy var animationView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.animatingColor
        self.addSubview(view)
        self.sendSubviewToBack(view)
        return view
    }()
    
    var animationViewSizeRatio: CGFloat {
        return 4.0 / 3.0
    }
    
    var shouldAnimate = false
    
    func add(to engine: TrackingEngine) {
        engine.registerView(self)
    }

    private var _onGaze: ((Int?) -> Void)?
    var onGaze: ((Int?) -> Void)? {
        get {
            if self._onGaze == nil { return self.parent?.onGaze }
            return self._onGaze
            
        }
        set {
            self._onGaze = newValue
        }
    }
}
