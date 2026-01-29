Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F0C35CBA5
	for <linux-cxl@vger.kernel.org>; Thu, 29 Jan 2026 21:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769720700; cv=none; b=PMPkFrdkEblSa32mpmNJy/qbgYsHu/ekj5hk0IOuFEqGmPk4dt/41zXzYqLDC48HG/6QLsfGbATmOFrGSEdKJtt+88EoIiZUUX/L6vxFx1io8BphqY/uS2LgUUWS/l6MR5zuwYN4qNXw2WIG2C1eGsjI4pnRZRDOHDzT7Vo3b1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769720700; c=relaxed/simple;
	bh=QNsY4J+Tc0rw1kzVfyOgqVGbBo/47Sd9HfuK48nkDOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q9nSacQjWquLxl/wxvryLwizr73ZAUAGLtemxp1A/3pJgXF2DPUuHmDiZ4BFEK7D9jq73iJ7WzfiO8gHXu00H+N4kqSbw5ZVf/WWtvjLRJrh7fGFXPnk2CKnCx0Hn3K46B/1lQ+8MH583HhigQvsphO336c9SCXRsEYHmyZk7vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=XGOgVsGE; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="XGOgVsGE"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8c5349ba802so140092885a.1
        for <linux-cxl@vger.kernel.org>; Thu, 29 Jan 2026 13:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1769720697; x=1770325497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=alwv4SGOFS63mWmVzbrgd9Xf0He8PRBJ686/YkdtOI4=;
        b=XGOgVsGE7lEH2jvTzMPTXM6VTcQCg0Fg1rN6+diAOZtBaxaAOARbZhqQQ6OqVTORFM
         u6tk6WVBLAPnaGrIC9yLob0RiedBLUU/acXRCKjpZbNlp9IiDInS0k6WJ5jwq3bfM5H8
         TBXMHljBw+bbfmoSAsHHMnV4gZLdAIsnNuIjYJuOI0MtCeY4IOn2S+4GwB0GP0C4HJfq
         8ee0hrWR2NifSyj7NiNZzWgko8u+1EyXK/J108U/LfXkMEqMm4cRroaB6ga2BvaXLQcT
         scFuuwo/PKMwy/snL/fvWEC7rqm992HmD28II3GxdtfS8V3LwfitDnXnR9W9GoVeKV2k
         XkTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769720697; x=1770325497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=alwv4SGOFS63mWmVzbrgd9Xf0He8PRBJ686/YkdtOI4=;
        b=eaetYniSKSX73ZJHhX9asE+R1S9y/BWIXK7mTbo413GfkgT6jK2PYvuIcFVkwTyCcK
         hdne8ZMXsS22k06PSoLuLUwDZSa5rfulZyKNobLWhSyHBucxWP7u2fliLT2kYtOL5+fi
         ozdUdOzXmzugXWaigzE8VvFqmMCL6e/bXyBL8shDdZ+5RMczdmxZL4Xk3wx3aAHDv5AN
         KVVqXvn5T3X74900SH5q2nxWHRj7z1AlENV1zw396bR5DRnJI4Yfnpego3p5Dra1oyah
         siCyLtM6L6K9xcamMqYsLVj94XdfQVfhxGwZsdUZXfWnBFem5ehNRP10pb5ktGdS2CW8
         lhiA==
X-Gm-Message-State: AOJu0YxJlOV+NuBtz4TkL8iL/Nt59eKaRy0cL0CxaVAjAQjoQRBcmZJ+
	BG+vIvdlnk3uV24nEJKlrFYO+V90SHiJP3mfaVOcPeD5BIwVpWZpbSmM6T+nIwLTfiw=
