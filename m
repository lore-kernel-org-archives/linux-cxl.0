Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E8A3624A9
	for <linux-cxl@vger.kernel.org>; Mon, 28 Sep 2026 01:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790559104; cv=none; b=Nc7SMiQ3YnB3TBwNTmK9Hx+PYQ3gCERCGu+bBch9SdArzb1mr5chf3jOYGZEljadzEyDkWrkwE/4zE9OXlLSfnpk/9+Y7PfubGeKtw8fO811xKDjJl+2a34QfhBP21zPacPltE1LBORzM4obutXoARFA1Sl1e0TAuuWKL54mM6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790559104; c=relaxed/simple;
	bh=dYwkjAg9+owsT1rlev5yvf7o5Iv/qhN5PaHBspFONRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CAkyB2eI3b4E4snNj21ZGRzLa3gU5m2RlBE+f+FQsTFYB3ylDvk7T99pHvbHzcbMcEocrpbq+maTyOat4OMRM7APRu8AugiczrnuK/lL3RmMhz5wwIybNfWZi67XAz1foXjakbg0U07Ra0IpCE38OwHY06pCWpPur+bIzcos9i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ch5S8KcJ; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ch5S8KcJ"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccb1a98dso1429819a91.0
        for <linux-cxl@vger.kernel.org>; Sun, 27 Sep 2026 18:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790559101; x=1791163901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1BTUtz+ZG/2ayv7b8VSD8LMcB/N3Z789fLpe/5tgLu8=;
        b=Ch5S8KcJaTBnzPmAYFD6GVPOpyCuPPxfcFnRJEUhV4w9lRvrn8UHhSZ9I7WpXDe55y
         9o+aLLYg32bSS7WBXnC2JdKp6WFtwjlzhlmPsStJoyhI+6Uxc57Am0i7obNu0QP+NOsp
         y6Gqc8xIOWokmFuwocKKs65YoDh6ZTgXJUBMDdoXJIkKzg20Abu7vX+Ek5kQsy42qUrQ
         L7KBbTIlvmQArYUhLyXMVT2hW2WTxOIYUqmrA9TycV+3Sg0FLVL4uIOnR26ohvpN8qXr
         mXw03Q6rcYcbKVs3S55MwjBC3ZlhVljwJqhmUngNkCq0B/PJ5eVzKFHeqJWMBYC0F4iR
         Fw3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790559101; x=1791163901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1BTUtz+ZG/2ayv7b8VSD8LMcB/N3Z789fLpe/5tgLu8=;
        b=j3fc4xB7ZP24kdKUZdobG0CJCGwLB5ZuhHCNPfhaqyg6ilqs5s2Vy6113t7prJI33s
         /HMG5pnrzQdh8x1OB+2NL1M3liVkBrTBHpC3zR9LyCaVRunkFzAIQytebLFkkRFxe9it
         ZVsdSU9p4OOhiLjDGom52Zh87RMM/aS6LerqmJSg5o99Z5sWUYQNRR5hhkr+VYakVrsg
         LONO/P8GwKzw9Km5f9Hcq6nzqnTjI3cSiV0sgK8I0hvLwVcU7IdIq/MW40RkLtCm3nsq
         snriG+WblNGrkOW+2Un36kHQU8f+7fomIDzYlVhHOPKWtlqUP8jMOz/BqF1aeNsEsAB2
         8mRQ==
X-Forwarded-Encrypted: i=1; AKwUvBxbSXBx0nq37kT9XaQc562I3l0rtdBFd8bSf5VQCp4CcsZnOcs4BD4FJvFAZd6es3Tt475sfcH0Y0k=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ1lk2Ihvf/NR+HYQnASg77ApNSWu6LhVd61hsANsPwjEpv9Zjc
	M39W8GqtqTWdCa36uZJ8UvllvhE+083KdZ6uONLR1rWTrBSHzOHPBitY
