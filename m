Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9083139B4AE
	for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 20:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788207900; cv=none; b=W33xR9P1G6JOXsPWaHI211OJY+NfzWMZ7Q6nP0zOWvv7T5KQsPy4gBNDpwStd9h+bhxUTMkoga/zt++WiCy0TEgLVAE4s4VgCMsaQW5/xfZZD43buUWeGKHBGHE6qjrx1qMVjGL+TmvrNuDQ1HpbhV3iUmpWig1o9rCR0IDMgio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788207900; c=relaxed/simple;
	bh=CWFQ/+Vl17Zve5N6MGDfPHhItoDk9FOs8IEZXpT/KiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=fxrTpkfXg35rjgebdtI3TcNhztkkAypV3efB0Rh+yf3UV1MrZn8qUM/bZEuq9+oIRHYfgPsv3OMa1EfKM5/CZ2QzcxzxYEtWKJ2nkNnrPoxevVOYx+nhLujwvqWDykTVVrhWdEar6XRqHNyeDVWAGBhSA2v64AjLj9B33hkYIyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y/pu+ogf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y/pu+ogf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788207897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UCP7UVj7lY6yPKsok5GRRYDTHAJpEfy9IihCRm+r6Qo=;
	b=Y/pu+ogfKQRLH1lBrPThhUIeyS0mmMkqZZsI/06Faddc/wKmO0wlVPzTOUJq7RfZyoPAwT
	E9oDsSOINmA3B185sHuFaILnJ9bfzVHIXiknTtZRdiq1e7iVC3RZObgN4yzQdYyJ1RNq6O
	7WX0DH7HJbY725G76GIaEkxDy5ymJmg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-RVxOMb3bPMe3ej89Z94FQg-1; Mon,
 31 Aug 2026 16:24:54 -0400
X-MC-Unique: RVxOMb3bPMe3ej89Z94FQg-1
X-Mimecast-MFC-AGG-ID: RVxOMb3bPMe3ej89Z94FQg_1788207891
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AC9C7191FCCC;
	Mon, 31 Aug 2026 20:24:51 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.63])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8290B1800347;
	Mon, 31 Aug 2026 20:24:44 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Lukas Straub <lukasstraub2@web.de>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Jonathan Cameron <jic23@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Markus Armbruster <armbru@redhat.com>,
	Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
	Jiri Pirko <jiri@resnulli.us>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	qemu-block@nongnu.org,
	Ani Sinha <anisinha@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	linux-cxl@vger.kernel.org,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Hanna Reitz <hreitz@redhat.com>,
	Alex Williamson <alex@shazbot.org>,
	Stefan Berger <stefanb@linux.vnet.ibm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Laurent Vivier <laurent@vivier.eu>,
	linux-edac@vger.kernel.org,
	Michael Tokarev <mjt@tls.msk.ru>,
	John Snow <jsnow@redhat.com>,
	Fabiano Rosas <farosas@suse.de>,
	Zhao Liu <zhao1.liu@intel.com>,
	"Gonglei (Arei)" <arei.gonglei@huawei.com>,
	Eric Blake <eblake@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Kevin Wolf <kwolf@redhat.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	qemu-trivial@nongnu.org,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v4 33/43] qapi: convert trivial intro sections for crypto.json
Date: Mon, 31 Aug 2026 16:19:35 -0400
Message-ID: <20260831201945.287730-34-jsnow@redhat.com>
In-Reply-To: <20260831201945.287730-1-jsnow@redhat.com>
References: <20260831201945.287730-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: ihY7ggUKG6d1jX_stbO6c0FVGl2Jsgl0k3pC5coLcGw_1788207891
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/crypto.json | 100 +++++++++++++++++------------------------------
 1 file changed, 36 insertions(+), 64 deletions(-)

diff --git a/qapi/crypto.json b/qapi/crypto.json
index 6e3a98ff68b..5e395bc10c7 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -26,8 +26,7 @@
 
 ##
 # @QCryptoSecretFormat:
-#
-# The data format that the secret is provided in
+#     The data format that the secret is provided in
 #
 # @raw: raw bytes.  When encoded in JSON only valid UTF-8 sequences
 #     can be used
