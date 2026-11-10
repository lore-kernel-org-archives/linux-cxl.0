Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794284538;
	b=aGTaxxhk/H0FLRVbdxQXt8lECosgJz/n/Mn4r5TRjBe0o5fWWrjyxj+hDcOZ01uvXDjH
	 vlPigVXiR/+Dj/bNcgwORF5C3zZmi/5U2TuINtaxephRtiXR10dtWueulZFVpzLhKXdj5
	 ZfQXb7Mm8xHhBpA3btvTBxHIGy4FVwPtjdG5fSwu4XEgy/vY0CFVxSnOgXEpJ0VPCCxqD
	 XQDLm4ZkhumqLdWY8KhQmGuuDZdeJZ6VCkvEhcVddS6CrYkZOxNuo9FaRPLwQXLCA1jKw
	 Ytl3TTOP+QLc0C/nwYKwF5OF3uFUJJaRefH++9HrYmQuUvW+NkWQAwYTJNJUv2/d1wQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794284538;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=uPNBoQQW3WB02TBAF3BzFuV2QfVhO4wd2JVa30h/5s0=;
	b=IHj2lgQvk13ZAofHd4ArlkA30g+kkZRqqFVGSQWr7A8CB4+yqzwMz4vIQPwLPMt2gvwi
	 rHlGLWi7N+DaR2HZgCrAW2H2/SqW7+7j40LWLSphpFUS2p+sKKWzDwXXgtqv5WT1qO+ip
	 DbH9wBE8BFT7/YBJXkpCWZDoIvEuIyvYIAj6FD9xW6ZIwfwA1EFVjG2/kVAfkStV8pbN+
	 61X3ryzNoykyhAzH4Qa9Ft7ZBMhOw1JSXYEzp1MgON5UXwlKjNWTvD3VShkRRtK7FWTB1
	 2Gq8Mw/f5mjrizABouFWDJKVTbBJr6UKXMu02ilRkROBM0lazwQs6Gl8DAPw2f1KURA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y6GcAIoM;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8C0606A734
	for <linux-cxl@vger.kernel.org>; Tue, 10 Nov 2026 04:22:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D8C0606A734
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y6GcAIoM
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1ae58d17cd9so1157337c88.1
        for <linux-cxl@vger.kernel.org>; Mon, 09 Nov 2026 20:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794284537; x=1794889337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uPNBoQQW3WB02TBAF3BzFuV2QfVhO4wd2JVa30h/5s0=;
        b=Y6GcAIoMky3oeSIHUgB2Mjm010BlPmVQ7t0ba1wxD4W/1igjfnN3/JlTXkToWSFml0
         ptSyuFK2E1l5miKEorIz2pgNYUJoq0fEtnt26LVxvTM8Qe+BfKtQjzV7Z0iNTw6E8yG2
         CVqoAmzAf2FUiL5HMEQhKo0lFFTtr560hbQblk0AOZVH25CD7COwhtYObutS+4k1azhG
         lAMOIRxuiXoo6udBIn9pguQULxNKBlZV0nMNhCCELShYjJlth6FX6nBJh+XmjMs5nLU3
         pmZNpyheJdNuFvjLptOu+HQde5wVjpqTRn6suCUh0DV6+yLUK8R12xAtehl45jFtw/jK
         4UHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794284537; x=1794889337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uPNBoQQW3WB02TBAF3BzFuV2QfVhO4wd2JVa30h/5s0=;
        b=fyvDZhV3smjG9fbg64iWuBM0EIuTspKtDt80anwVZu9GugpehyNS1LCLgmzmMph9Bf
         9dgiue/3xSZBiaAAspbIaQ3RP/SW/C4uyY+v6rmd+0u2pV7V/n+ieGiUxvCvRPqLxlvh
         8Np8ju8n2L76KtJ1Mw1wUHtxRwABriEygYyTF8ZWm4AAG567h6k83+bOVhid3ciLcTxv
         GlJ2NvF/9xGTMNjyXdbBqPyDUttPehx9SbHp++/vG5mxezNHOzeqsY8Mf4cH2aEw8wrA
         U3Y9PxWI36xqRYLNgfE1O+rpFUs33X9IDj8FZo2Fj/kTn9MuTIB/hMOitLJO/p4Wrg6y
         mcNA==
