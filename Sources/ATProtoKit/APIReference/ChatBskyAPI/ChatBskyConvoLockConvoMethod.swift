//
//  ChatBskyConvoLockConvoMethod.swift
//
//
//  Created by Christopher Jr Riley on 2025-08-12.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

extension ATProtoBlueskyChat {

    /// Locks a conversation.
    ///
    /// - SeeAlso: This is based on the [`chat.bsky.convo.lockConvo`][github] lexicon.
    ///
    /// [github]: https://github.com/bluesky-social/atproto/blob/main/lexicons/chat/bsky/convo/lockConvo.json
    ///
    /// - Parameter id: The ID of the conversation.
    /// - Returns: The locked conversation.
    ///
    /// - Throws: An ``ATProtoError``-conforming error type, depending on the issue. Go to
    /// ``ATAPIError`` and ``ATRequestPrepareError`` for more details.
    public func lockConversation(by id: String) async throws -> ChatBskyLexicon.Conversation.LockConversationOutput {
        guard let session = try await self.getUserSession() else {
            throw ATRequestPrepareError.missingActiveSession
        }

        let sessionURL = session.serviceEndpoint.absoluteString

        guard let requestURL = URL(string: "\(sessionURL)/xrpc/chat.bsky.convo.lockConvo") else {
            throw ATRequestPrepareError.invalidRequestURL
        }

        let requestBody = ChatBskyLexicon.Conversation.LockConversationRequestBody(
            conversationID: id
        )

        do {
            let request = apiClientService.createRequest(
                forRequest: requestURL,
                andMethod: .post,
                acceptValue: "application/json",
                contentTypeValue: "application/json",
                requiresAuthorization: true,
                isRelatedToBskyChat: true
            )

            let response = try await apiClientService.sendRequest(
                request,
                withEncodingBody: requestBody,
                decodeTo: ChatBskyLexicon.Conversation.LockConversationOutput.self
            )

            return response
        } catch {
            throw error
        }
    }
}
