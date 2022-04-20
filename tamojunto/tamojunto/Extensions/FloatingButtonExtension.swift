//
//  FloatingButtonExtension.swift
//  tamojunto
//
//  Created by Gustavo Perbone on 20/04/22.
//

import UIKit

extension UIViewController {
    private struct AssociatedKeys {
        static var floatingButton: UIButton?
    }

    var floatingButton: UIButton? {
        get {
            guard let value = objc_getAssociatedObject(self, &AssociatedKeys.floatingButton) as? UIButton else {return nil}
            return value
        }
        set(newValue) {
            objc_setAssociatedObject(self, &AssociatedKeys.floatingButton, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    func addFloatingButton() {
        // Customize your own floating button UI
        let button = UIButton(type: .custom)
        let image = UIImage(systemName: "plus")?.withRenderingMode(.alwaysTemplate)
        button.tintColor = .white
        button.setImage(image, for: .normal)
        button.backgroundColor = UIColor(named: "secondary700")
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 3
        button.layer.shadowOpacity = 0.12
        button.layer.shadowOffset = CGSize(width: 0, height: 1)
        button.sizeToFit()
        let buttonSize = CGRect(x: 160, y: 100, width: 50, height: 50)
        let rect = UIScreen.main.bounds.insetBy(dx: 4 + buttonSize.width / 2, dy: 4 + buttonSize.height / 2)
        button.frame = CGRect(origin: CGPoint(x: rect.maxX - 15, y: rect.maxY - 50), size: CGSize(width: 60, height: 60))

        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.autoresizingMask = []
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.imageEdgeInsets = UIEdgeInsets(top: 19, left: 19, bottom: 19, right: 19)
        view.addSubview(button)
        floatingButton = button
        let panner = UIPanGestureRecognizer(target: self, action: #selector(panDidFire(panner:)))
        floatingButton?.addGestureRecognizer(panner)
        snapButtonToSocket()
    }

    @objc fileprivate func panDidFire(panner: UIPanGestureRecognizer) {
        guard let floatingButton = floatingButton else {return}
        let offset = panner.translation(in: view)
        panner.setTranslation(CGPoint.zero, in: view)
        var center = floatingButton.center
        center.x += offset.x
        center.y += offset.y
        floatingButton.center = center

        if panner.state == .ended || panner.state == .cancelled {
            UIView.animate(withDuration: 0.3) {
                self.snapButtonToSocket()
            }
        }
    }

    fileprivate func snapButtonToSocket() {
        guard let floatingButton = floatingButton else {return}
        var bestSocket = CGPoint.zero
        var distanceToBestSocket = CGFloat.infinity
        let center = floatingButton.center
        for socket in sockets {
            let distance = hypot(center.x - socket.x, center.y - socket.y)
            if distance < distanceToBestSocket {
                distanceToBestSocket = distance
                bestSocket = socket
            }
        }
        floatingButton.center = bestSocket
    }

    fileprivate var sockets: [CGPoint] {
        let buttonSize = floatingButton?.bounds.size ?? CGSize(width: 0, height: 0)
        let rect = view.bounds.insetBy(dx: 4 + buttonSize.width / 2, dy: 4 + buttonSize.height / 2)
        let sockets: [CGPoint] = [
            CGPoint(x: rect.minX + 15, y: rect.minY + 30),
            CGPoint(x: rect.minX + 15, y: rect.maxY - 50),
            CGPoint(x: rect.maxX - 15, y: rect.minY + 30),
            CGPoint(x: rect.maxX - 15, y: rect.maxY - 50)
        ]
        return sockets
    }
    // Custom socket position to hold Y position and snap to horizontal edges.
    // You can snap to any coordinate on screen by setting custom socket positions.
    fileprivate var horizontalSockets: [CGPoint] {
        guard let floatingButton = floatingButton else {return []}
        let buttonSize = floatingButton.bounds.size
        let rect = view.bounds.insetBy(dx: 4 + buttonSize.width / 2, dy: 4 + buttonSize.height / 2)
        let y = min(rect.maxY - 50, max(rect.minY + 30, floatingButton.frame.minY + buttonSize.height / 2))
        let sockets: [CGPoint] = [
            CGPoint(x: rect.minX + 15, y: y),
            CGPoint(x: rect.maxX - 15, y: y)
        ]
        return sockets
    }
}
