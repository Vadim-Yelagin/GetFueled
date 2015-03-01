//
//  NSError+ETRUtils.m
//
//  Created by Vadim Yelagin on 15/10/14.
//  Copyright (c) 2014 EastBanc Technologies Russia. All rights reserved.
//

#import "NSError+ETRUtils.h"

static NSString *ETRURLDescriptionForCode(NSInteger code)
{
    switch (code) {
        case NSURLErrorUnknown:
            return @"An unknown error occurred.";
        case kCFHostErrorHostNotFound:
            return @"Indicates that the DNS lookup failed.";
        case kCFHostErrorUnknown:
            return @"An unknown error occurred during host lookup.";
        case kCFSOCKSErrorUnknownClientVersion:
            return @"The SOCKS server rejected access because it does not support connections with the requested SOCKS version.";
        case kCFSOCKSErrorUnsupportedServerVersion:
            return @"The version of SOCKS requested by the server is not supported.";
        case kCFSOCKS4ErrorRequestFailed:
            return @"Request rejected or failed by the server.";
        case kCFSOCKS4ErrorIdentdFailed:
            return @"Request rejected because SOCKS server cannot connect to identd on the client.";
        case kCFSOCKS4ErrorIdConflict:
            return @"Request rejected because the client program and identd report different user-ids.";
        case kCFSOCKS4ErrorUnknownStatusCode:
            return @"The status code returned by the server is unknown.";
        case kCFSOCKS5ErrorBadState:
            return @"The stream is not in a state that allows the requested operation.";
        case kCFSOCKS5ErrorBadResponseAddr:
            return @"The address type returned is not supported.";
        case kCFSOCKS5ErrorBadCredentials:
            return @"The SOCKS server refused the client connection because of bad login credentials.";
        case kCFSOCKS5ErrorUnsupportedNegotiationMethod:
            return @"The requested method is not supported.";
        case kCFSOCKS5ErrorNoAcceptableMethod:
            return @"The client and server could not find a mutually agreeable authentication method.";
        case kCFFTPErrorUnexpectedStatusCode:
            return @"The server returned an unexpected status code.";
        case kCFErrorHTTPAuthenticationTypeUnsupported:
            return @"The client and server could not agree on a supported authentication type.";
        case kCFErrorHTTPBadCredentials:
            return @"The credentials provided for an authenticated connection were rejected by the server.";
        case kCFErrorHTTPConnectionLost:
            return @"The connection to the server was dropped. This usually indicates a highly overloaded server.";
        case kCFErrorHTTPParseFailure:
            return @"The HTTP server response could not be parsed.";
        case kCFErrorHTTPRedirectionLoopDetected:
            return @"Too many HTTP redirects occurred before reaching a page that did not redirect the client to another page.";
        case kCFErrorHTTPBadURL:
            return @"The requested URL could not be retrieved.";
        case kCFErrorHTTPProxyConnectionFailure:
            return @"A connection could not be established to the HTTP proxy.";
        case kCFErrorHTTPBadProxyCredentials:
            return @"The authentication credentials provided for logging into the proxy were rejected.";
        case kCFErrorPACFileError:
            return @"An error occurred with the proxy autoconfiguration file.";
        case kCFErrorPACFileAuth:
            return @"The authentication credentials provided by the proxy autoconfiguration file were rejected.";
        case kCFErrorHTTPSProxyConnectionFailure:
            return @"A connection could not be established to the HTTPS proxy.";
        case kCFStreamErrorHTTPSProxyFailureUnexpectedResponseToCONNECTMethod:
            return @"The HTTPS proxy returned an unexpected status code.";
        case kCFURLErrorUnknown:
            return @"An unknown error occurred.";
        case kCFURLErrorCancelled:
            return @"The connection was cancelled.";
        case kCFURLErrorBadURL:
            return @"The connection failed due to a malformed URL.";
        case kCFURLErrorTimedOut:
            return @"The connection timed out.";
        case kCFURLErrorUnsupportedURL:
            return @"The connection failed due to an unsupported URL scheme.";
        case kCFURLErrorCannotFindHost:
            return @"The connection failed because the host could not be found.";
        case kCFURLErrorCannotConnectToHost:
            return @"The connection failed because a connection cannot be made to the host.";
        case kCFURLErrorNetworkConnectionLost:
            return @"The connection failed because the network connection was lost.";
        case kCFURLErrorDNSLookupFailed:
            return @"The connection failed because the DNS lookup failed.";
        case kCFURLErrorHTTPTooManyRedirects:
            return @"The HTTP connection failed due to too many redirects.";
        case kCFURLErrorResourceUnavailable:
            return @"The connection’s resource is unavailable.";
        case kCFURLErrorNotConnectedToInternet:
            return @"The connection failed because the device is not connected to the internet.";
        case kCFURLErrorRedirectToNonExistentLocation:
            return @"The connection was redirected to a nonexistent location.";
        case kCFURLErrorBadServerResponse:
            return @"The connection received an invalid server response.";
        case kCFURLErrorUserCancelledAuthentication:
            return @"The connection failed because the user cancelled required authentication.";
        case kCFURLErrorUserAuthenticationRequired:
            return @"The connection failed because authentication is required.";
        case kCFURLErrorZeroByteResource:
            return @"The resource retrieved by the connection is zero bytes.";
        case kCFURLErrorCannotDecodeRawData:
            return @"The connection cannot decode data encoded with a known content encoding.";
        case kCFURLErrorCannotDecodeContentData:
            return @"The connection cannot decode data encoded with an unknown content encoding.";
        case kCFURLErrorCannotParseResponse:
            return @"The connection cannot parse the server’s response.";
        case kCFURLErrorInternationalRoamingOff:
            return @"The connection failed because international roaming is disabled on the device.";
        case kCFURLErrorCallIsActive:
            return @"The connection failed because a call is active.";
        case kCFURLErrorDataNotAllowed:
            return @"The connection failed because data use is currently not allowed on the device.";
        case kCFURLErrorRequestBodyStreamExhausted:
            return @"The connection failed because its request’s body stream was exhausted.";
        case kCFURLErrorFileDoesNotExist:
            return @"The file operation failed because the file does not exist.";
        case kCFURLErrorFileIsDirectory:
            return @"The file operation failed because the file is a directory.";
        case kCFURLErrorNoPermissionsToReadFile:
            return @"The file operation failed because it does not have permission to read the file.";
        case kCFURLErrorDataLengthExceedsMaximum:
            return @"The file operation failed because the file is too large.";
        case kCFURLErrorSecureConnectionFailed:
            return @"The secure connection failed for an unknown reason.";
        case kCFURLErrorServerCertificateHasBadDate:
            return @"The secure connection failed because the server’s certificate has an invalid date.";
        case kCFURLErrorServerCertificateUntrusted:
            return @"The secure connection failed because the server’s certificate is not trusted.";
        case kCFURLErrorServerCertificateHasUnknownRoot:
            return @"The secure connection failed because the server’s certificate has an unknown root.";
        case kCFURLErrorServerCertificateNotYetValid:
            return @"The secure connection failed because the server’s certificate is not yet valid.";
        case kCFURLErrorClientCertificateRejected:
            return @"The secure connection failed because the client’s certificate was rejected.";
        case kCFURLErrorClientCertificateRequired:
            return @"The secure connection failed because the server requires a client certificate.";
        case kCFURLErrorCannotLoadFromNetwork:
            return @"The connection failed because it is being required to return a cached resource, but one is not available.";
        case kCFURLErrorCannotCreateFile:
            return @"The file cannot be created.";
        case kCFURLErrorCannotOpenFile:
            return @"The file cannot be opened.";
        case kCFURLErrorCannotCloseFile:
            return @"The file cannot be closed.";
        case kCFURLErrorCannotWriteToFile:
            return @"The file cannot be written.";
        case kCFURLErrorCannotRemoveFile:
            return @"The file cannot be removed.";
        case kCFURLErrorCannotMoveFile:
            return @"The file cannot be moved.";
        case kCFURLErrorDownloadDecodingFailedMidStream:
            return @"The download failed because decoding of the downloaded data failed mid-stream.";
        case kCFURLErrorDownloadDecodingFailedToComplete:
            return @"The download failed because decoding of the downloaded data failed to complete.";
        case kCFHTTPCookieCannotParseCookieFile:
            return @"The cookie file cannot be parsed.";
        case kCFNetServiceErrorUnknown:
            return @"An unknown error occurred.";
        case kCFNetServiceErrorCollision:
            return @"An attempt was made to use a name that is already in use.";
        case kCFNetServiceErrorInProgress:
            return @"A new search could not be started because a search is already in progress.";
        case kCFNetServiceErrorBadArgument:
            return @"A required argument was not provided or was not valid.";
        case kCFNetServiceErrorCancel:
            return @"The search or service was cancelled.";
        case kCFNetServiceErrorInvalid:
            return @"Invalid data was passed to a CFNetServices function.";
        case kCFNetServiceErrorTimeout:
            return @"A search failed because it timed out.";
        case kCFNetServiceErrorDNSServiceFailure:
            return @"An error from DNS discovery.";
    }
    return nil;
}

@implementation NSError (ETRUtils)

- (BOOL)etr_isCancelledError
{
    return [self.domain isEqual:NSURLErrorDomain] && self.code == kCFURLErrorCancelled;
}

- (NSString *)etr_description
{
    NSString *res = self.userInfo[NSLocalizedDescriptionKey];
    if (res.length)
        return res;
    if ([self.domain isEqual:NSURLErrorDomain])
        return ETRURLDescriptionForCode(self.code);
    return self.localizedDescription;
}

@end
