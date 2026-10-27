Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793078920;
	b=0ZbmTaazrEv2Rwhfe/MN4C8YjvyqIEH8gxnc50N2om1qIFs7kUZGpQNMY2x0OoSFOvBd
	 tHLZ6em1cPkewZ5abUAadYlXGsdgkEeewBjYoi5DIExsx0A/Gqr/6NnaXNPCQ8NN32l9h
	 DtaVLBLi8ttGPbSBH0Zy/sqFGi8mNmTSbjbLMPL3vrCPja5aiSjHCVe/0zh+5iplz2Q+g
	 uhBMdGP2sLQSXn9sbbpEWUi/clKDq21UbEp2IKoMOX7wR0a5nouAwkvUAp7LmSikr6alW
	 1xwLdgUN/Bav47W2GjNmmD+HGBX1Uflek90TiYV/FNB5c8UpkTBRDk5vKsd5l7z57Og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793078920;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7ULKdw7nG1ai3r4qmUZgbvbhTa7bgBPZLif2ckCL4RE=;
	b=TaQt/ovHvpkFe2Vnk17haD9q4rO8vB/RznKEgCAz6Sm7aUpkFoKYCjCbVCKAPVyD8ab6
	 aPzl+4KDsy0QCn433GPq3jTIwVjNNKOY2EHnFZ4XK4fkbQlDqhJwFPx2W8QkN+q6OD/jI
	 yJ61O/aK7IRIZThZlK0fUCQs+rJu+RLdtO2VRVdAClp4/3124FEBPdH65s1t3vpJUicLu
	 yRWOsGEOcAa90S1Qf51K724i4151XQhlGiAhBgIvcsXkgLqGuGJSE8cOgyUwMSWJFcALw
	 6YECcBJdWpNhlQg2AYgTl99dOb9HsYinlpThDeVwQrk/nojRY7qNjCAo4JFkapeiacw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="mNp0kR6/";
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44727606A31D
	for <linux-cxl@vger.kernel.org>; Tue, 27 Oct 2026 05:28:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44727606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mNp0kR6/
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ea138a3497so24160175ad.2
        for <linux-cxl@vger.kernel.org>; Mon, 26 Oct 2026 22:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793078919; x=1793683719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7ULKdw7nG1ai3r4qmUZgbvbhTa7bgBPZLif2ckCL4RE=;
        b=mNp0kR6/8+rXV3/wgMuhgo+r7aGb+8okwnoahZdS4XbFD3lPv4O8pfgyykJFkA7zxG
         q50iylJXYUqE1oNkhv6QhRN20B4/V11ggoF1T73+2HewZ96tnn4klnetG+6iUIarHK4K
         FjULIrkHYom2wqihJmjz2z3uU/U45tCfLGKOg8CNJMewERo/LRWUu7sEJUOMArjIEmgb
         Y/4dkoBaSIAMnn3fGQlpovVAsArSytXlUNmST5bBs9GJWA9dFM447fCBluCpZAma8eru
         R4+yrPYRc+oeYG1o6Ou50HewqDYIuJ6TjIyMJNqN2ijTUCJxIP+Y/HuNzYFH7Tar/3v2
         zKVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793078919; x=1793683719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7ULKdw7nG1ai3r4qmUZgbvbhTa7bgBPZLif2ckCL4RE=;
        b=QsI1tIL4syGo585pyCrYCxbrdJwnFE/+DfF9yEoJ/f6ujVD0rsQVotbRBJYQ3hJXIE
         j8oZcSiZdtm0hQqKqjKKJQeu+wmMIsGXgkvudsuaoTgxegnDn1ZQhFlHzTdJxH0+NGih
         +lA2ey/a9z89680J82/TmOwjgwvZ3WkjiVmyYFbN8eH/b3kHN0NKhQcI7rUB38ROnYYW
         Bzrh7LJRPqawiEbWW7MRS60ggps784AKIm/uhrtcPaDyCfmyO1X5aUnHD4M7QAcUIONH
         6lQN/orpVoFYXCXqf1DpwlDL1M1ZUnZ0j2j2roV8ZzHHLnZ9ZZThZjjPa3H6dvZ0koMo
         iQ5w==
