//
//  GetGraphBlocks.swift
//
//
//  Created by Christopher Jr Riley on 2024-03-08.
//

import Foundation

extension ATProtoKit {
    /// Gets all of the block records from the user account.
    /// 
    /// - Parameters:
    ///   - limit: The number of items the list will hold. Optional. Defaults to `50`.
    ///   - cursor: The mark used to indicate the starting point for the next set of result. Optional.
    /// - Returns: A `Result`, containing either a ``GraphGetBlocksOutput`` if successful, or an `Error` if not.
    public func getGraphBlocks(limit: Int? = 50, cursor: String? = nil) async throws -> Result<GraphGetBlocksOutput, Error> {
        guard let sessionURL = session.pdsURL,
              let requestURL = URL(string: "\(sessionURL)/xrpc/app.bsky.graph.getBlocks") else {
            return .failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
        }

        var queryItems = [(String, String)]()

        if let limit {
            let finalLimit = min(1, max(limit, 100))
            queryItems.append(("limit", "\(finalLimit)"))
        }

        if let cursor {
            queryItems.append(("cursor", cursor))
        }

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
            let response = try await APIClientService.sendRequest(request, decodeTo: GraphGetBlocksOutput.self)

            return .success(response)
        } catch {
            return .failure(error)
        }
    }
}