//
//  GetModerationEventAsAdmin.swift
//
//
//  Created by Christopher Jr Riley on 2024-03-01.
//

import Foundation

extension ATProtoKit {
    /// Gets details about a moderation event.
    /// 
    /// - Important: This is an administrator task and as such, regular users won't be able to access this; if they attempt to do so, an error will occur.
    ///  
    /// - Parameter id: The ID of the moderator event.
    /// - Returns: A `Result`, containing either an ``AdminModEventViewDetail`` if successful, or an `Error` if not.
    public func getModerationEvent(_ id: String) async throws -> Result<AdminModEventViewDetail, Error> {
        guard let sessionURL = session.pdsURL,
              let requestURL = URL(string: "\(sessionURL)/xrpc/com.atproto.admin.getModerationEvent") else {
            return .failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
        }

        let queryItems = [("id", id)]

        do {
            let queryURL = try APIClientService.setQueryItems(
                for: requestURL,
                with: queryItems
            )

            let request = APIClientService.createRequest(forRequest: queryURL,
                                                         andMethod: .get,
                                                         acceptValue: "application/json",
                                                         contentTypeValue: nil,
                                                         authorizationValue: "Bearer \(session.accessToken)")
            let response = try await APIClientService.sendRequest(request, decodeTo: AdminModEventViewDetail.self)

            return .success(response)
        } catch {
            return .failure(error)
        }
    }
}
