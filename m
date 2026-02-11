Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9C2344052
	for <linux-cxl@vger.kernel.org>; Wed, 11 Feb 2026 03:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770780744; cv=none; b=WY8f2gum2i9ewNFPgq9RMzqdGXMqEpG8q2vouOBb9BqO+EOPGzXXWW/iHWw8ZHJ2TtRCOjnhzZJ4xU9y7i3blRn+WpyypMigVrRY6TvKBV8GKq6c61HO1aCLTfjaQIPbOqH2bukKcWCpzFHMZuRjVpD+PRJ6/SMLJ3tL+Ap5PsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770780744; c=relaxed/simple;
	bh=refyXz8stY99dvGr7uUo6qpIJdnH8vinCei9HfJ4AoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YZ4gKt5Um01lOgoKrSwkGpcvGzeKTfn1Jh0ywctefM3lxtHUNNuAEXUuLi/cQxMLQL4hE6nHg+p5aIyvSuBjE39uv/B7tQxs/Cq/iDn3QVg95+zNKlwGnAAoM1clGZ3jB9Qnwoamt+1v3GLxs2RNI4fq1IZFdrc03bVSFGMcZGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZEC5PEg; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZEC5PEg"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82318702afbso4411951b3a.1
        for <linux-cxl@vger.kernel.org>; Tue, 10 Feb 2026 19:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770780742; x=1771385542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F7X8Upc/bbFH0ZPwDB1OWkHogmxT+7SWa7vhKFXLS+g=;
        b=dZEC5PEgV4EsbWOQS9wGyG6Gr0uckJ/I0CIKcYjNjEjKMz3GnjHyYVk1lwrrEgQCF+
         wDNZaVJi9CBqvtzfJXd+DhuVM0Ys9bA4Y2uwei9FgFz7ovR+pQUd88ANl2Ihy3ZHJWM2
         Ato6DizSXCMGTuAmq3ZqWG79Ek8MfL6XYWBwGHaoz/g3UzbnPvFGeL+pg5HY5kOOLxqt
         8fzyUikw01eYPPpY4uQQ1jZ5JwjScygP/vBuMKfF3NDiSjTXhPW0qhmtlF6ywJQo186e
         aYyNC3fX124tbWKd9jRxZnI2WzUYsSa/P7iM9bxPWCfZs9oAF+DlLpElqDCckdc4zSgM
         ir/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770780742; x=1771385542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F7X8Upc/bbFH0ZPwDB1OWkHogmxT+7SWa7vhKFXLS+g=;
        b=jJ9S+gMeojUaFkPOzKuryay3S5ljTMIfT9ddL9CT+VLP2rbvYHex/R5nrdak5LDLVy
         ugFPR1vmnoIvVODUXwptxLpBAllxJgfY+vxWkUXlE4ej23B8IgeIxYMxyR579dqmH60M
         UserHbhLTvIjTGzbaYKXN1NQp3b1TrL9sgyNmQCbm2KTf+ha7DX5Xf1SnaAxoneq06Nh
         t6Ra7EgjGKkHvKoqOP60XQQ+95uT9134bnnabkDul1FlhZesJFNcv1qfjVEkbeOBfXWn
         xmhhZCs+SIDZhWYbFk0Y791rQYMtKAcjCaTKTEZOuNZ4UaTugWohyByZJOEJ0Moxcf+o
         Lrmg==
X-Forwarded-Encrypted: i=1; AJvYcCWsUE1LIkx9NZ+gw1y7roMjtVYNQu3GfDQDBjp+r4/kJmOOVAcYLV7GC9628LjTtG8VzlKZHOmcBXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYSk/al2nLFjDCU9PZw+UOA4pLbR6fYWaWmW8u1mUZWnbKDtIF
	WvjT2lITXi/2uZQuZ4LJ2/jFXSZHg029b/an6ASdSTZdh6sBu+u4w1lR
