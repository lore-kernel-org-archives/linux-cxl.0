Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794284531;
	b=uSgk2mZgawIMjp8bCCFkM8L3oVKkRFxKX5BhrLJXZwVZGDbggEleze3E81Lek8o+FQPx
	 zb166aqbIyQjx4oDoRhVurKLlSbxvSTxFiCc8MmS7KdmIG/DMOKnh99S/ttkPv7+NbaqM
	 XaKFv1b6ypmWyLrdwZxOp71ltIS1RR3E1+5fd18bNrM+VHoV1HNWBtnuZJ4P1newHL0HZ
	 UoysVKwv1ju8LBcrYt7a6JeM2bVMW7T8etJ+jO69MLwlwN78QVLEVDImWt4cdDhJJD9mA
	 j4/fSL/qWhEOqBAjXtyowUORK5JtGQey2JJ+yh8PPI9ZO0vlfWIAOq3YTfq9aSoHO7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794284531;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hElMjptUOt7t67BL+1cimQWcisWptb+S2Cms/oh/gUI=;
	b=xKkDJVGU2Wl1zPeG+RzUAgrEoV9S+kzPg+JtmclgW6b7PWRUwncu/YznvP5eS9wAa31L
	 6FXcoNEdolnK+F+vmDC/AhqoVRQX5Tr4gyTJ5h1zbwwcIiRqVzvD1vqgdc/FxLLz614nc
	 2mVf9KItuwiqrgCxMucskhpa1klMKBo2N8EBivRfxKxv40JzwOlFcbp7O4FycE3cYJE3l
	 dOBI0cy7+NlrJ0jjJWW+4Sx25IcOdtVxoYwEltVkGzLxrcQCQCvcTas7l9jXVaswBwwm5
	 Ht2fa8SbRzZ9OIIospHNqeooaq8hUVG39ZqAxcXsOoBPWJY8/2MSeEf1EVRJ4npT3rQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="L2i2ifc/";
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001F0606A70E
	for <linux-cxl@vger.kernel.org>; Tue, 10 Nov 2026 04:22:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 001F0606A70E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L2i2ifc/
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1b3a05f8b5bso2463253c88.1
        for <linux-cxl@vger.kernel.org>; Mon, 09 Nov 2026 20:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794284529; x=1794889329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hElMjptUOt7t67BL+1cimQWcisWptb+S2Cms/oh/gUI=;
        b=L2i2ifc/1MRyuJOahGMZGz1QyhrPCpyGs/qHpXMbAD0EK0iOT/D/juMf+9dbSBLoIB
         P5kpH6KfvlFg8ikFV2uhM2LMI5DQLwXiS5tRm3z1u90iBKmuPoRfXFAcAqbZXMbTlwcr
         XuvwOZPOwU6WqkOECWjuwya/ox3QvPjttEqtnHmp7pTt/ngKwrzX7lsYY1Js15aLiaU6
         BBkfwUYt9Dk4tAxVeoc2oX3LCEvb4/srBh+JFNJwAN/gVxr6TAOMtZYCStSjqtNH5HqP
         SyUNinAr9cKkPJ2mSmTwcSWi1dsF438ZJU8QNNF29GNtYi7mrS7qmFSc95vBHvVbdhdH
         DWpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794284529; x=1794889329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hElMjptUOt7t67BL+1cimQWcisWptb+S2Cms/oh/gUI=;
        b=NvacF0U4YMvYjPA62UKkEuhze55lzsVd+zYV7Q7bw/Qg9d+5ltjh+IGxkSb+O5fStu
         W552JXfKzu3+XQksGTdWHNt3jTu6TCFvsxIereXMF7z8V4zmwOH/55MJE3mH6rG4vnzR
         4cKpsdPmD8hLH+Wf3DQ9cf03suE2xrW8kB/gDLoTe70pH/L0buMN/JTwtp7oavvizJkW
         h8UOKEfN0bsXFvQ6OjzrMhqmiImmsAb45kBXIcQdzDq5XrjHg9BoXxVHvGd7efVnPofA
         FCWkTRacAnuMEiB9HQq5V6OdajeuWhlkbowi3kQE44wqurP+A6sxc6pvIhj3vzh2rsXc
         0HqA==
