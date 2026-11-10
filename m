Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794284455;
	b=VlqCtKVM2Q+3yFYqO1Yz63l8iWDJTUSXP1qOQAQZcr+Kb9BnV0/dv0kbT56sR1D2I/yD
	 DAVTbTMpC76fpM1/SkrpWvRzqWvxqadecPf28Fnq9AwtMrmfIyGDH5u7DsgjmkxxM1Lon
	 TEe9J+u1+pJwAEUgul/7RNIJ2rO1WiArcXWE9bw+DMvvUlkoA9ex4Zk2vQ0MplcxDFE5Y
	 BEy/sFk99R2aQiiEt8KMao+x7QjvuZDn/d/FUxRRMTl0aibYKc+PvneT8uRC+5dWzF7Yc
	 WAKTXs6owyFV//zG84uAA6U6Eg6cj3OHBaqmoDqdm6hqBZJGTfa0EP/7yXV37YbZc4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794284455;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=4Fh9Hp7l2jRbV9ZfIyIPjxl8kvQ7eXmXys5l4VCkQqU=;
	b=xBpA8eFc6u3/J5I9rtvimbbPgeLE5opSTuvYDD5rJxI87rHYgypOqae+FBeLxb91bu8Y
	 /rJ3meY3a+Zq3X1ZphdnO0mEDaTFYOnsu7SX7mEWtBpKDx696XgpiTk9rioRFsNK2dSbV
	 EzFrq7JU9JR9/rGsNTeRmv2T7fhtrHSAi8SGXW/pNYva+uPSnfz0u6MiHfkV65K3YUe40
	 5bPL8hG6BxkyGdIxqrQcasL2xvOLMPvCW+sfrXuLj5F33rGqCmSCQfl3/jWFQt9QPW5pO
	 bdikAkeXpXw7B1uY9zlIDoDuqa5Nw1tCN7aCrKtVNHu43pYMA6eSmVBt/q7TtnKve0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IGGNy8QU;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A566C60A262A
	for <linux-cxl@vger.kernel.org>; Tue, 10 Nov 2026 04:20:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A566C60A262A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IGGNy8QU
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-36ff9c9da34so2750436eec.1
        for <linux-cxl@vger.kernel.org>; Mon, 09 Nov 2026 20:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794284454; x=1794889254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4Fh9Hp7l2jRbV9ZfIyIPjxl8kvQ7eXmXys5l4VCkQqU=;
        b=IGGNy8QUogtRL6KItCvWqaaJPLH31LHCZpq/n9MJNdi9igV84syK3QFTzf14+Sz3Le
         49MWDAIDJ4O0hc3RIk39SqX3wp+yZQZ0YxCZYn0zwZC52+m0TSta0d92hYhwohct8Xgv
         YsxCZyDlpucVv6sk76N9XSp/FBgwxPK1HpMXchYRgIuc1HLqKMJRX/HqwSuj2t9zw/rh
         PK2KP9xeTRtGl/9/2WsIh2ZRljdYpkXIag0HCyPtTZ7Saqw65lYek4nu43t+gzX+MwVq
         RjbjjQyVyZjXBB8FhOMyxIZr9NM4we7WXlWlkWNnz9GOVnNU2K7Lvfx+U/9MHDgJwrzh
         fyHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794284454; x=1794889254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4Fh9Hp7l2jRbV9ZfIyIPjxl8kvQ7eXmXys5l4VCkQqU=;
        b=XCMA45b7oc2Uk0OalCosV7M3FzqCZZkg4Fcfrezjdu1IwbieHqpeMQj6ySMSljZ2Dq
         ysQtHTQcQmKehzUwT4LRgPglAjrFWTXDP10gT+mIc8aWY/AQNRfvBJnKRfh1dqpsUCQg
         8LLEV2UNaWzzgH9SSD0EcVo+SQgOo6XA6fhE9UaboCOHGS5v1mCQn0EB90stSMEFiRBd
         ALf3QmupKIbKI5Idlep/f1yGOXzd79UqvR+MjILapv6oTSfpfr/qkXHm1HFXP6qfuaWx
         TN9wTp8aEsArschC50YA7xkNgBFG3/IPzn7mODetgnkYdWNhdlc+tOcmYOs+wdtO5+I4
         3xhA==