@@ -41,8 +40,7 @@
 
 ##
 # @QCryptoHashAlgo:
-#
-# The supported algorithms for computing content digests
+#     The supported algorithms for computing content digests
 #
 # @md5: MD5.  Should not be used in any new code, legacy compat only
 #
@@ -68,8 +66,7 @@
 
 ##
 # @QCryptoCipherAlgo:
-#
-# The supported algorithms for content encryption ciphers
+#     The supported algorithms for content encryption ciphers
 #
 # @aes-128: AES with 128 bit / 16 byte keys
 #
@@ -110,8 +107,7 @@
 
 ##
 # @QCryptoCipherMode:
-#
-# The supported modes for content encryption ciphers
+#     The supported modes for content encryption ciphers
 #
 # @ecb: Electronic Code Book
 #
@@ -150,8 +146,7 @@
 
 ##
 # @QCryptoBlockFormat:
-#
-# The supported full disk encryption formats
+#     The supported full disk encryption formats
 #
 # @qcow: QCow/QCow2 built-in AES-CBC encryption.  Use only for
 #     liberating data from old images.
@@ -165,8 +160,8 @@
 
 ##
 # @QCryptoBlockOptionsBase:
-#
-# The common options that apply to all full disk encryption formats
+#     The common options that apply to all full disk encryption
+#     formats
 #
 # @format: the encryption format
 #
@@ -177,8 +172,7 @@
 
 ##
 # @QCryptoBlockOptionsQCow:
-#
-# The options that apply to QCow/QCow2 AES-CBC encryption format
+#     The options that apply to QCow/QCow2 AES-CBC encryption format
 #
 # @key-secret: the ID of a QCryptoSecret object providing the
 #     decryption key.  Mandatory except when probing image for
@@ -191,8 +185,7 @@
 
 ##
 # @QCryptoBlockOptionsLUKS:
-#
-# The options that apply to LUKS encryption format
+#     The options that apply to LUKS encryption format
 #
 # @key-secret: the ID of a QCryptoSecret object providing the
 #     decryption key.  Mandatory except when probing image for
@@ -205,8 +198,7 @@
 
 ##
 # @QCryptoBlockCreateOptionsLUKS:
-#
-# The options that apply to LUKS encryption format initialization
+#     The options that apply to LUKS encryption format initialization
 #
 # @cipher-alg: the cipher algorithm for data encryption.  Currently
 #     defaults to 'aes-256'.
@@ -239,9 +231,8 @@
 
 ##
 # @QCryptoBlockOpenOptions:
-#
-# The options that are available for all encryption formats when
-# opening an existing volume
+#     The options that are available for all encryption formats when
+#     opening an existing volume
 #
 # Since: 2.6
 ##
@@ -253,9 +244,8 @@
 
 ##
 # @QCryptoBlockCreateOptions:
-#
-# The options that are available for all encryption formats when
-# initializing a new volume
+#     The options that are available for all encryption formats when
+#     initializing a new volume
 #
 # Since: 2.6
 ##
@@ -267,9 +257,8 @@
 
 ##
 # @QCryptoBlockInfoBase:
-#
-# The common information that applies to all full disk encryption
-# formats
+#     The common information that applies to all full disk encryption
+#     formats
 #
 # @format: the encryption format
 #
@@ -280,8 +269,7 @@
 
 ##
 # @QCryptoBlockInfoLUKSSlot:
-#
-# Information about the LUKS block encryption key slot options
+#     Information about the LUKS block encryption key slot options
 #
 # @active: whether the key slot is currently in use
 #
@@ -301,8 +289,7 @@
 
 ##
 # @QCryptoBlockInfoLUKS:
-#
-# Information about the LUKS block encryption options
+#     Information about the LUKS block encryption options
 #
 # @cipher-alg: the cipher algorithm for data encryption
 #
@@ -340,8 +327,7 @@
 
 ##
 # @QCryptoBlockInfo:
-#
-# Information about the block encryption options
+#     Information about the block encryption options
 #
 # Since: 2.7
 ##
