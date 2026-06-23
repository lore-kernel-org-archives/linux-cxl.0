Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D0F53E0B
	for <linux-cxl@vger.kernel.org>; Tue, 23 Jun 2026 04:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782190468; cv=none; b=OnJ0rx7TWzx6z4Q+5Y8KMw5y/6vj8XTQhxwcYp2suF1s9QPGnwJeMiymsuCXszfBN5emC48kRqGMbyJs+9jvQWLIO3RK/1XrCmqNrty3PNAiO1B8CMLmTxZ0kxEH1avyoBggl46ic3Qei1gBAx/NRgSWIpdk2rsfWrtSKt2Baxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782190468; c=relaxed/simple;
	bh=I7Eg9TZVIwhnpK+ZqS5PPnmgj8VTqwlD03DXcjwSxlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M2122MZEexEvbTV4enQpM9aSSTqSJUcHGKa0YwhY9dHcd1IsaviAbUc3OHJFPGvhMPaXrC8Yp22KlQFhYIHX2Od0YMMrUR+5J0QgUA4foqoIWd5QfoR6XrkztJvCxkHTo9PJMniN39lYwhAbfept3GMhH3pNwhzMcgb/l6zqMx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GW+y05r6; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GW+y05r6"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2c74383c93cso30202445ad.1
        for <linux-cxl@vger.kernel.org>; Mon, 22 Jun 2026 21:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782190467; x=1782795267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xx28JPVuyxeseCDpMYT7ZYlVOLpmmCqBqgah6lMJbOw=;
        b=GW+y05r6PH0MOe1MP9yLR/u45HHE/f8LJ8fe6TybDeeYQ+bRQXKM6ifQ5X1bWUqDsH
         HiOvzMmJS7G9BK8zUYGRB4pbI1ZZzroIrokZyhoxi1GAvpg8jbddgLEvjIaiJe/YgsNm
         hS+soJYRU7V4rklOzGtp1KbFz0MQHsgbAqM38inBfCoWowTE4s+elnEiWYCBBrHVrwMY
         QpQRFPwBzJvpS5uRP+Mv7QOrAA9N4vvkNi0i8oXaOOCY8nBEVoI1t3ZBDk45oEohplnt
         +DfDm3ze4AEJdBQdqp0KMnQoAAgGPdMCJuU2A3K9vFL+sb87MbSkrWUJGp7L6vnT8HdH
         Rvfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782190467; x=1782795267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xx28JPVuyxeseCDpMYT7ZYlVOLpmmCqBqgah6lMJbOw=;
        b=SpB34wBTY15rPVEcRWKxhgr68Tv9rkYczw13g0MTz8CYOv7Z/Pwbyg+mqylaDUnCBK
         UQfPCB1jdQDi2UkAGC08IPnOS28jJLU4oi9UNuRn/MV0M7NprJbYGaNk+nXhvD1aMzbD
         PP5rlRohbsg4vewMc1Zw22Eo0aOWPANpu56/5oqNnz1jnU74HNmX6lD/e5Srsy68Kf+7
         YaIDma2wENEFjCR3A9JW2YWW3hC9vkjJEPndTuE+iy7FKhmc/8iIKCLQ4FO+UafrAlIk
         87Bk2IDUmxYFGBqY8dWp1JT1QYWUAMaHBMrc79Rs6sbofIjFupBuS53saIH9n2JRF0of
         ekag==
X-Forwarded-Encrypted: i=1; AHgh+RpwPZLQ91SFhzkCM5Xg9oTZkGaUtJnsXfpOUtV0C/l2vjW7y6wYiYo5UiAAEGumxIYUJ2zssLOB1IY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzttRl2X87IvCw/sr52tzNFlGbxbBFX660mhPHHQsW/xYHzLXpY
	nVAqA6x+7L2ulvq4XUjx4HEUDILrKoR1GsPwAKaGMnIiXW47Bqph1fXD
X-Gm-Gg: AfdE7cmJDiID6MKM4ggY6Xc3a1hEHy2uDhH1edfb/QYFfDBHx8ozvmr0h1yF5DkywZ5
	n8js5UBmkcW2kFwSbNf3DpY8JHoSKRR4N9AoOVCZ+lxF8ibBYWFdXzI89t/qIMn0203keV1sSdC
	wFB5ohJkL0vOPPYre79y7mykMa51LT0UE4GwrxFAOHDXqHS1g9BYWMT1Tn5uYUMek9dRC7JCIil
	yzg5Fe69rbbTXX/gpRZR8xdAjZKSsIjk+NrB2x7HAsoir/i0N9UgNCb63xTKfOZcQApNq4VGiQK
	8CXStQcyRLPF5KSWfrsQ6ig0P2+/Zw4XX6mOpzOhOR/REZiRSSeXrVcv4akTscuI74jLlmJHRBg
	qtP+tjRz2D5dae747vCtZPoEn2pYU5I7zUdNtgE/kBeMtAeYoD9yVNliW99v5uoBVLIV7NV7Fqx
	atP2rooYSIUilVNwEP+ViF8TYYmE72Kg==
X-Received: by 2002:a17:903:3d07:b0:2c2:be43:39bc with SMTP id d9443c01a7336-2c7c9a02a86mr9155795ad.22.1782190465984;
        Mon, 22 Jun 2026 21:54:25 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7439f8cf0sm89734785ad.50.2026.06.22.21.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 21:54:25 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: akpm@linux-foundation.org,
	rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org,
	jic23@kernel.org,
	bhelgaas@google.com,
	lukas@wunner.de,
	alistair@alistair23.me,
	linux-cxl@vger.kernel.org,
	djbw@kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan.Cameron@huawei.com
Cc: alistair23@gmail.com,
	boqun.feng@gmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	bjorn3_gh@protonmail.com,
	gary@garyguo.net,
	wilfred.mallawa@wdc.com,
	aliceryhl@google.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	tmgross@umich.edu
Subject: [PATCH v2 01/21] rust: transmute: add `cast_slice[_mut]` functions
Date: Tue, 23 Jun 2026 14:53:46 +1000
Message-ID: <20260623045406.2589547-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623045406.2589547-1-alistair.francis@wdc.com>
References: <20260623045406.2589547-1-alistair.francis@wdc.com>
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
---
 rust/kernel/transmute.rs | 59 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/rust/kernel/transmute.rs b/rust/kernel/transmute.rs
index 654b5ede2fe2..c1282fcc9e65 100644
--- a/rust/kernel/transmute.rs
+++ b/rust/kernel/transmute.rs
@@ -3,6 +3,7 @@
 //! Traits for transmuting types.
 
 use core::mem::size_of;
+use core::slice;
 
 /// Types for which any bit pattern is valid.
 ///
@@ -227,3 +228,61 @@ macro_rules! impl_asbytes {
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
+pub unsafe fn cast_slice_mut<T, U>(slice: &mut [T]) -> &mut [U] {
+    // CAST: by the safety requirements, `T` and `U` have the same layout.
+    let ptr = slice.as_mut_ptr().cast::<U>();
+    // SAFETY: `ptr` and `len` come from the same slice reference.
+    unsafe { slice::from_raw_parts_mut(ptr, slice.len()) }
+}
-- 
2.54.0

