//
//  Sprites.swift
//  AppExamen-iOS
//
//  Created by Tardes on 19/2/26.
//

import UIKit

extension UIImageView {
    func rollDice(completion: @escaping (Int) -> Void) {

        let finalValue = Int.random(in: 1...6)
        var counter = 0

        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) {
            timer in

            let randomValue = Int.random(in: 1...6)
            self.image = UIImage(named: "dice\(randomValue)")

            counter += 1

            if counter >= 10 {
                timer.invalidate()
                self.image = UIImage(named: "dice\(finalValue)")
                completion(finalValue - 1)
            }
        }
    }
}
