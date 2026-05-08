Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26C52F0680
	for <linux-cxl@vger.kernel.org>; Fri,  8 May 2026 03:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778210333; cv=none; b=KIDdrCFUYSgbVzvLVL0CKPpzl8+WUfvJ4m+7GTQSYxajMO+I4Qj3EFdR769oqTXzIW12yKJMGyHK7+UFiSXJDob9coXImWShAgav52kS+tw4UI0LVYNpBXTREZ7riy6IBY5gyQ0PSKRjGAMJcbBmNWZzaLqbkNUPz+Ffu1D5n/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778210333; c=relaxed/simple;
	bh=oxNrGjcZCazizcSxSSIR96HPVNGWilr6D9NtWMsT9rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gxFm4SKDEbAu3Q4b3uCtqM2k7hGPbERs1zapTqgFRWOefUoULJPWawSxgPOTviRdtWUsnb2XlU6uUXJlau9d3YdDPz0g/JGck+eRTmZVBLk1b3k9aWLoUmXbAMN1xnD2XeEifJB7TbANXcRnnbNQs5s5xQUSQz5wWU02rVSJ3I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a+a6o51L; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+a6o51L"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ad9a9be502so8903295ad.0
        for <linux-cxl@vger.kernel.org>; Thu, 07 May 2026 20:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778210327; x=1778815127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sdaY8XVDz6HV3abuC4HHO5UewMGlDvcsArdslgC4GX0=;
        b=a+a6o51LnORkrj8YRpE5Xy8JhOmLgr/EPwjAL1nxVAAUF7J/76zW8cfLLpMBpc+jns
         XcNxlEblsg+g11U2adOV+fhOn2uS9A6CY3/bNdrFONHCmqaIAsgl0q/hr5WfpCg8bM5b
         6vf/vijWohGSxuTGnjTDAbGb0ACVYYMjaGSu0RObcl2b5X+i20WV80p62/qFMKtB6821
         RRr5M3CCWanHzG5v+6a+O1729SgJnff7wzrEFHwSxKZetRdHfXOAhzH2ojVYlwoIoJ2a
         0QMvd14MRAivzBwj11Ad1oHAyb9kYXAvUf8hmH9dkE1ixQNdqyt0N1XL+SmuK+9NffPp
         NNlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778210327; x=1778815127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sdaY8XVDz6HV3abuC4HHO5UewMGlDvcsArdslgC4GX0=;
        b=XvbvE9+fbgPFkhbsCcEYASocXIZxdr3FBY7YR/sjmnN6ncjaZyqG7MNsuqh1wLunGi
         gg45g4HGl1HkGgCdivkMLy2gGL227AxDcPEc3GSmVopjCM04FW09AiXvXkdcweU8iaPM
         unlCEPCu417zlH7yRJv9jGP2arbTODutsOdiHgWhT95g3EJWnEcyYaaPd/e/fX54zUWt
         biaSlQjeEooqgoPyzZHse1Ab0Ps42M+pDV8w+vlL8+LUaYkjEszWDloARaM7mw+2+u6x
         c9T3XbEglayjcEUVhTl/2AhiqZY/EcR166mjm3xHnni/MgOmZ5HVxOvKEP3kAwRFTE9i
         hhiA==
X-Forwarded-Encrypted: i=1; AFNElJ+M4lQC6sDqN/KNMaFHNUkYfOXH5JR6fIVN/jDcc6OzbB0oA7Iz4qaUepufQx3SgEotEqZFRW7aeyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9D0ZxLDI6ykjIN5gxS/Y/6GdQOaygyAiMD3hveP+EzM4YUYFw
	Llf/yqbmKJNTcwY5FOcrkVJtRZvav93mmHpqjU6ew6etppT9TnCSOAbF
