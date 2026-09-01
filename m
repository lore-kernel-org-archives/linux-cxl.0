Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B3E38E8A0
	for <linux-cxl@vger.kernel.org>; Tue,  1 Sep 2026 01:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788224668; cv=none; b=cBaFa/x49Pw9QkmFukCnF8UVI+sNZAJqhV2bPC36h3ds3j12ppRU4PHrLZLjw/b2eCRxDXNSru/ylBAZ+Qf6/w7gCCcY/jO4g17H91fhGishgBkdmZP0OmHs6OSmljaoL/ewKg58tr9j2isuzDBycJLVuy+zx3YGT6C7iaK7Tgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788224668; c=relaxed/simple;
	bh=BiaV76NHkxz06E8kYtTux48D14DxjulaUaglF1xarVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PFBTXWWsKh1gBXLbncBCXWAZFjWnE45sEnoxCDRg1zfjkXo1ZxhPVL51G0QQKZsrOLC+FRdY520LxJuY3gJsH+awGFMOuMVENIZ+OUKrM25sPGoBoci6tf2Wu+zzp/aY9GoGNd2UiFoD1F79JGew0yoKbRR7vK5uIn5xkmUJi0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQCg7ZlO; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQCg7ZlO"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38511175ad3so4281708a91.2
        for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 18:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788224666; x=1788829466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1Y85wCLF7sPuzEoPMS3iNY9FbVM2HqAZF/UVKCQfhZk=;
        b=FQCg7ZlO5dP6o1Jmz76SfkFYqPGzEpZizZfVOWQ9mU0SfidARzmD776FAT7MTh5m2M
         9tCZY/tJx22nt3GeC8eznD5oKRkxbaXyMJ6RmtlIW71yX9ZCt/YNz70Dd1M1zWw5pyHp
         FKBkXsMooV0n+9HNYBoHrATgB/4LKH2LcpYK06yMJWA2w6a0Ah/PFPDM9jfCZSSk+FZh
         wRwv+m+9QG7j6Vp7bmEIDAd0ZJIO47kWZLLHPJCsddGdxLYwJngLB0gi7lYMMFMii258
         YKH2XdZoeRXeHXWP0woeAenbo58lPuqsjCYKMWaTiH5N/0D1RHdcdjb24Dj8VwNmgDlW
         IQhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788224666; x=1788829466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1Y85wCLF7sPuzEoPMS3iNY9FbVM2HqAZF/UVKCQfhZk=;
        b=q5Ts2uasKI1s/Ttw16B4sY/sW0qztvxs+2XY4ogIy8vrKBYyDQC9UB6dzmrZxrwY6O
         AIJ9pZQ1w592IYuYZdIL8f3dKcm/6RCIrQKlYEPUFRHcdZIycUuYioAwGxI/JwkT9FQS
         +KqQYG9xyx72QFIuGboza3dEKG7VXqZW0Q5jZVtNJPHB4QitBn1ajU3Td8TRDonrlWOr
         0blJc9kjO09kItJHt5TUgfB83nLO675l1rx6VqKjvyso6nQdLEKuwSPu1bErxt+rhZMB
         DwfEYdQVVklvgMFGaF3aM5LYTLFis8x/zU4vSs0a52RAAhRG3sKFWxcUEMMV+SwMyHgw
         P0XA==
X-Forwarded-Encrypted: i=1; AKwUvBx2FuD2GaRQ4XYzJ3H070epPveGK51AzoTM9doRH8u8D96LTj5lnGCru1YIU9bQimYVgMAl5GKmSFI=@vger.kernel.org
X-Gm-Message-State: AFuF++l1Jhb5svhaKT61LP4MaHiE1H5+7ab/UUr913+P1G4JteZoBndF
	WHf5xHj5IFUU8T4T/NH5fmTy3FfIkQYplS6PPkfkCkxdMq3vJjI/ocHS
