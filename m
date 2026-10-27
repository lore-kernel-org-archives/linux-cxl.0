Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793078800;
	b=utGtbbOpxLS757K/QQmvRQ9LsEYZKWLalfDMEJdkzhPnMPLU+j0sRlXSRwvFl3RK2kW0
	 lg1GcMTVTcj30QrFXdNbaJletqpcfI7/dwr9Qko/YVioKjUoDMFZsW/99kIIUrsjTn9/p
	 UnP+Cv35JxD50NpTLV6Pr9i4VhQe+wiCcPkGmTtO+TjE3mPSfOt3QJ5/iFkRl0hfnTKqJ
	 jPiPH2y27I1E8ozyVXYA44bux7tLEThUe8UJiByNpR4kPLUE7IKh3ZEU2cx3u7lRBnaL2
	 fTBxWfRFLcH9jLcISMzwgo4eM8VOxaXi/A2FgZ8nJJ9zFGuPLnDZ/2yLNisD2wU3B4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793078800;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0x6mTxkP4nBs1deJf2I2SUu12QHLK1lhJg3onPx8YVk=;
	b=H3FCErAjquDArX9DEj+WkF+EJJ8UdsJC3CHNIluYU1d32YGdU3bFFBFAFJ8O6DREVI4N
	 yTEcU6Kwh/GwEQn0WfHndJ2DPqSx5xHf0VJEYYW4KXxZpU3JrqqYXnBbSLbI3v+JKgQtV
	 vK/iqDoxaRSFX0ROlEw5QyN/D4KzHSUUuF209zZYoQ1jLJWuVgGROuQIx5D7DY6DaCoC6
	 Bp/yBsvme6nLL5gxK/9hVHr3g76v8ewbuFgK3KHxquiHU6+bH/vanQMvhzM2i2xKuytdT
	 pK880agGXzc4bl+FtFShTSzc3IOtiBEtjjMg+brUGIDurUjUPW8j88wyKKDHiG5XzNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="Ghwts+3/";
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD99F606A31D
	for <linux-cxl@vger.kernel.org>; Tue, 27 Oct 2026 05:26:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD99F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ghwts+3/
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e9ae391a05so4124565ad.1
        for <linux-cxl@vger.kernel.org>; Mon, 26 Oct 2026 22:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793078799; x=1793683599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0x6mTxkP4nBs1deJf2I2SUu12QHLK1lhJg3onPx8YVk=;
        b=Ghwts+3/hrGnnAzwWpysKTB0hd2asbwn/FondnpQC/sUw0xIjOVjhFF0wm2h4+l9gp
         sPRtbxsmY/EyoJkhZl1vLxdsnp0D8G0TMs2AFYXw5ecowDoGCO5LphDoFPKGwGrNq103
         pFBFIoKYQgOQy7lbkYEPy3zS+4TzoeMU9Y1KKn/yro9QDnvolQV2aJQ6W5gexYqglT2o
         58tX26UzbtduhhMjUBofOx/nRAOsSCtFyMhOk/m47o1Ddgb9e7JgJuck3DDpNs+311iD
         uITJl0bAiZRyUun61ZziSK9euut3tVMF52n2IITtzTEV5lIHjff16P2x13v775iQxx3p
         OcLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793078799; x=1793683599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0x6mTxkP4nBs1deJf2I2SUu12QHLK1lhJg3onPx8YVk=;
        b=lkh5y32baxf3vTQ4kQHCT9b3WwRBLcL1r5/IuZIgGx28q304Hz0kVWcLIc/CEF7Z9h
         UPR9bx1o8qrOi8QQiLledRaUm+IyJET3vrFyYp8NXK3h+p/cCVg88j0eAQc+tU9MU+kX
         vHxGDE7vMBiKBo+7kYRX9g6hp1NVKZzArKR299X+ZYKlaOQG1uFp1qySPH7bU0z3aDpD
         PoYFAwurTfgd8wufcWNESWNslVJU+0EZK37s9sSKGzccqNbikpkhrTK5Xpdx6m1glcmm
         S/5xJTDvOJpPzsnob67ANBtFWjAIZ9rU1H+QRdudQuzfNEul4XngFSY0Yy4iu80xRave
         VagA==
