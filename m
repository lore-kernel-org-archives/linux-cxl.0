Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794284489;
	b=LJ9TGS7CUY2q0SUgsB9ybtSjQ7Cu9zXjL8zGW5w5MFn7SlAw6/I36TUx0L8E2ymyeoT9
	 ekMSjTm3WV6OGob0xX081cDVdYVnfxr1S3VTADQ7dkdQx6K/UGtPHQ1uHyZIyWkDdo2Q/
	 1DIiDb/Huglri2ILDzpBV9mkIlROT6Wfrec2L6kmCxOcelzoIsdHCqp5sGCIZ/5nmmRj7
	 9uxXoo3TTNsZoxbhl5MfjDn3fCIed4X0NjcHnTPgMTtdHkq3Ikm0iOkrcLycW0P3d0csV
	 KzsSwdn2gjq6lFjU34TwzYkePjZ9PjXb7KkjxWt8MRnllr36/kHan7d/LE/La7Rf/Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794284489;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hoDZ9A+UGItROYmZGLQ23RT75hHMt9V+4cTfTF/bRJ8=;
	b=spVfQNYtY8f/hOzs/7N0wdqioZfQFGlC20+UXGfA6mhlpeOA1MFjgQwsbHT2vPNJDhPh
	 m3FXFh2WtJklpQ1jlN4TAn5XGJq4mbRGMfJyKANKYJNjxi3NM60ZQ1SjdLXnDA4K9EvMS
	 S/hmfWaffZaIopdKUMx42/M0z9ClHh9BHh0VdjFdn5Otx3mAWSSeN9Y/X/uFaqxFnmYqT
	 ckwmDpcwvn4J45gfapT0kMsIAduGGx5dDl4LDPKVPybWArGufU+FNFmio9G2m8x4OQKX9
	 DNiw9Ao2MIDXqevZh0BnOssu2DsZqDvRHK0I+c/URKyumcoWxgOAxT5KJEvB0f6rOQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Amg4URSe;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D39606BB36
	for <linux-cxl@vger.kernel.org>; Tue, 10 Nov 2026 04:21:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79D39606BB36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Amg4URSe
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-36dbde64409so3186173eec.0
        for <linux-cxl@vger.kernel.org>; Mon, 09 Nov 2026 20:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794284488; x=1794889288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hoDZ9A+UGItROYmZGLQ23RT75hHMt9V+4cTfTF/bRJ8=;
        b=Amg4URSen9zLsh38hsbsl/UZMpz5KbaEgtKitqupbCIsRBf5LpjVqgFsD9ZefYDydk
         kfFxy/hYIL1wha53cHbYBWV4FzFzJ2Qc4UzCoV6C+wLU2xJJgALZHmAq4qcxxwb4g0dw
         OdXaXf/FkEapteYpQPnlB+bQF6e/kVn0ZHPGNA7aEIGGFjfe3TlARt1vjKgqaoJadmio
         9Y6N6JoHIXAnrUN7gA/Km/nOp2BXrcI+aDLr79IAmOQZpnWO5l/lfkzMe+XNIs4oqs6i
         0jVezHHQIlrzl2UrmS6bSUFUJflAJqRQajw3tSKNnRecSbK9aRGG8F+v5qdsCHoBacMS
         ToRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794284488; x=1794889288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hoDZ9A+UGItROYmZGLQ23RT75hHMt9V+4cTfTF/bRJ8=;
        b=CiiIQ0mbWqthtZubKejwHrj8xqcnf2ZVrm746Ky/nCY9c33HiSwxvDx8w44AAt0Wyp
         bchklX5MHvJPAqM4MUrewjWu5cgCKPkMeOuB/CKRWZ6ItxDU4yR6yLzWLuQGiA3nlzz0
         FgHJuosJAASCt6cZ+dRylnMj8vO4tVp1CcUyIPKqcAj+sPxdFFiBZdrVQRz6aNTqcoGl
         dxlF2uLfD2tU1y2tyb7exHH3y+1xH26rBXRT+dlr6vVd/rlL7mzzxIIVhbZMnFaXNvff
         MxwXgv8mIkI0uzpuyRuoqIApG6qbuPPTEAm848hsQjgNDAtTeZJx9/2I3Rx1qXW/99n+
         y2hQ==
