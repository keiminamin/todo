//
//  Category.swift
//  TodoHomeWork
//
//  Created by 長島啓太朗 on 2023/09/10.
//

import Foundation
import RealmSwift

class Category:Object{
    @Persisted var title:String = ""
}
