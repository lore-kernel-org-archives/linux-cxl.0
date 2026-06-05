Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F383D2FFC
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jun 2026 21:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780694370; cv=none; b=K3/n5a+uihmvVlkuHLxV7zAs5ANkDRmerVobTAvxmykfxb4YE1xg6d/ZSsZvn2m0kEcoV1dvu2mRfxFcziQdQbwDzTAdSE4kovBJTCIcTSzY06G36QIhvxoO02QXv15hJXZucUxvfxMCMonSXNRjuwyZoJ/o/DSVpXggs7xDSaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780694370; c=relaxed/simple;
	bh=1zTws9fmQmhgRciJvlP2AWzY+uWAfxRF9YfrcryFsNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MA9y4eqJL5ZhYseoYPwSQnCtLIKeyz0kxwxq69yij6BBlqI/IcFxLcMgoHSr8P++eWqL7NQbSwGGDv1ZfnxwwBpQ6fwyreAsCw5VbK5ID+nEwe9nbuhLAZkU8fbhAxBOS2x5UBWVyhQlDLkVO2gY7BFed6Vp1KM0nO0aaqNdvHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=gqFaGE0K; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="gqFaGE0K"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5177ad0cc67so19024401cf.0
        for <linux-cxl@vger.kernel.org>; Fri, 05 Jun 2026 14:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1780694368; x=1781299168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P2vGSHo9hdkHiErFpk6jdcKlA83TnjxiiQnZVrYQBSY=;
        b=gqFaGE0K9vKJMVXyKCgcKJk8t+bfz18rdbV9SZqyxylippjH89EXDmZoioIHwAOTf/
         jL9GS0UPHGtDknh1gzcNX76TNl5JIVQuyPoSBfHR/YGkc+yWZTVH6u39DKjAnekHdYo+
         IOpLWg4KwHwo1m/qWoArd81Su5scesilDhxxPwZTWyEK3Uk34Wvs97A/Ud2YIdUqgZwB
         UB3J19z0c8v3L659nIzUMgW9vZXSEUDO9+el+Cqvkth2vgmVvVTZBmcGB53b0bPlVD7E
         njUnQMfnCIADmD3TEpnfcx/K+mqrNf5LxU97cCTPNRN7jM5ckywzpo+vvWoL9amzStry
         MqYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780694368; x=1781299168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P2vGSHo9hdkHiErFpk6jdcKlA83TnjxiiQnZVrYQBSY=;
        b=iQYLPbySJiwSV1QP63f2sSaczp/MfRIRuqiOteB6Bp91xNr73Px3NVfdByfTzBv4zU
         XqHI8KqqIIxDMPp3z66zkoG3lHFhRyYx4c+J7yGiYQKdC6LMrW9AtT/0xhT+x6H4NDMi
         cMQFLuIKuobF8eO2qK3zLhn+EXTSImpEyevjx2y0a6NpH3TForKxxjauAma0ubHNAt+X
         WLQV1Nz+U5TIulLcT3mkzGv5ZU+916rxN7X6fOJBSxerWNJwnPxE6DFvVFm5wU1Z7Xbm
         f+PDyJq4jkZVAThY0MFZKyrdzP8bJ/7FTa5Vz2yAv019yzvWxx/jyACTIL81vqZRxJg/
         VErA==
X-Forwarded-Encrypted: i=1; AFNElJ+J09Lv66ksprVKrjeQxhk0zX2G7J+GL1brZOp+UB2+4RDm2kIalPNjtbPB51w61I8cApetG3P4cn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YykbSICKFBG5aUCFQuexHBCmshmDpOCFKuHvOKwWJRId/clJSIs
	7huMwo6+p7pr4xmPwUAFnq2/RcyY/yzMZONDjEQLyh5jhkg9FWKpmN5XWmJ1HNbdyMQ=