X-Gm-Gg: AZuq6aL/oFcC9KZ4Z9LH1OZCK+x6a4OPTEGCr9oUkPu94tr/j/AXjQBtL6x71udyO4g
	EELs+KZgwWgXm4Oji8RIUnsuXHo9DnZCDal7grv5v0yU7F6S/tnzZchSYO3oMwj23B1SfSmOhaW
	mvBKqHroDSVBKTXOoU2SpnOfkOPEHArVC4lB/eWQ4dntqoTyDEpfx/iTW41yuhDcxsZ+SKTQCAe
	P1I6l5IkJqWYrbcX4qagWWOx8Q3Rsq9s8U2dBdaoE910t3745Ug25x7Qjz16lXLAdof+2USBEeJ
	MQpd0AIBUetyaFtQtwYdm6YVhGH6AZs38sovb8RqvdJsfbXwWw2QzH3JS/d79apPRFhBm2ayp+H
	zTpd7XIfuWZmDboq4SOlc/D6z9QYPReoRSOaB9GpXUExHNoPl6sKYHjOdennF3j10f6rU03hmOO
	drc/sXLrPoHeQM3+crkOSlDOXL/iCNpzo714J7V4bL18ZOQPTVaSyILIwT2gDBP/ugtHzWjVGw8
	rE=
X-Received: by 2002:a05:620a:254e:b0:8c2:faed:ded3 with SMTP id af79cd13be357-8c9eb349005mr136193485a.89.1769720697462;
        Thu, 29 Jan 2026 13:04:57 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c71b859eaesm282041685a.46.2026.01.29.13.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 13:04:57 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kernel-team@meta.com,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	willy@infradead.org,
	jack@suse.cz,
	terry.bowman@amd.com,
	john@jagalactic.com
Subject: [PATCH 4/9] drivers/cxl,dax: add dax driver mode selection for dax regions
Date: Thu, 29 Jan 2026 16:04:37 -0500
Message-ID: <20260129210442.3951412-5-gourry@gourry.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129210442.3951412-1-gourry@gourry.net>
References: <20260129210442.3951412-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CXL regions may wish not to auto-configure their memory as dax kmem,
but the current plumbing defaults all cxl-created dax devices to the
kmem driver.  This exposes them to hotplug policy, even if the user
intends to use the memory as a dax device.

Add plumbing to allow CXL drivers to select whether a DAX region should
default to kmem (DAXDRV_KMEM_TYPE) or device (DAXDRV_DEVICE_TYPE).

Add a 'dax_driver' field to struct cxl_dax_region and update
devm_cxl_add_dax_region() to take a dax_driver_type parameter.

In drivers/dax/cxl.c, the IORESOURCE_DAX_KMEM flag used by dax driver
matching code is now set conditionally based on dax_region->dax_driver.

Exports `enum dax_driver_type` to linux/dax.h for use in the cxl driver.

All current callers pass DAXDRV_KMEM_TYPE for backward compatibility.

Cc: John Groves <john@jagalactic.com>
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/core.h   | 1 +
 drivers/cxl/core/region.c | 6 ++++--
 drivers/cxl/cxl.h         | 2 ++
 drivers/dax/bus.h         | 6 +-----
 drivers/dax/cxl.c         | 6 +++++-
 include/linux/dax.h       | 5 +++++
 6 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 1fb66132b777..dd987ef2def5 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -6,6 +6,7 @@
 
 #include <cxl/mailbox.h>
 #include <linux/rwsem.h>
+#include <linux/dax.h>
 
 extern const struct device_type cxl_nvdimm_bridge_type;
 extern const struct device_type cxl_nvdimm_type;
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index eef5d5fe3f95..e4097c464ed3 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3450,7 +3450,8 @@ static void cxlr_dax_unregister(void *_cxlr_dax)
 	device_unregister(&cxlr_dax->dev);
 }
 
