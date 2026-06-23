Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527A63A7F51
	for <linux-cxl@vger.kernel.org>; Tue, 23 Jun 2026 04:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782190590; cv=none; b=ri9Qh1jUHUA5RAaQDHIrAa9owSli7rM9JJ7W0Ag5S7yWWND10+R4ZJ59FjgPGJUgTUVzjGaf65YVpCXUZI4mFwoA069UpQ8/X1wojKSZG+XGamysv4tb/6+hVPVVadb0i89GIwiVW/T1sR0m+Wo9JdMXCWfxL4qCjYR4mpK9oV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782190590; c=relaxed/simple;
	bh=QgpkLTjKROEjsmhTkLmhJSwUvcTwjTMjJtvE9qxNcGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iZk0TLJrUKUFLZLRgo9pNJ14ddZHMa+Lx7EIS2D4AHaGhNSviR4nH7F/7PnJJaCdr1McrJ/c0JBxflJ209eSx1WLHyZp+ugfyJhyZnE3nXqR8NGYSUyvicoS0Ke9UCG/sap0171G+cdIEqiBHUPyZaCSEp946Y+ZAjj99dfduwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dB93iAG9; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dB93iAG9"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-36ba706ab46so2826885a91.1
        for <linux-cxl@vger.kernel.org>; Mon, 22 Jun 2026 21:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782190588; x=1782795388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vC3SpOvLTID7h2+3q7I+wdCKHbi2EUd9xk89i86eAr0=;
        b=dB93iAG91mJAJXJ1r1yPtcroqC+bydwBjRvUXfvdJzI8PO5OwwC/C9VHyzpsr3Fr69
         ODWZ77CSdGryAMJL690X9qqXIf3ruKu1DV6DIFwYsKhPZS/AG8uhkZlM81JS9RFpxyza
         1v1lsQsPUlrOWNKoAUT8Igx9RPkgM6ffG/lXHS4PdzuluRpsE9HzMqsL6krhvu+byYht
         VxIpD5vFKfk0tVc6RNMerwCzd58wWCUcbTe0eooIh0v0IJ126CYRs/Ao9fR2Mxe062i6
         zmeBuXngdZvYvXCuwh7KQ1aoNA1mULuGxSyzmfZbZa5tGAAY0XElMax6ldkBwch7qOkT
         q3Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782190588; x=1782795388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vC3SpOvLTID7h2+3q7I+wdCKHbi2EUd9xk89i86eAr0=;
        b=WLNz98zshetf+gGuHCmBHDFqHZMQ2rXcLXxK0ZWPa+icMXGBAVoZWgGZxcMrj/p+L1
         7w5rcqYjUGMjnz32pN/zgv01ZUE+aWzLtLyTDcuzkbGpjbSPcC2fGFi0lYb+gVs5aEbn
         DBIsYwUsb/YJiRD9YIpvAXmRKK8t/QZk8qDNpp6cfd0DFK5r3C6iMZWYPLdPbFCnFhVP
         gEhS/KsBPyrdZGJyR5pLY+sSeX6QNa6AQKxYp5ms2egSigH2G6L2HZ5I/QifxTAGxCZs
         xRYFi4zt8f9eUphjPUkKjmcUc1XQf0EZZ69yQyku4MCylQoziqOIntMiL8jHnuIPQI0w
         xNbg==
X-Forwarded-Encrypted: i=1; AHgh+Rq173bs2O9cur4MEzvJAciY64ZxKsRWgICt1hkbZyNktR+p5XCPztHGofBk9zCXWxp5WJvIR3R1Hnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwIn0odqR7ybvZttKYIax2qhweEEHX7XoVbD6lrDgDcD+cYpz+
	wrkXYzTz6/2fL+Fi1bj2k3pQKDIA8Hzo8XW1gwVQJdB93j7JJvMCt5IJ
X-Gm-Gg: AfdE7ckNT05I8cy1Afk8RohTQcKJc932u7ck6KXiueT8+BE/LjJnLj0I/hNQB8708NS
	FUTUb8ZTfDx2CV1AtOE0BKR5lBcbKbjOA7X5FrIHU4Si4SEFYOjw99yeXhILXh0ErC7wDApwRz1
	r/4e50jA+k6SF+n8yIrFNXCUvOccwilSipbYYnYern1PZsn/ctRn7+Awo6vmZaQPk9dvfyyyhcS
	jql0GG+agpKniWqDzrJyRAqxCRqY2GTzbdMVTJH08fpuQbtboSKFJcIHRLgs9zrYpBtI+fsfSzy
	RDK3gqiSrUyLQjrxgTpis4abhoXIowoCiwA0zBy4LfHQmTicjOxtvQ4u0pOI8Mi58HLNiKDpqvv
	xjdu6+vrlMnHN251b78/eY5l4NZcbvlvUgXxYvAVhA1DhjtuVaPzBs3G9czLsddylPTnUhrZoYS
	yfXa8gLiPAXlm5DVKG2cOZ58MioPQvGQ==