X-Gm-Gg: AYBFou11YaubZPc+BIzaUdO3FQ/XInvh3gYUV9r4DkkeOp61WB+4ZHFpPFbpHy7T1FL
	WxhxGZzf/LNj21iw+FLlP+302iRrNbOgjCW9SyS6ZK+vQ798C3gWMYofKWMYHrvSXVcE3wGoJGW
	Uxx4IjToH2hv+WunmhKuBu+JGNucRkr9OqNvg5U+KLEG6ooSX4NBPa7NbRzEG6EpGZbjqHjEaqz
	ja2me6Hg0nt6oA+ng7feVLDk6EdbR4wsks3PhDn5csQT79SwgE0ktBmTUukTOJvmrCC+hLR+L4l
	137Vua8KQOsawWqSkvFviphmSVaeS54S99erllwSKUB2yDKCTZTTrLTgE0CNNkmx/LPkE9WEAWH
	J5bVPgTKyOqKyktIgb3K/AhLcV0YrcOtjZzp1mHu370EZwuYaPDr+Aegz4u/cSrZMqkD7q5OkeB
	imaxuq+pyYqfpBbp7dB3CVni57XuUnZRiGdbEJp9kyUdDcyKx+xZfYEtRCsBvtN3oKgNFULVJhO
	c72FA==
X-Received: by 2002:a17:90a:e7d2:b0:398:9bd4:d15 with SMTP id 98e67ed59e1d1-39907e73facmr5625095a91.20.1788224666148;
        Mon, 31 Aug 2026 18:04:26 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990d49e9e0sm2372024a91.11.2026.08.31.18.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 18:04:25 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: linux-pci@vger.kernel.org,
	Jonathan.Cameron@huawei.com,
	djbw@kernel.org,
	rust-for-linux@vger.kernel.org,
	lukas@wunner.de,
	alistair@alistair23.me,
	jic23@kernel.org,
	linux-cxl@vger.kernel.org,
	bhelgaas@google.com,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
Cc: gary@garyguo.net,
	ojeda@kernel.org,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	wilfred.mallawa@wdc.com,
	tmgross@umich.edu,
	alistair23@gmail.com,
	boqun.feng@gmail.com,
	bjorn3_gh@protonmail.com,
	alex.gaynor@gmail.com,
	aliceryhl@google.com
Subject: [PATCH v3 03/21] rust: validate: add `Validate` trait
Date: Tue,  1 Sep 2026 11:03:29 +1000
Message-ID: <20260901010347.2614656-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901010347.2614656-1-alistair.francis@wdc.com>
References: <20260901010347.2614656-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
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

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
Message-ID: <20250814124424.516191-4-lossin@kernel.org>
---
 rust/kernel/validate.rs | 70 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 69 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/validate.rs b/rust/kernel/validate.rs
index 2b28625c25ef..663681b633c8 100644
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
@@ -52,7 +55,7 @@
 /// untrusted, as it would otherwise violate normal Rust rules. For this reason, one can easily
 /// convert that reference to `&[Untrusted<u8>]`. Another such example is `Untrusted<KVec<T>>`, it
 /// derefs to `KVec<Untrusted<T>>`. Raw bytes however do not behave in this way, `Untrusted<u8>` is
-/// totally opaque.
+/// totally opaque and one can only access its value by calling [`Untrusted::validate()`].
 ///
 /// # Usage in API Design
 ///
@@ -107,6 +110,30 @@ pub fn new(value: T) -> Self
     {
         Self(value)
     }
+
+    /// Validate the underlying untrusted data.
+    ///
+    /// See the [`Validate`] trait for more information.
+    pub fn validate<V: Validate<Self>>(self) -> Result<V, V::Err>
+    where
+        T: Sized,
+    {
+        V::validate(self.0)
+    }
+
+    /// Validate the underlying untrusted data.
+    ///
+    /// See the [`Validate`] trait for more information.
+    pub fn validate_ref<'a, V: Validate<&'a Self>>(&'a self) -> Result<V, V::Err> {
+        V::validate(&self.0)
+    }
+
+    /// Validate the underlying untrusted data.
+    ///
+    /// See the [`Validate`] trait for more information.
+    pub fn validate_mut<'a, V: Validate<&'a mut Self>>(&'a mut self) -> Result<V, V::Err> {
+        V::validate(&mut self.0)
+    }
 }
 
 impl<T> Deref for Untrusted<[T]> {
@@ -146,3 +173,44 @@ fn deref_mut(&mut self) -> &mut Self::Target {
         unsafe { &mut *ptr }
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
+pub trait Validate<Input: ValidateInput>: Sized {
+    /// Validation error.
+    type Err;
+
+    /// Validate the raw input.
+    fn validate(raw: Input::Inner) -> Result<Self, Self::Err>;
+}
-- 
2.55.0

