//
//  Product.swift
//  Blender
//
//  Created by Bryan Lin on 4/26/16.
//  Copyright © 2016 GiantCroissant. All rights reserved.
//

import Gloss

struct Products: Glossy {
  let products: [Product]

  init?(json: JSON) {
    self.products = "products" <~~ json ?? [Product]()
  }

  func toJSON() -> JSON? {
    return jsonify([])
  }
}

/*
 {
 "id" : "AS-628",
 "category" : "營養調理機",
 "title" : "全方位營養調理機",
 "description" :
 [
 "一機多功能" : "冰沙、冰淇淋、豆漿、研磨、攪碎、濃湯、精力湯、	牧草汁、調理醬料、蔬菜調理、果泥、肉泥……等",
 "無段式弱至強開關" : "旋鈕式轉速控制，耐用好操作。具瞬間超強轉速開關，方便營業使用。",
 "安全衛生容杯" : "超大容量2500 CC強化PC容杯，耐酸鹼、耐冰熱、耐撞，不會產生有毒物質，健康有保障。",
 "多角座刀頭" : "六向多角度不銹鋼硬化刀頭，堅韌無比。",
 "超強馬力功率大" : "台灣製造1200W工業級超強馬達，可將堅硬食物充分攪碎，保留完整營養。馬達具雙重安全保護，溫度(135℃)/電流(12A)過載保護裝置。"
 ],
 "info" :
 [
 "顏色" : "黑、白、紅、灰",
 "機體尺寸" : "255（長）× 205（寬）× 512 （高）（mm）",
 "機體淨重" : "5.0 KG",
 "機體毛重" : "5.5 KG",
 "生產國" : "台灣",
 "外箱裝台數" : "2台"
 ],
 "specs" :
 [
 "額定電壓" : "110 V / 220V~240V",
 "頻率" : "60 Hz / 50Hz",
 "消耗功率" : "1200 W",
 "容量" : "2500c.c."
 ]
 }
 let id: String
 let title: String
 let category: String
 let image: String
 let viewedCount: Int
 let description: String
 let videoCode: String
 let steps: [Step]
 let ingredients: [Ingredient]
 */

struct Product: Glossy {
  let id: String
  let title: String
  let category: String
  let descriptions: [ProductDescription]
  let infos: [ProductInfo]
  let specs: [ProductSpecs]
}


