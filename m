Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793078807;
	b=iikE2hDWe2Xh3kflW5weO/3OE6Xgm3Kpbr5T/2zpoT4n463FgX2Zj0gp/LmcMjUQnXB9
	 +2DjucQFa61r2JZdcZmolGvowOOjnvYGDOH2qsudWgnZy8xy7e1eVRubzpXj24igZ8drK
	 BoQSHY0Z1PRhteuiLPP9XHqKcL+pBhTbRp8uwyxBQ5O2SJeoiDt8dNV1QYrum9qRAMdaK
	 TWLQ3xcxPqtEcsZjHMgxUajqAUbLFXb4H/NfWkymXdHgiSiaaPeFgKCwBjTTYcPrMcHG2
	 mIcA00CcbGsNmLPRQm3ZJc48i4AsykyaFtq0NvrXCXOUjMWIaqFHsVQJ/aqcpZTqBhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793078807;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=T6TW1w2jznm3rH8N3w9X8qOCKxQ7D6pil2Ovq4EdpOw=;
	b=GfTKu9NIFPEvxNL6g7CkgJ+c0jsebAEC3LgQRAhf06UaiVO0V/XwNguPBhQ8yVkRbvln
	 OYA7Zvy383whZ9ojYZ6C/07/FARZ9ym2z8l8p4+AGdJflHy0ruvW5C4Jn5BDK1PF5Xpit
	 erGVhAcNTmDeP63iMVRvVtUDs2YJeQHgfQKRemLbtZsOTkfzuYoCm/cEPN4U+AWqxoPI5
	 Ts47DnrbGS8zac0ZVuer++llphO6S21Gx7tyKPb2NrBqeZyuftJfXS6vElIK6DVPHmr4+
	 ee09d6BLIcFHCWmRvFOLjpZxx4M8vH9C3IRjzquZYAuAdplsTuHi5CwgaPf7m3jj1cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=l7YWkduk;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DC4606A31B
	for <linux-cxl@vger.kernel.org>; Tue, 27 Oct 2026 05:26:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05DC4606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=l7YWkduk
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e8b20a899fso23385145ad.1
        for <linux-cxl@vger.kernel.org>; Mon, 26 Oct 2026 22:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793078806; x=1793683606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T6TW1w2jznm3rH8N3w9X8qOCKxQ7D6pil2Ovq4EdpOw=;
        b=l7YWkdukGmEONpkg0BtkGWQSy4WllYCXyMIThhAIhTu4ED1/cSGJS5s1knAlHS8ZRo
         gfUwxmkyGTt4ImNVxavYKNF2Mtx0+s1gjwUVvDVAPZpkXf73GqiwBS5qKANmmXwJKQS5
         EEMlVMToU857uf7c5BbibthK6rylk2h5HT8vRc5k9JGxKhlmM9rRcktlW35VSFOjjr0Y
         IPXQ8SLb9FsfwzaoXHUohBXVTmaETd/buHwaL5V4xraKuVA9pxcg12MjsvhvgwWlAchI
         Dt9ntpCfAynJ6dx0DdEGpQeJ5+quw9zRaH8An0sdZveuM1g6Ba0/HUvnDlbFSXu7B/GI
         JJrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793078806; x=1793683606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T6TW1w2jznm3rH8N3w9X8qOCKxQ7D6pil2Ovq4EdpOw=;
        b=uLFOrL2BgU1r5DwjoC8kfB4+k3ORoZ51SNIo2NGHAIeg8dnZDGOx3hr1spx5yDUvgW
         Q4fJnG5+xE75anea8VpN7omyTAVO9duuwBcnX5Vs4APGVWwu67QDJKlTe3LmQ9RqSjLG
         5sMB1i271iNnGu57YAPF1mSWjIHMVp5UW8dOyL9xjLK1wahsPW9/TkziB/DYs8NV/yiz
         2kKf6gcdKLluQyezPCuGlnjoVGOVMu5QKpjopIw0A6xJC6bQPfqMQyufIKFnRCmIZZDU
         WoRw3KO2izup1wgxHr+RMea1m8QN1aZ/QhrtwpB6Wls4BXTNo3iO6sjKk7s7gTxmfoqC
         mvkA==
