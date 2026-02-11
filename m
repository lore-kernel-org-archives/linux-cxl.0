Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E0E34DB6C
	for <linux-cxl@vger.kernel.org>; Wed, 11 Feb 2026 03:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770780772; cv=none; b=JHdHmmShMKowfBc4mh3H1ok04Mopc5v67x08YU2oHNx1DSFpLAUdQ4NLr8+ulSMPzhdYThkAFDGW86FZYdUzudiYouaj+zA+hVUKm0TDttgN2tXHTBlX3qhYLk5tLecKiIkwSeVPrZ9THI9c7g7+R4z0oZqc0ocyr/puH7x/duk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770780772; c=relaxed/simple;
	bh=vSBHsAMqmP0mTWh5XLC6s4jgQYugzTdX4cOLY716pds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qa+oWy0tPH4i0TOnq3xHjtXMx88uiZIKOSbnPCnSjfhLxW/38NRBHYvUZ7Yl8L/QsBbzRu24dy40H6ha+4V5AE0R8kI2cSEka0uxNtLkm+0t6mx/uo+yDDtuLF/6LMWgga2QkqephrmkA4abK1alxxcxL3/f4S7T6fMQXEGEzqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zox2dZZa; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zox2dZZa"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-81e8a9d521dso3048147b3a.2
        for <linux-cxl@vger.kernel.org>; Tue, 10 Feb 2026 19:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770780770; x=1771385570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dF6bX/QVONfWDQrBCiwnvcbeLdCbDl1IQ4EC8a9rjVk=;
        b=Zox2dZZaeOEmRU3KE/QgDrV8zctrDPtHoKmPoXeYbu8I+pDBVaZ2Rwjsxmlcm4JNmQ
         33Lm13+sbsQ940Ul/9B3K5eilSYAz5awblnZHWIeIP+SDidJ9NWUB8I+geJmpdXmuEpX
         CD7517TXo/+KS9H9Zs5vKiUWvR3V0NjdWBYbI/Qf3JSVdoTK9/EXIgxtR688mxpssVOq
         mcgl8FLgt4A2vcz5oN17PIYVv/3tFCu0d3EM+FVdFcDGmjXAW3IVKRuzt0c53RFydqFA
         91nMutKIqVSASx/S0ku4ISfmrSxa3gmYFD2wReracFk62e89Meuhdd9YYtV/aJzOt6CN
         lFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770780770; x=1771385570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dF6bX/QVONfWDQrBCiwnvcbeLdCbDl1IQ4EC8a9rjVk=;
        b=Lclew2JX0utb4KzyxOIIk+xR9I38xI3YqzY2fllxVrWMimDVt2KMknMsy83EVWw4Qt
         sLIbM6tsH0/h3QxdG3Mz8ZaJboml91TqFQTnbZSeKCWLyul7Gb4LDHOgf75u8BlS2kmZ
         L7+czrXUI4aUhJ9q4kg6drEYri6bgBo+IR4YfyD0wUXnegv/d9QIPqGzsN9v+bWHZsSN
         wTNZDHa4okbV5V4AUAp5nsFyVLCDAMRChsbm+5PKr46Lh3MXptKO5igTi0BrxrNf2LZX
         ZzUxVO2EKf/YnJxy4O2hh1eTVv4GmUVLGuDLnVDev9yKredAnGyhDhlxG3kAmCsgtKt7
         Fjsg==
X-Forwarded-Encrypted: i=1; AJvYcCX/gV7rBiF3wI8PD9uLVaPSHsp785MLxGNWA9Nopotwg0hCWOH6E9Hs3PJSYVyf6gIYxz+yfGMCniY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPBXNH08G+76Wvgf2rWT1aUvNd3Hhkt8xUDwOPwuBf+4D3JMJS
	uQ7lK0SA5kQnRYDtx3Pn6emulDGevOsLS2I2T3kyLul+83ET04LVZZ/z
X-Gm-Gg: AZuq6aKFJjJ3+Hy5ni4Y+RtRz/ylLKAVAgC5pcRALOWhoE8UqzoWdZdDWEduTazyA4p
	3/jtzySxBoxmfQPQCkbJ0TiC/jgNgHlUBYcTQ5CO+F2N4XH+hzamhixNGAG41zXMnWx6jUWMmlg
	5tkYyjSGYqMF4voTB+ENd71hHy8K8mmVSW2zo1nKk4TpK7X92Rw/NO9c/aNLqp1Vn/cBatOIO2S
	K7Z1rPpi3l5+z+FYMEdGZ6eJ5WbJ1ox7vFBk5kt+u4Je2NWkwl7okNe+bBt9SDs9kaMvOLHleIq
	kGdd6zZaVVkieaDaYGYaMSkSCaO9jVpxTdx+kH1axQbWT06FPTtL/q+/56D4RELXlgNXFazY+AB
	TEKz8U8JLkT39QyuMqrMzU/KmUpt+xTNZT920U3HOo8CWhsIkfbKU6FqePHiVe6IfZKkWT9sC95
	xkwehUJGrlw+AM+HxVhc/BhDHSpn6yncemMUSw+GfVBQ==
X-Received: by 2002:a05:6a20:9f86:b0:35d:d477:a7d6 with SMTP id adf61e73a8af0-3942e35f73cmr1201854637.13.1770780770454;
        Tue, 10 Feb 2026 19:32:50 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e197d63c9sm464856a12.20.2026.02.10.19.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 19:32:49 -0800 (PST)
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
Subject: [RFC v3 26/27] rust: add bindings for hash_info
Date: Wed, 11 Feb 2026 13:29:33 +1000
Message-ID: <20260211032935.2705841-27-alistair.francis@wdc.com>
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

C code can get the hash_digest_size by indexing into the global
hash_digest_size array. We can't do that in the Rust code, so let's add
a Rust helper function to allow us to get the hash_digest_size.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 rust/helpers/hash_info.c | 8 ++++++++
 rust/helpers/helpers.c   | 1 +
 2 files changed, 9 insertions(+)
 create mode 100644 rust/helpers/hash_info.c

diff --git a/rust/helpers/hash_info.c b/rust/helpers/hash_info.c
new file mode 100644
index 000000000000..d2cbc08b57d1
--- /dev/null
+++ b/rust/helpers/hash_info.c
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <crypto/hash_info.h>
+
+int rust_helper_get_hash_digest_size(uint32_t offset)
+{
+	return hash_digest_size[offset];
+}
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 4b08b4f1d3a3..34db9eb5e43e 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -31,6 +31,7 @@
 #include "drm.c"
 #include "err.c"
 #include "hash.c"
+#include "hash_info.c"
 #include "irq.c"
 #include "fs.c"
 #include "io.c"
-- 
2.52.0

