Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010C11A2547
	for <linux-cxl@vger.kernel.org>; Fri, 24 Oct 2025 01:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761268898; cv=none; b=FmXbKrHMgKJUyQWlfVe/C8QLfmqSuOYwipxhDarG6OwDmEezrWGsdntffkCj/YNtQSJ5tboTcqjTKuvJeO/J9hHQenVoxXDJwe6cSeDspF4DZUDrOmPtPUEOfcdlrpWbpBICCFb1w19sbn3NXk6/DvpLw25xQ5RbHf7vq/qAqX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761268898; c=relaxed/simple;
	bh=7uktLTVlrJm7nB0yUepAnFd9bHjFwk36Uk/OBvinjps=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KleDn5Uy/qPz6KvpJ/WOKJGOQ26g/+kZz4AkmKQ2hyc0fCeBprdanw1GrGwi1I9eWamrReeHyXvDh7r0C53F3x3KiJxF85RwIxXaN/GERThpsVGQrSqhehP5u7b1nRZZATWmk5c0G/S+2H4vOds0DTc0dbmrnyC8236HKirO3PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mclapinski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mjMGLQG6; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mclapinski.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mjMGLQG6"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-471168953bdso15743795e9.1
        for <linux-cxl@vger.kernel.org>; Thu, 23 Oct 2025 18:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761268895; x=1761873695; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LmD4KoyqZKUw57P8WwHSWBVJ5vxbTrg41hvD9Exq1hg=;
        b=mjMGLQG647lSHk8ylmnbY89JVQYOwqSRWg8yDy7cXIoMNj/qbZ1N97Gq7jOscEYOgJ
         Knt+eBffgjrBIdfuNrx+HOt8anPZbaT19SaW++lHzUlk84OVLiwnBfbDYrqvH5xHaoli
         eaIkuUE7Gbig7zoIDNrsPBO0Kw0NK+3TJy6jpWkWsuUgIeVm7/rqCYxnYk0xtbl0BGgw
         Qi8I/gHza4T+chG/o/N+XLdbJ1M/HihbiYVOBGyy0SOaFd7PiYW79eTesPJHjC4d05gr
         xEveFXLTveWLxj5uIe/zP0VBYigHHXeTOEPw/mmY9Lu4TF2bI2B3skkw8RzUydat8l2N
         F4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761268895; x=1761873695;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LmD4KoyqZKUw57P8WwHSWBVJ5vxbTrg41hvD9Exq1hg=;
        b=EvSyf0gQoPyZQAzyq7yA8DTbm1dxnpZw8jK+EhVsrS1c634Boyrg9n27ylo6044fhu
         isvz6qciUKWV7Evb4M/WMiPSpuf4dQsU0vuswgpGBuYCtGBXxLFWodIpYA+rIC/Kvv5x
         SFIiPe/qK4xNySGbgQcvuK4u6bAUo23wFwitA4suw8Elpn7bNsYokMiNnU2xOHg66YIx
         4t2hIoqc5Cp9W93irJMH/6/iIWmzLUsn1aokOUd1re8u2PtzL6yOnMN/CfVwDtRqwI8L
         GoGAP9CeSUugTPjb0f+jkBAdi26yZ/1zlmr93P/TrJLsxYMgb+AOnIM5hQZTJkvAG4AA
         Or+A==
X-Forwarded-Encrypted: i=1; AJvYcCWwOCNSNBkmKk7D/a9TPfTdifGl2xOM2uC9jIE/zrtsLk3eDHK/DEhuVAWwKAI24RndPYdqTkKvtSs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6ZP8nbF0r4N73GmToClfJRitbswOp8utF0XHT3dw1HslmSADg
	PGrNaxtIEfakFA3nw65DT00k0tqEr5ykjjM6vL0pKAd25MRSAg3UsrMEfpgw5RrDYsMIWChy73s
	BtL80gjuIZhqPY4hxzzz4rg==
X-Google-Smtp-Source: AGHT+IGu3wOBe55z+Y8FldXJmulA4Ot9s9N1XFNSpEp8SZhKSHZbJJRFrsWPO5D8uzOhVCBt4ECj3Xzzht0Oqp7n
X-Received: from wmcn19.prod.google.com ([2002:a05:600c:c0d3:b0:46f:aa50:d705])
 (user=mclapinski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3e8c:b0:46e:6339:79c5 with SMTP id 5b1f17b1804b1-475d241ce79mr5272425e9.5.1761268895505;
 Thu, 23 Oct 2025 18:21:35 -0700 (PDT)
Date: Fri, 24 Oct 2025 03:21:24 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Message-ID: <20251024012124.1775781-1-mclapinski@google.com>
Subject: [PATCH v2 1/1] dax: add PROBE_PREFER_ASYNCHRONOUS to all dax drivers
From: Michal Clapinski <mclapinski@google.com>
To: Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org, 
	Michal Clapinski <mclapinski@google.com>
Content-Type: text/plain; charset="UTF-8"

Comments in linux/device/driver.h say that the goal is to do async
probing on all devices. The current behavior unnecessarily slows down
the boot by synchronously probing dax devices, so let's change that.

For thousands of devices, this change saves >1s of boot time.

Signed-off-by: Michal Clapinski <mclapinski@google.com>
---
 drivers/dax/cxl.c       | 1 +
 drivers/dax/device.c    | 3 +++
 drivers/dax/hmem/hmem.c | 2 ++
 drivers/dax/kmem.c      | 3 +++
 drivers/dax/pmem.c      | 1 +
 5 files changed, 10 insertions(+)

diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
index 13cd94d32ff7..90734ddbd369 100644
--- a/drivers/dax/cxl.c
+++ b/drivers/dax/cxl.c
@@ -38,6 +38,7 @@ static struct cxl_driver cxl_dax_region_driver = {
 	.id = CXL_DEVICE_DAX_REGION,
 	.drv = {
 		.suppress_bind_attrs = true,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 
diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 2bb40a6060af..74f2381a7df6 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -470,6 +470,9 @@ static int dev_dax_probe(struct dev_dax *dev_dax)
 static struct dax_device_driver device_dax_driver = {
 	.probe = dev_dax_probe,
 	.type = DAXDRV_DEVICE_TYPE,
+	.drv = {
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
 };
 
 static int __init dax_init(void)
diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index c18451a37e4f..5a6d99d90f77 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -45,6 +45,7 @@ static struct platform_driver dax_hmem_driver = {
 	.probe = dax_hmem_probe,
 	.driver = {
 		.name = "hmem",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 
@@ -131,6 +132,7 @@ static struct platform_driver dax_hmem_platform_driver = {
 	.probe = dax_hmem_platform_probe,
 	.driver = {
 		.name = "hmem_platform",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 
diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index c036e4d0b610..4bfaab2cb728 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -274,6 +274,9 @@ static struct dax_device_driver device_dax_kmem_driver = {
 	.probe = dev_dax_kmem_probe,
 	.remove = dev_dax_kmem_remove,
 	.type = DAXDRV_KMEM_TYPE,
+	.drv = {
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
 };
 
 static int __init dax_kmem_init(void)
diff --git a/drivers/dax/pmem.c b/drivers/dax/pmem.c
index bee93066a849..737654e8c5e8 100644
--- a/drivers/dax/pmem.c
+++ b/drivers/dax/pmem.c
@@ -77,6 +77,7 @@ static struct nd_device_driver dax_pmem_driver = {
 	.probe = dax_pmem_probe,
 	.drv = {
 		.name = "dax_pmem",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.type = ND_DRIVER_DAX_PMEM,
 };
-- 
2.51.1.821.gb6fe4d2222-goog

