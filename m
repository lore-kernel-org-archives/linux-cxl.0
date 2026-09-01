Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D03C3A9620
	for <linux-cxl@vger.kernel.org>; Tue,  1 Sep 2026 01:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788224807; cv=none; b=A2rJvrOvA7VAr+PqALbivvcgX/G6dKaOqoSQ3IZ+QR91fOY5ZK1PjjFfJu/GU6/NMeqGMbk/EyONcXBBoDOuJuy8/cxcIaZBJ+hVaXlAhUg/F6gn2W+8Vz6KtSw/AccjQcZHW6vilG2Xa4u6jACOzLnGyZXs5AJHDJDoQJVIP4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788224807; c=relaxed/simple;
	bh=J2T7JILoVByS1MCnyW03kxxqDPc+zD1Y62mEstcjhGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ul/c4h7TeAO7UAh270MQJ3kHrjMa4CueZvQJvMgVsqGQ8SMwYemyDNAgcdtx4ekF2C9Gp+RErvsYIMDhis4ea+2OvOHEY/jl+e1H7EHM1PsDbL7wpMiOO4/cV1WxEV+UCH2WrbhlvYUPgjRNRat7w1ke0RlGn4VJASFmlCZys20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AKD2k6AN; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AKD2k6AN"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-398c1101c1bso2416669a91.1
        for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 18:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788224805; x=1788829605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6+g1amS8TRdiwzXTKVJFNhTGQRsJ1L567PEixpjliHU=;
        b=AKD2k6ANVeCaqQk72UsRW/MXsWjkC9sv3DG5oxLDONtGMacee/UJHIQ7666bdKDVB/
         yot9DhVmSutCQlxYl/cq3hmQ+gZ93xfjsC7dnejV2Vu1cE1s2uRFkuyni6Obum5BGfRt
         M4yNCzwvkUCAqnggj2VGgd+4+HcbTCRPRw9uYvFIXQwoZFOf0pKvoCU480RAV8n599FK
         5CCy/TrNO5g6OKK6haz6RfKgjGzsoW0BCmx/FAB0wbGZL5iSxaRwDxXHFwaXuvnWNBU4
         cOLs2rwmOenWUyMxlZNkdC2CKXHurNZw05s2ENmGPvZJZahqsSOTzSpcxftRZSph/PG3
         /0PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788224805; x=1788829605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6+g1amS8TRdiwzXTKVJFNhTGQRsJ1L567PEixpjliHU=;
        b=Y+tA0zmC6BuQ2mf5K6SYYn3lxgpmYSd16ULRtrXD9NVCAcAnfr4c8LNZXZuSbGxXMS
         Ayn5rCP6jZYMzy8zagTJoiO28643XoxfDk8hxxBiP/KM0orOGA7DFW3YKq4R9GXk08rc
         aEPt8L9Itkx/BzWvV6C6f/Zy90G4gcjsLoXURlSerwY5xgwxdxwAOThQnTahyqH6EBH0
         f77EFEF9VX89SDl4ttDQycwSzcTCZnvQ3DIN83wcqOeFKBpcteSRUvkp4UPxX3N8ZiEh
         j+iTPwBIxOB0CNO8cmZFOFuyY/xNq33gfYfJfnMoxSLRfEO3PEpaa6CBg+AQHmvWYjoO
         cQ7w==
X-Forwarded-Encrypted: i=1; AKwUvBxt8cQEoCI6EvKRA8+GCVo8isLGG2pQ+PksgQyNFulO4H4L8frjykiO0nZCx/nRwqhKRnfKEQZNUO4=@vger.kernel.org
X-Gm-Message-State: AFuF++lVmeGuD5J3T062F4A46NOocbyS/7nMCQTwN6uYqe698Bk66s3W
	8J+exr1GEFqhZB2tnWGRhwiWKx59ANqzhTVaMX3wpGlTWHl1Hxkblw2eI1VSQA==