X-Gm-Gg: AYBFou0TJ7HK1vxsxr8c28NdiQMjjkRlWb+2hYNXTXrfhawnQBi8Lc3PPsNXNSlmVyu
	Wpa1uRY546iE8seG9sbXj8Ms0pb5Gkbm1BYdlJXkoRvJZu1AfsvW3nyZXSwlgHbOxNKkVpT2bJ4
	Qg1ZD4tR8SyB/ga5hDsyJCkm5MM2p+nsoMD4sXqd80qyDkLMCugDPfNIT+s7sBr9rM2uVjAG1qv
	pRK36yt6vJ3A2wb3U+GEbTWeQMlTziPnlexC5NF7U1sfhdukiBGaVMqLXtwod7+uV1h/djLdI+X
	IAAxieBPMkwCSFJwj06Nm6NOuYyAiiN6Y1DsBP8MCHypEhungWTMTjuaejYoVXLMaLECpyVaweh
	BF18dsH+ld33OuicAq0n0sv+Ya2QoTHAXEkVqMI94z2BuDkGpLyTSAbhiLTFbKv2MndIoA6G3dV
	YXVdg8eLMrX3uL1679clnxiLRnoepNuOI+Hgnu8AHsWxNf58676YHC/57BHfQ2ynvSRI1/oNOFW
	O9efdjj/EBVwHwkKcH8As8WVz4=
X-Received: by 2002:a17:90b:4d91:b0:39e:6a80:b799 with SMTP id 98e67ed59e1d1-3a0bb60e3a4mr6742393a91.41.1790559101350;
        Sun, 27 Sep 2026 18:31:41 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0c719f86fsm14951084a91.7.2026.09.27.18.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 18:31:40 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: djbw@kernel.org,
	linux-pci@vger.kernel.org,
	bhelgaas@google.com,
	linux-kernel@vger.kernel.org,
	Jonathan.Cameron@huawei.com,
	rust-for-linux@vger.kernel.org,
	lukas@wunner.de,
	akpm@linux-foundation.org,
	jic23@kernel.org,
	alistair@alistair23.me,
	linux-cxl@vger.kernel.org
Cc: aliceryhl@google.com,
	gregkh@linuxfoundation.org,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	boqun.feng@gmail.com,
	ojeda@kernel.org,
	alistair23@gmail.com,
	bjorn3_gh@protonmail.com,
	gary@garyguo.net,
	tmgross@umich.edu,
	wilfred.mallawa@wdc.com,
	alex.gaynor@gmail.com
Subject: [PATCH v4 20/22] lib: rspdm: Support SPDM certificate validation
Date: Mon, 28 Sep 2026 11:31:21 +1000
Message-ID: <20260928013123.566184-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928013123.566184-1-alistair.francis@wdc.com>
References: <20260928011123.450800-1-alistair.francis@wdc.com>
 <20260928013123.566184-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair@alistair23.me>

Support validating the SPDM certificate chain. This only performs basic
sanity checks on the chain before we continue on. This does not ensure
that the root CA is trusted, we leave that for userspace to check and
enforce. Instead we just make sure that the chain is correct, uses
supported signatures and that it isn't blacklisted in the kernel.

We then store the first leaf certificate for use later.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 lib/rspdm/lib.rs                |  12 +++
 lib/rspdm/state.rs              | 147 +++++++++++++++++++++++++++++++-
 rust/bindings/bindings_helper.h |   2 +
 3 files changed, 160 insertions(+), 1 deletion(-)

diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
index ee17f4818aeb..50ff92741086 100644
--- a/lib/rspdm/lib.rs
+++ b/lib/rspdm/lib.rs
@@ -124,6 +124,18 @@ pub extern "C" fn spdm_authenticate(state_ptr: *mut spdm_state) -> c_int {
         provisioned_slots &= !(1 << slot);
     }
 
