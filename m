Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794284386;
	b=TzLgWRu2hRgtgwhEOhpyfZrcc4mLURsL+J7/FtO9VJmgPXnpRbNk04rzCZiAsSnntbTv
	 7OwrLEYUvGm7oVMkvVXC41mNzs0SUQIIDpVwZC78g2tptrawkdUCqGwBHjEDg3H8i6mWS
	 JiIuKoH2s0gAsygZVJV63BOwdDuz6O82rbYz2cG+jLth3MPFU/+y/OvMBA8DznECxNu2j
	 SeLUP5Pa8nioMiig84Yg079yg9TpBdkUOCoDHRvRm2l4PzUFY7euhClPwleIo85lrsRfB
	 o23/QztXIu+36MZULksCDoRyqjK06PkPk2XOv9Mr9JXURFvGWc0m5BkP2rQR6KNMZjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794284386;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=GWNZ8zQxqiZGzpWyot+03nwu4qhuEeSDcx/Yq9DH+WA=;
	b=EEURBkKblV58+U3yrAgbnwIJ8BinsCol4SJZUGNCwKr9GIXu2fuBw/RaZtzbY63mjSyQ
	 7MiYFcwevSjUyZfZsEhKnswFlKYJ3JVDpVfNf3d9jIMm57LnGiJDvS4GjdJGSSLlP1TlY
	 neXYNIBynMM7HECIyIsG9DxQTmiYrF0KTLsjlm61Im52l+tWoQiZ6ATNdzVHHBzcPPWIz
	 2iwB3DZ8Enf/tyHFlC9nqo7Yp+DDfbfJaR8VOszyjA76sCrvUq27nVziRA2jz9kdl+3XD
	 4dWjXaVIJTqUu4BpgOlom5gqDyYE7Hf8w35IWWmTupznZlzaQH7NalRxMeCGdX+fuow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yGtenEbZ;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EE1606E8ED
	for <linux-cxl@vger.kernel.org>; Tue, 10 Nov 2026 04:19:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5EE1606E8ED
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yGtenEbZ
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1b3a05f8b5bso2461089c88.1
        for <linux-cxl@vger.kernel.org>; Mon, 09 Nov 2026 20:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794284385; x=1794889185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GWNZ8zQxqiZGzpWyot+03nwu4qhuEeSDcx/Yq9DH+WA=;
        b=yGtenEbZG7Qy6TLOfNHH0y5Y07HDUztMPNGH3pc770I1r2cy3ZaH19A2RVmEr0UI/O
         NZeYX9CpwtGDlWb0S9HZyajA8d25SmnVgJ4F6kjH4/q45zPIe1zefUOfIaqHT0g3hwFK
         Cn6+z73Wn3D/7ZIxwbuXvB0QWjr96G80mTxU2EXqHyigkYPy0OKly1nGOk5paCbWlat3
         Qk2roQcaq3Gvka9pimS3DGiW9wA52FY8ZRCFgkmUQEq86+1KQeoXmZW/nju7ed4FzWuB
         NbXDttmUANX+suQLHNmfzHEMZ0+Kzh8LhSxP+wbrlgmKTAIxym4xWpgfOT7EiNtfWu01
         T+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794284385; x=1794889185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GWNZ8zQxqiZGzpWyot+03nwu4qhuEeSDcx/Yq9DH+WA=;
        b=YxKFaJD3eMOdfguo9FtCqLPngSyWZPwtUgAVl/AJMMursCJgkVcHL2GStwe8atfn2g
         /eKuWiMbE86q6xecgBJFJtF4jkVCRIwRQubEBCc4pPR+y2QjCBLvn63zGo8UYnBlDBzW
         TW8hUjoKeZjktGUztBKseSQE6lK0fw6nZ1R8Vq4fF14TWnCY9H7185wnXZ6/uBT3wpsS
         WOOjwZaOQQi0yKOTgEgqFaQC8R5FaZZU7vrgD+6xEQpZ2W/gO/lNggOMCNw2Vs5wndgH
         SAQGpXyBkxRVFuOAeBbplFIecb42vbV4lubt/HF2Nk7+uVkxau6shkLNsU6HtXyyQiTn
         peIg==