X-Gm-Gg: Acq92OF3IOadWWmxGXfsC+sLqJAU44ddxh4NYiJD4dthmdpi25saoll3W1pow7vuZPP
	qDRkC2VtNVIlGZi1aZXWtUCTMVBZt13wYvgSekxnVHZNuUBARd0kXx0husRxJJdfam8AqVJ4nRE
	CUlVv20WWSH0dii81IoucsChkSK/Chjbt/8TbNsF/Mw6i4++qKw+DWPJGV0NRQh9OPfYSKeYsZZ
	i3Uxgx7aRelkTbmDTeL4VdLFfwI1662X973JGnCbECgKUh5fZfGnqTifZncppxX4Rjz3I+X1j82
	pMej2UxiGw02CsZznASB0GUqG8UBY90a1r7B+83SD6NLXQ8fUQs/GToQFfFNf+y1DUAhlUdF5rG
	fAQGbU1WyKkhbSyg6Hyd6EZGXbQsXSzl0pmKvuSTFm0Zp1n2j/lAAXNvyEfK/wMCmY1w7bAaI5t
	sbz0yiE2GMLdOb3sQ7FpRX7uBipu+Q4FJmLoExxAV/
X-Received: by 2002:a17:903:1af0:b0:2ad:bd4c:a5 with SMTP id d9443c01a7336-2ba78f63c82mr112714875ad.1.1778210327123;
        Thu, 07 May 2026 20:18:47 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1eafa62sm3220685ad.74.2026.05.07.20.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 20:18:46 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: alistair@alistair23.me,
	linux-kernel@vger.kernel.org,
	lukas@wunner.de,
	Jonathan.Cameron@huawei.com,
	bhelgaas@google.com,
	rust-for-linux@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-cxl@vger.kernel.org,
	djbw@kernel.org,
	linux-pci@vger.kernel.org
Cc: alex.gaynor@gmail.com,
	wilfred.mallawa@wdc.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	aliceryhl@google.com,
	boqun.feng@gmail.com,
	a.hindborg@kernel.org,
	tmgross@umich.edu,
	ojeda@kernel.org,
	alistair23@gmail.com
Subject: [PATCH 11/18] lib: rspdm: Support SPDM get_version
Date: Fri,  8 May 2026 13:17:03 +1000
Message-ID: <20260508031710.514574-12-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260508031710.514574-1-alistair.francis@wdc.com>
References: <20260508031710.514574-1-alistair.francis@wdc.com>
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
 lib/rspdm/consts.rs    | 14 +++++++++
 lib/rspdm/lib.rs       |  8 ++++-
 lib/rspdm/state.rs     | 61 ++++++++++++++++++++++++++++++++++++
 lib/rspdm/validator.rs | 70 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 152 insertions(+), 1 deletion(-)

diff --git a/lib/rspdm/consts.rs b/lib/rspdm/consts.rs
index 2feddde67885..5482a0f6cee0 100644
--- a/lib/rspdm/consts.rs
+++ b/lib/rspdm/consts.rs
@@ -7,10 +7,21 @@
 //! Rust implementation of the DMTF Security Protocol and Data Model (SPDM)
 //! <https://www.dmtf.org/dsp/DSP0274>
 
+use crate::validator::SpdmHeader;
+use core::mem;
+
 /* SPDM versions supported by this implementation */
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
 
 pub(crate) const SPDM_REQ: u8 = 0x80;
 pub(crate) const SPDM_ERROR: u8 = 0x7f;
@@ -54,3 +65,6 @@ fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
         Ok(())
     }
 }
+
+pub(crate) const SPDM_GET_VERSION: u8 = 0x84;
+pub(crate) const SPDM_GET_VERSION_LEN: usize = mem::size_of::<SpdmHeader>() + u8::MAX as usize;
diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
index 758d43fba5cb..1cc6c33516fb 100644
--- a/lib/rspdm/lib.rs
+++ b/lib/rspdm/lib.rs
@@ -105,7 +105,13 @@
 /// Return 0 on success or a negative errno.  In particular, -EPROTONOSUPPORT
 /// indicates authentication is not supported by the device.
 #[export]
