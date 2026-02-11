Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF58934846D
	for <linux-cxl@vger.kernel.org>; Wed, 11 Feb 2026 03:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770780729; cv=none; b=aLnigi2HMfm7mpBL4xTWr/XJF1hKxJruX3+6Zs864WTLWEnHtGn4gyqyoZAuC/GGduv0VuLgbdahvMpWVNwjf3mRj3Gg7AYORev9isOVZR9dxhP7Tu3Ul6SdnwYFn6r9QLgRDcKXQ2yPAHuN5UmYA9HHOhVt2v+5swMbRt3nPVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770780729; c=relaxed/simple;
	bh=BS4wcIwoXxB/BfRlgobZUgb7fvQ0v0BNsMCQMjGrn0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AP2886alShW1OXDwXyu2ixKoYZ3qn3fIMtjT+XaoPqyKyE0rsgrRkvKIuJKF9lUjsbCQRknopRvm0buMx8f6WfZKfSu4VMkYohDWUJCnOm5sMbXnDFdM/6nkPCxuyMDe4++gH4ik6JegfBvNR+iTt6vbHhNAziH5n4iXHD1sroc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jprI8o00; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jprI8o00"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-823081bb15fso2474375b3a.3
        for <linux-cxl@vger.kernel.org>; Tue, 10 Feb 2026 19:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770780728; x=1771385528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oi2wlCfDaGRwhyBd7+2iWudqGoJb/SncUXJkMt9402Q=;
        b=jprI8o00x/piRHbGbfv+vhlDiRy7bl8rTIZubxCtUkcFnIk0PG/z/o2Z6SN9QlNpC2
         AK2g1TctXDWK4gQwcA/UzFx7bzUCfzBj5JUa/Jb0MHCLfsMkUCf46ETIBRt4nH4dNSW0
         9NR1oAr6WzmsOpiyfFCLBikDE0qU0JgH2EGpuOR5DrK/hPjP5WhGzBvl/FJCpt75sF5H
         qeqGN02Skl204CHdm8ms/3H3msbpQhqQWfVZodl7V3/jTUB++ZhmnKmCiroIDWPa4esa
         34I0qfySLErFdOot3YpQ1ImNu4rKFzwMKxMoTNmT5Pexct15VusPiDax7O0hwVoaXLg2
         oKTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770780728; x=1771385528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oi2wlCfDaGRwhyBd7+2iWudqGoJb/SncUXJkMt9402Q=;
        b=YyrIr7JQf38vega3AVYTH0zJHaSYvdfWc0Tmq/T8p2nnC44XSllVdVuXtNd/VKE9eE
         WQ9RF+UJ/VPQW/mvgVPodrX9BVN3CrbGt5VZFMNdjp5NJEO7m9xGMcne3besYSE0A8E2
         ehfsK8//Gg8EjUSD2UFe3TYV2kkuIHwqL0T88bdPdx/nMMOjfplGZjUGaDGdf34B54oS
         2BpI3ZbGpIgrlY18nyO8dtBUXD1DvithscDlDZ3jE7YyVJmbevsySgpV5G9SBHNPbJWM
         gO363B8W89eU/DlgzEOQJWNOTlkeWspZxAze3NEDSII5cw6QDgAy1xkFDiDEBLISw3l6
         RpWw==
X-Forwarded-Encrypted: i=1; AJvYcCXQiiaNehpwBAPfO2rlHkPYVIg7YFgFrgNywBivBYAeSluuPj+mh22vmWKqNeyC6PP0aqZl0sVuNf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBRDTpKoRQ+NYwkvMrN1SiIgaQLvtsnRSNp2WpAqkrTRYJL/hA
	JUVzzKF98z1hqf4q5XidkArhHI2Dm5ebw+u7nEfpSC8HRdIYIwdUwStU
