Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794284497;
	b=HCe/Zys0xo4+0/cdUlr0fTwDBNGXS6vpJN82u/1N261UdUciodc6R1zSO8PTkkHUJr1x
	 O37iHX8WuShgQt1IXStJg4cIXVqnx+EILec+VXtgUlUxSAivUMbMi30561qTldbtzS2DA
	 AZa51D9QvyLnzMgZ/ktAz2T1KECMahU5lGc9K2GnjVYnEnOgTTuRRohViNaH1Eto8eJl8
	 108JQZ5yq8xQEH2WUHXs46x6Y+8KjdPuqQsxEeBQsNCEfn/bsCj3ZjEa48yrXdpPTX+5p
	 w0iOHD9QCj06GW0iE+YuT6aHnC3hRj3TO4gJE1jfj32U27nf8M5F6H7eS+7HOeOzcUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794284497;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=odWeZv+wWSyD8twL4Iv1hdHOEwYuH8TFJO8N5Al4CP4=;
	b=kGRUX2KC+ewLYyFOrgaj9BpsfZL2/UUxcrDAtqQXlwlI6tOIODzn8QDb3wt/sWsAGJ8J
	 Z4yxUElo3i7pKaHCsVK/85vqcgxO+EjCEVPE9HOAbAmnV1Z91LwACRXZ9kB0foMIwUsdi
	 00gYEwch3MlBlUD+g1nStRVmenYx+12j/HQivowHK9I0WkLwwDNPMAcETdeo+KY1auhbm
	 VBQyXm5jRgQT1JsL6MhfBDl6kt4zScSO2iiJne0QR+9m9Q3yBnNEdx02orr04EKfrDbkx
	 hL2TLSJIXzfMKIzFjSkIJqimUbnmn6Rm3s6yiyM/xvvLApOWvDjvB+n6QDBbeLpLmlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ODjnhsD0;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41A0606E8EC
	for <linux-cxl@vger.kernel.org>; Tue, 10 Nov 2026 04:21:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D41A0606E8EC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ODjnhsD0
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1a3c08d6928so2882395c88.0
        for <linux-cxl@vger.kernel.org>; Mon, 09 Nov 2026 20:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794284496; x=1794889296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=odWeZv+wWSyD8twL4Iv1hdHOEwYuH8TFJO8N5Al4CP4=;
        b=ODjnhsD048dNFfHLskPq5QntRys8wzvlFIjv7TH7mqpEpsFUFR/jJVxoFX9ChV9U6p
         z1QzFdLcV6D60n2Hz5ArQcJdcaBahPuUUT+xuOMx7K1thINo6PDppgO4jvgt29PnVnfB
         Pvnr3Lm+Rbv0oQSEMDW5Hel1mcZn3eEqMClEfHLlt87qJwjEzMvDkkNZcaBPqax1WBwz
         tdDAj/QS//vhiYl4kRckbbpD3MScWGMghqPu/4hfNQh43IYk+TaXgQoUl/7fzD6gbkiT
         dvMlbLsUpUu1AsvtRKIxv8ORiWbEpQSxa1oK3pyXSsk+zPxn27277XY3ynLsvx2/422L
         7NkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794284496; x=1794889296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=odWeZv+wWSyD8twL4Iv1hdHOEwYuH8TFJO8N5Al4CP4=;
        b=e/X/5KL6vb5UMFUH67Pa3s9W5q6OPjs5jd9NcX4SlKbmN+88fuYeUYE68E1/nQIQeC
         x5gzu1wsZz9RvATEEVLW6SGVHfZMowzDblCo4ZAXtkB/a6FkjlOFkVCTDcAXnOvbQg6w
         H9nl1IaumRjZvA8AZI1m9A4ScgDyHdP8VJd78hs2BO+kTPMygeOj1CdeeGTdNu4qB7ZZ
         0oOhO6No8qQmRbEghdzbpMswtDAPlcDouEJJP1Gmw8coVsAlFlmIxDqL+wTQOa/KBhGQ
         AMqs5Vi5YUXGGe/47yLr/Takfehx/C8Y5EVH+AXQL3QDjV9Hkq9yWz1KNr7a/TEuhpeb
         gViQ==
X-Forwarded-Encrypted: i=1; AL+hErHKywIHO2ndk6PKF56iTQzBXhrrMv7O4pLZP5vJ49ewXHHacGvBhHvJ69X0jJkv/YZGjLopOnWApSI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/I8LaugJT9AGzLVtlod1FMMpi2LfG05AatAE/Ga/dob0usaKfI
	TsZNrsy+mSlRKwOdXDe0Sr4yE2jmTZRny/Cf2ehgWz+pBaEuhE95PvDo