X-Gm-Gg: AZuq6aJsveuiimGvy38bPsidKpYAr347CnkEBwI0alHhv5WLwS5zuejqwBrojR891L3
	MIX1ditBJkBYD6iJg+rIqgTc0fhQylk6HT2HXCNjPsgZAa5Kasy6s8SRIYc4LKqzEu7DV+Vg8AP
	UQUGRRvMTVdEcY4AlMoerlJV08O1FV0jlP2ihkua50c3OMFAdyu3unBg7KER7KqTnte3m8UqIiS
	g9UHybDgZDX5cAis7Uy8LuPH0p9hXITCSlDWBr+aPrLgBMlN2HW55PkN3pyqfGG7NRo/QBaqpUK
	nTTHdL3zV3x3KbDW4f4Iod8m4E1eDPOGaVAwstCNs4ml8EDjnggS3Km3II7xBw4125IHaj6/j2S
	5qPjBW9mRdimInwwZtcN7CEQ4otNQO9WUzcWTjTEKv8ETO/dB9iG0RLK8FZ6TswJQp7W8JKEKz1
	lVgvNYAwvTNTk2cMJ7RHddnq6d1mv78o9uKLuryFyBfQ==
X-Received: by 2002:a05:6a21:1fc5:b0:342:a7cd:9211 with SMTP id adf61e73a8af0-3942e3b5d3emr1317494637.34.1770780742090;
        Tue, 10 Feb 2026 19:32:22 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e197d63c9sm464856a12.20.2026.02.10.19.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 19:32:21 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: bhelgaas@google.com,
	lukas@wunner.de,
	rust-for-linux@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-pci@vger.kernel.org,
	Jonathan.Cameron@huawei.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: alex.gaynor@gmail.com,
	benno.lossin@proton.me,
	boqun.feng@gmail.com,
	a.hindborg@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	tmgross@umich.edu,
	alistair23@gmail.com,
	ojeda@kernel.org,
	wilfred.mallawa@wdc.com,
	aliceryhl@google.com,
	Alistair Francis <alistair@alistair23.me>
Subject: [RFC v3 22/27] lib: rspdm: Support SPDM certificate validation
Date: Wed, 11 Feb 2026 13:29:29 +1000
Message-ID: <20260211032935.2705841-23-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260211032935.2705841-1-alistair.francis@wdc.com>
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair@alistair23.me>

Support validating the SPDM certificate chain.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 lib/rspdm/lib.rs                | 17 ++++++
 lib/rspdm/state.rs              | 93 ++++++++++++++++++++++++++++++++-
 rust/bindings/bindings_helper.h |  2 +
 3 files changed, 111 insertions(+), 1 deletion(-)

diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
index b065b3f70356..c016306116a3 100644
--- a/lib/rspdm/lib.rs
+++ b/lib/rspdm/lib.rs
@@ -136,6 +136,17 @@
         provisioned_slots &= !(1 << slot);
     }
 
+    let mut provisioned_slots = state.provisioned_slots;
+    while (provisioned_slots as usize) > 0 {
+        let slot = provisioned_slots.trailing_zeros() as u8;
+
+        if let Err(e) = state.validate_cert_chain(slot) {
+            return e.to_errno() as c_int;
+        }
+
+        provisioned_slots &= !(1 << slot);
+    }
+
     0
 }
 
