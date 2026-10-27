Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793078777;
	b=i/2iQ67qGkxE4XefSL5k0sFVffEcGa14bX70Gt5Cw7m+jsuUWf3Or1e6p3knrB0LyvCC
	 sUa3rpG/kk94u5jiPsJnvgpNhrN0zlBjtaw20W1S1vJufBOjm9CjduQzW3yDFuqxoJFXj
	 mlAf7+AvBCroJLsFR8J+6w3fnE8c3CKcsBNx2sp6GqVzbHW1WLbBOAHQdSlq5+b+NhmZJ
	 6T8u64/2mli7DG4rt90A9lGhiAn/oj/EuzZGCe5bvRmfMs87GIaA5wdaYXqzKKkIABDZN
	 jy03x0nB4UiIYu1InJclpku8ZmIm4MYxnKvo+RIbfGY4rINIDAjiWaSx+TwLapunSQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793078777;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=jPU4IMrUNrr8h45vc8EL5JTCvYSHe/yNNj7XMONjgu8=;
	b=bnkJ2LyZHp1LTHH1jlx0ImAymjGXuw6JQvIvwXQMJ+oqvNXlqDavBuxhCgntiCyY55yw
	 FpHkpV8r2Ha14L18SgbwHhxCOyXNP6+wTBoX2/j/oe9v6uvFeu/FPwA9ChKnUwHyC58JS
	 5nS8meTON73hFNrCqOSQga0uLPPFIpmpvoPytcul6XIr8ynEzFoRCcums4BvDG2vuBUmq
	 cp+R4GrOyd4DJtCHmEPnb/NZqKihpBLJrAoORirvD8ymRatBPdElSjHsUSUf8Docn9hNZ
	 q0ShWipIhIVot/5VrTT+WgqOvUlpd+HZUom8AcQjmhZRisJPE3HDbTDfQZ7eJcD3LLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cs3qXRCT;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113BD606A320
	for <linux-cxl@vger.kernel.org>; Tue, 27 Oct 2026 05:26:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 113BD606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cs3qXRCT
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e99b1e5b4cso20818445ad.0
        for <linux-cxl@vger.kernel.org>; Mon, 26 Oct 2026 22:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793078776; x=1793683576; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jPU4IMrUNrr8h45vc8EL5JTCvYSHe/yNNj7XMONjgu8=;
        b=cs3qXRCTz9nB2wngbl4nhivYX1L5cGCnAZIM5Vc4Sie58g9/yh8EBNZXs4YlJF33OO
         8Kaj7KE6oiinLgTv6Q8F7EediA/jRQgxS/K5nddpxBBhkUd72ZiumOJpZ1GUT4JOyeKf
         +Vc5DsmvIggUiKD34y+OoHVuQHyHMscIJKDp+v4DW8qL1aSVKdbbcLMTkWmDNxrIyX38
         6lDX7nY2WxLCv+b8kBslxNsUKBKakgWXoFGdJxtVmWCKnU/PfzPcSbZqzS5EwAlJrvGX
         krMLCoLoxcQF/EyU4mQw/1+BnRutXseAQEQU9Twe9XAGPrmDvWzDvg3w6enASb8bbzVD
         QlKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793078776; x=1793683576;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jPU4IMrUNrr8h45vc8EL5JTCvYSHe/yNNj7XMONjgu8=;
        b=MfFOtVjqBnKMuBeoUpl5GF9w4u2lPIVKXbCusu/2IvCOoP4Uu6XqUloyd/Pe2v6f1O
         KQwOQxVkapl6sAs8G0ZM6r5+5ECvKKOrSGx0VYdancUmVlo9Aee0c8nZy/gN87b1rZe5
         yXfteOPZBDAh54nPo+FUCLUcOvv9o8kChYi+7TfAF2JEmFOE/eJME/lvaxeVnyqIxxLd
         df1BFIHj0ObSGtl4g6jI7bm2+sdsw822+9KEni4dhpWfWAKPYs1r4HI01qDL5yIE1xKB
         daKZyu/eZhUWiWHAOx2tRvHVfhk9oq7DJ2dpZIPyQAHmXiNT2zkWwecNMsyPAh8o71OQ
         dzFw==
X-Forwarded-Encrypted: i=1; AKwUvBz7oi2DzFhKC5+cnWmqcyo7zTslPYHDvS1gNHW3xNOun/Q0f4IKlcxmVyzdeMLwpsCRcNZhMwBXGkQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKYmaP6rLxelO3HC3t+UE58d8oa3/IzHLDdhKJvGPL6H6VPbE04
	w22UtH97p1BQG2IhCTWkaJ0UzE3+1jLrWKBDopfJNMwOyugbbt7cRUGI
