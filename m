Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BA13A8FE1
	for <linux-cxl@vger.kernel.org>; Tue, 23 Jun 2026 04:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782190511; cv=none; b=lr44Rn3dgz9Tj+7qiH3ibW4I6bMk2bfA2FObpRorIJRTr18I8zQ51rcrvUYcFYvbCxhiqd5DLgVBGUdxuCPKlN4r4hz/DcEbLT48j3MvOqzaMUp0fuVKNXKld2jEli58eVPtCEoK5wgq6JjZjjrezZt0dIGXmBLwK7vcpQmLx50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782190511; c=relaxed/simple;
	bh=yZUv7mHEjRiCBLwdrj4DyQct/UPESpR42MXV0lXcuxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rdqe3RXceeicU3T1hG22dlg1Siy0EB7JaYH8uDvHfp1YbKc6FIclgzHmxF+0435sBocoErrTgjzqSSEjRHL8gMZ2/F1iPU7wrJ/uEgMzMyN+uxsLI0zNLP3eCqfD54KlZcHpKb4Dmke8j0tFTtkOvJMal0SXvjA1/+oMHJOrHvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HxEDmi1q; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxEDmi1q"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2c0b9328c4aso36798305ad.0
        for <linux-cxl@vger.kernel.org>; Mon, 22 Jun 2026 21:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782190509; x=1782795309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H8aXMdr+mkXyTo6jtSYYnrRZNLYOcPsK1e5K9rpBo7k=;
        b=HxEDmi1qgzuhOCyNrAyAXOVCGJym7ASjg33p59b1mYYWZLXNayY10547WS12J5W5Ql
         jEbum2Z9vBfXMZtTpysab/jrwcsZ4v11lvym7DypbEVNeI4nxbEfARFJ7TggggDj71jp
         HATMvMZfPdrqegcEPPpnNLM91MH3O/CK4UUVE4lQrzc6W6vDvfczP4B/86b7sXtuIarQ
         rBFPgh8Crj5ghmfKz93FimpCtHK8cKZ/fdLE6pBtIejbyAwHHlJs0lHBw+LVjFd5W1v6
         N86ambm6TqbHcdEL/6lIYwhYhpfatolwuS80Q8wloiomSpdBxKl/MOXByt/DQWr68hWr
         DNWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782190509; x=1782795309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H8aXMdr+mkXyTo6jtSYYnrRZNLYOcPsK1e5K9rpBo7k=;
        b=Puug1UA+fOPSglMpmBCBe3nNQ8580fa73CwG7FIBCVOFAz85s/N5pgoeCDRyFp492N
         U5/PtYyD/NjYdABa+9gfnd4xNXOCv9fIibzD6O69hrKrp3BB22ingGLafKriVA/3Qaz9
         93fOL3Fq+JSLt+8OK8t/RsrgGOIRkFHdRJ2UtyMGmG1h1j6HPzB3uTPUwgtbJ0uLOOHv
         oKyICJdpoYTQ2WhkRIo7SBreNvWXzQRnuiLtw/S9tI+aix7F5lh5aZ5lqasY7tVAe8Sg
         dbTHeozEfPLohSjZnrDHmjihPG9U5QotsqVaUxBfiPl/J6XzG/nbD5usDFbOgzGtZ/HY
         BY9w==
X-Forwarded-Encrypted: i=1; AHgh+RrD6iSsP6tlVQm5xNTkrlHCg541ZUMBw8QgHqccybqI5/fFZNaFnfJ2B3aA2h4jSblxyDE94xQIazk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy43aYX6rYB3Jf7yyGtGoyGSzvhc9FrxTQ3pIDViMCcXRi9U9pM
	uwXftLz7KcpqAxsflHGls44Xc425XkVrUfJQvsiEXt6IxzwacjmCx8AL
X-Gm-Gg: AfdE7cku4UOGxB3JkvDr9Ct7A9alDyHCb9hsZ/yJ6qLU9W2wsHMXW2vK8VIH5M2RdDA
	mZNWWLRMKdQe8N1GltaHSnEEJiG6UVs4IO7PXsKbGuPvQSO+e25JsLf9ytI3kcGhn3Dxfd8Z57e
	s48/0mLJWS1hPIHov7KtZl5uyWEY91kka3JzuTszNMF4s672/yFQJUlFBe4yJshC8bUUqyoZI4q
	gtjLRBlU5G5IRQLQ7gF0fXUqjlber3LMtLdPlLt9EE06fVUsHOW+609SWmjxnlrQqjnDQosmKgp
	a8Iw/XZ97VIxOQPq1289EIE97W+4e7IOcRjiBe9+IdNGtj56YXfgYOu6KN+7b1CrssSoEzk5JLk
	C0Ct2ylckJqhfKp72iCBU0GKJZ65/+ToKW1TXt3tr2uVk1/3yP3cB9pwH5TAq+hxeoCCy1AqbtI
	SFSJXQsjtFsnbLN33wZIZTU0r/zbpJ0g==
X-Received: by 2002:a17:902:d505:b0:2bf:23c3:34ba with SMTP id d9443c01a7336-2c742b3e10emr130893915ad.28.1782190509121;
        Mon, 22 Jun 2026 21:55:09 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7439f8cf0sm89734785ad.50.2026.06.22.21.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 21:55:08 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: akpm@linux-foundation.org,
	rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org,
	jic23@kernel.org,
	bhelgaas@google.com,
	lukas@wunner.de,
	alistair@alistair23.me,
	linux-cxl@vger.kernel.org,
	djbw@kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan.Cameron@huawei.com
Cc: alistair23@gmail.com,
	boqun.feng@gmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	bjorn3_gh@protonmail.com,
	gary@garyguo.net,
	wilfred.mallawa@wdc.com,
	aliceryhl@google.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	tmgross@umich.edu,
	Dan Williams <dan.j.williams@intel.com>,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 06/21] X.509: Move certificate length retrieval into new helper
Date: Tue, 23 Jun 2026 14:53:51 +1000
Message-ID: <20260623045406.2589547-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623045406.2589547-1-alistair.francis@wdc.com>
References: <20260623045406.2589547-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Wunner <lukas@wunner.de>

The upcoming in-kernel SPDM library (Security Protocol and Data Model,
https://www.dmtf.org/dsp/DSP0274) needs to retrieve the length from
ASN.1 DER-encoded X.509 certificates.

Such code already exists in x509_load_certificate_list(), so move it
into a new helper for reuse by SPDM.

Export the helper so that SPDM can be tristate.  (Some upcoming users of
the SPDM libray may be modular, such as SCSI and ATA.)

No functional change intended.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 crypto/asymmetric_keys/x509_loader.c | 38 +++++++++++++++++++---------
 include/keys/asymmetric-type.h       |  2 ++
 2 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/crypto/asymmetric_keys/x509_loader.c b/crypto/asymmetric_keys/x509_loader.c
index 0d516c77cc26..174451b93eda 100644
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
index 1b91c8f98688..301efa952e26 100644
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
2.54.0

