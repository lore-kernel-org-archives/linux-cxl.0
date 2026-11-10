Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794284368;
	b=b2/fyfJtCLz0zb0c+xZrzODT7JT1025fbLYa/JQSAGfMcw1o4TRMqckM5LdeJILrDIjN
	 fLguuznsAg4a/Ru0GrktlMJsCN5SBwXdaFrr8e0t85RPdVrARw3rPwmIENDXPbQem6nZA
	 f/AwdQCpr2VUEOyBYkRFYz3rzM9VCNZPatitBWlJTff5YzgyfXCimAiao6a3EavTfMymm
	 ygDfMm4pPLeelnoCQ5aD+riUU1tnTYdLQ53rM+elGkUOPOeXPg2pPkUS9t4+jokrUhao0
	 brMXNgivxJYzxfrJh4jJNZ7+hfO6FNsz2t/gaGUrbqUHzbZEeZQzGtZy+wTiE6aUwiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794284368;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=DF2GX2Vr9/zlICZewnCnHZ+XwMhrVOLtr9YXmakaBJ8=;
	b=VrKgEYajUP2nbGWNSwjwACxU/EMRQJCV+INS+3F+xrO0UfFtYBbZmfwn6QLr407auzqz
	 aB2if3FJQ/HLODmeU6PD5S2QSCD94VkX+lkatEHr7o3QAOl/ijy75JUeHIppxM98TD041
	 lUmt0PPV8ryv9lnct1Z9qx1lyU0/xA2W04HSb+bfgI87HJOsdquLrUi/UQyektbbWJS5U
	 7tD1C6p/kPCjDdEvf24xWYc5Lqlh8nmi9mSmrJlPEXRcQntnI5zYPKpCNXW9Y6uudHUun
	 2fn5dk6gnk+DVZFDv/kz9bg1sxg7Me71717cMASgo/+faXXbSXW3cGyRekDSvhYtSzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RWXI6nx2;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898D260A5BCD
	for <linux-cxl@vger.kernel.org>; Tue, 10 Nov 2026 04:19:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 898D260A5BCD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RWXI6nx2
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1b3a05f8b5bso2460792c88.1
        for <linux-cxl@vger.kernel.org>; Mon, 09 Nov 2026 20:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794284368; x=1794889168; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DF2GX2Vr9/zlICZewnCnHZ+XwMhrVOLtr9YXmakaBJ8=;
        b=RWXI6nx2GRh58cVQ3eVAqSiKzpFdhkGcuKrUVqZBTguWwL8ORLFBkqpFpvsZzQAr6f
         X/Bv16dT0jJgVH8v9tpsi8ml2u3NKo3LG84JzfyJR+PNTP6Vz4FBCEnh3wE/VrulnPoN
         d45MtlsnuEnECG87c1Lr5YwwY3DTHN2Y60/Z6kamzxkXxCoV5ICJIbfu3b1QLPPJpv0h
         bvDjZJ6ql5VEcKz2loy1jpu1R4doD4KIYOe8o8dMdZTwysoc63QTufoThjEcBPmF2tVA
         h1vkE846+i+TR+k5UutlaqiTFcqY0tjUa52de2g4aTAD4MWmzmbYCS6vyViMR2XhakZb
         4O+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794284368; x=1794889168;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DF2GX2Vr9/zlICZewnCnHZ+XwMhrVOLtr9YXmakaBJ8=;
        b=ki0/E/cf/JU272LQLs1zhxEpHN4aZuZdXDeov5HjHpwaiU53V7WxoCHnSDjAMU61Az
         2E3siK4GYSUSqRFK3NzP6qnqZgK6Q7OKxKisIvDYX4iOfi0dz31bpaT9Tg7gXmS9EpC8
         xWHRKArvvCDWAtT+fpc2sWEQR/4evp/6zK+dREyyXcKgaIXw3NoQ7kaW+rDkQIk8QZKh
         ZxH1TQnatw6DjsuOFbPkI6CSZWbZ7QeDcILVqyujyvTlhwbF30bgtbRdHKWdeOLZlJJB
         1RsKj3rYk805NN0xp/wCXwMB1lx3aIghKrE5lJsGA3T6TIrIOzT811LY+RufHAfMrdZ4
         Pz/Q==
X-Forwarded-Encrypted: i=1; AL+hErFa8sY5fxRyk16Mnu2+haUBO0AyHAOqnL31RSwyf7RgwyCSaAGF9N7HbV8JXnVndo/hwx99F/E3bcs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/4VHusKy3FaprdUrTqU74Zpu/jmQT1yJGLpw79F0wHNGGmi1d/
	ifrgRGXZrZYlTr5JdLXeHwd85OsOSAMwaFxxtMo4grYq0+GLpo4gbXLS
X-Gm-Gg: AYBFou0zmKqU5t3cT6MACYrQVUXgsyLYk4RiTu3bqzNyivwqFLf0lGcon6WeFlNjEJN
	MXji8GxmcYFno7IA+FuM230EbaLMR9e5Vdqz7PzNpAIuA8PhqcATikUHnLvjqF+aUBieAzzTKcn
	avTvz1f9qt38PVcl8G1GaGuNHfm20KOHUYmewCiw83d3zpueaDqJVvrMAkbZlVCYX4MWyNHalDv
	ocp8iu0AQ9JLZmqF2RQ36DJ38SuAIKEhZZIT1kt1rZQdq0V9lLHOd9n/BilWny1tAbYAzZBn/Kr
	scHROH2ZRL/c+HCR5C3i95tUgddzUNgfKeKT+VnqD8P42b42m7lfyLchM9rzTdePbFlJ0AlKhl5
	6YkmvW0S9OyVXAx4vrZ1bS6FoWT41cFDqCLAMdrRMSSK2nYYKE3zCz1HE6E7LJQmvEfxbu1D0pc
	Q8ocGYCF3imZ4T6bknx4cdWgD44CtFMPExxzLvuyZ60PuPy8JZy/W7cDSSZlDxvNfl8ca5b28gR
	d58ywYkW3KORa4iWQ4/lsxUxuh3yaAAJsF6uh3mE1MZVMBGKPQO3M1P8ekPO34yov9n/CCfm65M
	zzWDrbv0ypP3aX7y47GcCouAhSrFWByz1DRYLppmACHWnDM=
X-Received: by 2002:a05:7022:ea55:10b0:1b2:6cba:7f7c with SMTP id a92af1059eb24-1b3b605183cmr2161968c88.37.1794284367571;
        Mon, 09 Nov 2026 20:19:27 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b7ba88sm3540459c88.22.2026.11.09.20.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 20:19:27 -0800 (PST)
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
	Alistair Francis <alistair.francis@wdc.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v6 05/25] X.509: Parse Subject Alternative Name in certificates
Date: Tue, 10 Nov 2026 14:18:12 +1000
Message-ID: <20261110041832.1730924-6-alistair.francis@wdc.com>
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

