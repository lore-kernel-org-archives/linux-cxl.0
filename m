Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793078854;
	b=lQmFRyPuTHzOMR3LzdGABZJoJ3zmWyzTLrjwDbZm9SB18MQVz83iZVV1SGvje7S9pQpC
	 Q128WH2pG2kLt4D4Of5GgT6HFBPvcjeqGJ8qeypD7cZ6gY6fhqh0+jAVIRVdu97gvEoGV
	 WywoNQlQTpQSSgX6vfDmIC0QuTGeCFk5bWxE1HbB6ue2VSXW6itYjDbFxYBO/Lvuqv/ES
	 v14vxfHv+HwCJVrQ1ufSj4+RRyvT5BnWkIhSSgs1ioXWBNwS0VFADxL+FMUJNemnXteU/
	 4NQJUhdiMz4FQB+tqOXICPR4NASWKKjdT3ICWMFdiy4qsAUuksTmvp0uoy0nOUXoqcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793078854;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5MkuSML0CXj91wrVIEGiElyyqrZvS0iKDa7bMqbnP3k=;
	b=njQPYCZOix9v7RVyS3qB/of8Sd3+EOS8ErKG6/nufRayyc1uGR8/GBdFE6LXoJYBJbYg
	 Fw9UVGilntgZ2x/ytqrwfRImaJOkuPB0ZD3uHjSdtzBaqWGZ2PbjAJSWSkoObsrfPO8pS
	 Zbe5IpV87nxfY5ppZzrausegkIR2gpm5KJ1Xq/Fa/sKIDvg3Bcn4mE2GEsCcRaN0xq1XH
	 6uRWX05CrDvyWvJ9Ezyc7K0OsuMP2Pt457209gR6pti97DXvgLheC/BolcJGwjx1VWLIN
	 jK7EtMv+YRMjshqEslqQa1jDZ8F0uEi7PBOtIrsBBn8qmguOwL709IpMRN1isFs6T8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Wbh7ObBm;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26927606A31D
	for <linux-cxl@vger.kernel.org>; Tue, 27 Oct 2026 05:27:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26927606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Wbh7ObBm
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e60f9af6e6so32082945ad.3
        for <linux-cxl@vger.kernel.org>; Mon, 26 Oct 2026 22:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793078853; x=1793683653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5MkuSML0CXj91wrVIEGiElyyqrZvS0iKDa7bMqbnP3k=;
        b=Wbh7ObBm9t0sFRe+lEvHInaznHfzDZOk1RC/RdczuVDSEFritYt8FqpKanNdyCSCdG
         izo+YS6LISu0SHTr82t9mMm3P3FcwvIowRi8hEDvW6lTrA8680FnaVHvTc6GMUoQvhzn
         lp3cxP6kvO3/CBkqEjP7DBBIcND0YksompdhrGtHftdrqTXgjeb8rkE9vCSLIUHqJSt2
         fIrUTGaVgrhowpmDPgH9ApqIq31hpRaP+8j8/bQynU9mmedNyuUy0n2OT4qWw9/zYenb
         r1OzclrqkT9tHOlqa/jG5Kj7pNYt+/jlO+HMK1UcELBMTed6FGG6im2rO2Ct/wgCHd35
         l4lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793078853; x=1793683653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5MkuSML0CXj91wrVIEGiElyyqrZvS0iKDa7bMqbnP3k=;
        b=SrdixyLvC93l874A2aaFEbX0YhWmcNdK04s4w4t0Fy17xdzcKFJRCKmoE7rMe/6H0t
         Bn+c3j6e0pAnIJILf3l2Zyj60PYk+27M/hICg3xUVMf4QppW33UjiZJEp7eH84JtUhNO
         ZUPikvzD68OnpQKqMKF8zGHUm8Se6QgpamCa4phLxHQVEpMErOwx2aoimikRFhlFL9k7
         E8fWe2iMhMnLC6Ax50zL2UwVIpjhkXSv1fD4lwqITZjmeGzpjSW6QXLLArB/+mgbbt4d
         zS+YGx1EGyGLlal+JZyXoj59itRkWVE94i3vcj4/I8mb2GKXR6l6UipUViEznPykSnsz
         CnnQ==