X-Forwarded-Encrypted: i=1; AL+hErHjR+fsgA7UveM3BoBMU5ZjLbOA6IbUzM8hvcfIcHbubjWD4mvur01Yj5IKxMeBxz5+tgZm8/d0soo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9NSbUZG/3AKXjCy15RqfP4M/IX6x5SnKi87bQdOer9szRSgqRn
	pGhIbwsGoPAsXtZ10k7NewoQQOkj6defvo4bs46w8hsTHmgCu2z1Edm7
X-Gm-Gg: AYBFou3S6Bp7mvSGVT0efCljQZ6pXCDylRKabLAk1yCFAx5+bNjr0h4IoKCzw3vDysj
	mG1xWjriVyxSDPfqbVqVuC6at+g+/GgwDoiIVrXfGZGaxNZpj+S5ZFP2mCCOBrYUc2DMtE8NVWi
	de3+y2nvqXjd2qEREjYgfLTK/1adQlwI2sKMOZGxc6/87TiAJxTBj5A833QgkV6h4vsbq0YN/iU
	+EcaRjNHmWaZjil5EPyT7cO92QtSlhyjjTIJ1OQmKvQgae7TMm78zR2FEMvye/N0oyCuR6kG7Jw
	/uPIfriiPGwfop9Bs7eRP29jijzCXQvN3f/NjPhSWXOxXeyKz2ERxkPVLIT1NNF6vhhZEDg2KAJ
	IajyaqecVGc7dwfMGxMULBicMbHJpnQFzP/12ZnVAqcuqHQ1F3WT2accQRReZnY/jYDUXmziKiT
	diNhdsqqF1y0/1mXmXbA2KH7eCGpNkKEK2M6e+xoCj2RVNmpCDC92TddjrImi20cUuR0YqFkhlt
	sUqCB3imH/PtKiXR6rfmT/4uBj8Fb7yJtlmZ5wMPjJsfF7Vz1ybV+KHMXOzOH8g1Lrksgbn6YUz
	aJGsBzWpZ8JTpUZgUu6onR64cxaDUolkXXaN6ABGo13TIYdngwfWz53efeAhi4ojPJb5gw==
X-Received: by 2002:a05:7022:92b:b0:1b3:a89c:c456 with SMTP id a92af1059eb24-1b3b5fa2534mr2790550c88.6.1794284453640;
        Mon, 09 Nov 2026 20:20:53 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b7ba88sm3540459c88.22.2026.11.09.20.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 20:20:52 -0800 (PST)
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
	Alistair Francis <alistair.francis@wdc.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v6 15/25] lib: rspdm: Support SPDM get_capabilities
Date: Tue, 10 Nov 2026 14:18:22 +1000
Message-ID: <20261110041832.1730924-16-alistair.francis@wdc.com>
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

Support the GET_CAPABILITIES SPDM command.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 lib/rspdm/consts.rs    |  22 ++-
 lib/rspdm/lib.rs       |   4 +
 lib/rspdm/state.rs     |  76 +++++++++-
 lib/rspdm/validator.rs | 318 ++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 415 insertions(+), 5 deletions(-)

diff --git a/lib/rspdm/consts.rs b/lib/rspdm/consts.rs
index 2470c7ac5e4d0..43be144251190 100644
--- a/lib/rspdm/consts.rs
+++ b/lib/rspdm/consts.rs
@@ -9,12 +9,14 @@
 
 use crate::validator::SpdmHeader;
 use core::mem;
+use kernel::bits::{
+    bit_u32,
+    bit_u8, //
+};
 
 // SPDM versions supported by this implementation
 pub(crate) const SPDM_VER_10: u8 = 0x10;
-#[expect(dead_code)]
 pub(crate) const SPDM_VER_11: u8 = 0x11;
-#[expect(dead_code)]
 pub(crate) const SPDM_VER_12: u8 = 0x12;
 #[expect(dead_code)]
 pub(crate) const SPDM_VER_13: u8 = 0x13;
@@ -30,4 +32,20 @@
 pub(crate) const SPDM_GET_VERSION_LEN: usize =
     mem::size_of::<SpdmHeader>() + 2 + (u8::MAX as usize) * mem::size_of::<u16>();
 
+pub(crate) const SPDM_GET_CAPABILITIES: u8 = 0xe1;
+pub(crate) const SPDM_CAP_SUPPORTED_ALGORITHMS: u8 = bit_u8(0);
 pub(crate) const SPDM_MIN_DATA_TRANSFER_SIZE: u32 = 42; // SPDM 1.2.0 margin no 226