+    let mut provisioned_slots = state.provisioned_slots;
+    while (provisioned_slots as usize) > 0 {
+        let slot = provisioned_slots.trailing_zeros() as u8;
+
+        if let Err(e) = state.validate_cert_chain(slot) {
+            pr_err!("Certificate in slot {slot} failed to verify: {e:?}\n");
+            return e.to_errno() as c_int;
+        }
+
+        provisioned_slots &= !(1 << slot);
+    }
+
     -(EPROTONOSUPPORT as i32)
 }
 
diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
index 780b9d459abf..9f7f6d0ffac6 100644
--- a/lib/rspdm/state.rs
+++ b/lib/rspdm/state.rs
@@ -117,7 +117,8 @@
 ///  H in SPDM specification.
 /// @certs: Certificate chain in each of the 8 slots. Empty KVec if a slot is
 ///  not populated. Prefixed by the 4 + H header per SPDM 1.0.0 table 15.
-#[expect(dead_code)]
+/// @leaf_key: Public key portion of leaf certificate against which to check
+///  responder's signatures.
 pub(crate) struct SpdmState<'a> {
     pub(crate) dev: *mut bindings::device,
     pub(crate) transport: bindings::spdm_transport,
@@ -146,10 +147,20 @@ pub(crate) struct SpdmState<'a> {
 
     // Certificates
     pub(crate) certs: [KVec<u8>; SPDM_SLOTS],