X-Forwarded-Encrypted: i=1; AKwUvBxIVOF9s/8UbHl3hNKFBopdu/qYyF0jC6FTMv7LOhvC3BcE/CpC3loX+0Ufiq0eQM0OwL+RnjOh/uw=@vger.kernel.org
X-Gm-Message-State: AFq9FYI7zvFXOi46l0dRkAKxSXlbuM3vSxt5oaFPK4DSmhqMPnNwQsOV
	JHslFrGBsaJnL8tnuTwvSpdoIbOTkSQ87423h6FIZrdlNIiNRO4RfceC
X-Gm-Gg: AYBFou0czpJ3Aypp3Cter64DsXO2X4MrHJ4xHbMe5r1nB6pPteIIsxOTdRVDGBlwA3T
	oa6P0EPFLORf17VeomwTLxbmeFMpvt/UoDN7wkNcceXEmQ8USZV3CHay8gL7rLFeajDp7L+GjJD
	qqj7sx8uS2iM2OxwnabG7588t5ACsDhJXt3DL/C/Z27Z0ZBtUqAh0ea03hdCQTowOa4Nh2b3WTc
	bx/+lmPslhICwVApUN3Ooaqh3wR0Z+EDv7mOEqHM3JN5XYKGHT5VcvC4WdGyqziuiMzjR8mgTfx
	MO/mPR76hWoYbjDhJoo++NTLormpxIoPBxd6obtlOl1ko0O+dfASjwoKgNzGFSkDoGzccwfH8VF
	r8wnTBwmBOc0z9DZmIZqf12oFz/tmMChqihXpyolGB7UFFI+W9f9OCTzxA/HU6MNKtaMvRAW2Gr
	OP3ca94xSM5Dc5uWKfDBUIP5zkiGR49dmx/HCZTgLRiOdet3xorTaot33z8mOgwGCDEkkILcnar
	WD1AB9fRZLFxpPc7hNDYrkIFCBVb38sx559LsFblFYM/VoQiAEMoNjraNsrknNtk5yxTM0lgHch
	rtXxQIXyN0JHvV/OaWk=
X-Received: by 2002:a17:902:ea12:b0:2e9:5507:b52c with SMTP id d9443c01a7336-2ea9c833a8amr76830915ad.34.1793078853454;
        Mon, 26 Oct 2026 22:27:33 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6c9757bsm3307715ad.58.2026.10.26.22.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 22:27:31 -0700 (PDT)
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
	Alistair Francis <alistair.francis@wdc.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v5 14/23] lib: rspdm: Support SPDM get_version
Date: Tue, 27 Oct 2026 15:25:27 +1000
Message-ID: <20261027052536.1722081-15-alistair.francis@wdc.com>
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

Support the GET_VERSION SPDM command.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 lib/rspdm/consts.rs    | 17 +++++++-
 lib/rspdm/lib.rs       | 25 +++++++++++-
 lib/rspdm/state.rs     | 43 +++++++++++++++++++-
 lib/rspdm/validator.rs | 90 +++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 169 insertions(+), 6 deletions(-)

diff --git a/lib/rspdm/consts.rs b/lib/rspdm/consts.rs
index ef6d61d4998b5..a130673b6473c 100644
--- a/lib/rspdm/consts.rs
+++ b/lib/rspdm/consts.rs
@@ -7,12 +7,25 @@
 //! Rust implementation of the DMTF Security Protocol and Data Model (SPDM)
 //! <https://www.dmtf.org/dsp/DSP0274>
 
+use crate::validator::SpdmHeader;
+use core::mem;
+
 // SPDM versions supported by this implementation
 pub(crate) const SPDM_VER_10: u8 = 0x10;
+#[expect(dead_code)]
+pub(crate) const SPDM_VER_11: u8 = 0x11;
+#[expect(dead_code)]
+pub(crate) const SPDM_VER_12: u8 = 0x12;
+#[expect(dead_code)]
+pub(crate) const SPDM_VER_13: u8 = 0x13;
+pub(crate) const SPDM_VER_14: u8 = 0x14;
 
 pub(crate) const SPDM_MIN_VER: u8 = SPDM_VER_10;
+pub(crate) const SPDM_MAX_VER: u8 = SPDM_VER_14;
 
-#[allow(dead_code)]
 pub(crate) const SPDM_REQ: u8 = 0x80;
