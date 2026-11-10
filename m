Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794284333;
	b=MlyZyh96bFLI/nmP8Xq08aOv/z6OnbTg0K/s7ObJc2+riZnEPuAbUBtJmwth0bLiARR9
	 sx1K3AvnNpOSo9tGSggMrwYkFhnVM7veITow0NOak57bCS/p2Kh0B5v1oCAfF1E7b/S2B
	 1HVfo6OOuREQZQUV/I3jvsJIi7QYEbQ/a+AsqXhzCGgLrQ3cT2zBWF9rpwLfseGIeT+kX
	 GZ9VrTFIUitdMO8/ynfE3s5IJ5dTgaCMgbv3wKjgwdFhovsV7qpiVjIc5OAlE4Y3uOI8/
	 g82I8FiK4W+PXIamkbJ7RABZpD/n/2HcK93mi3pHnAN4IOvBupSZJLDv6jpXJ6NJn6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794284333;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/PPCRJzYX/gkAYasFGf9AE1kvXx6TkVJOW81o94WTfA=;
	b=HHYPcryZcmWKkz35DnI6KVvmk08WvEUlVqHf1iT4uqNGWHKowQgBa0kYaeeTUz97BM/U
	 rc2+a4K7wzCehY3VQUkhAWA9YbRRppn1cL6nA4VhXVDao3eMo6hLyq5NcvlhwPKKHS/Ru
	 feXAoJzBV31ga5PU5JDSrcB444hIfB1DyAxILABJsgNUTnZOEPHTQt09TXTgnP8Gursh5
	 62MmjRHv+d/JSxMhHkzo52h6rnuxJ5JYR6+FDfmjEAjEZq7nP9WFRpCM4KdujRN1mAHnY
	 an7jl2fYMgqib3tcPnP6achKHCPPmMxtzVmfzK1vGjTMbX90Rp6K3au02s2hJhS+4Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KJ5FxfYE;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB4B606A32E
	for <linux-cxl@vger.kernel.org>; Tue, 10 Nov 2026 04:18:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CB4B606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KJ5FxfYE
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1aefd1bf74aso1357555c88.1
        for <linux-cxl@vger.kernel.org>; Mon, 09 Nov 2026 20:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794284332; x=1794889132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/PPCRJzYX/gkAYasFGf9AE1kvXx6TkVJOW81o94WTfA=;
        b=KJ5FxfYEV2AlmOZ0PV5RTnsUn6YDqKKyWmpfQ1/KX9Im0Mu4oidFvqPyW1IdOTw6J6
         yg6X6TrPj0P0slZ+KC21GHQqPelZ+p9hBDWuIWnCHrlYsxuAM1RAt46hgJugE/jhcOOJ
         a0rA4KRFfFTMU7unb0u84VA4W82XKiP9SC2dK6YxXO2qq4FkV6OE2Xk6TozYgnK129h4
         adKIaWbkh3XtpsTUTVN35+4FiUV/U+6q2K0agBPWqcoS/lEgOzPdAKOcnWrrs7/MwAUL
         A3F4ChPxmQNeFQeqUv+IhLNe1lT+V9assrC/+lr6X5ybZO5zx31tI8ieETg/vM1d3oIg
         PE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794284332; x=1794889132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/PPCRJzYX/gkAYasFGf9AE1kvXx6TkVJOW81o94WTfA=;
        b=frG1T6ctJEm1EA+yuXFV7SrCs0SpU8wNeB1vkUCYBZdEoAl1uZ3bXnkcEH9Xf3+h2S
         BxExm02tzyDuzsjPifyVDe8vVeXonWiJJ1cdEKIY+H3Q4YGOYCXd1NUQETK1StaEUiaz
         1JoMX505mq+MjM4o2Aaes/J+wjO2fnrN5tot9fFn1fCDHj8ShgDbZRPJdYtq1m8WN59p
         qh4JmpIbQ1SIyKIai5t019TE2QFg+IMTd1/0Vg1s314WgqpIZspUx/WNdzKwkEPZ1mKy
         ugvozzTopYaoZPKEzBM578NKUuvmajk4cOd0S0nPURuaIQx6l4+VRVjjzLGkv40nHtxL
         MsIQ==
X-Forwarded-Encrypted: i=1; AL+hErFLkbzk2/XHR8X5DXPEGlqbU8LnAbBGUNbrELwjPJzJsCuNI7iNJby7cXESGUterOAOwMseN5/yPUk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9PTVX56fWcPlKvHAlJF13wx9jqSOrla2q86GJV7+Dp4NRWmvvG
	EovLLROHOQBJpNVEl6G9JkpnUTDdkPQnkAa5FqGBAG02Bt/VkWtsXGPz