X-Forwarded-Encrypted: i=1; AL+hErFAJGfAFXhgTyg6xsyC8qU6eCoI1/CU+we6I/56JkohTwP4vzm91EbAOcZewiIYeiGiFRz9TP+qRSU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9zF+/NARtYctTq+ObYSss7sBRcUpVHRqkF5tODLi5Ete0PntL0
	ae16JdmlwbeTbnetZSHTvDIgY4+ZEme2NjjgyOXpnPeXtJXG0SKobI2l
X-Gm-Gg: AYBFou3hBXpOIH8TFUsqrmIZBVdLMN2QEpUq8HXxaL8xSLGimLGZv/YZ4nffrP8MmSE
	TvH1uhoBJKoAGAIZmwryk2rHDXlfgU7G0YIz5a0uTXGH58gKDwE3TqftQHSBvFVVEmNFCYHcktI
	Bo9ovC8k8yADb5QZVtZ2RwRHoKni8fh/mjTOfl/5jZQT3EvYxvCE++rZY5n2JZ4ryh8oVf8dGn9
	vy251yUl6TGhPasR4mKaPaY3KlRdJBFwVG2xn97KN3WZ5Qy1e1H2jqhvz2ETI6gVZCUdjCCqnol
	qV4jo2NKxRezE4k1GV1ZdfU2t+zFHyfE293XraO45c9EJKqDaTJhkpYU5qEHc8/200po2/Oj8Y/
	faSJXvMBoaC3IGyc5tNwGSAFmezK4hgUEV9AL+jQNkUqCk3gTd/LuQNV96qFEdQE+CLIvNDE/O0
	LcQgaxWB2jMzLV1icv9dVb9hHaIPGgzPKkGZm+QBV67WoX1WKFVU1m60KnrsLxgPIJFmaUVmcrO
	usBCe5JpPj7zpjNbvrqM8k5zR9FRfi5hSdydF43KSQ4zcymhMlIveFHZV1wgujPwV0xdllBLaFK
	DNvzxq8RPDYusIiBYfab5sjXQHh7muJHZK4olsqKCYGN6DA=
X-Received: by 2002:a05:7022:ec17:b0:144:fdf0:9d91 with SMTP id a92af1059eb24-1b3b604c6cemr2508611c88.24.1794284487379;
        Mon, 09 Nov 2026 20:21:27 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b7ba88sm3540459c88.22.2026.11.09.20.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 20:21:26 -0800 (PST)
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
Subject: [PATCH v6 19/25] lib: rspdm: Support SPDM get_certificate
Date: Tue, 10 Nov 2026 14:18:26 +1000
Message-ID: <20261110041832.1730924-20-alistair.francis@wdc.com>
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

Support the GET_CERTIFICATE SPDM command.

The kernel will send a GET_CERTIFICATE request to the responder and
then iterate over all of the certificates returned.

Certificate validation happens in the next commit.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 lib/rspdm/consts.rs    |   2 +
 lib/rspdm/lib.rs       |  15 ++++
 lib/rspdm/state.rs     | 100 +++++++++++++++++++++++-
 lib/rspdm/validator.rs | 170 ++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 285 insertions(+), 2 deletions(-)

diff --git a/lib/rspdm/consts.rs b/lib/rspdm/consts.rs
index b80c37f1ee70c..b76bab8894b9e 100644
--- a/lib/rspdm/consts.rs
+++ b/lib/rspdm/consts.rs
@@ -85,6 +85,8 @@
 
 pub(crate) const SPDM_GET_DIGESTS: u8 = 0x81;
 
