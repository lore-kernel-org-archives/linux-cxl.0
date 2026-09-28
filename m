Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99549347500
	for <linux-cxl@vger.kernel.org>; Mon, 28 Sep 2026 01:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790558005; cv=none; b=K9lZCBAxholi9aoODQDJYn4ulub8JLaFahhSdWESzuqR+HRQr4E+x6NrAz1sjO3JX18+Gb+f15Foa/Vtv5EnEDySkLiij6dwuEwkMd4HYV5PuuxjN3oi7NnZA61gjKb0sBxnJiQ5a5fgaoEpax0Oa8lbR6XwvBcyaTBV984ZN6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790558005; c=relaxed/simple;
	bh=mIJj2PFMVUUNNsXwcbtjNssZ9wRJR+8187rmA5db69w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jTnyX07ATkqKQ9eOX/Z8F4YoLsmYvWdJflmyC8mlItI8g/io6N5pBL2PClgmB5CfSo1hcomzGVOST+zRiz3NFrKegWmWeEp9rYae3EqL6n9uL5ktaDMPYjMX1Hdmt+AmO/AuQ00uqpYG+Mr17KbYbIbzqD6BbExNb6ufHGMN+B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVlN2STk; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVlN2STk"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccafb752so1226234a91.0
        for <linux-cxl@vger.kernel.org>; Sun, 27 Sep 2026 18:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790558003; x=1791162803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NxbrOG9ST+XaQdXoHv0Ef4P/NyPEEJDX0N7/PNt6kcQ=;
        b=BVlN2STkXq3Eu8jBopPWnXR+cf6Ep7eyEBuryQio/z5U08v/6Zd0wUGTH0zOe5KFtK
         CJypjInMPKnPq9CDuQeucybT3Lz0I/DfEghoNBub+qpYg13G8rtGl0AewGCiBFP/midS
         pOq2I5w/Fp7rxhQrvtZU3IlH49Mm83m8ArBnL3b4HhwZcsYdgSfGU186bC1Ueu/fD6wn
         56tsvUHTizaZKabW/uChRePX4DfHu69IQbhOcE7ddoS2GLPImSY3GI1YjO33SlRzsQaM
         Bdg24lSYJp+I0RvelG9maSozCk2DbLicZf5ZbfpHT5ceKfWe8KcoI4RH9oellF7PwM2U
         5+eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790558003; x=1791162803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NxbrOG9ST+XaQdXoHv0Ef4P/NyPEEJDX0N7/PNt6kcQ=;
        b=giHeoV7Mb+FKpZIX7xhrEkVSYOsuUcqrV7ds/k94y0sC5DYeTXzX89Hxu9j9QOWaM2
         sgh+FFGN72Ommjsx6B5BEHpVCcIbuM3rjTtT9ZivBoOuu/rAvLgxdv1liDPszwxwO+0x
         0zV59nKlKXBBhtdriMfQvd61N514nWJeDOUFCaIXgSonzOYDZctzk7AG5MOD7AKnzJE4
         S3XyjYclEL6QZuPBDqrX0gn9QnFJWh7MiUzKn/bjWo8PVJ+3wiSDWJdWPpq4xCj1LwOf
         FdnZM7B8Y0HZXfdOF9qbDjHNQLs7ybt1b9YpPbS7b0sNka0hYc8OQBdY4TCaArNa1Ho6
         BmYg==
X-Forwarded-Encrypted: i=1; AKwUvByLrxAdIMy67UKfo5Qo40UoAnfxOU48w79FdVCmwMYOlsysziRwsMBP+mLUwYrx8L5RJfqh+p/KTvM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLWBpVPoyTEaTAyyFUDlaw7b3s2EAAEKUZlgX5e7v1N47MWst/1
	CrZlSmVlEIj/uIzi4WlvfgDWn8k3I8ovNy4idzBFMteK8LOD28gIDF/F