-#[allow(dead_code)]
 pub(crate) const SPDM_ERROR: u8 = 0x7f;
+
+pub(crate) const SPDM_GET_VERSION: u8 = 0x84;
+pub(crate) const SPDM_GET_VERSION_LEN: usize =
+    mem::size_of::<SpdmHeader>() + 2 + (u8::MAX as usize) * mem::size_of::<u16>();
diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
index 27449ac1ca25d..e0fb7b49d4a07 100644
--- a/lib/rspdm/lib.rs
+++ b/lib/rspdm/lib.rs
@@ -238,7 +238,30 @@ fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
 ///
 /// See `include/linux/spdm.h` for the full C API documentation.
 #[export]
-pub extern "C" fn spdm_authenticate(_state_ptr: *mut spdm_state) -> c_int {
+pub extern "C" fn spdm_authenticate(state_ptr: *mut spdm_state) -> c_int {
+    if state_ptr.is_null() {
+        return -(bindings::EINVAL as c_int);
+    }
+
+    // SAFETY: `state_ptr` was returned from `spdm_create()` which used `into_foreign()`
+    // to create the pointer, and it remains valid until `spdm_destroy()` is called.
+    // We only borrow here (rather than `from_foreign()`) so that ownership stays
+    // with the foreign (C) caller.
+    // The exclusive `&mut SpdmState` lives entirely inside the lock guard, so
+    // concurrent FFI callers serialize on the mutex and can never form
+    // aliased `&mut SpdmState` references.
+    let mutex = unsafe {
+        <Pin<KBox<Mutex<SpdmState<'_, CTransport>>>> as ForeignOwnable>::borrow(
+            state_ptr.cast::<c_void>(),
+        )
+    };
+
+    let mut state = mutex.lock();
+
+    if let Err(e) = state.get_version() {
+        return e.to_errno() as c_int;
+    }
+
     -(EPROTONOSUPPORT as i32)
 }
 
diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
index f864d869eff0c..22655b2aff258 100644
--- a/lib/rspdm/state.rs
+++ b/lib/rspdm/state.rs
@@ -20,10 +20,14 @@
 
 use crate::consts::{
     SPDM_ERROR,
+    SPDM_GET_VERSION_LEN,
+    SPDM_MAX_VER,
     SPDM_MIN_VER,
     SPDM_REQ, //
 };
 use crate::validator::{
+    GetVersionReq,
+    GetVersionRsp,
     SpdmErrorRsp,
     SpdmHeader, //
 };