X-Gm-Gg: AYBFou1UAabrdpiXTz+lFA78V+uI8/idQm40su2ijrryI2/1mgJY1Ii6rbB2EmoJn8P
	IZYAW2W15iKXb0zAF9ry+CZjXPHuRAg2qJavRLX/IfPLRMwk2qKHOvB0uxMPWmUYDZsc5wF/zIu
	jHxcvclcvIqqMpiBfJhheR6AeTeEUdw48Zg/gAPn/JpCzgTaH1Vo9l+IFxUdiKYmQAbNEtJP714
	MAesYcBRr/hnVYn31iaDg0Yr1YibpmHDoViLvN1cgSYW2HVCE7wY2KObK38ypPQYSCGbPWoVDpR
	DgiFlPfsEXDNgpRFUGPjOHdbAgEVjh/gOpZKtRX7M1vJH9QqwMFIkqgDh3iMyayF7rrO3b+dtl4
	wOoLO26PLUw5OvO/Er0y1BM+jevlA8kJ3l7fjObbKgZ7kUgCqo1xBQsD1m6CAF4LI95+wdzO3Vf
	5ugmio6GWE67tgtBN+svfU9PZPgiG2TF/V1O08PYE52a1+OmngGtuLdi4ja+7dobrYbILSdN7ym
	OyPJG3pyqwUufpUqrJ2P3WtkWbmRTtDBvl0GMc3QXQh3gg2bhbgUA/bIGPvrm+ahmDVkLM+eiwl
	MeR5gyoK0bWfrz7mvLrOB0C3g1kJS7ANAj9RdtnuKHqVhbU=
X-Received: by 2002:a05:7022:408c:b0:184:ae11:51c8 with SMTP id a92af1059eb24-1b3b5e5d8e0mr1852652c88.23.1794284332360;
        Mon, 09 Nov 2026 20:18:52 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b7ba88sm3540459c88.22.2026.11.09.20.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 20:18:51 -0800 (PST)
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
Subject: [PATCH v6 01/25] virt: coco: change tsm_register() to use a const struct
Date: Tue, 10 Nov 2026 14:18:08 +1000
Message-ID: <20261110041832.1730924-2-alistair.francis@wdc.com>
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

The tsm_register() function takes a struct pci_tsm_ops *ops argument.
This eventually is stored in struct tsm_dev as a const, so we should
just change the tsm_register() register function argument to be a const.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 drivers/crypto/ccp/sev-dev-tsm.c | 2 +-
 drivers/virt/coco/tsm-core.c     | 4 ++--
 include/linux/tsm.h              | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/ccp/sev-dev-tsm.c b/drivers/crypto/ccp/sev-dev-tsm.c
index 46f2539d2d5ab..48df8c579c74d 100644
--- a/drivers/crypto/ccp/sev-dev-tsm.c
+++ b/drivers/crypto/ccp/sev-dev-tsm.c
@@ -339,7 +339,7 @@ static void dsm_disconnect(struct pci_dev *pdev)
 	streams_teardown(dev_data->ide);
 }
 
-static struct pci_tsm_ops sev_tsm_ops = {
+static const struct pci_tsm_ops sev_tsm_ops = {
 	.probe = dsm_probe,
 	.remove = dsm_remove,
 	.connect = dsm_connect,
diff --git a/drivers/virt/coco/tsm-core.c b/drivers/virt/coco/tsm-core.c
index e784993353d8f..6b735ac2a814e 100644
--- a/drivers/virt/coco/tsm-core.c
+++ b/drivers/virt/coco/tsm-core.c
@@ -57,7 +57,7 @@ static struct tsm_dev *alloc_tsm_dev(struct device *parent)
 }
 
 static struct tsm_dev *tsm_register_pci_or_reset(struct tsm_dev *tsm_dev,
-						 struct pci_tsm_ops *pci_ops)
+						 const struct pci_tsm_ops *pci_ops)
 {
 	int rc;
 
@@ -78,7 +78,7 @@ static struct tsm_dev *tsm_register_pci_or_reset(struct tsm_dev *tsm_dev,
 	return tsm_dev;
 }
 
-struct tsm_dev *tsm_register(struct device *parent, struct pci_tsm_ops *pci_ops)
+struct tsm_dev *tsm_register(struct device *parent, const struct pci_tsm_ops *pci_ops)
 {
 	struct tsm_dev *tsm_dev __free(put_tsm_dev) = alloc_tsm_dev(parent);
 	struct device *dev;
diff --git a/include/linux/tsm.h b/include/linux/tsm.h
index 381c53244c835..6ac12de8c4d36 100644
--- a/include/linux/tsm.h
+++ b/include/linux/tsm.h
@@ -120,7 +120,7 @@ DEFINE_FREE(put_tsm_dev, struct tsm_dev *,
 
 int tsm_report_register(const struct tsm_report_ops *ops, void *priv);
 int tsm_report_unregister(const struct tsm_report_ops *ops);
-struct tsm_dev *tsm_register(struct device *parent, struct pci_tsm_ops *ops);
+struct tsm_dev *tsm_register(struct device *parent, const struct pci_tsm_ops *ops);
 void tsm_unregister(struct tsm_dev *tsm_dev);
 struct tsm_dev *find_tsm_dev(int id);
 #endif /* __TSM_H */
-- 
2.56.0