X-Forwarded-Encrypted: i=1; AL+hErFklDFvrwQvdqgdIikYrOn2bOthjUhY8y5cLRr7VpytA+KNpvp+9wyXqhx5bI+qpSxrzbLD7UYSF40=@vger.kernel.org
X-Gm-Message-State: APuU4Z9plB2hVe8rYKwrw9qBD19dhqmLlZHKXMorGeHzVgMNNeXEJ1Qn
	0yOGymZdrJOLcBj54noDvF9IV3TTdsALwiY++0nKK8RyGEa2wsxbVKtr
X-Gm-Gg: AYBFou3agFeMjYZn3vZ3x/PXV+7Rs+w7gEIXCkEA3nXpmJrTLAk2pwtkWj7MCDlF/vP
	rbGiA7k6w+01frk2ATIgjcwYIsUIYVXBgOinF6BmqhINzmOoTsVYmNAywPaUheNoiwlO5lWIiPp
	edVY/0I8UWVczZUc6l+TkL9QuFaSKzbHbeEezR/3zMKY4HePTZuc9hS7ImBxucMir+yHVHvFD/C
	4zZk+oTKhoyzg0QktwCBJDBxESE/1qxwrF+fMxZWuuW6GmvMk4qGXX6jJ6M1WE5CPEpI5NxOysm
	qIyhS8ceUJUPaEtAKoT/S6oDBC35pTpsKBsAurY859kDTwqJSY8cQF5aO3SK6xcet6sHrmE9YLG
	7YFerwnkGzWpRCTKuAsVA6zLgreKU5lW7eog5a0f5IJ8F/RcN+BT+mn98q6yt+C3rN6svig1dvg
	Bm1GJs8+eFWqRIZsEiCmpgP8kbkVzTGktaOGsbd4UqVQVVF3b8fItqMWLKgaHGaxLmGCQmspcD4
	YceOHU+v6Y+ibZL5N4u/Js68LN3qC1Tz22v/ga6TCQZAAoRT0vDiqyE+vIQePaVV6TAu/rjhd7M
	RNsAEJk/7aHI/xnzYO7LIi2sOSM93G/jn1a+LC5C4+VUI4k=
X-Received: by 2002:a05:701b:450c:10b0:149:49c:233 with SMTP id a92af1059eb24-1b3b603e878mr2107744c88.27.1794284384921;
        Mon, 09 Nov 2026 20:19:44 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b7ba88sm3540459c88.22.2026.11.09.20.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 20:19:44 -0800 (PST)
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
Subject: [PATCH v6 07/25] rust: add bindings for hash.h
Date: Tue, 10 Nov 2026 14:18:14 +1000
Message-ID: <20261110041832.1730924-8-alistair.francis@wdc.com>
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

Make the functions crypto_shash_descsize(), crypto_shash_digestsize()
and crypto_free_shash() available to Rust.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 rust/bindings/bindings_helper.h |  1 +
 rust/helpers/hash.c             | 22 ++++++++++++++++++++++
 rust/helpers/helpers.c          |  1 +
 3 files changed, 24 insertions(+)
 create mode 100644 rust/helpers/hash.c

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 3791af0aadc73..4992bc3194e7e 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -28,6 +28,7 @@
  */
 #include <linux/hrtimer_types.h>
 
+#include <crypto/hash.h>
 #include <linux/acpi.h>
 #include <linux/gpu_buddy.h>
 #include <drm/drm_device.h>
diff --git a/rust/helpers/hash.c b/rust/helpers/hash.c
new file mode 100644
index 0000000000000..1e50fe16c5031
--- /dev/null
+++ b/rust/helpers/hash.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <crypto/hash.h>
+
+#ifdef CONFIG_CRYPTO_HASH2
+
+__rust_helper unsigned int rust_helper_crypto_shash_descsize(struct crypto_shash *tfm)
+{
+	return crypto_shash_descsize(tfm);
+}
+
+__rust_helper unsigned int rust_helper_crypto_shash_digestsize(struct crypto_shash *tfm)
+{
+	return crypto_shash_digestsize(tfm);
+}
+
+__rust_helper void rust_helper_crypto_free_shash(struct crypto_shash *tfm)
+{
+	crypto_free_shash(tfm);
+}
+
+#endif /* CONFIG_CRYPTO_HASH2 */
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index d62c7be1ca7bd..0dcdad905f0ef 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -67,6 +67,7 @@
 #include "fs.c"
 #include "fwctl.c"
 #include "gpu.c"
+#include "hash.c"
 #include "interrupt.c"
 #include "io.c"
 #include "irq.c"
-- 
2.56.0