X-Received: by 2002:a17:903:2f84:b0:2c6:a99a:52a9 with SMTP id d9443c01a7336-2c718cc243bmr199990305ad.7.1782190588540;
        Mon, 22 Jun 2026 21:56:28 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7439f8cf0sm89734785ad.50.2026.06.22.21.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 21:56:27 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: akpm@linux-foundation.org,
	rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org,
	jic23@kernel.org,
	bhelgaas@google.com,
	lukas@wunner.de,
	alistair@alistair23.me,
	linux-cxl@vger.kernel.org,
	djbw@kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan.Cameron@huawei.com
Cc: alistair23@gmail.com,
	boqun.feng@gmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	bjorn3_gh@protonmail.com,
	gary@garyguo.net,
	wilfred.mallawa@wdc.com,
	aliceryhl@google.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	tmgross@umich.edu
Subject: [PATCH v2 14/21] lib: rspdm: Support SPDM get_version
Date: Tue, 23 Jun 2026 14:53:59 +1000
Message-ID: <20260623045406.2589547-15-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623045406.2589547-1-alistair.francis@wdc.com>
References: <20260623045406.2589547-1-alistair.francis@wdc.com>
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
---
 lib/rspdm/consts.rs    | 16 ++++++++--
 lib/rspdm/lib.rs       | 54 +++++++++++++++++++++++++++------
 lib/rspdm/state.rs     | 67 ++++++++++++++++++++++++++++++++++++++--
 lib/rspdm/validator.rs | 69 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 192 insertions(+), 14 deletions(-)

diff --git a/lib/rspdm/consts.rs b/lib/rspdm/consts.rs
index 01f008958a1f..055671d43abd 100644
--- a/lib/rspdm/consts.rs
+++ b/lib/rspdm/consts.rs
@@ -7,16 +7,24 @@
 //! Rust implementation of the DMTF Security Protocol and Data Model (SPDM)
 //! <https://www.dmtf.org/dsp/DSP0274>
 
+use crate::validator::GetVersionRsp;
+use core::mem;
 use kernel::error::{code::EINVAL, Error};
 
 // SPDM versions supported by this implementation
 pub(crate) const SPDM_VER_10: u8 = 0x10;
+#[allow(dead_code)]
+pub(crate) const SPDM_VER_11: u8 = 0x11;
+#[allow(dead_code)]
+pub(crate) const SPDM_VER_12: u8 = 0x12;
+#[allow(dead_code)]
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
+    mem::size_of::<GetVersionRsp>() + (u8::MAX as usize) * mem::size_of::<u16>();
diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
index 1883579b817a..58d86ea06fd9 100644
--- a/lib/rspdm/lib.rs
+++ b/lib/rspdm/lib.rs
@@ -18,8 +18,10 @@
     c_int,
     c_void, //
 };
+use core::pin::Pin;
 use core::ptr;
 use kernel::prelude::*;
