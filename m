Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3384D356767
	for <linux-cxl@vger.kernel.org>; Mon, 28 Sep 2026 01:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790557954; cv=none; b=qQngQQO7oRvMqaqsEJlkyfaqy8mx3euyPwtB2kWm2QH6h1URyHjW8VCBEMIoE4D+x8kXfJa21QLaSWB+XZcl27EBvPJPeAGlngNwv+Y6uWN7yYgvFuVqX83DmqGWTkiApgNsutMYn6eibuTa4GBHxiC3J06RC9r7/cfKxP+2ESo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790557954; c=relaxed/simple;
	bh=7H9GI30AsWmAlTdg30uohie4gLRcANCA6UmHmEupp3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fyn44PTgoG+26q3/T5IE3kYye47R7yVKjEoUyCTgCWIlVb8OORyCRammVRxTQkWSimwwRlxcZJwu10ZDA0VVXCd3CeQdWX6QMdZZ9zoC9VUhaNvw6t68XziGlOPdMfGsEgBUYsiOEy/DhtXTw/9vbHUIKQJPgXJOPDYEqg45iQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H5+l+qYo; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5+l+qYo"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc4c08393b0so971291a12.0
        for <linux-cxl@vger.kernel.org>; Sun, 27 Sep 2026 18:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790557951; x=1791162751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jWbFM6ywa1yjj692OE0MrLQnEnm7JyCgqunSYul2orw=;
        b=H5+l+qYos+zmT6KE8uplrh8S155yY15lByYW0kkZcZYgRqPz7z+r7QD8+mkh/gSBQa
         riyTtQNBiCV0oPPqW8du0Xq3Bja7ChLyfT1vqAHuaNi0Ls5Amq7XHl5T73QZjdaXXmRw
         cdssomUZFMpui0wtviLJK87a6SaNIoK8x6YR/1PA9FByjtv7x0MlFW8yrcmihKzr675A
         8/wtREQkdLLoPffPgcsS8SwqFC3OFhkDunkFrDrKBkcjPQE35y0Gd/pJIcSO9S213i1V
         QYmB1lNO0h5Cy2+kFgVmaoO/JI1vFfyU1sPg7jKVZEHc5vt1QH2hfFgFJvrhtruOhSs0
         Hr8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790557951; x=1791162751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jWbFM6ywa1yjj692OE0MrLQnEnm7JyCgqunSYul2orw=;
        b=egs9bu9gDBu+fBiNayLZ+ooY4cgslN2ib7xuC/PEsMwjTF2XbSD6ex+qfg5zwM901W
         30BIuxtlC+RzOz57As7DlVNR4Vv1+XHzWiFQx0hEd6xujobesI3fFlf2OvvPJVyWfrFs
         BxFmeCIdFmJBbUN3ggzy++BwsoX6GEGBf8mWqwluv6oJceYCELS6Q5xMSZQzbV5FZMd+
         Adw/Bs50gZeS+6uEjT6M+vmenCOMfeCvh/FHaxSuiAi5orp0iXqGmG/w8ktfSuz1ry0Q
         fF0EmyBO5eV19ttJ6ey/b2Ho5Fyd5ILzvIB8pP5l02gxgRxkMGCYVLRXOd6W/+hNUqpC
         KxAg==
X-Forwarded-Encrypted: i=1; AKwUvBw6Py8eSECbdNxHdLa9JVhjDvauRwLWq6bB0Rbp11Th7wDQ7fskrPAes+eKiFn/I86Cfe1GAjt7Txw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLq5DbKGMUfv+wtAcPjd6u0+99fVaQWIz/fzcwTwrP9OJjfiChe
	jRSCPVDqdYObrxjP/G7z6BqZ3YcW/WFQEQbOIIWRYHxcnViv8DDvYxUR
X-Gm-Gg: AYBFou3iAeeTf6WSqeju6swocqpcnT8j1dYlLCwlQojvdRwxcja98LWVaq0Rk5ow3uA
	tmj53fRpuyPUaOYlFBZ+KujUaBt2fSFzoVZclhREeeLYF784k/pAhJoPApDI3hSUjJSdcXFAsin
	f0zhBLZ8rGw5gtOXazuqg7Vuh7MT9yv39AUmKxxQVnwNBRlRByxMEZsEQ2M3sCszZSeQR6cDylE
	dxDESUMOpvOiE84i+/mpN8y4/gzHvkdfG58eVeG0RTYdBScP0d4feovqwqzaIK34koWa4rJX6EJ
	Rke1RfZzcD5QU9Lc3VmgeFwVge3S30o539qxJ6KLe09bWrLn9IVuJHWVDD6kW37rU4YBosFdwYz
	rjmXKakKgdzVUWb3FfqA+cApD4tyTvwDCcy5z6RkZiS8F9Xx55uxbQJR1PnMobtRGVUvPWuPSAu
	JDlAjBm9eQlGElPcDVCuFH2YqYP5K/iXQbm/eX/ZVkwYQvUjKOWCHQslI0CDdUZBjh5VZ/NAG0R
	ME3Lm141FYy/LE9
X-Received: by 2002:a17:90b:55d0:b0:398:9bd5:490b with SMTP id 98e67ed59e1d1-3a098cdbb1fmr9655552a91.18.1790557951540;
        Sun, 27 Sep 2026 18:12:31 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0e7036e3bsm10425773a91.13.2026.09.27.18.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 18:12:31 -0700 (PDT)
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
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v4 08/22] rust: add bindings for hash.h
Date: Mon, 28 Sep 2026 11:11:09 +1000
Message-ID: <20260928011123.450800-9-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928011123.450800-1-alistair.francis@wdc.com>
References: <20260928011123.450800-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair.francis@wdc.com>

Make the functions crypto_shash_descsize(), crypto_shash_digestsize()
and crypto_free_shash() available to Rust.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 rust/bindings/bindings_helper.h |  1 +
 rust/helpers/hash.c             | 18 ++++++++++++++++++
 rust/helpers/helpers.c          |  1 +
 3 files changed, 20 insertions(+)
 create mode 100644 rust/helpers/hash.c

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 4b31aa7f432f..fd223b6c5aaf 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -30,6 +30,7 @@
 
 #include <linux/acpi.h>
 #include <linux/gpu_buddy.h>
+#include <crypto/hash.h>
 #include <drm/drm_device.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_file.h>
diff --git a/rust/helpers/hash.c b/rust/helpers/hash.c
new file mode 100644
index 000000000000..23a63618a370
--- /dev/null
+++ b/rust/helpers/hash.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <crypto/hash.h>
+
+__rust_helper unsigned int rust_helper_crypto_shash_descsize(struct crypto_shash *tfm)
+{
+	return crypto_shash_descsize(tfm);
+}
+
+__rust_helper unsigned int rust_helper_crypto_shash_digestsize(struct crypto_shash *tfm)
+{
+	return crypto_shash_digestsize(tfm);
+}
+
+__rust_helper void rust_helper_crypto_free_shash(struct crypto_shash *tfm)
+{
+	crypto_free_shash(tfm);
+}
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 440fb7638e3c..09ec69f736b1 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -66,6 +66,7 @@
 #include "fs.c"
 #include "fwctl.c"
 #include "gpu.c"
+#include "hash.c"
 #include "interrupt.c"
 #include "io.c"
 #include "irq.c"
-- 
2.55.0

