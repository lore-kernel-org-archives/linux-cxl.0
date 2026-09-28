Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF435335555
	for <linux-cxl@vger.kernel.org>; Mon, 28 Sep 2026 01:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790558027; cv=none; b=gfkLyHXlrAc/dosrW3fc6nFMjO8edO0LjNbd4R19ycE8JnmPmmAK9GXrnagmI/9gPRjz5pdva0KR42m3fEPabkb1RLzm/KypGk3hZJsZQA/b8Tb++fIqgUPVXHbWbq0JOraqQTQnBeZQ0egzICqd5gcBF9v/53qsY8ksz75vpGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790558027; c=relaxed/simple;
	bh=f9ZhtYSlrwFJfmTSOBai7MB1cph32op5FRcZer33uNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=doP+w5c/GbVZqrUbmo9g/kbs4QDZaHFQ4ldnR5k1oFOiiaQvfF2ev670a6wbdMZBfLTyFl1KXK7ep7Cwa3VzOLErucMZac/jsDp6oBgbGbWAeeF+dG9OuAvqzGd2eYkUrRaZYvNLeVDOGbJaDpBHNIggvwuC5XdwXDey649QLfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aM7+sfLF; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aM7+sfLF"
Received: by mail-pj2-f43.google.com with SMTP id d9443c01a7336-2df8de41d6eso15276315ad.1
        for <linux-cxl@vger.kernel.org>; Sun, 27 Sep 2026 18:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790558025; x=1791162825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9p8DnBZJKeBguPKZaL9Uo6YvWl4RWzdFx0DNOjIPErs=;
        b=aM7+sfLFGoPyg1OV+ICDFURdrHjfKsiYs4TFyFEsTtAhi8loLlhqlgFScBeVdr8MK1
         kvRTFP8SOR2bD6Z/LGpSt275pcRdOhYTOmOp2EOl9LafHAvR5da8XyarZLKehC6Bu+Ww
         jh2MRf+K9gq4Ifvk05CFVHrwcVkjcY/+AJGq4j5qigx42DF/0/zKtnyS8ERRc0VLvm1i
         l6alD7hItGcbK3/P63j3IYCqanGdEKZOqKLkhFy7G7fWctDJlwbeiToSzTOc/1Fn/0cH
         cISsgDROPmq1az1c22i9IW2/aXjopK5segTfZwN/cAviEQwrllG2XTcdBL10Y3gLhmeF
         YSpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790558025; x=1791162825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9p8DnBZJKeBguPKZaL9Uo6YvWl4RWzdFx0DNOjIPErs=;
        b=nedDz7Yvw3BxzQCD+m3rgLiLzVTZ/iJlJFia4mVqo2lQhBOU2o9yojCAF6NMPvHGOb
         IIyvUlHj0FkgxIcY6T9PNIzqvWQ7epW6cSdHFYDp7IeDZeUy2ziD6OnDcFNzVbFhkSnO
         Cpefvtx9y8qdaW4StmN4MZzpAPmvBuHYb19MVYMaf7y24/j1cvF3oXQZlHEaFnFbhw/9
         uWtoTZMUeJPRNoBB/GMqVFEEoYf6Q+Qzr24ltPxAm8WiOf8TodU0/nMhU27niRruO8qH
         hibSF7Mnh/p/0fKVCfIA/YwpfULUB++ULW5/Xbd4g9ZOV5iJXKfFre1J/D1ZfGnhhP1+
         WDBw==
X-Forwarded-Encrypted: i=1; AKwUvBzGGr7+ioLoqs5nGDfaNS9u80+oqJ9J5+TtNuM3ipgFxNUTia5AblKxjQnDeFWw/M2hfCKfjkpaTUU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKehAL8/Ei9Og9qsIkZL1+HXk5CB/pmNSPLrvdtTLCzot6s8wlz
	53Ch9gjM3j8x5lJDDVLhsaUyI/Mc+aJMY0TZ0xREPj/qj4osDYZehDW2
