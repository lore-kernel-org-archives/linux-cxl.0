Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794284513;
	b=XAUYgJfKwJGYJj8IIjCD+BXeHWcNW26BfwG2YLGh04kK+iA8ZcDRcA19jecEmNu/icRR
	 kQr+UsRWzDef4xJ1IcJUahpi8NDwLzOIi27+pbU4z0RDBLR+PHIcr92zekdD8Q/wUJ3Lc
	 eX7If+taDSl9Z1Pfmkhe8dFzExCbsm+3MmeQtWi8NDzu5rZr4iCVTLxThjkATNxC/1tbU
	 5YjV6nDdN4RT3NnmvRu72jSk7IKKRX07z3+yitDJuChhVFdQcgeqqmcXH+cSvmcCaNZzi
	 jb/B4VpRYoxJ7lisopQ1thtHfo7Y5txfA/Ep3w2+wk8nBjEMFhAhhrlr12aideIFIiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794284513;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1UrPtzuZOU8w+NOzsFrYP3iAkuGefx7LxxeJF/PgmNU=;
	b=aNCwdmzMG/46cDW68Bor0FiIwtaOETS8quymHKo1Hb0iyJPmKi/tOf4J22ahNnHzH0OQ
	 a7v/JG6+uQSLAAIPgTWpmRpJHDHfO8rftnGKbKU0INchM/WbFMj4Qahc3jYU8ZDmBmjDu
	 pKZBYTAJF8zg9Fv/jTl/zvw1fcRDyL3V3I2Z634t5uAoZoA2bvEX5zU6pCd9AW4FoV4AY
	 bi2CPFeSHJ7QZCPOgZgEeOe8DONBCpx0U6B80Lr0WFt3JVDLDlgQ0q9IdTjTnoRY3lzlc
	 Sed0FWprURrhWM8CySV//A4XnK12aRi1wyFs1opqGjkNNdEpZ5ePwxGdUmdRe8tae1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IY8cwLTA;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D8460A260E
	for <linux-cxl@vger.kernel.org>; Tue, 10 Nov 2026 04:21:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30D8460A260E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IY8cwLTA
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1b3b4944abeso695609c88.1
        for <linux-cxl@vger.kernel.org>; Mon, 09 Nov 2026 20:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794284512; x=1794889312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1UrPtzuZOU8w+NOzsFrYP3iAkuGefx7LxxeJF/PgmNU=;
        b=IY8cwLTA/ajLi6TVtJ4Pu5m5CZTq57Pdd1+rp2M+yhgNceS7HolUdis1g0r3h9YGx9
         +T7bBQJgStKbgOHbMxw5uBEbnY91ZAXWC1xus9cOoSJwnJZWJmaZq1BiF/sfdxCeb/qu
         gKcePPbpt0RPdVDgQQq4A4LlHXdBRfE8EFEUhP/sRzczsHKL0M7yNrmu2WSs0qyjqh+3
         jHSi2YqEA60+dqbajJswde5OBtJY3NMhQ56ucqZqiWsWV7Ur1/3Wc2s7dTf9keIyrXKD
         xl1wDFw2wyAFhzUEfwuA9QJkzMKVan/W/NlTcz4tjBjjkXa22hSHngboVdhVuAelOF4X
         7etw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794284512; x=1794889312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1UrPtzuZOU8w+NOzsFrYP3iAkuGefx7LxxeJF/PgmNU=;
        b=W5JUFMg2vaocX9FJemyG9PZSCGzd3UtmSxCvbWqCf50Hj6XaXlEC/9eZrHqYLQGXzt
         QzuwIjEFSeixwmLpLtmABj5JX2856sBD6IpUppTcJZzZW6nArdluCu3ilPJ1lLf8uHYs
         XzaRbyq6YMcz2hNQxs4nniKSU6UnxSsV6QPeAe9SKMRP5W2CVg/6liqN/yeUYNkesjRE
         6II3/M2tzqqYYggkiGy6WNLhnfkB4b4QGDGQiV+Ij6P2Ivh4pIKyUrr+THi5Yy9BRZ2B
         kUF70RYmjfU70RSbC/VNt1PVR9Qgw+6bCHi6o+QGfST5aBggQKFmjeTa6jSvOvdrnwo/
         0oqA==
X-Forwarded-Encrypted: i=1; AL+hErEA4rb86jcJ+0EIHsOSPsM0N9Ysiizns3/MiUbGG2fG80TXAmpn9QEJQxdztFH2nJelMWAfQvBbtr4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/RYUAgIhgP39EKPQ1+LiQnOuRryVQxU55FKqBi9lc5VpXoQRSQ
	6VmxbFrh3dN4MuRTs0Yc+LkA+32XySn4YVmTK9YLKvLdVUAo4vyJEgLy
