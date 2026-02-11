Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC024344050
	for <linux-cxl@vger.kernel.org>; Wed, 11 Feb 2026 03:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770780708; cv=none; b=BLtIbop2RwyFRdFDXTDszZIj8EaMEbwiy2AzZC0Ow2uKQwmVNGeXJXTPNNKlVMW53ghQZY0M11UOanU8+rIeSnvAK6tuKXeVr3fWU6YIb5x/y4v6MuTTfOdX1gFE40t/MqTt45q+UszcFw7TN8p1KN4h+HwweJ35qlZVRJ/9J4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770780708; c=relaxed/simple;
	bh=+Dv6Jp5OhwC7087KAYCtSukovH0C5t6UM5K7Pi3a9Lk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MYLNuFEyMmWVwcm04lGPnjsLif9IygJlfgQykl920DcM50XlAmE2Ctbr+Rd/tdr6eXVgTRzY1VKLsD1VLVVPkdCDmdRiZuwWql/XrCgETQZzdFNzTAqtmyhb01EOwVNPl1hT6b8HXvXBYLqXelws4LUCTsNx3LNZBFNL5ogBwGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iDBYRPJQ; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDBYRPJQ"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c648bc907ebso4096623a12.3
        for <linux-cxl@vger.kernel.org>; Tue, 10 Feb 2026 19:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770780707; x=1771385507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3mB5YXChxH7A1l1HnU2HjGhx6UZiL0/lHVVqKO5gi7I=;
        b=iDBYRPJQBzfiFaGZ9rh2PBQ3hmQLykXxB94fynOLlV4iaOfnt1TG/OOUgWpr8liY6E
         ZRB+M2z2PHMCzeccm5nvMb5ciFPgx0mNA+oXyviAbeA7OlB3EQgD/qCjj1i1Nr2Cwwyh
         DSbDiIteS0UglJBv1FsIVgTjHWBCqzoDbdQnN/IP2kCe9CR6kuBrMcfYQmIMoYeR+PR4
         fGkQrjTB3dgpy5US6JOCRbLsg6LhMObK6lv/jttxq5JU0ZJek9RAroXoMchEPcD81CG5
         5QAa//34HJYaus7BWWPlBRW2WVcmppp9nrEzCe6rd6WpKPnGFphsRcFTOND5woPwP9lM
         5AqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770780707; x=1771385507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3mB5YXChxH7A1l1HnU2HjGhx6UZiL0/lHVVqKO5gi7I=;
        b=qfR/8USxk7IAl8wwjaRmrzfIASHliJt22ldLsqIOrQ1tV3nZTg9VQfrs6f4KCm/tjZ
         sIwXBYh5LOj46VQquhYvX44ydKE3kIBv0X8qdt69KvlEoNY50Gl1pppAubj9TZ0S/FWG
         IL3UreEIiEM9eo0v/u07BF7pMSG6ofF1lcBdVWZgk/idj78S+83ctuMk1pNmgAF0MZrY
         PAQznhv6HJUqKzQy1UZQqPIDIloAjf0WRa/q38SEku+LuW4Iox6bglejgQGFviOgvbK/
         WJ7z9PSAAXHtcxwiBwQ70R5wItgQkJOas2DtZSRMjNAdi6LY9D2EpvYQ9A0EW7UpYwhZ
         ZIRQ==
X-Forwarded-Encrypted: i=1; AJvYcCU73e6ZmpLkh6ctTCJjunpzP9s62BhkwTcMmu1sWGOsVRWNz2goUimmx7umW7/4y3CXaC//eo7AUiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwivD7Fg0qEQPzyfFjEg6vaiguzB+7mQN1UEdUhjM8e/K0vPljN
	tG5opRjBaAHUwdnqQ02+JSZ/fTdDl2Zvw1OO/AD4DMaQOwiZct990+rm