X-Forwarded-Encrypted: i=1; AKwUvByT477vNHIb/k6qbr23FWhP+LDbtJlw/SuAYQdpOx6moZamPTbXTwo9K/oU/R/QcY9YhWrQFRtBssM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKIr7r5Ugrfal/na0Gb6rFfplGBu0ZifBTtBPSsi8ewGAjCJ/eP
	0sbWJrcWE8oL6GXFi29meVUneM29sR5uVu8LYR1X28FHv7nwQ4/feRL/
X-Gm-Gg: AYBFou1/JKypkX5+pAF0ww7CRQcwvdBrl7G1fhW4nd0TV3F88y5/40IxMK8RFZvwAR1
	HSFR7dyPRGg2mvShDx64DL2ZRKc2ihfpbU1B2L5Lih7VXbtdmAkShw8s5uUH7Sjzb/3rTdaJ8Q2
	NsjeOXMDaycHc6u0YDBDBksff0Lb1meMCdhzbmTmwLEZ0iW1JJTldHDEl4913NhoUhtMFfIG+cN
	R3dZsINMbpZOLAgiDXeCTOWa9H3mh7/yUlcb2Eq3ZXOnwINfEI3JemouUs/syXM2GVS78E8nL6o
	JuxVoECRBpZKzr3S4xLVMcVV1zjQM2RB9h+aO82Sg5C+nlTpLdXnJo9Tzt1mc8va5gQ/vpXCQXM
	ETtcxKwtfFlqH22h3pUVaHrCM6k1WezEs67pygnqYsx3ttRfjsEC8rAxVSmdkedTJXMrp8VZB7b
	YUz8jacp2ok/q5WoTqQXAGOJVaX1CDIoutJ8XpRObfDRoLUgTDuVY6LS9YnrnDKjN11iNgE+zgZ
	StkdbVJcyOPwuMR1dDxuxkKVqj+2svLGWxEwwNnCSaWLqWYeE7SB7wQBn8Mh2gz5PDMfwN+iQ==
X-Received: by 2002:a17:903:4b4c:b0:2e5:f62e:2eaa with SMTP id d9443c01a7336-2ea9c88872fmr70545755ad.43.1793078806314;
        Mon, 26 Oct 2026 22:26:46 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6c9757bsm3307715ad.58.2026.10.26.22.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 22:26:45 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: akpm@linux-foundation.org,
	bhelgaas@google.com,
	lukas@wunner.de,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	alistair@alistair23.me,
	rust-for-linux@vger.kernel.org,
	jic23@kernel.org
Cc: ojeda@kernel.org,
	aliceryhl@google.com,
	a.hindborg@kernel.org,
	alistair23@gmail.com,
	wilfred.mallawa@wdc.com,
	bjorn3_gh@protonmail.com,
	gregkh@linuxfoundation.org,
	boqun.feng@gmail.com,
	benno.lossin@proton.me,
	gary@garyguo.net,
	tmgross@umich.edu,
	alex.gaynor@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v5 08/23] rust: device: Expose Device from_raw() publically
Date: Tue, 27 Oct 2026 15:25:21 +1000
Message-ID: <20261027052536.1722081-9-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027052536.1722081-1-alistair.francis@wdc.com>
References: <20261027052536.1722081-1-alistair.francis@wdc.com>
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

We are going to call the from_raw() function later as part of the SPDM
library, so expose it publically.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 rust/kernel/device.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 2291d85b6849e..a355ac9803410 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -262,7 +262,7 @@ pub unsafe fn drvdata_borrow<T>(&self) -> Pin<&T> {
 
 impl<Ctx: DeviceContext> Device<Ctx> {
     /// Obtain the raw `struct device *`.
-    pub(crate) fn as_raw(&self) -> *mut bindings::device {
+    pub fn as_raw(&self) -> *mut bindings::device {
         self.0.get()
     }
 
-- 
2.56.0

