//
//  CustomPrint.swift
//  StoryBoardTest
//
//  Created by 正奇晟业 on 2020/12/8.
//  Copyright © 2020 eall. All rights reserved.
//

import Foundation

func print<N>(message: N, fileName: String = #file, methodName: String = #function, lineNumber: Int = #line) {
    #if DEBUGSWIFT // 若是Debug模式下，则打印
    /*
    //创建一个DateComponents对象
    var components = DateComponents.init()
    
    //设置各个时间成分
    components.year = 2020
    components.month = 12
    components.day = 8
    components.hour = 9
    components.minute = 50
    components.second = 0
    
    //时区设置为东八区(中国)，输出比设置少八小时
    components.timeZone = TimeZone.init(secondsFromGMT: 8 * 3600)!
    //创建一个转换桥梁
    let calendar = Calendar.current
    
    let currentDate = calendar.date(from: components)!
    */
    
    // 获取格林威治时间（GMT）/ 标准时间
    let date = Date()
    // 获取当前时区
    let zone = NSTimeZone.system
    // 获取当前时区和GMT的时间间隔
    let interval = zone.secondsFromGMT()
    // 获取当前系统时间
    let now = date.addingTimeInterval(TimeInterval(interval))
    
    print("\(now)\n\(fileName as NSString)\n方法:\(methodName)\n行号:\(lineNumber)\n打印信息:\(message)\n");
    #endif
}