X-Gm-Gg: AYBFou2sznpFU960XooOmJXhJ3JLishn6p3789CDJckN9slLhOdh4C1PMCU7fp7WPrA
	n/7EYkNK/WovoGuUkxLATt+WoLX14PLpqtfYy75JAiRPJfqh2Eyi0L3PFYPifBebdK/LDlw2ZZG
	mkdbz9tYrJ1e3Bt7AEebk5vEZGH1H8UtWK1nRiv377GzJxA191GsF8av+7BiAVXjl+wfzetwGn5
	5ta/tpFgvXnxLRX0RJw31Sjvv+d5W/s+QQg5fk45i2iT3gQIVphgURNte6WhuG8FhssfK2fYYPq
	76XTMDrlt6oUiWsRjpcu6zYDdgCZiGtm67tlAohIA8CTU3Mv3aIApkx88APKaIlDGYZzBEJnXZi
	2pfG+m522vBfzNFpFzOYkB104ep6diytvEGvFQOZb+Ipkrd23Hsm5HGPro/vuBferL3BMkF7i/F
	7PrOr8BJBkGGo1WfWat9WoNtsTvfJRVgs7/mXKvr1zY6BRheIMQaJ4Xpd64a8qoIIycf5xWHv4q
	Sacydwu0Nc4TD+w00hXQAo1FWg=
X-Received: by 2002:a17:90b:35c4:b0:3a2:b16d:928b with SMTP id 98e67ed59e1d1-3a2b16da167mr1695774a91.46.1790558025044;
        Sun, 27 Sep 2026 18:13:45 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0e7036e3bsm10425773a91.13.2026.09.27.18.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 18:13:44 -0700 (PDT)
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
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v4 18/22] lib: rspdm: Support SPDM get_digests
Date: Mon, 28 Sep 2026 11:11:19 +1000
Message-ID: <20260928011123.450800-19-alistair.francis@wdc.com>
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

From: Alistair Francis <alistair@alistair23.me>

Support the GET_DIGESTS SPDM command.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 lib/rspdm/consts.rs    |  5 ++-
 lib/rspdm/lib.rs       |  4 ++
 lib/rspdm/state.rs     | 56 +++++++++++++++++++++++-
 lib/rspdm/validator.rs | 99 +++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 161 insertions(+), 3 deletions(-)

diff --git a/lib/rspdm/consts.rs b/lib/rspdm/consts.rs
index d51b6eb06f81..11e080815aa6 100644
--- a/lib/rspdm/consts.rs
+++ b/lib/rspdm/consts.rs
@@ -19,10 +19,11 @@
 pub(crate) const SPDM_VER_10: u8 = 0x10;
 pub(crate) const SPDM_VER_11: u8 = 0x11;
 pub(crate) const SPDM_VER_12: u8 = 0x12;
-#[expect(dead_code)]
 pub(crate) const SPDM_VER_13: u8 = 0x13;
 pub(crate) const SPDM_VER_14: u8 = 0x14;
 
+pub(crate) const SPDM_SLOTS: usize = 8;
+
 pub(crate) const SPDM_MIN_VER: u8 = SPDM_VER_10;
 pub(crate) const SPDM_MAX_VER: u8 = SPDM_VER_14;
 
@@ -145,6 +146,8 @@ fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
 pub(crate) const SPDM_HASH_SHA_384: u32 = bit_u32(1);
 pub(crate) const SPDM_HASH_SHA_512: u32 = bit_u32(2);
 
+pub(crate) const SPDM_GET_DIGESTS: u8 = 0x81;
+
 // If the crypto support isn't enabled don't offer the algorithms
 // to the responder
 #[cfg(CONFIG_CRYPTO_RSA)]
diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
index 63db5da8aa7a..92035b1070d1 100644
--- a/lib/rspdm/lib.rs
+++ b/lib/rspdm/lib.rs
@@ -105,6 +105,10 @@ pub extern "C" fn spdm_authenticate(state_ptr: *mut spdm_state) -> c_int {
         return e.to_errno() as c_int;
     }
 
+    if let Err(e) = state.get_digests() {
+        return e.to_errno() as c_int;
+    }
+
     -(EPROTONOSUPPORT as i32)
 }
 
diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
index 51055ea521d7..502d99eb13a6 100644
--- a/lib/rspdm/state.rs
+++ b/lib/rspdm/state.rs
@@ -43,13 +43,17 @@
     SPDM_OPAQUE_DATA_FMT_GENERAL,
     SPDM_REQ,
     SPDM_RSP_MIN_CAPS,
+    SPDM_SLOTS,
     SPDM_VER_10,
     SPDM_VER_11,
