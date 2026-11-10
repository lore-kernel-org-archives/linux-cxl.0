Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794284394;
	b=w2MWM2KUp1SBJDL18uRzsjN4d2NOH2iQyMw0+IUqa+s7sa0SB5qQ3rPo5OtlCMQja7mJ
	 eMM9cd0o4dhyJz+fgzgjxvXCnj4QOlwFoT/7bjV2wQxFN+Nnblf/3sJB0MIUE/D8PXj5m
	 scQr9nIyunGod8ehO6YRxWBiCHdrkr1AXn0MlTUXlkyxmwyxny9YwONxikN8LjY3UMb7v
	 YtwdVS23ROlpxSVONPgRmtAbwsmEHU1zoxFcXdGNhA7yKa7GIdyZW5QXd47HurqyFRvcW
	 Z539O6/l9CKam7WLptwIPbmJYsTwJwZAXZxqqeqHxWC61+GoygHwzsMeO224jAIRUJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794284394;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=3AxS6ewNN37c8Z1T2Uoj4Jwsnbq6o66JX4RBhLIPEDs=;
	b=hvG0vs9ZB9EtbRQpAePG+MU1GIM8+MaL6NipVGGMuNuZf1X0S97XWN8bDSYjKx44BvgN
	 vQSQbbmDhSHXXwH0WZHUfVaPDoOMnPjB3UIrQJFrxrRq5315tK5+R2VBKMBCjvMdRHcQ3
	 rqhYNiDq9GwNoC8DOVU5XEQbls7kMRiemkUP4flgOZIHeJAzxv8GKksPLa6B8QyzGC8v8
	 zvHzBBUVhvZ2ofmeuirA5p0T448BovyZQ0SgPrf2NDV2bL/2sctLaZH/M/9DeYEAOJkQI
	 oXjhptIZ0kEkShcl1JgNyONZ/HQFkSgPtNAT8zhDaHmmlotB7kPV8QL2UU4/HZJNVSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bAdLG6I0;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BC760A2630
	for <linux-cxl@vger.kernel.org>; Tue, 10 Nov 2026 04:19:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34BC760A2630
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bAdLG6I0
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-3720addb068so2720678eec.1
        for <linux-cxl@vger.kernel.org>; Mon, 09 Nov 2026 20:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794284393; x=1794889193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3AxS6ewNN37c8Z1T2Uoj4Jwsnbq6o66JX4RBhLIPEDs=;
        b=bAdLG6I0SEmoBfqYyUKe4jfQKmj4cvRp+anU2Oj5X0c+tjnjU59+VA8jKT18ZQe/my
         1NrBxCtLGndpR7JX52vRaLI/OHEVVmEBDmojm8MthHWn6SR3kGWvFZ44fCtuACa0sgDA
         6QsIpWMMPsrPsXtwmzjWeN0K+kXepme8doarva6YuCZtrU7O/N/BXDGI/28Ae798vZYV
         slUmkSL+oM/WLaktRkrd/0TFjbDoJYl+8vuyHhX766Ljbk6SztVXDT96+gpuH6/Iu9Kc
         c/h49WO/AxN8dbZftCq5H5N5bEBhro/po5jMkc72OtKLfwrKmrsGz/n11bnhfJiQSS7M
         XeNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794284393; x=1794889193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3AxS6ewNN37c8Z1T2Uoj4Jwsnbq6o66JX4RBhLIPEDs=;
        b=N/cw1jSczR6ZqOjNYsaahBt1+AW1HcWEBgTxxS0hzAGLgZ870RommySXDq+yfmAIUA
         5WNXCEaGRfcoRdqqt9MXVi7Rjvt6slKCWoexJ2wgbhBsbOK68j2CFp4BEnCf/k5Y2THW
         M6XXL1/OJRZIcp74N1MgvfcFqmhiNeFowGCR4S+udga5ClbyZ6LGc40871NKHflYB507
         +cMT0mWW4AX8OscwzOTERUSbGf+rez3BTiLALV2xrBzlZz4ApMDZaqj/4AYEvCdwjVPm
         PiQ7r/IBOLj4fHAcFWW5V1sPg24SvPszh7Tvpu7QD466oOL7euAEkIIaSl3n4zGxp3GA
         YbNg==
X-Forwarded-Encrypted: i=1; AL+hErErsRLIW+KedB/BFKXhPQhRNJ4D0OYK0Y0mL4o+D5R6sCC8siab5M/Uea03h+9O4EGWYCl0VF+k7lM=@vger.kernel.org
X-Gm-Message-State: APuU4Z92Lo28t0e2c7SCjit484aV2x8lS23tBdbpRauyGkBN8kZ5bMe0
	LWus317lfiWsh4eVHeaV/g9l4mAfTOQU5axzUu5ncQa8T0qvUx55KHsJ
X-Gm-Gg: AYBFou1B6OQrGYtnRmQTY79FVYvhRkWU3ws8+ZXadBJi5VtTLyk70o/mHvoYMs1thgo
	E8idbnTX6slnVT/53dszckr0Fn2P1zjNgLlGyfn6ob1ilLhuk1GmZreUK1OV+tS1wJdiZPfgaDC
	BzPGVD96gjnPDI/vO3QJzydEhyHVOINdgSVobOR//xqMSEcFrubCB7BfXsHT1aFi5szE4WU9THt
	yLE2WlEwBIx8IGLLmlOmaiIxTTTA9sG23uSM8YpAR8HY9+iZKdIR8WrFNBrSvzjuaY7S/AIDGRl
	goOGlOFZ+uTdHjajZyS0wO0LqXvpSm4EyEfiQXb5fzLdwE5JKXfpXEqFZF67EPopaXZfa60i09v
	hMAkkHexnktDZ//2sMSiRF3Vs3KS63g5sokDlBXeibNXJGYiYmMHOWDV/hNoGondT9ZgetS5H4l
	h3EDZbKdnXkFtKirnmqTzF6XMJR+kUHL82RwvfWrkWHdMjPkDpLC6EGV+XdnZlywv7jkQtFuLh1
	zDJnmFF/3gqZx7w9OsiOfW2EOtUVWKpDadpZuqvuqezXE7gyjm49b1/h5a4L8GbbEu0kdW1t2E0
	98xGtHb0/5uAhuJN4rybffCs+a8d+MzxsX4hI8e7pO7Lk88=
X-Received: by 2002:a05:701b:2807:b0:144:fb31:a597 with SMTP id a92af1059eb24-1b3b61860eemr1668909c88.47.1794284393237;
        Mon, 09 Nov 2026 20:19:53 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b7ba88sm3540459c88.22.2026.11.09.20.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 20:19:52 -0800 (PST)
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
Subject: [PATCH v6 08/25] rust: device: Expose Device as_raw() publicly
Date: Tue, 10 Nov 2026 14:18:15 +1000
Message-ID: <20261110041832.1730924-9-alistair.francis@wdc.com>
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

We are going to call the as_raw() function later as part of the SPDM
library, so expose it publicly.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 rust/kernel/device.rs | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 2291d85b6849e..be89e9023b09f 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -262,7 +262,8 @@ pub unsafe fn drvdata_borrow<T>(&self) -> Pin<&T> {
 
 impl<Ctx: DeviceContext> Device<Ctx> {
     /// Obtain the raw `struct device *`.
-    pub(crate) fn as_raw(&self) -> *mut bindings::device {
+    #[inline]
+    pub fn as_raw(&self) -> *mut bindings::device {
         self.0.get()
     }
 
-- 
2.56.0

