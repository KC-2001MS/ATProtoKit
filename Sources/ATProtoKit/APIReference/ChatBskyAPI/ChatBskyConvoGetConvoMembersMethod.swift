//
//  ChatBskyConvoGetConvoMembersMethod.swift
//
//
//  Created by Christopher Jr Riley on 2025-08-12.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

extension ATProtoBlueskyChat {

    /// Retrieves the members of a conversation.
    ///
    /// - SeeAlso: This is based on the [`chat.bsky.convo.getConvoMembers`][github] lexicon.
    ///
    /// [github]: https://github.com/bluesky-social/atproto/blob/main/lexicons/chat/bsky/convo/getConvoMembers.json
    ///
    /// - Parameters:
    ///   - from: The ID of the conversation.
    ///   - limit: The number of items that can be in the list. Optional. Defaults to `50`.
    ///   - cursor: The mark used to indicate the starting point for the next set
    ///   of results. Optional.
    /// - Returns: A list of member profile views for the conversation, with an optional cursor.
    ///
    /// - Throws: An ``ATProtoError``-conforming error type, depending on the issue. Go to
    /// ``ATAPIError`` and ``ATRequestPrepareError`` for more details.
    public func getConversationMembers(
        from id: String,
        limit: Int? = 50,
        cursor: String? = nil
    ) async throws -> ChatBskyLexicon.Conversation.GetConversationMembersOutput {
        guard let session = try await self.getUserSession() else {
            throw ATRequestPrepareError.missingActiveSession
        }

        let sessionURL = session.serviceEndpoint.absoluteString

        guard let requestURL = URL(string: "\(sessionURL)/xrpc/chat.bsky.convo.getConvoMembers") else {
            throw ATRequestPrepareError.invalidRequestURL
        }

        var queryItems = [(String, String)]()

        queryItems.append(("convoId", id))

        if let limit {
            let finalLimit = max(1, min(limit, 100))
            queryItems.append(("limit", "\(finalLimit)"))
        }

        if let cursor {
            queryItems.append(("cursor", cursor))
        }

        let queryURL: URL

        do {
            queryURL = try apiClientService.setQueryItems(
                for: requestURL,
                with: queryItems
            )

            let request = apiClientService.createRequest(
                forRequest: queryURL,
                andMethod: .get,
                acceptValue: "application/json",
                contentTypeValue: nil,
                requiresAuthorization: true,
                isRelatedToBskyChat: true
            )
            let response = try await apiClientService.sendRequest(
                request,
                decodeTo: ChatBskyLexicon.Conversation.GetConversationMembersOutput.self
            )

            return response
        } catch {
            throw error
        }
    }
}
