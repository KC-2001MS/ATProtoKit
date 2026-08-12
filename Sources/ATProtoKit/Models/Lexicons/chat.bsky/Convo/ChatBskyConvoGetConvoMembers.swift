//
//  ChatBskyConvoGetConvoMembers.swift
//
//
//  Created by Christopher Jr Riley on 2025-08-12.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

extension ChatBskyLexicon.Conversation {

    /// An output model for getting conversation members.
    ///
    /// - SeeAlso: This is based on the [`chat.bsky.convo.getConvoMembers`][github] lexicon.
    ///
    /// [github]: https://github.com/bluesky-social/atproto/blob/main/lexicons/chat/bsky/convo/getConvoMembers.json
    public struct GetConversationMembersOutput: Sendable, Codable {

        /// The mark used to indicate the starting point for the next set of results. Optional.
        public let cursor: String?

        /// An array of member profile views.
        public let members: [ChatBskyLexicon.Actor.ProfileViewBasicDefinition]
    }
}
