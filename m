Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AB2395ACE
	for <linux-cxl@vger.kernel.org>; Tue,  1 Sep 2026 01:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788224704; cv=none; b=B80pAf6s/YW334fXCvQC5LuDjIY8hkCkA5je/A/dY3ATPnLqPWGrk3iBPe2eNDt0rSf/Q3m6pxeJ7r1YaU4u7v/P3Y+1unq3CYIQHILCWnnH6o6vHt3q2lm9FTexhJTtBo2/MbECUVJEtuDdVbv7cpnkl35DK4Fkmi5tWxF0IEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788224704; c=relaxed/simple;
	bh=7H9GI30AsWmAlTdg30uohie4gLRcANCA6UmHmEupp3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZuKOD50K3h0RPXxCuOURQmwb48w4lNo/ffGQj8xnryETEaRSB4JwIY0pKxtmPaHa7U4Lkyk16FsRrCNmU9DPYNcEcBdgCPFxdlnntyMsktAbZFm5p8alCGqFNLLP7J8cu6rHUuav57PejxX9+dSVr+UB8dkKYmLSM9v7v8QXhsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+YQ2TYC; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+YQ2TYC"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c96c92c0980so257588a12.3
        for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 18:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788224702; x=1788829502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jWbFM6ywa1yjj692OE0MrLQnEnm7JyCgqunSYul2orw=;
        b=d+YQ2TYCuKChwoPQfL5IsXw8KZDWudgQ5nl55KRLhDWcU/gJC7uZKUR3Rsa/hvrFIu
         1zjw7xN2aiWcDdflQlzlDhDMg77O2eY3YssOVRaf2XiZtm5rediRfOrjYTmzSJdEpWTP
         Etuy2TgNIKbTKKGOWNpne0L+sq8ENRQYtdnHtwvhCBmxZg6KB9F4g4A7X1n4M+PJpz9Y
         ILDCryRfLkRlNnRi8i7BYNjxR/d4/TkjfRKcXgwPLCXMbRaU/8yJHZzS4/uOnjuup5va
         Ww4MNUHPwhYNpt1U3+/xZ5Ou4r0FnLhO2m7lDhhLye1J9nQ4GWB69Gk2gc+HtyXqHFD8
         uxhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788224702; x=1788829502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jWbFM6ywa1yjj692OE0MrLQnEnm7JyCgqunSYul2orw=;
        b=luwX021tpuzOOdq/xMxXesAw++i3x4+bsYIvDlXLDWuHF4jop1TrLBK8FfBkodafbd
         9otHTEPJKase0+BdVh5iYKwX4fscoG1sEZ55ZBFPjU0llc7IXBuhjKXY3OS3ERgAbaEu
         B7v8t+d0L/bhuCh4824JvVc6RbMSPoOljzCA1F+GdKFMaQSJ7YGE3iIVu/vhlw/afKWX
         k1ePruZ+Zp39w/yWeN3KQH6k2NtarF6g6TkQ0aL8Y3HCVZZg2aUtJFZ4KXXysZ//520S
         eONQlEvA14LLJC/xizHGGafwOKdniSAtA3AGMjMhDTFWOps6znuAz9xANPSpcGiAJcqs
         xRhg==
X-Forwarded-Encrypted: i=1; AKwUvBxrRO4aab9qxfixAtcHI4wpJvGW1En1+eaUr7sHOW6dE2xsVcYJLcVodB0p/dhVoXWVpjjZu0RNgo4=@vger.kernel.org
X-Gm-Message-State: AFuF++kq9+PxwCJs5OBc120Sftb/qb7C7FgEyqB0LTXz6G/vYN94sIDo
	sg4JRERoabcgAnohDhHG2TMbu1Qogz4n8Lg2NxbEFuGuwds9LhMnPFY+
X-Gm-Gg: AYBFou08J20AaA+EripwALX4v+devSCsowgRBWKm4DWQeSyV5JphHuDAh2EemJ9vgRi
	tgXvxQ3hTrkewCx4woNu6xZJggW+tnYiEUkgRYaZisokQYGJc16MSP8UD8z6yloQojU8FHZ+rlN
	OSMVztPcxSm5+nmF0kOqzZKikFLuaKk27a0uD/2N2NUNcoBFkCWQGTeCxqgutpdYBQJoDjB5XYU
	dVIJSnSPK+eHlKI2eNsrZW5Cs3eRtw0LN0p6KCSUn49uOJhY5dPREo17unC4TicSpxoYAPsu4es
	j7fDrZPj9fJE4toLiIaV6AyT5mThO6BScYV3VVekD1LrlDVsZL0TNtV4dlPbeeXbld2J7LuZZL1
	lBzWe7Kohk1ajPxQmSvzJP8l+kh5Gidx6oCuf4HVi3FdbAYgyWydZqTM1Ksrmq7L1R0cjtt2+eD
	IU9QiV5TYn1vlhaEEklkhDXJTKDu7wKQeCXm2yoavTSP0jDeRPNpP5ZtwAO1Ts0gRwQ+m1bf/8J
	ugMUg==
X-Received: by 2002:a17:90b:164b:b0:38e:6a44:671b with SMTP id 98e67ed59e1d1-396d0c79e8amr44052502a91.0.1788224702403;
        Mon, 31 Aug 2026 18:05:02 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990d49e9e0sm2372024a91.11.2026.08.31.18.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 18:05:01 -0700 (PDT)
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
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 07/21] rust: add bindings for hash.h
Date: Tue,  1 Sep 2026 11:03:33 +1000
Message-ID: <20260901010347.2614656-8-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901010347.2614656-1-alistair.francis@wdc.com>
References: <20260901010347.2614656-1-alistair.francis@wdc.com>
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