X-Gm-Gg: AYBFou3G2ksIKvwfUN1RSiH5DW0GvC9bLN4aHxDP4AB5eM+tlc4rFCtdi8BqkPm5ilD
	CWWpM5CoMm7A7h4dpUljekUPRTAlfdrwCWobSA28MMSdp0V3pj7nUtzLZrpvHHSwz9H60xcLRw4
	wW454Qow11gE7KV0FhhRqtx6pljXh9EGFfimmGXkfDw8DzkCU8ZpHKVVikEvDeMgI8Z1WpLrQ3f
	3yh3HHHR7FNpip7KFg0Ak+5D/rhITfte2mxYQBIbBCV1bzRVRo5xsWQVCjESj6EocIVE0IcjwpI
	liMh03dcVE1q1F5Z5z6JpW6O0o7x9a5rgGir7oBUV8wqvBimyV8j/kwrAUIuC1IaBe8TsSrVEqi
	r21W241hMmUFsvl5/DPZPtU7lfZ8UJZC+bLkHuvGHcjdA3/uzhI6dQE8dJjD82GweDVGfJ5CRgD
	4/U3qY7w9+GQFGJW+g9B5UvcceHVQtaLFxRL4Yfkog9X1LEwmJA5uO32LUs1jILycCTNguqu82k
	KathQujXHdo1zzU0ztjrb3tiw6o
X-Received: by 2002:a17:90b:1dcd:b0:3a2:b036:ed63 with SMTP id 98e67ed59e1d1-3a2b036f44cmr1034460a91.38.1790558002874;
        Sun, 27 Sep 2026 18:13:22 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0e7036e3bsm10425773a91.13.2026.09.27.18.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 18:13:22 -0700 (PDT)
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
Subject: [PATCH v4 15/22] lib: rspdm: Support SPDM get_version
Date: Mon, 28 Sep 2026 11:11:16 +1000
Message-ID: <20260928011123.450800-16-alistair.francis@wdc.com>
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

Support the GET_VERSION SPDM command.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 lib/rspdm/consts.rs    | 16 +++++++-
 lib/rspdm/lib.rs       | 23 ++++++++++-
 lib/rspdm/state.rs     | 56 ++++++++++++++++++++++++++-
 lib/rspdm/validator.rs | 88 +++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 176 insertions(+), 7 deletions(-)

diff --git a/lib/rspdm/consts.rs b/lib/rspdm/consts.rs
index 9709f51849d7..cb0fc2b55206 100644
--- a/lib/rspdm/consts.rs
+++ b/lib/rspdm/consts.rs
@@ -7,16 +7,24 @@
 //! Rust implementation of the DMTF Security Protocol and Data Model (SPDM)
 //! <https://www.dmtf.org/dsp/DSP0274>
 
+use crate::validator::SpdmHeader;
+use core::mem;
 use kernel::error::{code::EINVAL, Error};
 
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
 
 #[derive(Clone, Copy)]
@@ -90,3 +98,7 @@ fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
         write!(f, "{:#x}", *self as u8)
     }
 }