X-Gm-Gg: Acq92OFjK6128L9IKh3UGNYBvmxWzLwGtafnIWNLIksbkTiOqvN9+OPrh38cF6UTv3O
	FpghWrD9Hx0YpFe7Bpn9h3DR9kd/jfAX+HJlRgbPrMVOLATLbwy/+RLY/NoDOMZcKg6aMRMsCco
	6fTghhX1f7Gnunt065Q9gAiBErF0RjsWueJFJRNzwbUp/vJ537Z2Rr1Bh3glsFGzMN1GDJHM63q
	rAkOe/UdXzatYDNgU1b5TF24HspjZgAkyds7g/324JoVFChFyUiL/+zA2hpxKz4N0W07wyAzgWg
	F5dYNzNCPqhzzFsJCbmF422mABE/81xeKOlk3nI2Oo5vitnak6r6wnyL4q/f/ideFdqeUu3B6C5
	qqmtuxgI9/0j5KDAQsjA41XrnxsZhJfVGkBzGzEVELwHyc55o2qZVj2PDR3iZhHa+qxO/n11WIm
	CdGANaOYUvpZ0SAUhK0QT/cpo3z5KbCMF7ZtPT2REVwKHZ5i3Qh3WVW9Z9P4nyi+Jf+r6Pz7EA1
	duEtcPMxSUlTO8WfWdSrPNz0boqbUVVSA==
X-Received: by 2002:a05:622a:514:b0:50f:6415:1eb4 with SMTP id d75a77b69052e-51795bbf29bmr79531471cf.49.1780694367941;
        Fri, 05 Jun 2026 14:19:27 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd277bbcsm90518196d6.49.2026.06.05.14.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 14:19:27 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org,
	nvdimm@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	linux-cxl@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	djbw@kernel.org,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	osalvador@suse.de,
	shuah@kernel.org,
	gourry@gourry.net,
	alison.schofield@intel.com,
	Smita.KoralahalliChannabasappa@amd.com,
	ira.weiny@intel.com,
	apopple@nvidia.com
Subject: [PATCH v4 6/9] dax: plumb hotplug online_type through dax
Date: Fri,  5 Jun 2026 22:19:08 +0100
Message-ID: <20260605211911.2160954-7-gourry@gourry.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605211911.2160954-1-gourry@gourry.net>
References: <20260605211911.2160954-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no way for drivers leveraging dax_kmem to plumb through a
preferred auto-online policy - the system default policy is forced.

Add 'enum mmop' field to DAX device creation path to allow drivers
to specify an auto-online policy when using the kmem driver.

Current callers initialize online_type to mhp_get_default_online_type()
to retain backward compatibility and to make explicit to the drivers
what is actually happening underneath.

No functional changes to existing callers.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/dax/bus.c         | 3 +++
 drivers/dax/bus.h         | 2 ++
 drivers/dax/cxl.c         | 1 +
 drivers/dax/dax-private.h | 3 +++
 drivers/dax/hmem/hmem.c   | 1 +
 drivers/dax/kmem.c        | 5 +++--
 drivers/dax/pmem.c        | 1 +
 7 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 492573b47f66..6611fe399f59 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2017-2018 Intel Corporation. All rights reserved. */
 #include <linux/memremap.h>
+#include <linux/memory_hotplug.h>
 #include <linux/device.h>
 #include <linux/mutex.h>
 #include <linux/list.h>
@@ -394,6 +395,7 @@ static ssize_t create_store(struct device *dev, struct device_attribute *attr,
 			.size = 0,
 			.id = -1,
 			.memmap_on_memory = false,
+			.online_type = mhp_get_default_online_type(),
 		};
 		struct dev_dax *dev_dax = __devm_create_dev_dax(&data);
 
@@ -1527,6 +1529,7 @@ static struct dev_dax *__devm_create_dev_dax(struct dev_dax_data *data)
 	ida_init(&dev_dax->ida);
 
 	dev_dax->memmap_on_memory = data->memmap_on_memory;
