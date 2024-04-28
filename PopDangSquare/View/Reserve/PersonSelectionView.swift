//
//  PersonSelectionView.swift
//  PopDangSquare
//
//  Created by 민웅킴 on 4/28/24.
//

import UIKit

class PersonSelectionView: UIView {
    
    var isDisabled: Bool = false // 장애인 여부
    var isTeenager: Bool = false // 청소년 여부
    var isChild: Bool = false // 유아 여부
    
    var selectedNumberOfPeople: Int = 1 // 선택된 인원 수
    
    // UI 요소들
    private var titleLabel: UILabel!
    private var pickerView: UIPickerView!
    
    // 선택 가능한 최소 및 최대 인원 수
    private let minNumberOfPeople = 1
    private let maxNumberOfPeople = 8
    
    // 인원 선택이 완료되었을 때 실행될 클로저
    var didSelectNumberOfPeople: ((Int) -> Void)?
    
    // 초기화 메서드
    init(frame: CGRect, isDisabled: Bool, isTeenager: Bool, isChild: Bool) {
        super.init(frame: frame)
        
        self.isDisabled = isDisabled
        self.isTeenager = isTeenager
        self.isChild = isChild
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // UI 구성
    private func setupUI() {
        // 레이블 설정
        titleLabel = UILabel(frame: CGRect(x: 20, y: 20, width: frame.width - 40, height: 30))
        titleLabel.textAlignment = .center
        titleLabel.text = "인원 선택"
        addSubview(titleLabel)
        
        // 버튼을 생성하여 뷰에 추가합니다.
        let buttonTitles = ["1", "2", "3", "4", "5", "6", "7", "8"]
        let buttonWidth: CGFloat = 50
        let buttonHeight: CGFloat = 30
        let horizontalSpacing: CGFloat = 10
        let verticalSpacing: CGFloat = 10
        let numberOfButtonsPerRow = 8 // 한 줄에 표시할 버튼의 수
        let totalVerticalSpacing = verticalSpacing * CGFloat((buttonTitles.count - 1) / numberOfButtonsPerRow)
        let buttonTotalWidth = buttonWidth * CGFloat(numberOfButtonsPerRow) + horizontalSpacing * CGFloat(numberOfButtonsPerRow - 1)
        let buttonStartX = (frame.width - buttonTotalWidth) / 2 // 중앙 정렬을 위한 시작 X 좌표 계산
        var currentX = buttonStartX
        var currentY: CGFloat = 20 // 버튼의 Y 좌표
        
        for title in buttonTitles {
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.frame = CGRect(x: currentX, y: currentY, width: buttonWidth, height: buttonHeight)
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            addSubview(button)
            
            // 다음 버튼의 X 좌표 계산
            currentX += buttonWidth + horizontalSpacing
            
            // 줄 바꿈 처리
            if currentX >= buttonStartX + buttonTotalWidth {
                currentX = buttonStartX
                currentY += buttonHeight + verticalSpacing
            }
        }
    }
    
    
    // 버튼을 탭했을 때 호출되는 액션 메서드
    @objc private func buttonTapped(_ sender: UIButton) {
        guard let title = sender.title(for: .normal), let numberOfPeople = Int(title) else { return }
        handleNumberOfPeopleSelected(numberOfPeople)
    }
    // 사용자가 인원을 선택하고 선택된 인원 수를 처리하는 함수
    private func handleNumberOfPeopleSelected(_ numberOfPeople: Int) {
        // didSelectNumberOfPeople 클로저를 호출하여 선택된 인원 수를 전달합니다.
        didSelectNumberOfPeople?(numberOfPeople)
    }
}

extension PersonSelectionView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // 장애인, 청소년, 유아 여부에 따라 선택 가능한 인원 수 조정
        if isDisabled {
            return maxNumberOfPeople // 장애인은 최대 8명까지 선택 가능
        } else if isTeenager {
            return min(maxNumberOfPeople, selectedNumberOfPeople) // 청소년은 선택한 수까지만 선택 가능
        } else if isChild {
            return min(maxNumberOfPeople, selectedNumberOfPeople) // 유아도 선택한 수까지만 선택 가능
        } else {
            return maxNumberOfPeople // 일반적인 경우 최대 8명까지 선택 가능
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // 각 row에 해당하는 텍스트 반환
        return "\(row + 1)명"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // 선택한 인원 수 업데이트
        selectedNumberOfPeople = row + 1
        
        // 클로저 호출하여 선택된 인원 수 전달
        didSelectNumberOfPeople?(selectedNumberOfPeople)
    }
}