X-Gm-Gg: AYBFou363oIOJeWKpmu2np0uud3ml+/VeuK3MeFCb2pquOaOaiLY0R3LIkcihCvAYy8
	PvVid3rZcNxrsBkKvj9iNm/Ld11P+G5gtC3c5t65H0sBMFtKk9RtMnX9meSsdkYwYYZpG7GUf0T
	/pZ73d3PntMljZu0Es7yfDk8WRZbBZKpsn3QTPgkUBhqjfZlNwNcEVH+gNocYKYFpe8cLNJ8qXB
	/8XkZEefThg//v43qjkWu0pCnRHDSDsAm0+okrFASUaRUNd3SZrhdUEenYwIFH7Y7pd1sBF2q85
	u6u0E6OEjHHVQmFaDqpxfAhT8wIY3vKQ4UxwIpu0z97HZOKMSy+warZSADZvimAM50Vaq6Ua90a
	WsI5iceKQGIfMASWODlPDK2fTArGnoB3vqyd31RF1rERAjwLdjHPOBehx1zxz2mo9g4FcnfCWI0
	/Qs6NUPtC+NRWWc+/YPSzmTMgA1wte57zX2RQZuKunU0CuKw4pm7A+VC9Ck6Ket6I0hx2wKBonL
	srpbw==
X-Received: by 2002:a17:90b:5544:b0:398:bd37:6a49 with SMTP id 98e67ed59e1d1-398bd376c65mr24254913a91.12.1788224805187;
        Mon, 31 Aug 2026 18:06:45 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990d49e9e0sm2372024a91.11.2026.08.31.18.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 18:06:44 -0700 (PDT)
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
	aliceryhl@google.com
Subject: [PATCH v3 19/21] lib: rspdm: Support SPDM certificate validation
Date: Tue,  1 Sep 2026 11:03:45 +1000
Message-ID: <20260901010347.2614656-20-alistair.francis@wdc.com>
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
 lib/rspdm/state.rs              | 146 +++++++++++++++++++++++++++++++-
 rust/bindings/bindings_helper.h |   2 +
 3 files changed, 159 insertions(+), 1 deletion(-)

diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
index 488203be821d..fa5513e8bd4e 100644
--- a/lib/rspdm/lib.rs
+++ b/lib/rspdm/lib.rs
@@ -129,6 +129,18 @@ pub extern "C" fn spdm_authenticate(state_ptr: *mut spdm_state) -> c_int {
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
index 1e8a4402e634..fc7df9dd7b97 100644
--- a/lib/rspdm/state.rs
+++ b/lib/rspdm/state.rs
@@ -109,7 +109,8 @@
 ///  H in SPDM specification.
 /// @certs: Certificate chain in each of the 8 slots. Empty KVec if a slot is
 ///  not populated. Prefixed by the 4 + H header per SPDM 1.0.0 table 15.
-#[expect(dead_code)]
+/// @leaf_key: Public key portion of leaf certificate against which to check
+///  responder's signatures.
 pub(crate) struct SpdmState<'a> {
     pub(crate) dev: *mut bindings::device,
     pub(crate) transport: bindings::spdm_transport,
@@ -138,10 +139,20 @@ pub(crate) struct SpdmState<'a> {
 
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
         if let Some(desc) = self.desc.take() {
             // SAFETY: `self.shash` is a valid handle
             let desc_len = core::mem::size_of::<bindings::shash_desc>()
@@ -200,6 +211,7 @@ pub(crate) fn new(
             desc: None,
             hash_len: 0,
             certs: [const { KVec::new() }; SPDM_SLOTS],
+            leaf_key: None,
         }
     }
 
@@ -846,4 +858,136 @@ pub(crate) fn get_certificate(&mut self, slot: u8) -> Result<(), Error> {
 
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
+            // The leaf key is the same for all slots, so just store the first one.
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

