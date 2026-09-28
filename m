Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207ED329E4B
	for <linux-cxl@vger.kernel.org>; Mon, 28 Sep 2026 01:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790558435; cv=none; b=gPBNN+s/VaCgcrxHcf55G86FOK1OuEwPLPGivrAJjfvhg1tR97dJFsUMjeVqAsdjI+ICJLwrSQxeqvXLwpSYGiaqJt5G8cUu/HkelE4A2nmxL2PUfWtF6QiHCj1xutF0Ch7fCwKz1xfesZljNOsArTsAwLQI66xDz8OVHZAV6pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790558435; c=relaxed/simple;
	bh=yZJky22DK8SoOEpKSdAy5qWRF+Ef1Q8RltBsE50v/BQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MwIBu+MYSh8NWc+F0Uka3gWhvcdOhRJ86oeisYDH6e+TPyIpJvBYUeqj5MN5EKAZA8Tra1G/QslCGNMyIAMAmxh0f/ML1MTqn2J4wvBSG0tYIWPpjuJJC6qjYQwrYQ0XjUsg0k31XcnhY7o58TiapmtdFCafxQDBCqbY8+1nXy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nlwe95B8; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlwe95B8"
Received: by mail-pj2-f41.google.com with SMTP id 98e67ed59e1d1-3a0abca97c0so1258830a91.1
        for <linux-cxl@vger.kernel.org>; Sun, 27 Sep 2026 18:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790558431; x=1791163231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dirh2UEA4WtZV+9yohxG/1+RZRfECh/4CcVZeUY5/Aw=;
        b=nlwe95B8T+AJxO7yvPOIDWqiA65GV9s5cEoWvANkpTbAyr0HploIwIpEJo7eArs9oP
         fMKvUyxAp1dbPPFfTZSe79suZUThhc679kPRWqKwFZ2hvNmAjlTO6579rQMap8eWW2jE
         MQ2OWNMKpCBFp2L6/ZVEz1icTG8Z4WyCi5cdxkvcCv+iIsZUO/vK+Nd/xzYn+cB9oi+c
         YkaERCsoWYPJ7sAiEnQNyMxaL73NlDfVQbH7UMru7212koNgGbeD3kdWofQHnmVakmF5
         3cgOsoWLxtJ6Xft7pfnRRFqZ0qMSNV1duiws6Jkwg90Z8It/Ps8XOymXcFj5CpLSeqip
         CbjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790558431; x=1791163231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dirh2UEA4WtZV+9yohxG/1+RZRfECh/4CcVZeUY5/Aw=;
        b=TMKpr4eugh1m41k8VuJ4v5Ba7HT8AOUOPNMM+J9OtHlOwE1ZRqWIy2aMSFZWVDOoGg
         qNvrqD/Kc5y4Db1WlIAcwP4szupWGfO804KMBKbi6iMQp08R4/fohD2GYvPSn+aGW8ZW
         SsfxNNR3qR+d3oIe/VV2KDhWAtAwfyPGwXtt/8DrJN4LfGRPUqmbel41zYi8+xMt9+Uz
         CIYZTIP39OBDPXe1/opWbdux2tLzbhNB277lYiqWT4r82YoY49BAmn2//XoaN5T8DvS6
         0VS9GXmxbAc6pqnBKYve44BAYgkKHzm8WSfBYIW/nxH1e5ecrAlfeVx0vEmQUt1T3u+o
         p48Q==
X-Gm-Message-State: AFq9FYIEImdb9O0ASRZn7UglP2RIPFMeFHklkpSBcsN+XbWVxjeU2upD
	G5lv7JFIwsWlLpkSWTKsd+k6oy9h5wJv6d5zeLFvbMflk9ok8cCYbzft7oKKyQ==
X-Gm-Gg: AYBFou3/flflHjKJsljpjQgxaJk6oOVXlvNup+uUubH79UdAXkVZUg2lcNAoaxR84GH
	tBXhVHzmNLeuvbIF7LX1cqrYp9wrh9OaTt73DL8dnkvT9q5JrE6XJ3DCi4J9qANz2pGR9sZu6n9
	H0FmjUHLdxxe+dKtFwyD/yc5CCoCVLNRBAhiL02/uLNoYxNBWPplfHuINlN/idUAR1qUzdVZh2f
	dHGdA9JFQu2sbVAe18A2C55XmvbW/21dSG04kt3xzPdwmKrZ8W9zLM5U91GCDoEBjnyb7LufvQw
	3b19Wg9hqRW5WMDEq9CiNS/BPrOhDONTmGwXp71DMrD2fo3zChAfJZElmRp/htK+Q3IBEYLB3gp
	j7saLlgx+Xy8qnu0+qq8pxiIQz+/4aPOLD4W6zQT3fX57GDt1EH+XAW42ViuyXa125scYV1f1oQ
	L/OEc97sCVF8nnuqzsKkcvLX3K0OlNBEhX74Yu4uZnbm3V+MgwDzlmRclErSdzaF6fbaoyfiJu7
	v6pPnxU8kfy0mJA