@@ -97,7 +101,6 @@ pub(crate) fn new(
     ///
     /// The data in `request_buf` is sent to the device and the response
     /// is returned as untrusted data to be validated by the caller.
-    #[allow(dead_code)]
     pub(crate) fn spdm_exchange(
         &self,
         request_buf: &[u8],
@@ -142,4 +145,42 @@ pub(crate) fn spdm_exchange(
 
         Ok(Untrusted::new(response_buf))
     }
+
+    /// Negotiate a supported SPDM version and store the information
+    /// in the `SpdmState`.
+    pub(crate) fn get_version(&mut self) -> Result<(), Error> {
+        let mut request = GetVersionReq::default();
+        request.header.version = SPDM_MIN_VER;
+        self.version = SPDM_MIN_VER;
+
+        let mut request_buf = request.to_bytes()?;
+
+        let response_vec: KVec<u8> = KVec::from_elem(0u8, SPDM_GET_VERSION_LEN, GFP_KERNEL)?;
+
+        let response: GetVersionRsp = self
+            .spdm_exchange(request_buf.as_mut_slice(), response_vec)?
+            .validate(&*self)?;
+
+        let mut foundver = false;
+        for &entry in response.version_number_entries.iter() {
+            let alpha_version = (entry & 0xF) as u8;
+            let version = (entry >> 8) as u8;
+
+            if alpha_version != 0 {
+                pr_warn!("Alpha version {alpha_version} is not specifically supported\n");
+            }
+
+            if version >= self.version && version <= SPDM_MAX_VER {
+                self.version = version;
+                foundver = true;
+            }
+        }
+
+        if !foundver {
+            pr_err!("No common supported version\n");
+            return Err(EPROTO);
+        }
+
+        Ok(())
+    }
 }
diff --git a/lib/rspdm/validator.rs b/lib/rspdm/validator.rs
index 0fe341b8dce12..98922638a228b 100644
--- a/lib/rspdm/validator.rs
+++ b/lib/rspdm/validator.rs
@@ -7,11 +7,16 @@
 //! Rust implementation of the DMTF Security Protocol and Data Model (SPDM)
 //! <https://www.dmtf.org/dsp/DSP0274>
 
+use crate::consts::{
+    SPDM_GET_VERSION,
+    SPDM_MIN_VER, //
+};
 use crate::{
     SpdmErrorCode,
     SpdmState,
     Transport, //
 };
+use core::mem;
 use kernel::prelude::*;
 use kernel::{
     error::Error,
@@ -31,7 +36,6 @@ pub(crate) struct SpdmHeader {
 }
 
 impl SpdmHeader {
-    #[expect(dead_code)]
     pub(crate) fn new(code: u8) -> Self {
         SpdmHeader {
             version: 0,
@@ -41,7 +45,6 @@ pub(crate) fn new(code: u8) -> Self {
         }
     }
 
-    #[expect(dead_code)]
     pub(crate) fn to_bytes(&self) -> Result<KVec<u8>> {
         let mut out = KVec::new();
 
@@ -90,3 +93,86 @@ fn validate(unvalidated: &[u8], _context: &'c SpdmState<'c, T>) -> Result<Self,
         })
     }
 }
+
+pub(crate) struct GetVersionReq {
+    pub(crate) header: SpdmHeader,
+}
+
+impl GetVersionReq {
+    pub(crate) fn to_bytes(&self) -> Result<KVec<u8>> {
+        self.header.to_bytes()
+    }
+}
+
+impl Default for GetVersionReq {
+    fn default() -> Self {
+        GetVersionReq {
+            header: SpdmHeader::new(SPDM_GET_VERSION),
+        }
+    }
+}
+
+#[expect(dead_code)]
+pub(crate) struct GetVersionRsp {
+    pub(crate) header: SpdmHeader,
+
+    pub(crate) version_number_entry_count: u8,
+    pub(crate) version_number_entries: KVec<u16>,
+
+    /// The actual length of the SPDM message. `raw_bytes` might be longer
+    /// as it includes transport specific padding.
+    length: usize,
+
+    /// Entire response, used for the transcript hash.
+    raw_bytes: KVec<u8>,
+}
+
+impl GetVersionRsp {
+    #[expect(dead_code)]
+    pub(crate) fn as_bytes(&self) -> Result<&[u8], Error> {
+        self.raw_bytes.get(..self.length).ok_or(EPROTO)
+    }
+}
+
+impl<'c, T: Transport> Validate<'c, Untrusted<KVec<u8>>, &'c SpdmState<'c, T>> for GetVersionRsp {
+    type Err = Error;
+
+    fn validate(unvalidated: KVec<u8>, context: &'c SpdmState<'c, T>) -> Result<Self, Self::Err> {
+        let header: SpdmHeader =
+            Untrusted::new(unvalidated.get(0..4).ok_or(EPROTO)?).validate(context)?;
+
+        if header.code != SPDM_GET_VERSION - 0x80 {
+            return Err(EPROTO);
+        }
+
+        if header.version != SPDM_MIN_VER {
+            return Err(EPROTO);
+        }
+
+        let version_number_entry_count = *unvalidated.get(5).ok_or(EPROTO)?;
+
+        // Entries follow header (4) + reserved (1) + count (1) = 6 bytes.
+        let mut offset = mem::size_of::<SpdmHeader>() + 2;
+
+        let mut version_number_entries = KVec::new();
+        for _ in 0..version_number_entry_count {
+            let entry = u16::from_le_bytes(
+                unvalidated
+                    .get(offset..offset + mem::size_of::<u16>())
+                    .ok_or(EPROTO)?
+                    .try_into()
+                    .map_err(|_| EPROTO)?,
+            );
+            version_number_entries.push(entry, GFP_KERNEL)?;
+            offset += mem::size_of::<u16>();
+        }
+
+        Ok(GetVersionRsp {
+            header,
+            version_number_entry_count,
+            version_number_entries,
+            length: offset,
+            raw_bytes: unvalidated,
+        })
+    }
+}
-- 
2.56.0

