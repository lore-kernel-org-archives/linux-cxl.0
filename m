Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F593A7843
	for <linux-cxl@vger.kernel.org>; Tue, 23 Jun 2026 04:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782190502; cv=none; b=A1x/Zu0YXQQFzZL1dW5M71on5aY9572CegQNAj1SymEOYVOD7vWWZVgR6JrX9PNhLHAt59t0IvACxIfoZuBqK6ygWTRgs4JTxeKm9A1YpUUddlTCFaB4hva8ccagiGx0UdvlOME7vhLXiWrK32PYi6oe+iNw24C5Ul6J3dzOc34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782190502; c=relaxed/simple;
	bh=P4j28MQiUepWUPR6ls/AjPt3mUcsoZpAfSvc8hS1j8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YGki2rlQUEfGeSbUgcqS+F6L26AGJU1A+TJJVJGxo1cpX6N5VP6zEsExwBDwawbdvqDzNzAigvgYp6v6PDYlaNQtmjlnVvxCfvw8vEIehJJcK3787f5fAC0zpI5ShDkoPlSLRGQtD+Oax1KvVhlM3jPvXPos99ksEz8ohhPDe/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FtUOTEJ6; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtUOTEJ6"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2bf1cda2b17so4168225ad.1
        for <linux-cxl@vger.kernel.org>; Mon, 22 Jun 2026 21:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782190500; x=1782795300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tUbYMnUT89p2VCtovUWaFf0u4bBhWvF56ocO3qt/G5A=;
        b=FtUOTEJ6/hFifDHj8HQG5IG+DiGbVCYAkWu7prSPWU2c5qv6Om2/SPA4Ys9NOQeDr2
         D+68Vsu9wu8/E1uqwFgZJ8ImjcmU38P+CD2gyAnWCs+j8LGuNY22e+IBaRJ9he80z1VE
         Ip/Kn3A9KK3FIz/uGGQ8BMZLq0UjPRi7h7ExoUDpklA8MzgB5o0JWLXA67N+rhJtRKek
         YMbPxD/O1tZrEIJtkB3x6WSu+QFg1i9w99JrS3PhxAZnKStR12aC3wNyE3hP1/fiYqTR
         yuUtdQiwpLZY7xisIRCnl7wfEuGhq+6F+LRnX+7ju0uKlw0u7Rq1StEDp/fhu0sIxegZ
         ElBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782190500; x=1782795300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tUbYMnUT89p2VCtovUWaFf0u4bBhWvF56ocO3qt/G5A=;
        b=s382Gw1HbSpORfLeI6uhrOEmjD2Bc+/D3VSNOi+K0jB3EXiSdX2/3CNhZKhnNwDMfl
         L1lCJzBx3cPIkY2jtLg3dQ6Qpq04Q+FM4BBfL8iYgIjIsm0cT4JS4stRDyG+WL8SVq+7
         VZpO+ILctOgWBmpI3NZ6aUWYptx3z4tIZ7uK86AP+G2kcif7ovphdQvFzPlJhPxpYx1k
         XoU7bgFS7XbtuJkpsSJwUIvJnsPpOUnWcDQ+l+YVi3van01XvxBy/DB4YswVN2nCnK4v
         j1HX1+oXr6u1RfCSvx/P3PX4jzr54FmB4LPSSGGlpr1q5r0A/IAKsnVjTHvtjpd5QHAO
         Putg==
X-Forwarded-Encrypted: i=1; AHgh+RrBhlY0QXyrEn7DU5nGRZ0nLhqAK8T45dVzTgvIu4FJOXd/8jt333snexEITwYK5mTAwHFxP4aN/EI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhBSKlyeN1vgwYqpJsRjmOovh3kRPbCb3V+TBu3NN/VUg9NJ/G
	RrYckrqHPF6YS4ftfgRjPWBe/Fqm/b1QZNI39qPx6CLTqEASBsW5JRe0
X-Gm-Gg: AfdE7clGwneomaz+WIZWxKDGd4igiJRwx8f5t14pObxRM8YW7dq3gwSTMozbZBd+Vnn
	2dGuwY7ytglBHsdO7sJKGPccTab4DuDCzM6+k9KclZvC2tVJu+pVpjfbTtkAqRxPrVqcpjZjLyq
	Qagw6RYHeGkE+sysUib+SD/EpWokR7FLlLDPb3Ld7t3oXNDEr1dV0TMyXLI1yl9RiJs3+0rsf9Z
	2abxNIw/FiC4aC1AotbJQ/PQnaSUWunS8EkP3h0TVCHB1W0Ig5jt7TKYg4L9YCYKnpMi1ryOZfr
	EghgC/Dt5l3lR1RPf7UqzKLPSCNxcpVw6EK+6h1OPyck77o1j2Tf0uHKBla5N/p13RiSIvcBHH7
	XuOOqdCBT3aB+aNHvldbjQc0ROnLwaB9CtnOwXT+zI9nhltHUA3GjOow76+tv+VAug+b8z0j3Pn
	G1AjJCuPpd49sOQ3pOb1cvCXIGIhAORA==
X-Received: by 2002:a17:902:ef44:b0:2ba:838b:bfae with SMTP id d9443c01a7336-2c7c3f00beemr16025915ad.18.1782190500476;
        Mon, 22 Jun 2026 21:55:00 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7439f8cf0sm89734785ad.50.2026.06.22.21.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 21:55:00 -0700 (PDT)
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
	Alistair Francis <alistair.francis@wdc.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v2 05/21] X.509: Parse Subject Alternative Name in certificates
Date: Tue, 23 Jun 2026 14:53:50 +1000
Message-ID: <20260623045406.2589547-6-alistair.francis@wdc.com>
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

Store a pointer to the Subject Alternative Name upon parsing for
consumption by CMA-SPDM.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Dan Williams <dan.j.williams@intel.com>
---
 crypto/asymmetric_keys/x509_cert_parser.c | 9 +++++++++
 include/keys/x509-parser.h                | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
index bfd10f0195e0..c3ec2846695a 100644
--- a/crypto/asymmetric_keys/x509_cert_parser.c
+++ b/crypto/asymmetric_keys/x509_cert_parser.c
@@ -596,6 +596,15 @@ int x509_process_extension(void *context, size_t hdrlen,
 		return 0;
 	}
 
+	if (ctx->last_oid == OID_subjectAltName) {
+		if (ctx->cert->raw_san)
+			return -EBADMSG;
+
+		ctx->cert->raw_san = v;
+		ctx->cert->raw_san_size = vlen;
+		return 0;
+	}
+
 	if (ctx->last_oid == OID_keyUsage) {
 		/*
 		 * Get hold of the keyUsage bit string
diff --git a/include/keys/x509-parser.h b/include/keys/x509-parser.h
index 8b68e720693a..4e6a05a8c7a6 100644
--- a/include/keys/x509-parser.h
+++ b/include/keys/x509-parser.h
@@ -38,6 +38,8 @@ struct x509_certificate {
 	unsigned	raw_subject_size;
 	unsigned	raw_skid_size;
 	const void	*raw_skid;		/* Raw subjectKeyId in ASN.1 */
+	const void	*raw_san;		/* Raw subjectAltName in ASN.1 */
+	unsigned	raw_san_size;
 	unsigned	index;
 	bool		seen;			/* Infinite recursion prevention */
 	bool		verified;
-- 
2.54.0

