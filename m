Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794284359;
	b=kGrObLn5cEQyknJDdWr0wO0GwPhcSTP5De0cSJsVQipDTV8qCLJ0D5hPKRQBOmaWnVUl
	 lVMR20wRpj0JKtHaOcPMqgmzxtxv02Dio5jQkqWHN0WRG2c9o6FcDAj7ZGwcYh2s2kRRg
	 v0ljp1YXSArOqVEdxM7WgelxmuBQN+JS8kiCSB8ucnJoSH8xo1ttCWsAEYwPiDQOA+SF8
	 rkOA2HdclTIwfVSQlT7wZnTc/eHPXKBI3x5QbtPdHRwZU3sP6HJYCt1R4hXvuABzYyRru
	 BzrQI0VhWE5stZGslUWGMXLDug8eW8AvpkBykbo2hQGUSN8U7aK0mOgQuER5caVXvoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794284359;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=jPU4IMrUNrr8h45vc8EL5JTCvYSHe/yNNj7XMONjgu8=;
	b=zzq53AWj07vRGPGuB+Q5TzbiLwcML3aG4izA7quDRK+fXBlB5YegC4Qyrfsa6H0Kq5wF
	 fEMW1FLdgJ3GGsAE+n0z5JTg6x7RmSZ+ONdc6ylDZwMVc6pI1hUU2BDg8quSX9qRQAesq
	 QDgQ7HXoeNjiz+YCipkDyWa8oA9QsOZ6Sua/hRq7r4hihiVWhLCiL20PPK0fqdGZaX9WX
	 QWZ9MjR+p4swVFHdpgA8j9WbDj1f3BvqR+MCWqJIvLBYUFJ9TcRe3jG6WLPnXrGZ3+PvY
	 8gjl6ZQrnnIxpOhZEaugCi3GJGBq7GZfPNVjD/gc7A5Kr7e/JcqwOpLbGms7NUawxzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ovAYrcEU;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F24960A261D
	for <linux-cxl@vger.kernel.org>; Tue, 10 Nov 2026 04:19:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F24960A261D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ovAYrcEU
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1b3a05f8b5bso2460619c88.1
        for <linux-cxl@vger.kernel.org>; Mon, 09 Nov 2026 20:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794284358; x=1794889158; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jPU4IMrUNrr8h45vc8EL5JTCvYSHe/yNNj7XMONjgu8=;
        b=ovAYrcEU4YpDj+qS9Kyezyn7VjwJYTQDYf/0Vweej35GM7wXA/wOoKS7MWECpqjyVb
         TtebLwvQ8/cDfHo5BPUx3cqMp9bm31UwYU+rzH+jPVJ5pUHQqy5ISGkvu1J6oCmdC3Ww
         k3NXlfzLR0gFgTX15eqxD6aCfQ6oVPF+kU67mQmQCBQk/kPkBZwaaIL8856LeMuif8S3
         DHdpkLtz5XpfHtWYyox+VVAx+JTuTi0g4xur9KhGJYaYK1XBVAVW2Oh1NeiyZiP8EGSp
         MEAzO99G76otNRCOY6hvZjYKWBlhU49J7g292qg5I2GkfK3s6t/lRAmBrcgTumrCByD1
         /D9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794284358; x=1794889158;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jPU4IMrUNrr8h45vc8EL5JTCvYSHe/yNNj7XMONjgu8=;
        b=fEu9vJrKtPKRGJgv7HA2tv4BqqJqhgsPUCSC2TZmUuuydfjT6lvOQxqMbory2NsHZk
         D9IuA9+pTWePHPmbJ8wWJ87W2yszaxN2QnDlJsK2jZGGVn5L9WkhPmPv0eZ49M2XwW1X
         BgQcdD7EtX2fy1GlZdKGa/Vmtr8WqPil83oMiszrIwIyZtXYsr11Ydm9AbLkjHy6Sid9
         yA4ioF5YE0ndbapbB5PNt6sZWb4SkRd+/gyMORn4EesZ7i0srb2IBLCv7YOcZguhSkrg
         kklQrAuw3FFYb2xshKAlGWc1asTOqIsI2K7AbsYwSukAglIoQEjq68M51Mkw5STdjZz6
         zU9Q==
X-Forwarded-Encrypted: i=1; AL+hErGHPwTGSEXygyTL0QOGRKwVfvSJnpENxHsyJBWcRierqsjq9/7QV+H0eE6M1ni2oknVWBZlaLqy+LY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/c92OGg+aAO3bBO6vUbdy2jQ824AfPKJm0lwDA90hBU26Kz0Gc
	2o+tuoFQYh7D9/iGW3yY/Yfr01vlehhyV4mRGpz5Y56PB8LGpjlQpMuE
X-Gm-Gg: AYBFou06wo2RtnSVzAZcvt8vHndQYNrTg5TNiIMoQN4tydQSYfCTPQwFkzyLhy9cJmw
	QQedlOVq3NrhyqsQpROXUN07y4llXMo6mdT+aHIdXh8z6+fD4QZvcwZ7vQg9r4rz1SBKxxCy+mB
	m8OOe4uAE7B5+LvsjkcSTMnHqqoUNjdI7P6TAHZnsKGSCsT401mlFPOxJsOCtjSwX6rpynRtgoP
	QCQNFHx3cqdhX6an8OVwe/5+hPczEzlHfGJCe4UkhgPVByrgjdgBLAtTEfjsFYlBAYOQVo4EUk5
	qxtuQkA2EsBhcrqejebg+Kze1CS57b6fmwoWrDPt652kZz5K3Q/KY462yzed44B5LU+v3R2AZct
	0R0vIvhJ675nrbgzYAqUqqklAH1ZlqNdqePCjokBTxOXiSzW8R1OyHiAM8sTvnXRruzLyI/K/lo
	hp7N88UDZRoSo3fp2lnPxBz+zuw9NuDUHfRypHJJSBNsT/b0EbxW51MW1FA7avPOgNjr73m07tl
	/3SZrOjIaf59oSBfQibk7ay0PlN2j2I4u5eVNYiF9lZNzhRoNYjntgxZRXvn+3hNbmzCDq50LID
	jj35DJmafIxqOTN3A2D1/EcgzarajClul5WnonCopwdcV5c+iKNoK5dCLQecAPz09FC0
X-Received: by 2002:a05:701a:ca05:b0:190:3950:43e2 with SMTP id a92af1059eb24-1b3b6000497mr2107814c88.8.1794284358348;
        Mon, 09 Nov 2026 20:19:18 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b7ba88sm3540459c88.22.2026.11.09.20.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 20:19:17 -0800 (PST)
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
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v6 04/25] X.509: Make certificate parser public
Date: Tue, 10 Nov 2026 14:18:11 +1000
Message-ID: <20261110041832.1730924-5-alistair.francis@wdc.com>
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

