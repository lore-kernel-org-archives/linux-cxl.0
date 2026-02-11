Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3179344D9D
	for <linux-cxl@vger.kernel.org>; Wed, 11 Feb 2026 03:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770780632; cv=none; b=ppsUhUxB00RNppUL1plM/UeD9zY9xEiuTd/zXyhm6UqfLqcVXclbfwx6hCz3K/Wprj3nOPTfSnpAAYSIQje9aBkSm8M/pLd6XKZ+8qoqKqjoo5frp/RqZcFw3446/qxId3RhZKNkj9xWVRKD32LraHt/f3woggrhBhxIdCeh4d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770780632; c=relaxed/simple;
	bh=3KwgssT0qLSW0xBZrdG5K1brZw1i/pcHLAEb0PzMGv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bb8JsDsVeZ0C8bPjPM1ce97kUxVs2GS9DKHD8KTRxLQXHVVtb6Oebyr/7Q36SULenexz94D24nSzcP2sM0TrSPr8GVgy7dq6rK6hZtsQtXgIPpnwBK4sQMY374j82VxDkgu16Fhmv2vMjsHuuAoGF/83EqCFgkGHN+6Rrx8I7Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YquY9jk2; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YquY9jk2"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-824a2888de5so5866b3a.0
        for <linux-cxl@vger.kernel.org>; Tue, 10 Feb 2026 19:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770780630; x=1771385430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dg944eAYwPSQ7NjEWDDm+/KZG6xsl7b2l82fMEgSYcM=;
        b=YquY9jk2WfObP4B0UhrgKBsE5Xsdah95vDEj1c2QbseqZ5rmtp9Ay3OW1mcYUA7Hdw
         rjuskHzsqqCMLdDfMfYkkvT2ZxlTNfrLxie5R/ojvaeJrZ9IlME0s2peFAP79tBFIsQV
         MxxdnLJeDeU/D3CbQZDj3j0/9kHX1T4zGIx7otee6HZCiKaTBK0v/dszkhL1fuqxs/CX
         AxwzoHFnwj/0ib8X+DUFAKXzQSLEWNCFAUZwdSQYlySC4S7vIvjJUnypBnqAX/wMXNDL
         dd4WcAW1Bj9tufjzt5k1JSZ2CuFOCbAvxCp+5TwqbyZ/kUpXs3vY1Q2VqvNZ5tzeRy2T
         4N4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770780630; x=1771385430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dg944eAYwPSQ7NjEWDDm+/KZG6xsl7b2l82fMEgSYcM=;
        b=HZksyJnOvYrolXzVjv2K/kDNcocWuXrKOPYHN+ylEkdWqYNlyQtezPvIo7T0bdCZvj
         DgKLPzIjIOrUYBdYiwf4lvO8GykEMri3louhR/10mGA8dp5A02tA2y3k+pq7dfLdeZ9e
         P+wnAa67yDfMJF4q4+De74wR1dQZj8eTBdjJb4oAcr9Bhkl2BJENOIscQpW3RnRtnrJJ
         afDe2VkuX8KGof5YTcspj9JfHlRvPTg1gfa5srXHh9HC4S3xYzmiDo8S/v9OZrG5ImJl
         nDSoDFXi9+82siUMToBBOfj7BOjjjqJFJY1jDR60x0fSPNVQWA7wUrAVcVoX4P47bvXS
         4EtA==
X-Forwarded-Encrypted: i=1; AJvYcCVS2rjfE7ZX5bgsGEbglXqn0r1R8yjOvaIesVLNFi/2Z8gj7YIMGBz7HyXb2yummVO4KZabFZyBJVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEc3DIk8zFjcY1S/cyMw472GrYQtrJvKEi4xhWtVgycDspYnqb
	S9JeD8sDEaNeP+71GYu9zomLwbCoBbCvDuer9Zt7P9fwvmdstmkriQlk
X-Gm-Gg: AZuq6aJkPUMXR1HXOC6RMfWNysJ9oB/arW5lxtWJLSvsY1HNUpGSBQ6yWrMErvvmO5k
	qYIC5alVFkEB8zQQK27UQ1y0ByCoPDDsnPoSoawbY766SkjKqQy9Aqe4Er1gXaWdVlQF+jckH67
	WqicbzlhLmssWXpOSeXWcWFJvegV0cDz7fzpTDUMnL9vkluDCZAh8GIcJ/EYxX5u84egQ7iY6d9
	qRvtCMwlX+cUD8PxFRSwrFwdgQytpZzjxY3Z0c6x9hHSEVlB2hEYGbjNGCnxoyrrTLHR+eTeE+J
	lJJ7qpMbQpWUOeGXiln/0AMdkt3PlUocZGMM4pytZ/WqkAtMXaAIlLoIk0hAvyV/ZQtHAUjiR73
	YCRJg9hIGYfF8B/F3G2DghGB3VvqzstCNv0pRo7VwfP1WAmcHPl1QmFiCwN7ZF70l5miuARwIvM
	Z8+EHFe2D0TqRDuCWelbSwInhUnzCuFSQcs36TgiHSkw==
X-Received: by 2002:a05:6a21:e58b:b0:375:4503:ef0e with SMTP id adf61e73a8af0-3941556bee6mr4592807637.14.1770780629942;
        Tue, 10 Feb 2026 19:30:29 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e197d63c9sm464856a12.20.2026.02.10.19.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 19:30:29 -0800 (PST)
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
Subject: [RFC v3 06/27] rust: add bindings for hash.h
Date: Wed, 11 Feb 2026 13:29:13 +1000
Message-ID: <20260211032935.2705841-7-alistair.francis@wdc.com>
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

Make the functions crypto_shash_descsize(), crypto_shash_digestsize()
and crypto_free_shash() available to Rust.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 rust/bindings/bindings_helper.h |  2 ++
 rust/helpers/hash.c             | 18 ++++++++++++++++++
 rust/helpers/helpers.c          |  1 +
 3 files changed, 21 insertions(+)
 create mode 100644 rust/helpers/hash.c

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index a067038b4b42..0075c4b62c29 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -34,6 +34,7 @@
 #include <drm/drm_file.h>
 #include <drm/drm_gem.h>
 #include <drm/drm_ioctl.h>
+#include <crypto/hash.h>
 #include <kunit/test.h>
 #include <linux/auxiliary_bus.h>
 #include <linux/bitmap.h>
@@ -60,6 +61,7 @@
 #include <linux/fs.h>
 #include <linux/i2c.h>
 #include <linux/ioport.h>
+#include <linux/hash.h>
 #include <linux/jiffies.h>
 #include <linux/jump_label.h>
 #include <linux/mdio.h>
diff --git a/rust/helpers/hash.c b/rust/helpers/hash.c
new file mode 100644
index 000000000000..8ddb84668841
--- /dev/null
+++ b/rust/helpers/hash.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <crypto/hash.h>
+
+unsigned int rust_helper_crypto_shash_descsize(struct crypto_shash *tfm)
+{
+	return crypto_shash_descsize(tfm);
+}
+
+unsigned int rust_helper_crypto_shash_digestsize(struct crypto_shash *tfm)
+{
+	return crypto_shash_digestsize(tfm);
+}
+
+void rust_helper_crypto_free_shash(struct crypto_shash *tfm)
+{
+	crypto_free_shash(tfm);
+}
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index a3c42e51f00a..4b08b4f1d3a3 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -30,6 +30,7 @@
 #include "dma.c"
 #include "drm.c"
 #include "err.c"
+#include "hash.c"
 #include "irq.c"
 #include "fs.c"
 #include "io.c"
-- 
2.52.0

