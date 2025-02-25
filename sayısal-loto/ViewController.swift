//
//  ViewController.swift
//  sayısal-loto
//
//  Created by Alp Melih İlgin on 22.02.2025.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var numberLabel1: UILabel!
    @IBOutlet weak var numberLabel2: UILabel!
    @IBOutlet weak var numberLabel3: UILabel!
    @IBOutlet weak var numberLabel4: UILabel!
    @IBOutlet weak var numberLabel5: UILabel!
    @IBOutlet weak var numberLabel6: UILabel!
    @IBOutlet weak var generateButton: UIButton!
    
    var timer: Timer?
    var elapsedTime = 0.0
    var labels: [UILabel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        labels = [numberLabel1, numberLabel2, numberLabel3, numberLabel4, numberLabel5, numberLabel6]
        
        setupUI()
        startNumberAnimation()
    }

    @IBAction func generateButtonTapped(_ sender: UIButton) {
        startNumberAnimation()
    }
    
    func startNumberAnimation() {
        elapsedTime = 0.0
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            self.elapsedTime += 0.1
            self.updateRandomNumbers()

            if self.elapsedTime >= 3.0 {
                timer.invalidate()
                self.generateFinalNumbers() 
            }
        }
    }
    
    func updateRandomNumbers() {
        for label in labels {
            label.text = "\(Int.random(in: 1...49))"
        }
    }
    
    func generateFinalNumbers() {
        let numbers = generateUniqueNumbers()
        for (index, number) in numbers.enumerated() {
            labels[index].text = "\(number)"
            animateLabel(label: labels[index]) // Animasyon ekle
        }
    }
    
    func generateUniqueNumbers() -> [Int] {
        var numbersSet = Set<Int>()
        while numbersSet.count < 6 {
            let randomNumber = Int.random(in: 1...49)
            numbersSet.insert(randomNumber)
        }
        return Array(numbersSet).sorted()
    }
    
    func animateLabel(label: UILabel) {
        UIView.animate(withDuration: 0.3, animations: {
            label.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
        }) { _ in
            UIView.animate(withDuration: 0.3) {
                label.transform = .identity
            }
        }
    }

    func setupUI() {
        view.backgroundColor = .white
        

        for label in labels {
           
            label.layer.masksToBounds = true
            label.backgroundColor = UIColor.systemYellow
            label.textAlignment = .center
            label.font = UIFont.boldSystemFont(ofSize: 24)
            label.textColor = .white
        }

        if let safeButton = generateButton {
            safeButton.layer.cornerRadius = 12
            safeButton.backgroundColor = .systemBlue
            safeButton.setTitleColor(.white, for: .normal)
            safeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
            safeButton.layer.shadowColor = UIColor.black.cgColor
            safeButton.layer.shadowOpacity = 0.3
            safeButton.layer.shadowOffset = CGSize(width: 2, height: 2)
            safeButton.layer.shadowRadius = 5
        } else {
            print("Hata: generateButton nil!")
        }
    }

}
