//
//  APIError.swift
//  Rush
//
//  Created by MJ Roldan on 06/07/2017.
//  Copyright © 2017 Mark Joel Roldan. All rights reserved.
//

import Foundation

public enum APIErrorCode {
    case serverIssue
    case requestTimeout
    case otherError
    case invalidToken
    case invalidURL
    case invalidAppKeySecret
    case invalidData
    case invalidParameter
    case noInternet
}

struct APIError {
    static func urlErrorDomain(_ error: NSError) -> APIErrorCode {
        var apiError: APIErrorCode!
        switch error.code {
        // Invalid URL
        case NSURLErrorBadURL,
             NSURLErrorUnsupportedURL,
             NSURLErrorCannotFindHost,
             NSURLErrorDNSLookupFailed:
            apiError = .invalidURL
            break
        // Request Time Out
        case NSURLErrorTimedOut,
             NSURLErrorCannotConnectToHost,
             NSURLErrorRequestBodyStreamExhausted,
             NSURLErrorBackgroundSessionWasDisconnected:
            apiError = .requestTimeout
            break
        // Invalid Data
        case NSURLErrorDataLengthExceedsMaximum,
             NSURLErrorResourceUnavailable,
             NSURLErrorZeroByteResource,
             NSURLErrorCannotDecodeRawData,
             NSURLErrorCannotDecodeContentData,
             NSURLErrorFileDoesNotExist,
             NSURLErrorFileIsDirectory,
             NSURLErrorNoPermissionsToReadFile:
            apiError = .invalidData
            break
        // No Internet
        case NSURLErrorNetworkConnectionLost,
             NSURLErrorNotConnectedToInternet,
             NSURLErrorInternationalRoamingOff,
             NSURLErrorDataNotAllowed,
             NSURLErrorCannotLoadFromNetwork:
            apiError = .noInternet
            break
        // Server error
        case NSURLErrorHTTPTooManyRedirects,
             NSURLErrorRedirectToNonExistentLocation,
             NSURLErrorBadServerResponse,
             NSURLErrorUserCancelledAuthentication,
             NSURLErrorUserAuthenticationRequired,
             NSURLErrorSecureConnectionFailed,
             NSURLErrorServerCertificateHasBadDate,
             NSURLErrorServerCertificateUntrusted,
             NSURLErrorServerCertificateHasUnknownRoot,
             NSURLErrorServerCertificateNotYetValid,
             NSURLErrorClientCertificateRejected,
             NSURLErrorClientCertificateRequired:
            apiError = .serverIssue
            break
        default: // Other errors
            apiError = .otherError
            break
        }
        return apiError
    }

    static func responseStatus(_ response: HTTPURLResponse) -> APIErrorCode? {
        var apiError: APIErrorCode?
        switch response.statusCodeEnum {
        case .ok: apiError = nil
            break
        case .requestTimeout,
             .gatewayTimeout,
             .nginxNoResponse:
            apiError = .requestTimeout
            break
        case .notModified,
             .badRequest,
             .notFound,
             .gone,
             .movedPermanently:
            apiError = .invalidURL
            break
        case .internalServerError,
             .serviceUnavailable,
             .forbidden,
             .unauthorized,
             .badGateway:
            apiError = .serverIssue
            break
        default: apiError = .otherError
            break
        }
        return apiError
    }
}
