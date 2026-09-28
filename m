Received: from mail-pz2-f38.google.com (mail-pz2-f38.google.com [74.125.228.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85085335555
	for <linux-cxl@vger.kernel.org>; Mon, 28 Sep 2026 01:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790557910; cv=none; b=UrByhr4sZy8O/7PP5nLnQqrWf9oq79QJtXJocewJNxk5PjSDju2XTlntF0WPKkK9zBnS+QwIb2uAGsctnAkkVl6FNfgKmlbvaaK5lnJOFzxtzanKm82w4Ln56nkm2LzThvcQ5owSh7nFWbxdalbNhxxJjOgyzmfrVVw2r7F7+rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790557910; c=relaxed/simple;
	bh=p8JwPgU1xRJyWiaWo5PEfMwIN7CbI4fAQ4CChCA/yRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j2PbiHMn9nDUoiLIisVBCqurf14BacoB4ZzTjELiBK53pgQTIv66T5LunDWTFikRFzUGLPkxWReewgG4SkUQlzLKl+hZcokbZG/6dRJcpDJT9wNtNepHE4KR/UUqDeGP6Tx4rWm+h8f7mn48QoLWGe87gGT+IFE4kUJYEtdsN7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p6oOqcmx; arc=none smtp.client-ip=74.125.228.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p6oOqcmx"
Received: by mail-pz2-f38.google.com with SMTP id 41be03b00d2f7-cc7a15ba46fso287108a12.2
        for <linux-cxl@vger.kernel.org>; Sun, 27 Sep 2026 18:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790557908; x=1791162708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mFJg0vsGWvqBUD55IaY5ElA+ee/UB4gcWuyrn3oaq14=;
        b=p6oOqcmxH3HazDcB8ksy116zY3USdrFkdYDYQy5LX0uhE2w8Jx/T/qgCduZ+6nFjbh
         YGYzkU1n+ZZ8Bb2ZcmmqX+D7rP1BbHd9bqiikDbggNXc4aKKdrEU7k0G/hqlS6jKN8oh
         PPJhcELqcg7L0dxGWvnTjatOim30eaEUOCEK4dZVSbGj0SkVhxzg1bQHyiqE3yaXKgM8
         U5h+ygvH69s7LMKL4gPn63DcUQw1gIjaYgVvuHCiAdQfO5zTIE4XVog/rwQZj3MKdxgo
         tfR3umCcI4IXAdWx/RGkiMRisknQehAw3qV8Xxq7mW2b5PFLUzh/Jysdin3QjdnfuT1O
         GKFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790557908; x=1791162708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mFJg0vsGWvqBUD55IaY5ElA+ee/UB4gcWuyrn3oaq14=;
        b=eceiERUpsSzU/pMrx80fRo91XbVvgcfwnfxRaSjtDP7Klsce0UYEQu/tfeeRo1GguO
         7mkaMvirvRovWnKtgc65et+7nahL++RbwlI6C6i1OSK3btuTKA4pCcs8/IoyFs7yFaCR
         ftkVfin5s4NwwPcb6+ylxJcbMgagRdx/eXTPqi04sZP4fMuMQCbCZSzOgcypMKCtAGS+
         SN363fWC7qMAs14NQ3IFqTNI+9Eh5/PjtGPIU1ROyXvmeR7EflCEAbh5GnxLmmpFXYOD
         28nnwyusmYwftxHyvo1xz8LOF6xCZxVH7NzauBlVVgvW7oeE5loDNUwFpRqoGArZOoIM
         qfzg==
X-Forwarded-Encrypted: i=1; AKwUvBwRvY+ZiRmIXs1yBdRJMhmDm909rzsoADqTWk9q+rNYoftbGLxo6toHT1AvJCx8y3iuWkywKoICPSY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLNjZx2UboY/73+WuefLphqwewEhmCd85IP9Fq58Vl+ebUArcMt
	wF8m7alSi2drDcl3vM53E+lRI8GtDWr+AWB/b7WLy8kMq8NbT6M2hSlb
X-Gm-Gg: AYBFou1mnVQzZ9gGG/0N7OtkSyflRL5mkg3KZAN2i1XnLGdNOpvl9qWCzinVVBZU3a1
	wjMRpkXR+3i62AZtOHAUA4zRh3vUQTGN3LXE5tTAhi6oiTV9NJnhjUuFRs4UoVc/PZs3XTGfjzB
	R5poVawPQPmhMOCY65qRVXJf2ciMmnPraCkRu+79szJEpEQbXBoOnn1QGBI31YFgJ4X0wc6U3OU
	E1W1xwjVZKlZ7iOHF9qy4KoToVWia49UY0IERDGwkrgD4xSeuAxVhhEL/UYi3aSCKil+5fjkfKM
	Vwx8W6RkndppIuPO9PC2RSpqdPLDgclRDQNKiR3onCfbnIs0G+4xCde47/S9II2r2e3XkzmJSJo
	VsP4i1OkNqJ1xJ5TBntvWKsAhJzMwdw27CtsgCRMjwvhXxvmAwO4zCAoElPTzOXB1pRDft6xwXZ
	Tr1G8+7ZsQjJtnVP9ushTHJeHPWBXLFHpBxwQnSC7MXkyhOUMMZLoGU92A1nOg77vveW6MJFSnG
	Z2V+QxiibwzVTaB
X-Received: by 2002:a17:90a:1149:b0:3a0:9c9d:eb0b with SMTP id 98e67ed59e1d1-3a09c9df050mr6698377a91.58.1790557907473;
        Sun, 27 Sep 2026 18:11:47 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0e7036e3bsm10425773a91.13.2026.09.27.18.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 18:11:47 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: lukas@wunner.de,
	linux-cxl@vger.kernel.org,
	akpm@linux-foundation.org,
	Jonathan.Cameron@huawei.com,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	bhelgaas@google.com,
	alistair@alistair23.me,
	djbw@kernel.org,
	linux-pci@vger.kernel.org
Cc: wilfred.mallawa@wdc.com,
	a.hindborg@kernel.org,
	gregkh@linuxfoundation.org,
	alex.gaynor@gmail.com,
	alistair23@gmail.com,
	aliceryhl@google.com,
	benno.lossin@proton.me,
	boqun.feng@gmail.com,
	bjorn3_gh@protonmail.com,
	tmgross@umich.edu,
	gary@garyguo.net,
	ojeda@kernel.org,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v4 02/22] rust: transmute: add `cast_slice[_mut]` functions
Date: Mon, 28 Sep 2026 11:11:03 +1000
Message-ID: <20260928011123.450800-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928011123.450800-1-alistair.francis@wdc.com>
References: <20260928011123.450800-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benno Lossin <benno.lossin@proton.me>

Add functions to make casting slices only one `unsafe` block.

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
Message-ID: <20250814124424.516191-2-lossin@kernel.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 rust/kernel/transmute.rs | 71 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 70 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/transmute.rs b/rust/kernel/transmute.rs
index 654b5ede2fe2..68e96c635ed7 100644
--- a/rust/kernel/transmute.rs
+++ b/rust/kernel/transmute.rs
@@ -2,7 +2,10 @@
 
 //! Traits for transmuting types.
 
-use core::mem::size_of;
+use core::{
+    mem::size_of,
+    slice, //
+};
 
 /// Types for which any bit pattern is valid.
 ///
@@ -227,3 +230,69 @@ macro_rules! impl_asbytes {
     {<T: AsBytes>} [T],
     {<T: AsBytes, const N: usize>} [T; N],
 }
+
+/// Casts the type of a slice to another.
+///
+/// Also see [`cast_slice_mut`].
+///
+/// # Examples
+///
+/// ```rust
+/// # use kernel::transmute::cast_slice;
+/// #[repr(transparent)]
+/// #[derive(Debug)]
+/// struct Container<T>(T);
+///
+/// let array = [0u32; 42];
+/// let slice = &array;
+/// // SAFETY: `Container<u32>` transparently wraps a `u32`.
+/// let container_slice = unsafe { cast_slice::<u32, Container<u32>>(slice) };
+/// pr_info!("{container_slice:?}");
+/// ```
+///
+/// # Safety
+///
+/// - `T` and `U` must have the same layout.
+/// - Every bit pattern that is valid for `T` must also be valid for `U`.
+/// - Neither `T` nor `U` may have interior mutability.
+#[inline]
+pub unsafe fn cast_slice<T, U>(slice: &[T]) -> &[U] {
+    // CAST: by the safety requirements, `T` and `U` have the same layout.
+    let ptr = slice.as_ptr().cast::<U>();
+    // SAFETY: `ptr` and `len` come from the same slice reference.
+    unsafe { slice::from_raw_parts(ptr, slice.len()) }
+}
+
+/// Casts the type of a slice to another.
+///
+/// Also see [`cast_slice`].
+///
+/// # Examples
+///
+/// ```rust
+/// # use kernel::transmute::cast_slice_mut;
+/// #[repr(transparent)]
+/// #[derive(Debug)]
+/// struct Container<T>(T);
+///
+/// let mut array = [0u32; 42];
+/// let slice = &mut array;
+/// // SAFETY: `Container<u32>` transparently wraps a `u32`.
+/// let container_slice = unsafe { cast_slice_mut::<u32, Container<u32>>(slice) };
+/// pr_info!("{container_slice:?}");
+/// ```
+///
+/// # Safety
+///
+/// - `T` and `U` must have the same layout.
+/// - Every bit pattern that is valid for `T` must also be valid for `U`, and
+///   vice versa, so that values written through the returned slice are again
+///   valid for `T`.
+/// - Neither `T` nor `U` may have interior mutability.
+#[inline]
+pub unsafe fn cast_slice_mut<T, U>(slice: &mut [T]) -> &mut [U] {
+    // CAST: by the safety requirements, `T` and `U` have the same layout.
+    let ptr = slice.as_mut_ptr().cast::<U>();
+    // SAFETY: `ptr` and `len` come from the same slice reference.
+    unsafe { slice::from_raw_parts_mut(ptr, slice.len()) }
+}
-- 
2.55.0