@@ -352,8 +338,7 @@
 
 ##
 # @QCryptoBlockLUKSKeyslotState:
-#
-# Defines state of keyslots that are affected by the update
+#     Defines state of keyslots that are affected by the update
 #
 # @active: The slots contain the given password and marked as active
 #
@@ -367,9 +352,8 @@
 
 ##
 # @QCryptoBlockAmendOptionsLUKS:
-#
-# This struct defines the update parameters that activate/de-activate
-# set of keyslots
+#     This struct defines the update parameters that
+#     activate/de-activate set of keyslots
 #
 # @state: the desired state of the keyslots
 #
@@ -409,9 +393,8 @@
 
 ##
 # @QCryptoBlockAmendOptions:
-#
-# The options that are available for all encryption formats when
-# amending encryption settings
+#     The options that are available for all encryption formats when
+#     amending encryption settings
 #
 # Since: 5.1
 ##
@@ -423,8 +406,7 @@
 
 ##
 # @SecretCommonProperties:
-#
-# Properties for objects of classes derived from secret-common.
+#     Properties for objects of classes derived from secret-common.
 #
 # @format: the data format that the secret is provided in
 #     (default: raw)
@@ -465,8 +447,7 @@
 
 ##
 # @SecretKeyringProperties:
-#
-# Properties for secret_keyring objects.
+#     Properties for secret_keyring objects.
 #
 # @serial: serial number that identifies a key to get from the kernel
 #
@@ -479,8 +460,7 @@
 
 ##
 # @TlsCredsProperties:
-#
-# Properties for objects of classes derived from tls-creds.
+#     Properties for objects of classes derived from tls-creds.
 #
 # @verify-peer: if true the peer credentials will be verified once the
 #     handshake is completed.  This is a no-op for anonymous
@@ -505,8 +485,7 @@
 
 ##
 # @TlsCredsAnonProperties:
-#
-# Properties for tls-creds-anon objects.
+#     Properties for tls-creds-anon objects.
 #
 # Since: 2.5
 ##
@@ -516,8 +495,7 @@
 
 ##
 # @TlsCredsPskProperties:
-#
-# Properties for tls-creds-psk objects.
+#     Properties for tls-creds-psk objects.
 #
 # @username: the username which will be sent to the server.  For
 #     clients only.  If absent, "qemu" is sent and the property will
@@ -531,8 +509,7 @@
 
 ##
 # @TlsCredsX509Properties:
-#
-# Properties for tls-creds-x509 objects.
+#     Properties for tls-creds-x509 objects.
 #
 # @sanity-check: if true, perform some sanity checks before using the
 #     credentials (default: true)
@@ -552,8 +529,7 @@
 
 ##
 # @QCryptoAkCipherAlgo:
-#
-# The supported algorithms for asymmetric encryption ciphers
+#     The supported algorithms for asymmetric encryption ciphers
 #
 # @rsa: RSA algorithm
 #
@@ -564,8 +540,7 @@
 
 ##
 # @QCryptoAkCipherKeyType:
-#
-# The type of asymmetric keys.
+#     The type of asymmetric keys.
 #
 # @public: public key
 #
@@ -578,8 +553,7 @@
 
 ##
 # @QCryptoRSAPaddingAlgo:
-#
-# The padding algorithm for RSA.
+#     The padding algorithm for RSA.
 #
 # @raw: no padding used
 #
@@ -592,8 +566,7 @@
 
 ##
 # @QCryptoAkCipherOptionsRSA:
-#
-# Specific parameters for RSA algorithm.
+#     Specific parameters for RSA algorithm.
 #
 # @hash-alg: `QCryptoHashAlgo`
 #
@@ -607,9 +580,8 @@
 
 ##
 # @QCryptoAkCipherOptions:
-#
-# The options that are available for all asymmetric key algorithms
-# when creating a new QCryptoAkCipher.
+#     The options that are available for all asymmetric key algorithms
+#     when creating a new QCryptoAkCipher.
 #
 # @alg: encryption cipher algorithm
 #
-- 
2.55.0