+pub(crate) const SPDM_GET_CERTIFICATE: u8 = 0x82;
+
 // If the crypto support isn't enabled don't offer the algorithms
 // to the responder
 #[cfg(CONFIG_CRYPTO_RSA)]
diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
index ee996ecfb4ce1..440589ff66b5f 100644
--- a/lib/rspdm/lib.rs
+++ b/lib/rspdm/lib.rs
@@ -280,6 +280,21 @@ fn from(code: SpdmErrorCode) -> Self {
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
index a44f98a941cd0..f1a55da1f1cfa 100644
--- a/lib/rspdm/state.rs
+++ b/lib/rspdm/state.rs
@@ -62,16 +62,21 @@
 use crate::validator::{
     GetCapabilitiesReq,
     GetCapabilitiesRsp,
+    GetCertificateReq,
+    GetCertificateRsp,
     GetDigestsReq,
     GetDigestsRsp,
     GetVersionReq,
     GetVersionRsp,
     NegotiateAlgsReq,
     NegotiateAlgsRsp,
+    SpdmCertChain,
     SpdmErrorRsp,
     SpdmHeader,
     GET_CAPABILITIES_RSP_SZ,
-    NEGOTIATE_ALGS_RSP_SZ, //
+    GET_CERTIFICATE_RSP_HDR_SZ,
+    NEGOTIATE_ALGS_RSP_SZ,
+    SPDM_CERT_CHAIN_HDR_SZ, //
 };
 
 /// Transport for exchanging SPDM messages with a responder device.
@@ -500,4 +505,97 @@ pub(crate) fn get_digests(&mut self) -> Result<(), Error> {
 
         Ok(())
     }
+
+    pub(crate) fn get_certificate(&mut self, slot: u8) -> Result<(), Error> {
+        let mut request = GetCertificateReq::default();
+        request.header.version = self.version;
+        request.header.param1 = slot;
+
+        // Bound the per-chunk allocation to one page
+        let rsp_sz = (GET_CERTIFICATE_RSP_HDR_SZ + PAGE_SIZE).min(self.data_transfer_sz as usize);
+
+        request.offset = 0;
+        request.length = (rsp_sz - GET_CERTIFICATE_RSP_HDR_SZ) as u16;
+
+        let response_vec: KVec<u8> = KVec::from_elem(0u8, rsp_sz, GFP_KERNEL)?;
+
+        let mut request_buf = request.to_bytes()?;
+        let response: GetCertificateRsp = self
+            .spdm_exchange(request_buf.as_mut_slice(), response_vec)?
+            .validate(&*self)?;
+
+        if (response.header.param1 & 0xF) != slot {
+            dev_err!(&self.dev, "Invalid slot response\n");
+            return Err(EPROTO);
+        }
+
+        let portion_length = response.portion_length;
+        let rem_length = response.remainder_length;
+
+        let total_cert_len = portion_length as usize + rem_length as usize;
+
+        let mut certs_buf: KVec<u8> = KVec::new();
+
+        certs_buf.extend_from_slice(&response.cert_chain, GFP_KERNEL)?;
+
+        let mut offset: u16 = portion_length;
+        let mut remainder_length = rem_length as usize;
+
+        while remainder_length > 0 {
+            request.offset = offset;
+            request.length = (remainder_length.min(rsp_sz - GET_CERTIFICATE_RSP_HDR_SZ)) as u16;
+
+            let mut request_buf = request.to_bytes()?;
+
+            let response_vec: KVec<u8> = KVec::from_elem(
+                0u8,
+                request.length as usize + GET_CERTIFICATE_RSP_HDR_SZ,
+                GFP_KERNEL,
+            )?;
+
+            let response: GetCertificateRsp = self
+                .spdm_exchange(request_buf.as_mut_slice(), response_vec)?
+                .validate(&*self)?;
+
+            let portion_length = response.portion_length;
+            let rem_length = response.remainder_length;
+
+            if portion_length == 0
+                || (response.header.param1 & 0xF) != slot
+                || offset as usize + portion_length as usize + rem_length as usize != total_cert_len
+            {
+                dev_err!(&self.dev, "Malformed certificate response\n");
+                return Err(EPROTO);
+            }
+
+            certs_buf.extend_from_slice(&response.cert_chain, GFP_KERNEL)?;
+            let (val, overflow) = offset.overflowing_add(portion_length);
+            if overflow {
+                dev_err!(&self.dev, "portion_length  response overflowed\n");
+                return Err(EPROTO);
+            }
+            offset = val;
+            remainder_length = rem_length as usize;
+        }
+
+        let header_length = SPDM_CERT_CHAIN_HDR_SZ + self.hash_len();
+
+        if total_cert_len < header_length || total_cert_len != certs_buf.len() {
+            dev_err!(&self.dev, "Malformed certificate chain in slot {slot}\n");
+            return Err(EPROTO);
+        }
+
+        let certs: SpdmCertChain = Untrusted::new(certs_buf.as_slice()).validate(&*self)?;
+        let cert_chain_length = certs.length as usize;
+
+        if total_cert_len != cert_chain_length {
+            dev_err!(&self.dev, "Malformed certificate chain in slot {slot}\n");
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
index 54207527e9f4d..dad8482525794 100644
--- a/lib/rspdm/validator.rs
+++ b/lib/rspdm/validator.rs
@@ -12,6 +12,7 @@
     SPDM_CAP_SUPPORTED_ALGORITHMS,
     SPDM_CTEXPONENT,
     SPDM_GET_CAPABILITIES,
+    SPDM_GET_CERTIFICATE,
     SPDM_GET_DIGESTS,
     SPDM_GET_VERSION,
     SPDM_HASH_ALGOS,
@@ -24,7 +25,8 @@
     SPDM_VER_10,
     SPDM_VER_11,
     SPDM_VER_12,
-    SPDM_VER_13, //
+    SPDM_VER_13,
+    SPDM_VER_14, //
 };
 use crate::{
     SpdmErrorCode,
@@ -824,3 +826,169 @@ fn validate(unvalidated: KVec<u8>, context: &'c SpdmState<T>) -> Result<Self, Se
         })
     }
 }
