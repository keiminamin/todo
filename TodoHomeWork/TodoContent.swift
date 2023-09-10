//
//  TodoContent.swift
//  TodoHomeWork
//
//  Created by 長島啓太朗 on 2023/09/04.
//

import Foundation
import RealmSwift

class TodoContent :Object{
    @Persisted var title:String = ""
    @Persisted var body:String = ""
    @Persisted var isMarked:Bool = false
    @Persisted var date:Date = Date()
    @Persisted var number:Int = 0
    @Persisted var category: Category?
}
