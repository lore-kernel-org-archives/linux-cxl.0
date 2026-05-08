Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABC12EA498
	for <linux-cxl@vger.kernel.org>; Fri,  8 May 2026 03:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778210373; cv=none; b=lFvfvmfL28bbdV7xdR5Jk0b8fRIYWjn+rzLd+h5YHpp4GaiesAzNSVI7dPWjkiFNnyPizA81XgLPOh6A+P4Wr+XoYUIsZr6wJ2j4yghwUhb7smglkjL1bI2w7oq1r/YyGTU7rP3Bsn1VM3x2UVEOiD/sM4AsIn+vPLLQ2samUeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778210373; c=relaxed/simple;
	bh=j3lxGogAEu2m4ODiCYf4W/cmhvK2xVIezXSiFbrV+fY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eE2Ygod8Dr5lDHHKlDqGjoXLoubbi4bJHuS7CyeLZ9BPmjeQ1FwJyfk8E/VtVJmAnrg+vhEzdgjTFOnyBK66dcbvV6hpq0AfVsRz3Wufire2Eob5/Bm1PcyJcYXrJ71cB9DwevIgfLfcjPmiKF4620eR9EMQx6ENNWBNIQog+ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYPzEgPP; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYPzEgPP"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b7d3ecc10dso14679435ad.2
        for <linux-cxl@vger.kernel.org>; Thu, 07 May 2026 20:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778210371; x=1778815171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KV+KKNzPOZuwOP9jOwich0HOmZDeWpgxJKGJYxOCc1E=;
        b=SYPzEgPPEAISbTP4ZX6A+emoUo22JWeiwLrPlZlR9DklqTVIl8Z557D3b2AJ3AEb/W
         RX8DqmMrTG3QX6anU7D5OmBzEnwOLlwAFDhPFCXLylLZXegujZmengVO4xPbqLqpF5Cb
         S3QpS6vZEkzsY3oKH9Tj3gFmItjnpHVR7iCNog1CHZovwXVHlNfrTIk1m3eAwTdKFLUz
         Dsm8mx7xaFU2zv326821qnQsrMJOpv6D7YokAZs8Lq+tDsyNwkDrC9GaQUvyDN/vPXfi
         f+6eNnwDKYc0LpEvFaUGOAiqTyk6qSKDSi6YfV191oQnTqmuYsBLwYSRelm6SRZbxE+5
         VjGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778210371; x=1778815171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KV+KKNzPOZuwOP9jOwich0HOmZDeWpgxJKGJYxOCc1E=;
        b=VRH3+R1kiCUEfVT0GDnUfUG49A5qjUKR2zj7Xo1rLE9g+T/zGSUts10ar2pqvlZrSW
         XJf1uR5dvnEHNXEQxWoVLrFfKhI76xHGNBPT77IPquPscL5z3TICxMQrAcpkghxEMQcU
         ax7YtD/VkffbrUDHRwmCBXHj/fgABtueZpgTNA362KmYWM6ccHg+H6kUtitwWZfjmc6p
         YNWbu1/rvaKU+tgRTq55svj7FBmdoMYoQUMv0abHAK5uADNthCAyfC7N31JieaSVr0c/
         ZqOP8KVo8D9VCKFgt7KlCOdwJWINr3GGNuL9wmvsh5ZK9sozUGztBTJyEievIp0ekOuz
         hCLQ==
X-Forwarded-Encrypted: i=1; AFNElJ8vTtinsGkQ3tjjiz2jfvLheO1MTjVvEbm8pK0sOuiI7NM15vlYU1mg3+YMRLf5XQ67UyDNQ/sIrXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpSDKsVRdW6I8sVn8buoHdeZC4eJR7KeBNn4OLroeiNmctVmkB
	h4Qgk7U69QTab3UBW+hsJNVzaxsXNVxNuG7I5KGToIDtcDKKEZCbbaXt
X-Gm-Gg: Acq92OG4ockX5lesjxG6J+mw4ts92WUe5dcMFCbZhiqrYWfYxrLBpvG+nLfrEwi04no
	cGOafpO4fs/gYtBvtbIhbluegyzRQl9OVrcuTYBkMGWVv6TCSbNksJ/qPlBcmK9iW193HDg0ej4
	oDlBxp1ar6AnqpDDfshEiOx/UvksG+72g2qO9ARZVnJAbkZgiVGRRfOrWD+AhPZUaIwrKu0z2gK
	1z9vpCpoYp0X8WuPPmmQJvBlUZ46d7gMMHRoj061Ns0lEuc/bVyA7bG0xyuoEGwbEafBhir4zLH
	vRC7RE6GNSip4l+hTXZ9IQWSitavsEsmbLqr6DRZhEljChC92krs+5yUVnbe++v9ZSvS96i9iNp
	Y+g2/R/l7ppCX9FpiWvAfAUbABH5kowaNV5JTH5CzqKirtXJ9uD8/Aqs5xqLFGM3U3y6AzWb0Xb
	d1/+xGKzlgfWAEwyIWZl/ZoP5iI4rvkV/+qc6ZzHAZ1OuuTdyTDs8=
X-Received: by 2002:a17:903:3887:b0:2ba:83f8:7b7b with SMTP id d9443c01a7336-2ba83f87cfcmr97081925ad.33.1778210371221;
        Thu, 07 May 2026 20:19:31 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1eafa62sm3220685ad.74.2026.05.07.20.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 20:19:30 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: alistair@alistair23.me,
	linux-kernel@vger.kernel.org,
	lukas@wunner.de,
	Jonathan.Cameron@huawei.com,
	bhelgaas@google.com,
	rust-for-linux@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-cxl@vger.kernel.org,
	djbw@kernel.org,
	linux-pci@vger.kernel.org
Cc: alex.gaynor@gmail.com,
	wilfred.mallawa@wdc.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	aliceryhl@google.com,
	boqun.feng@gmail.com,
	a.hindborg@kernel.org,
	tmgross@umich.edu,
	ojeda@kernel.org,
	alistair23@gmail.com
Subject: [PATCH 17/18] rust: allow extracting the buffer from a CString
Date: Fri,  8 May 2026 13:17:09 +1000
Message-ID: <20260508031710.514574-18-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260508031710.514574-1-alistair.francis@wdc.com>
References: <20260508031710.514574-1-alistair.francis@wdc.com>
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
index 17070dde0e35..764dd5c695f6 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -856,6 +856,12 @@ pub fn try_from_fmt(args: fmt::Arguments<'_>) -> Result<Self, Error> {
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
2.52.0

