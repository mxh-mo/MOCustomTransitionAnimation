//
//  MOPushOrPresentAnimator.swift
//  MOCustomTransitionAnimation
//
//  Created by mikimo on 2022/11/26.
//  Copyright © 2022 mikimo. All rights reserved.
//

import UIKit

class MOPushOrPresentAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    /// 返回动画时长
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    /// 转场动画
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        moPrint(self, #line, "push or present animateTransition")
        
        // 1. get data for animation (获取动画需要的数据)
        let containerView = transitionContext.containerView
        guard let toVC = transitionContext.viewController(forKey: .to) else {
            moPrint(self, #line, "toVC is nil")
            return
        }
        guard let toView = transitionContext.view(forKey: .to) else {
            moPrint(self, #line, "toView is nil")
            return
        }
        
        // 2. calculate the value what you want (计算初始位置+最终位置)
        let containerFrame = containerView.frame;
        var toViewInitialFrame = transitionContext.initialFrame(for: toVC)
        let toViewFinalFrame = transitionContext.finalFrame(for: toVC)
        
        toViewInitialFrame.origin.x = containerFrame.size.width;
        toViewInitialFrame.origin.y = containerFrame.size.height;

        // 3. Add do toView to the contenerView, and set the initial value (添加 toView 到 contianerView 上, 并设置初始值）
        containerView.addSubview(toView)
        toView.frame = toViewInitialFrame;
        
        // 4. execute animation 执行动画
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext)) {
            // 5.1 set final frame for animation view
            toView.frame = toViewFinalFrame

        } completion: { finish in
            // 5.2 get animation result
            let success = !transitionContext.transitionWasCancelled
            // 5.2.1 remove the view after animation finish
            if !success {
                toView.removeFromSuperview()
            }
            transitionContext.completeTransition(success)
        }
    }
    
    /// 动画结束回调
    func animationEnded(_ transitionCompleted: Bool) {
        moPrint(self, #line, "animationEnded completed: \(transitionCompleted)")
    }
}
