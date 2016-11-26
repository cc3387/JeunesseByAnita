//
//  YourFuture.swift
//  JeunessebyAnita
//
//  Created by Clement Chan on 11/15/16.
//  Copyright © 2016 Clement Chan. All rights reserved.
//

import Foundation
import UIKit

class YourFuture: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var Yourfuture: UILabel!
    @IBOutlet weak var RankDescription: UITextView!
    @IBOutlet weak var Becomenineone: UILabel!
    @IBOutlet weak var Becomeninetwo: UILabel!
    @IBOutlet weak var Back: UILabel!

    /////////////////////////////////////////////////////////////////////////////
    @IBOutlet weak var myUIScrollView: UIScrollView!
    var myUIImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(language == "english"){
            language = "english"
            self.Back.text = "Back"
            self.Yourfuture.text = "Your Future"
            self.Becomenineone.text = "Become an app user for $0.99/month"
            self.Becomeninetwo.text = "Buy Product, join for $0.99/month"
            self.RankDescription.text = "Jeunesse Ranking " + "\n" + "\n" + "1. Distributor" + "\n" + "->" + "\n" + "2. Registered Executive" + "\n" + "->" + "\n" + "3. Jade Executive" + "\n" + "->" + "\n" + "4. Pearl Executive" + "\n" + "->" + "\n" + "5. Sapphire Executive -" + "\n" + "Monthly Income $5,000" + "\n" + "->" + "\n" + "6. Sapphire Elite -" + "\n" + "Monthly Income $5,000 - $10,000" + "\n" + "->" + "\n" + "7. Ruby Executive -" + "\n" + "Monthly Income $10,000 - $25,000" + "\n" + "->" + "\n" + "8. Emerald Executive -" + "\n" + "Monthly Income $25,000 - $50,000" + "\n" + "->" + "\n" + "9. Diamond Executive -" + "\n" + "Monthly Income - $150,000"
            self.myUIScrollView.maximumZoomScale = 5.0
            self.myUIScrollView.minimumZoomScale = 0.0
            self.myUIScrollView.delegate = self
            
            let image: UIImage = UIImage(named: "JeunesseRankingEng.jpg")!
            
            myUIImageView = UIImageView(image: image)
            self.myUIScrollView.addSubview(myUIImageView)
            updateMinZoomScaleForSize(view.bounds.size)
            
        }
        else if(language == "traditional"){
            language = "traditional"
            self.Back.text = "回到前頁"
            self.Yourfuture.text = "你的將來"
            self.Becomenineone.text = "加入團隊，成為版主-每月0.99美元"
            self.Becomeninetwo.text = "購買婕斯,接收訊息-每月0.99美元"
            self.RankDescription.text = "婕斯階梯" + "\n" + "\n" + "1. 經銷商" + "\n" + "->" + "\n" + "2. 合格經銷商" + "\n" + "->" + "\n" + "3. 翡翠經銷商" + "\n" + "->" + "\n" + "4. 珍珠經銷商" + "\n" + "->" + "\n" + "5. 藍寶石經銷商 -" + "\n" + "月入 5,000 美元" + "\n" + "->" + "\n" + "6. 星光藍寶經銷商 -" + "\n" + "月入 5,000 - 10,000 美元" + "\n" + "->" + "\n" + "7. 紅寶經銷商 -" + "\n" + "月入 10,000 - 25,000 美元" + "\n" + "->" + "\n" + "8. 綠寶經銷商 -" + "\n" + "月入 25,000 - 50,000 美元" + "\n" + "->" + "\n" + "9. 鑽石經銷商 -" + "\n" + "月入可超过 150,000 美元" + "\n" + "\n" + "以上為粗略計算，收入視乎團隊業績表現"
            self.myUIScrollView.maximumZoomScale = 5.0
            self.myUIScrollView.minimumZoomScale = 0.0
            self.myUIScrollView.delegate = self
            
            let image: UIImage = UIImage(named: "Jeuness_Ranking.jpg")!
            
            myUIImageView = UIImageView(image: image)
            self.myUIScrollView.addSubview(myUIImageView)
            updateMinZoomScaleForSize(view.bounds.size)
            
        }
        else if(language == "simplified"){
            language = "simplified"
            self.Back.text = "回到前页"
            self.Yourfuture.text = "你的将来"
            self.RankDescription.text = "婕斯阶梯" + "\n" + "\n" + "1. 经销商" + "\n" + "->" + "\n" + "2. 合格经销商" + "\n" + "->" + "\n" + "3. 翡翠经销商" + "\n" + "->" + "\n" + "4. 珍珠经销商" + "\n" + "->" + "\n" + "5. 蓝宝石经销商 -" + "\n" + "月入 5,000 美元" + "\n" + "->" + "\n" + "6. 星光蓝宝经销商 -" + "\n" + "月入 5,000 - 10,000 美元" + "\n" + "->" + "\n" + "7. 红宝经销商 -" + "\n" + "月入 10,000 - 25,000 美元" + "\n" + "->" + "\n" + "8. 绿宝经销商 -" + "\n" + "月入 25,000 - 50,000 美元" + "\n" + "->" + "\n" + "9. 钻石经销商 -" + "\n" + "月入可超过 150,000 美元" + "\n" + "\n" + "以上为粗略计算，收入视乎团队业绩表现"
            self.Becomenineone.text = "加入团队,成为版主-每月0.99美元"
            self.Becomeninetwo.text = "购买婕斯,接收讯息-每月0.99美元"
            
            self.myUIScrollView.maximumZoomScale = 5.0
            self.myUIScrollView.minimumZoomScale = 0.0
            self.myUIScrollView.delegate = self
            
            let image: UIImage = UIImage(named: "Jeuness_Ranking.jpg")!
            
            myUIImageView = UIImageView(image: image)
            self.myUIScrollView.addSubview(myUIImageView)
            updateMinZoomScaleForSize(view.bounds.size)
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return myUIImageView
        
    }
    
    func updateMinZoomScaleForSize(_ size: CGSize) {
        let widthScale = size.width / myUIImageView.bounds.width
        let heightScale = size.height / myUIImageView.bounds.height
        let minScale = min(widthScale, heightScale)
        
        self.myUIScrollView.minimumZoomScale = minScale
        
        self.myUIScrollView.zoomScale = minScale
    }
}
