Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793078904;
	b=pMxTFgY7b8cCfKLj57Av3DMNbifSx3sWYFVKQNrlozEtjTJ6NHzs6hoe2hFROo2inohF
	 qJhcscd9h5oz7b3XdmLWks2hTh6jJlnXUmM/cW0hVkHgm9EFKL6QBL/I2xkV02eYcQlFO
	 6jFUR8fQEWEgYnzMDqOyFzNKS0p02a7QyZ9ro7Cm1sgFsz38mfYGueSPQvIPOfP/T292S
	 cBTicdJzkVuQ0muaGlOJSlgI4otgM3pDoyyxv1ruy2/X1Pgq1H9ocK5f73Zmaq7ED6QRo
	 DxbWBlilxOsEJ5yfGppe94Emg/gkiD04HCkxLB0hs2DEVmGGXJJvrkFEGZOu2wfTEow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793078904;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=3hMKyPaWEskOkBv5OG5DqLWYBk+n+YndVnXQUQRhXr4=;
	b=3z2NvylxYW0ULKEFkyAz8s5X5yEeoPyItNYO0Odlp9BEKKIJHKjVUf3Wdd7U5ch6JhV1
	 R8rKbGUU35OdCBqe2ZXfsm9eiOAxhPgUgFjfJhi/1Ayva+YayBO00EuxOF6zrHJ88gMgR
	 anrHjLhFMbVQlpaBluFebj5vFdi7ewEmnl5K4c5XO3UkVWXqbCcFpMpyCpR/vdPehOF9r
	 Y7OTPXSAJfpEqBU1ZB5xsE4LTsXWWWeqyxYggc1hXNrYvCeJ+xtt+2ywoZBRbxLp6QboG
	 49+Kn2sTHNHALfw/B2KqkZKOosj1kHxOxoLutDFgpzn+iwEJOgJ89orVL1qPs9GCj3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="YmQ/doa3";
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C554606A324
	for <linux-cxl@vger.kernel.org>; Tue, 27 Oct 2026 05:28:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C554606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YmQ/doa3
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e9cf928dc9so2593325ad.0
        for <linux-cxl@vger.kernel.org>; Mon, 26 Oct 2026 22:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793078904; x=1793683704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3hMKyPaWEskOkBv5OG5DqLWYBk+n+YndVnXQUQRhXr4=;
        b=YmQ/doa3Tp9ADiNWK9TKhBal34RqpzT+ddGpWNx00MH8fgCJWAnWAV/NTFOkEgLo3n
         kU1EkuRLZtCaYK8MxHf/5EJ+Bn0740V11yy7Zph3QgLB33pXnppAeRzg2Fjoo5ScN1lc
         AHTIhuBI98zFCVN00yliB3O2sJ0/lyagaM0DbMx3xSVFC+Y3eRg42ZnYGqnx92to6k4P
         1sh7N9tAPLGJr1iwOxe+CkBsEbW9f9X7Fo3ZNY97TR4ZUliEGLy15OlmnzS4JqW5Zh4J
         8gJz/G/CNd8RJz9VpfeMHyo199bp1EWPxOIH292Q8qJ456+HTdb1NXTqtt+St2MV2Wov
         iQWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793078904; x=1793683704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3hMKyPaWEskOkBv5OG5DqLWYBk+n+YndVnXQUQRhXr4=;
        b=NlBoetf25l1A57zAFSNS8MQSQzMUYTbRZcMVBzu7kjlgamMVed7JqapEu4zAB8nNxH
         9X+fNYsi236pQYvUeVgVv24NLDmy99PXRhgzM4eoWSTRiuJ3LPdnIR9B9/2MmDZb1kOd
         V6CBwIev8ty74pEiW53PMZ31rXqPIW+lCG/WYdnyq0+8LRC3m7zN3k1mMvrkg2R0tDJP
         gcdOrv1bNgOQpgqgjAlC2SBi0sY4sA+KtEOR0aIIOdv+O09aoT4v36dzxjVTiETyBq6K
         Bz5qZ5MboF93TqWLJrEM143WZBw3I3ig5xm2ZuFkDuERaRJEryQ4CW6TsSisAS5jWB/O
         unog==
X-Forwarded-Encrypted: i=1; AKwUvBxvwSKhYQ8H5KKVJ8bxymJFWYrjtqkK/yD8rh12OHa5FyiBr6alMNsSi2jU+MggshgrUUtvd3baSe8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIhBZBvuN7geUaMOQF7JMKmWswsyOmCwVbQLKA+evLX74ekbuyj
	7hu/KZiKk1ODMvhwkaUrqpxHLAIPehqG8zMc1m0jmK437TfA667s5iln
