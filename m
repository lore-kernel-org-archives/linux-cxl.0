Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793078785;
	b=hFcUnWAlNYX+CpoxGZvwXEFrE+viPa4V2NmDwn1uv9kU7ubAZXlqRttJTn3OsD3jYw3P
	 bF46HDl6iSSA+skDKex/Dkcsz+6asosybZ6YLkzyPTxGMi+cYLaqC9PEokbFZ+Cl8AOEO
	 /O3WZgilxLTy4hPFeJYfHUPtIvhTq0XrUMnC8y0nmiA1L6XR6IC39mQDSNY33U5sgn6Nn
	 4ZOpfJVPv1pWVBt7druBcSeHrEreI/znjzp39r3sm+P+Oyh6PXpr1bFmri6UCG0corqNZ
	 DhUH3JLCYd/UYSFTfFY2H0LJZ+S94rYmwcMtH9suOrBlioqAdGxF3504WdDBFCdOAnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793078785;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=DF2GX2Vr9/zlICZewnCnHZ+XwMhrVOLtr9YXmakaBJ8=;
	b=0b0VZVVRhG5NU56CDIUI7btPXcDp4uiH1tc3C8iu2g5VpmeMv5hWkixrl1b7yYuJHtMQ
	 WMRpBC7C1E3lemDY+aMOCYx47fu7bArdoLak4n8Xj2toK0vI5ffbl1PWfw1ndxEr26e2w
	 TCE2cskFHEstW44pUMTguzvKPlVRXLln7omj6Kiuxv5dtI3o2oYYr8DPQAD+7+jtoYV9E
	 t4gcZxfb5rtN8aU/CtbySYozRLIy9TlvTieGFaMEw4UTaNO+1dR+uC3MMkDNjVxib9bak
	 Gup850SnAobQbQmP5gm0Ms5ryaIv5p30AZnNnZREFQBp9g17nbxQz6oQ/BltZe2TJhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ppBUU5Jt;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179B3606A31E
	for <linux-cxl@vger.kernel.org>; Tue, 27 Oct 2026 05:26:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 179B3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ppBUU5Jt
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e987b4a710so2528625ad.1
        for <linux-cxl@vger.kernel.org>; Mon, 26 Oct 2026 22:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793078784; x=1793683584; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DF2GX2Vr9/zlICZewnCnHZ+XwMhrVOLtr9YXmakaBJ8=;
        b=ppBUU5JtRQffnmvz2rPfVCMM0am1iKNTT99vWsxtfGruBwur7u+9uMc877XNtqKgWx
         nIVOk9/LHIxR2M6QwA5WZvMpE75bn2BdBs19T+/oTV8He95F8ZGDE0Blcw5sWb/8pZC/
         c8ujYPR/A99kQKfnnuCMEUueJWGXuEmq+WzbTUqJzCrVRNDPORf8hL6d9SAx5WS++S4m
         GdnHr557QDvgp4i5dRMmTe2xa5zvSPTz24vrxafPuEG5UHK1fTBQwqOgKYqnF+/UNTWp
         7lzZQePJQVfpNjfYh0hTJDCZgTmefumMec75BK2aGFPYKLmN4nZdkL/8el6bwtDSqldb
         qUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793078784; x=1793683584;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DF2GX2Vr9/zlICZewnCnHZ+XwMhrVOLtr9YXmakaBJ8=;
        b=uxAFWd07SXXdiyI+dgzc9ZoEL+9GOoExHPIF/aYpzPWnlbO3OUV/jrHXQ63fKF9XIT
         CL9i2wG2V61f99r7hBOqjMNQ9UxfvTo5j6qYpX1vZVq2yyOajAQ1visvn8P+SsPkh1Yq
         HXP6IuKIt6h23xdY+cDh0VHK36SCx3ahWd5srNzjooAyyXeUiazCcvtHra1KRWNOtXgl
         yAJwkIRK77jJQjxhWfNWRviOIWq/PY4/RICsk0CMdPPIumnuUCoqyUWDi3gxE/rtrFYh
         WMPIPb2k2zybSluJCG4iaR6ir4f1a73A9a5fY9dEhAtdhAjzfHB0lQeuAMcQTiwOa7R1
         WdOQ==
X-Forwarded-Encrypted: i=1; AKwUvBy9AJNfaySs57XEDXX7HXSBlhbG5ZrGK3YVnDcxhHZi+fy8nplzvx+WR24SDSjuWzUAsYXOLCgbm1U=@vger.kernel.org
X-Gm-Message-State: AFq9FYKXmtvELfYrr9YXht3MHTkYYC/cPO16eX2y8TzjczoWRM19vg5C
	Hk+1LPJ9iSWzPAGK/lgT9SoRvaIBYTJ/mgY+60hrE1foh2OrZixpDXPc
X-Gm-Gg: AYBFou1DBB3ytYTc8sUOTMO3JAEt/Pcgacx67sDDBe61zMdTVXgydlfD0n+fY3ARy7Y
	F8zOMhdGNxXqqOk7TNNzjuZFtOaKffD4YyHjtAh8XJNiiVv95Y9mON+AKvJ+u5hIhNkeyjD2O4Q
	cThWrfXaGLVqJVSRgxrnLuDdTrdrSM09r1o5xNJCZpct0cfFk53qhLF44ISjny7nO6SFJpBnbN+
	PjbB7mJwBCKR4SitFS+1gov1Ht/2UlVAE+ZCpf0QTbKtCFZRCtUJLrX+a3JzhU1iLTAGyKnyHlV
	OCIC0vDzKC6tcTYV/WU7auWbmcdaBjV06r3/DzjKktqEy5SR/P9I/rz0ku3NDWRVmNPC9HAuZ/s
	LxWip77+NVJGakcQg2fLZC0E6B/w2q04hlAcql+xYkY4TOxqpOh+XTIBxRqep5t3jF6MQIyZukn
	d+7Qha65b6KOiUWispozUeuuXadOrj80C+F4zc9Ogxe6o3SLzIR/CnagLbHnI4qWu8e3okC8L2J
	E4hI2o/eljnw6s2cFnbMUZNXv0qk+TrWKBunc9rZxngVzuN8erikvbjU91FTi8MTqRIzdaigg==
X-Received: by 2002:a17:902:e80b:b0:2e9:5313:8f7a with SMTP id d9443c01a7336-2eae3d1de56mr9703925ad.6.1793078784280;
        Mon, 26 Oct 2026 22:26:24 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6c9757bsm3307715ad.58.2026.10.26.22.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 22:26:23 -0700 (PDT)
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
	Alistair Francis <alistair.francis@wdc.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v5 05/23] X.509: Parse Subject Alternative Name in certificates
Date: Tue, 27 Oct 2026 15:25:18 +1000
Message-ID: <20261027052536.1722081-6-alistair.francis@wdc.com>
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

Store a pointer to the Subject Alternative Name upon parsing for
consumption by CMA-SPDM.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 crypto/asymmetric_keys/x509_cert_parser.c | 9 +++++++++
 include/keys/x509-parser.h                | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
index bfd10f0195e01..c3ec2846695a5 100644
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
index 8b68e720693a6..4e6a05a8c7a66 100644
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
2.56.0

