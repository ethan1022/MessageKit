import Foundation
import UIKit

open class TopicUpdateMessageSizeCalculator: MessageSizeCalculator {

    open override func messageContainerSize(for message: MessageType) -> CGSize {
        switch message.kind {
        case .topicUpdate(let item):
            let maxWidth = messageContainerMaxWidth(for: message)
            if maxWidth < item.size.width {
                // Maintain the ratio if width is too great
                let height = maxWidth * item.size.height / item.size.width
                return CGSize(width: maxWidth, height: height)
            }
            return item.size
        default:
            fatalError("messageContainerSize received unhandled MessageDataType: \(message.kind)")
        }
    }
}