X-Gm-Gg: AYBFou3J5vWOftjsI2kokJ4k79Yff4pTXDWC9nEYcxZPyHawTtbVAXgc8FdtcvpXCI7
	HBJxNEV7c+6uzh2Ckz3N22P8aBcZ9tas67TXbfZ0O+uyEZPyaSxALJsfOmJbL0kfvORw9OxuPmK
	hHl8DI8ntEFBE23pMYbOglvI9HdypGI13+GsoHHrUMUKb70gB5Fs3qn84os7J9FDi9s0gmQt8RT
	JFdiw7iHPd5SoQa7ckuIQsLEZQjzxO6BR4sxhIljQbixCDxWkDkIXySAnb2a4LiK9puhUhQApt8
	42NcIHU+ud9urZoXu2MPtr+Zbxkk9QRge1IQWyAtY1SB7d/G12HAU8xpQN2EQcye9Cyj5zuC0sm
	oqqpfz9HXWc/ngOB1ECNsYAVRQ/CxfLADIVuZFU8zXiAx2bE3SoN6QkBbfvATCl2MxD325pckfo
	rB0TQ/gTAXX7UVX5tPH/ZquMffHSRS6C4gvVH124jNQxPQaxgOvoTinZZI64+mh1jmsTDVHJOlK
	8q8rQPmSyJc+kl7Q2iHf/dsI5btrOIRaUckXlBTtOARfpVvSjfEcVpZD58EiI63Yk7wIOXuOw==
X-Received: by 2002:a17:903:2ecd:b0:2e9:3a86:b995 with SMTP id d9443c01a7336-2eae39fdae1mr11913125ad.15.1793078903879;
        Mon, 26 Oct 2026 22:28:23 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6c9757bsm3307715ad.58.2026.10.26.22.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 22:28:22 -0700 (PDT)
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
Subject: [PATCH v5 20/23] rust: public_key: Add crypto public key bindings
Date: Tue, 27 Oct 2026 15:25:33 +1000
Message-ID: <20261027052536.1722081-21-alistair.francis@wdc.com>
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

Initial support for the kernel crypto public key (asymmetric-keys) bindings,
which will be used by the SPDM library.

This is just a few functions that the Rust SPDM implementation will use
in the next few commits.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 rust/bindings/bindings_helper.h |  1 +
 rust/kernel/lib.rs              |  2 +
 rust/kernel/public_key.rs       | 69 +++++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+)
 create mode 100644 rust/kernel/public_key.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index a2512fda77e1f..da8855899c530 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -29,6 +29,7 @@
 #include <linux/hrtimer_types.h>
 
 #include <crypto/hash.h>
+#include <crypto/public_key.h>
 #include <linux/acpi.h>
 #include <linux/gpu_buddy.h>
 #include <drm/drm_device.h>
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index f7db5975e7621..e8b652faa3b49 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -122,6 +122,8 @@
 pub mod print;
 pub mod processor;
 pub mod ptr;
+#[cfg(CONFIG_CRYPTO)]
+pub mod public_key;
 #[cfg(CONFIG_RUST_PWM_ABSTRACTIONS)]
 pub mod pwm;
 pub mod ratelimit;
diff --git a/rust/kernel/public_key.rs b/rust/kernel/public_key.rs
new file mode 100644
index 0000000000000..e1d51333c1179
--- /dev/null
+++ b/rust/kernel/public_key.rs
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2026 Western Digital
+
+//! Wrappers around the Linux kernel crypto public key APIs.
+//!
+//! C headers: [`include/crypto/public_key.h`](srctree/include/crypto/public_key.h).
+//!
+//! Reference: <https://www.kernel.org/doc/html/latest/crypto/asymmetric-keys.html>
+
+use core::ptr::NonNull;
+use kernel::prelude::*;
+use kernel::{
+    bindings,
+    error::to_result,
+    str::CStr, //
+};
+
+/// Owned `struct public_key` wrapper.
+pub struct PublicKey {
+    key: NonNull<bindings::public_key>,
+}
+
+impl PublicKey {
+    /// Create a Rust `PublicKey` from a valid C `struct public_key` pointer.
+    pub fn from_raw(key: NonNull<bindings::public_key>) -> Self {
+        Self { key }
+    }
+
+    /// Verify a signature using this public key.
+    pub fn verify_signature(
+        &self,
+        signature: &[u8],
+        encoding: &'static CStr,
+        hash_algo: &'static CStr,
+        message: &[u8],
+    ) -> Result {
+        let sig = bindings::public_key_signature {
+            s: signature.as_ptr().cast_mut(),
+            s_size: signature.len() as u32,
+            encoding: encoding.as_char_ptr().cast::<u8>(),
+            hash_algo: hash_algo.as_char_ptr().cast::<u8>(),
+            m: message.as_ptr().cast_mut(),
+            m_size: message.len() as u32,
+            ..Default::default()
+        };
+
+        // SAFETY: `self.key` is a valid public key handle, and `sig` points to
+        // valid signature/message data owned by the caller for the duration of
+        // this call.
+        unsafe {
+            to_result(bindings::public_key_verify_signature(
+                self.key.as_ptr(),
+                &sig,
+            ))
+        }
+    }
+}
+
+impl Drop for PublicKey {
+    fn drop(&mut self) {
+        // SAFETY: `self.key` was either returned by `x509_cert_parse()` or
+        // manually transferred from an `x509_certificate` and has not been
+        // freed yet.
+        unsafe {
+            bindings::public_key_free(self.key.as_ptr());
+        }
+    }
+}
-- 
2.56.0