@@ -144,6 +155,12 @@
 /// @spdm_state: SPDM session state
 #[no_mangle]
 pub unsafe extern "C" fn spdm_destroy(state: &'static mut SpdmState) {
+    if let Some(leaf_key) = &mut state.leaf_key {
+        unsafe {
+            bindings::public_key_free(*leaf_key);
+        }
+    }
+
     if let Some(desc) = &mut state.desc {
         unsafe {
             bindings::kfree(*desc as *mut _ as *mut c_void);
diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
index 1e5656144611..728b920beace 100644
--- a/lib/rspdm/state.rs
+++ b/lib/rspdm/state.rs
@@ -76,7 +76,8 @@
 /// @slot: Certificate chain in each of the 8 slots.  NULL pointer if a slot is
 ///  not populated.  Prefixed by the 4 + H header per SPDM 1.0.0 table 15.
 /// @slot_sz: Certificate chain size (in bytes).
-#[expect(dead_code)]
+/// @leaf_key: Public key portion of leaf certificate against which to check
+///  responder's signatures.
 pub struct SpdmState {
     pub(crate) dev: *mut bindings::device,
     pub(crate) transport: bindings::spdm_transport,
@@ -106,6 +107,7 @@ pub struct SpdmState {
 
     // Certificates
     pub(crate) certs: [KVec<u8>; SPDM_SLOTS],
+    pub(crate) leaf_key: Option<*mut bindings::public_key>,
 }
 
 #[repr(C, packed)]
@@ -146,6 +148,7 @@ pub(crate) fn new(
             desc: None,
             hash_len: 0,
             certs: [const { KVec::new() }; SPDM_SLOTS],
+            leaf_key: None,
         }
     }
 
@@ -743,4 +746,92 @@ pub(crate) fn get_certificate(&mut self, slot: u8) -> Result<(), Error> {
 
         Ok(())
     }
+
+    pub(crate) fn validate_cert_chain(&mut self, slot: u8) -> Result<(), Error> {
+        let cert_chain_buf = &self.certs[slot as usize];
+        let cert_chain_len = cert_chain_buf.len();
+        let header_len = 4 + self.hash_len;
+
+        let mut offset = header_len;
+        let mut prev_cert: Option<*mut bindings::x509_certificate> = None;
+
+        while offset < cert_chain_len {
+            let cert_len = unsafe {
+                bindings::x509_get_certificate_length(
+                    &cert_chain_buf[offset..] as *const _ as *const u8,
+                    cert_chain_len - offset,
+                )
+            };
+
+            if cert_len < 0 {
+                pr_err!("Invalid certificate length\n");
+                to_result(cert_len as i32)?;
+            }
+
+            let _is_leaf_cert = if offset + cert_len as usize == cert_chain_len {
+                true
+            } else {
+                false
+            };
+
+            let cert_ptr = unsafe {
+                from_err_ptr(bindings::x509_cert_parse(
+                    &cert_chain_buf[offset..] as *const _ as *const c_void,
+                    cert_len as usize,
+                ))?
+            };
+            let cert = unsafe { *cert_ptr };
+
+            if cert.unsupported_sig || cert.blacklisted {
+                to_result(-(bindings::EKEYREJECTED as i32))?;
+            }
+
+            if let Some(prev) = prev_cert {
+                // Check against previous certificate
+                let rc = unsafe { bindings::public_key_verify_signature((*prev).pub_, cert.sig) };
+
+                if rc < 0 {
+                    pr_err!("Signature validation error\n");
+                    to_result(rc)?;
+                }
+            } else {
+                // Check aginst root keyring
+                let key = unsafe {
+                    from_err_ptr(bindings::find_asymmetric_key(
+                        self.keyring,
+                        (*cert.sig).auth_ids[0],
+                        (*cert.sig).auth_ids[1],
+                        (*cert.sig).auth_ids[2],
+                        false,
+                    ))?
+                };
+
+                let rc = unsafe { bindings::verify_signature(key, cert.sig) };
+                unsafe { bindings::key_put(key) };
+
+                if rc < 0 {
+                    pr_err!("Root signature validation error\n");
+                    to_result(rc)?;
+                }
+            }
+
+            if let Some(prev) = prev_cert {
+                unsafe { bindings::x509_free_certificate(prev) };
+            }
+
+            prev_cert = Some(cert_ptr);
+            offset += cert_len as usize;
+        }
+
+        if let Some(prev) = prev_cert {
+            if let Some(validate) = self.validate {
+                let rc = unsafe { validate(self.dev, slot, prev) };
+                to_result(rc)?;
+            }
+
+            self.leaf_key = unsafe { Some((*prev).pub_) };
+        }
+
+        Ok(())
+    }
 }
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 5043eee2a8d6..52ad3e98e036 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -64,6 +64,8 @@
 #include <linux/hash.h>
 #include <linux/jiffies.h>
 #include <linux/jump_label.h>
+#include <keys/asymmetric-type.h>
+#include <keys/x509-parser.h>
 #include <linux/mdio.h>
 #include <linux/mm.h>
 #include <linux/miscdevice.h>
-- 
2.52.0

