//  Copyright © 2024 Checkout.com. All rights reserved.

import Security
import Foundation

import JOSESwift

public func sign(message: String) -> String? {
    guard let key = createRandomKey(),
          let signer = Signer(signingAlgorithm: .RS256, privateKey: key) else {
        return nil
    }
    do {
        let jws = try JWS(
            header: JWSHeader(algorithm: .RS256),
            payload: Payload(Data(message.utf8)),
            signer: signer
        )
        return jws.compactSerializedString
    } catch {
        return nil
    }
}

private func createRandomKey() -> SecKey? {
    let attributes: [CFString: Any] = [
        kSecAttrKeyType: kSecAttrKeyTypeRSA,
        kSecAttrKeyClass: kSecAttrKeyClassPrivate,
        kSecAttrKeySizeInBits: 2048,
        kSecPrivateKeyAttrs: [kSecAttrIsPermanent: false]
    ]
    var error: Unmanaged<CFError>?
    guard let key = SecKeyCreateRandomKey(attributes as CFDictionary, &error) else {
        return nil
    }
    return key
}
