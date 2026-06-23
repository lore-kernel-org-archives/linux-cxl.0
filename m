Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8517D3A7843
	for <linux-cxl@vger.kernel.org>; Tue, 23 Jun 2026 04:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782190643; cv=none; b=kXv/LN5VZfkIsnqp6BvrkJTt/AMuJp/bI8hGLK/RAgtKvl04j8urHAxErfF8wfocIVa/y8tH/HLA4Zz/P1rvotB87PTzsH2ONaLfKmArdrGhvqMxQHkmjh/uNVQxEUn5U+Nyu+k7e3DcNjQJBVkXKpQHnGNL30IwnWvF2qp56Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782190643; c=relaxed/simple;
	bh=b1p8QYDJtGAUMfQOZ7yKfgv3g86cSUtLRbu9pIoZySA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K/fm7lu9+atzTJA9y+Ihif+tq/LkeaNEf6XsWg/yzOm0/E58daGfcMuw+HnSZRZPEzisMgDvInTWrJO42dgPOMIeNvxX5qJTgulS9m8tapsqDWxMa1b3Au/jsIa5vNmbZl0s/x1PvmQB8uQAVCGnLbrXNEKb3hW5IgvdXojzNl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q7w8ssGZ; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7w8ssGZ"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-36d5fd50d20so3505830a91.1
        for <linux-cxl@vger.kernel.org>; Mon, 22 Jun 2026 21:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782190642; x=1782795442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xk8SrCAuPrpKQay4vKvsDXzhAFJImT5ZIR9RIcxuUy8=;
        b=Q7w8ssGZZupMkR2wFzIAww+68cYnEOyRtEja//m35Pr2fnc17UvxpsbMjZ6xhUxSok
         weggbBQiS2LOqg+WEvjaaJjN7Ad6R0vkv9UrjGHDdH+0whVG7qgj5mZg4B7Z9J7j6iZa
         7fRcB2C3DVFuWphbqQ3HxBEG9NPkIPP1Nc6z/6HlyjkRfEgQrrSk69B1LyNEhJxEBdLZ
         hXRN10j206jvmbuIz1deqpZc7BE7TYCniKwgKtP8CFsv7I8apLubV9BJ7H/owG2tXixD
         jD3gtJX4r3borNlw5m5QB+gFr7nZ/6VrRwfpQy9qCRw6V5auORLXEUcllqOrXpp08eMy
         k6Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782190642; x=1782795442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xk8SrCAuPrpKQay4vKvsDXzhAFJImT5ZIR9RIcxuUy8=;
        b=LwdHLneBhCCTGbo5TnlyUfx0nVwY8ki6GKF03ccLat23c1cC3vcG1bNo97jY8f2AcM
         xAKf26ZwpG/Y5z1pc6pZcJXLvJ1gwf0xEFTJFeKEPakUl39mVjSm4Z1J7DbNPS1u8c/w
         ItmpcM4A8Q1EfPhsx3FpgfZPFjn5TwEA0tl4P0+E2Io+cFeQNUNnve0qi/m8BXRt5Wb3
         EljZ03dMaHkHDIAfR/W6dtKuh/d6L3xQpM9Jxou50gaXoM5v6DzxI6LMbUMs+uFSqFu3
         MXwPW78C+THotvbdBrwgQF/Vi3GHHVsFJqHzHT/rCRKZho20Mktp6gPXgCG9q7zoEP2X
         /GqQ==
X-Forwarded-Encrypted: i=1; AHgh+RrOH+jkR6Iml14Lec60iPca1F01g6GxVf8OuH6cK4jfL5VlHF5qHLN6FKEi0zqqvmGaRtrnP7q6UHo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn8omnzJJI0xHPBQzmwN3yINO93zHzLOpzdd8g13sIrUILjcE6
	5ALt1d+jAFspQf1cOUbIVbLyVUUOcKi0ExlPP0xTkXswstWt8N5+m8/g
X-Gm-Gg: AfdE7cncuEnt68DkqYgaxHsO2tA9IZOh3A0k+1SdQl0xX6SvByZ7wSUPP1OY6gAWsEy
	SfPjL928YPdXvRbgnyRteRTe2nOV5iosIvpkucciU4hBEr3hfxQOhPvnysOVRTttHHtL3UB3iwK
	wKf3clh5CKgtMqJA8DjfuVQ9c6OyM6SY4LyRlurY2xP75tGuspZVfJTfOZP0MxK+2BDFXxV1/MG
	LE5DNFbN4UxZRCUVVOekW2NFLWnKHup8tJ6ix/15ZWNkrloz2Z+hdGmiK5jkKRFqo4pz9XEqpeC
	kO1ssyriLp/QE7Ui9F1Avg1g/zs3ckm1y3NePtenLFE8KxMkPTlE4aDz9831aDXyFM7tgzXXr8z
	i6jZ2BmsOV4r+I6AFQvJedPw8cv96YV4pBkWUnEw/ORoRfOmkonXi8DbV9gaUmxYbcB4px//L89
	rEdUMBdAXt2HtBZ+aynCH6Mrilm+VjrXhAy+WXDNAV
X-Received: by 2002:a17:903:2b07:b0:2bf:2e06:2ebf with SMTP id d9443c01a7336-2c7c76d610dmr15796005ad.31.1782190641888;
        Mon, 22 Jun 2026 21:57:21 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7439f8cf0sm89734785ad.50.2026.06.22.21.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 21:57:21 -0700 (PDT)
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
Subject: [PATCH v2 20/21] rust: allow extracting the buffer from a CString
Date: Tue, 23 Jun 2026 14:54:05 +1000
Message-ID: <20260623045406.2589547-21-alistair.francis@wdc.com>
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

From: Alistair Francis <alistair@alistair23.me>

The kernel CString is a wrapper aroud a KVec. This patch allows
retrieving the underlying buffer and consuming the CString. This allows
users to create a CString from a string and then retrieve the underlying
buffer.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
Reviewed-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/str.rs | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index a556788bcc5e..3fd8a218547f 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -870,6 +870,12 @@ pub fn try_from_fmt(args: fmt::Arguments<'_>) -> Result<Self, Error> {
         // exist in the buffer.
         Ok(Self { buf })
     }
+
+    /// Return the internal buffer while consuming the original [`CString`]
+    #[inline]
+    pub fn into_vec(self) -> KVec<u8> {
+        self.buf
+    }
 }
 
 impl Deref for CString {
-- 
2.54.0