X-Gm-Gg: AYBFou3VybHs/Ky/G1Md9VO6sipr+2uifIB4EF8p6axQPM/G2K5bJxBxRzdilV/+cLf
	5eTlw6DJrsHbw0XqqiFWtQClEpLbyCB33GKct5L2O0pxdn3GNuDFhSZv9nmEFkEYFVQV2K7Ameq
	lzOSH0IspP2wzL4/g3n7NTItyzbpXUKWgtZTt0AXQBMGZEsm7WPr3Z9zm+KxgP4QjbuMhR2V/J7
	56TrSqEjG5QZg8df3b+kCqwxiLnAaMS9poBmIXM5+z82s64A/CCUogO0lrGN/i6at5OgBf5Jf0O
	86e9D6MlsOhXTin2lUN5/i/cvBk6ouuqi17FW9okUELagpYplL7isHhc9vCuGCSASZPlAfWe72n
	+QfDIuPiK2aVhVxgO4ppEsPbv2MX9TlJCQRoAd4qziQ3d19P2GFKampqrEdO+RW+jUwIqIaWUug
	QJ+Z50JvhQdbgQlgtS4u1gTjNkCGXIjPh3cCy6gMxCo3DaqFmWTdWb7LTAkeQ2tZHKpNCZQDW/s
	LXflIGeQ4jsKUOBg2EmRcWTnm/uK+anLOLcOlRqRuohTHPa3uz0aSAMf6q+kR6gZnuWHj8sIjYg
	RFF8C6neWwmSnFuOfWqHMx1xEzk6mBXZF9CrSb9qnN+Dyyo=
X-Received: by 2002:a05:7022:5f06:b0:1b2:3b5b:b80b with SMTP id a92af1059eb24-1b3b605ff4amr1715031c88.8.1794284512191;
        Mon, 09 Nov 2026 20:21:52 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b7ba88sm3540459c88.22.2026.11.09.20.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 20:21:51 -0800 (PST)
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
Subject: [PATCH v6 22/25] rust: x509: Add X509 certificate bindings
Date: Tue, 10 Nov 2026 14:18:29 +1000
Message-ID: <20261110041832.1730924-23-alistair.francis@wdc.com>
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

Initial support for the kernel x509 parser bindings,
which will be used by the SPDM library.

This is just a few functions that the Rust SPDM implementation will use
in the next few commits.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 rust/bindings/bindings_helper.h |   2 +
 rust/kernel/lib.rs              |   2 +
 rust/kernel/x509.rs             | 236 ++++++++++++++++++++++++++++++++
 3 files changed, 240 insertions(+)
 create mode 100644 rust/kernel/x509.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index da8855899c530..66e18819d52b0 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -39,6 +39,8 @@
 #include <drm/drm_gem_shmem_helper.h>
 #include <drm/drm_gpuvm.h>
 #include <drm/drm_ioctl.h>
+#include <keys/asymmetric-type.h>
+#include <keys/x509-parser.h>
 #include <kunit/test.h>
 #include <linux/auxiliary_bus.h>
 #include <linux/bitmap.h>
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 8ad9e61d1a6fb..19a5cb7bec0af 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -153,6 +153,8 @@
 pub mod usb;
 pub mod validate;
 pub mod workqueue;
+#[cfg(CONFIG_X509_CERTIFICATE_PARSER = "y")]
+pub mod x509;
 pub mod xarray;
 
 #[doc(hidden)]