+	dev_dax->online_type = data->online_type;
 
 	inode = dax_inode(dax_dev);
 	dev->devt = inode->i_rdev;
diff --git a/drivers/dax/bus.h b/drivers/dax/bus.h
index 5909171a4428..c53a9427f8e4 100644
--- a/drivers/dax/bus.h
+++ b/drivers/dax/bus.h
@@ -3,6 +3,7 @@
 #ifndef __DAX_BUS_H__
 #define __DAX_BUS_H__
 #include <linux/device.h>
+#include <linux/memory_hotplug.h>
 #include <linux/platform_device.h>
 #include <linux/range.h>
 #include <linux/workqueue.h>
@@ -26,6 +27,7 @@ struct dev_dax_data {
 	resource_size_t size;
 	int id;
 	bool memmap_on_memory;
+	enum mmop online_type;
 };
 
 struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data);
diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
index 3ab39b77843d..0eaef700bb2a 100644
--- a/drivers/dax/cxl.c
+++ b/drivers/dax/cxl.c
@@ -27,6 +27,7 @@ static int cxl_dax_region_probe(struct device *dev)
 		.id = -1,
 		.size = range_len(&cxlr_dax->hpa_range),
 		.memmap_on_memory = true,
+		.online_type = mhp_get_default_online_type(),
 	};
 
 	return PTR_ERR_OR_ZERO(devm_create_dev_dax(&data));
diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
index 81e4af49e39c..0787325bc8dd 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -8,6 +8,7 @@
 #include <linux/device.h>
 #include <linux/cdev.h>
 #include <linux/idr.h>
+#include <linux/memory_hotplug.h>
 
 /* private routines between core files */
 struct dax_device;
@@ -79,6 +80,7 @@ struct dev_dax_range {
  * @dev: device core
  * @pgmap: pgmap for memmap setup / lifetime (driver owned)
  * @memmap_on_memory: allow kmem to put the memmap in the memory
+ * @online_type: MMOP_* online type for memory hotplug
  * @nr_range: size of @ranges
  * @ranges: range tuples of memory used
  */
@@ -95,6 +97,7 @@ struct dev_dax {
 	struct device dev;
 	struct dev_pagemap *pgmap;
 	bool memmap_on_memory;
+	enum mmop online_type;
 	int nr_range;
 	struct dev_dax_range *ranges;
 };
diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index af21f66bf872..0ef6e9ae660d 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -37,6 +37,7 @@ static int dax_hmem_probe(struct platform_device *pdev)
 		.id = -1,
 		.size = region_idle ? 0 : range_len(&mri->range),
 		.memmap_on_memory = false,
+		.online_type = mhp_get_default_online_type(),
 	};
 
 	return PTR_ERR_OR_ZERO(devm_create_dev_dax(&data));
diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index 592171ec10f4..41ccb618a146 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -172,8 +172,9 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 		 * Ensure that future kexec'd kernels will not treat
 		 * this as RAM automatically.
 		 */
-		rc = add_memory_driver_managed(data->mgid, range.start,
-				range_len(&range), kmem_name, mhp_flags);
+		rc = __add_memory_driver_managed(data->mgid, range.start,
+				range_len(&range), kmem_name, mhp_flags,
+				dev_dax->online_type);
 
 		if (rc) {
 			dev_warn(dev, "mapping%d: %#llx-%#llx memory add failed\n",
diff --git a/drivers/dax/pmem.c b/drivers/dax/pmem.c
index bee93066a849..a5f987814da5 100644
--- a/drivers/dax/pmem.c
+++ b/drivers/dax/pmem.c
@@ -63,6 +63,7 @@ static struct dev_dax *__dax_pmem_probe(struct device *dev)
 		.pgmap = &pgmap,
 		.size = range_len(&range),
 		.memmap_on_memory = false,
+		.online_type = mhp_get_default_online_type(),
 	};
 
 	return devm_create_dev_dax(&data);
-- 
2.54.0

