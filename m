Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794284505;
	b=galayqbMU7kb8W0tGWyE2UKC2ahla2l2ktkNpaw5/Pm5/pzLtBBa9PFM0iawqx4tUgty
	 1+JqUuh/qKl56y8RyqkiizePV933ylgcU07/X+LaG1GOGCGnkN2bHsyC7ULIf3UtMi+2N
	 cn4HcP6PQXumf8ergZyqCvKyy+B0bvHRu5WAQxJR2sor5bU6Iz29ENwYkEW5FE948wcg1
	 xEd2NkBUGt/XDIQnDYwgDDU+XckDAhSxXu4YDkRhjmlDx18EXgtc7WtZrP/Eq8KkJdYQK
	 LGsdgdbiu7Hh3gacyJemN2B4v5CFMUuUpWo1YtnnpgMjwzDg9ZUciLmkveMIQa6phAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794284505;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vvn0N/Mf2XDKU1UdfH8n9zC897rDJdvpuyd+JGWtjC8=;
	b=Ykh/X7MVmjZuK/vQd4mPjp++hc3oXAGQhq5oxSIK2t/grFfyM59YsDhlWZW1kAGL2k3U
	 lVsv52sJS9plDuMf8IF/V2/VWl/uIWcwhdGurc7u2D7dqDm3Dpa/7dWXKVgS2dUEQOZDo
	 qJ5Jp6q2lW57veTpehyg71dkse2cXAhhuBzG+RZOAIx0C7F8CNq1MhEFVVaTtq55BcSzp
	 HoHCMB8g55Tb0SJeyIpy1pXWa2S7AKKKU4uqtK+nVHlEF/5AHHE5n9b6yUMw9y0Jd7oKr
	 92Fq09ov6DEcsNDuzeh0Vlh6lzQRDwAFlbe5yw1FeQz2GQV7BX+4nmxCy9cWxElseDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="CkUNtGc/";
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DFE606BB37
	for <linux-cxl@vger.kernel.org>; Tue, 10 Nov 2026 04:21:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6DFE606BB37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CkUNtGc/
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1438d9363fbso947918c88.0
        for <linux-cxl@vger.kernel.org>; Mon, 09 Nov 2026 20:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794284504; x=1794889304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vvn0N/Mf2XDKU1UdfH8n9zC897rDJdvpuyd+JGWtjC8=;
        b=CkUNtGc/IdLYYEBp0KfBNkDLcjNwOLWYY5889OwOd8dCaFE/pf6bgKCp/rWI52S3ig
         toH2RRyJFa5nCKyAUhemTo/KpcN1Sol/MHnT6mreE+/sBMF+rcYuk/vXC7DLEpb1TksY
         40CIWTNqGVX/JHGWNy+FnSxhT2nwChIEo6oEBwK6JgP3c6RVyAmVg8pzY9URuyqe/WIb
         ILI+4NBT8WGoAw3WY0T/6s4zF9RNfmSqRkwAEtpgwUbdKA67MMBMEBigjCTB/EEYiroC
         D+7soLk29vQwyd6m2sF3Rxojj2AfCDcxhi6pqxHyjzb9Vrbdncc8wTMokfoL1xd3TttE
         074w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794284504; x=1794889304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vvn0N/Mf2XDKU1UdfH8n9zC897rDJdvpuyd+JGWtjC8=;
        b=fXXvxtiPZydLnt9OvaNHU2ggswuevSUPfDGX/HfSvM8Xzo3HnR6Makghr/UAVyabSX
         lTaAsuG0VNHv0pi2Hu8OZuz/62JFU8IBOqEIYBoiruufq5EA3X3Cy6lauVjDMaLX5Yif
         3xtD4nDiUPEGJ1gGCj2sGnSVNxQVw+xie8MPzGbaZk4GxYP6mKSisPHi1fpRS6YcA6yz
         naPoLIl1Ckkx6gNaK9o9Z8BPMw3Jd1KkFOJuWNP9BlnisaEPVcGubgW/hYQx7G5aYSmm
         co/dXK1bPoRlP1xunXXSp56HK5NzM7REJP/SxN7s+2c803kQcMHzmbupC1Cd37ecq2fP
         Ca2A==
