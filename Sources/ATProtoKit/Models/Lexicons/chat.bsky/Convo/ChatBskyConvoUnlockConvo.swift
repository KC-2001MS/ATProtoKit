//
//  ChatBskyConvoUnlockConvo.swift
//
//
//  Created by Christopher Jr Riley on 2025-08-12.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

extension ChatBskyLexicon.Conversation {

    /// A request body model for unlocking a conversation.
    ///
    /// - SeeAlso: This is based on the [`chat.bsky.convo.unlockConvo`][github] lexicon.
    ///
    /// [github]: https://github.com/bluesky-social/atproto/blob/main/lexicons/chat/bsky/convo/unlockConvo.json
    public struct UnlockConversationRequestBody: Sendable, Codable {

        /// The ID of the conversation to unlock.
        public let conversationID: String

        enum CodingKeys: String, CodingKey {
            case conversationID = "convoId"
        }
    }

    /// An output model for unlocking a conversation.
    ///
    /// - SeeAlso: This is based on the [`chat.bsky.convo.unlockConvo`][github] lexicon.
    ///
    /// [github]: https://github.com/bluesky-social/atproto/blob/main/lexicons/chat/bsky/convo/unlockConvo.json
    public struct UnlockConversationOutput: Sendable, Codable {

        /// The unlocked conversation.
        public let conversation: ConversationViewDefinition

        enum CodingKeys: String, CodingKey {
            case conversation = "convo"
        }
    }
}