X-Gm-Gg: AZuq6aLgVMWVqUNsRdAYNKdMjA58glWefQ1p09+oYoObyaGupQLxb8BYwUyClvV8Dtb
	C6NtiA5RZqWVkM5M7TDw6mDGt/mS5oSbTpPR6Ra4yNdAz7KYCTv85hJZcjMRjd92wwR/72JLm9w
	zDQwMASQZXZyRR67WsJs1rHYnvioJ+OwdK5uJ0lqyBFKKRS9t55MF/9qbBdUhqvaelvC7ybGbZe
	LOdKjaM+IlJJktVIL0a0jMvUnOOQ6e+fgIrryfddCu1A8QiZQVDK6VEUQefP4xq1jLvf/XxoFZi
	mu28Nys1ICrBpqemxlktpWH/oPEvZarQRWRNrkHXLUXDXAtKiNHgeFUi0t3tms+nv1mnIqFtmMR
	Hxj+sc5OeSejqJDd405oaGotTHHdHAdnHcu3P4ktW0v/Rzku/UDHXUs1FkyQ3zOxM2GLZW7BKaT
	xQIvhfXIH6IpTzrq/KbpUVhmmBmt95kavNNG5ww7e5Pg==
X-Received: by 2002:a05:6a20:cfa9:b0:334:87c2:445 with SMTP id adf61e73a8af0-3942e3c472amr1397613637.36.1770780728067;
        Tue, 10 Feb 2026 19:32:08 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e197d63c9sm464856a12.20.2026.02.10.19.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 19:32:07 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: bhelgaas@google.com,
	lukas@wunner.de,
	rust-for-linux@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-pci@vger.kernel.org,
	Jonathan.Cameron@huawei.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: alex.gaynor@gmail.com,
	benno.lossin@proton.me,
	boqun.feng@gmail.com,
	a.hindborg@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	tmgross@umich.edu,
	alistair23@gmail.com,
	ojeda@kernel.org,
	wilfred.mallawa@wdc.com,
	aliceryhl@google.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [RFC v3 20/27] crypto: sha: Load early in boot
Date: Wed, 11 Feb 2026 13:29:27 +1000
Message-ID: <20260211032935.2705841-21-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260211032935.2705841-1-alistair.francis@wdc.com>
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair.francis@wdc.com>

Work is ongoing to support PCIe device attestation and authentication.
As part of this probing a PCIe device will require generating hashes via
the SPDM protocol to the kernel.

Linux should verify the device before enabling the device, which means we
need the crypto functions to be ready before arch initilisation (where PCIe
init happens). Move the crypto init to postcore to
ensure it's loaded before PCIe devices.

This allows us to verify the certificate chain provided by a PCIe device
via SPDM before we enable it.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 crypto/sha256.c | 2 +-
 crypto/sha3.c   | 2 +-
 crypto/sha512.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/crypto/sha256.c b/crypto/sha256.c
index fb81defe084c..0ebe96f89733 100644
--- a/crypto/sha256.c
+++ b/crypto/sha256.c
@@ -398,7 +398,7 @@ static int __init crypto_sha256_mod_init(void)
 {
 	return crypto_register_shashes(algs, ARRAY_SIZE(algs));
 }
-module_init(crypto_sha256_mod_init);
+postcore_initcall(crypto_sha256_mod_init);
 
 static void __exit crypto_sha256_mod_exit(void)
 {
diff --git a/crypto/sha3.c b/crypto/sha3.c
index 8f364979ec89..d37ce694b50a 100644
--- a/crypto/sha3.c
+++ b/crypto/sha3.c
@@ -145,7 +145,7 @@ static int __init crypto_sha3_mod_init(void)
 {
 	return crypto_register_shashes(algs, ARRAY_SIZE(algs));
 }
-module_init(crypto_sha3_mod_init);
+postcore_initcall(crypto_sha3_mod_init);
 
 static void __exit crypto_sha3_mod_exit(void)
 {
diff --git a/crypto/sha512.c b/crypto/sha512.c
index d320fe53913f..6effa6043b55 100644
--- a/crypto/sha512.c
+++ b/crypto/sha512.c
@@ -404,7 +404,7 @@ static int __init crypto_sha512_mod_init(void)
 {
 	return crypto_register_shashes(algs, ARRAY_SIZE(algs));
 }
-module_init(crypto_sha512_mod_init);
+postcore_initcall(crypto_sha512_mod_init);
 
 static void __exit crypto_sha512_mod_exit(void)
 {
-- 
2.52.0