X-Forwarded-Encrypted: i=1; AKwUvBxKPAbILb7+WWncetSR1W9YthYH2Z2UMvf9/KEzLwd58wAmsrlkNrvpn9gYYfjgRxzPiAa35Ppcu0g=@vger.kernel.org
X-Gm-Message-State: AFq9FYIn6QGFx5I+G4xo2v99nugdxkCcJgj7AOMVRe1zT+cOV93lODBE
	o7fHjagYrfbkt+MAGKPvm9VcIs47PJ1tiTXRAzRyWlq9CM5O+R7wpzUX
X-Gm-Gg: AYBFou1OwHmq3jfyk0CfkyJeFD6qmYRHmvNSR3dz+VxGUdZR7E8bZ4PvRcUFnUAHJo6
	/2oYOqkIXatmre+TQc4/p7LBIyA/18FsyLxqoISLSAzzd+aEcla5s/uTTr6GiNjjxG+n8JErR1k
	z458qiTJL+zmq8ShMINFbvisQvIjqq30ZnxXvsyDa28FMenY9lPL83mEBB3xORNYwRkwbOYWW5d
	73Dy6d8gODM0Y7iiJTPRU6FV1r8VOYKcFuvuep8Bak661Ur71JnJxFUu7De236eay2DI4AmIKJj
	9+EMfPmJO2Sc8Ybgpa0aPYbf/MSuv8a3+NYoJ6zblLeS3UeT9ggJ7eAINyJOmwtk6f58Uwlioxl
	qt3Z2ZpUINiea5/lTFRDtEs3UZzJjFBdQagbq/oyAXQ7uH3BtbdW+tbGhQwx+j3QGzXL9YlgpUY
	ceTuIkuN9K+xv1RFsD2MlFODYSWPUKFW9LDCxzEKZUlAER50q8k2R++2Z+sNpoeoBJ8uWF6mEql
	s2IB+hDGOAUDZLG9P7qKje4PlHSmYE+u0FP6fND3qq/HkzjIIKG7Bgh5yhIPDWTEzs361JuKxN1
	yGjLTeODNJRfiCrj7tw=
X-Received: by 2002:a17:902:e946:b0:2ea:dee6:d672 with SMTP id d9443c01a7336-2eae3ed93b0mr9549575ad.19.1793078799174;
        Mon, 26 Oct 2026 22:26:39 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6c9757bsm3307715ad.58.2026.10.26.22.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 22:26:38 -0700 (PDT)
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
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v5 07/23] rust: add bindings for hash.h
Date: Tue, 27 Oct 2026 15:25:20 +1000
Message-ID: <20261027052536.1722081-8-alistair.francis@wdc.com>
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
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair.francis@wdc.com>

Make the functions crypto_shash_descsize(), crypto_shash_digestsize()
and crypto_free_shash() available to Rust.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 rust/bindings/bindings_helper.h |  1 +
 rust/helpers/hash.c             | 22 ++++++++++++++++++++++
 rust/helpers/helpers.c          |  1 +
 3 files changed, 24 insertions(+)
 create mode 100644 rust/helpers/hash.c

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 3791af0aadc73..4992bc3194e7e 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -28,6 +28,7 @@
  */
 #include <linux/hrtimer_types.h>
 
+#include <crypto/hash.h>
 #include <linux/acpi.h>
 #include <linux/gpu_buddy.h>
 #include <drm/drm_device.h>
diff --git a/rust/helpers/hash.c b/rust/helpers/hash.c
new file mode 100644
index 0000000000000..0d88752084673
--- /dev/null
+++ b/rust/helpers/hash.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <crypto/hash.h>
+
+#ifdef CONFIG_CRYPTO
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
+
+#endif /* CONFIG_CRYPTO */
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index d62c7be1ca7bd..0dcdad905f0ef 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -67,6 +67,7 @@
 #include "fs.c"
 #include "fwctl.c"
 #include "gpu.c"
+#include "hash.c"
 #include "interrupt.c"
 #include "io.c"
 #include "irq.c"
-- 
2.56.0