X-Forwarded-Encrypted: i=1; AL+hErEzP1TXuRCBEZN/yIgO5hmxt2DKcePc3XNKOEtfS3Hv5Mso0sT2hyzhzoo3vekb23kxSmrZKiHgSsY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9sWXXW64yqkRkmq2YsOGa//aLKmDFIT3gqVYwdChREAVZypRcS
	sQCuFhxtAfgFbgJqMp3n5q2BYZ/4x/rQ0uiOAu/GndurY5KrLl9nE6LX
X-Gm-Gg: AYBFou1LHCEw3f4aU3ckfaBnFHUdc9snTh9gUE5Nn8SzOrOTwBSWPQ69k5U0Cgl4XS3
	evYUatTtXnMGMXxl5W6gagOPaFrZPtP8JghuO8tmbkuAyZowExdgMUWprU1yPn0AGX7tKsqL02z
	B9a6QWVI1cclBAd5roQ1eEtxKoOrvBOlK2c7Ak8ux+BpZLgTfCoZ1nBC+lem07ypgRoinMukVhF
	20MbW6Cq8yH7xAlfprZ/T7p9ytw2hJWZPAtivV5g/c/kbc90GL3Noz7/oa98/xt9kzv9BgyqZH7
	KA4/ggjc+8GbhjusmZQ0YeKUnFrMRmxOrPDX9AbjSZHTgXVmyR06QNepy+M56NmI/wf+zKGcR3u
	yA85tIzDwy13u2PWALFiMMLcNkATVOqR+kl99SbGg2vG3ubBiiuiMtIfR7ardlYOvoW4zLFuvGs
	zG/cYY7EK0GluJMNvH7ZGgPZt4A6w3p/58SweWBUomKCIGvG/GSBftRTXNJUO9T+NMXgMNKsi8X
	OowhVu2cdd1voxxCzW/f6sI2AmN9hFKy3EvoaK7CmU/GmHyqkeB4yUYcTW9+uzwNo+aZsS+ak5J
	VHEPFkPGoEqrzHnK5wOSIwd2WgNW7cHXgMIqicYBf9gxCns=
X-Received: by 2002:a05:701b:270c:b0:14a:5284:1bf5 with SMTP id a92af1059eb24-1b3b5fda3bfmr2024081c88.13.1794284537372;
        Mon, 09 Nov 2026 20:22:17 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b7ba88sm3540459c88.22.2026.11.09.20.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 20:22:16 -0800 (PST)
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
Subject: [PATCH v6 25/25] lib: rspdm: Expose public Rust API
Date: Tue, 10 Nov 2026 14:18:32 +1000
Message-ID: <20261110041832.1730924-26-alistair.francis@wdc.com>
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

Expose a public Rust API and an example that can be used to authenticate
an SPDM responder.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 lib/rspdm/lib.rs   | 69 ++++++++++++++++------------------------------
 lib/rspdm/state.rs | 43 +++++++++++++++++++++++++++--
 2 files changed, 63 insertions(+), 49 deletions(-)

diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
index 6bfe1eedc4121..6b1f864fe7266 100644
--- a/lib/rspdm/lib.rs
+++ b/lib/rspdm/lib.rs
@@ -9,6 +9,26 @@
 //!
 //! Top level library, including C compatible public functions to be called
 //! from other subsytems.
+//!
+//! ```rust,ignore
+//! struct MyTransport { }
+//!
+//! impl Transport for MyTransport {
+//!     fn exchange(
+//!         &self,
+//!         dev: &Device,
+//!         request: &[u8],
+//!         response: &mut [u8],
+//!     ) -> Result<usize, Error> {
+//!         todo!()
+//!     }
+//! }
+//!
+//! fn authenticate_device(dev: &Device, transport: &MyTransport) -> Result {
+//!     let mut state = SpdmState::new(ARef::from(dev), transport, 512, None);
+//!     state.authenticate()
+//! }
+//! ```
 
 use crate::bindings::{
     spdm_state, //
@@ -30,7 +50,7 @@
 };
 
 use crate::consts::SPDM_MIN_DATA_TRANSFER_SIZE;
