import UIKit

open class TopicUpdateMessageCell: MessageContentCell {
    
    public lazy var questionLabel: UILabel = {
        let questionLabel = UILabel(frame: .zero)
        questionLabel.font = UIFont.systemFont(ofSize: 13)
        questionLabel.textColor = UIColor(hex: 0x343637)
        questionLabel.numberOfLines = 0
        return questionLabel
    }()
    
    public lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView(frame: .zero)
        iconImageView.contentMode = .scaleAspectFit
        return iconImageView
    }()
    
    open override func setupSubviews() {
        super.setupSubviews()
        messageContainerView.addSubview(questionLabel)
        messageContainerView.addSubview(iconImageView)
        setupConstraints()
    }
    
    open func setupConstraints() {
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        questionLabel.leadingAnchor.constraint(equalTo: messageContainerView.leadingAnchor, constant: 16).isActive = true
        questionLabel.topAnchor.constraint(equalTo: messageContainerView.topAnchor, constant: 16).isActive = true
        questionLabel.bottomAnchor.constraint(equalTo: messageContainerView.bottomAnchor, constant: 16).isActive = true
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        iconImageView.centerYAnchor.constraint(equalTo: questionLabel.centerYAnchor).isActive = true
        iconImageView.leadingAnchor.constraint(equalTo: questionLabel.trailingAnchor, constant: 10).isActive = true
        iconImageView.trailingAnchor.constraint(equalTo: messageContainerView.trailingAnchor, constant: -16).isActive = true
    }
    
    // MARK: - Configure Cell
    
    open override func configure(with message: MessageType, at indexPath: IndexPath, and messagesCollectionView: MessagesCollectionView) {
        super.configure(with: message, at: indexPath, and: messagesCollectionView)
        guard let dataSource = messagesCollectionView.messagesDataSource else {
            fatalError(MessageKitError.nilMessagesDataSource)
        }
        
        if !dataSource.isFromCurrentSender(message: message) {
            iconImageView.image = UIImage(named: "IncomeTopicMsgIcon")
        } else {
            iconImageView.image = UIImage(named: "OutgoingTopicMsgIcon")
        }
        
        guard let displayDelegate = messagesCollectionView.messagesDisplayDelegate else {
            fatalError(MessageKitError.nilMessagesDisplayDelegate)
        }
        
        displayDelegate.configureTopicUpdateCell(self, message: message)
    }
}