+use kernel::sync::{new_mutex, Mutex};
 use kernel::{
     alloc::flags,
     bindings, //
@@ -51,11 +53,22 @@ pub extern "C" fn spdm_create(
     transport_sz: u32,
     validate: bindings::spdm_validate,
 ) -> *mut spdm_state {
-    match KBox::new(
-        SpdmState::new(dev, transport, transport_priv, transport_sz, validate),
-        flags::GFP_KERNEL,
-    ) {
-        Ok(ret) => KBox::into_raw(ret) as *mut spdm_state,
+    // Wrap the `SpdmState` in a `Mutex` so that concurrent FFI callers (for
+    // example, two threads racing on `spdm_authenticate()` for the same
+    // device) serialize on the lock and never form aliased `&mut SpdmState`
+    // references.
+    let state = SpdmState::new(dev, transport, transport_priv, transport_sz, validate);
+    match KBox::pin_init(new_mutex!(state), flags::GFP_KERNEL) {
+        Ok(b) => {
+            // `Mutex<SpdmState>` is `!Unpin` and must remain pinned in
+            // memory.  The C side stores the raw pointer; `spdm_destroy()`
+            // re-pins via `Pin::new_unchecked` before dropping, preserving
+            // the pin invariant.
+            // SAFETY: The contents are not moved between here and the
+            // matching `KBox::from_raw` in `spdm_destroy()`.
+            let raw = KBox::into_raw(unsafe { Pin::into_inner_unchecked(b) });
+            raw as *mut spdm_state
+        }
         Err(_) => ptr::null_mut(),
     }
 }
@@ -70,7 +83,25 @@ pub extern "C" fn spdm_create(
 /// Return 0 on success or a negative errno.  In particular, -EPROTONOSUPPORT
 /// indicates authentication is not supported by the device.
 #[export]
-pub extern "C" fn spdm_authenticate(_state_ptr: *mut spdm_state) -> c_int {
+pub extern "C" fn spdm_authenticate(state_ptr: *mut spdm_state) -> c_int {
+    if state_ptr.is_null() {
+        return -(bindings::EINVAL as c_int);
+    }
+
+    // SAFETY: `state_ptr` was returned from `spdm_create()` (which leaks a
+    // `Pin<KBox<Mutex<SpdmState>>>`) and has not yet been passed to
+    // `spdm_destroy()`.  We only form a shared reference to the mutex; the
+    // exclusive `&mut SpdmState` lives entirely inside the lock guard, so
+    // concurrent FFI callers serialize on the mutex and can never form
+    // aliased `&mut SpdmState` references.
+    let mutex: &Mutex<SpdmState> = unsafe { &*(state_ptr as *const Mutex<SpdmState>) };
+
+    let mut state = mutex.lock();
+
+    if let Err(e) = state.get_version() {
+        return e.to_errno() as c_int;
+    }
+
     -(EPROTONOSUPPORT as i32)
 }
 
@@ -82,8 +113,11 @@ pub extern "C" fn spdm_destroy(state_ptr: *mut spdm_state) {
     if state_ptr.is_null() {
         return;
     }
-    // SAFETY: `state_ptr` was returned from `spdm_create` (which uses
-    // `KBox::into_raw`) and the caller guarantees the state is no longer
-    // in use.  Reconstructing the `KBox` and dropping it frees the state.
-    drop(unsafe { KBox::from_raw(state_ptr as *mut SpdmState) });
+    // SAFETY: `state_ptr` was returned from `spdm_create()`, which leaked a
+    // `Pin<KBox<Mutex<SpdmState>>>` via `KBox::into_raw`.  The caller
+    // guarantees the state is no longer in use.  Reconstructing the pinned
+    // box and dropping it runs `Drop` for the `Mutex` and `SpdmState` and
+    // frees the allocation.
+    let b = unsafe { KBox::from_raw(state_ptr as *mut Mutex<SpdmState>) };
+    drop(unsafe { Pin::new_unchecked(b) });
 }
diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
index e1f74d19ac4b..9e8c65a12199 100644
--- a/lib/rspdm/state.rs
+++ b/lib/rspdm/state.rs
@@ -8,6 +8,7 @@
 //! <https://www.dmtf.org/dsp/DSP0274>
 
 use core::ffi::c_void;
+use core::slice::from_raw_parts_mut;
 use kernel::prelude::*;
 use kernel::{
     bindings,
@@ -22,10 +23,14 @@
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
@@ -33,6 +38,11 @@
 /// The current SPDM session state for a device. Based on the
 /// C `struct spdm_state`.
 ///
+/// Concurrent access is serialized by wrapping the whole struct in a
+/// `Mutex<SpdmState>` at the FFI boundary, so `spdm_authenticate()` callers
+/// run one at a time and the locked `&mut SpdmState` is the only way to
+/// reach the inner fields.
+///
 /// `dev`: Responder device.  Used for error reporting and passed to @transport.
 /// `transport`: Transport function to perform one message exchange.
 /// `transport_priv`: Transport private data.
@@ -72,7 +82,6 @@ pub(crate) fn new(
         }
     }
 
-    #[allow(dead_code)]
     fn spdm_err(&self, rsp: &SpdmErrorRsp) -> Result<(), Error> {
         match rsp.error_code {
             SpdmErrorCode::InvalidRequest => {
@@ -184,7 +193,6 @@ fn spdm_err(&self, rsp: &SpdmErrorRsp) -> Result<(), Error> {
     ///
     /// The data in `request_buf` is sent to the device and the response is
     /// stored in `response_buf`.
-    #[allow(dead_code)]
     pub(crate) fn spdm_exchange(
         &self,
         request_buf: &mut [u8],
@@ -234,4 +242,59 @@ pub(crate) fn spdm_exchange(
 
         Ok(length)
     }
+
+    /// Negotiate a supported SPDM version and store the information
+    /// in the `SpdmState`.
+    pub(crate) fn get_version(&mut self) -> Result<(), Error> {
+        let mut request = GetVersionReq::default();
+        request.version = SPDM_MIN_VER;
+        self.version = SPDM_MIN_VER;
+
+        // SAFETY: `request` is repr(C) and packed, so we can convert it to a slice
+        let request_buf = unsafe {
+            from_raw_parts_mut(
+                &mut request as *mut _ as *mut u8,
+                core::mem::size_of::<GetVersionReq>(),
+            )
+        };
+
+        let mut response_vec: KVec<u8> = KVec::from_elem(0u8, SPDM_GET_VERSION_LEN, GFP_KERNEL)?;
+
+        let rc = self.spdm_exchange(request_buf, response_vec.as_mut_slice())? as usize;
+
+        // The transport must report a length within the buffer we provided.
+        if rc > response_vec.len() {
+            return Err(EINVAL);
+        }
+        response_vec.truncate(rc);
+
+        let response: &GetVersionRsp = Untrusted::new(response_vec.as_slice()).validate()?;
+
+        let mut foundver = false;
+        let entry_count = response.version_number_entry_count;
+        let entries_offset = core::mem::offset_of!(GetVersionRsp, version_number_entries);
+
+        for i in 0..entry_count as usize {
+            let off = entries_offset + i * core::mem::size_of::<u16>();
+            let entry = u16::from_le_bytes([response_vec[off], response_vec[off + 1]]);
+            let alpha_version = (entry & 0xF) as u8;
+            let version = (entry >> 8) as u8;
+
+            if alpha_version > 0 {
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
index ca853d5aa473..4570b5f41f8c 100644
--- a/lib/rspdm/validator.rs
+++ b/lib/rspdm/validator.rs
@@ -7,6 +7,10 @@
 //! Rust implementation of the DMTF Security Protocol and Data Model (SPDM)
 //! <https://www.dmtf.org/dsp/DSP0274>
 
+use crate::bindings::{
+    __IncompleteArrayField,
+    __le16, //
+};
 use crate::consts::SpdmErrorCode;
 use core::mem;
 use kernel::prelude::*;
@@ -21,6 +25,11 @@
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
@@ -90,3 +99,63 @@ fn validate(unvalidated: &[u8]) -> Result<Self, Self::Err> {
         Ok(unsafe { &*ptr })
     }
 }
+
+#[repr(C, packed)]
+pub(crate) struct GetVersionReq {
+    pub(crate) version: u8,
+    pub(crate) code: u8,
+    pub(crate) param1: u8,
+    pub(crate) param2: u8,
+}
+
+impl Default for GetVersionReq {
+    fn default() -> Self {
+        GetVersionReq {
+            version: 0,
+            code: SPDM_GET_VERSION,
+            param1: 0,
+            param2: 0,
+        }
+    }
+}
+
+#[repr(C, packed)]
+pub(crate) struct GetVersionRsp {
+    pub(crate) version: u8,
+    pub(crate) code: u8,
+    param1: u8,
+    param2: u8,
+    reserved: u8,
+    pub(crate) version_number_entry_count: u8,
+    pub(crate) version_number_entries: __IncompleteArrayField<__le16>,
+}
+
+impl Validate<Untrusted<&[u8]>> for &GetVersionRsp {
+    type Err = Error;
+
+    fn validate(unvalidated: &[u8]) -> Result<Self, Self::Err> {
+        if unvalidated.len() < mem::size_of::<GetVersionRsp>() {
+            return Err(EINVAL);
+        }
+
+        let version = *(unvalidated.get(0).ok_or(ENOMEM))? as usize;
+        if version != SPDM_MIN_VER.into() {
+            return Err(EINVAL);
+        }
+
+        let version_number_entries = *(unvalidated.get(5).ok_or(ENOMEM))? as usize;
+        let total_expected_size =
+            version_number_entries * mem::size_of::<__le16>() + mem::size_of::<GetVersionRsp>();
+        if unvalidated.len() < total_expected_size {
+            return Err(EINVAL);
+        }
+
+        let ptr = unvalidated.as_ptr();
+        // CAST: `GetVersionRsp` only contains integers and has `repr(C)`.
+        let ptr = ptr.cast::<GetVersionRsp>();
+        // SAFETY: `ptr` came from a reference and the cast above is valid.
+        let rsp: &GetVersionRsp = unsafe { &*ptr };
+
+        Ok(rsp)
+    }
+}
-- 
2.54.0