X-Forwarded-Encrypted: i=1; AL+hErHK49A7WYdf1TzNrVPb/bIDZj5engF6X80HkmYmULySXG9ehf6ElFqMaBviS5d33dbN7ezjD1kcmmk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9rVIXjwldMPYVti8bW/nkc+e27ocOVSmpp1oZjeaSPmQ/8ZYyH
	NdF+jjWnwuZVF4izo4Fn+b6HoSmQMJI1bveNV/zePZs8Ec12wcWNIz3a9Y+VWg==
X-Gm-Gg: AYBFou3FePMQaDFN5LerdnwONIgWfsSLBKmRHJBPtIQt4j42nYHEUu/6jlI3URRecn/
	2plmGXd8ltqGmR9jmkLTiz/usZJmKOq7TJGXiwgUsUFoK7pAAI+UmEluCU4aTMOM+VsMUpUthZH
	/jUxbDavLadMUNIOWBWLbtiu73malh52MYntJFlk6G/9BLkTKHExYELGUmskyIxnZoxoiT+ZKbZ
	Xv+17WQP2kKWDKde7z+8NYXK5A8v3P+6gTxzFpuPsHKrT5rm9gX326hIzOAfP6uCFdlelq3qgYH
	iOvwbh3HIFWzorEPWa4cn2oai0zhQb3oc6c1/UdTFntJnS7lSVdbrPs6uEVd1cVeC0EMWTwrpce
	PDT0AioxhR6sF/9xuUkcFB0w/TofJWSBHiypVLgxr73jWThuOFvdvbN+XVwjC/l2L096BB+Ph1s
	SGOW7X1/0GcTNTvYhIegTZ10U4ymDeJ2xkbwC3UGO5tQyy5bXSMB3kdi918MuglUa6Z+0jJ2b2o
	soBzbrmSGKMpsQ9M/R43Zc5im+GWk6aWB5mTD/v2I1rPvceltNiWZSY/wB48z9URtcgPTdVFkjG
	0qJ1TYTtktagA96dOUSA1163C///rEqaBng667z0TzYRdUYQ4UZy8gRWtraF7OZ0du8J
X-Received: by 2002:a05:7022:ea55:10b0:1b2:6cba:7f7c with SMTP id a92af1059eb24-1b3b605183cmr2168503c88.37.1794284529052;
        Mon, 09 Nov 2026 20:22:09 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b7ba88sm3540459c88.22.2026.11.09.20.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 20:22:08 -0800 (PST)
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
Subject: [PATCH v6 24/25] lib: rspdm: Support SPDM challenge
Date: Tue, 10 Nov 2026 14:18:31 +1000
Message-ID: <20261110041832.1730924-25-alistair.francis@wdc.com>
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

Support the CHALLENGE SPDM command.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 lib/rspdm/consts.rs    |   6 ++
 lib/rspdm/lib.rs       |  10 +-
 lib/rspdm/state.rs     | 206 ++++++++++++++++++++++++++++++++++++++++-
 lib/rspdm/validator.rs | 156 ++++++++++++++++++++++++++++++-
 4 files changed, 365 insertions(+), 13 deletions(-)

diff --git a/lib/rspdm/consts.rs b/lib/rspdm/consts.rs
index b76bab8894b9e..0807788055f0c 100644
--- a/lib/rspdm/consts.rs
+++ b/lib/rspdm/consts.rs
@@ -87,6 +87,8 @@
 
 pub(crate) const SPDM_GET_CERTIFICATE: u8 = 0x82;
 
+pub(crate) const SPDM_CHALLENGE: u8 = 0x83;
+
 // If the crypto support isn't enabled don't offer the algorithms
 // to the responder
 #[cfg(CONFIG_CRYPTO_RSA)]
@@ -115,3 +117,7 @@
 pub(crate) const SPDM_HASH_ALGOS: u32 = SPDM_HASH_SHA2_256 | SPDM_HASH_SHA2_384_512;
 
 pub(crate) const SPDM_OPAQUE_DATA_FMT_GENERAL: u8 = bit_u8(1);
