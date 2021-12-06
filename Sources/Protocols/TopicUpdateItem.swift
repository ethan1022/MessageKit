//
//  TopicUpdateItem.swift
//
//
//  Created by Ethan Wen on 2021/11/26.
//

import Foundation
import UIKit

public protocol TopicUpdateItem {
    
    var topicId: String { get }
    
    var description: String { get }
    
    var messageId: String { get }
    
    var size: CGSize { get }
}