+
+// SPDM cryptographic timeout of this implementation:
+// Assume calculations may take up to 1 sec on a busy machine, which equals
+// roughly 1 << 20.  That's within the limits mandated for responders by CMA
+// (1 << 23 usec, PCIe r6.2 sec 6.31.3) and DOE (1 sec, PCIe r6.2 sec 6.30.2).
+// Used in GET_CAPABILITIES exchange.
+pub(crate) const SPDM_CTEXPONENT: u8 = 20;
+
+pub(crate) const SPDM_CERT_CAP: u32 = bit_u32(1);
+pub(crate) const SPDM_CHAL_CAP: u32 = bit_u32(2);
+pub(crate) const SPDM_MULTI_KEY_CAP: u32 = bit_u32(26) | bit_u32(27);
+
+pub(crate) const SPDM_REQ_CAPS: u32 = SPDM_CERT_CAP | SPDM_CHAL_CAP;
+pub(crate) const SPDM_RSP_MIN_CAPS: u32 = SPDM_CERT_CAP | SPDM_CHAL_CAP;
diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
index 61f0a1ff4a1ca..9b0211ae76f55 100644
--- a/lib/rspdm/lib.rs
+++ b/lib/rspdm/lib.rs
@@ -268,6 +268,10 @@ fn from(code: SpdmErrorCode) -> Self {
         return e.to_errno() as c_int;
     }
 
+    if let Err(e) = state.get_capabilities() {
+        return e.to_errno() as c_int;
+    }
+
     -(EPROTONOSUPPORT as i32)
 }
 
diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
index e06578d204e74..cb6a351fe6085 100644
--- a/lib/rspdm/state.rs
+++ b/lib/rspdm/state.rs
@@ -12,6 +12,7 @@
     bindings,
     device::Device,
     error::Error,
+    page::PAGE_SIZE,
     sync::aref::ARef,
     validate::Untrusted, //
 };
@@ -21,13 +22,21 @@
     SPDM_GET_VERSION_LEN,
     SPDM_MAX_VER,
     SPDM_MIN_VER,
-    SPDM_REQ, //
+    SPDM_MULTI_KEY_CAP,
+    SPDM_REQ,
+    SPDM_RSP_MIN_CAPS,
+    SPDM_VER_10,
+    SPDM_VER_11,
+    SPDM_VER_12, //
 };
 use crate::validator::{
+    GetCapabilitiesReq,
+    GetCapabilitiesRsp,
     GetVersionReq,
     GetVersionRsp,
     SpdmErrorRsp,
-    SpdmHeader, //
+    SpdmHeader,
+    GET_CAPABILITIES_RSP_SZ, //
 };
 
 /// Transport for exchanging SPDM messages with a responder device.
@@ -75,6 +84,9 @@ pub(crate) struct SpdmState<T: Transport> {
     /// Maximum common supported version of requester and responder.
     /// Negotiated during GET_VERSION exchange.
     pub(crate) version: u8,
+    /// Cached capabilities of responder. Received during GET_CAPABILITIES
+    /// exchange.
+    pub(crate) rsp_caps: u32,
 }
 
 impl<T: Transport> SpdmState<T> {
@@ -96,6 +108,7 @@ pub(crate) fn new(
             data_transfer_sz: transport_sz,
             validate,
             version: SPDM_MIN_VER,
+            rsp_caps: 0,
         }
     }
 
@@ -193,4 +206,63 @@ pub(crate) fn get_version(&mut self) -> Result<(), Error> {
 
         Ok(())
     }
