//
//  ViewController.swift
//  TicTacToe
//
//  Created by Arvind Venkataraman on 3/11/17.
//  Copyright © 2017 Arvind Venkataraman. All rights reserved.
//

import UIKit

class TicTacToeButton: UIButton {
    var x: NSNumber!
    var y: NSNumber!
}

enum GameState {
    case Incomplete
    case Draw
    case XWins
    case OWins
}

class ViewController: UIViewController {
    
    @IBOutlet var buttons: [TicTacToeButton]!

    var currentUser = 0
    var board = [[Int]](repeating:[Int](repeating: -1, count: 3),count:3)
    var defaultButtonLabelColor: UIColor?

    func getGameState() -> GameState {
        if(board[0][0] != -1 && (board[0][0] == board[0][1] && board[0][1] == board[0][2])) {
            return board[0][0] == 0 ? GameState.XWins : GameState.OWins;
            
        }
        if(board[1][0] != -1 && (board[1][0] == board[1][1] && board[1][1] == board[1][2])) {
            return board[1][0] == 0 ? GameState.XWins : GameState.OWins;
        }
        if(board[2][0] != -1 && (board[2][0] == board[2][1] && board[2][1] == board[2][2])) {
            return board[2][0] == 0 ? GameState.XWins : GameState.OWins;
        }
        
        if(board[0][0] != -1 && (board[0][0] == board[1][0] && board[1][0] == board[2][0])) {
            return board[0][0] == 0 ? GameState.XWins : GameState.OWins;
            
        }
        if(board[0][1] != -1 && (board[0][1] == board[1][1] && board[1][1] == board[2][1])) {
            return board[0][1] == 0 ? GameState.XWins : GameState.OWins;
        }
        if(board[0][2] != -1 && (board[0][2] == board[1][2] && board[1][2] == board[2][2])) {
            return board[0][2] == 0 ? GameState.XWins : GameState.OWins;
        }
        
        if(board[0][0] != -1 && (board[0][0] == board[1][1] && board[1][1] == board[2][2])) {
            return board[0][0] == 0 ? GameState.XWins : GameState.OWins;
        }
        
        if(board[0][2] != -1 && (board[0][2] == board[1][1] && board[1][1] == board[2][0])) {
            return board[0][2] == 0 ? GameState.XWins : GameState.OWins;
        }

        if(board[0].index(of: -1) != nil || board[1].index(of: -1) != nil || board[2].index(of: -1) != nil) {
            return GameState.Incomplete
        }
        
        return GameState.Draw;
    }
    
    func onAlertDismiss(action: UIAlertAction) {
        resetGameState()
    }
    func resetGameState() {
        board = [[Int]](repeating:[Int](repeating: -1, count: 3),count:3)
        currentUser = 0
        for button in buttons {
            button.setTitle("-", for: .normal)
            button.setTitleColor(defaultButtonLabelColor, for: .normal)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        defaultButtonLabelColor = buttons[0].titleColor(for: UIControlState.normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: onAlertDismiss))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func touchButton(_ sender: UIButton) {
        let x = sender.value(forKey: "x") as! Int
        let y = sender.value(forKey: "y") as! Int

        print("Button \(x), \(y) clicked")


        if(board[x][y] == -1) {
            board[x][y] = currentUser;
            let title = (currentUser == 0) ? "X" : "O";
            let color = (currentUser == 0) ? UIColor.red : UIColor.cyan;
            
            sender.setTitle(title, for: UIControlState.normal)
            sender.setTitleColor(color, for: UIControlState.normal)
            
            let gameState = getGameState()
            switch gameState {
                case GameState.Draw:
                    showAlert(title: "Draw", message: "Good game")
                    break
                case GameState.XWins:
                    showAlert(title: "X Wins!", message: "Good job user 1")
                    break
                case GameState.OWins:
                    showAlert(title: "O Win!", message: "Good job user 2")
                    break
                case GameState.Incomplete:
                    print("game goes on")
            }
            currentUser ^= 1;
            print("Board: \(board)")
        } else {
            print("square already taken")
        }
    
    }
}

