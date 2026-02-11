Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1511349AFC
	for <linux-cxl@vger.kernel.org>; Wed, 11 Feb 2026 03:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770780750; cv=none; b=k3FAfReZsXK+75gKkeM4NMdqma/XUCjxElFwl/1M6xSA5bLftn12Qs2cuw/QtDLSAPElO800XbcHHmMcgAbrglYLmeIuCMnhOaT9IsfokkfEu9zWnVHDZoednRkJEJ7hOT2v6/dxOSjIP8lXDpfLx10/ImDiq+4bFdHHiBAiM9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770780750; c=relaxed/simple;
	bh=dNpi1NMAaQ5h9qqbmQ1Z0VBLphRlK4MYeHJdgBkEl2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pdVy/Oeyrksg+CJN/vOAkLDLJUVDQO6ypy9m0z4iqfjAKgjalWgZ1BIJgK0VdmKAbT1u1TwGUIwmCkB3CULacP5j+NvRYaSDvmGJtgHg3vB1+iM42bMdcgm/DyUU8r/jCrOBaEBRWDpAsrUCIVNLgWJ/tzfCKZAQHeNXFoFOQSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mY0cd+sb; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mY0cd+sb"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-824923c7059so606556b3a.3
        for <linux-cxl@vger.kernel.org>; Tue, 10 Feb 2026 19:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770780749; x=1771385549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Hd4JNZlcn7oVuweMnFnRxHFMq+VGi5u1+C/ZJTSOAc=;
        b=mY0cd+sbu8JVYqnTxyljkX7xHNpQ/WPcfvw+VJNyBREzjLBE0ICSuNdsX8PfeCCfND
         bLdUpVoNjPwMKHNmKk+kcY1WbhfZ2Kb/ADA8pgXRqjoIbNzOduTiLZAcrNmHt7ToxL+L
         RlAhYQFBYHXcbeth2C6tUXMEpYfqhrmHt4MJafaUhq/jpw/WTF8IfOIK/lqVWr3LJKBI
         xLyg7g5jwSn7HtQ82Q6R28NY5TNFeNaLUGnHxco9zn6ykzQP2Z+NWysX2XnzQHAUKD58
         cCkgYCjIJ0m/ol+SlFTuVNcCdFP+D42ab2XIRwRzX86FLYZwe8EnTuF6QnwNwBI4ZfEt
         hjng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770780749; x=1771385549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9Hd4JNZlcn7oVuweMnFnRxHFMq+VGi5u1+C/ZJTSOAc=;
        b=iLqdHT0dXi/O6eRXGiaFTyyVJw5ri6Q2vap91q7No1VkjXPGy+NvxhkJCtM2kLda5w
         EIlo+zuRbs2e53K6GIemnzXpprWrkesrYFo2A2YazC86Gcg7FbJfrRrLWorH/vZvW+tk
         O4h0SUOTT0+pfH9/dQ8F7KoKyIH2xI4ZoLtywWjsoG1SZpngvdIhxG331ybleFamXqs3
         +/DUqH/s7MZ7ErO0w9Mt3x3gjpOztFAux+VdcXn2cwUoYB0YJQZUtJiAYGbV7UG2d45a
         OJSEjZCDg42oojgI2aCRLwu1f0cMJEsA7adeZR3XQTJYQiyOrrQlleLkP5NNp50Exjh2
         iYNQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2RxZVvHONWAicSWQqv6zwOZBvfIF7Fn/Ypkp9xwvcE+VtjFSW7cJjbAwceCRfV2j/oS03T3LcNrg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0kbbEtJpHQFsM266vjATQiaOKzJ7NDNkd8XaaYFEbbfQAQe6l
	TWSWTFUjw6Ep/8MZVFUFQhZtms9pkTrzrX98zCCytiwCXEy8D8N9dnpz3O1l0P3ErAA=
X-Gm-Gg: AZuq6aLKh2BPTjXmOSWiBvZQ+kKN+WaJSpLf7mNVzyZWlV2SU0Eumy5QQCf0ID7sQ0r
	cO8Z1Yc2V14NOBBCX3alCjNKoIJHEqJBevhiyKzf2agi7O6NnxMV1S4Vjxi8eXQx8EHujxqO4mR
	P7Uk2WD/wPFwFKD/bwigFuxBQO1HCerm1jVM66QYiHf52XIyCANKkKxsZA2AXwxcR2yEtXQ991l
	nNipGLNSmX1aNL01K3FBdEev+Jer6bvjwKXHLjCowP8ayUxta9pVUnuw09zyU8KNZJLrGgKRu7U
	3a+uhfD5EsnbNmFWuCTNGyFtJfei7UzOTgR6Jb9KFGlqFc7rz+Y0QMtOi1gYFuy7zIyw5G0HQk9
	bw5YDpxWtTHOnFYXRG34YvS/IVPIpUh9HVir7cY5B4LKgI7w9bU7UPj54R/NShzXMkrYo1lQ/4C
	N+yfjCS5z0EXOxXJtKvSYtNndQJN3zpJhJhZbt5glQvfF+gAr0aV+V
X-Received: by 2002:a05:6a20:c793:b0:38e:9405:beff with SMTP id adf61e73a8af0-393ad3b6d6bmr16299563637.65.1770780749068;
        Tue, 10 Feb 2026 19:32:29 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e197d63c9sm464856a12.20.2026.02.10.19.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 19:32:28 -0800 (PST)
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
	Alistair Francis <alistair@alistair23.me>
Subject: [RFC v3 23/27] rust: allow extracting the buffer from a CString
Date: Wed, 11 Feb 2026 13:29:30 +1000
Message-ID: <20260211032935.2705841-24-alistair.francis@wdc.com>
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

From: Alistair Francis <alistair@alistair23.me>

The kernel CString is a wrapper aroud a KVec. This patch allows
retrieving the underlying buffer and consuming the CString. This allows
users to create a CString from a string and then retrieve the underlying
buffer.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 rust/kernel/str.rs | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index fa87779d2253..17426db83c9f 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -844,6 +844,11 @@ pub fn try_from_fmt(args: fmt::Arguments<'_>) -> Result<Self, Error> {
         // exist in the buffer.
         Ok(Self { buf })
     }
+
+    /// Return the internal buffer while consuming the original [`CString`]
+    pub fn into_vec(self) -> KVec<u8> {
+        self.buf
+    }
 }
 
 impl Deref for CString {
-- 
2.52.0