+
+    /// Obtain the supported capabilities from an SPDM session and store the
+    /// information in the `SpdmState`.
+    pub(crate) fn get_capabilities(&mut self) -> Result<(), Error> {
+        let mut request = GetCapabilitiesReq::default();
+        request.header.version = self.version;
+
+        let rsp_sz = match self.version {
+            SPDM_VER_10 | SPDM_VER_11 => {
+                core::mem::size_of::<SpdmHeader>() + 4 + core::mem::size_of::<u32>()
+            }
+            _ => {
+                request.data_transfer_size = self.transport_sz;
+                request.max_spdm_msg_size = self.transport_sz;
+
+                (GET_CAPABILITIES_RSP_SZ + PAGE_SIZE).min(self.data_transfer_sz as usize)
+            }
+        };
+
+        let mut request_buf = request.to_bytes()?;
+
+        let response_vec: KVec<u8> = KVec::from_elem(0u8, rsp_sz, GFP_KERNEL)?;
+
+        let response: GetCapabilitiesRsp = self
+            .spdm_exchange(request_buf.as_mut_slice(), response_vec)?
+            .validate(&*self)?;
+
+        self.rsp_caps = response.flags;
+        if (self.rsp_caps & SPDM_RSP_MIN_CAPS) != SPDM_RSP_MIN_CAPS {
+            dev_err!(
+                &self.dev,
+                "{:#x} capabilities are supported, which don't meet required {:#x}\n",
+                self.rsp_caps,
+                SPDM_RSP_MIN_CAPS
+            );
+            self.rsp_caps = 0;
+            return Err(EPROTONOSUPPORT);
+        }
+
+        if self.rsp_caps & SPDM_MULTI_KEY_CAP != 0
+            && self.rsp_caps & SPDM_MULTI_KEY_CAP != 0b10 << 26
+        {
+            dev_err!(
+                &self.dev,
+                "Multi-key capable responders are not supported\n"
+            );
+            self.rsp_caps = 0;
+            return Err(EPROTONOSUPPORT);
+        }
+
+        if self.version >= SPDM_VER_12 {
+            // Negotiate the session's transfer size without permanently
+            // shrinking the transport's own capability, so that
+            // re-authentication starts from `transport_sz` again.
+            self.data_transfer_sz = self.transport_sz.min(response.data_transfer_size);
+        }
+
+        Ok(())
+    }
 }
diff --git a/lib/rspdm/validator.rs b/lib/rspdm/validator.rs
index 234398734a536..66212f0faf5f1 100644
--- a/lib/rspdm/validator.rs
+++ b/lib/rspdm/validator.rs
@@ -8,8 +8,16 @@
 //! <https://www.dmtf.org/dsp/DSP0274>
 
 use crate::consts::{
+    SPDM_CAP_SUPPORTED_ALGORITHMS,
+    SPDM_CTEXPONENT,
+    SPDM_GET_CAPABILITIES,
     SPDM_GET_VERSION,
-    SPDM_MIN_VER, //
+    SPDM_MIN_DATA_TRANSFER_SIZE,
+    SPDM_MIN_VER,
+    SPDM_REQ_CAPS,
+    SPDM_VER_10,
+    SPDM_VER_11,
+    SPDM_VER_12, //
 };
 use crate::{
     SpdmErrorCode,
@@ -176,3 +184,311 @@ fn validate(unvalidated: KVec<u8>, context: &'c SpdmState<T>) -> Result<Self, Se
         })
     }
 }
