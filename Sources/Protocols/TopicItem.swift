//
//  TopicItem.swift
//  
//
//  Created by Ethan Wen on 2021/11/26.
//

import Foundation

public protocol TopicItem {
    
    /// Topic text.
    var topicDescription: String { get }
    
    var topicId: String { get }
    
    var isReply: Bool { get }
}