-    SPDM_VER_12, //
+    SPDM_VER_12,
+    SPDM_VER_13, //
 };
 use crate::validator::{
     GetCapabilitiesReq,
     GetCapabilitiesRsp,
+    GetDigestsReq,
+    GetDigestsRsp,
     GetVersionReq,
     GetVersionRsp,
     NegotiateAlgsReq,
@@ -91,6 +95,10 @@
 ///  Selected by responder during NEGOTIATE_ALGORITHMS exchange.
 /// @meas_hash_alg: Hash algorithm for measurement blocks.
 ///  Selected by responder during NEGOTIATE_ALGORITHMS exchange.
+/// @supported_slots: Bitmask of responder's supported certificate slots.
+///  Received during GET_DIGESTS exchange (from SPDM 1.3).
+/// @provisioned_slots: Bitmask of responder's provisioned certificate slots.
+///  Received during GET_DIGESTS exchange.
 /// @base_asym_enc: Human-readable name of @base_asym_alg's signature encoding.
 ///  Passed to crypto subsystem when calling verify_signature().
 /// @sig_len: Signature length of @base_asym_alg (in bytes).
@@ -102,6 +110,8 @@
 /// @desc: Synchronous hash context for @base_hash_alg computation.
 /// @hash_len: Hash length of @base_hash_alg (in bytes).
 ///  H in SPDM specification.
+/// @certs: Certificate chain in each of the 8 slots. Empty KVec if a slot is
+///  not populated. Prefixed by the 4 + H header per SPDM 1.0.0 table 15.
 #[expect(dead_code)]
 pub(crate) struct SpdmState<'a> {
     pub(crate) dev: *mut bindings::device,
@@ -116,6 +126,8 @@ pub(crate) struct SpdmState<'a> {
     pub(crate) base_asym_alg: u32,
     pub(crate) base_hash_alg: u32,
     pub(crate) meas_hash_alg: u32,
+    pub(crate) supported_slots: u8,
+    pub(crate) provisioned_slots: u8,
 
     /* Signature algorithm */
     base_asym_enc: &'a CStr,
@@ -126,6 +138,9 @@ pub(crate) struct SpdmState<'a> {
     pub(crate) shash: *mut bindings::crypto_shash,
     pub(crate) desc: *mut bindings::shash_desc,
     pub(crate) hash_len: usize,
+
+    // Certificates
+    pub(crate) certs: [KVec<u8>; SPDM_SLOTS],
 }
 
 impl Drop for SpdmState<'_> {
@@ -157,12 +172,15 @@ pub(crate) fn new(
             base_asym_alg: 0,
             base_hash_alg: 0,
             meas_hash_alg: 0,
+            supported_slots: 0,
+            provisioned_slots: 0,
             base_asym_enc: unsafe { CStr::from_bytes_with_nul_unchecked(b"\0") },
             sig_len: 0,
             base_hash_alg_name: unsafe { CStr::from_bytes_with_nul_unchecked(b"\0") },
             shash: core::ptr::null_mut(),
             desc: core::ptr::null_mut(),
             hash_len: 0,
+            certs: [const { KVec::new() }; SPDM_SLOTS],
         }
     }
 
@@ -600,4 +618,40 @@ pub(crate) fn negotiate_algs(&mut self) -> Result<(), Error> {
 
         Ok(())
     }
+
+    pub(crate) fn get_digests(&mut self) -> Result<(), Error> {
+        let mut request = GetDigestsReq::default();
+        request.header.version = self.version;
+
+        let rsp_sz = core::mem::size_of::<SpdmHeader>() + SPDM_SLOTS * self.hash_len;
+
+        let mut request_buf = request.to_bytes()?;
+
+        let mut response_vec: KVec<u8> = KVec::from_elem(0u8, rsp_sz, GFP_KERNEL)?;
+
+        let len =
+            self.spdm_exchange(request_buf.as_mut_slice(), response_vec.as_mut_slice())? as usize;
+        response_vec.truncate(len);
+
+        let response: GetDigestsRsp = Untrusted::new(response_vec.as_slice()).validate(&*self)?;
+
+        let mut deprovisioned_slots = self.provisioned_slots & !response.header.param2;
+        while (deprovisioned_slots.trailing_zeros() as usize) < SPDM_SLOTS {
+            let slot = deprovisioned_slots.trailing_zeros() as usize;
+            self.certs[slot].clear();
+            deprovisioned_slots &= !(1 << slot);
+        }
+
+        self.provisioned_slots = response.header.param2;
+
+        let supported_slots = if self.version >= SPDM_VER_13 {
+            response.header.param1
+        } else {
+            0xFF
+        };
+
+        self.supported_slots = supported_slots;
+
+        Ok(())
+    }
 }