X-Forwarded-Encrypted: i=1; AL+hErGNXGIyWfDeC4Z73Q2+3L7OkZ2rqHyHMb6abB2WFG3fEe6L/yHbYHK1Z3R7RDEqzs5GLS8kvcBgvvM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+YV/jjAeVJOHjK2DjEc2Da8WWaD8XLALBLbDfEBAxjOYWCG2Gr
	b6RIH/a8JUppnva4OalaQgE3N0rDtQKghXEL2sn33sKpD3nLDP0cdoZ8
X-Gm-Gg: AYBFou2uUu0VVS98TJFzXdX3uJ5oYjT1A6RmpSMPvEW+gS1WqEDccOeDjb19/JSyAky
	hne9wetFBPFnlnBDrtVEN1LDhQ7ZWW/tnJCi96oTTx6QQ7yRQ9rB5n9oqDM9+uCw0CXh9qeoBF4
	y8t8lzbBS6GGW3v/r7KIR1fb9GWCQk8cCXH1nr6EraX39+TqGGuE3Dj9emf515OyTFGaj1wB99Y
	opFcH3z0v0UXP08VkCgizKrmkPLFAXZb7aZebJDd9fJxPUE/Wtfubzm4xzXZUUrPIasjr1PG7gu
	lNnO47ExifQg4BpoyrtBfo/Y4cBVenaagp39mhHA/GI3W5hO3cgG9LCYeM+V4nT1E1Wk5aeQoN6
	GlgNQQgrz/P6d8BtK/CmOw7hVp3NjXVfFOy310Ya8gEof7SN4gsDEgJGD452LKLV3AVphiUNRN3
	6y53zoNyworxNj2w3rn72AnM5qGo/zzFui+9yodkedNsGr870dR2EQZwYZb6Keh+stCYFR22WZ0
	FjoJVNplUI3oUBHYl1a05Ze7Z/3rX6m+PUskT7DNTmiXCGl/rZmux3okyiDKxF2RiJ7NqL2wm3Q
	hR4qar7seuqh8Eoj9UsGI1nAWlYqTMtC6I7TmuH4yIlKIR0=
X-Received: by 2002:a05:701b:4642:b0:1ab:e9b8:8a28 with SMTP id a92af1059eb24-1b3b5e167e5mr1932957c88.5.1794284503989;
        Mon, 09 Nov 2026 20:21:43 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b7ba88sm3540459c88.22.2026.11.09.20.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 20:21:43 -0800 (PST)
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
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v6 21/25] keys: Guard asymmetric-type.h behind CONFIG_KEYS
Date: Tue, 10 Nov 2026 14:18:28 +1000
Message-ID: <20261110041832.1730924-22-alistair.francis@wdc.com>
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
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair.francis@wdc.com>

The header keys/asymmetric-type.h includes linux/key-type.h,
which is where `struct key_type` is defined.

linux/key-type.h has a `#ifdef CONFIG_KEYS` guard around the entire file,
yet keys/asymmetric-type.h doesn't. So if CONFIG_KEYS is not defined
including keys/asymmetric-type.h will cause build failures as
`struct key_type` isn't defined.

Guard keys/asymmetric-type.h with a `#ifdef CONFIG_KEYS` to fix the
failures seen when including keys/asymmetric-type.h in the Rust bindgen.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/keys/asymmetric-type.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/keys/asymmetric-type.h b/include/keys/asymmetric-type.h
index 301efa952e263..b77bfa7bd5904 100644
--- a/include/keys/asymmetric-type.h
+++ b/include/keys/asymmetric-type.h
@@ -13,6 +13,8 @@
 #include <linux/key-type.h>
 #include <linux/verification.h>
 
+#ifdef CONFIG_KEYS
+
 extern struct key_type key_type_asymmetric;
 
 /*
@@ -93,4 +95,5 @@ int x509_load_certificate_list(const u8 cert_list[], const unsigned long list_si
  * The payload is at the discretion of the subtype.
  */
 
+#endif /* CONFIG_KEYS */
 #endif /* _KEYS_ASYMMETRIC_TYPE_H */
-- 
2.56.0