+
+pub(crate) const SPDM_PREFIX_SZ: usize = 64;
+pub(crate) const SPDM_COMBINED_PREFIX_SZ: usize = 100;
+pub(crate) const SPDM_MAX_OPAQUE_DATA: usize = 1024;
diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
index 44fab9caf1877..6bfe1eedc4121 100644
--- a/lib/rspdm/lib.rs
+++ b/lib/rspdm/lib.rs
@@ -11,8 +11,7 @@
 //! from other subsytems.
 
 use crate::bindings::{
-    spdm_state,
-    EPROTONOSUPPORT, //
+    spdm_state, //
 };
 use core::ptr;
 use kernel::prelude::*;
@@ -307,7 +306,12 @@ fn from(code: SpdmErrorCode) -> Self {
         provisioned_slots &= !(1 << slot);
     }
 
-    -(EPROTONOSUPPORT as i32)
+    let provisioned_slots = state.provisioned_slots.trailing_zeros();
+    if let Err(e) = state.challenge(provisioned_slots as u8) {
+        return e.to_errno() as c_int;
+    }
+
+    0
 }
 
 /// Destroys an SPDM session.
diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
index dfe2f8becfb74..059398e95b92d 100644
--- a/lib/rspdm/state.rs
+++ b/lib/rspdm/state.rs
@@ -19,6 +19,7 @@
     page::PAGE_SIZE,
     public_key::PublicKey,
     str::CStr,
+    str::CString,
     sync::aref::ARef,
     validate::Untrusted,
     x509::Certificate, //
@@ -26,16 +27,19 @@
 
 use crate::consts::{
     SPDM_ASYM_ALGOS,
+    SPDM_COMBINED_PREFIX_SZ,
     SPDM_ERROR,
     SPDM_GET_VERSION_LEN,
     SPDM_HASH_ALGOS,
     SPDM_KEY_EX_CAP,
+    SPDM_MAX_OPAQUE_DATA,
     SPDM_MAX_VER,
     SPDM_MEAS_RESP_CAP,
     SPDM_MEAS_SPEC_DMTF,
     SPDM_MIN_VER,
     SPDM_MULTI_KEY_CAP,
     SPDM_OPAQUE_DATA_FMT_GENERAL,
+    SPDM_PREFIX_SZ,
     SPDM_REQ,
     SPDM_RSP_MIN_CAPS,
     SPDM_SLOTS,
@@ -65,6 +69,8 @@
     SPDM_HASH_SHA_512, //
 };
 use crate::validator::{
+    ChallengeReq,
+    ChallengeRsp,
     GetCapabilitiesReq,
     GetCapabilitiesRsp,
     GetCertificateReq,
@@ -84,6 +90,8 @@
     SPDM_CERT_CHAIN_HDR_SZ, //
 };
 
+const SPDM_CONTEXT: &str = "responder-challenge_auth signing";
+
 /// Transport for exchanging SPDM messages with a responder device.
 ///
 /// This trait abstracts the bus-specific message transport (for example