X-Gm-Gg: AYBFou25IU+M+z/1Loh5487m+Nx+3bd9VUv4Tb4gpS7HFTB4DG6ai3AD80PZgIQkead
	8+hGHlu6avz2IUdRx/a4nh9yo1cas9d7qsiL1wttu5RB4C0oDFjhB8yJAgRoy/yp+q1W9pTL8cX
	VlRpnKr/2VlL+wo3SWGx4aJxA4BwNoaWqzlbpCOQryShp8JLSeymBwi5eDJTAH/t80OCyrTTnZQ
	nD4yjD7ke+v+nnQZpPPbPqEW5jhnYSxkXNqi8NKGXVF+XkkqoBi5hhjlXoNDxYwm/rSTLyimJRF
	VQPgytzGcz8Qc52HMoLv3m9IQeOM4WhZKherOFDXWsm+GoT4WkEd2KCoaDZnam3uNC0ZBAryrDl
	9OycekmjGjHd0Ms3ZFN1jxnHNpd7quDV2kukoQnImLAFH8gpENoEX/7LX9py31zAhTeI9TJGCfw
	ww6HYrNZ4z476cUg1B/6zrwL40dmEz45vYNcvbnjzsTdrgz+XOjpOpUG/CJlPSiD4O5QOPiXqr2
	EAgqDdN3CuOjTsKmzHMJ9ptoIMgFn2T6jQ2vF07fZFJnPXC5vnYRvMHGbwiGOGAuejGuI/BMA==
X-Received: by 2002:a17:902:d541:b0:2e9:3dd2:a90c with SMTP id d9443c01a7336-2ea9c7bd583mr74901225ad.20.1793078776372;
        Mon, 26 Oct 2026 22:26:16 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6c9757bsm3307715ad.58.2026.10.26.22.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 22:26:15 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: akpm@linux-foundation.org,
	bhelgaas@google.com,
	lukas@wunner.de,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	alistair@alistair23.me,
	rust-for-linux@vger.kernel.org,
	jic23@kernel.org
Cc: ojeda@kernel.org,
	aliceryhl@google.com,
	a.hindborg@kernel.org,
	alistair23@gmail.com,
	wilfred.mallawa@wdc.com,
	bjorn3_gh@protonmail.com,
	gregkh@linuxfoundation.org,
	boqun.feng@gmail.com,
	benno.lossin@proton.me,
	gary@garyguo.net,
	tmgross@umich.edu,
	alex.gaynor@gmail.com,
	Dan Williams <dan.j.williams@intel.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v5 04/23] X.509: Make certificate parser public
Date: Tue, 27 Oct 2026 15:25:17 +1000
Message-ID: <20261027052536.1722081-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027052536.1722081-1-alistair.francis@wdc.com>
References: <20261027052536.1722081-1-alistair.francis@wdc.com>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Lukas Wunner <lukas@wunner.de>

The upcoming support for PCI device authentication with CMA-SPDM
(PCIe r6.1 sec 6.31) requires validating the Subject Alternative Name
in X.509 certificates.

High-level functions for X.509 parsing such as key_create_or_update()
throw away the internal, low-level struct x509_certificate after
extracting the struct public_key and public_key_signature from it.
The Subject Alternative Name is thus inaccessible when using those
functions.

Afford CMA-SPDM access to the Subject Alternative Name by making struct
x509_certificate public, together with the functions for parsing an
X.509 certificate into such a struct and freeing such a struct.

No functional change intended.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 crypto/asymmetric_keys/x509_parser.h | 42 +--------------------
 include/keys/x509-parser.h           | 55 ++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 41 deletions(-)
 create mode 100644 include/keys/x509-parser.h

diff --git a/crypto/asymmetric_keys/x509_parser.h b/crypto/asymmetric_keys/x509_parser.h
index b7aeebdddb360..39f1521b773dd 100644
--- a/crypto/asymmetric_keys/x509_parser.h
+++ b/crypto/asymmetric_keys/x509_parser.h
@@ -5,51 +5,11 @@
  * Written by David Howells (dhowells@redhat.com)
  */
 
