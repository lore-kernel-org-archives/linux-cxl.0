Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E393A9018
	for <linux-cxl@vger.kernel.org>; Tue, 23 Jun 2026 04:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782190626; cv=none; b=AVS2cO4eN2Io2SgHyd3N18M0XiCqgZtMpyAOktvwj/U4mCKq09oO4oEWWzf8qsRnW9+SlBfVZ2OraPXkeSTuATosRSwF7nlk30onOT1vgIxMiCkyQ6QZH2aM1cYuRSbrdpy61VWo5FVt5yLEOV6RFP6B3XoMpkzstcr0h0g9y9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782190626; c=relaxed/simple;
	bh=sBpR4JQ88I3PDGrLJFDK356imYHMyhsXTGvnvbmZQac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O1t+4Kj/IjNs+dQNRtkhatSqyKHFnNSBPGFi4pjp0kdnmz9GLJubM4axjUpATX2Y47HsBnUPDo3sdC9a61CiU8DMmFCqRIq2POYvFUt9Cqnnqvzn1Ns6cirUxGB1AZA+P6FHfRfJrQ9Z92w5dMmZfDj8NFt3iXkcgL5oHVFQxRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLuTwvLD; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLuTwvLD"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-36b900f350fso4782160a91.0
        for <linux-cxl@vger.kernel.org>; Mon, 22 Jun 2026 21:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782190624; x=1782795424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=drzKMbtY3d2JRD2m95+FREql9WlTcjSX9aCDfh4Eqhw=;
        b=gLuTwvLDPR51ylYrHqZgfVR7KYls/UoZYWEzHzlAlzeoN7e+KxixynK5MzAD1RYatz
         ElRCkKvn/4RdMWcAwc4IVZy8NVNkHKMEe7pgcXNhUhnQb651G25wsgKfp3a7LMy/6gHf
         rGaB0/BtxhV8G1uZnfqI4WUDPV5d901WBlMlxUsQL4gKUpmZBIF4y0aK+LxHFD+JS2jB
         ydQOBbiB1pKbGr3SJeOgJZ8y0k2282NrY4X5F8Uu6sKEnsHfPFREPPU4xwV/w62xGe1N
         30ogX0NBt9hErsMKF6P1QzIYk6Eg5ClpR/tAjslsyHKNucM3yrY08ucaLTC/GM24kDsS
         Px6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782190624; x=1782795424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=drzKMbtY3d2JRD2m95+FREql9WlTcjSX9aCDfh4Eqhw=;
        b=ZbLhi7khAqBCBrRVt+2MWh6E4/lIxaaiN1SBC3agBOuAe9+02mw4ECAp+o2hKrom0l
         m72Sy/FH5QrNLxtCfU3Spm4CrGhvgJ401F4DDwec0EaNecmrPesbf/nx2RGpaKT7iw7y
         hNvzqs/WT3MbBoqtkRqaDc5OHdek0zFjZJ9wvtwgjF+VDetsF4zfcaotMlJlwldK30VX
         lWRSjWDrKsdK0xi7tL6eb5yADiQEvql8SdavjRNKmjEgG0zlaGQt95/eIK7JCGsOUScM
         zOQFMGLV33MEnnL7j0hZC9KmkvjkU+uudB6M1e3suFdKV/FZi9HdDOIqLW9YENZxdA3T
         fMDA==
X-Forwarded-Encrypted: i=1; AHgh+RpIz6SI0taQ6GzUhfLFPYFSVYiOJ/Taesu6182pcw4zb9CwvtGsSNu986ZoVjveTldE+pRDp4Bf/eg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7iDev+vnbCXkJTW/P31BBmld0i0MHuFIU7lOqekel4irQDd6j
	yRWAGF2N6FTOM+UeP9HtADBhLX3kKzzb5jLaZYQ0Ojj13noyeXDrrbdx
