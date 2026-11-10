Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794284378;
	b=l2AhBvZ/FSVV3R/0kZImjg7g/GkP9lhWvaWWjLTtSmvuZIzky0WpyJfUrE2xGj7OewEX
	 bFFGnn4cstvsA5/iLYu35IroW3+/a9s0UmTdSKnuDwosq4Duf6uo/bpwSM4LNndbhfNLd
	 aZWk2Bxd4mT5LiioeK8G1l3v8yHsvRgG8695skfGpCwxIbyyyaivjvXijSYkDBO2AnCwA
	 AIXOJw9Qv7M790/QhS/FeLDu0f350taMIv/cddLU1YrBQO5ZlzE5UNY0OVI/TwBAOnDKL
	 qlGa/ePR2pa1Vqjw3gOjYUH3heRynVl1GPyqT8od08zYJogTd3IDoegNanEG+pQF0Iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794284378;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=akOgOFZaJ6AkC9My1p+5ZWxqR31Lz10lBBUyVueJ0Ek=;
	b=k7uXao2sFQIFU+mqcsCGzXA2F6VuV0rdwsPENtQiY7O5KNPtkCZskXx3uNHR6yAzCdN4
	 066n1qPmy7t+BRvdztXiWhY71RB8T4UZH0sJMubUBbLKB2qQhxbS12u4sWwol6Hs+zn/X
	 n68GFFJ+CIvRB9wtJHeg2lJPhVlFCYy2WSPLHZhD6wzINEjrFMuDCpalKtvLWfxOdRxF8
	 JQU/2u37IwcSRCf2RfIi8XQcTS5+T8BU7dQBP1Z53pjQJ2LlfW8a5Kv+CsPznFZV38RVh
	 Max3jD8GvnP33spTChQB1JDKsrLGxRP7CV0cjpVXdzR+DJoMunU+GKPRX1Swva4VoXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BYW6ru18;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83E7606E8C0
	for <linux-cxl@vger.kernel.org>; Tue, 10 Nov 2026 04:19:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B83E7606E8C0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BYW6ru18
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1aefd1bf74aso1357984c88.1
        for <linux-cxl@vger.kernel.org>; Mon, 09 Nov 2026 20:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794284377; x=1794889177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=akOgOFZaJ6AkC9My1p+5ZWxqR31Lz10lBBUyVueJ0Ek=;
        b=BYW6ru18H3XBx3AsTpAR8Xqn7UK+BaL7xpqsLxLhqN2QvvOiWbVZxKkyqDcuQPdzVW
         2+gpsIN6qgJie5m6wTOQRhX+fUPxLjgcxBll/ZY5p5UUbL0d50ye8w6dG9XoY+qrh79S
         vVkCKtAvNEplr6QFFbhPl5rlOHja0HaBtUjHnvmCGW4fMecoJaMuo0sRvS36ezUY3TJn
         rpl5lcuLVLu+51qXKbkEETsCX/Rp45x3aXYPZ5W9ze4MZOYCpD/pPMmfcTFNTa4MM7O4
         pVBCqfOAZdqwjRZmG0VMJWPLnctGlbgb+BcQqD5NJ7ofHiuG6bpYKdyv2tR/xhNzr2NN
         taMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794284377; x=1794889177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=akOgOFZaJ6AkC9My1p+5ZWxqR31Lz10lBBUyVueJ0Ek=;
        b=noSWOuzq+QiywOvUCq36jWMv+aOwnytNHsxDDi7fUdh3N2VhgnIlCvUGJpo0eGG9yP
         TdNY4Pd47pAedfXN6iMM5ZH93qgJRcX+38ZZ/BdJh7+BTAfQ/T+0vCIjnhj6MJndFRWJ
         jvbwU5mNOVllYFJexCr76CI7SH9wfar33wd1eXYqAJs/mCQdQSSFBDVpSCQmSgxEuriR
         ajEeV36VmoEfzEKb1Dn6BsKHmzeQN4b6Sf9cdTKMsUK+tnYTlUq7lEqyhgDXqif+KDN0
         UnowtlStymI598hTWxij9AZmJt12j4129uNmnHt/+KGNa9WcuixA53ybTdZzRirySwZQ
         /Aww==
X-Forwarded-Encrypted: i=1; AL+hErEEYDFC79ngFkubTBhgprJjiSMQ/V//Y0jVKIRgqWwf4kEJ5UKHmhACnAXuV3MRL4a5JpwJ9h2QDh4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Ojq4qUeqeB2wjf1Rz9wo+ZVWS2cTw7+l/WUtv9NdbggRMKVeS
	r3BfiKzUHkmSU4a1sb8/bfZTH8VUh/Z0gklEqbV3V8dZucONzsun7uRd
