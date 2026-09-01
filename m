Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974C838E8A0
	for <linux-cxl@vger.kernel.org>; Tue,  1 Sep 2026 01:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788224718; cv=none; b=GJPjA4Kcy09G2WhF6wczhfWtsDQH9uvt9aYcn+G4dLeTfzj/cJd85LUrV546+ODSV/TQXRAUuLng37Kmi31ukB2i/QJZOB2SRcfDULE4Rwp6+0BFhNK2oDVi96t2gQarw6A1NSsJz2asm7GbTwm6s5hQ506ugrmZLvkWk792XZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788224718; c=relaxed/simple;
	bh=S/AOyWuaiA3NHvzmTE2CNReBuvvkbVK6T+Yewj+2g5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KBu8Oq4razdqHk4rOM+cBr2IhGYWJeYoznQL+tiwAsDXVIeBqh5kyxfo6MtOboM2zaqki1+GId47L19x9KINIZTT89K7Sk1E24lHNnYHtbYJK6YuBJ1AEH/HeX4Anw2GxRLdhEoabKvQ71ZnGcpf0z3dVYCLsE67SGRVHiH4SGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fd+bz32y; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fd+bz32y"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38511175ad3so4282168a91.2
        for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 18:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788224711; x=1788829511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZxuwZq03lYI2TGgQtjkc9QJfZ6xOq7ziiudQrg9Xx9o=;
        b=fd+bz32yCWvfXhKEUaxlixgV3kiy6TsUmNr5WbxryVjQpBcFI46cP5ABP7pCz5XlBU
         3s0W9Rv+ct6iQSD08ircYVhfzpDJmh6EwZwD/GHWzMGQ8h7D8KgjvTR29luloQFpgtNt
         mt5c8n7k9kDfShQU06bWnRXsxv/KOVQwoZGRslhvCjYo4lf9h2Qav4vK0Gm5B1e4SnhF
         St+MQG0l1tM5umdMm4zGBSlgnYTA7RZuS8/TM7yp2GR1qy/6G3m5q2Cl9B+6LhnVuHRO
         Lq0WTaNI9lk5BNmNIujFUeTBROi8DFqEneJIhS+RM/icgq+oCc5txVxH1AJ6PGSH0FXA
         muAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788224711; x=1788829511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZxuwZq03lYI2TGgQtjkc9QJfZ6xOq7ziiudQrg9Xx9o=;
        b=NpoJfMWV7UIa5y1R1obvrZXmK1MClBVCsBvVC0S7bWzVQ0Cq6pxPNCXwwPD6/MW90I
         Vdib/UGAZVXRu+XXB+Y0V0bcL0/ob1VxMQQFNF+WWckoS/kHOn2cfLUMYqDMuke6ndgf
         t1HuOaqD/7W1tp8dWhiEzYqYbaXqQiS8YeTIdVg1TSi3e70j579hFzzjr8ptAJ2u3qxM
         0UYILoV3XJANeE9V17vBowsirri6KRaV5Ps1Z7wh0Wx9rbHE2hw1QqyQoUjbEVp8IGm3
         MVWsi7cFb6vInoXkMc9zTdk/R7X8rP0Y4HGmCAN6NN7o95FNBIvnX/4Ibh/zAw8yzpgg
         XZ+Q==
X-Forwarded-Encrypted: i=1; AKwUvBy90tjAjV6g4L2a+rxR1eJqkcUW6kHG+GDV4fmX6Oms7Pcfxk7J7+yuejz03hQ4wKgNz4qG/IcMQxE=@vger.kernel.org
X-Gm-Message-State: AFuF++mx7a7KFdxH8v5n9POHf4cr6x80DWoqP7H4aPPl+qSyLRetaZll
	/VX2wv5IY/7h+5BuYGj1+6iIlEAZ8oIHXywEm0edE6aREsIvMuwNe9CH
X-Gm-Gg: AYBFou3QecLtClCPEBywze4ZGWHtIplo/+Hn+lFhBUYA6A4gENneSL1f1ew2l1FMZGI
	QQ/qDwgndiZejGcCYAgv+Mclma44gcqBawZGGUC1giyVOIq5aTvfqBb9P8hUFtIPS2bl4PRpeUn
	HqmLC1ewtaU5KWR+dpTLLOe5QNPBz9KfDXDpjWhwg2ApQ+msQbbKUkOhyn1fkz7HH1toWrC6QRA
	TpNmFyK/nWpuAhZpHGGFN12tz2Opck8kXIU64VKqtJnavl5fzRcdyIk+Q7VsxYpOctMEA4PTKfu
	eqmom1C/ILt3d6H+iClwVAMBsCQE+f0nftoWwQXSDLL3XgCaMzGwqqPKR0Rcl9/phRhvMYLwsXi
	7EYOyPcmsLbKNwAEwR7WzZv5zUXgkvYL8ZxuUtufWfnLQDyyeuuI+STRV5REsJn8igKCJh4bBMp
	M1NZ+MHtKvXij2Ly7T5PZrn57r2PuRRzi+PgRb8D1Qj2lWwaz/fZsZm4BV7r2a8vI9fEH6n9V53
	zxw5z31zrgqTTWk
X-Received: by 2002:a17:90b:5281:b0:38e:6aa7:68ad with SMTP id 98e67ed59e1d1-39907aff83dmr6183862a91.5.1788224711002;
        Mon, 31 Aug 2026 18:05:11 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990d49e9e0sm2372024a91.11.2026.08.31.18.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 18:05:10 -0700 (PDT)
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
	aliceryhl@google.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 08/21] rust: error: impl From<FromBytesWithNulError> for Kernel Error
Date: Tue,  1 Sep 2026 11:03:34 +1000
Message-ID: <20260901010347.2614656-9-alistair.francis@wdc.com>
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

From: Alistair Francis <alistair.francis@wdc.com>

Implement From<FromBytesWithNulError> for the Kernel Error type as we
will use it in a future patch.

As this is now generally available we can remove it from the test case
as well.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 rust/kernel/error.rs | 18 +++++++++++++++---
 rust/kernel/str.rs   |  7 -------
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index e52793f77196..84e6466f54c2 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -12,9 +12,14 @@
     str::CStr,
 };
 
-use core::num::NonZeroI32;
-use core::num::TryFromIntError;
-use core::str::Utf8Error;
+use core::{
+    ffi::FromBytesWithNulError,
+    num::{
+        NonZeroI32,
+        TryFromIntError, //
+    },
+    str::Utf8Error, //
+};
 
 /// Contains the C-compatible error codes.
 #[rustfmt::skip]
@@ -358,6 +363,13 @@ fn from(e: core::convert::Infallible) -> Error {
     }
 }
 
+impl From<FromBytesWithNulError> for Error {
+    #[inline]
+    fn from(_: FromBytesWithNulError) -> Error {
+        code::EINVAL
+    }
+}
+
 /// A [`Result`] with an [`Error`] error type.
 ///
 /// To be used as the return type for functions that may fail.
diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index b3caa9a1c898..a556788bcc5e 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -433,13 +433,6 @@ macro_rules! c_str {
 mod tests {
     use super::*;
 
-    impl From<core::ffi::FromBytesWithNulError> for Error {
-        #[inline]
-        fn from(_: core::ffi::FromBytesWithNulError) -> Error {
-            EINVAL
-        }
-    }
-
     macro_rules! format {
         ($($f:tt)*) => ({
             CString::try_from_fmt(fmt!($($f)*))?.to_str()?
-- 
2.55.0

