Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EEE321F2D
	for <linux-cxl@vger.kernel.org>; Mon, 28 Sep 2026 01:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790558448; cv=none; b=EkUxxty+uGuwqfdDrOgTE4CfjxMErNCgSKdYuTUiHF2kBr+Ct4mZxVk1RCScbuorbV5+5zdVIdhnideFPq+Bzni4ED4u13zkVJ0bq95tQrF8hvCFMp+3CrZoAOLXS/98Jfh7Xqv6cfr1PBGr2RUWsV31TmaTJ1rKP+E8HEsBbK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790558448; c=relaxed/simple;
	bh=7Yw8TRdsC8iJj4zKIDBj3vysMEmn/ITvAglewvj0fLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=toOzN5143Gi+ueuu0yi7TljdB0loU4DIelcpV+xlzHANpC+AESlL398eb6I8D6EscY+SWTepe0PaCw4vurJylAktwVX8CG34WjTuH+QHYAke5rp0kuF+OPYw2C0FyG22jjl1sFK1rkCGoaRtTw0ZCpBTu7LJi7Sk2BbDlpwgW/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UxkENCEA; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxkENCEA"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccd5cf02so1267129a91.3
        for <linux-cxl@vger.kernel.org>; Sun, 27 Sep 2026 18:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790558446; x=1791163246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Uiz6c8lHl0mIc3Nv6bMi5cOROWKCJXWfj0lE81TYGfE=;
        b=UxkENCEAToW8Yqw/Z/an6HYAcFzypxasuWnBzkdMw+xLQFBPCtJduad2eHvSy77v9h
         jH86mdNrQlHujJwD2TfbExYKkavrSTbr3DbjCI0Sje63weM5qAB2aBVFjGitv2Uy6RVf
         pCWoEQiuDBk9zbAkYDv4Gom6zN+veTM57lQYJBKBGjU5Ob0qh3SL1K+uLBCPNPYCLy58
         cj1tlqlgBJM1d3xM4sCpZBLX9IcvYx9hAYOEyDvtsmDzX5tYMSeE7RChF5v3XZtebNBC
         9BpxF9yqSHrseFIcAzbxD6dS9VsrRN/KEQLGVOQ5oLejSvPZjhGYmTB/QE/J4vP8iBqg
         PG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790558446; x=1791163246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Uiz6c8lHl0mIc3Nv6bMi5cOROWKCJXWfj0lE81TYGfE=;
        b=dOEHeTB13SwBMmb6TYUeLErp5hyDuO09iL9gNZwlduFjcB/8V8dv2zo0uCcJxVyS9t
         ik9Dgg8XGkGwC3qsj5EbVhS8mP6ODGpyXLy/+3E92HhHUY4y18JFFfTzTY9y8U9lCwhu
         LCvsj7OPOB5n4NjurBQ6+DvA0+T18OpLNFx/IjwfFNeQFrof+LfI8yU379hvLHSHZin8
         Js/tw/KI9V33f0tVNSAwnF5nfxO2Ui2O8B/eJkE56bXkzvvsEnb0iAZaXB7M4MUufsGz
         G8qmRPxweIepviVg7bvBUmGYad7ZTNDodBm+n7GUjVmR9fjeqSFZMi3pevQbZOdtbUDe
         d1OA==
X-Gm-Message-State: AFq9FYLj27q0hOiNMVUOxr+5c8RJMo6KNezhpr8cyR0FSM7LXWKKhN08
	uykDn06U3Ny1glGXykRuoBg1UwqYTLiLy0i2IAxRoPgFe+iWvp4hPJI8t0JXHg==
X-Gm-Gg: AYBFou3bSIKTAlbPV1dwVk2LsXiiklieDoldLgs3oXUI6+g3V6KrV/MiMfq5r60pbv3
	xJsq+qj3UhqYpVE2uKtvbL0F0V3qp5Mcvwtm2yxUOyDiGRTH/2EsQMhFsW1DqopAWnCbX966hUr
	8TETEIruyrrRk+oR0phgLbXv/+RIqga3rXYSPpCVVxzBWYGbp+S073w3njEc6tv2Btj02ocz2Cb
	h+q6qaiF4tfGW3GzFOCuF7Kd+ScyLzdUgX2pz1B3MZNZ5LAO15uSav5IGOi4sS0DlnsCbCzWMjJ
	1MpDk2nH1kGUQh1mFkaEQ89whIXqRYN0lsQ4fkONJqcIMLGEFfkCdluGZMoMnv9g8XXbff6tmff
	eZ7U0P7MjtLp7D7csvH/xA8A8SCT9jPxqkueU6/+MXz+2JFkhA1I+sJp/SijsBIXj36DcHv6Gge
	3J5SXQntx7bW6Ms12B1sxCZjX3Mz8ki1pR1ErnGZwexxabAtUeiEmvQWIQglP7aMnNzR9m3I+CF
	SzWoy0kFC5oxF0u
X-Received: by 2002:a17:90a:e7d2:b0:3a0:ed1d:8e0e with SMTP id 98e67ed59e1d1-3a0ed1d9254mr3939086a91.0.1790558445915;
        Sun, 27 Sep 2026 18:20:45 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0e151be04sm11010527a91.9.2026.09.27.18.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 18:20:44 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: linux-cxl@vger.kernel.org,
	akpm@linux-foundation.org,
	Jonathan.Cameron@huawei.com,
	bhelgaas@google.com,
	djbw@kernel.org,
	alistair@alistair23.me,
	lukas@wunner.de,
	rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org,
	jic23@kernel.org,
	linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	bjorn3_gh@protonmail.com,
	ojeda@kernel.org,
	tmgross@umich.edu,
	gary@garyguo.net,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	alistair23@gmail.com,
	benno.lossin@proton.me,
	wilfred.mallawa@wdc.com,
	aliceryhl@google.com,
	a.hindborg@kernel.org
Subject: [PATCH v4 21/22] rust: allow extracting the buffer from a CString
Date: Mon, 28 Sep 2026 11:20:20 +1000
Message-ID: <20260928012021.484003-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928012021.484003-1-alistair.francis@wdc.com>
References: <20260928012021.484003-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair@alistair23.me>

The kernel CString is a wrapper around a KVec. This patch allows
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
2.55.0