+
+pub(crate) struct GetCapabilitiesReq {
+    pub(crate) header: SpdmHeader,
+
+    pub(crate) ctexponent: u8,
+
+    pub(crate) flags: u32,
+
+    /* End of SPDM 1.1 structure */
+    pub(crate) data_transfer_size: u32,
+    pub(crate) max_spdm_msg_size: u32,
+}
+
+impl GetCapabilitiesReq {
+    pub(crate) fn to_bytes(&self) -> Result<KVec<u8>> {
+        let mut out = self.header.to_bytes()?;
+
+        if self.header.version <= SPDM_VER_10 {
+            return Ok(out);
+        }
+
+        out.push(0u8, GFP_KERNEL)?;
+        out.push(self.ctexponent, GFP_KERNEL)?;
+
+        out.extend_from_slice(&[0u8; 2], GFP_KERNEL)?;
+        out.extend_from_slice(&self.flags.to_le_bytes(), GFP_KERNEL)?;
+
+        if self.header.version >= SPDM_VER_12 {
+            out.extend_from_slice(&self.data_transfer_size.to_le_bytes(), GFP_KERNEL)?;
+            out.extend_from_slice(&self.max_spdm_msg_size.to_le_bytes(), GFP_KERNEL)?;
+        }
+
+        Ok(out)
+    }
+}
+
+impl Default for GetCapabilitiesReq {
+    fn default() -> Self {
+        GetCapabilitiesReq {
+            header: SpdmHeader::new(SPDM_GET_CAPABILITIES),
+
+            ctexponent: SPDM_CTEXPONENT,
+            flags: SPDM_REQ_CAPS,
+            data_transfer_size: 0,
+            max_spdm_msg_size: 0,
+        }
+    }
+}
+
+/// Response AlgStructure field format
+#[expect(dead_code)]
+pub(crate) struct RespAlgStruct {
+    pub(crate) alg_type: u8,
+    pub(crate) alg_count: u8,
+    pub(crate) alg_supported: KVec<u8>,
+    pub(crate) alg_external: KVec<u32>,
+}
+
+pub(crate) const GET_CAPABILITIES_RSP_SZ: usize = mem::size_of::<SpdmHeader>() + 16;
+
+/// The GET_CAPABILITIES SupportedAlgorithms block (SPDM 1.3+).
+///
+/// Conforms to the NEGOTIATE_ALGORITHMS request message format,
+/// including all fields from Param1 through the end of the message inclusive.
+/// The `Length` field is equal to the total size of the block (`AlgSize`).
+#[expect(dead_code)]
+pub(crate) struct SupportedAlgorithms {
+    /// param1
+    pub(crate) alg_struct_count: u8,
+    pub(crate) length: u16,
+
+    pub(crate) measurement_specification: u8,
+    pub(crate) other_params_support: u8,
+
+    pub(crate) base_asym_algo: u32,
+    pub(crate) base_hash_algo: u32,
+
+    pub(crate) ext_asym_count: u8,
+    pub(crate) ext_hash_count: u8,
+
+    pub(crate) mel_specification: u8,
+
+    pub(crate) ext_asym: KVec<u32>,
+    pub(crate) ext_hash: KVec<u32>,
+    pub(crate) alg_struct: KVec<RespAlgStruct>,
+}
+
+impl SupportedAlgorithms {
+    #[allow(clippy::get_first)]
+    fn from_bytes<T: Transport>(buf: &[u8], context: &SpdmState<T>) -> Result<Self, Error> {
+        let read_le16 = |off: usize| -> Result<u16, Error> {
+            Ok(u16::from_le_bytes(
+                buf.get(off..off + mem::size_of::<u16>())
+                    .ok_or(EPROTO)?
+                    .try_into()
+                    .map_err(|_| EPROTO)?,
+            ))
+        };
+        let read_le32 = |off: usize| -> Result<u32, Error> {
+            Ok(u32::from_le_bytes(
+                buf.get(off..off + mem::size_of::<u32>())
+                    .ok_or(EPROTO)?
+                    .try_into()
+                    .map_err(|_| EPROTO)?,
+            ))
+        };
+
+        let alg_struct_count = *buf.get(0).ok_or(EPROTO)?;
+        let length = read_le16(2)?;
+        let measurement_specification = *buf.get(4).ok_or(EPROTO)?;
+        let other_params_support = *buf.get(5).ok_or(EPROTO)?;
+        let base_asym_algo = read_le32(6)?;
+        let base_hash_algo = read_le32(10)?;
+        let ext_asym_count = *buf.get(26).ok_or(EPROTO)?;
+        let ext_hash_count = *buf.get(27).ok_or(EPROTO)?;
+        let mel_specification = *buf.get(29).ok_or(EPROTO)?;
+
+        let mut offset = 30;
+
+        let mut ext_asym = KVec::new();
+        for _ in 0..ext_asym_count {
+            ext_asym.push(read_le32(offset)?, GFP_KERNEL)?;
+            offset += mem::size_of::<u32>();
+        }
+
+        let mut ext_hash = KVec::new();
+        for _ in 0..ext_hash_count {
+            ext_hash.push(read_le32(offset)?, GFP_KERNEL)?;
+            offset += mem::size_of::<u32>();
+        }
+
+        let mut alg_struct = KVec::new();
+        for _ in 0..alg_struct_count {
+            let alg_type = *buf.get(offset).ok_or(EPROTO)?;
+            let alg_count = *buf.get(offset + 1).ok_or(EPROTO)?;
+
+            let fixed_alg_count = (alg_count >> 4) as usize;
+            let ext_alg_count = (alg_count & 0xf) as usize;
+
+            offset += 2;
+
+            let mut alg_supported = KVec::new();
+            alg_supported.extend_from_slice(
+                buf.get(offset..offset + fixed_alg_count).ok_or(EPROTO)?,
+                GFP_KERNEL,
+            )?;
+            offset += fixed_alg_count;
+
+            let mut alg_external = KVec::new();
+            for _ in 0..ext_alg_count {
+                alg_external.push(read_le32(offset)?, GFP_KERNEL)?;
+                offset += mem::size_of::<u32>();
+            }
+
+            alg_struct.push(
+                RespAlgStruct {
+                    alg_type,
+                    alg_count,
+                    alg_supported,
+                    alg_external,
+                },
+                GFP_KERNEL,
+            )?;
+        }
+
+        if length as usize != offset {
+            dev_err!(&context.dev, "Malformed SupportedAlgorithms block\n");
+            return Err(EPROTO);
+        }
+
+        Ok(SupportedAlgorithms {
+            alg_struct_count,
+            length,
+            measurement_specification,
+            other_params_support,
+            base_asym_algo,
+            base_hash_algo,
+            ext_asym_count,
+            ext_hash_count,
+            mel_specification,
+            ext_asym,
+            ext_hash,
+            alg_struct,
+        })
+    }
+}
+
+#[expect(dead_code)]
+pub(crate) struct GetCapabilitiesRsp {
+    pub(crate) header: SpdmHeader,
+
+    pub(crate) ctexponent: u8,
+    pub(crate) flags: u32,
+
+    // End of SPDM 1.1 structure
+    pub(crate) data_transfer_size: u32,
+    pub(crate) max_spdm_msg_size: u32,
+
+    pub(crate) supported_algorithms: Option<SupportedAlgorithms>,
+
+    /// The actual length of the SPDM message. `raw_bytes` might be longer
+    /// as it includes transport specific padding.
+    length: usize,
+
+    /// Entire response, used for the transcript hash.
+    raw_bytes: KVec<u8>,
+}
+
+impl GetCapabilitiesRsp {
+    #[expect(dead_code)]
+    pub(crate) fn as_bytes(&self) -> Result<&[u8], Error> {
+        self.raw_bytes.get(..self.length).ok_or(EPROTO)
+    }
+}
+
+impl<'c, T: Transport> Validate<'c, Untrusted<KVec<u8>>, &'c SpdmState<T>> for GetCapabilitiesRsp {
+    type Err = Error;
+
+    fn validate(unvalidated: KVec<u8>, context: &'c SpdmState<T>) -> Result<Self, Self::Err> {
+        let header: SpdmHeader =
+            Untrusted::new(unvalidated.get(0..4).ok_or(EPROTO)?).validate(context)?;
+
+        if header.code != SPDM_GET_CAPABILITIES - 0x80 {
+            return Err(EPROTO);
+        }
+
+        if header.version != context.version {
+            dev_err!(&context.dev, "Invalid version response\n");
+            return Err(EPROTO);
+        }
+
+        let ctexponent = *unvalidated.get(5).ok_or(EPROTO)?;
+        let flags = u32::from_le_bytes(
+            unvalidated
+                .get(8..12)
+                .ok_or(EPROTO)?
+                .try_into()
+                .map_err(|_| EPROTO)?,
+        );
+
+        // DataTransferSize and MaxSPDMmsgSize only exist in SPDM 1.2 and later.
+        let (data_transfer_size, max_spdm_msg_size, supported_algorithms, length) = if context
+            .version
+            <= SPDM_VER_11
+        {
+            (
+                0,
+                0,
+                None,
+                mem::size_of::<SpdmHeader>() + 4 + mem::size_of::<u32>(),
+            )
+        } else {
+            let data_transfer_size = u32::from_le_bytes(
+                unvalidated
+                    .get(12..16)
+                    .ok_or(EPROTO)?
+                    .try_into()
+                    .map_err(|_| EPROTO)?,
+            );
+            let max_spdm_msg_size = u32::from_le_bytes(
+                unvalidated
+                    .get(16..20)
+                    .ok_or(EPROTO)?
+                    .try_into()
+                    .map_err(|_| EPROTO)?,
+            );
+
+            if data_transfer_size < SPDM_MIN_DATA_TRANSFER_SIZE {
+                dev_err!(&context.dev,
+                        "Invalid minimum transport size {data_transfer_size}, must be at least {SPDM_MIN_DATA_TRANSFER_SIZE}\n"
+                    );
+                return Err(EPROTONOSUPPORT);
+            }
+
+            let supported_algorithms = if header.param1 & SPDM_CAP_SUPPORTED_ALGORITHMS != 0 {
+                Some(SupportedAlgorithms::from_bytes(
+                    unvalidated.get(GET_CAPABILITIES_RSP_SZ..).ok_or(EPROTO)?,
+                    context,
+                )?)
+            } else {
+                None
+            };
+
+            let length = GET_CAPABILITIES_RSP_SZ
+                + supported_algorithms
+                    .as_ref()
+                    .map_or(0, |s| s.length as usize);
+
+            (
+                data_transfer_size,
+                max_spdm_msg_size,
+                supported_algorithms,
+                length,
+            )
+        };
+
+        Ok(GetCapabilitiesRsp {
+            header,
+            ctexponent,
+            flags,
+            data_transfer_size,
+            max_spdm_msg_size,
+            supported_algorithms,
+            length,
+            raw_bytes: unvalidated,
+        })
+    }
+}
-- 
2.56.0

