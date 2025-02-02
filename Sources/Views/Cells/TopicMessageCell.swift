//
//  TopicMessageCell.swift
//  MingleTime
//
//  Created by Ethan Wen on 2021/11/25.
//


import UIKit

open class TopicMessageCell: MessageContentCell {
    
    public lazy var replyButton: UIButton = {
        let replyButton = UIButton(type: .system)
        replyButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return replyButton
    }()
    
    public lazy var questionLabel: UILabel = {
        let questionLabel = UILabel(frame: .zero)
        questionLabel.textColor = UIColor(hex: 0x343637)
        questionLabel.numberOfLines = 0
        return questionLabel
    }()
    
    public lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView(frame: .zero)
        iconImageView.contentMode = .scaleAspectFit
        return iconImageView
    }()
    
    public lazy var isReplyLabel: UILabel = {
        let isReplyLabel = UILabel(frame: .zero)
        isReplyLabel.textColor = UIColor(hex: 0x343637)
        isReplyLabel.font = UIFont.systemFont(ofSize: 17)
        isReplyLabel.numberOfLines = 1
        return isReplyLabel
    }()
    
    public lazy var saperatorView: UIView = {
        let saperatorView = UIView(frame: .zero)
        return saperatorView
    }()
    
    public lazy var isReplyLabelHeightConstraint: NSLayoutConstraint = {
        let isReplyLabelHeightConstraint = isReplyLabel.heightAnchor.constraint(equalToConstant: 0)
        return isReplyLabelHeightConstraint
    }()
    
    
    open override func setupSubviews() {
        super.setupSubviews()
        messageContainerView.addSubview(questionLabel)
        messageContainerView.addSubview(iconImageView)
        messageContainerView.addSubview(isReplyLabel)
        messageContainerView.addSubview(saperatorView)
        messageContainerView.addSubview(replyButton)
        setupConstraints()
    }
    
    open func setupConstraints() {
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        questionLabel.leadingAnchor.constraint(equalTo: messageContainerView.leadingAnchor, constant: 16).isActive = true
        questionLabel.topAnchor.constraint(equalTo: messageContainerView.topAnchor, constant: 16).isActive = true
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        iconImageView.centerYAnchor.constraint(equalTo: questionLabel.centerYAnchor).isActive = true
        iconImageView.leadingAnchor.constraint(equalTo: questionLabel.trailingAnchor, constant: 10).isActive = true
        iconImageView.trailingAnchor.constraint(equalTo: messageContainerView.trailingAnchor, constant: -16).isActive = true
        
        isReplyLabel.translatesAutoresizingMaskIntoConstraints = false
        isReplyLabel.leadingAnchor.constraint(equalTo: messageContainerView.leadingAnchor, constant: 16).isActive = true
        isReplyLabel.trailingAnchor.constraint(equalTo: messageContainerView.trailingAnchor, constant: -16).isActive = true
        isReplyLabel.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 6).isActive = true
        isReplyLabelHeightConstraint.isActive = true
        
        saperatorView.translatesAutoresizingMaskIntoConstraints = false
        saperatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        saperatorView.leadingAnchor.constraint(equalTo: messageContainerView.leadingAnchor).isActive = true
        saperatorView.trailingAnchor.constraint(equalTo: messageContainerView.trailingAnchor).isActive = true
        saperatorView.topAnchor.constraint(equalTo: isReplyLabel.bottomAnchor, constant: 16).isActive = true
        
        replyButton.translatesAutoresizingMaskIntoConstraints = false
        replyButton.heightAnchor.constraint(equalToConstant: 46).isActive = true
        replyButton.leadingAnchor.constraint(equalTo: messageContainerView.leadingAnchor).isActive = true
        replyButton.topAnchor.constraint(equalTo: saperatorView.bottomAnchor).isActive = true
        replyButton.trailingAnchor.constraint(equalTo: messageContainerView.trailingAnchor).isActive = true
        replyButton.bottomAnchor.constraint(equalTo: messageContainerView.bottomAnchor).isActive = true
    }
    
    open func tuneUI(by isReply: Bool) {
        isReplyLabelHeightConstraint.constant = isReply ? 24 : 0
        questionLabel.font = UIFont.systemFont(ofSize: isReply ? 13 : 17)
    }
    
    /// Handle tap gesture on contentView and its subviews.
    open override func handleTapGesture(_ gesture: UIGestureRecognizer) {
        let touchLocation = gesture.location(in: self)
        // compute play button touch area, currently play button size is (25, 25) which is hardly touchable
        // add 10 px around current button frame and test the touch against this new frame
        let replyButtonTouchArea = CGRect(replyButton.frame.origin.x, replyButton.frame.origin.y, replyButton.frame.size.width, replyButton.frame.size.height)
        let translateTouchLocation = convert(touchLocation, to: messageContainerView)
        if replyButtonTouchArea.contains(translateTouchLocation) {
            delegate?.tapReplyButton(in: self)
        } else {
            super.handleTapGesture(gesture)
        }
    }
    
    // MARK: - Configure Cell
    
    open override func configure(with message: MessageType, at indexPath: IndexPath, and messagesCollectionView: MessagesCollectionView) {
        super.configure(with: message, at: indexPath, and: messagesCollectionView)
        guard let dataSource = messagesCollectionView.messagesDataSource else {
            fatalError(MessageKitError.nilMessagesDataSource)
        }
        
        if !dataSource.isFromCurrentSender(message: message) {
            iconImageView.image = UIImage(named: "IncomeTopicMsgIcon")
            replyButton.setTitleColor(UIColor(hex: 0xF8A56D), for: .normal)
            saperatorView.backgroundColor = UIColor(hex: 0xD1D2D3)
        } else {
            iconImageView.image = UIImage(named: "OutgoingTopicMsgIcon")
            replyButton.setTitleColor(UIColor(hex: 0x343637), for: .normal)
            saperatorView.backgroundColor = UIColor(hex: 0xD69F7A)
        }
        
        guard let displayDelegate = messagesCollectionView.messagesDisplayDelegate else {
            fatalError(MessageKitError.nilMessagesDisplayDelegate)
        }
        
        if case let .topic(topicItem) = message.kind {
            questionLabel.text = topicItem.topicDescription
            tuneUI(by: topicItem.isReply)
        }
        
        displayDelegate.configureTopicCell(self, message: message)
    }
}