+    pub(crate) leaf_key: Option<*mut bindings::public_key>,
 }
 
 impl Drop for SpdmState<'_> {
     fn drop(&mut self) {
+        if let Some(leaf_key) = self.leaf_key.take() {
+            // SAFETY: `leaf_key` was extracted from a x509 certificate
+            // in `validate_cert_chain()` so it is valid to pass to
+            // `public_key_free()`.
+            unsafe {
+                bindings::public_key_free(leaf_key);
+            }
+        }
+
         self.free_desc();
 
         unsafe {
@@ -186,6 +197,7 @@ pub(crate) fn new(
             desc: core::ptr::null_mut(),
             hash_len: 0,
             certs: [const { KVec::new() }; SPDM_SLOTS],
+            leaf_key: None,
         }
     }
 
@@ -762,4 +774,137 @@ pub(crate) fn get_certificate(&mut self, slot: u8) -> Result<(), Error> {
 
         Ok(())
     }
+
+    pub(crate) fn validate_cert_chain(&mut self, slot: u8) -> Result<(), Error> {
+        let cert_chain_buf = &self.certs[slot as usize];
+        let cert_chain_len = cert_chain_buf.len();
+        // We skip over the RootHash
+        let header_len = 4 + self.hash_len;
+
+        let mut offset = header_len;
+        let mut prev_cert: Option<*mut bindings::x509_certificate> = None;
+
+        if offset >= cert_chain_len {
+            return Err(EPROTO);
+        }
+
+        while offset < cert_chain_len {
+            // SAFETY: `cert_chain_buf[offset..]` is a non-empty slice of
+            // bytes valid for at least `cert_chain_len` bytes.
+            let cert_len = unsafe {
+                bindings::x509_get_certificate_length(
+                    &cert_chain_buf[offset..] as *const _ as *const u8,
+                    cert_chain_len - offset,
+                )
+            };
+
+            if cert_len < 0 {
+                pr_err!("Invalid certificate length\n");
+
+                if let Some(prev) = prev_cert {
+                    // SAFETY: `prev_cert` is the previously parsed
+                    // certificate from a prior loop iteration.
+                    unsafe { bindings::x509_free_certificate(prev) };
+                }
+
+                to_result(cert_len as i32)?;
+            }
+
+            // SAFETY: `cert_chain_buf[offset..]` is a non-empty slice of
+            // bytes valid for at least `cert_len` bytes.
+            let cert_ptr = unsafe {
+                match from_err_ptr(bindings::x509_cert_parse(
+                    &cert_chain_buf[offset..] as *const _ as *const c_void,
+                    cert_len as usize,
+                )) {
+                    Err(e) => {
+                        if let Some(prev) = prev_cert {
+                            // SAFETY: `prev_cert` is the previously parsed
+                            // certificate from a prior loop iteration.
+                            bindings::x509_free_certificate(prev);
+                        }
+                        return Err(e);
+                    }
+                    Ok(c) => c,
+                }
+            };
+            // SAFETY: Cast the `struct x509_certificate` to a Rust binding
+            let cert = unsafe { *cert_ptr };
+
+            if cert.unsupported_sig || cert.blacklisted {
+                pr_err!("Certificate was rejected\n");
+
+                if let Some(prev) = prev_cert {
+                    // SAFETY: `prev_cert` is the previously parsed
+                    // certificate from a prior loop iteration.
+                    unsafe { bindings::x509_free_certificate(prev) };
+                }
+                // SAFETY: `cert_ptr` was just returned by
+                // `x509_cert_parse()`.
+                unsafe { bindings::x509_free_certificate(cert_ptr) };
+
+                return Err(EKEYREJECTED);
+            }
+
+            if let Some(prev) = prev_cert {
+                // SAFETY: `prev_cert` is the previously parsed
+                // certificate from a prior loop iteration.
+                let rc = unsafe { bindings::public_key_verify_signature((*prev).pub_, cert.sig) };
+
+                if rc < 0 {
+                    pr_err!("Signature validation error\n");
+
+                    // SAFETY: `prev_cert` is the previously parsed
+                    // certificate from a prior loop iteration.
+                    unsafe { bindings::x509_free_certificate(prev) };
+
+                    // SAFETY: `cert_ptr` was just returned by
+                    // `x509_cert_parse()`.
+                    unsafe { bindings::x509_free_certificate(cert_ptr) };
+
+                    to_result(rc)?;
+                }
+            }
+
+            if let Some(prev) = prev_cert {
+                // SAFETY: `prev_cert` is the previously parsed
+                // certificate from a prior loop iteration.
+                unsafe { bindings::x509_free_certificate(prev) };
+            }
+
+            prev_cert = Some(cert_ptr);
+            offset += cert_len as usize;
+        }
+
+        if let Some(prev) = prev_cert {
+            if let Some(validate) = self.validate {
+                // SAFETY: Call the `validate` function provided.
+                let rc = unsafe { validate(self.dev, slot, prev) };
+                if let Err(e) = to_result(rc) {
+                    // SAFETY: `prev_cert` is the previously parsed
+                    // certificate from a prior loop iteration.
+                    unsafe { bindings::x509_free_certificate(prev) };
+                    return Err(e);
+                }
+            }
+
+            // The leaf key is the same for all slots (MULT_KEY_CAP == 0),
+            // so just store the first one.
+            if self.leaf_key.is_none() {
+                // SAFETY: `prev_cert` is the previously parsed
+                // certificate from a prior loop iteration.
+                self.leaf_key = unsafe { Some((*prev).pub_) };
+                // SAFETY: `prev_cert` is the previously parsed
+                // certificate from a prior loop iteration. We are setting
+                // the `pub` key to null so it isn't freed below
+                unsafe { (*prev).pub_ = core::ptr::null_mut() };
+            }
+
+            // SAFETY: `prev_cert` is the previously parsed
+            // certificate from a prior loop iteration.
+            unsafe { bindings::x509_free_certificate(prev) };
+        }
+
+        Ok(())
+    }
 }
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index d2781c27794b..5cc71552b524 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -38,6 +38,8 @@
 #include <drm/drm_gem_shmem_helper.h>
 #include <drm/drm_gpuvm.h>
 #include <drm/drm_ioctl.h>
+#include <keys/asymmetric-type.h>
+#include <keys/x509-parser.h>
 #include <kunit/test.h>
 #include <linux/auxiliary_bus.h>
 #include <linux/bitmap.h>
-- 
2.55.0