+
+pub(crate) struct GetCertificateReq {
+    pub(crate) header: SpdmHeader,
+
+    pub(crate) offset: u16,
+    pub(crate) length: u16,
+}
+
+impl GetCertificateReq {
+    pub(crate) fn to_bytes(&self) -> Result<KVec<u8>> {
+        let mut out = self.header.to_bytes()?;
+
+        out.extend_from_slice(&self.offset.to_le_bytes(), GFP_KERNEL)?;
+        out.extend_from_slice(&self.length.to_le_bytes(), GFP_KERNEL)?;
+
+        Ok(out)
+    }
+}
+
+impl Default for GetCertificateReq {
+    fn default() -> Self {
+        GetCertificateReq {
+            header: SpdmHeader::new(SPDM_GET_CERTIFICATE),
+
+            offset: 0,
+            length: 0,
+        }
+    }
+}
+
+pub(crate) const GET_CERTIFICATE_RSP_HDR_SZ: usize = mem::size_of::<SpdmHeader>() + 4;
+
+pub(crate) const SPDM_CERT_CHAIN_HDR_SZ: usize = mem::size_of::<u16>() + 2;
+
+/// A parsed SPDM certificate chain
+#[expect(dead_code)]
+pub(crate) struct SpdmCertChain {
+    // `length` is a u16 (with 2 bytes reserved) for SPDM versions 1.3
+    // and lower and u32 for 1.4.
+    pub(crate) length: u32,
+
+    pub(crate) root_hash: KVec<u8>,
+
+    pub(crate) certificates: KVec<u8>,
+}
+
+impl<'a, 'c, T: Transport> Validate<'c, Untrusted<&'a [u8]>, &'c SpdmState<T>> for SpdmCertChain {
+    type Err = Error;
+
+    fn validate(unvalidated: &[u8], context: &'c SpdmState<T>) -> Result<Self, Self::Err> {
+        let length = if context.version >= SPDM_VER_14 {
+            u32::from_le_bytes(
+                unvalidated
+                    .get(0..4)
+                    .ok_or(EPROTO)?
+                    .try_into()
+                    .map_err(|_| EPROTO)?,
+            )
+        } else {
+            u32::from(u16::from_le_bytes(
+                unvalidated
+                    .get(0..2)
+                    .ok_or(EPROTO)?
+                    .try_into()
+                    .map_err(|_| EPROTO)?,
+            ))
+        };
+
+        let root_hash_end = SPDM_CERT_CHAIN_HDR_SZ + context.hash_len();
+        let mut root_hash = KVec::new();
+        root_hash.extend_from_slice(
+            unvalidated
+                .get(SPDM_CERT_CHAIN_HDR_SZ..root_hash_end)
+                .ok_or(EPROTO)?,
+            GFP_KERNEL,
+        )?;
+
+        let cert_chain_end = length as usize;
+        let mut certificates = KVec::new();
+        certificates.extend_from_slice(
+            unvalidated
+                .get(root_hash_end..cert_chain_end)
+                .ok_or(EPROTO)?,
+            GFP_KERNEL,
+        )?;
+
+        Ok(SpdmCertChain {
+            length,
+            root_hash,
+            certificates,
+        })
+    }
+}
+
+pub(crate) struct GetCertificateRsp {
+    pub(crate) header: SpdmHeader,
+
+    pub(crate) portion_length: u16,
+    pub(crate) remainder_length: u16,
+
+    pub(crate) cert_chain: KVec<u8>,
+
+    /// The actual length of the SPDM message. `raw_bytes` might be longer
+    /// as it includes transport specific padding.
+    length: usize,
+
+    /// Entire response, used for the transcript hash.
+    raw_bytes: KVec<u8>,
+}
+
+impl GetCertificateRsp {
+    #[expect(dead_code)]
+    pub(crate) fn as_bytes(&self) -> Result<&[u8], Error> {
+        self.raw_bytes.get(..self.length).ok_or(EPROTO)
+    }
+}
+
+impl<'c, T: Transport> Validate<'c, Untrusted<KVec<u8>>, &'c SpdmState<T>> for GetCertificateRsp {
+    type Err = Error;
+
+    fn validate(unvalidated: KVec<u8>, context: &'c SpdmState<T>) -> Result<Self, Self::Err> {
+        let header: SpdmHeader =
+            Untrusted::new(unvalidated.get(0..4).ok_or(EPROTO)?).validate(context)?;
+
+        if header.code != SPDM_GET_CERTIFICATE - 0x80 {
+            return Err(EPROTO);
+        }
+
+        if header.version != context.version {
+            dev_err!(&context.dev, "Invalid version response\n");
+            return Err(EPROTO);
+        }
+
+        let portion_length = u16::from_le_bytes(
+            unvalidated
+                .get(4..6)
+                .ok_or(EPROTO)?
+                .try_into()
+                .map_err(|_| EPROTO)?,
+        );
+        let remainder_length = u16::from_le_bytes(
+            unvalidated
+                .get(6..8)
+                .ok_or(EPROTO)?
+                .try_into()
+                .map_err(|_| EPROTO)?,
+        );
+
+        let cert_chain_end = 8 + portion_length as usize;
+
+        let mut cert_chain = KVec::new();
+        cert_chain.extend_from_slice(
+            unvalidated.get(8..cert_chain_end).ok_or(EPROTO)?,
+            GFP_KERNEL,
+        )?;
+
+        Ok(GetCertificateRsp {
+            header,
+            portion_length,
+            remainder_length,
+            cert_chain,
+            length: cert_chain_end,
+            raw_bytes: unvalidated,
+        })
+    }
+}
-- 
2.56.0