X-Gm-Gg: AfdE7cnVLSzG00CoCMzJZB59IoMeBtndf+SX1lttYi/3oSK9xDZSLwfhaWl0k/jThY4
	nyFYLDy93n4VOSBNqvmbEMSsvfbI0FOxABH7KHmoeILGzzd5ccG9UgUgGDq8zA0tNBcTjXLBkkh
	ck2JEhr2KYKmjb8xHsz6u6Cs67uLgumnHtGtPLQtzJsVPRcEMiLz4cC13FB9/Tt0JhQA2e0Pkyq
	au4LWF89QdVwugpjCCEnxzkWmtneQM+yICf9i0kg9zelv5lRZAj8PqpfMYApVALbXY8iyibZfAE
	95kKubAUrab6BxNQBdz0QV1aKibeigmIWw+J3o4PxlTyoGVvzLmftl9YCn68jxq8BDZPrR8Xz+v
	N80ughZ3KvY2ACwMLEyYdtpjFzvGoUn5UYz2h6Y+CysRyIpDQvaosuslLkvMBMiFqhwUZgniedf
	gCOur5nJxGVX6ArjzoD20dXT3RB4ZU6w==
X-Received: by 2002:a17:902:e74f:b0:2c6:e1f7:b4ce with SMTP id d9443c01a7336-2c7c9a2a093mr7558305ad.28.1782190624222;
        Mon, 22 Jun 2026 21:57:04 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7439f8cf0sm89734785ad.50.2026.06.22.21.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 21:57:03 -0700 (PDT)
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
Subject: [PATCH v2 18/21] lib: rspdm: Support SPDM get_certificate
Date: Tue, 23 Jun 2026 14:54:03 +1000
Message-ID: <20260623045406.2589547-19-alistair.francis@wdc.com>
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

Support the GET_CERTIFICATE SPDM command.

The kernel will send a GET_CERTIFICATE request to the the responder and
then iterate over all of the certificates returned.

Certificate validation happens in the next commit.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 lib/rspdm/consts.rs    |   2 +
 lib/rspdm/lib.rs       |  15 +++++
 lib/rspdm/state.rs     | 145 +++++++++++++++++++++++++++++++++++++++++
 lib/rspdm/validator.rs |  56 ++++++++++++++++
 4 files changed, 218 insertions(+)

diff --git a/lib/rspdm/consts.rs b/lib/rspdm/consts.rs
index c4d9521866af..2fbc4ab41869 100644
--- a/lib/rspdm/consts.rs
+++ b/lib/rspdm/consts.rs
@@ -146,6 +146,8 @@ fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
 
 pub(crate) const SPDM_GET_DIGESTS: u8 = 0x81;
 
+pub(crate) const SPDM_GET_CERTIFICATE: u8 = 0x82;
+
 // If the crypto support isn't enabled don't offer the algorithms
 // to the responder
 #[cfg(CONFIG_CRYPTO_RSA)]
diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
index bda5f91ca13c..488203be821d 100644
--- a/lib/rspdm/lib.rs
+++ b/lib/rspdm/lib.rs
@@ -114,6 +114,21 @@ pub extern "C" fn spdm_authenticate(state_ptr: *mut spdm_state) -> c_int {
         return e.to_errno() as c_int;
     }
 
+    if state.provisioned_slots == 0 {
+        return -(bindings::EIO as c_int);
+    }
+
+    let mut provisioned_slots = state.provisioned_slots;
+    while (provisioned_slots as usize) > 0 {
+        let slot = provisioned_slots.trailing_zeros() as u8;
+
+        if let Err(e) = state.get_certificate(slot) {
+            return e.to_errno() as c_int;
+        }
+
+        provisioned_slots &= !(1 << slot);
+    }
+
     -(EPROTONOSUPPORT as i32)
 }
 
diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
index 055f37289c8b..9138df30e138 100644
--- a/lib/rspdm/state.rs
+++ b/lib/rspdm/state.rs
@@ -53,6 +53,8 @@
 use crate::validator::{
     GetCapabilitiesReq,
     GetCapabilitiesRsp,
+    GetCertificateReq,
+    GetCertificateRsp,
     GetDigestsReq,
     GetDigestsRsp,
     GetVersionReq,
@@ -157,6 +159,17 @@ fn drop(&mut self) {
     }
 }
 