X-Received: by 2002:a17:90b:524a:b0:3a4:71b7:eb63 with SMTP id 98e67ed59e1d1-3a471b7f585mr416544a91.10.1790558431012;
        Sun, 27 Sep 2026 18:20:31 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0e151be04sm11010527a91.9.2026.09.27.18.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 18:20:29 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: linux-cxl@vger.kernel.org,
	akpm@linux-foundation.org,
	Jonathan.Cameron@huawei.com,
	bhelgaas@google.com,
	djbw@kernel.org,
	alistair@alistair23.me,
	lukas@wunner.de,
	rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org,
	jic23@kernel.org,
	linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	bjorn3_gh@protonmail.com,
	ojeda@kernel.org,
	tmgross@umich.edu,
	gary@garyguo.net,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	alistair23@gmail.com,
	benno.lossin@proton.me,
	wilfred.mallawa@wdc.com,
	aliceryhl@google.com,
	a.hindborg@kernel.org
Subject: [PATCH v4 19/22] lib: rspdm: Support SPDM get_certificate
Date: Mon, 28 Sep 2026 11:20:18 +1000
Message-ID: <20260928012021.484003-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
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
 lib/rspdm/lib.rs       |  15 ++++
 lib/rspdm/state.rs     | 110 ++++++++++++++++++++++++++++-
 lib/rspdm/validator.rs | 152 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 278 insertions(+), 1 deletion(-)

diff --git a/lib/rspdm/consts.rs b/lib/rspdm/consts.rs
index 11e080815aa6..234534c7aa6d 100644
--- a/lib/rspdm/consts.rs
+++ b/lib/rspdm/consts.rs
@@ -148,6 +148,8 @@ fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
 
 pub(crate) const SPDM_GET_DIGESTS: u8 = 0x81;
 
+pub(crate) const SPDM_GET_CERTIFICATE: u8 = 0x82;
+
 // If the crypto support isn't enabled don't offer the algorithms
 // to the responder
 #[cfg(CONFIG_CRYPTO_RSA)]
diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
index 92035b1070d1..ee17f4818aeb 100644
--- a/lib/rspdm/lib.rs
+++ b/lib/rspdm/lib.rs
@@ -109,6 +109,21 @@ pub extern "C" fn spdm_authenticate(state_ptr: *mut spdm_state) -> c_int {
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
index 502d99eb13a6..780b9d459abf 100644
--- a/lib/rspdm/state.rs
+++ b/lib/rspdm/state.rs
@@ -52,16 +52,21 @@
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
 
 /// The current SPDM session state for a device.
@@ -654,4 +659,107 @@ pub(crate) fn get_digests(&mut self) -> Result<(), Error> {
 
         Ok(())
     }
+
+    fn get_cert_exchange(
+        &mut self,
+        request_buf: &mut [u8],
+        response_vec: &mut KVec<u8>,
+    ) -> Result<GetCertificateRsp, Error> {
+        let len = self.spdm_exchange(request_buf, response_vec.as_mut_slice())? as usize;
+        response_vec.truncate(len);
+
+        let response: GetCertificateRsp =
+            Untrusted::new(response_vec.as_slice()).validate(&*self)?;
+
+        Ok(response)
+    }
+
+    pub(crate) fn get_certificate(&mut self, slot: u8) -> Result<(), Error> {
+        let mut request = GetCertificateReq::default();
+        request.header.version = self.version;
+        request.header.param1 = slot;
+
+        let rsp_sz =
+            (GET_CERTIFICATE_RSP_HDR_SZ as u32 + u16::MAX as u32).min(self.transport_sz) as usize;
+
+        request.offset = 0;
+        request.length = (rsp_sz - GET_CERTIFICATE_RSP_HDR_SZ) as u16;
+
+        let mut response_vec: KVec<u8> = KVec::from_elem(0u8, rsp_sz, GFP_KERNEL)?;
+
+        let mut request_buf = request.to_bytes()?;
+        let response = self.get_cert_exchange(request_buf.as_mut_slice(), &mut response_vec)?;
+
+        if (response.header.param1 & 0xF) != slot {
+            pr_err!("Invalid slot response\n");
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
+            response_vec.resize(
+                request.length as usize + GET_CERTIFICATE_RSP_HDR_SZ,
+                0,
+                GFP_KERNEL,
+            )?;
+
+            let response = self.get_cert_exchange(request_buf.as_mut_slice(), &mut response_vec)?;
+
+            let portion_length = response.portion_length;
+            let rem_length = response.remainder_length;
+
+            if portion_length == 0
+                || (response.header.param1 & 0xF) != slot
+                || offset as usize + portion_length as usize + rem_length as usize != total_cert_len
+            {
+                pr_err!("Malformed certificate response\n");
+                return Err(EPROTO);
+            }
+
+            certs_buf.extend_from_slice(&response.cert_chain, GFP_KERNEL)?;
+            let (val, overflow) = offset.overflowing_add(portion_length);
+            if overflow {
+                pr_err!("portion_length  response overflowed\n");
+                return Err(EPROTO);
+            }
+            offset = val;
+            remainder_length = rem_length as usize;
+        }
+
+        let header_length = SPDM_CERT_CHAIN_HDR_SZ + self.hash_len;
+
+        if total_cert_len < header_length || total_cert_len != certs_buf.len() {
+            pr_err!("Malformed certificate chain in slot {slot}\n");
+            return Err(EPROTO);
+        }
+
+        let certs: SpdmCertChain = Untrusted::new(certs_buf.as_slice()).validate(&*self)?;
+        let cert_chain_length = certs.length as usize;
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
index c058dde31440..f4e9485179d0 100644
--- a/lib/rspdm/validator.rs
+++ b/lib/rspdm/validator.rs
@@ -26,6 +26,7 @@
     SPDM_CAP_SUPPORTED_ALGORITHMS,
     SPDM_CTEXPONENT,
     SPDM_GET_CAPABILITIES,
+    SPDM_GET_CERTIFICATE,
     SPDM_GET_DIGESTS,
     SPDM_GET_VERSION,
     SPDM_HASH_ALGOS,
@@ -794,3 +795,154 @@ fn validate(unvalidated: &[u8], context: &'c SpdmState<'c>) -> Result<Self, Self
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
+    // and lower and u32 for 1.4. We don't currently support `LargeOffset`
+    // and `LargeLength`, so let's pretend this is always a u16
+    pub(crate) length: u16,
+
+    pub(crate) root_hash: KVec<u8>,
+
+    pub(crate) certificates: KVec<u8>,
+}
+
+impl<'a, 'c> Validate<'c, Untrusted<&'a [u8]>> for SpdmCertChain {
+    type Err = Error;
+
+    type Context = &'c SpdmState<'c>;
+
+    fn validate(unvalidated: &[u8], context: &'c SpdmState<'c>) -> Result<Self, Self::Err> {
+        let length = u16::from_le_bytes(
+            unvalidated
+                .get(0..2)
+                .ok_or(EIO)?
+                .try_into()
+                .map_err(|_| EINVAL)?,
+        );
+
+        let root_hash_end = SPDM_CERT_CHAIN_HDR_SZ + context.hash_len;
+        let mut root_hash = KVec::new();
+        root_hash.extend_from_slice(
+            unvalidated
+                .get(SPDM_CERT_CHAIN_HDR_SZ..root_hash_end)
+                .ok_or(EIO)?,
+            GFP_KERNEL,
+        )?;
+
+        let cert_chain_end = length as usize - root_hash_end;
+        let mut certificates = KVec::new();
+        certificates.extend_from_slice(
+            unvalidated.get(root_hash_end..cert_chain_end).ok_or(EIO)?,
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
+    /// Size of the response, not public
+    length: usize,
+}
+
+impl GetCertificateRsp {
+    #[expect(dead_code)]
+    pub(crate) fn len(&self) -> usize {
+        self.length
+    }
+}
+
+impl<'a, 'c> Validate<'c, Untrusted<&'a [u8]>> for GetCertificateRsp {
+    type Err = Error;
+
+    type Context = &'c SpdmState<'c>;
+
+    fn validate(unvalidated: &[u8], context: &'c SpdmState<'c>) -> Result<Self, Self::Err> {
+        let header: SpdmHeader =
+            Untrusted::new(unvalidated.get(0..4).ok_or(EIO)?).validate(context)?;
+
+        if header.code != SPDM_GET_CERTIFICATE - 0x80 {
+            return Err(EINVAL);
+        }
+
+        if header.version != context.version {
+            pr_err!("Invalid version response\n");
+            return Err(EPROTO);
+        }
+
+        let portion_length = u16::from_le_bytes(
+            unvalidated
+                .get(4..6)
+                .ok_or(EIO)?
+                .try_into()
+                .map_err(|_| EINVAL)?,
+        );
+        let remainder_length = u16::from_le_bytes(
+            unvalidated
+                .get(6..8)
+                .ok_or(EIO)?
+                .try_into()
+                .map_err(|_| EINVAL)?,
+        );
+
+        let cert_chain_end = 8 + portion_length as usize;
+
+        let mut cert_chain = KVec::new();
+        cert_chain.extend_from_slice(unvalidated.get(8..cert_chain_end).ok_or(EIO)?, GFP_KERNEL)?;
+
+        Ok(GetCertificateRsp {
+            header,
+            portion_length,
+            remainder_length,
+            cert_chain,
+            length: cert_chain_end,
+        })
+    }
+}
-- 
2.55.0

