Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B1038D3E4
	for <linux-cxl@vger.kernel.org>; Tue,  1 Sep 2026 01:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788224686; cv=none; b=ibsILfQXUMVj+gvCfvbIh0R9RVHR9VpeGmUagOBQ6q11GUTCiRxFaDrDiJ7fmmCzcPi13JmX4WMNgX85i+T2fOO7RfU5vI+YfPQWeeLc3F7snzbF4l8iW4pHgUZX+OiyX8evELLYhbzSlJUEof22O6ipcNUvgQg9xlofxGW/uEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788224686; c=relaxed/simple;
	bh=0JGUpE4k1PmLAxdyW1CDm+kOaSuNwlxy5EWP/0iy7YA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KxEe1p7UVqn0q8PtldHSRh7qv3gYAoknWofuf6XMGJ2fs4lc3NCfy9X0OcReSxG2fCbbLc5cG1dUCgVsVfIiUo3v8N0WTf6vqXFKIuhI+OlCyerj/TBhO4mQwlwuPG2LSjmBUw/ifzg9fwxlIzFA7oEMZy27FNUeNpv4LPAjLCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZH/KDUO1; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZH/KDUO1"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cc1c73645a1so331228a12.1
        for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 18:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788224685; x=1788829485; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jIcsSTZcRttPSVFsvlIP8uLVExwGwURdPEd6Mb7+UkA=;
        b=ZH/KDUO1OJqNyRRHjzC3y73qmUoR1g2KaffL5ytGdfTG1zYhN6QbNTJaivUMq/fIPM
         dV3KeYx2AzQ8DSmt+WOy0VzUMTv4VLQz6PqN9S74fROy6FYg0oIOyLA+YzYVASRKWjAZ
         LHuFbnYDNVf0tHJfIwTp/Ro0c8LQMXo6p2wojDvEx0nniofuD3TXYO48CgwHbhR62VJq
         QJoKoDckeLshKSmuD9hXLcKfCh3fguWu/h6v+vU2qSAVHxRYC1x7JP7z0i0vipxcWCf5
         Wfp0Df0fnEekfKgCIGZN8VNGMW3pwLXfNnPMvllz/NlGymilnXXl2QCyJPvC9IVpzSCb
         HMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788224685; x=1788829485;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jIcsSTZcRttPSVFsvlIP8uLVExwGwURdPEd6Mb7+UkA=;
        b=n+umtldVVu6o1A/EOH13GngLYWzZD/Z+1s+Zmh7NTh6GvHYZ3mdp+X9giyXc8AUCeA
         7FcHXYUgLqvpLmoMDFrsINQWlfPVXvHDu8FhhBWs9CY3UhzKHfiCBEVpZrRTuGDCmtRt
         QSFkzt1miPuLxS4mamC8y8EWLzu8MdS43oXN1II8hrvD3aqiZwomHe9qYvvNPoZzEHSx
         +yS/ZISXAtaadvvXo9v6sAX1OuF/CFD2h+BYhTtHvgE44CQ/OUdZc47bvD3jUHDmpaZJ
         RYjIrKqyRhWTXDmJMiDAAOYKwbqbeoHEtZxIaZZp6jtQG/QnUQNKL9PR/6vdd7h8blmy
         JRFA==
X-Forwarded-Encrypted: i=1; AKwUvBwhzt++d66b0xeGIChmRgCQjb07MJ5UPK4YVpNT68VLriIHA5qEaaAZJnelg1/E7Pz6dIPY0kvpEtY=@vger.kernel.org
X-Gm-Message-State: AFuF++nCxSuqDjI06vWUcGyAikiXqsAk9Vcsi4bvsoye/Ss09JGa1HYo
	RfDcw4Dmylng8FPtgkj1sl6Y3yB4tD8Q0XIXNl/AWB9ex9d9Wp51+pVh
X-Gm-Gg: AYBFou32Yv7v5OoGT14QMKwUo5v6C2aRGCa13u47KIuEpb/yjmXbUkcyv0dJ28h0zrG
	HXGfWBh0Awgb9t8LjtJwZMxcoNnC1+IL+JD2g9RWEGuDuNJDcMFdHIHAt6tfoK8kLJL03T9HouJ
	JtCuVM+tYc35iyPSu6XpqQN6L1k+bFMkN9jPL5dGdE+OD0ikIB1C9n9dGVmiVuyOpV4mtgzqO9T
	xpISw10tpRtkSK72dRKNXSXJvJbmhtuss5bvQmusdCJmHVDEY96Po0mt4TPYwRwu2OGVSYPAZ2/
	gplepqjfk2zKBizPl+zsghsSFjx4tiP8AxQNKvGp5iEvs0+qQY+o5or38E3OqkOjWxs+88ry+IC
	yUyjfYbephNJqUEc+JzWUfS418E+PO4cQaZreiTyr0jWa6huX7NDVojIoVp5hJRfenz0PiqLjAX
	239kgcNtMplUdL8dP7W9O4PZw8IQhDTNvu4HP/lrSMBrWliMrIEOCjCijYVKkd5NQevNaMIRDFD
	EKuWQ==
X-Received: by 2002:a17:90b:4a81:b0:399:1f8b:d255 with SMTP id 98e67ed59e1d1-3991f8bd96bmr528414a91.5.1788224684691;
        Mon, 31 Aug 2026 18:04:44 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990d49e9e0sm2372024a91.11.2026.08.31.18.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 18:04:44 -0700 (PDT)
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
	Alistair Francis <alistair.francis@wdc.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v3 05/21] X.509: Parse Subject Alternative Name in certificates
Date: Tue,  1 Sep 2026 11:03:31 +1000
Message-ID: <20260901010347.2614656-6-alistair.francis@wdc.com>
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

