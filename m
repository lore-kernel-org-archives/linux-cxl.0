Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="Olv9JQnv"
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA28AC
	for <linux-cxl@vger.kernel.org>; Wed, 13 Dec 2023 08:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:subject;
  bh=vOA8+c5jyI1ZcsCy4M8pKSjBjERCAAWJH+KIL2mtA6U=;
  b=Olv9JQnvv6/WZnMfeYas5iaVEh3IWzYVM/P/qlinOmlmbjbFrhUutyf3
   S1p5OAEA5Y8Aox7en48iGM4OP6XM7F34HIOmpxZwCq5tVowxNG3QpgIln
   /6HQc0O9kjpn916a8/PPAkpZgbmOfyA4iQq8YXpLsp118TFWBcefPDOzl
   Q=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Brice.Goglin@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.04,273,1695679200"; 
   d="asc'?scan'208";a="74340288"
Received: from clt-128-93-179-199.vpn.inria.fr (HELO [128.93.179.199]) ([128.93.179.199])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 17:02:36 +0100
Message-ID: <99e72815-2078-47e0-9276-4a6a9e8e82f9@inria.fr>
Date: Wed, 13 Dec 2023 17:02:35 +0100
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
From: Brice Goglin <Brice.Goglin@inria.fr>
Subject: [PATCH] cxl/region: fix "x9"->"x6" interleaving in a comment
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------x875HzidVMv432WWwbPr4dSq"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------x875HzidVMv432WWwbPr4dSq
Content-Type: multipart/mixed; boundary="------------Rh4568pt6Jn9LdFAE0etxsJS";
 protected-headers="v1"
From: Brice Goglin <Brice.Goglin@inria.fr>
To: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Message-ID: <99e72815-2078-47e0-9276-4a6a9e8e82f9@inria.fr>
Subject: [PATCH] cxl/region: fix "x9"->"x6" interleaving in a comment

--------------Rh4568pt6Jn9LdFAE0etxsJS
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

U2lnbmVkLW9mZi1ieTogQnJpY2UgR29nbGluIDxCcmljZS5Hb2dsaW5AaW5yaWEuZnI+DQot
LS0NCiDCoGRyaXZlcnMvY3hsL2NvcmUvcmVnaW9uLmMgfCAyICstDQogwqAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvY3hsL2NvcmUvcmVnaW9uLmMgYi9kcml2ZXJzL2N4bC9jb3JlL3JlZ2lvbi5jDQpp
bmRleCA1NmU1NzVjNzliYjQuLmQ5OWY2Njk4MTY4ZCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMv
Y3hsL2NvcmUvcmVnaW9uLmMNCisrKyBiL2RyaXZlcnMvY3hsL2NvcmUvcmVnaW9uLmMNCkBA
IC0zOTcsNyArMzk3LDcgQEAgc3RhdGljIHNzaXplX3QgaW50ZXJsZWF2ZV93YXlzX3N0b3Jl
KHN0cnVjdCBkZXZpY2UgKmRldiwNCiDCoMKgwqDCoCDCoMKgwqAgcmV0dXJuIHJjOw0KDQog
wqDCoMKgwqAgLyoNCi3CoMKgwqAgwqAqIEV2ZW4gZm9yIHgzLCB4OSwgYW5kIHgxMiBpbnRl
cmxlYXZlcyB0aGUgcmVnaW9uIGludGVybGVhdmUgbXVzdCBiZSBhDQorwqDCoMKgIMKgKiBF
dmVuIGZvciB4MywgeDYsIGFuZCB4MTIgaW50ZXJsZWF2ZXMgdGhlIHJlZ2lvbiBpbnRlcmxl
YXZlIG11c3QgYmUgYQ0KIMKgwqDCoMKgIMKgKiBwb3dlciBvZiAyIG11bHRpcGxlIG9mIHRo
ZSBob3N0IGJyaWRnZSBpbnRlcmxlYXZlLg0KIMKgwqDCoMKgIMKgKi8NCiDCoMKgwqDCoCBp
ZiAoIWlzX3Bvd2VyX29mXzIodmFsIC8gY3hsZC0+aW50ZXJsZWF2ZV93YXlzKSB8fA0KLS0g
DQoyLjQyLjANCg0KDQo=

--------------Rh4568pt6Jn9LdFAE0etxsJS--

--------------x875HzidVMv432WWwbPr4dSq
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEelpOgOQAl7r26tY4RJGQ8yNavTsFAmV51ZsFAwAAAAAACgkQRJGQ8yNavTuz
QhAAipxjsQ8C13SIh1PqDIxKD5VgAqDbuKBgWJjAf9o3LZi8NBJF4yFR8ifRtJ9y8//C8sgbHaQf
2yTnqPHskLARSh+BqGW6luRy3n85XnAIDkSOODNafEw8Ex5N6NdQMtL+MAiHSP2ACwzF2Gb64aTB
vZGDuuIX83zFHyxi5UJick9/OdlfTfaW2Fk3Zg/nnNIuwMHAraxBza18jsfTM/KhcTKFaICVZPeL
22ooN7CXnQdCP3k+c4cBwWMjxm+NOD8+mUnQvoK80cQQrKkJaeyX2kRYpfD8MmOAgqkn582Z+2O+
FsCVCVjq9Iw4C6zw4HlHyVG7d3CFTTOTJYtmv+pQfW6eC7CY3fmi3HhaIgTPUEI8AFtH7zZ0sA5H
RtGjHGVQBqmelV+NMl8IrFtW9yVMgArWdbLb3auSpgrjPuztdtLW5klWtGhlntWhKbS2IANEJhHk
3T/m2Zd8tDw0D56rA8rFxnvK6lVCvH0tkKJkzhzdzrgYBYiTIycMprZf+1H2K6LAvIplDRa/8TuI
pexKk0hVCI6ks6srjd6zwVATaGT47+7nv+/ZfG0/vJqxPnTI/Wj1G696a+D4fBNF+h0VR4YynKST
/9D9iudqA4gaPDXYCrwTvQyDlXfPDmASERST8JgOYvThWjs++1TMTowPCWu/zxRSkSW6HkBmqdiD
Xqs=
=NagQ
-----END PGP SIGNATURE-----

--------------x875HzidVMv432WWwbPr4dSq--
