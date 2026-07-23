Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C8F38D3F2
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jul 2026 04:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784782456; cv=none; b=Fv+qSytWD6vEpRYJJ/0HdZuZPhhVgKe0s4Ui5S+F5eEXOat4vW1XAckU8T2GMyQ8xeI6kuRS7jv0B/oDBkRW1RJ6z40dYGxynfpyQVUteSnOp+a3CGbsYzGSZOcAmUTnptPt8KAr2qxASf5rRuldBg89xuNySww3qmKgNTNyLbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784782456; c=relaxed/simple;
	bh=dKZABxNrtm9vqZ744nFaTLRvrjdmtbBOduDI2nOcFqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=su7juhyRTru3y5ZywSYKwai7K75UswvmTSrD52LUiIgTxPH9u064IhF5wqYNk4hh3TvuNBCQvYQZ9tUrByyGi2fWbvaVH904v2FWwlZ7wE45oA3jnGtOwzAyX5nHwV01t7WZZxIT+jEH2vVUKIP9rwSA7e1wPREeZKz2YDPeZr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CRiHaFej; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CRiHaFej"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784782444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lCYDP6Hrj8CzePr1mYVT3Ek4VxvkfuHjDMXZ3o0GlI0=;
	b=CRiHaFejuX8FuOTDQebUS1MZxZ3L3OdQRtTWm5tEQfRrjoXdBD3xbO/I5xklZpMlVPszqD
	w6tcYeapSWWy8hDgisThYBd2+Zza3tXe/q6AWYvDEmH9Q/3J8CuTpyIF/u+HRwIQxTM5np
	uXqHzsp1fXL3N+Jdnn9w4fM88eTz9Sk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-186-flsMf9TDOHOS0HUxRx7iBg-1; Thu,
 23 Jul 2026 00:53:59 -0400
X-MC-Unique: flsMf9TDOHOS0HUxRx7iBg-1
X-Mimecast-MFC-AGG-ID: flsMf9TDOHOS0HUxRx7iBg_1784782436
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EE8051955DEA;
	Thu, 23 Jul 2026 04:53:55 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.44])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D62A618002AE;
	Thu, 23 Jul 2026 04:53:45 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Lukas Straub <lukasstraub2@web.de>,
	Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
	Zhao Liu <zhao1.liu@intel.com>,
	Laurent Vivier <laurent@vivier.eu>,
	Markus Armbruster <armbru@redhat.com>,
	"Gonglei (Arei)" <arei.gonglei@huawei.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	Alex Williamson <alex@shazbot.org>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hanna Reitz <hreitz@redhat.com>,
	Ani Sinha <anisinha@redhat.com>,
	qemu-block@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	Kevin Wolf <kwolf@redhat.com>,
	linux-cxl@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Stefan Berger <stefanb@linux.vnet.ibm.com>,
	Fabiano Rosas <farosas@suse.de>,
	John Snow <jsnow@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Michael Tokarev <mjt@tls.msk.ru>,
	Igor Mammedov <imammedo@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-edac@vger.kernel.org,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Eric Blake <eblake@redhat.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	qemu-trivial@nongnu.org,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v2 34/44] qapi: convert trivial intro sections for crypto.json
Date: Thu, 23 Jul 2026 00:47:55 -0400
Message-ID: <20260723044805.527643-35-jsnow@redhat.com>
In-Reply-To: <20260723044805.527643-1-jsnow@redhat.com>
References: <20260723044805.527643-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: OEVu7tN0pUQI_AwOc8hefxzoJdIPAYiT1uM-tZvp5Nw_1784782436
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

(Trivial)

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/crypto.json | 118 ++++++++++++++++++-----------------------------
 1 file changed, 45 insertions(+), 73 deletions(-)

diff --git a/qapi/crypto.json b/qapi/crypto.json
index 2b55befef97..5c821be1a33 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -10,10 +10,10 @@
 
 ##
 # @QCryptoTLSCredsEndpoint:
-#
-# The type of network endpoint that will be using the credentials.
-# Most types of credential require different setup / structures
-# depending on whether they will be used in a server versus a client.
+#     The type of network endpoint that will be using the credentials.
+#     Most types of credential require different setup / structures
+#     depending on whether they will be used in a server versus a
+#     client.
 #
 # @client: the network endpoint is acting as the client
 #
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
@@ -128,11 +124,11 @@
 
 ##
 # @QCryptoIVGenAlgo:
-#
-# The supported algorithms for generating initialization vectors for
-# full disk encryption.  The 'plain' generator should not be used for
-# disks with sector numbers larger than 2^32, except where
-# compatibility with pre-existing Linux dm-crypt volumes is required.
+#     The supported algorithms for generating initialization vectors
+#     for full disk encryption.  The 'plain' generator should not be
+#     used for disks with sector numbers larger than 2^32, except
+#     where compatibility with pre-existing Linux dm-crypt volumes is
+#     required.
 #
 # @plain: 64-bit sector number truncated to 32-bits
 #
@@ -148,8 +144,7 @@
 
 ##
 # @QCryptoBlockFormat:
-#
-# The supported full disk encryption formats
+#     The supported full disk encryption formats
 #
 # @qcow: QCow/QCow2 built-in AES-CBC encryption.  Use only for
 #     liberating data from old images.
@@ -163,8 +158,8 @@
 
 ##
 # @QCryptoBlockOptionsBase:
