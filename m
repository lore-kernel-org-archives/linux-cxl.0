Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E138345CA0
	for <linux-cxl@vger.kernel.org>; Wed, 11 Feb 2026 03:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770780638; cv=none; b=Ln1DE4B4HtmDPxX9MqOAlvHqf+vYx6vShII0pAa5nNK1TlxTTfOT8C1vBbJ0JmFdJ54T6WYF6G/OaB60yjU77SvTyycuv/Y0kiCXo8pycekD1n0qLk/Qdf6+4ev5IDhKnY/OHILpa2Us7GffW5hWOUV03UK/T7zaIC9bPbhDgtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770780638; c=relaxed/simple;
	bh=FppKemrwtWk7l1BEg98yFq7nk3dgLMRXUW1h9vBpl4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uWSEhWmYv6TvUJsnillPvKh26f2eVuaHqhp7yoJtjO+vzE6d5CocqGO1U29lR9VBj5wr06RB73/MCO1CvyrmvgH7ksQu6PCFN06VtBEzGUrvXsrzgHa26HG/BTI8N2KyolANzTWGY9R2EiMWdeyFNlbFGsuv0tbTNKe4XVi51ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AqI6ICbz; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqI6ICbz"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c6e167e3051so128738a12.2
        for <linux-cxl@vger.kernel.org>; Tue, 10 Feb 2026 19:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770780637; x=1771385437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=viBpYkVWc9cE68UFiQJOVrqrE/EpXnGovXyJD9hjSPs=;
        b=AqI6ICbzsb2BaM28dkfJzC1s0VCKby2Jjh0sYOshnzToGY8D4kJ+W80yGkWmBMtNpq
         uxV0fch3G3Canly3z/cAKYQdhFpd8wfRtpwc345q9o2hIX9EeiW9dmZdQZYgWNBBWby3
         W6oVJDGwtLxxeKosU8VGgQrR6PTQxTmgugZZt3n0X4XqlJw9mR9RknD6FbrT1emihhtd
         aA3ZLWp0V5xaYgDBLmWyOE3JmD+falHdgj7vwLcksen/3XzqW2Fyw/ULq39gZ80+9hUq
         yysM1hPLQppWvNe1q1G4m8EQ4ofLDLTKthYHFzydo7x3N+sDtBwc08mdUt0T2bQi569V
         nMPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770780637; x=1771385437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=viBpYkVWc9cE68UFiQJOVrqrE/EpXnGovXyJD9hjSPs=;
        b=nBR5HC9q64pxpc+hilXiioOKHWFRkwIoTLz8RHJSbe4JsXPVOW4rZujAfFl2x42pFm
         sfdWZ3LNkF1vqOfnzYBSSwuC9rk9Rl6l2yRZ7Wxv4vRqQrUDv0kteZ0EariX0fevqgcn
         uqHKyVwayR8ivsZcJN2kzWdqiwTvc8VysGegz8D5lz2+hHTkElfJLr4GqHlMAJ1gPTL9
         vEboym8nusGtlpU48aE7w17LA+9eAw5i4zuoFxsvBn83eOlQdGmJljel3/0BrD7Q6VZk
         TA8NBicfTr4MOpg/oxkqufDyagK7rL/LXjTxm2wb79nUSOSKt8VVr5BfYzgsenHcRutX
         HTxA==
X-Forwarded-Encrypted: i=1; AJvYcCUXn0/RvDpKlygsLUu/lZAa645k3stq1y48zu6zyG/KA+FMtYzHqklAIiBqe5ymsaVlnROluaQn9q4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8aM0jqqjvJyVc5n1S5WUyORzTMt1EzJx9upiaQe25kVJv5/BC
	6CgqMSmz8gNv/SztZ5OFbwkpo2eCiL024Jrrlt5IsAZhWer5Z2rk1and
X-Gm-Gg: AZuq6aKEGzLGM6TLrz1qJxDCqOtb7GLsPI7E2MjxATGWzHbHVozisAqb+NGPXb4ANtS
	6wmaSWNxjyVkIPcnpUt8HH9kwU5OUGo5HjwtDbbo81HVA4OxqjmDeTxENVtqj4cPqK944Vdoh2P
	iTNFtQan0w+wFs5Ogv19YLYezYsIxfOhsz/LADoUtzARSjDCmZJSTkYFF2qm+MLQjrePy8qlqrO
	tSry5LHcqdy2zd1m3ottFo5kbeFd1sFrVcm8dKKJ9isTLEI78uJvYd5ZazXDAUwrRDGt9N+OP8H
	+TlGpbisPXzXmZTL+b8Tn6NnKhIG2rdR1VDRtBqZP6lT5d7VpIKh/dAZP8pOIb38ZNrCdWLp40A
	A5ux81QEY0WYA17NbBVlZTwvG4rwxp2Xym0SF4xZauX61rv8j4fpacUphUUsIWiuA8Y8lncsWzp
	ogOIlnHTUs+tLQPSp4YIIq9oEHdhRVSmIrUy7raxsimw==
X-Received: by 2002:a05:6a21:a92:b0:342:9cb7:649d with SMTP id adf61e73a8af0-393ad01e8f0mr17914368637.26.1770780636948;
        Tue, 10 Feb 2026 19:30:36 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e197d63c9sm464856a12.20.2026.02.10.19.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 19:30:36 -0800 (PST)
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
	Alistair Francis <alistair.francis@wdc.com>
Subject: [RFC v3 07/27] rust: error: impl From<FromBytesWithNulError> for Kernel Error
Date: Wed, 11 Feb 2026 13:29:14 +1000
Message-ID: <20260211032935.2705841-8-alistair.francis@wdc.com>
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

From: Alistair Francis <alistair.francis@wdc.com>

Implement From<FromBytesWithNulError> for the Kernel Error type

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 rust/kernel/error.rs | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 258b12afdcba..569d9d032ab3 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -12,6 +12,7 @@
     str::CStr,
 };
 
+use core::ffi::FromBytesWithNulError;
 use core::num::NonZeroI32;
 use core::num::TryFromIntError;
 use core::str::Utf8Error;
@@ -251,6 +252,12 @@ fn from(e: core::convert::Infallible) -> Error {
     }
 }
 
+impl From<FromBytesWithNulError> for Error {
+    fn from(_: FromBytesWithNulError) -> Error {
+        code::EINVAL
+    }
+}
+
 /// A [`Result`] with an [`Error`] error type.
 ///
 /// To be used as the return type for functions that may fail.
-- 
2.52.0

