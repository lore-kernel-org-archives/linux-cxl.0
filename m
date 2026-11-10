Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794284350;
	b=kuBtyP/5CuNFKdZPNkgZJnu3QieRI0fi+P47myqk2HliaNubbpnCgnLQcDJeaioStUF6
	 bkoBIIBs0onMBMjIfpXp5lhLhz4C4mH6V3yw2K5HX92elR25SFyHkmUVaJLkEOD6+lwW5
	 21Qcaca/KEmYczXqwAr+FF/7Mt/eEb0QQqUWBzOR4wFyOEWc1L0evWSiw94BbKFcshv7t
	 32ifTfItONQ9PTJKVmR9R1eo0SBSW8MBHfeQ7AErzpeZgwn9fbogO5fVyjpbbi1afekxY
	 Fn13y/ubEBI75uxRV1ELPfzoYDEuTOpfbu19DVlYSyH/6GL70KUKIIR24GwhFiFb+oQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794284350;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=j2kMsOhp92fCLsO0obs3IL9PPq/SCiWUbTQc+uhZCXU=;
	b=jGTZb8p6ngPDl7o/SdMornTQVwammW9T0HV7f//oovMTQVnNQN3asNHI0YcVVbkrlfEG
	 EMqFt0facf6pPNaboveCrAu7SZeMslA586At+JJPDdofux9U3rLphqKEAHUjQEb4ZSmDA
	 NO7gVaXM2Furfv0hwNRl0DlGkZwtfe2kd4R0g9pw0xftDDAOMVa9ffRvm9GfjG6YG0qRv
	 jKI04BTtAWJySDcXUi7xOxpOwqB78t0cgg7BEM7sb4rD0qVwxSFC2uD4kiMqh9mhSwHRt
	 jMrQwore2raqdnIImL2vIOTUfnpshuqCRfF1/K5B2X88GsswmmXpYptuQmuz85mbsCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iJ8PRqK+;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495E6606A333
	for <linux-cxl@vger.kernel.org>; Tue, 10 Nov 2026 04:19:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 495E6606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iJ8PRqK+
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1ae58d17cd9so1155605c88.1
        for <linux-cxl@vger.kernel.org>; Mon, 09 Nov 2026 20:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794284349; x=1794889149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j2kMsOhp92fCLsO0obs3IL9PPq/SCiWUbTQc+uhZCXU=;
        b=iJ8PRqK+HdX5GWTx2chepwBxt7/0tmVLfODoxHuSSvkvErARbTnFSrboU1gt4eRf8a
         URhuGXpPqS4psk94/0pfgXITuI+/k4KzwyLSiTf63mqrDIAVpkRJRLBSrV/hp/8LQ9tC
         iWRGLNGircSUyiX0MmkrXkICnQpIoZg4ZaJmKXUL+vkoW4tOXcoPDLyKcasvnXEqenw1
         kQud+2iBP4Y4qrhVLIrh017JolN5D2lhp9YVS+FbC5FchrGR2IFOghtO1Jrc55kIqi/P
         Q89o021dj8UypN+i4BRWBlVAdohSH5uFGN7FJUZXFIpHcaP7m8EE0b6QzPTHKjPcMewV
         XUEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794284349; x=1794889149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=j2kMsOhp92fCLsO0obs3IL9PPq/SCiWUbTQc+uhZCXU=;
        b=mQ+4yCw/7s8OviX8/FXGq46rSEagxY1ONxs++jXvLzAfLKpgZuXUPt2fHDgMuQ8S5/
         a01WoZ06y8t3QKwm/mIWEs1BMkecsU0N3Zx8SJbNKhy+HcA8XWBlfhXogljHyfEddIRz
         MjKQMq7i7U7EqDLeZQJeVxKe6WpTz7nQJ9DIyiHJB12uVDeHoW+6gyo+T0BvAH7zqtaQ
         rPByNFroXl2Spsj3xN03An9Rq2KI/EQC+AK0IbJFjnI3T9S5iows2OYXZ3WznskbMBJy
         7TkzsZN+KBNAN4HnhQzgjCXyio5MB5syO9gzLTkAkHuAakt8GqOR9JYYoZIkTSDWJqH9
         4blg==