-pub unsafe extern "C" fn spdm_authenticate(_state_ptr: *mut spdm_state) -> c_int {
+pub unsafe extern "C" fn spdm_authenticate(state_ptr: *mut spdm_state) -> c_int {
+    let state: &mut SpdmState = unsafe { &mut (*(state_ptr as *mut SpdmState)) };
+
+    if let Err(e) = state.get_version() {
+        return e.to_errno() as c_int;
+    }
+
     0
 }
 
diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
index 18e81f24c724..26b90942b298 100644
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
@@ -232,4 +237,60 @@ pub(crate) fn spdm_exchange(
 
         Ok(length)
     }
+
+    /// Negotiate a supported SPDM version and store the information
+    /// in the `SpdmState`.
+    pub(crate) fn get_version(&mut self) -> Result<(), Error> {
+        let mut request = GetVersionReq::default();
+        request.version = self.version;
+
+        // SAFETY: `request` is repr(C) and packed, so we can convert it to a slice
+        let request_buf = unsafe {
+            from_raw_parts_mut(
+                &mut request as *mut _ as *mut u8,
+                core::mem::size_of::<GetVersionReq>(),
+            )
+        };
+
+        let mut response_vec: KVec<u8> = KVec::with_capacity(SPDM_GET_VERSION_LEN, GFP_KERNEL)?;
+        // SAFETY: `response_vec` is SPDM_GET_VERSION_LEN length, initialised, aligned
+        // and won't be mutated
+        let response_buf =
+            unsafe { from_raw_parts_mut(response_vec.as_mut_ptr(), SPDM_GET_VERSION_LEN) };
+
+        let rc = self.spdm_exchange(request_buf, response_buf)?;
+
+        // SAFETY: `rc` is the length of data read, which will be smaller
+        // than the capacity of the vector
+        unsafe { response_vec.inc_len(rc as usize) };
+
+        let response: &mut GetVersionRsp = Untrusted::new_mut(&mut response_vec).validate_mut()?;
+
+        let mut foundver = false;
+        let unaligned = core::ptr::addr_of_mut!(response.version_number_entries) as *mut u16;
+
+        for i in 0..response.version_number_entry_count {
+            // Creating a reference on a packed struct will result in
+            // undefined behaviour, so we operate on the raw data directly
+            let addr = unaligned.wrapping_add(i as usize);
+            let alpha_version = (unsafe { core::ptr::read_unaligned::<u16>(addr) } & 0xF) as u8;
+            let version = (unsafe { core::ptr::read_unaligned::<u16>(addr) } >> 8) as u8;
+
+            if alpha_version > 0 {
+                pr_warn!("Alpha version {alpha_version} is unsupported\n");
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
+            to_result(-(bindings::EPROTO as i32))?;
+        }
+
+        Ok(())
+    }
 }
diff --git a/lib/rspdm/validator.rs b/lib/rspdm/validator.rs
index 58039f532b7d..8f45bafd4d69 100644
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
@@ -71,3 +80,64 @@ pub(crate) struct SpdmErrorRsp {
     pub(crate) error_code: SpdmErrorCode,
     pub(crate) error_data: u8,
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
+impl Validate<&mut Unvalidated<KVec<u8>>> for &mut GetVersionRsp {
+    type Err = Error;
+
+    fn validate(unvalidated: &mut Unvalidated<KVec<u8>>) -> Result<Self, Self::Err> {
+        let raw = unvalidated.raw_mut();
+        if raw.len() < mem::size_of::<GetVersionRsp>() {
+            return Err(EINVAL);
+        }
+
+        let version = *(raw.get(0).ok_or(ENOMEM))? as usize;
+        if version != SPDM_MIN_VER.into() {
+            return Err(EINVAL);
+        }
+
+        let version_number_entries = *(raw.get(5).ok_or(ENOMEM))? as usize;
+        let total_expected_size =
+            version_number_entries * mem::size_of::<__le16>() + mem::size_of::<GetVersionRsp>();
+        if raw.len() < total_expected_size {
+            return Err(EINVAL);
+        }
+
+        let ptr = raw.as_mut_ptr();
+        // CAST: `GetVersionRsp` only contains integers and has `repr(C)`.
+        let ptr = ptr.cast::<GetVersionRsp>();
+        // SAFETY: `ptr` came from a reference and the cast above is valid.
+        let rsp: &mut GetVersionRsp = unsafe { &mut *ptr };
+
+        Ok(rsp)
+    }
+}
-- 
2.52.0

