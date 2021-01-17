//
//  ViewController.swift
//  ThreeSecondGreen
//
//  Created by Robert Ryan on 1/17/21.
//

import UIKit

class ViewController: UICollectionViewController {
    private var threeSecondItems: Set<Int> = []
}

extension ViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1000
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThreeSecondCell", for: indexPath) as! ThreeSecondCell
        let item = indexPath.item
        cell.configure(for: "\(item)", isGreen: threeSecondItems.contains(item))

        return cell
    }
}

extension ViewController {
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard
            let cell = cell as? ThreeSecondCell,
            !threeSecondItems.contains(indexPath.item)
        else { return }

        cell.didTimerFire = { [weak self] cell in
            guard
                let self = self,
                let indexPath = collectionView.indexPath(for: cell)
            else {
                return
            }

            self.threeSecondItems.insert(indexPath.item)
            collectionView.reloadItems(at: [indexPath])
        }
        cell.startTimer()
    }

    override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        (cell as? ThreeSecondCell)?.cancelTimer()
    }
}