-static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
+static int devm_cxl_add_dax_region(struct cxl_region *cxlr,
+				   enum dax_driver_type dax_driver)
 {
 	struct cxl_dax_region *cxlr_dax;
 	struct device *dev;
@@ -3461,6 +3462,7 @@ static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
 		return PTR_ERR(cxlr_dax);
 
 	cxlr_dax->online_type = mhp_get_default_online_type();
+	cxlr_dax->dax_driver = dax_driver;
 	dev = &cxlr_dax->dev;
 	rc = dev_set_name(dev, "dax_region%d", cxlr->id);
 	if (rc)
@@ -3994,7 +3996,7 @@ static int cxl_region_probe(struct device *dev)
 					p->res->start, p->res->end, cxlr,
 					is_system_ram) > 0)
 			return 0;
-		return devm_cxl_add_dax_region(cxlr);
+		return devm_cxl_add_dax_region(cxlr, DAXDRV_KMEM_TYPE);
 	default:
 		dev_dbg(&cxlr->dev, "unsupported region mode: %d\n",
 			cxlr->mode);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 07d57d13f4c7..c06a239c0008 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -12,6 +12,7 @@
 #include <linux/node.h>
 #include <linux/io.h>
 #include <linux/range.h>
+#include <linux/dax.h>
 
 extern const struct nvdimm_security_ops *cxl_security_ops;
 
@@ -592,6 +593,7 @@ struct cxl_dax_region {
 	struct cxl_region *cxlr;
 	struct range hpa_range;
 	int online_type; /* MMOP_ value for kmem driver */
+	enum dax_driver_type dax_driver;
 };
 
 /**
diff --git a/drivers/dax/bus.h b/drivers/dax/bus.h
index 4ac92a4edfe7..9144593b4029 100644
--- a/drivers/dax/bus.h
+++ b/drivers/dax/bus.h
@@ -2,6 +2,7 @@
 /* Copyright(c) 2016 - 2018 Intel Corporation. All rights reserved. */
 #ifndef __DAX_BUS_H__
 #define __DAX_BUS_H__
+#include <linux/dax.h>
 #include <linux/device.h>
 #include <linux/range.h>
 
@@ -29,11 +30,6 @@ struct dev_dax_data {
 
 struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data);
 
-enum dax_driver_type {
-	DAXDRV_KMEM_TYPE,
-	DAXDRV_DEVICE_TYPE,
-};
-
 struct dax_device_driver {
 	struct device_driver drv;
 	struct list_head ids;
diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
index 856a0cd24f3b..b13ecc2f9806 100644
--- a/drivers/dax/cxl.c
+++ b/drivers/dax/cxl.c
@@ -11,14 +11,18 @@ static int cxl_dax_region_probe(struct device *dev)
 	struct cxl_dax_region *cxlr_dax = to_cxl_dax_region(dev);
 	int nid = phys_to_target_node(cxlr_dax->hpa_range.start);
 	struct cxl_region *cxlr = cxlr_dax->cxlr;
+	unsigned long flags = 0;
 	struct dax_region *dax_region;
 	struct dev_dax_data data;
 
+	if (cxlr_dax->dax_driver == DAXDRV_KMEM_TYPE)
+		flags |= IORESOURCE_DAX_KMEM;
+
 	if (nid == NUMA_NO_NODE)
 		nid = memory_add_physaddr_to_nid(cxlr_dax->hpa_range.start);
 
 	dax_region = alloc_dax_region(dev, cxlr->id, &cxlr_dax->hpa_range, nid,
-				      PMD_SIZE, IORESOURCE_DAX_KMEM);
+				      PMD_SIZE, flags);
 	if (!dax_region)
 		return -ENOMEM;
 
diff --git a/include/linux/dax.h b/include/linux/dax.h
index bf103f317cac..e62f92d0ace1 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -19,6 +19,11 @@ enum dax_access_mode {
 	DAX_RECOVERY_WRITE,
 };
 
+enum dax_driver_type {
+	DAXDRV_KMEM_TYPE,
+	DAXDRV_DEVICE_TYPE,
+};
+
 struct dax_operations {
 	/*
 	 * direct_access: translate a device-relative
-- 
2.52.0

