Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E25453E0B
	for <linux-cxl@vger.kernel.org>; Tue, 23 Jun 2026 04:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782190493; cv=none; b=cDAzDe+kjTlCyoKzuIE/s7vbvMIakj0GxVnOFIOf3PTNEUMg3tKwYpPsBqaupp00XnvzQ6LsF/mM/l8UANpBXqnXlyppn6ski2hiEf8i3BXhu63rw2Ih94ksZWiDpmE845e8a9xW35PamrJp97dBrs7B9uQC+FE8L4dnQJDSoIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782190493; c=relaxed/simple;
	bh=OLXs3Fufa2MbacrwYlnD48/27+yJ2MkbIQw8G8Ag99o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EslwpXRPe66RcUwFplNTyzKfxUSoRqTHW4LOh9r23W1VBNuoxtXQkqUzyFJfBQ+atO5fUa0M8Q9s/DSi8600krwXDWvk4XmsFsGQVWEeccwTatYq4ztyeLYfEO0GO6LnMTwcYZbfeDJNERDcARmiYuO0kxyPIOGoX5ltczXy6NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZoLT+sMA; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZoLT+sMA"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-36d98b9aa9aso4598057a91.3
        for <linux-cxl@vger.kernel.org>; Mon, 22 Jun 2026 21:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782190491; x=1782795291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=em+GgXcAR5Bq6k8M2WoqxbNFVjEAu9j/BAUf/d9vc7M=;
        b=ZoLT+sMAGM5SxmQCiOKTrfXio6huyA6o0wFzSy6NShs7kDPXjhqcugB2VAdNs7F3s3
         rOAioX6Y0d5V7g3PWU7CW66OiXUg5n9kFZTOn8WjS+AjhiwjGUh7nQ5b3Gn+2A6D5Bji
         uAj/BSuotuDlEUJWj/j+Ury8ORf92Gm6IkqHBfAXC5bndwMZ4lnv+tojQOP9BPXFV+Mz
         kESnZwKRBm7NFp4f7itq/E0QUMuclSq05a6WuGBCCachvRwsYbgP8EGXMWcJ+d5aqnsm
         CPJScm7dMD11k38EChBJTJXjam2+fTerFfkxG5YKCbzokarn0PJmhh4M7BL4w+Em2m8k
         POXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782190491; x=1782795291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=em+GgXcAR5Bq6k8M2WoqxbNFVjEAu9j/BAUf/d9vc7M=;
        b=hp+6KWh2ePe+M3HIDrwNO+de9DfPp3EQz1HIiTWT+H5DOvOJL5J7aBsMeNDBSTdhmy
         wNpNbdgnyuEUw5iz0oVPZY6nOI9GjJXTeVJTPR1bAPv65deIsdOqx050n5usJKRhaUoN
         9Z0d4C+cYlihG4+vGmmwxwiSdiWkUYOauNylTzp4X32k63p6ksBp40Tw+HRGY6XsrRUR
         I4gEZtm8WRbsuKiUBaOJEYN5AKRc2AIRk2RUqCoZh2I43ThDOmqs8LLV9wzH7al5uUJ7
         Tjn95tqlZCAGKbNHipvuaQVIgtHd5/JFM1t8REbcGMzRfvplYKTszqsP83XO9G7BLre3
         UX5w==
X-Forwarded-Encrypted: i=1; AHgh+Rplpv0YvrnFbrnN1AiiSf1/3WwqXQoobk6MOpc1XKMSSeQv1yseC+HBqyoP3fof4r2WzXnGiaytWn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXzjRhu6iY/ixWkK4OSuvLaYxBQ7bMitGxRlL58oX9e2yvVaRF
	AJJPWRcP5TXg1VpRddPNDFkuTl8ZskPeXJZUNwlTLgv8uZjXXfPjwpui
X-Gm-Gg: AfdE7cmSIBLdGsCpNN6zfIRwR4fzh4l5obi1cLmeZ0JvoI0AS7ON+iMeICVqIwEfTnN
	rR+uSx3uJbYxdSgdBpV9ajhc+WOEVPVuXprdqW05d7JZMtc2a3O5sd5hLsUA9AdREaLZKyluKY8
	95rf4uuGza3VhPDScDNYJpMyHbwTFnRHUedoc5a5GXbHizfOQjNjNIIXyVqlaiPCBsNB8HLWVeU
	F3BN99exh6HDGnrCErJkS82O1kZ2DZbNledK5bIRtXzzR0ukl00oQi/lQpNTVUkT7dFM/6TpoKw
	l8Sk2r+78xMVvR/jdTjNrW8MxefRvPJNsSqZSOzrwdUgimWK2aegiSr0z4PtndNijMnikp7X5dT
	yWjLlN0c+wYGUic1RVP76Anhw7ZyMVPA987PfMrQt/rMZZzlw/1XMbPQcJWaJ8TEoP5qPGHogDW
	HJe4dhfJ79HYlDH9tGZ9wvKawqCfQzjA==
X-Received: by 2002:a17:902:ce02:b0:2c6:a97e:1c24 with SMTP id d9443c01a7336-2c7c758b9bemr14124315ad.7.1782190491545;
        Mon, 22 Jun 2026 21:54:51 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7439f8cf0sm89734785ad.50.2026.06.22.21.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 21:54:50 -0700 (PDT)
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
	Alistair Francis <alistair.francis@wdc.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 04/21] X.509: Make certificate parser public
Date: Tue, 23 Jun 2026 14:53:49 +1000
Message-ID: <20260623045406.2589547-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623045406.2589547-1-alistair.francis@wdc.com>
References: <20260623045406.2589547-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
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
---
 crypto/asymmetric_keys/x509_parser.h | 42 +--------------------
 include/keys/x509-parser.h           | 55 ++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 41 deletions(-)
 create mode 100644 include/keys/x509-parser.h

diff --git a/crypto/asymmetric_keys/x509_parser.h b/crypto/asymmetric_keys/x509_parser.h
index b7aeebdddb36..39f1521b773d 100644
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
index 000000000000..8b68e720693a
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
2.54.0

