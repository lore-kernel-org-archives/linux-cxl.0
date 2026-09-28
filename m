Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com [74.125.228.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075CC357A3E
	for <linux-cxl@vger.kernel.org>; Mon, 28 Sep 2026 01:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790557939; cv=none; b=RLVBUwfKIwchMN/LePr5WyPZd29xiAbeAY6RQCfCMhHzEqiEZOzsBXM5ykGU0724cylKKMyfMg1Z3Owt/nMMXZhviIEv6yskFLVv9Q4urSJN/Z8JtP78JslDYnsl51bYgBFae/uHtR1FqJkzCcTz5V1aVzQ7z2d7C46N/3uLo48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790557939; c=relaxed/simple;
	bh=0JGUpE4k1PmLAxdyW1CDm+kOaSuNwlxy5EWP/0iy7YA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c6j7dK0d5EmRcunS2+0uYwjICmjMopvR2aHmOO6431B/PDxdSB/b/VWtO8cP2pUgDoYRszvnuG5ot+HVBspLbt9EFNg06mu43hRWXxS/lPo/n43W51dkouZTrwqThCDR6omDHcEfGGDyE4/QNDGC6IfT/QzSkxtgHVS2VViNzuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CkOp6dF7; arc=none smtp.client-ip=74.125.228.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkOp6dF7"
Received: by mail-pz2-f39.google.com with SMTP id 41be03b00d2f7-cc7979d1deaso458109a12.1
        for <linux-cxl@vger.kernel.org>; Sun, 27 Sep 2026 18:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790557937; x=1791162737; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jIcsSTZcRttPSVFsvlIP8uLVExwGwURdPEd6Mb7+UkA=;
        b=CkOp6dF7bKujR2NLbnCjDt2tRvCu2JAPqR7XsVkRKsgj/Y6vx9+7fz9kS7g1ZwNckf
         CXq7EHdTw6hD/VLldSwzMMH4453lagngjaTgnju2YDB3lIymxxFoXawaRe9szEh4UBaW
         IvHg2tAtsdC3inEFQHNDk+MQP8Vcldey7IwQ13qT0ClpbLBT2rQjaM3hJGRfINxUkVck
         SEeQ4u3JI8R8HIM7i6o44ve9nT2kM4pjXMk6gE+H8vctzEancsAf9oHsGkl1azGEXs94
         JgkgH4pj66AgFcWoKHLVM7BrDdcDFySGxh5edchXfVQJO4CgVJO3LafM9ZF5ahdLrPB5
         Pxqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790557937; x=1791162737;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jIcsSTZcRttPSVFsvlIP8uLVExwGwURdPEd6Mb7+UkA=;
        b=UhK1xdJLOMZWqAWUhvj9qq55dTaVEH3PA1+jgjx9dE8K04d9AuSVfy4deU5st3sykr
         ypm4O93pw6FEpSQql55jl7DnbKuJDMVnH3YH3lZtxHiC3zZfStNdha7r+m2anUOWDCTw
         BCQkQJJyiLo25onPIJiMyzv6/WbGyV46jJtrsv28XKvhRsgBjBI8U2vPLVzfroRweWAs
         j4ewTRigMSMbYCNjGocgG4R4q8PNC0j5vd91qqiwtba03aUsSi6GSYrdo6Y/kegB4p14
         TZb54qYG8Q3yHGqNQJJ778CvxxxRrY/vf4YYU63puXov/Id3Ythe6ccdPaCddj0MIno8
         oKCQ==
X-Forwarded-Encrypted: i=1; AKwUvBz9qOOgK6+EkGy1G5l6ws7/ehtAyro+MfQMF9i1rCkzvXcy6d6rXFV/pHancIeZuTIVzHQ4VLnMRFo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIJeEy9lBzoDgtUa4f5pTp/NkMm90yPj4/ntgKQ3YAidmLiyFPa
	gL7kweeBTeYXVUXgTJPx1v8O7Cyaqhq4JJnyXRm+L0l+0iOpipm4LFkK
X-Gm-Gg: AYBFou28WwE82SNfH+b6oEIibQ+83o5L3er+dkri42qtK9Maz++aGzQaMUeXm5zIELf
	Znit/S6ramI8eKXJkrnDUQv93hjVXi68DgUcVQAUc/rGR7KCtjmwZpRt1SfG4k+/ZADjSi+ibG6
	veU8ESRleLRzOpCBxqrPMjLb1kiKKGlJJ6yyiGI81a09Ox4hKdiAzPHG5LF13Kp56GvS/O520cW
	cNJ01RVFsNuCpWKnoXBASqFa8xIRLVCoHy/d6OjD92JZYk9wIrD6n3Y3eujPBx6kfP4T6gGaqzo
	D61JhB3SRIoQVUGEpi0S6+Hu0k6TnGUDAxSZknL82a0FIxYu10n7BeKKbOyGFdTud0+O4EUcjvf
	WZ0xTmUQz0/eZVIwRyQLCBn5DFop4Fc50tPFPcfoDykLvciZ9A3jc1bPnWYffxog3/wDsxZECjM
	axUlL1Bi0o/gQl6pZX9VL3tV7oLc+9CBc1nsARo2VDm1OaViZkuKUDdhnyYZHoYcnmwdhrFe47H
	de0eqeHsQe8UHJQ
X-Received: by 2002:a17:90b:28c6:b0:3a0:f2cd:fa3b with SMTP id 98e67ed59e1d1-3a0f2cdfd7cmr2894386a91.46.1790557937216;
        Sun, 27 Sep 2026 18:12:17 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0e7036e3bsm10425773a91.13.2026.09.27.18.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 18:12:16 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: lukas@wunner.de,
	linux-cxl@vger.kernel.org,
	akpm@linux-foundation.org,
	Jonathan.Cameron@huawei.com,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	bhelgaas@google.com,
	alistair@alistair23.me,
	djbw@kernel.org,
	linux-pci@vger.kernel.org
Cc: wilfred.mallawa@wdc.com,
	a.hindborg@kernel.org,
	gregkh@linuxfoundation.org,
	alex.gaynor@gmail.com,
	alistair23@gmail.com,
	aliceryhl@google.com,
	benno.lossin@proton.me,
	boqun.feng@gmail.com,
	bjorn3_gh@protonmail.com,
	tmgross@umich.edu,
	gary@garyguo.net,
	ojeda@kernel.org,
	Alistair Francis <alistair.francis@wdc.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v4 06/22] X.509: Parse Subject Alternative Name in certificates
Date: Mon, 28 Sep 2026 11:11:07 +1000
Message-ID: <20260928011123.450800-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928011123.450800-1-alistair.francis@wdc.com>
References: <20260928011123.450800-1-alistair.francis@wdc.com>
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
2.55.0