diff --git a/rust/kernel/x509.rs b/rust/kernel/x509.rs
new file mode 100644
index 0000000000000..56369ef520cd1
--- /dev/null
+++ b/rust/kernel/x509.rs
@@ -0,0 +1,236 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2026 Western Digital
+
+//! Wrappers around the Linux kernel X509 parser APIs.
+//!
+//! C headers: [`include/keys/x509-parser.h`](srctree/include/keys/x509-parser.h).
+
+use core::marker::PhantomData;
+use core::ptr::{
+    self,
+    NonNull, //
+};
+use kernel::prelude::*;
+use kernel::{
+    bindings,
+    error::{
+        from_err_ptr,
+        to_result, //
+    },
+    public_key::PublicKey,
+};
+
+/// Owned `struct x509_certificate` wrapper.
+pub struct Certificate<'a> {
+    cert: NonNull<bindings::x509_certificate>,
+    _data: PhantomData<&'a [u8]>,
+}
+
+/// Key extension flags of the certificate's public key (`key_eflags`
+/// bits), as defined for `struct public_key` in
+/// [`include/crypto/public_key.h`](srctree/include/crypto/public_key.h).
+#[derive(Clone, Copy, Debug)]
+pub struct KeyExtFlags(usize);
+
+impl KeyExtFlags {
+    /// Whether the CA basic constraint is asserted.
+    pub fn is_ca(self) -> bool {
+        self.0 & (1 << bindings::KEY_EFLAG_CA) != 0
+    }
+
+    /// Whether the keyCertSign key usage is asserted.
+    pub fn key_cert_sign(self) -> bool {
+        self.0 & (1 << bindings::KEY_EFLAG_KEYCERTSIGN) != 0
+    }
+
+    /// Whether the digitalSignature key usage is asserted.
+    pub fn digital_signature(self) -> bool {
+        self.0 & (1 << bindings::KEY_EFLAG_DIGITALSIG) != 0
+    }
+}
+
+impl<'a> Certificate<'a> {
+    /// Parses a DER certificate from `data` and returns it with the length
+    /// of the certificate in bytes.
+    ///
+    /// The returned certificate borrows `data` (`x509_cert_parse()` keeps
+    /// pointers into the DER buffer), so `data` must outlive it.
+    pub fn parse(data: &'a [u8]) -> Result<(Self, usize)> {
+        // SAFETY: `data.as_ptr()` points to at least `data.len()` valid bytes.
+        let len = unsafe { bindings::x509_get_certificate_length(data.as_ptr(), data.len()) };
+        let len = usize::try_from(len).map_err(|_| {
+            pr_err!("Invalid certificate length\n");
+            EPROTO
+        })?;
+
+        if len > data.len() {
+            pr_err!("Certificate length is larger than the buffer\n");
+            return Err(EPROTO);
+        }
+
+        // SAFETY: `data.as_ptr()` points to `data.len()` valid bytes and the
+        // caller has already checked that the DER certificate length fits in
+        // that buffer.
+        let cert = from_err_ptr(unsafe {
+            bindings::x509_cert_parse(data.as_ptr().cast::<c_void>(), len)
+        })?;
+        let cert = NonNull::new(cert).ok_or(EINVAL)?;
+
+        Ok((
+            Self {
+                cert,
+                _data: PhantomData,
+            },
+            len,
+        ))
+    }
+
+    /// Returns the raw pointer for the X.509 certificate.
+    /// This is what is returned from the C function x509_cert_parse()
+    #[inline]
+    pub fn as_raw(&self) -> *const bindings::x509_certificate {
+        self.cert.as_ptr()
+    }
+
+    /// Raw issuer name of the certificate.
+    #[inline]
+    pub fn raw_issuer(&self) -> &'a [u8] {
+        // SAFETY: `self.cert` is valid per the struct invariants, and the
+        // parser borrows the `raw_issuer` slice from the input buffer, which
+        // outlives `self` for the lifetime `'a`.
+        unsafe {
+            let cert = &*self.cert.as_ptr();
+            if cert.raw_issuer.is_null() {
+                return &[];
+            }
+            core::slice::from_raw_parts(cert.raw_issuer.cast::<u8>(), cert.raw_issuer_size as usize)
+        }
+    }
+
+    /// Raw subject name of the certificate.
+    #[inline]
+    pub fn raw_subject(&self) -> &'a [u8] {
+        // SAFETY: `self.cert` is valid per the struct invariants, and the
+        // parser borrows the `raw_subject` slice from the input buffer, which
+        // outlives `self` for the lifetime `'a`.
+        unsafe {
+            let cert = &*self.cert.as_ptr();
+            if cert.raw_subject.is_null() {
+                return &[];
+            }
+            core::slice::from_raw_parts(
+                cert.raw_subject.cast::<u8>(),
+                cert.raw_subject_size as usize,
+            )
+        }
+    }
+
+    /// Key extension flags of the certificate's public key.
+    #[inline]
+    pub fn key_ext_flags(&self) -> Result<KeyExtFlags> {
+        // SAFETY: `self.cert` is valid per the struct invariants.
+        let pub_key = unsafe { (*self.cert.as_ptr()).pub_ };
+        let pub_key = NonNull::new(pub_key).ok_or(EINVAL)?;
+
+        // SAFETY: `pub_key` is owned by `self.cert` and, as it was just
+        // checked to be non-NULL, valid to read.
+        Ok(KeyExtFlags(unsafe { (*pub_key.as_ptr()).key_eflags }))
+    }
+
+    /// Name of the public key algorithm (e.g. `"rsa"` or `"ecdsa"`).
+    #[inline]
+    pub fn pkey_algo(&self) -> Result<&'static CStr> {
+        // SAFETY: `self.cert` is valid per the struct invariants.
+        let pub_key = unsafe { (*self.cert.as_ptr()).pub_ };
+        let pub_key = NonNull::new(pub_key).ok_or(EINVAL)?;
+
+        // SAFETY: `pub_key` is valid and non-NULL as checked above;
+        // `pkey_algo` points to static kernel algorithm-name strings for
+        // keys created by the X.509 parser.
+        let name = unsafe { (*pub_key.as_ptr()).pkey_algo };
+        let name = NonNull::new(name.cast_mut()).ok_or(EINVAL)?;
+
+        // SAFETY: `name` points to a NUL-terminated C string with static
+        // lifetime, as established by the parser.
+        Ok(unsafe { CStr::from_char_ptr(name.as_ptr()) })
+    }
+
+    /// Length of the raw public key (in bytes). For RSA keys this is the
+    /// modulus length; for ECDSA keys the uncompressed public key encoding.
+    #[inline]
+    pub fn pkey_len(&self) -> Result<usize> {
+        // SAFETY: `self.cert` is valid per the struct invariants.
+        let pub_key = unsafe { (*self.cert.as_ptr()).pub_ };
+        let pub_key = NonNull::new(pub_key).ok_or(EINVAL)?;
+
+        // SAFETY: `pub_key` is valid and non-NULL as checked above.
+        Ok(unsafe { (*pub_key.as_ptr()).keylen } as usize)
+    }
+
+    /// Check that the certificate is not unsupported or blacklisted.
+    #[inline]
+    pub fn check_accepted(&self) -> Result {
+        // SAFETY: `self.cert` was returned by `x509_cert_parse()` and remains
+        // valid until dropped.
+        let cert = unsafe { &*self.cert.as_ptr() };
+        if cert.unsupported_sig || cert.blacklisted {
+            pr_err!("Certificate was rejected\n");
+            return Err(EKEYREJECTED);
+        }
+
+        Ok(())
+    }
+
+    /// Verify that `child`'s signature is signed by this cert's public/private key.
+    #[inline]
+    pub fn verify_signed(&self, child: &Self) -> Result {
+        // SAFETY: both certificate pointers were produced by `x509_cert_parse()`
+        // and remain valid until dropped.
+        let (prev, child) = unsafe { (&*self.cert.as_ptr(), &*child.cert.as_ptr()) };
+
+        let prev_pub = NonNull::new(prev.pub_).ok_or(EINVAL)?;
+        let child_sig = NonNull::new(child.sig).ok_or(EINVAL)?;
+
+        // SAFETY: `prev_pub` and `child_sig` are valid for at least the duration
+        // of this call.
+        unsafe {
+            to_result(bindings::public_key_verify_signature(
+                prev_pub.as_ptr(),
+                child_sig.as_ptr(),
+            ))
+        }
+    }
+
+    /// Transfers the public key out of the certificate so the certificate can be
+    /// dropped without freeing the public key.
+    #[inline]
+    pub fn take_public_key(&mut self) -> Option<PublicKey> {
+        // SAFETY: `self.cert` is a valid certificate pointer.
+        let raw = unsafe { (*self.cert.as_ptr()).pub_ };
+        let key = NonNull::new(raw)?;
+
+        // SAFETY: `self.cert` is a valid certificate pointer. Clearing `pub_`
+        // transfers ownership of the public key to the returned `PublicKey`.
+        // The `pub_` field will not be freed by `x509_free_certificate()` in
+        // Drop
+        unsafe {
+            (*self.cert.as_ptr()).pub_ = ptr::null_mut();
+        }
+
+        // SAFETY: `key` was just extracted from `self.cert`, which no longer
+        // owns it since `pub_` was cleared above, so ownership is transferred
+        // to the `PublicKey` exclusively.
+        Some(unsafe { PublicKey::from_raw(key) })
+    }
+}
+
+impl Drop for Certificate<'_> {
+    fn drop(&mut self) {
+        // SAFETY: `self.cert` was produced by `x509_cert_parse()` and has
+        // not been freed yet.
+        unsafe {
+            bindings::x509_free_certificate(self.cert.as_ptr());
+        }
+    }
+}
-- 
2.56.0