X-Gm-Gg: AYBFou2Nq7qOdS3a23IYl6SOYO2bIVRZs+Ke+R+D2HS11iMgsNCiL43o2V/bmOEblr1
	BDf82YGrsixkd+jewK5JzAOfBIlZwYwKDNVg6f91I7czHuNClJ2AtcZRE1Pav3thIL1riWi478O
	8efuvrWTAAoBfqIK8TuLbShguZWyDbdPbKnqws5Sb117dsSW7D/vdG3n3zdQByjEz31pBtnTSqk
	20kK3noMaVvbUE7SsXFPTv5Bd5fOvFJdre4Ug2/51Ohn9pFWT89vqqBLvMR0HhJAhcKZc9mUXkl
	ss2U+YWIsNwj9W/GVDdqeuoA2qdKrzeZ2xJsFFQp6VlV+aIFE02sXaCEFuSV9Dwh6bwOKyAEy0R
	tk5QsgIuwdt8IICWxlSXm/ocP+SzO1TWyOEekyp/HRc9y/jO6+aATOJuSSfkBMdahyFuOVgLLXf
	qnMUYPZSnf5fvPGFIeVxIuA/wpuV/Icdh5Adbo9HSa/Z2DmEovkVG/7gXtBPDvoOBfTivmBj9z6
	oECb/dQfL4nPUxbdYaR1BkUxqXLok7eDwe/4UR1ex93XWyN3HyP4iow0x3J2PYHnsdG8UUmpQT0
	2paYdhT+v1qKpkt3IMmSQMt6GGDgww4u9ZlOcsUQOghuLtw=
X-Received: by 2002:a05:701b:4502:10b0:1ab:90a8:87a2 with SMTP id a92af1059eb24-1b3b5e25dbcmr1978641c88.11.1794284376568;
        Mon, 09 Nov 2026 20:19:36 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b7ba88sm3540459c88.22.2026.11.09.20.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 20:19:35 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: bhelgaas@google.com,
	lukas@wunner.de,
	bvanassche@acm.org,
	linux-pci@vger.kernel.org,
	alistair@alistair23.me,
	linux-cxl@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	rust-for-linux@vger.kernel.org,
	jgg@nvidia.com,
	akpm@linux-foundation.org
Cc: gary@garyguo.net,
	a.hindborg@kernel.org,
	wilfred.mallawa@wdc.com,
	tmgross@umich.edu,
	ojeda@kernel.org,
	boqun.feng@gmail.com,
	alistair23@gmail.com,
	gregkh@linuxfoundation.org,
	aliceryhl@google.com,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	alex.gaynor@gmail.com,
	Dan Williams <dan.j.williams@intel.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v6 06/25] X.509: Move certificate length retrieval into new helper
Date: Tue, 10 Nov 2026 14:18:13 +1000
Message-ID: <20261110041832.1730924-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110041832.1730924-1-alistair.francis@wdc.com>
References: <20261110041832.1730924-1-alistair.francis@wdc.com>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Wunner <lukas@wunner.de>

The upcoming in-kernel SPDM library (Security Protocol and Data Model,
https://www.dmtf.org/dsp/DSP0274) needs to retrieve the length from
ASN.1 DER-encoded X.509 certificates.

Such code already exists in x509_load_certificate_list(), so move it
into a new helper for reuse by SPDM.

Export the helper so that SPDM can be tristate.  (Some upcoming users of
the SPDM library may be modular, such as SCSI and ATA.)

No functional change intended.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 crypto/asymmetric_keys/x509_loader.c | 38 +++++++++++++++++++---------
 include/keys/asymmetric-type.h       |  2 ++
 2 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/crypto/asymmetric_keys/x509_loader.c b/crypto/asymmetric_keys/x509_loader.c
index 0d516c77cc26a..174451b93edad 100644
--- a/crypto/asymmetric_keys/x509_loader.c
+++ b/crypto/asymmetric_keys/x509_loader.c
@@ -4,28 +4,42 @@
 #include <linux/key.h>
 #include <keys/asymmetric-type.h>
 
+ssize_t x509_get_certificate_length(const u8 *p, unsigned long buflen)
+{
+	ssize_t plen;
+
+	/* Each cert begins with an ASN.1 SEQUENCE tag and must be more
+	 * than 256 bytes in size.
+	 */
+	if (buflen < 4)
+		return -EINVAL;
+
+	if (p[0] != 0x30 ||
+	    p[1] != 0x82)
+		return -EINVAL;
+
+	plen = (p[2] << 8) | p[3];
+	plen += 4;
+	if (plen > buflen)
+		return -EINVAL;
+
+	return plen;
+}
+EXPORT_SYMBOL_GPL(x509_get_certificate_length);
+
 int x509_load_certificate_list(const u8 cert_list[],
 			       const unsigned long list_size,
 			       const struct key *keyring)
 {
 	key_ref_t key;
 	const u8 *p, *end;
-	size_t plen;
+	ssize_t plen;
 
 	p = cert_list;
 	end = p + list_size;
 	while (p < end) {
-		/* Each cert begins with an ASN.1 SEQUENCE tag and must be more
-		 * than 256 bytes in size.
-		 */
-		if (end - p < 4)
-			goto dodgy_cert;
-		if (p[0] != 0x30 ||
-		    p[1] != 0x82)
-			goto dodgy_cert;
-		plen = (p[2] << 8) | p[3];
-		plen += 4;
-		if (plen > end - p)
+		plen = x509_get_certificate_length(p, end - p);
+		if (plen < 0)
 			goto dodgy_cert;
 
 		key = key_create_or_update(make_key_ref(keyring, 1),
diff --git a/include/keys/asymmetric-type.h b/include/keys/asymmetric-type.h
index 1b91c8f98688d..301efa952e263 100644
--- a/include/keys/asymmetric-type.h
+++ b/include/keys/asymmetric-type.h
@@ -84,6 +84,8 @@ extern struct key *find_asymmetric_key(struct key *keyring,
 				       const struct asymmetric_key_id *id_2,
 				       bool partial);
 
+ssize_t x509_get_certificate_length(const u8 *p, unsigned long buflen);
+
 int x509_load_certificate_list(const u8 cert_list[], const unsigned long list_size,
 			       const struct key *keyring);
 
-- 
2.56.0