X-Gm-Gg: AYBFou1nVvkNuHi/JZD/lITFrRK6ZHil1SBzzkY8dJTRL7FL83MtEcc9GacirbtNb7t
	L0nNz2LPvfUxSm+ba4svRwn123ZKKKvbdmPtBXuf+OTIgQncx6+piLHpOrK74PQ7YfzmVKG5hWY
	IYnK56aEl4Sdf6rVSZubNQzLPRRNMKS2u/1unknj3AQtMW8QP+SbZvcdy0QHlekqa/RHURUzapb
	r7XgSvTDZ2i26eSZAEfauML+gtMt8b6dclvW0phNjNyG3O7CSUGy+HRO3FDFWelQ5z1OYtHk6mJ
	rT8CUAXQwywUc+0frBfCz9GUFPwEWlZdympqa03BirrgESnmzku08vFVLZGdscjYEeXePKwpCgh
	vyPoKF8TbLY/PZ+DLe4wt8zIFhRMfX/A63m2zxfXwlsEBjyn9wGQFSM0gHaLSuzLPCj/x6btRw4
	8eGe8jRz1IBYH/h/C0CgAo19y85TEOd7Qj7WvcaDEWH+nS21mUmwb/lUnO+aSE9Oks7g5A8U9Mj
	0O3+v8rd/0m+2UBaU3OpFQeZGLhKmSbMM+RAk5cxEO+P5UBtzL+ap4Au+XLnF2qzNi2KdEqq984
	LJExr9Rs53ZtO6Zcg7VsDrGNvI95Rm/UApt7ohA8x/Xj8XA=
X-Received: by 2002:a05:7023:a5b:10b0:14d:3c0c:79e9 with SMTP id a92af1059eb24-1b3b5fda050mr2101350c88.11.1794284495718;
        Mon, 09 Nov 2026 20:21:35 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b7ba88sm3540459c88.22.2026.11.09.20.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 20:21:35 -0800 (PST)
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
Subject: [PATCH v6 20/25] rust: public_key: Add crypto public key bindings
Date: Tue, 10 Nov 2026 14:18:27 +1000
Message-ID: <20261110041832.1730924-21-alistair.francis@wdc.com>
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

Initial support for the kernel crypto public key (asymmetric-keys) bindings,
which will be used by the SPDM library.

This is just a few functions that the Rust SPDM implementation will use
in the next few commits.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 rust/bindings/bindings_helper.h |  1 +
 rust/kernel/lib.rs              |  2 +
 rust/kernel/public_key.rs       | 83 +++++++++++++++++++++++++++++++++
 3 files changed, 86 insertions(+)
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
index 0cf6eab448d08..8ad9e61d1a6fb 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -122,6 +122,8 @@
 pub mod print;
 pub mod processor;
 pub mod ptr;
+#[cfg(CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE = "y")]
+pub mod public_key;
 #[cfg(CONFIG_RUST_PWM_ABSTRACTIONS)]
 pub mod pwm;
 pub mod ratelimit;
diff --git a/rust/kernel/public_key.rs b/rust/kernel/public_key.rs
new file mode 100644
index 0000000000000..0c0d4c98bb570
--- /dev/null
+++ b/rust/kernel/public_key.rs
@@ -0,0 +1,83 @@
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
+    error::to_result, //
+};
+
+/// Owned `struct public_key` wrapper.
+pub struct PublicKey {
+    key: NonNull<bindings::public_key>,
+}
+
+impl PublicKey {
+    /// Create a Rust `PublicKey` from a valid C `struct public_key` pointer.
+    ///
+    /// # Safety
+    ///
+    /// `key` must point to a valid, exclusively-owned `struct public_key`
+    /// whose ownership is transferred to the returned `PublicKey`. The key
+    /// is freed with `public_key_free()` when the `PublicKey` is dropped,
+    /// so the caller must not free it itself or pass the same pointer to
+    /// `from_raw()` again.
+    #[inline]
+    pub unsafe fn from_raw(key: NonNull<bindings::public_key>) -> Self {
+        Self { key }
+    }
+
+    /// Verify a signature using this public key.
+    #[inline]
+    pub fn verify_signature(
+        &self,
+        signature: &[u8],
+        encoding: &'static CStr,
+        hash_algo: &'static CStr,
+        message: &[u8],
+    ) -> Result {
+        // SAFETY: `self.key` is valid per the struct invariants; its
+        // `pkey_algo` is populated by the key parser.
+        let pkey_algo = unsafe { (*self.key.as_ptr()).pkey_algo };
+
+        let sig = bindings::public_key_signature {
+            pkey_algo,
+            s: signature.as_ptr().cast_mut(),
+            s_size: u32::try_from(signature.len()).map_err(|_| EINVAL)?,
+            encoding: encoding.as_char_ptr().cast::<u8>(),
+            hash_algo: hash_algo.as_char_ptr().cast::<u8>(),
+            m: message.as_ptr().cast_mut(),
+            m_size: u32::try_from(message.len()).map_err(|_| EINVAL)?,
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