+#[repr(C, packed)]
+pub(crate) struct SpdmCertChain {
+    // `length` is a u16 (with 2 bytes reserved) for SPDM versions 1.3
+    // and lower and u32 for 1.4. We don't currently support `LargeOffset`
+    // and `LargeLength`, so let's pretend this is always a u16
+    length: u16,
+    _reserved: [u8; 2],
+    root_hash: bindings::__IncompleteArrayField<u8>,
+    certificates: bindings::__IncompleteArrayField<u8>,
+}
+
 impl SpdmState<'_> {
     pub(crate) fn new(
         dev: *mut bindings::device,
@@ -686,4 +699,136 @@ pub(crate) fn get_digests(&mut self) -> Result<(), Error> {
 
         Ok(())
     }
+
+    fn get_cert_exchange(
+        &mut self,
+        request_buf: &mut [u8],
+        response_vec: &mut KVec<u8>,
+    ) -> Result<&GetCertificateRsp, Error> {
+        let len = self.spdm_exchange(request_buf, response_vec.as_mut_slice())? as usize;
+
+        // The transport must report a length within the buffer we provided.
+        if len < core::mem::size_of::<GetCertificateRsp>() {
+            pr_err!("Truncated certificate response\n");
+            return Err(EIO);
+        }
+        if len > response_vec.len() {
+            pr_err!("Overflowed get certificate response\n");
+            return Err(EIO);
+        }
+        response_vec.truncate(len);
+
+        let response: &GetCertificateRsp = Untrusted::new(response_vec.as_slice()).validate()?;
+
+        if len
+            < core::mem::size_of::<GetCertificateRsp>()
+                + u16::from_le(response.portion_length) as usize
+        {
+            pr_err!("Truncated certificate response\n");
+            return Err(EIO);
+        }
+
+        Ok(response)
+    }
+
+    pub(crate) fn get_certificate(&mut self, slot: u8) -> Result<(), Error> {
+        let mut request = GetCertificateReq::default();
+        request.version = self.version;
+        request.param1 = slot;
+
+        let req_sz = core::mem::size_of::<GetCertificateReq>();
+        let rsp_sz = (core::mem::size_of::<GetCertificateRsp>() as u32 + u16::MAX as u32)
+            .min(self.transport_sz) as usize;
+
+        request.offset = 0;
+        request.length = ((rsp_sz - core::mem::size_of::<GetCertificateRsp>()) as u16).to_le();
+
+        // SAFETY: `request` is repr(C) and packed, so we can convert it to a slice
+        let request_buf = unsafe { from_raw_parts_mut(&mut request as *mut _ as *mut u8, req_sz) };
+
+        let mut response_vec: KVec<u8> = KVec::from_elem(0u8, rsp_sz, GFP_KERNEL)?;
+
+        let response = self.get_cert_exchange(request_buf, &mut response_vec)?;
+
+        if response.param1 != slot {
+            pr_err!("Invalid slot response\n");
+            return Err(EPROTO);
+        }
+
+        let total_cert_len = u16::from_le(response.portion_length) as usize
+            + u16::from_le(response.remainder_length) as usize;
+
+        let mut certs_buf: KVec<u8> = KVec::new();
+
+        certs_buf.extend_from_slice(
+            &response_vec[8..(8 + u16::from_le(response.portion_length) as usize)],
+            GFP_KERNEL,
+        )?;
+
+        let mut offset: u16 = u16::from_le(response.portion_length);
+        let mut remainder_length = u16::from_le(response.remainder_length) as usize;
+
+        while remainder_length > 0 {
+            request.offset = offset.to_le();
+            request.length =
+                ((remainder_length.min(rsp_sz - core::mem::size_of::<GetCertificateRsp>())) as u16)
+                    .to_le();
+
+            let request_buf =
+                unsafe { from_raw_parts_mut(&mut request as *mut _ as *mut u8, req_sz) };
+
+            response_vec.resize(
+                request.length as usize + core::mem::size_of::<GetCertificateRsp>(),
+                0,
+                GFP_KERNEL,
+            )?;
+
+            let response = self.get_cert_exchange(request_buf, &mut response_vec)?;
+
+            if u16::from_le(response.portion_length) == 0
+                || (response.param1 & 0xF) != slot
+                || offset as usize
+                    + u16::from_le(response.portion_length) as usize
+                    + u16::from_le(response.remainder_length) as usize
+                    != total_cert_len
+            {
+                pr_err!("Malformed certificate response\n");
+                return Err(EPROTO);
+            }
+
+            certs_buf.extend_from_slice(
+                &response_vec[8..(8 + u16::from_le(response.portion_length) as usize)],
+                GFP_KERNEL,
+            )?;
+            offset += u16::from_le(response.portion_length);
+            remainder_length = u16::from_le(response.remainder_length) as usize;
+        }
+
+        let header_length = core::mem::size_of::<SpdmCertChain>() + self.hash_len;
+
+        if total_cert_len < header_length as usize || total_cert_len != certs_buf.len() {
+            pr_err!("Malformed certificate chain in slot {slot}\n");
+            return Err(EPROTO);
+        }
+
+        let cert_chain_length = {
+            let ptr = certs_buf.as_ptr();
+            // SAFETY: `SpdmCertChain` is repr(C) and packed. We just
+            // checked the length above so we can convert it from a slice
+            let ptr = ptr.cast::<SpdmCertChain>();
+            // SAFETY: `ptr` came from a reference and the cast above is valid.
+            let certs: &SpdmCertChain = unsafe { &*ptr };
+            u16::from_le(certs.length) as usize
+        };
+
+        if total_cert_len != cert_chain_length {
+            pr_err!("Malformed certificate chain in slot {slot}\n");
+            return Err(EPROTO);
+        }
+
+        self.certs[slot as usize].clear();
+        self.certs[slot as usize].extend_from_slice(&certs_buf, GFP_KERNEL)?;
+
+        Ok(())
+    }
 }