X-Forwarded-Encrypted: i=1; AL+hErE/MvmigTNrxrv5wtFvjMwFdW2uPtalm0S4wHgDcyNg9bZOtYxGt/9dN3RyeQUReTRAG4tknyLznrM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+eshABsP+BjTRjmglPEWG3aqMUkXdvDuj4BAPSZMIVFDBUxdLb
	G71ffIOCZEfa3J1l/DxsWRRJyI/xIhv9YZIJ2LKs5QOtzQPvcjkBT8Fb
X-Gm-Gg: AYBFou3EsIGmNQw5AH4x0ufj1LD/BUxTnhXVikMsIts2mRVbUV/2iPloUwM2/Ks9LNG
	EgxDwsZp2CXCG5XC99IpJzjmrNbhIfr/DRkBnoONmv+ZGczkl75PgZtgW5ZC+XZ5JR2KAsNqIXT
	brL/ZU5/aDk0rimD2SfYCYlAw56StgGzWHAisIrn1oAvjz3Ckg3p62C1ZEsGRvyG6dmV07vEA5C
	xGd68mh4NVQusSWabH+k1fAlGGLAQK9w8RHU+x4PfYeKev2xXCz+BYU2fkTXNVU0EOn8jHoL7e9
	FJfpTKRdyAdocLP40HrynmYO/z77dwgpcH5KcKtEFn8zB4H3Aqi2sNKyJKaVymaeUWsfTzvWgQd
	kwYkB596HzpzGXcqsFZpEt/hSKYaOuuFUXsxubPDGhoJmHIXdNNMDzv+bBgf3B9ucJJTsLiu7NO
	rYIXRNiKBT3UNwOKTdPIWxw9nYjYf36Fh0+FA+yAPZyilLCdGqbkJ2HZ8nOGddcKdQEk+VSWpV+
	ALGwx30+gKdYSiVYoXmZOBadeS9vbvv2DtKupcQ2faI7XGljvWT06K0UtNDDU17xERqtG384Pn2
	FfuB7LDZibCei3cAjrgEWFFl3jAytFaJn20czrWDPybLKoc=
X-Received: by 2002:a05:7022:e884:b0:144:e535:3ef6 with SMTP id a92af1059eb24-1b3b6046680mr2240260c88.41.1794284349175;
        Mon, 09 Nov 2026 20:19:09 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b7ba88sm3540459c88.22.2026.11.09.20.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 20:19:08 -0800 (PST)
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
Subject: [PATCH v6 03/25] rust: validate: add `Validate` trait
Date: Tue, 10 Nov 2026 14:18:10 +1000
Message-ID: <20261110041832.1730924-4-alistair.francis@wdc.com>
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

From: Benno Lossin <benno.lossin@proton.me>

Introduce the `Validate<Input>` trait and functions to validate
`Untrusted<T>` using said trait. This allows one to access the inner
value of `Untrusted<T>` via `validate{,_ref,_mut}` functions which
subsequently delegate the validation to user-implemented `Validate`
trait.

The `Validate` trait is the only entry point for validation code, making
it easy to spot where data is being validated.

The reason for restricting the types that can be inputs to
`Validate::validate` is to be able to have the `validate...` functions
on `Untrusted`. This is also the reason for the suggestions in the
`Usage in API Design` section in the commit that introduced
`Untrusted<T>`.

The `Validate::validate()` function allows additional context to be
passed, which can be used as part of the validation process. For example
comparing data against already negotiated information.

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
Message-ID: <20250814124424.516191-4-lossin@kernel.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 rust/kernel/validate.rs | 85 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 84 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/validate.rs b/rust/kernel/validate.rs
index 5926d0697d3ff..3f5fed5eef219 100644
--- a/rust/kernel/validate.rs
+++ b/rust/kernel/validate.rs
@@ -11,6 +11,9 @@
 //! APIs that write back into userspace usually allow writing untrusted bytes directly, allowing
 //! direct copying of untrusted user data back into userspace without validation.
 //!
