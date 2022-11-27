//
//  MOPopOrDismissAnimator.swift
//  MOCustomTransitionAnimation
//
//  Created by mikimo on 2022/11/26.
//  Copyright © 2022 mikimo. All rights reserved.
//

import UIKit

class MOPopOrDismissAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    /// 返回动画时长
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    /// 转场动画
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        moPrint(self, #line, "pop or dismiss animateTransition")
        
        // 1. get data for animation (获取动画需要的数据)
        let containerView = transitionContext.containerView
        guard let fromVC = transitionContext.viewController(forKey: .from) else {
            moPrint(self, #line, "fromVC is nil")
            return
        }
        guard let toVC = transitionContext.viewController(forKey: .to) else {
            moPrint(self, #line, "toVC is nil")
            return
        }
        guard let fromView = transitionContext.view(forKey: .from)else {
            moPrint(self, #line, "fromView is nil")
            return
        }
        // pop 时能拿到 toView
    //        guard let toView = transitionContext.view(forKey: .to)else {
    //            moPrint(self, #line, "toView is nil")
    //            return
    //        }
        // dismiss 时拿不到 toView
        let toView: UIView = transitionContext.view(forKey: .to) ?? UIView(frame: .zero)
        
        moPrint(self, #line, "fromView: \(fromView), toView: \(toView)")
        
        // 2. calculate the value what you want (计算初始位置+最终位置)
        let containerFrame = containerView.frame;
        let toViewStartFrame = transitionContext.initialFrame(for: toVC)
        var fromViewFinalFrame = transitionContext.finalFrame(for: fromVC)
        
        fromViewFinalFrame = CGRect(x: CGRectGetWidth(containerFrame),
                                    y: CGRectGetHeight(containerFrame),
                                    width: CGRectGetWidth(fromView.frame),
                                    height: CGRectGetHeight(fromView.frame))
        
        // 3. Add do toView to the contenerView, and set the initial value (添加 toView 到 contianerView 上, 并设置初始值）
        containerView.addSubview(toView)
        toView.frame = toViewStartFrame;
        
        // 4. execute animation 执行动画
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext)) {
            // 5.1 set final frame for animation view
            fromView.frame = fromViewFinalFrame

        } completion: { finish in
            // 5.2 get animation result
            let success = !transitionContext.transitionWasCancelled
            // 5.2.1 remove the view after animation finish
            if success {
                fromView.removeFromSuperview()
            }
            transitionContext.completeTransition(success)
        }
    }

    /// 动画结束回调
    func animationEnded(_ transitionCompleted: Bool) {
        moPrint(self, #line, "animationEnded completed: \(transitionCompleted)")
    }
}

