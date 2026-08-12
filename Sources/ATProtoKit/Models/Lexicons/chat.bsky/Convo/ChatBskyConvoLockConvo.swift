//
//  ChatBskyConvoLockConvo.swift
//
//
//  Created by Christopher Jr Riley on 2025-08-12.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

extension ChatBskyLexicon.Conversation {

    /// A request body model for locking a conversation.
    ///
    /// - SeeAlso: This is based on the [`chat.bsky.convo.lockConvo`][github] lexicon.
    ///
    /// [github]: https://github.com/bluesky-social/atproto/blob/main/lexicons/chat/bsky/convo/lockConvo.json
    public struct LockConversationRequestBody: Sendable, Codable {

        /// The ID of the conversation to lock.
        public let conversationID: String

        enum CodingKeys: String, CodingKey {
            case conversationID = "convoId"
        }
    }

    /// An output model for locking a conversation.
    ///
    /// - SeeAlso: This is based on the [`chat.bsky.convo.lockConvo`][github] lexicon.
    ///
    /// [github]: https://github.com/bluesky-social/atproto/blob/main/lexicons/chat/bsky/convo/lockConvo.json
    public struct LockConversationOutput: Sendable, Codable {

        /// The locked conversation.
        public let conversation: ConversationViewDefinition

        enum CodingKeys: String, CodingKey {
            case conversation = "convo"
        }
    }
}
