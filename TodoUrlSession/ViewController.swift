//
//  ViewController.swift
//  TodoUrlSession
//
//  Created by 김라영 on 2023/03/21.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {
    @IBOutlet weak var pageCnt: UILabel!
    @IBOutlet weak var selectedTodo: UILabel!
    
    @IBOutlet weak var selectedTodoDeleteBtn: UIButton!
    @IBOutlet weak var addTodoBtn: UIButton!
    
    @IBOutlet weak var todoTableView: UITableView!
    var todoListData : BehaviorRelay<[TodoData]> = BehaviorRelay(value: [])
    
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        tableview에 cell등록
        todoTableView.register(TodoCell.uiNib, forCellReuseIdentifier: TodoCell.reuseIdentifier)

        //toddListData를 tableview의 cell에 꽂아주는 과정
        todoListData.bind(to: self.todoTableView.rx.items(cellIdentifier: TodoCell.reuseIdentifier, cellType: TodoCell.self)){ [weak self] index, element, cell in

            guard let self = self else { return }
            cell.todoId.text = String(describing: element.id)
            cell.todoContent.text = String(describing: element.title)
        }
        .disposed(by: disposeBag)
        
        requestTodoListData()
    }
    
    //todoListData를 받아오는 부분
    func requestTodoListData() {
        print(#fileID, #function, #line, "- ")
        
        TodosAPI.fetchTodos { result in
            switch result {
                
            case .success(let todosResponse):
                print(#fileID, #function, #line, "- todosResponse: \(todosResponse)")
                var currentData = self.todoListData.value
                print(#fileID, #function, #line, "- currentData: \(currentData)")
                if let addedTodoData = todosResponse.data {
                    var addedTodoListData = currentData + addedTodoData
                    print(#fileID, #function, #line, "- addedTodoListData: \(addedTodoListData)")
                    self.todoListData.accept(addedTodoData)
                }
                
                self.todoTableView.reloadData()
                
            case .failure(let error):
                print(#fileID, #function, #line, "- error: \(error)")
            }
        }
    }
}