-#
-# The common options that apply to all full disk encryption formats
+#     The common options that apply to all full disk encryption
+#     formats
 #
 # @format: the encryption format
 #
@@ -175,8 +170,7 @@
 
 ##
 # @QCryptoBlockOptionsQCow:
-#
-# The options that apply to QCow/QCow2 AES-CBC encryption format
+#     The options that apply to QCow/QCow2 AES-CBC encryption format
 #
 # @key-secret: the ID of a QCryptoSecret object providing the
 #     decryption key.  Mandatory except when probing image for
@@ -189,8 +183,7 @@
 
 ##
 # @QCryptoBlockOptionsLUKS:
-#
-# The options that apply to LUKS encryption format
+#     The options that apply to LUKS encryption format
 #
 # @key-secret: the ID of a QCryptoSecret object providing the
 #     decryption key.  Mandatory except when probing image for
@@ -203,8 +196,7 @@
 
 ##
 # @QCryptoBlockCreateOptionsLUKS:
-#
-# The options that apply to LUKS encryption format initialization
+#     The options that apply to LUKS encryption format initialization
 #
 # @cipher-alg: the cipher algorithm for data encryption.  Currently
 #     defaults to 'aes-256'.
@@ -237,9 +229,8 @@
 
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
@@ -251,9 +242,8 @@
 
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
@@ -265,9 +255,8 @@
 
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
@@ -278,8 +267,7 @@
 
 ##
 # @QCryptoBlockInfoLUKSSlot:
-#
-# Information about the LUKS block encryption key slot options
+#     Information about the LUKS block encryption key slot options
 #
 # @active: whether the key slot is currently in use
 #
@@ -299,8 +287,7 @@
 
 ##
 # @QCryptoBlockInfoLUKS:
-#
-# Information about the LUKS block encryption options
+#     Information about the LUKS block encryption options
 #
 # @cipher-alg: the cipher algorithm for data encryption
 #
@@ -338,8 +325,7 @@
 
 ##
 # @QCryptoBlockInfo:
-#
-# Information about the block encryption options
+#     Information about the block encryption options
 #
 # Since: 2.7
 ##
@@ -350,8 +336,7 @@
 
 ##
 # @QCryptoBlockLUKSKeyslotState:
-#
-# Defines state of keyslots that are affected by the update
+#     Defines state of keyslots that are affected by the update
 #
 # @active: The slots contain the given password and marked as active
 #
@@ -365,9 +350,8 @@
 
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
@@ -407,9 +391,8 @@
 
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
@@ -421,8 +404,7 @@
 
 ##
 # @SecretCommonProperties:
-#
-# Properties for objects of classes derived from secret-common.
+#     Properties for objects of classes derived from secret-common.
 #
 # @format: the data format that the secret is provided in
 #     (default: raw)
@@ -463,8 +445,7 @@
 
 ##
 # @SecretKeyringProperties:
-#
-# Properties for secret_keyring objects.
+#     Properties for secret_keyring objects.
 #
 # @serial: serial number that identifies a key to get from the kernel
 #
@@ -477,8 +458,7 @@
 
 ##
 # @TlsCredsProperties:
-#
-# Properties for objects of classes derived from tls-creds.
+#     Properties for objects of classes derived from tls-creds.
 #
 # @verify-peer: if true the peer credentials will be verified once the
 #     handshake is completed.  This is a no-op for anonymous
@@ -503,8 +483,7 @@
 
 ##
 # @TlsCredsAnonProperties:
-#
-# Properties for tls-creds-anon objects.
+#     Properties for tls-creds-anon objects.
 #
 # Since: 2.5
 ##
@@ -514,8 +493,7 @@
 
 ##
 # @TlsCredsPskProperties:
-#
-# Properties for tls-creds-psk objects.
+#     Properties for tls-creds-psk objects.
 #
 # @username: the username which will be sent to the server.  For
 #     clients only.  If absent, "qemu" is sent and the property will
@@ -529,8 +507,7 @@
 
 ##
 # @TlsCredsX509Properties:
-#
-# Properties for tls-creds-x509 objects.
+#     Properties for tls-creds-x509 objects.
 #
 # @sanity-check: if true, perform some sanity checks before using the
 #     credentials (default: true)
@@ -550,8 +527,7 @@
 
 ##
 # @QCryptoAkCipherAlgo:
-#
-# The supported algorithms for asymmetric encryption ciphers
+#     The supported algorithms for asymmetric encryption ciphers
 #
 # @rsa: RSA algorithm
 #
@@ -562,8 +538,7 @@
 
 ##
 # @QCryptoAkCipherKeyType:
-#
-# The type of asymmetric keys.
+#     The type of asymmetric keys.
 #
 # @public: public key
 #
@@ -576,8 +551,7 @@
 
 ##
 # @QCryptoRSAPaddingAlgo:
-#
-# The padding algorithm for RSA.
+#     The padding algorithm for RSA.
 #
 # @raw: no padding used
 #
@@ -590,8 +564,7 @@
 
 ##
 # @QCryptoAkCipherOptionsRSA:
-#
-# Specific parameters for RSA algorithm.
+#     Specific parameters for RSA algorithm.
 #
 # @hash-alg: `QCryptoHashAlgo`
 #
@@ -605,9 +578,8 @@
 
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

