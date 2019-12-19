//
//  ViewController.swift
//  Aimls-swift
//
//  Created by 中创 on 2019/12/3.
//  Copyright © 2019 LS. All rights reserved.
//

import UIKit

protocol protocol1 {
    func doSomethind(parameter:String) -> String
}
class Data {
    weak var ref:Test? = nil
    var test:Test? = nil
    
    init() {
        print("Data被初始化了...")
    }
    init(test:Test) {
        self.test = test
    }
    func doSomethind() {
        
    }
    deinit {
        print("Data实例被销毁了...")
    }
}
class A {
    var name:String = ""
    init?(name:String, age:Int) {
        if name == "unknown" {
            return nil
        }
        self.name = name;
    }
    init(name:String) {
        self.name = name
    }
    deinit {
        print("A实例被销毁了...")
    }
}
class B: A, protocol1 {
    var ref:Data? = Data()
    lazy var data:Data = Data()
    func doSomethind(parameter: String) -> String {
        return parameter
    }
    
    deinit {
        print("B实例被销毁了...")
    }
    
    
}
extension B{
    var va:String { // 扩展中增加计算属性
        get{
            return "self.va"
        }
    }
    
    func play() {
        print("B的扩展增加的一个方法")
    }
}

class Test {
    unowned var ref:Data? = nil // 无主引用：引用的对象一旦销毁便不再指向该对象
    var name:String = ""
    init() {
        
    }
    init(name:String) {
        self.name = name
    }
    lazy var log:() -> Void = { // lazy是为了防止调用的时候name还没有被初始化
        [unowned self] () -> Void in    // 解决闭包引起的循环引用
        print("self.name:" + self.name)
    }
    
    deinit {
        print("Test实例被销毁了...")
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.green
        
        func testAssert(num:Int){
            if num > 5 {
                assert(false, "停止运行...")
            }
             print("继续运行...")
        }
        testAssert(num: 5)
        print("------------参数操作------------")
        func testFunc(outParameter1 parameter1:String, outParameter2 parameter2:String) -> (String, String){
            
            return(parameter1, parameter2)
        }
        // 忽略参数标签(外部使用)
        func testFunc1(_ parameter1:String, _ parameter2:String) -> (String, String){
            
            return(parameter1, parameter2)
        }
        let arr = testFunc(outParameter1: "1", outParameter2: "2")
        testFunc1("1", "2")
        print(arr)
        
        print(type(of: 1.2))
        // （） ??
        let a = Int("12") ?? 0
        print(a)
        
        // 可选类型
        var b:Int? = 10
        b = nil
        if b == nil{
            print("b为nil...")
        }else{
            print("b为" + String(b!))
        }
        
        // 元祖
        let c = (1, "2", 3.1, age:11)
        print(c)
        print(c.1)
        print(c.age)
        
        // 可选项绑定 隐式展开
        var d:Int? = 10
        d = 5
        if let e = d{
            print("d有值，e为\(e)")
        }else{
            print("d没有值")
        }
        
        var f:Int! = 10
        f = 5
        let g:Int = f
        print(g)
        
        // switch fallthrough
        let h = (1, "3")
        switch h {
        case (1, "3"):
            print("1, '3'")
            fallthrough
        case (1, "2"):
            print("1, '2'")
        default:
            print("另外的情况")
        }
        
        print("------------区间运算符------------")
        // 区间运算符
        for item in stride(from: 0, to: 10, by: 2){
            print(item)
        }
        print("------------repeat while------------")
        var i = 0
        var j = true
        
        repeat{
            print(i)
            i += 1
            if i > 5 {
                j = false
            }
        }
        while (j)
        
        print("------------字符串操作------------")
        let str = "1 23456"
        let str1 = str[str.index(str.startIndex, offsetBy: 3)]
        print(str1)
        let str2 = str.replacingOccurrences(of: " ", with: "")
        print(str2)
        for c in str{
            print(c)
        }
        let mStr = """
                        fff
                        ddf
                    """
        print(mStr)
        let str3 = #"jjjj..."""ddd"#
        print(str3)
        print("------------数组操作------------")
        var array = [1, 2, 3, 4]
        array.reverse()
        print(array)
        let newArr = array.filter({
            (item) -> Bool in
            return item != 2    // 过滤掉为2的
        })
        print(newArr)
        print("------------字典操作------------")
        var dict = ["a":"A", "b":"B"]
        dict["a"] = "AA"
        print(dict)
        let newDict = dict.filter({
            (key,value) -> Bool in
            return key != "a"
        })
        print(newDict)
        
        print("------------类型判断的使用------------")
        let aClass = A(name: "")
        let bClass = B(name: "")
        print(aClass is A)
        print(bClass is B)
        print("------------泛型的使用------------")
        let t1 = self.testT(parameter: "1")
        let t2 = self.testT(parameter: [1, 2, 3])
        print(t1)
        print(t2)
        print("------------扩展的使用------------")
        bClass.play()
        print(bClass.va)
        print("------------protocol的使用------------")
        print(bClass.doSomethind(parameter: "just do it!"))
        print("------------延迟属性的使用------------")
        bClass.data.doSomethind()
        print("------------可失败初始化器的使用------------")
        let b1 = A(name: "unknown", age: 1)
        if let bb = b1 {
            print(bb.name)
        }else{
            print("nil了...")
        }
         print("------------反初始化器的使用------------")
        var test1:Test? = Test()
        test1 = nil
        print("------------弱引用解决循环强引用的使用------------")
        var data:Data? = Data()
        var test2:Test? = Test()
        data!.ref = test2
        test2!.ref = data
//        data!.ref = nil
        data = nil
        test2 = nil
        print("------------弱引用解决循环强引用的使用------------")
        print("------------无主引用的使用------------")
        var test3:Test? = Test()
        test3!.ref = Data(test: test3!)
        test3 = nil
        print("------------无主引用的使用------------")
        print("------------解决闭包循环引用------------")
        var test4:Test? = Test()
        test4!.log()
        test4 = nil
        print("------------解决闭包循环引用------------")
        print("------------尾随闭包的使用------------")
        self.endClosure(name: "1", para: {
            (p:String) -> String in
            return p + "3"
        })
        self.play(para: {
            (p:String) -> String in
            return p + "2"
        }, name: "3")
        print("------------尾随闭包的使用------------")
    }
    
    func endClosure(name:String, para:(String) -> String) -> Void {
        print(name + para("2"))
    }
    func play(para:(String) -> String, name:String) -> Void {
        print(para("1") + name)
    }
    
    func testT<T>(parameter:T) -> T {
        return parameter
    }
}