+//! The only way to access untrusted data is to [`Validate::validate`] it. This is facilitated by
+//! the [`Validate`] trait.
+//!
 //! # Rationale
 //!
 //! When reading data from an untrusted source, it must be validated before it can be used for
@@ -53,7 +56,7 @@
 /// untrusted, as it would otherwise violate normal Rust rules. For this reason, one can easily
 /// convert that reference to `&[Untrusted<u8>]`. Another such example is `Untrusted<KVec<T>>`, it
 /// derefs to `[Untrusted<T>]`. Raw bytes however do not behave in this way, `Untrusted<u8>` is
-/// totally opaque.
+/// totally opaque and one can only access its value by calling [`Untrusted::validate()`].
 ///
 /// # Usage in API Design
 ///
@@ -116,6 +119,42 @@ pub fn new(value: T) -> Self
     {
         Self::from(value)
     }
+
+    /// Validate the underlying untrusted data.
+    ///
+    /// See the [`Validate`] trait for more information.
+    #[inline]
+    pub fn validate<'c, Context, V: Validate<'c, Self, Context>>(
+        self,
+        context: Context,
+    ) -> Result<V, V::Err>
+    where
+        T: Sized,
+    {
+        V::validate(self.0, context)
+    }
+
+    /// Validate the underlying untrusted data.
+    ///
+    /// See the [`Validate`] trait for more information.
+    #[inline]
+    pub fn validate_ref<'a, 'c, Context, V: Validate<'c, &'a Self, Context>>(
+        &'a self,
+        context: Context,
+    ) -> Result<V, V::Err> {
+        V::validate(&self.0, context)
+    }
+
+    /// Validate the underlying untrusted data.
+    ///
+    /// See the [`Validate`] trait for more information.
+    #[inline]
+    pub fn validate_mut<'a, 'c, Context, V: Validate<'c, &'a mut Self, Context>>(
+        &'a mut self,
+        context: Context,
+    ) -> Result<V, V::Err> {
+        V::validate(&mut self.0, context)
+    }
 }
 
 impl<T> Untrusted<T> {
@@ -196,3 +235,47 @@ pub fn from_trusted(value: Self) -> Vec<Untrusted<T>, A> {
         unsafe { Vec::from_raw_parts(ptr.cast::<Untrusted<T>>(), length, capacity) }
     }
 }
+
+/// Marks valid input for the [`Validate`] trait.
+pub trait ValidateInput: private::Sealed {
+    /// Type of the inner data.
+    type Inner: ?Sized;
+}
+
+impl<T: ?Sized> ValidateInput for Untrusted<T> {
+    type Inner = T;
+}
+
+impl<'a, T: ?Sized> ValidateInput for &'a Untrusted<T> {
+    type Inner = &'a T;
+}
+
+impl<'a, T: ?Sized> ValidateInput for &'a mut Untrusted<T> {
+    type Inner = &'a mut T;
+}
+
+mod private {
+    use super::Untrusted;
+
+    pub trait Sealed {}
+
+    impl<T: ?Sized> Sealed for Untrusted<T> {}
+    impl<'a, T: ?Sized> Sealed for &'a Untrusted<T> {}
+    impl<'a, T: ?Sized> Sealed for &'a mut Untrusted<T> {}
+}
+
+/// Validate [`Untrusted`] data.
+///
+/// Care must be taken when implementing this trait, as unprotected access to unvalidated data is
+/// given to the [`Validate::validate`] function. The implementer must ensure that the data is only
+/// used for logic after successful validation.
+pub trait Validate<'c, Input: ValidateInput, Context>: Sized {
+    /// Validation error.
+    type Err;
+
+    /// Validate the raw input.
+    ///
+    /// `Context` is additional context needed for validation. The `'c` lifetime is the lifetime of
+    /// the borrowed context (`&'c Foo`).
+    fn validate(raw: Input::Inner, context: Context) -> Result<Self, Self::Err>;
+}
-- 
2.56.0

