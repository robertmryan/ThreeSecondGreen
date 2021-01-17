//
//  ThreeSecondCell.swift
//  ThreeSecondGreen
//
//  Created by Robert Ryan on 1/17/21.
//

import UIKit

class ThreeSecondCell: UICollectionViewCell {
    var didTimerFire: ((UICollectionViewCell) -> Void)?

    @IBOutlet private weak var label: UILabel!

    private weak var timer: Timer?

    override func prepareForReuse() {
        cancelTimer()
        label.text = nil
    }

    func configure(for text: String, isGreen: Bool) {
        cancelTimer()
        label.text = text
        label.textColor = isGreen ? .green : .red
    }
    
    func startTimer() {
        timer?.invalidate()
        let timer = Timer(timeInterval: 3, repeats: false) { [weak self] _ in
            guard let self = self else { return }
            self.didTimerFire?(self)
            self.didTimerFire = nil
        }
        RunLoop.main.add(timer, forMode: .common)
        self.timer = timer
    }

    func cancelTimer() {
        self.didTimerFire = nil
        timer?.invalidate()
    }
}
