//
//  ReserveViewController.swift
//  PopDangSquare
//
//  Created by 민웅킴 on 4/26/24.
//

import UIKit

class ReserveViewController: UIViewController {
    
    @IBOutlet weak var ReserveBackImage: UIImageView!
    @IBOutlet weak var ReserveStackView: UIStackView!
    
    @IBOutlet weak var ReserveCancelView: UIView!
    @IBOutlet weak var ReserveCancelBTN: UIButton!
    
    @IBOutlet weak var ReserveReserveView: UIView!
    @IBOutlet weak var ReserveReserveBTN: UIButton!
    
    @IBOutlet weak var ReservePosterImage: UIImageView!
    @IBOutlet weak var ReserveTextLabel: UILabel!
    
    @IBOutlet weak var ReserveCollectionView: UICollectionView!
    
    @IBOutlet weak var ReserveTitleView: UIView!
    @IBOutlet weak var ReserveMovieName: UILabel!
    @IBOutlet weak var ReserveDateAndTime: UILabel!
    @IBOutlet weak var ReserveLocation: UILabel!
    
    
    
    
    
    
    
    
    

    override func viewDidLoad() {
        
        ReserveCollectionView.register(UINib(nibName: "ReserveCell", bundle: nil), forCellWithReuseIdentifier: "ReserveCell")
        
        
        super.viewDidLoad()
        
    }
}
