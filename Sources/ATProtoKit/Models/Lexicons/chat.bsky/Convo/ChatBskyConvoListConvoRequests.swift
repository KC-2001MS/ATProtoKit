//
//  ChatBskyConvoListConvoRequests.swift
//
//
//  Created by Christopher Jr Riley on 2025-08-12.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

extension ChatBskyLexicon.Conversation {

    /// An output model for listing conversation requests.
    ///
    /// - SeeAlso: This is based on the [`chat.bsky.convo.listConvoRequests`][github] lexicon.
    ///
    /// [github]: https://github.com/bluesky-social/atproto/blob/main/lexicons/chat/bsky/convo/listConvoRequests.json
    public struct ListConversationRequestsOutput: Sendable, Codable {

        /// The mark used to indicate the starting point for the next set of results. Optional.
        public let cursor: String?

        /// An array of conversation request items. Each item is either a direct conversation view
        /// or a group join request view (chat.bsky.group.defs#joinRequestConvoView, pending
        /// group lexicon implementation).
        public let requests: [RequestUnion]

        // Unions
        /// A union for each item in the conversation requests list.
        public enum RequestUnion: ATUnionProtocol {

            /// A direct conversation request view.
            case convoView(ChatBskyLexicon.Conversation.ConversationViewDefinition)

            /// An unknown case.
            case unknown(String, [String: CodableValue])

            public init(from decoder: any Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                let type = try container.decodeIfPresent(String.self, forKey: .type)

                switch type {
                    case "chat.bsky.convo.defs#convoView":
                        self = .convoView(try ChatBskyLexicon.Conversation.ConversationViewDefinition(from: decoder))
                    default:
                        let singleValueDecodingContainer = try decoder.singleValueContainer()
                        let dictionary = try Self.decodeDictionary(from: singleValueDecodingContainer, decoder: decoder)

                        self = .unknown(type ?? "unknown", dictionary)
                }
            }

            public func encode(to encoder: any Encoder) throws {
                var container = encoder.singleValueContainer()

                switch self {
                    case .convoView(let value):
                        try container.encode(value)
                    default:
                        break
                }
            }

            enum CodingKeys: String, CodingKey {
                case type = "$type"
            }
        }
    }
}
