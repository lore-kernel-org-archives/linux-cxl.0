Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E9D374E45
	for <linux-cxl@vger.kernel.org>; Tue,  1 Sep 2026 01:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788224677; cv=none; b=OF6SPJ1B+Zj4SaCARRsquItVkg7mY60ogBBhEP8DigFtsXKLThEsM7ZNxgbNp0IaEq958O3XnStB5e/CT0XM7F9dpQIT5+6tHJQHK3vbnXwMdN5sv/qM2edJrWvPIW6Q34iSKtKyHoEhRkdYjHVFYzq130AgsL1ujUBfx6Msf3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788224677; c=relaxed/simple;
	bh=CQFEUDdrBOr25kMcKMXOfOQ/OinpeF576SKItpXVsJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dJIHEjoPFGWxlkf4CRQl98EKHGFJqNSTpx5p4z4LHkUJYqT4/AHEhUd+sBi/xfQjsDRMVNIlp5oheYs5UCn3gVygBDK3eg2QF4M+9pr5DRb28s/Ed8iQ8T317vLdD2ILe9Sinf2k1Xj9sUhfufQq+U90+HVTbOXyJKG5c95I+ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZsBDaC0/; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZsBDaC0/"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-398d2b28acfso1512471a91.1
        for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 18:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788224675; x=1788829475; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UyJ6OADjMeEJ9CwYlU3XCJzTi4L5CBgkg5gwk3kMxf4=;
        b=ZsBDaC0/+fQmyD8tSNma39eqdyThM8INc0UOACy2Uaxa6xkRXPoltbKVX9msgUyY4j
         HDRReL3Hu9mqFn0Lj7970n4SznkLZri3iVOHP9GPmteNf73PClvaBg61H2fabq4dyoOh
         cYPi10HRGV+j6vTQ7rWmH2UHTqmloTehgFJKpe6PB6tv8FJMQdvC77/IK/BCRxL2Sl2t
         3A/puScoxik8/IcLJKrXhZ9TikflCIgYwSe6qu73WcYbLMCspK75Ai4l2aiQkQz26Fvs
         6PDEbZjmMUOTG5oSZnWWwvYkyA535ABSgC0DEdMnaTdtOiMJ69mCj2T3m0CItNZdQnR5
         LT5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788224675; x=1788829475;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UyJ6OADjMeEJ9CwYlU3XCJzTi4L5CBgkg5gwk3kMxf4=;
        b=fDNKgL56lvIeEULrsqR30Cxg1pNdV4MEk/sgXbX0sjfWOvnBtzED9kA54sinjpmYPg
         h0/9A6pRKu4ISXsUDxA7z761iIVxo2+Ff1o+w7zuuU9lXnd3jEjM+h1lD35ip7xiP7DO
         34OcESOgzc+BwodqWd3zOfBhy1sKqDfP+hGKcunoCEJbln5Uy1EUOhgWkVMsCfqmyStx
         RR6zhLXq+rXLfCc6WLu1JtW70IcuySwcoGNxP/VxsibWhJJJLXgDsXf4T4oRslz4q+rC
         E4ph4Lke24dE+r5KpsAMvc1xYnlMUmHP3jeiTmO92lWsKmcVq8QaG2X/VWTm1s6SE7RR
         bJGw==
X-Forwarded-Encrypted: i=1; AKwUvByoxqLMP4wl95z6TVrZR8ve2Nt9g+wdQnISh0DwHSa0QlPbSThy1Qzp9xlTH/ajPAQkHSYEmrBAIng=@vger.kernel.org
X-Gm-Message-State: AFuF++nckWPwl1Pf6o9+z7VUgg/8ooaiMKV0KAiEAZlYagQCdo69tCUh
	dmQJSQLJsyZwfiysgneg1o1iFskO+VkJLRAspOMkY71tnObrDhtvSxv7
X-Gm-Gg: AYBFou2mBkoolxRVoNa+4UCFlZFvvQiENsJbe0kQnEjU99zoFT+M/g/G39c6Axn+5VK
	VnSKTnk/OWcBCGL5jimOMdTPM4s2m91MKldL/DMmQ4uhlEi4NeK+t/ZddbBPd04aLeilyHx828U
	jxChWjmDSMtEwsMI9IcHhklTiDi1UkYdoX3b9QQ1jbs01fexvl83Bddl+n4nTA/gpE+45Idh0Zk
	5IqQkB4lyXkkeVg9gjaoXjU66HhnfeRNFm7PCNplwNXmDrmzEcU2eWf3WXSTWlEsf+UZGFKLJcL
	RLtsjLC1OTHM/qiMCB9LpudSxENSYy6p2eufVp/ydGuoF2gcMVagDMaq/m6NIjxfaxKolI1kscC
	OPfXapPbhvZMVHINZgVDhP2IEmHemz8FHrFKIX/pK6+tnt+wOhmSqYsxh6vh/y5OQ1fw9k2t39d
	BPaBfm/Wa/Bl8YB5VIRcb09FUxG5SSUVISFUJJAtotA8sSc3LlGL06vOVsgtNG9Vkma41qKAfcP
	kijbw==
X-Received: by 2002:a17:90b:54d0:b0:398:d93a:b343 with SMTP id 98e67ed59e1d1-39907ab0ec5mr6643406a91.3.1788224675395;
        Mon, 31 Aug 2026 18:04:35 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990d49e9e0sm2372024a91.11.2026.08.31.18.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 18:04:34 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: linux-pci@vger.kernel.org,
	Jonathan.Cameron@huawei.com,
	djbw@kernel.org,
	rust-for-linux@vger.kernel.org,
	lukas@wunner.de,
	alistair@alistair23.me,
	jic23@kernel.org,
	linux-cxl@vger.kernel.org,
	bhelgaas@google.com,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
Cc: gary@garyguo.net,
	ojeda@kernel.org,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	wilfred.mallawa@wdc.com,
	tmgross@umich.edu,
	alistair23@gmail.com,
	boqun.feng@gmail.com,
	bjorn3_gh@protonmail.com,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	Dan Williams <dan.j.williams@intel.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 04/21] X.509: Make certificate parser public
Date: Tue,  1 Sep 2026 11:03:30 +1000
Message-ID: <20260901010347.2614656-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901010347.2614656-1-alistair.francis@wdc.com>
References: <20260901010347.2614656-1-alistair.francis@wdc.com>
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
2.55.0