-use crate::state::{
+pub use crate::state::{
     SpdmState,
     Transport, //
 };
@@ -263,51 +283,8 @@ fn from(code: SpdmErrorCode) -> Self {
 
     let mut state = mutex.lock();
 
-    if let Err(e) = state.get_version() {
-        return e.to_errno() as c_int;
-    }
-
-    if let Err(e) = state.get_capabilities() {
-        return e.to_errno() as c_int;
-    }
-
-    if let Err(e) = state.negotiate_algs() {
-        return e.to_errno() as c_int;
-    }
-
-    if let Err(e) = state.get_digests() {
-        return e.to_errno() as c_int;
-    }
-
-    if state.provisioned_slots == 0 {
-        return -(bindings::EIO as c_int);
-    }
-
-    let mut provisioned_slots = state.provisioned_slots;
-    while (provisioned_slots as usize) > 0 {
-        let slot = provisioned_slots.trailing_zeros() as u8;
-
-        if let Err(e) = state.get_certificate(slot) {
-            return e.to_errno() as c_int;
-        }
-
-        provisioned_slots &= !(1 << slot);
-    }
-
-    let mut provisioned_slots = state.provisioned_slots;
-    while (provisioned_slots as usize) > 0 {
-        let slot = provisioned_slots.trailing_zeros() as u8;
-
-        if let Err(e) = state.validate_cert_chain(slot) {
-            pr_err!("Certificate in slot {slot} failed to verify: {e:?}\n");
-            return e.to_errno() as c_int;
-        }
-
-        provisioned_slots &= !(1 << slot);
-    }
-
-    let provisioned_slots = state.provisioned_slots.trailing_zeros();
-    if let Err(e) = state.challenge(provisioned_slots as u8) {
+    if let Err(e) = state.authenticate() {
+        dev_err!(&state.dev, "Authentication failed: {e:?}\n");
         return e.to_errno() as c_int;
     }
 
diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
index 059398e95b92d..0fe99caf27958 100644
--- a/lib/rspdm/state.rs
+++ b/lib/rspdm/state.rs
@@ -96,7 +96,7 @@
 ///
 /// This trait abstracts the bus-specific message transport (for example
 /// a DOE mailbox for PCIe CMA) from the SPDM session logic.
-pub(crate) trait Transport {
+pub trait Transport {
     /// Perform a single SPDM message exchange.
     ///
     /// Send `request` to the responder and write the response into
@@ -115,7 +115,7 @@ pub(crate) trait Transport {
 /// it does not need to stay bound to its driver. `T` is data and an
 /// exchange function owned by the caller, so the borrow checker enforces
 /// that the transport data outlives `SpdmState`.
-pub(crate) struct SpdmState<T: Transport> {
+pub struct SpdmState<T: Transport> {
     /// Responder device (reference counted). Used for error reporting and
     /// passed to `transport`.
     pub(crate) dev: ARef<Device>,
@@ -194,7 +194,7 @@ impl<T: Transport> SpdmState<T> {
     ///
     /// `transport_sz` is the maximum message size the transport can carry,
     /// and must be at least the SPDM minimum data transfer size (42 bytes).
-    pub(crate) fn new(
+    pub fn new(
         dev: ARef<Device>,
         transport: T,
         transport_sz: u32,
@@ -232,6 +232,43 @@ pub(crate) fn hash_len(&self) -> usize {
             .unwrap_or(0)
     }
 
+    /// Authenticates the responder through a sequence of GET_VERSION,
+    /// GET_CAPABILITIES, NEGOTIATE_ALGORITHMS, GET_DIGESTS, GET_CERTIFICATE
+    /// and CHALLENGE exchanges.
+    pub fn authenticate(&mut self) -> Result {
+        self.get_version()?;
+        self.get_capabilities()?;
+        self.negotiate_algs()?;
+        self.get_digests()?;
+
+        if self.provisioned_slots == 0 {
+            return Err(EIO);
+        }
+
+        let mut provisioned_slots = self.provisioned_slots;
+        while (provisioned_slots as usize) > 0 {
+            let slot = provisioned_slots.trailing_zeros() as u8;
+
+            self.get_certificate(slot)?;
+
+            provisioned_slots &= !(1 << slot);
+        }
+
+        let mut provisioned_slots = self.provisioned_slots;
+        while (provisioned_slots as usize) > 0 {
+            let slot = provisioned_slots.trailing_zeros() as u8;
+
+            self.validate_cert_chain(slot)?;
+
+            provisioned_slots &= !(1 << slot);
+        }
+
+        let provisioned_slots = self.provisioned_slots.trailing_zeros();
+        self.challenge(provisioned_slots as u8)?;
+
+        Ok(())
+    }
+
     /// Start a SPDM exchange
     ///
     /// The data in `request_buf` is sent to the device and the response
-- 
2.56.0

