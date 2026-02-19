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

        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in

            let randomValue = Int.random(in: 1...6)

            guard let image = UIImage(named: "dice_sprites/dice\(randomValue)")
            else {
                print("⚠️ Imagen dice_sprites/dice\(randomValue) no encontrada")
                return
            }

            self.image = image

            counter += 1

            if counter >= 10 {
                timer.invalidate()
                if let finalImage = UIImage(named: "dice\(finalValue)") {
                    self.image = finalImage
                }
                completion(finalValue)  // devuelve 1–6
            }
        }
    }
}