diff --git a/lib/rspdm/validator.rs b/lib/rspdm/validator.rs
index b3d5cab6a9ce..4e78683d7b22 100644
--- a/lib/rspdm/validator.rs
+++ b/lib/rspdm/validator.rs
@@ -30,6 +30,7 @@
     SPDM_ASYM_ALGOS,
     SPDM_CTEXPONENT,
     SPDM_GET_CAPABILITIES,
+    SPDM_GET_CERTIFICATE,
     SPDM_GET_DIGESTS,
     SPDM_GET_VERSION,
     SPDM_HASH_ALGOS,
@@ -426,3 +427,58 @@ fn validate(unvalidated: &[u8]) -> Result<Self, Self::Err> {
         Ok(rsp)
     }
 }
+
+#[repr(C, packed)]
+pub(crate) struct GetCertificateReq {
+    pub(crate) version: u8,
+    pub(crate) code: u8,
+    pub(crate) param1: u8,
+    pub(crate) param2: u8,
+
+    pub(crate) offset: u16,
+    pub(crate) length: u16,
+}
+
+impl Default for GetCertificateReq {
+    fn default() -> Self {
+        GetCertificateReq {
+            version: 0,
+            code: SPDM_GET_CERTIFICATE,
+            param1: 0,
+            param2: 0,
+            offset: 0,
+            length: 0,
+        }
+    }
+}
+
+#[repr(C, packed)]
+pub(crate) struct GetCertificateRsp {
+    pub(crate) version: u8,
+    pub(crate) code: u8,
+    pub(crate) param1: u8,
+    pub(crate) param2: u8,
+
+    pub(crate) portion_length: u16,
+    pub(crate) remainder_length: u16,
+
+    pub(crate) cert_chain: __IncompleteArrayField<u8>,
+}
+
+impl Validate<Untrusted<&[u8]>> for &GetCertificateRsp {
+    type Err = Error;
+
+    fn validate(unvalidated: &[u8]) -> Result<Self, Self::Err> {
+        if unvalidated.len() < mem::size_of::<GetCertificateRsp>() {
+            return Err(EINVAL);
+        }
+
+        let ptr = unvalidated.as_ptr();
+        // CAST: `GetCertificateRsp` only contains integers and has `repr(C)`.
+        let ptr = ptr.cast::<GetCertificateRsp>();
+        // SAFETY: `ptr` came from a reference and the cast above is valid.
+        let rsp: &GetCertificateRsp = unsafe { &*ptr };
+
+        Ok(rsp)
+    }
+}
-- 
2.54.0