@@ -154,7 +162,7 @@ pub(crate) struct SpdmState<T: Transport> {
     base_asym_enc: &'static CStr,
     /// Signature length of `base_asym_alg` (in bytes). S or SigLen in SPDM
     /// specification.
-    sig_len: usize,
+    pub(crate) sig_len: usize,
 
     /// Hash transformation for `base_hash_alg` computation.
     crypto: Option<Shash>,
@@ -168,6 +176,16 @@ pub(crate) struct SpdmState<T: Transport> {
     /// Public key portion of leaf certificate against which to check
     /// responder's signatures.
     pub(crate) leaf_key: Option<PublicKey>,
+
+    /// Concatenation of all SPDM messages exchanged during an authentication
+    /// or measurement sequence. Used to verify the signature, as it is
+    /// computed over the hashed transcript.
+    transcript: VVec<u8>,
+
+    /// Requester nonce to be used for the next authentication sequence.
+    /// Populated from user space through sysfs. If user space does not
+    /// provide a nonce, the kernel uses a random one.
+    pub(crate) next_nonce: KVec<u8>,
 }
 
 impl<T: Transport> SpdmState<T> {
@@ -201,6 +219,8 @@ pub(crate) fn new(
             certs: [const { KVec::new() }; SPDM_SLOTS],
             digests: [const { KVec::new() }; SPDM_SLOTS],
             leaf_key: None,
+            transcript: VVec::new(),
+            next_nonce: KVec::new(),
         }
     }
 
@@ -217,12 +237,14 @@ pub(crate) fn hash_len(&self) -> usize {
     /// The data in `request_buf` is sent to the device and the response
     /// is returned as untrusted data to be validated by the caller.
     pub(crate) fn spdm_exchange(
-        &self,
+        &mut self,
         request_buf: &[u8],
         mut response_buf: KVec<u8>,
     ) -> Result<Untrusted<KVec<u8>>, Error> {
         let header_size = core::mem::size_of::<SpdmHeader>();
-        let request: SpdmHeader = Untrusted::new(request_buf).validate(self)?;
+        let request: SpdmHeader = Untrusted::new(request_buf).validate(&*self)?;
+
+        self.transcript.extend_from_slice(request_buf, GFP_KERNEL)?;
 
         let length =
             self.transport
@@ -240,11 +262,11 @@ pub(crate) fn spdm_exchange(
         response_buf.truncate(length);
 
         let response: SpdmHeader =
-            Untrusted::new(response_buf.get(..header_size).ok_or(EPROTO)?).validate(self)?;
+            Untrusted::new(response_buf.get(..header_size).ok_or(EPROTO)?).validate(&*self)?;
 
         if response.code == SPDM_ERROR {
             let error_rsp: SpdmErrorRsp =
-                Untrusted::new(response_buf.get(..header_size).ok_or(EPROTO)?).validate(self)?;
+                Untrusted::new(response_buf.get(..header_size).ok_or(EPROTO)?).validate(&*self)?;
             dev_err!(&self.dev, "Error response: {error_rsp:?}\n");
             return Err(error_rsp.error_code.into());
         }
@@ -272,6 +294,8 @@ pub(crate) fn get_version(&mut self) -> Result<(), Error> {
         // Reset all negotiated session state as we are re-authenticating
         self.data_transfer_sz = self.transport_sz;
 
+        self.transcript.clear();
+
         for digest in self.digests.as_mut() {
             digest.clear();
         }
@@ -287,6 +311,9 @@ pub(crate) fn get_version(&mut self) -> Result<(), Error> {
             .spdm_exchange(request_buf.as_mut_slice(), response_vec)?
             .validate(&*self)?;
 
+        self.transcript
+            .extend_from_slice(response.as_bytes()?, GFP_KERNEL)?;
+
         let mut foundver = false;
         for &entry in response.version_number_entries.iter() {
             let alpha_version = (entry & 0xF) as u8;
@@ -340,7 +367,11 @@ pub(crate) fn get_capabilities(&mut self) -> Result<(), Error> {
             .spdm_exchange(request_buf.as_mut_slice(), response_vec)?
             .validate(&*self)?;
 
+        self.transcript
+            .extend_from_slice(response.as_bytes()?, GFP_KERNEL)?;
+
         self.rsp_caps = response.flags;
+
         if (self.rsp_caps & SPDM_RSP_MIN_CAPS) != SPDM_RSP_MIN_CAPS {
             dev_err!(
                 &self.dev,
@@ -451,6 +482,9 @@ pub(crate) fn negotiate_algs(&mut self) -> Result<(), Error> {
             .spdm_exchange(request_buf.as_mut_slice(), response_vec)?
             .validate(&*self)?;
 
+        self.transcript
+            .extend_from_slice(response.as_bytes()?, GFP_KERNEL)?;
+
         self.base_asym_alg = response.base_asym_sel;
         self.base_hash_alg = response.base_hash_sel;
         self.meas_hash_alg = response.measurement_hash_algo;
@@ -496,6 +530,9 @@ pub(crate) fn get_digests(&mut self) -> Result<(), Error> {
             .spdm_exchange(request_buf.as_mut_slice(), response_vec)?
             .validate(&*self)?;
 
+        self.transcript
+            .extend_from_slice(response.as_bytes()?, GFP_KERNEL)?;
+
         let mut deprovisioned_slots = self.provisioned_slots & !response.header.param2;
         while (deprovisioned_slots.trailing_zeros() as usize) < SPDM_SLOTS {
             let slot = deprovisioned_slots.trailing_zeros() as usize;
@@ -535,6 +572,9 @@ pub(crate) fn get_certificate(&mut self, slot: u8) -> Result<(), Error> {
             .spdm_exchange(request_buf.as_mut_slice(), response_vec)?
             .validate(&*self)?;
 
+        self.transcript
+            .extend_from_slice(response.as_bytes()?, GFP_KERNEL)?;
+
         if (response.header.param1 & 0xF) != slot {
             dev_err!(&self.dev, "Invalid slot response\n");
             return Err(EPROTO);
@@ -568,6 +608,9 @@ pub(crate) fn get_certificate(&mut self, slot: u8) -> Result<(), Error> {
                 .spdm_exchange(request_buf.as_mut_slice(), response_vec)?
                 .validate(&*self)?;
 
+            self.transcript
+                .extend_from_slice(response.as_bytes()?, GFP_KERNEL)?;
+
             let portion_length = response.portion_length;
             let rem_length = response.remainder_length;
 
@@ -764,4 +807,157 @@ pub(crate) fn validate_cert_chain(&mut self, slot: u8) -> Result<(), Error> {
 
         Ok(())
     }
+
+    pub(crate) fn challenge_rsp_len(&mut self, nonce_len: usize, opaque_len: usize) -> usize {
+        // No measurement summary hash requested (MSHLength == 0)
+        let mut length =
+            core::mem::size_of::<SpdmHeader>() + self.hash_len() + nonce_len + opaque_len + 2;
+
+        if self.version >= SPDM_VER_13 {
+            length += 8;
+        }
+
+        length + self.sig_len
+    }
+
+    fn verify_signature(&mut self, signature: &mut [u8]) -> Result<(), Error> {
+        let crypto = self.crypto.as_mut().ok_or(EPROTO)?;
+        let leaf_key = self.leaf_key.as_ref().ok_or(EPROTO)?;
+        let hash_len = crypto.hash_len();
+        let sig_len = self.sig_len;
+
+        if self.transcript.len() <= sig_len {
+            return Err(EPROTO);
+        }
+
+        let mut m: KVec<u8> = KVec::new();
+        m.extend_with(SPDM_COMBINED_PREFIX_SZ + hash_len, 0, GFP_KERNEL)?;
+
+        // Generate the `unverified_message_hash`, which is the hash of the
+        // `unverified_data` (Chapter 16 - "Signature Verification").
+        crypto.digest(
+            &self.transcript[..(self.transcript.len() - sig_len)],
+            &mut m[SPDM_COMBINED_PREFIX_SZ..],
+        )?;
+
+        // Must be in scope whenever `sig` is used
+        let mut mhash: KVec<u8> = KVec::new();
+
+        let message = if self.version <= SPDM_VER_11 {
+            &m[SPDM_COMBINED_PREFIX_SZ..]
+        } else {
+            // `M` shall be the concatenation of the `combined_spdm_prefix`
+            // and `unverified_message_hash`. We use `M` for pub/priv
+            // signature verification below.
+            // (Chapter 16 - "Signature Verification")
+
+            let major = self.version >> 4;
+            let minor = self.version & 0xF;
+
+            // Generate the `spdm_prefix` (Chapter 15 - "Signature generation")
+            let prefix = CString::try_from_fmt(fmt!("dmtf-spdm-v{major:x}.{minor:x}.*dmtf-spdm-v{major:x}.{minor:x}.*dmtf-spdm-v{major:x}.{minor:x}.*dmtf-spdm-v{major:x}.{minor:x}.*"))?;
+
+            if prefix.to_bytes().len() != SPDM_PREFIX_SZ {
+                dev_err!(&self.dev, "spdm_prefix length is incorrect\n");
+                return Err(EPROTO);
+            }
+
+            // Build the `combined_spdm_prefix` (Chapter 15 - "Signature
+            // generation") directly in `m`: the 64 byte `spdm_prefix`, zero
+            // padding, followed by the 36 byte `spdm_context`. `m` was zero
+            // initialised above with the `unverified_message_hash` copied
+            // in at offset SPDM_COMBINED_PREFIX_SZ, so only the two
+            // non-zero portions need to be written.
+            m[..SPDM_PREFIX_SZ].copy_from_slice(prefix.to_bytes());
+            m[SPDM_COMBINED_PREFIX_SZ - SPDM_CONTEXT.len()..SPDM_COMBINED_PREFIX_SZ]
+                .copy_from_slice(SPDM_CONTEXT.as_bytes());
+
+            // Generate a hash of `M` and use that for signature
+            // verification (RSA or ECDSA)
+            mhash.extend_with(hash_len, 0, GFP_KERNEL)?;
+            crypto.digest(m.as_slice(), mhash.as_mut_slice())?;
+
+            mhash.as_slice()
+        };
+
+        // Finally verify the generated signature against the public key
+        leaf_key.verify_signature(signature, self.base_asym_enc, crypto.name(), message)
+    }
+
+    pub(crate) fn challenge(&mut self, slot: u8) -> Result<(), Error> {
+        let mut request = ChallengeReq::default();
+        request.header.version = self.version;
+        request.header.param1 = slot;
+
+        let nonce_len = request.nonce.len();
+
+        if !self.next_nonce.is_empty() {
+            let request_nonce_len = request.nonce.len();
+
+            if self.next_nonce.len() == request_nonce_len {
+                request
+                    .nonce
+                    .copy_from_slice(&self.next_nonce[..request_nonce_len]);
+            } else {
+                return Err(EINVAL);
+            }
+
+            self.next_nonce.clear();
+        } else {
+            // SAFETY: `request.nonce` is a valid buffer of `nonce_len` length.
+            unsafe {
+                bindings::get_random_bytes(
+                    core::ptr::from_mut(&mut request.nonce).cast::<c_void>(),
+                    nonce_len,
+                )
+            };
+        }
+
+        let rsp_sz = self.challenge_rsp_len(nonce_len, SPDM_MAX_OPAQUE_DATA);
+
+        let mut request_buf = request.to_bytes()?;
+
+        let response_vec: KVec<u8> = KVec::from_elem(0u8, rsp_sz, GFP_KERNEL)?;
+
+        let mut response: ChallengeRsp = self
+            .spdm_exchange(request_buf.as_mut_slice(), response_vec)?
+            .validate(&*self)?;
+
+        self.transcript
+            .extend_from_slice(response.as_bytes()?, GFP_KERNEL)?;
+
+        if request.context != response.context {
+            dev_err!(&self.dev, "Mismatched challenge context response\n");
+            return Err(EPROTO);
+        }
+
+        if (response.header.param1 & 0xF) != slot {
+            dev_err!(&self.dev, "Invalid slot in challenge response\n");
+            return Err(EPROTO);
+        }
+
+        let crypto = self.crypto.as_mut().ok_or(EPROTO)?;
+        let mut hash: KVec<u8> = KVec::new();
+        hash.extend_with(crypto.hash_len(), 0, GFP_KERNEL)?;
+        crypto.digest(&self.certs[slot as usize], hash.as_mut_slice())?;
+
+        if hash.as_slice() != response.cert_chain_hash.as_slice() {
+            dev_err!(
+                &self.dev,
+                "Certificate chain hash mismatch in challenge response\n"
+            );
+            return Err(EKEYREJECTED);
+        }
+
+        match self.verify_signature(&mut response.signature) {
+            Ok(()) => {
+                dev_info!(&self.dev, "Authenticated with certificate slot {slot}\n");
+                Ok(())
+            }
+            Err(e) => {
+                dev_err!(&self.dev, "Cannot verify challenge_auth signature: {e:?}\n");
+                Err(EPROTO)
+            }
+        }
+    }
 }
diff --git a/lib/rspdm/validator.rs b/lib/rspdm/validator.rs
index dad8482525794..1d02d0d2d6d34 100644
--- a/lib/rspdm/validator.rs
+++ b/lib/rspdm/validator.rs
@@ -10,12 +10,14 @@
 use crate::consts::{
     SPDM_ASYM_ALGOS,
     SPDM_CAP_SUPPORTED_ALGORITHMS,
+    SPDM_CHALLENGE,
     SPDM_CTEXPONENT,
     SPDM_GET_CAPABILITIES,
     SPDM_GET_CERTIFICATE,
     SPDM_GET_DIGESTS,
     SPDM_GET_VERSION,
     SPDM_HASH_ALGOS,
+    SPDM_MAX_OPAQUE_DATA,
     SPDM_MEAS_SPEC_DMTF,
     SPDM_MIN_DATA_TRANSFER_SIZE,
     SPDM_MIN_VER,
@@ -145,7 +147,6 @@ pub(crate) struct GetVersionRsp {
 }
 
 impl GetVersionRsp {
-    #[expect(dead_code)]
     pub(crate) fn as_bytes(&self) -> Result<&[u8], Error> {
         self.raw_bytes.get(..self.length).ok_or(EPROTO)
     }
@@ -402,7 +403,6 @@ pub(crate) struct GetCapabilitiesRsp {
 }
 
 impl GetCapabilitiesRsp {
-    #[expect(dead_code)]
     pub(crate) fn as_bytes(&self) -> Result<&[u8], Error> {
         self.raw_bytes.get(..self.length).ok_or(EPROTO)
     }
@@ -592,7 +592,6 @@ pub(crate) struct NegotiateAlgsRsp {
 }
 
 impl NegotiateAlgsRsp {
-    #[expect(dead_code)]
     pub(crate) fn as_bytes(&self) -> Result<&[u8], Error> {
         self.raw_bytes.get(..self.length).ok_or(EPROTO)
     }
@@ -768,7 +767,6 @@ pub(crate) struct GetDigestsRsp {
 }
 
 impl GetDigestsRsp {
-    #[expect(dead_code)]
     pub(crate) fn as_bytes(&self) -> Result<&[u8], Error> {
         self.raw_bytes.get(..self.length).ok_or(EPROTO)
     }
@@ -937,7 +935,6 @@ pub(crate) struct GetCertificateRsp {
 }
 
 impl GetCertificateRsp {
-    #[expect(dead_code)]
     pub(crate) fn as_bytes(&self) -> Result<&[u8], Error> {
         self.raw_bytes.get(..self.length).ok_or(EPROTO)
     }
@@ -992,3 +989,152 @@ fn validate(unvalidated: KVec<u8>, context: &'c SpdmState<T>) -> Result<Self, Se
         })
     }
 }
+
+pub(crate) struct ChallengeReq {
+    pub(crate) header: SpdmHeader,
+
+    pub(crate) nonce: [u8; 32],
+    pub(crate) context: [u8; 8],
+}
+
+impl ChallengeReq {
+    pub(crate) fn to_bytes(&self) -> Result<KVec<u8>> {
+        let mut out = self.header.to_bytes()?;
+
+        out.extend_from_slice(&self.nonce, GFP_KERNEL)?;
+
+        if self.header.version > SPDM_VER_12 {
+            out.extend_from_slice(&self.context, GFP_KERNEL)?;
+        }
+
+        Ok(out)
+    }
+}
+
+impl Default for ChallengeReq {
+    fn default() -> Self {
+        ChallengeReq {
+            header: SpdmHeader::new(SPDM_CHALLENGE),
+
+            nonce: [0; 32],
+            context: [0; 8],
+        }
+    }
+}
+
+#[expect(dead_code)]
+pub(crate) struct ChallengeRsp {
+    pub(crate) header: SpdmHeader,
+
+    pub(crate) cert_chain_hash: KVec<u8>,
+    pub(crate) nonce: [u8; 32],
+
+    pub(crate) opaque_data_len: u16,
+    pub(crate) opaque_data: KVec<u8>,
+
+    /// `RequesterContext`, only present in SPDM 1.3 and later, zeroed otherwise.
+    pub(crate) context: [u8; 8],
+
+    pub(crate) signature: KVec<u8>,
+
+    /// The actual length of the SPDM message. `raw_bytes` might be longer
+    /// as it includes transport specific padding.
+    length: usize,
+
+    /// Entire response, used for the transcript hash.
+    raw_bytes: KVec<u8>,
+}
+
+impl ChallengeRsp {
+    pub(crate) fn as_bytes(&self) -> Result<&[u8], Error> {
+        self.raw_bytes.get(..self.length).ok_or(EPROTO)
+    }
+}
+
+impl<'c, T: Transport> Validate<'c, Untrusted<KVec<u8>>, &'c SpdmState<T>> for ChallengeRsp {
+    type Err = Error;
+
+    fn validate(unvalidated: KVec<u8>, context: &'c SpdmState<T>) -> Result<Self, Self::Err> {
+        let header: SpdmHeader =
+            Untrusted::new(unvalidated.get(0..4).ok_or(EPROTO)?).validate(context)?;
+
+        if header.code != SPDM_CHALLENGE - 0x80 {
+            return Err(EPROTO);
+        }
+
+        if header.version != context.version {
+            dev_err!(&context.dev, "Invalid version response\n");
+            return Err(EPROTO);
+        }
+
+        let hash_len = context.hash_len();
+
+        let nonce_offset = mem::size_of::<SpdmHeader>() + hash_len;
+        // MSHLength (H) is always zero as we don't support it
+        let opaque_len_offset = nonce_offset + 32;
+        let opaque_offset = opaque_len_offset + 2;
+
+        let mut cert_chain_hash = KVec::new();
+        cert_chain_hash.extend_from_slice(
+            unvalidated
+                .get(mem::size_of::<SpdmHeader>()..nonce_offset)
+                .ok_or(EPROTO)?,
+            GFP_KERNEL,
+        )?;
+
+        let mut nonce = [0u8; 32];
+        nonce.copy_from_slice(
+            unvalidated
+                .get(nonce_offset..nonce_offset + 32)
+                .ok_or(EPROTO)?,
+        );
+
+        let opaque_data_len = u16::from_le_bytes(
+            unvalidated
+                .get(opaque_len_offset..opaque_len_offset + 2)
+                .ok_or(EPROTO)?
+                .try_into()
+                .map_err(|_| EPROTO)?,
+        );
+
+        if opaque_data_len > SPDM_MAX_OPAQUE_DATA as u16 {
+            return Err(EPROTO);
+        }
+
+        let opaque_end = opaque_offset + opaque_data_len as usize;
+        let mut opaque_data = KVec::new();
+        opaque_data.extend_from_slice(
+            unvalidated.get(opaque_offset..opaque_end).ok_or(EPROTO)?,
+            GFP_KERNEL,
+        )?;
+
+        // `RequesterContext` (8 bytes) is only present in SPDM 1.3 and later.
+        let mut req_context = [0u8; 8];
+        let context_end;
+        if context.version >= SPDM_VER_13 {
+            context_end = opaque_end + 8;
+            req_context.copy_from_slice(unvalidated.get(opaque_end..context_end).ok_or(EPROTO)?);
+        } else {
+            context_end = opaque_end;
+        }
+
+        let signature_end = context_end + context.sig_len;
+        let mut signature = KVec::new();
+        signature.extend_from_slice(
+            unvalidated.get(context_end..signature_end).ok_or(EPROTO)?,
+            GFP_KERNEL,
+        )?;
+
+        Ok(ChallengeRsp {
+            header,
+            cert_chain_hash,
+            nonce,
+            opaque_data_len,
+            opaque_data,
+            context: req_context,
+            signature,
+            length: signature_end,
+            raw_bytes: unvalidated,
+        })
+    }
+}
-- 
2.56.0