+
+pub(crate) const SPDM_GET_VERSION: u8 = 0x84;
+pub(crate) const SPDM_GET_VERSION_LEN: usize =
+    mem::size_of::<SpdmHeader>() + 2 + (u8::MAX as usize) * mem::size_of::<u16>();
diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
index 1010bd38df6d..df3b97a05c41 100644
--- a/lib/rspdm/lib.rs
+++ b/lib/rspdm/lib.rs
@@ -75,7 +75,28 @@ pub extern "C" fn spdm_create(
 /// Return 0 on success or a negative errno.  In particular, -EPROTONOSUPPORT
 /// indicates authentication is not supported by the device.
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
+        <Pin<KBox<Mutex<SpdmState>>> as ForeignOwnable>::borrow(state_ptr as *mut c_void)
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
index c894cf30bb87..3bbe55d965f7 100644
--- a/lib/rspdm/state.rs
+++ b/lib/rspdm/state.rs
@@ -22,10 +22,14 @@
 use crate::consts::{
     SpdmErrorCode,
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
@@ -37,6 +41,11 @@
 /// run one at a time and the locked `&mut SpdmState` is the only way to
 /// reach the inner fields.
 ///
+/// Concurrent access is serialized by wrapping the whole struct in a
+/// `Mutex<SpdmState>` at the FFI boundary, so `spdm_authenticate()` callers
+/// run one at a time and the locked `&mut SpdmState` is the only way to
+/// reach the inner fields.
+///
 /// `dev`: Responder device.  Used for error reporting and passed to @transport.
 /// `transport`: Transport function to perform one message exchange.
 /// `transport_priv`: Transport private data.
@@ -76,7 +85,6 @@ pub(crate) fn new(
         }
     }
 
-    #[allow(dead_code)]
     fn spdm_err(&self, rsp: &SpdmErrorRsp) -> Result<(), Error> {
         match rsp.error_code {
             SpdmErrorCode::InvalidRequest => {
@@ -188,7 +196,6 @@ fn spdm_err(&self, rsp: &SpdmErrorRsp) -> Result<(), Error> {
     ///
     /// The data in `request_buf` is sent to the device and the response is
     /// stored in `response_buf`.
-    #[allow(dead_code)]
     pub(crate) fn spdm_exchange(
         &self,
         request_buf: &mut [u8],
@@ -238,4 +245,49 @@ pub(crate) fn spdm_exchange(
 
         Ok(length)
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
+        let mut response_vec: KVec<u8> = KVec::from_elem(0u8, SPDM_GET_VERSION_LEN, GFP_KERNEL)?;
+
+        let rc =
+            self.spdm_exchange(request_buf.as_mut_slice(), response_vec.as_mut_slice())? as usize;
+
+        // The transport must report a length within the buffer we provided.
+        if rc > response_vec.len() {
+            return Err(EINVAL);
+        }
+        response_vec.truncate(rc);
+
+        let response: GetVersionRsp = Untrusted::new(response_vec.as_slice()).validate(&*self)?;
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
index b14c066e6a51..d0b6691365c0 100644
--- a/lib/rspdm/validator.rs
+++ b/lib/rspdm/validator.rs
@@ -11,6 +11,7 @@
     consts::SpdmErrorCode,
     SpdmState, //
 };
+use core::mem;
 use kernel::prelude::*;
 use kernel::{
     error::Error,
@@ -20,6 +21,11 @@
     },
 };
 
+use crate::consts::{
+    SPDM_GET_VERSION,
+    SPDM_MIN_VER, //
+};
+
 #[repr(C, packed)]
 pub(crate) struct SpdmHeader {
     pub(crate) version: u8,
@@ -29,7 +35,6 @@ pub(crate) struct SpdmHeader {
 }
 
 impl SpdmHeader {
-    #[expect(dead_code)]
     pub(crate) fn new(code: u8) -> Self {
         SpdmHeader {
             version: 0,
@@ -39,7 +44,6 @@ pub(crate) fn new(code: u8) -> Self {
         }
     }
 
-    #[expect(dead_code)]
     pub(crate) fn to_bytes(&self) -> Result<KVec<u8>> {
         let mut out = KVec::new();
 
@@ -91,3 +95,83 @@ fn validate(unvalidated: &[u8], _context: &'c SpdmState) -> Result<Self, Self::E
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
+    /// Size of the response, not public
+    length: usize,
+}
+
+impl GetVersionRsp {
+    #[expect(dead_code)]
+    pub(crate) fn len(&self) -> usize {
+        self.length
+    }
+}
+
+impl<'a, 'c> Validate<'c, Untrusted<&'a [u8]>> for GetVersionRsp {
+    type Err = Error;
+
+    type Context = &'c SpdmState;
+
+    fn validate(unvalidated: &[u8], context: &'c SpdmState) -> Result<Self, Self::Err> {
+        let header: SpdmHeader =
+            Untrusted::new(unvalidated.get(0..4).ok_or(EIO)?).validate(context)?;
+
+        if header.code != SPDM_GET_VERSION - 0x80 {
+            return Err(EINVAL);
+        }
+
+        if header.version != SPDM_MIN_VER {
+            return Err(EINVAL);
+        }
+
+        let version_number_entry_count = *unvalidated.get(5).ok_or(EIO)?;
+
+        // Entries follow header (4) + reserved (1) + count (1) = 6 bytes.
+        let mut offset = mem::size_of::<SpdmHeader>() + 2;
+
+        let mut version_number_entries = KVec::new();
+        for _ in 0..version_number_entry_count {
+            let entry = u16::from_le_bytes(
+                unvalidated
+                    .get(offset..offset + mem::size_of::<u16>())
+                    .ok_or(EIO)?
+                    .try_into()
+                    .map_err(|_| EINVAL)?,
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
+        })
+    }
+}
-- 
2.55.0