X-Forwarded-Encrypted: i=1; AKwUvByMDKXmOgVrpg33wkaiDpyvhopEpmDTxlO54k7uirbCHQkSZtKgkKsY2K6FdhMv7epbxYg3CJUHOWg=@vger.kernel.org
X-Gm-Message-State: AFq9FYIvJicTNdJd3cCAfH0gOYAV7AsLD8DUN3TY/xhy7AWIsiokCs+l
	6XaGAxqV/pdkF6pyeEXI3y578UYiDsQ5YTtZekt9jzvvvnpwhwWuA9Je
X-Gm-Gg: AYBFou1KCxX82wC3VYs1SfsT5bB8GAY+AZ+GG/NwudnnjgjxN7z0fckaGpFjlgKCWWM
	Rm9V3iDr2+7F0BPjHmMlyW500w2HzTdqXiMM1Dk/J3kSRkYEdiGfN6JAituybn8oFrb4pBiZ8wb
	5e/Xw01cnYM8dS2ACylSGBu2v3lSYqtqymBRG3Fo3YsezCVZFeYtMtwXrLxU5E6p0tbXlHY74ok
	1xeK2+G7SmalBif9N7u9p7KVG4fOgdRTlo2Q3Jnemd/RinTmPPs21uqPIpO12xbd2OI8jVp1x4i
	x+qpnpiGJ3RWWrS2ymn/kqvgKrLRs9bHJxm8BL+Y+dqoLP+tHsEiNf+fW5W27dzPKArnR4To/d/
	QSWEbNUoEU/D2WfaUG36XUlsHUW33AGGZA/mzmb5e2RBXUe1uKk6ilB1wMv6QyFF27tiOcxTql5
	BMhthvLLm/8+ypQ4bQ3vF2poVLpB7GkEi7IeUYWek5k/rm82V6LW7L0gW2Dbk1+6rq/6HAeIBkC
	ZPxvJfsPy80XdevOFx+AquKwLxkWsnko/+3pJEpQDNAn9xHqooeJUJozrFYcUXZVPcLvUSVOR9l
	Mtjv0OLwbSHNww3ru34=
X-Received: by 2002:a17:903:41d1:b0:2e9:5ec6:bfc9 with SMTP id d9443c01a7336-2ea9c6c82a8mr84726685ad.9.1793078918650;
        Mon, 26 Oct 2026 22:28:38 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6c9757bsm3307715ad.58.2026.10.26.22.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 22:28:38 -0700 (PDT)
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
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v5 22/23] lib: rspdm: Support SPDM certificate validation
Date: Tue, 27 Oct 2026 15:25:35 +1000
Message-ID: <20261027052536.1722081-23-alistair.francis@wdc.com>
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

Support validating the SPDM certificate chain. This only performs basic
sanity checks on the chain before we continue on. This does not ensure
that the root CA is trusted, we leave that for userspace to check and
enforce. Instead we just make sure that the chain is correct, uses
supported signatures and that it isn't blacklisted in the kernel.

We then store the first leaf certificate for use later.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 lib/rspdm/lib.rs   | 12 ++++++++++
 lib/rspdm/state.rs | 56 ++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
index 6b0be0a0303fa..5277fc8c56fb8 100644
--- a/lib/rspdm/lib.rs
+++ b/lib/rspdm/lib.rs
@@ -289,6 +289,18 @@ pub extern "C" fn spdm_authenticate(state_ptr: *mut spdm_state) -> c_int {
         provisioned_slots &= !(1 << slot);
     }
 
+    let mut provisioned_slots = state.provisioned_slots;
+    while (provisioned_slots as usize) > 0 {
+        let slot = provisioned_slots.trailing_zeros() as u8;
+
+        if let Err(e) = state.validate_cert_chain(slot) {
+            pr_err!("Certificate in slot {slot} failed to verify: {e:?}\n");
+            return e.to_errno() as c_int;
+        }
+
+        provisioned_slots &= !(1 << slot);
+    }
+
     -(EPROTONOSUPPORT as i32)
 }
 
diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
index 7799d4ac70c3f..aa36d4ce7b41a 100644
--- a/lib/rspdm/state.rs
+++ b/lib/rspdm/state.rs
@@ -14,10 +14,15 @@
         Bound,
         Device, //
     },
-    error::Error,
+    error::{
+        to_result,
+        Error, //
+    },
     hash::Shash,
+    public_key::PublicKey,
     str::CStr,
     validate::Untrusted,
+    x509::Certificate,
 };
 
 use crate::consts::{
@@ -97,7 +102,6 @@ fn exchange(
 ///
 /// `T` is data and an exchange function owned by the caller,
 /// so the borrow checker enforces that the transport data outlives `SpdmState`.
-#[expect(dead_code)]
 pub(crate) struct SpdmState<'a, T: Transport> {
     /// Responder device. Used for error reporting and passed to `transport`.
     pub(crate) dev: &'a Device<Bound>,
@@ -148,6 +152,9 @@ pub(crate) struct SpdmState<'a, T: Transport> {
     /// Certificate chain in each of the 8 slots. Empty `KVec` if a slot is
     /// not populated. Prefixed by the 4 + H header per SPDM 1.0.0 table 15.
     pub(crate) certs: [KVec<u8>; SPDM_SLOTS],
+    /// Public key portion of leaf certificate against which to check
+    /// responder's signatures.
+    pub(crate) leaf_key: Option<PublicKey>,
 }
 
 impl<'a, T: Transport> SpdmState<'a, T> {
@@ -173,6 +180,7 @@ pub(crate) fn new(
             sig_len: 0,
             crypto: None,
             certs: [const { KVec::new() }; SPDM_SLOTS],
+            leaf_key: None,
         }
     }
 
@@ -240,6 +248,9 @@ pub(crate) fn get_version(&mut self) -> Result<(), Error> {
         request.header.version = SPDM_MIN_VER;
         self.version = SPDM_MIN_VER;
 
+        // Clear the leaf cert as we are re-authenticating
+        self.leaf_key = None;
+
         let mut request_buf = request.to_bytes()?;
 
         let response_vec: KVec<u8> = KVec::from_elem(0u8, SPDM_GET_VERSION_LEN, GFP_KERNEL)?;
@@ -551,4 +562,45 @@ pub(crate) fn get_certificate(&mut self, slot: u8) -> Result<(), Error> {
 
         Ok(())
     }
+
+    pub(crate) fn validate_cert_chain(&mut self, slot: u8) -> Result<(), Error> {
+        let cert_chain_buf = &self.certs[slot as usize];
+        let cert_chain_len = cert_chain_buf.len();
+        // We skip over the RootHash
+        let mut offset = SPDM_CERT_CHAIN_HDR_SZ + self.hash_len();
+
+        if offset >= cert_chain_len {
+            return Err(EPROTO);
+        }
+
+        let mut prev_cert: Option<Certificate> = None;
+
+        while offset < cert_chain_len {
+            let (cert, cert_len) = Certificate::parse(&cert_chain_buf[offset..])?;
+            cert.check_accepted()?;
+
+            if let Some(prev) = &prev_cert {
+                prev.verify_signed(&cert)?;
+            }
+
+            let _ = prev_cert.replace(cert);
+            offset += cert_len;
+        }
+
+        if let Some(mut cert) = prev_cert.take() {
+            if let Some(validate) = self.validate {
+                // SAFETY: Call the `validate` function provided.
+                let rc = unsafe { validate(self.dev.as_raw(), slot, cert.raw()) };
+                to_result(rc)?;
+            }
+
+            // The leaf key is the same for all slots (MULT_KEY_CAP == 0),
+            // so just store the first one.
+            if self.leaf_key.is_none() {
+                self.leaf_key = cert.take_public_key();
+            }
+        }
+
+        Ok(())
+    }
 }
-- 
2.56.0