-#include <linux/cleanup.h>
-#include <linux/time.h>
-#include <crypto/public_key.h>
-#include <keys/asymmetric-type.h>
-#include <crypto/sha2.h>
-
-struct x509_certificate {
-	struct x509_certificate *next;
-	struct x509_certificate *signer;	/* Certificate that signed this one */
-	struct public_key *pub;			/* Public key details */
-	struct public_key_signature *sig;	/* Signature parameters */
-	u8		sha256[SHA256_DIGEST_SIZE]; /* Hash for blacklist purposes */
-	char		*issuer;		/* Name of certificate issuer */
-	char		*subject;		/* Name of certificate subject */
-	struct asymmetric_key_id *id;		/* Issuer + Serial number */
-	struct asymmetric_key_id *skid;		/* Subject + subjectKeyId (optional) */
-	time64_t	valid_from;
-	time64_t	valid_to;
-	const void	*tbs;			/* Signed data */
-	unsigned	tbs_size;		/* Size of signed data */
-	unsigned	raw_sig_size;		/* Size of signature */
-	const void	*raw_sig;		/* Signature data */
-	const void	*raw_serial;		/* Raw serial number in ASN.1 */
-	unsigned	raw_serial_size;
-	unsigned	raw_issuer_size;
-	const void	*raw_issuer;		/* Raw issuer name in ASN.1 */
-	const void	*raw_subject;		/* Raw subject name in ASN.1 */
-	unsigned	raw_subject_size;
-	unsigned	raw_skid_size;
-	const void	*raw_skid;		/* Raw subjectKeyId in ASN.1 */
-	unsigned	index;
-	bool		seen;			/* Infinite recursion prevention */
-	bool		verified;
-	bool		self_signed;		/* T if self-signed (check unsupported_sig too) */
-	bool		unsupported_sig;	/* T if signature uses unsupported crypto */
-	bool		blacklisted;
-};
+#include <keys/x509-parser.h>
 
 /*
  * x509_cert_parser.c
  */
-extern void x509_free_certificate(struct x509_certificate *cert);
-DEFINE_FREE(x509_free_certificate, struct x509_certificate *,
-	    if (!IS_ERR(_T)) x509_free_certificate(_T))
-extern struct x509_certificate *x509_cert_parse(const void *data, size_t datalen);
 extern int x509_decode_time(time64_t *_t,  size_t hdrlen,
 			    unsigned char tag,
 			    const unsigned char *value, size_t vlen);
diff --git a/include/keys/x509-parser.h b/include/keys/x509-parser.h
new file mode 100644
index 0000000000000..8b68e720693a6
--- /dev/null
+++ b/include/keys/x509-parser.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* X.509 certificate parser
+ *
+ * Copyright (C) 2012 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#ifndef _KEYS_X509_PARSER_H
+#define _KEYS_X509_PARSER_H
+
+#include <linux/cleanup.h>
+#include <linux/time.h>
+#include <crypto/public_key.h>
+#include <keys/asymmetric-type.h>
+#include <crypto/sha2.h>
+
+struct x509_certificate {
+	struct x509_certificate *next;
+	struct x509_certificate *signer;	/* Certificate that signed this one */
+	struct public_key *pub;			/* Public key details */
+	struct public_key_signature *sig;	/* Signature parameters */
+	u8		sha256[SHA256_DIGEST_SIZE]; /* Hash for blacklist purposes */
+	char		*issuer;		/* Name of certificate issuer */
+	char		*subject;		/* Name of certificate subject */
+	struct asymmetric_key_id *id;		/* Issuer + Serial number */
+	struct asymmetric_key_id *skid;		/* Subject + subjectKeyId (optional) */
+	time64_t	valid_from;
+	time64_t	valid_to;
+	const void	*tbs;			/* Signed data */
+	unsigned	tbs_size;		/* Size of signed data */
+	unsigned	raw_sig_size;		/* Size of signature */
+	const void	*raw_sig;		/* Signature data */
+	const void	*raw_serial;		/* Raw serial number in ASN.1 */
+	unsigned	raw_serial_size;
+	unsigned	raw_issuer_size;
+	const void	*raw_issuer;		/* Raw issuer name in ASN.1 */
+	const void	*raw_subject;		/* Raw subject name in ASN.1 */
+	unsigned	raw_subject_size;
+	unsigned	raw_skid_size;
+	const void	*raw_skid;		/* Raw subjectKeyId in ASN.1 */
+	unsigned	index;
+	bool		seen;			/* Infinite recursion prevention */
+	bool		verified;
+	bool		self_signed;		/* T if self-signed (check unsupported_sig too) */
+	bool		unsupported_sig;	/* T if signature uses unsupported crypto */
+	bool		blacklisted;
+};
+
+struct x509_certificate *x509_cert_parse(const void *data, size_t datalen);
+void x509_free_certificate(struct x509_certificate *cert);
+
+DEFINE_FREE(x509_free_certificate, struct x509_certificate *,
+	    if (!IS_ERR(_T)) x509_free_certificate(_T))
+
+#endif /* _KEYS_X509_PARSER_H */
-- 
2.56.0

