Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793078754;
	b=jyOlM+C1I+v0IOPIziumF90d+wzUsFAv+OeWPTYjELwHa+Ycr/EaSc6QSUHXV4r+PZRP
	 ZjlC5rpvdMcYCF2gWwidSNLNIvAU8dPJ4+07my99QcxmEpcHTKkrptug1DZp/lID4gofa
	 0JUwRkmXpLoPkdQv2tgeG50z45RgGx/3M2568288pHj5p90htfGKFMbF/2CdqUwD71sf/
	 lh6pPkhCoGVZeg9105mskw05tE/8jFSTZsvGWefL9SNcjLSqyvJsBWqSrlOpu/n7CTrXK
	 9MjBve1FNPVAUjZ2mK1Q/XWooPb0uE5r0T/cB5KZ+xn/8cF6sosltIYO2+7EGFy2VrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793078754;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/PPCRJzYX/gkAYasFGf9AE1kvXx6TkVJOW81o94WTfA=;
	b=fsXBdWzg0rXoLxUyQZo9DLeTPObb7ZG1Egl9VOxUlCYhkNZUfKhYwcyeQM7lGMn+AZvk
	 DqaUt324nKVAPylbV+SvHjtuZso8IYZ3ZB3O0LQNCJU3IZ6oLohUbuT4AYsmFqAc0gUBE
	 D2ciMUylU8BgI4TJa7u3Q/a5/aKNqb6xjqITRJj8k/+5kzW2ypkjsd+toqGNsxmzeYPNu
	 xazndes6uA2KLiDv1O2m6l/V+aSHCDYElEvpk951t03vy529FQ/Qyn0PWGKjezV+MPvGN
	 xCxB+Zjo8pWCj2N+MXDuiZsLeCiXv7xAg59Y+A9YO8d1HeVYDuNzTHVJ2rjzM6oDCmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Cz2btDR8;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5320A606A320
	for <linux-cxl@vger.kernel.org>; Tue, 27 Oct 2026 05:25:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5320A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Cz2btDR8
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e8f2c3ad6bso24313175ad.1
        for <linux-cxl@vger.kernel.org>; Mon, 26 Oct 2026 22:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793078754; x=1793683554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/PPCRJzYX/gkAYasFGf9AE1kvXx6TkVJOW81o94WTfA=;
        b=Cz2btDR8XV2eezXzWRlq7mbSvagoFv+4MtQfyrcCn7L4Haf3pdebXhwFFcMA+fiAoI
         nNym5bMFgAm6rEppUfIigN//XpHC9ruj35Ed6Ve+0Q0JhUswR98+bZorurlfG2FazHVi
         ziQibUSnNZzwIsS8pgeY8ZpwnqSMKD0Fcv13o317DItLWyEaK3e7sEHJEKlyNMENKuu8
         27AWXQByvboKoYM5r93nHfR9FwfezhgVBEPVE4oDs+ozM0O4fg8OYBmOHKwH4R8DrNka
         0zLj8jAwl/gpVw7mSunoRfESjwWHrwvwtm9EETHzkkT3Gi6N4St+LRscwDcyxk8bepH0
         un9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793078754; x=1793683554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/PPCRJzYX/gkAYasFGf9AE1kvXx6TkVJOW81o94WTfA=;
        b=vu55ytKfmHweuoBdhEb2BMO0UxU/RQSxyyRwNROXPl0TtIE3b5+whOBnUy193HJ42P
         bA8jxtlycYD/1y4oIE1Taz2S3D3o0gIt6eDeBv8wuWKu7+G31w+yt4GFXNMw+rbx+KD1
         NPmgw+7nxHeLOsgYt/raPu/PdRZN3L9rN5ZMJjLM+KMU+ZCAv1oUzHvHHl4mwpYb5Ila
         QPzZNwOTSh4EEDMA31bBMoVASoZ71iJhveak+NUT3fekOClJPTohcWNj596euSUzzSCL
         ssl8+LISlOrfRkrrBFePUi1MeBzEEG3h0pnJ3foYF8bQyskyDggKCoDIP7yxXCQPlyVh
         2kVw==
X-Forwarded-Encrypted: i=1; AKwUvBzz/LwLYBCWOjT2MESWox06CzOVwyU9T6feog+lXOvgLZ9Z1Fa7Si7Aw2YlTmIBjScHITQ99aRejyQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKx6UvEtAmgzDDv6SN54gVxIhk1WK1xRmSwkIP09NRLnRKqMgN7
	2CEs0Ap9n5JEEVKqTkLs2J424HGKQJGaXpaM2djgEHf6m0Gt664/Mfw5
X-Gm-Gg: AYBFou1lL/ZbsD1Z8FygBJSEj28f4E0YF+0I6rfcSjvO5s2QRa49eEt2OkXZw9e5Gjh
	Zzjpw2Xw4iojB+52bDUxB8eA1iplArVIIjHGflmM/+u2Y+ADflJZQ0jV62A4u9/UQtUxFsQKmAQ
	aPC60qFpdFssNDp9ccXNKv5xfzobkrJZu+kBnpM3qi+b1TCd7SAnkakuzYnWH0rdgoESv4EakSD
	gDT07kOzjrmypv0cb0wDKU2E8BZBRgGOigq/6cwBy4hOeZ/CSfZQUQLCyYGKlNz2DyCk9e22hbV
	RV6w7TwuyGu+Fmg6UztLM5Amvh/3HNVjsXdRNazlZ8WuWIHERX98fyIYtHVzZOHIChZH9DOZSRE
	OTvoiuEzJn1aLaqSDPRTt9phhD+zV6879cpuTcaL0kNWQAGuAEPfFQxtI2tXldBMFAqzeNrp0+l
	6mB5h82cVmrurHvImfB8/LAeApu7ZZjvATU6tW1WY5KEnZUbLws+XTql/btVy0VdlG3AVWG8hoA
	GKoOdgBoebvrP7AIl4NHDP0w5ZaeJAy2Km7nRlzFbbcsq5T2A6Z2fW6fVuyi1VXubzyWH/I0w==
X-Received: by 2002:a17:902:da85:b0:2ea:71a7:7f21 with SMTP id d9443c01a7336-2ea9c6c245fmr69254805ad.13.1793078753628;
        Mon, 26 Oct 2026 22:25:53 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6c9757bsm3307715ad.58.2026.10.26.22.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 22:25:53 -0700 (PDT)
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
Subject: [PATCH v5 01/23] virt: coco: change tsm_register() to use a const struct
Date: Tue, 27 Oct 2026 15:25:14 +1000
Message-ID: <20261027052536.1722081-2-alistair.francis@wdc.com>
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