diff --git a/lib/rspdm/validator.rs b/lib/rspdm/validator.rs
index 58f6a3d436a8..c058dde31440 100644
--- a/lib/rspdm/validator.rs
+++ b/lib/rspdm/validator.rs
@@ -26,6 +26,7 @@
     SPDM_CAP_SUPPORTED_ALGORITHMS,
     SPDM_CTEXPONENT,
     SPDM_GET_CAPABILITIES,
+    SPDM_GET_DIGESTS,
     SPDM_GET_VERSION,
     SPDM_HASH_ALGOS,
     SPDM_MEAS_SPEC_DMTF,
@@ -33,9 +34,11 @@
     SPDM_MIN_VER,
     SPDM_NEGOTIATE_ALGS,
     SPDM_REQ_CAPS,
+    SPDM_SLOTS,
     SPDM_VER_10,
     SPDM_VER_11,
-    SPDM_VER_12, //
+    SPDM_VER_12,
+    SPDM_VER_13, //
 };
 
 #[repr(C, packed)]
@@ -697,3 +700,97 @@ fn validate(unvalidated: &[u8], context: &'c SpdmState<'c>) -> Result<Self, Self
         })
     }
 }
+
+pub(crate) struct GetDigestsReq {
+    pub(crate) header: SpdmHeader,
+}
+
+impl GetDigestsReq {
+    pub(crate) fn to_bytes(&self) -> Result<KVec<u8>> {
+        self.header.to_bytes()
+    }
+}
+
+impl Default for GetDigestsReq {
+    fn default() -> Self {
+        GetDigestsReq {
+            header: SpdmHeader::new(SPDM_GET_DIGESTS),
+        }
+    }
+}
+
+#[expect(dead_code)]
+pub(crate) struct GetDigestsRsp {
+    pub(crate) header: SpdmHeader,
+
+    pub(crate) digests: [KVec<u8>; SPDM_SLOTS],
+
+    // KeyPairIDs, added in 1.3
+
+    // CertificateInfo, added in 1.3
+
+    // KeyUsageMask, added in 1.3
+    /// Size of the response, not public
+    length: usize,
+}
+
+impl GetDigestsRsp {
+    #[expect(dead_code)]
+    pub(crate) fn len(&self) -> usize {
+        self.length
+    }
+}
+
+impl<'a, 'c> Validate<'c, Untrusted<&'a [u8]>> for GetDigestsRsp {
+    type Err = Error;
+
+    type Context = &'c SpdmState<'c>;
+
+    fn validate(unvalidated: &[u8], context: &'c SpdmState<'c>) -> Result<Self, Self::Err> {
+        let header: SpdmHeader =
+            Untrusted::new(unvalidated.get(0..4).ok_or(EIO)?).validate(context)?;
+
+        if header.code != SPDM_GET_DIGESTS - 0x80 {
+            return Err(EINVAL);
+        }
+
+        if header.version != context.version {
+            pr_err!("Invalid version response\n");
+            return Err(EPROTO);
+        }
+
+        if header.param2 == 0 {
+            pr_err!("No certificates provisioned\n");
+            return Err(EPROTO);
+        }
+
+        let mut digests: [KVec<u8>; SPDM_SLOTS] = [const { KVec::new() }; SPDM_SLOTS];
+        let mut offset = mem::size_of::<SpdmHeader>();
+        let mut slot_mask = header.param2;
+
+        while (slot_mask.trailing_zeros() as usize) < SPDM_SLOTS {
+            let slot = slot_mask.trailing_zeros() as usize;
+
+            digests[slot].extend_from_slice(
+                unvalidated
+                    .get(offset..(offset + context.hash_len))
+                    .ok_or(EIO)?,
+                GFP_KERNEL,
+            )?;
+            offset += context.hash_len;
+
+            slot_mask &= !(1 << slot);
+        }
+
+        if context.version >= SPDM_VER_13 && (header.param2 & !header.param1 != 0) {
+            pr_err!("Malformed digests response\n");
+            return Err(EPROTO);
+        }
+
+        Ok(GetDigestsRsp {
+            header,
+            digests,
+            length: offset,
+        })
+    }
+}
-- 
2.55.0

