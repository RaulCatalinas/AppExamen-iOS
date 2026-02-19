//
//  ViewController.swift
//  AppExamen-iOS
//
//  Created by Tardes on 19/2/26.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource,
    UITableViewDelegate
{
    @IBOutlet weak var diceImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var questionLabel: UILabel!

    private var selectedQuestion: TrivialQuestion!
    private var selectedCellByUser: UITableViewCell!
    private var correctTableViewCell: UITableViewCell? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        selectedQuestion = TRIVIAL_QUESTIONS.randomElement()!.value
            .randomElement()!

        questionLabel.text = selectedQuestion.question

        tableView.dataSource = self
        tableView.delegate = self
    }

    @IBAction func rollDice(_ sender: Any) {
        selectedCellByUser.backgroundColor = .clear
        if correctTableViewCell != nil {
            correctTableViewCell!.backgroundColor = .clear
        }

        tableView.allowsSelection = true

        selectedQuestion = TRIVIAL_QUESTIONS.randomElement()!.value
            .randomElement()!

        questionLabel.text = selectedQuestion.question

        tableView.reloadData()

        /*diceImageView.rollDice { [self] result in
            let selectedCategory = TrivialCategory.allCases[result]
        
            selectedQuestion = TRIVIAL_QUESTIONS[selectedCategory]?.randomElement()
        
            tableView.reloadData()
        }*/
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        return selectedQuestion.answers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        let cell =
            tableView.dequeueReusableCell(
                withIdentifier: "trivial_cell",
                for: indexPath
            ) as! TrivailAnswerViewCell

        cell.configure(with: selectedQuestion.answers[indexPath.row].text)

        return cell
    }

    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableView.allowsSelection = false

        let userAnswer = selectedQuestion.answers[indexPath.row]

        guard let cell = tableView.cellForRow(at: indexPath) else {
            print("Cell not found")
            return
        }

        selectedCellByUser = cell

        if userAnswer.isCorrect {
            cell.backgroundColor = .systemGreen
            
            let quiesito = UIView(frame: CGRect(x: cell.frame.width - 40, y: 10, width: 30, height: 30))

            quiesito.backgroundColor = .yellow
            quiesito.layer.cornerRadius = 15  // redondo
            quiesito.layer.borderWidth = 1
            quiesito.layer.borderColor = UIColor.orange.cgColor

            return
        }

        cell.backgroundColor = .systemRed

        // Buscar la respuesta correcta
        let correctIndex = selectedQuestion.answers.firstIndex(where: {
            $0.isCorrect
        })

        guard let correctIndex = correctIndex else { return }

        let correctCell = tableView.cellForRow(
            at: IndexPath(row: correctIndex, section: 0)
        )

        guard let correctCell = correctCell else { return }

        correctCell.backgroundColor = .systemGreen

        correctTableViewCell = correctCell

    }

}