X-Gm-Gg: AZuq6aKZGERz2yX+/+83+7wheEU+tk5aF/dd5GkXcRsZZ1ugEflfPYRcnTLlutuEACv
	qF+6rDl4PWaA/Ydq23G8KY/1vYAZtULQmHz1B6KW7R5ecAV5RUnqcAK11fbgFQ67PkBvaSIIkiK
	aDTq7zPI2/znYvUqr5iHfTHhOAr950eR7rSQYCCzcxS6U0zyI/caGgjGHMJSKuV+GRWrOuweYUX
	JV8tCaPzkb6jgFW81vwU1/UiK7QRxvf1ihxdTuIi74jiRoiYe3fueboT37sHyZYywT2Nbmvfd/1
	ly0PKXYCEtNNEfT0CW/mDMTuEY9fN8f4OttnC826b7d+egg3cWCT/LCqFDoRNU6QAKCJHB90Xwm
	dxWaVVGFrVUKANswNG4fMEoBzv9KsiXguKYoS020DUvK03TEL5zaoJ9GgbMKiWO42u2TrUselvn
	oTmHgQyfQXTQbwZ66ynyHLE4UmgOfw4Ogxmh35hOW7PA==
X-Received: by 2002:a05:6a20:3ca5:b0:38b:ebdd:919f with SMTP id adf61e73a8af0-3943229ad32mr804189637.1.1770780707132;
        Tue, 10 Feb 2026 19:31:47 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e197d63c9sm464856a12.20.2026.02.10.19.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 19:31:46 -0800 (PST)
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
	Alistair Francis <alistair@alistair23.me>
Subject: [RFC v3 17/27] crypto: asymmetric_keys - Load certificate parsing early in boot
Date: Wed, 11 Feb 2026 13:29:24 +1000
Message-ID: <20260211032935.2705841-18-alistair.francis@wdc.com>
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

From: Alistair Francis <alistair@alistair23.me>

Work is ongoing to support PCIe device attestation and authentication.
As part of this a PCIe device will provide a X.509 certificate chain
via the SPDM protocol to the kernel.

Linux should verify the chain before enabling the device, which means we
need the certificate store ready before arch initilisation (where PCIe
init happens). Move the certificate and keyring init to postcore to
ensure it's loaded before PCIe devices.

This patch enables X.509 certificate parsing and asymmetric key support
early in the boot process so that it can be used by the key store and
SPDM to verify the certificate chain provided by a PCIe device
via SPDM before we enable it.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 crypto/asymmetric_keys/asymmetric_type.c | 2 +-
 crypto/asymmetric_keys/x509_public_key.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/crypto/asymmetric_keys/asymmetric_type.c b/crypto/asymmetric_keys/asymmetric_type.c
index 2326743310b1..3f209299ee3a 100644
--- a/crypto/asymmetric_keys/asymmetric_type.c
+++ b/crypto/asymmetric_keys/asymmetric_type.c
@@ -677,5 +677,5 @@ static void __exit asymmetric_key_cleanup(void)
 	unregister_key_type(&key_type_asymmetric);
 }
 
-module_init(asymmetric_key_init);
+postcore_initcall(asymmetric_key_init);
 module_exit(asymmetric_key_cleanup);
diff --git a/crypto/asymmetric_keys/x509_public_key.c b/crypto/asymmetric_keys/x509_public_key.c
index 27b4fea37845..2b308345bc6f 100644
--- a/crypto/asymmetric_keys/x509_public_key.c
+++ b/crypto/asymmetric_keys/x509_public_key.c
@@ -258,7 +258,7 @@ static void __exit x509_key_exit(void)
 	unregister_asymmetric_key_parser(&x509_key_parser);
 }
 
-module_init(x509_key_init);
+postcore_initcall(x509_key_init);
 module_exit(x509_key_exit);
 
 MODULE_DESCRIPTION("X.509 certificate parser");
-- 
2.52.0

