Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B026435C1B4
	for <linux-cxl@vger.kernel.org>; Thu, 29 Jan 2026 21:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769720706; cv=none; b=Z86X+QbJY6crhvgl1mEht6sW5YYADvUx9LAhouKRqLz3mVA+A9A08uEOFOzFhclXhvChbz0Z7gRXfG/Ty74Kbm0zyJbXIWk4FaWvd2dg+qJ6yxRymGYJ19YHELj1PywSBHVzYTN16x654fzkU/61v/HqXbaLpHy8sIKNEWQQ5ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769720706; c=relaxed/simple;
	bh=c99ew5/U2ROZr/ddOc62AYyxyE5STejoR0DEktJNssc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P/dUL4t6p4kHQlHnIBL77xAXQt6eFilKPoRUAHbJovmSUPDqVEZZE1xN0Zx6dPHKBjD4B7INHwnbEdw371NjDZ0qQjAzaUv1Fkzll7BrGcGGWcB9suauJyjYwUR6XqTqZJxYVoVAfpqQ1LP6M5kzvWcTeOoUIfMgwT1vOzW2W6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=pr29mWfp; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="pr29mWfp"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-502a2370e4fso12076871cf.3
        for <linux-cxl@vger.kernel.org>; Thu, 29 Jan 2026 13:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1769720700; x=1770325500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M5ShTIweYFg1/ZuxvW60BAtA8gMRBxv7vwbNQNJLoKA=;
        b=pr29mWfp7Ek0laGua5f7qJCbLen5McW5TbpGOzein5yA0gCxXCulCmmIwWpAItbBJh
         2qeJI7rzGxSqoI2usLRwN2oP6mU8sHq6LIR0bjcgyLKTBQfaBxpJ7DR9vJOY3b1YEw2X
         un7+07IaK7qifin+manL7+Cvov1a8BHReDUedxdkzqPSFxmbnNzUWr/cZgvlLnBpS9Tb
         CKUE0ODEXFldb44/VrAcATEAGFuvpijAqLFtpRSFq3ex8hl3RbiAxFrxhIzWoWpm05eM
         2nw1IYw74XH6oAkXnJBKDhco84XR013gyBODuc3XaLf3qaH3t0WiXjub9KERG/orgitC
         tXDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769720700; x=1770325500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M5ShTIweYFg1/ZuxvW60BAtA8gMRBxv7vwbNQNJLoKA=;
        b=d3m9NXC3TO6fJP0pLQef0lpyU2cOJkbSTrP+VV4t8im85/G7ZJD1JpbFIDXqQwufw2
         Yc2YkEwODL4XKNcc46C+BPWgVCVfy5fTuX1I3r2D9hrjzbI/MU46Z8QN5XDpqqqX5gAA
         4HSvq5RDvsOhzdwSby67OzUcgx0qbAJow5oocvCPb7yw/J504SETbIZDwiFeVwPUqe2x
         YEGz6bYWDk5QgW9VcgmNAZy9VYQKkEPQqSOZFjEdIoKEJRUrSjo+lUQMgf6q5ZplriZR
         58S69Xxi9gbJdWCuNw3xvGkA2eW3JTwJauBm3FgFQCuhYAxdDUimt90Wiuv15AHHHqiS
         z3kA==
X-Gm-Message-State: AOJu0YzfH0VpRDp85X/CigyjQKipbvl5NPWlW9GI5daNHXRJpdxD9JXz
	nAywks4h4skguqQ2Tx+i1HEWegdKCWzrxVfDAfAXvzs9dB2jm0HRtmpY0OW63zBdaK4=
X-Gm-Gg: AZuq6aI8VV4XPjFrzDSxUKPO8K6kuF7SiAV6oTf1PtcgS2SFDPEijsN9V0CLB6BXTmM
	mDOUyd0R+5m4hguD/0LjJr+vt5Oq+KbSSHbMJ5c5GuOaSl3fHNPCywH5pEXLtcRNhAgskoJ2cFL
	7k30KRTNaNblm+05GgCRrvVuy74oSUUwAihTP553ctokiJ+nHihpu3xf5NAE9Zv6hCvsruGAHYF
	29vRnSwSfWy5qswBKkNBaOG486eQv+6rwgCjDkmKBGYalDeDdcqzYapPys7Swg6fJLnEghm71aq
	02dP65Li9kmT3sLrn9VtuwA7yZgvBXh5HsTKKKY7HUxGOtKAUn+k6WXydq7smHIIsFQMeU3axBF
	H6j8/BqTIOuK4rkw/Wstln4MusFPn9+YZup57pSdDi2a0jMLQTKEhnVWA1YMZIVOtRCNsm4ghn3
	34k2HFcKLIW64Dh4GpHX+090VpPSTWqC9RbYqkNziE2EYZagDryhiO5M8Bfjg9TbE8HCLbAw1S0
	Z8=
X-Received: by 2002:ac8:7d4b:0:b0:501:47f8:982d with SMTP id d75a77b69052e-505d223dfcbmr11826491cf.52.1769720699550;
        Thu, 29 Jan 2026 13:04:59 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c71b859eaesm282041685a.46.2026.01.29.13.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 13:04:59 -0800 (PST)
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
Subject: [PATCH 5/9] cxl/core/region: move pmem region driver logic into pmem_region
Date: Thu, 29 Jan 2026 16:04:38 -0500
Message-ID: <20260129210442.3951412-6-gourry@gourry.net>
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

Move the pmem region driver logic from region.c into pmem_region.c.

No functional changes.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/Makefile      |   1 +
 drivers/cxl/core/core.h        |   1 +
 drivers/cxl/core/pmem_region.c | 191 +++++++++++++++++++++++++++++++++
 drivers/cxl/core/region.c      | 184 -------------------------------
 4 files changed, 193 insertions(+), 184 deletions(-)
 create mode 100644 drivers/cxl/core/pmem_region.c

diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index 5ad8fef210b5..23269c81fd44 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -17,6 +17,7 @@ cxl_core-y += cdat.o
 cxl_core-y += ras.o
 cxl_core-$(CONFIG_TRACING) += trace.o
 cxl_core-$(CONFIG_CXL_REGION) += region.o
+cxl_core-$(CONFIG_CXL_REGION) += pmem_region.o
 cxl_core-$(CONFIG_CXL_MCE) += mce.o
 cxl_core-$(CONFIG_CXL_FEATURES) += features.o
 cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += edac.o
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index dd987ef2def5..26991de12d76 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -43,6 +43,7 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port);
 struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa);
 u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 		   u64 dpa);
+int devm_cxl_add_pmem_region(struct cxl_region *cxlr);
 
 #else
 static inline u64 cxl_dpa_to_hpa(struct cxl_region *cxlr,
diff --git a/drivers/cxl/core/pmem_region.c b/drivers/cxl/core/pmem_region.c
new file mode 100644
index 000000000000..81b66e548bb5
--- /dev/null
+++ b/drivers/cxl/core/pmem_region.c
@@ -0,0 +1,191 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2022 Intel Corporation. All rights reserved. */
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <cxlmem.h>
+#include <cxl.h>
+#include "core.h"
+
+static void cxl_pmem_region_release(struct device *dev)
+{
+	struct cxl_pmem_region *cxlr_pmem = to_cxl_pmem_region(dev);
+	int i;
+
+	for (i = 0; i < cxlr_pmem->nr_mappings; i++) {
+		struct cxl_memdev *cxlmd = cxlr_pmem->mapping[i].cxlmd;
+
+		put_device(&cxlmd->dev);
+	}
+
+	kfree(cxlr_pmem);
+}
+
+static const struct attribute_group *cxl_pmem_region_attribute_groups[] = {
+	&cxl_base_attribute_group,
+	NULL,
+};
+
+const struct device_type cxl_pmem_region_type = {
+	.name = "cxl_pmem_region",
+	.release = cxl_pmem_region_release,
+	.groups = cxl_pmem_region_attribute_groups,
+};
+bool is_cxl_pmem_region(struct device *dev)
+{
+	return dev->type == &cxl_pmem_region_type;
+}
+EXPORT_SYMBOL_NS_GPL(is_cxl_pmem_region, "CXL");
+
+struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev)
+{
+	if (dev_WARN_ONCE(dev, !is_cxl_pmem_region(dev),
+				"not a cxl_pmem_region device\n"))
+		return NULL;
+	return container_of(dev, struct cxl_pmem_region, dev);
+}
+EXPORT_SYMBOL_NS_GPL(to_cxl_pmem_region, "CXL");
+static struct lock_class_key cxl_pmem_region_key;
+
+static int cxl_pmem_region_alloc(struct cxl_region *cxlr)
+{
+	struct cxl_region_params *p = &cxlr->params;
+	struct cxl_nvdimm_bridge *cxl_nvb;
+	struct device *dev;
+	int i;
+
+	guard(rwsem_read)(&cxl_rwsem.region);
+	if (p->state != CXL_CONFIG_COMMIT)
+		return -ENXIO;
+
+	struct cxl_pmem_region *cxlr_pmem __free(kfree) =
+		kzalloc(struct_size(cxlr_pmem, mapping, p->nr_targets), GFP_KERNEL);
+	if (!cxlr_pmem)
+		return -ENOMEM;
+
+	cxlr_pmem->hpa_range.start = p->res->start;
+	cxlr_pmem->hpa_range.end = p->res->end;
+
+	/* Snapshot the region configuration underneath the cxl_rwsem.region */
+	cxlr_pmem->nr_mappings = p->nr_targets;
+	for (i = 0; i < p->nr_targets; i++) {
+		struct cxl_endpoint_decoder *cxled = p->targets[i];
+		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+		struct cxl_pmem_region_mapping *m = &cxlr_pmem->mapping[i];
+
+		/*
+		 * Regions never span CXL root devices, so by definition the
+		 * bridge for one device is the same for all.
+		 */
+		if (i == 0) {
+			cxl_nvb = cxl_find_nvdimm_bridge(cxlmd->endpoint);
+			if (!cxl_nvb)
+				return -ENODEV;
+			cxlr->cxl_nvb = cxl_nvb;
+		}
+		m->cxlmd = cxlmd;
+		get_device(&cxlmd->dev);
+		m->start = cxled->dpa_res->start;
+		m->size = resource_size(cxled->dpa_res);
+		m->position = i;
+	}
+
+	dev = &cxlr_pmem->dev;
+	device_initialize(dev);
+	lockdep_set_class(&dev->mutex, &cxl_pmem_region_key);
+	device_set_pm_not_required(dev);
+	dev->parent = &cxlr->dev;
+	dev->bus = &cxl_bus_type;
+	dev->type = &cxl_pmem_region_type;
+	cxlr_pmem->cxlr = cxlr;
+	cxlr->cxlr_pmem = no_free_ptr(cxlr_pmem);
+
+	return 0;
+}
+
+static void cxlr_pmem_unregister(void *_cxlr_pmem)
+{
+	struct cxl_pmem_region *cxlr_pmem = _cxlr_pmem;
+	struct cxl_region *cxlr = cxlr_pmem->cxlr;
+	struct cxl_nvdimm_bridge *cxl_nvb = cxlr->cxl_nvb;
+
+	/*
+	 * Either the bridge is in ->remove() context under the device_lock(),
+	 * or cxlr_release_nvdimm() is cancelling the bridge's release action
+	 * for @cxlr_pmem and doing it itself (while manually holding the bridge
+	 * lock).
+	 */
+	device_lock_assert(&cxl_nvb->dev);
+	cxlr->cxlr_pmem = NULL;
+	cxlr_pmem->cxlr = NULL;
+	device_unregister(&cxlr_pmem->dev);
+}
+
+static void cxlr_release_nvdimm(void *_cxlr)
+{
+	struct cxl_region *cxlr = _cxlr;
+	struct cxl_nvdimm_bridge *cxl_nvb = cxlr->cxl_nvb;
+
+	scoped_guard(device, &cxl_nvb->dev) {
+		if (cxlr->cxlr_pmem)
+			devm_release_action(&cxl_nvb->dev, cxlr_pmem_unregister,
+					cxlr->cxlr_pmem);
+	}
+	cxlr->cxl_nvb = NULL;
+	put_device(&cxl_nvb->dev);
+}
+
+/**
+ * devm_cxl_add_pmem_region() - add a cxl_region-to-nd_region bridge
+ * @cxlr: parent CXL region for this pmem region bridge device
+ *
+ * Return: 0 on success negative error code on failure.
+ */
+int devm_cxl_add_pmem_region(struct cxl_region *cxlr)
+{
+	struct cxl_pmem_region *cxlr_pmem;
+	struct cxl_nvdimm_bridge *cxl_nvb;
+	struct device *dev;
+	int rc;
+
+	rc = cxl_pmem_region_alloc(cxlr);
+	if (rc)
+		return rc;
+	cxlr_pmem = cxlr->cxlr_pmem;
+	cxl_nvb = cxlr->cxl_nvb;
+
+	dev = &cxlr_pmem->dev;
+	rc = dev_set_name(dev, "pmem_region%d", cxlr->id);
+	if (rc)
+		goto err;
+
+	rc = device_add(dev);
+	if (rc)
+		goto err;
+
+	dev_dbg(&cxlr->dev, "%s: register %s\n", dev_name(dev->parent),
+			dev_name(dev));
+
+	scoped_guard(device, &cxl_nvb->dev) {
+		if (cxl_nvb->dev.driver)
+			rc = devm_add_action_or_reset(&cxl_nvb->dev,
+					cxlr_pmem_unregister,
+					cxlr_pmem);
+		else
+			rc = -ENXIO;
+	}
+
+	if (rc)
+		goto err_bridge;
+
+	/* @cxlr carries a reference on @cxl_nvb until cxlr_release_nvdimm */
+	return devm_add_action_or_reset(&cxlr->dev, cxlr_release_nvdimm, cxlr);
+
+err:
+	put_device(dev);
+err_bridge:
+	put_device(&cxl_nvb->dev);
+	cxlr->cxl_nvb = NULL;
+	return rc;
+}
+
+
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e4097c464ed3..fc56f8f03805 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2747,46 +2747,6 @@ static ssize_t delete_region_store(struct device *dev,
 }
 DEVICE_ATTR_WO(delete_region);
 
-static void cxl_pmem_region_release(struct device *dev)
-{
-	struct cxl_pmem_region *cxlr_pmem = to_cxl_pmem_region(dev);
-	int i;
-
-	for (i = 0; i < cxlr_pmem->nr_mappings; i++) {
-		struct cxl_memdev *cxlmd = cxlr_pmem->mapping[i].cxlmd;
-
-		put_device(&cxlmd->dev);
-	}
-
-	kfree(cxlr_pmem);
-}
-
-static const struct attribute_group *cxl_pmem_region_attribute_groups[] = {
-	&cxl_base_attribute_group,
-	NULL,
-};
-
-const struct device_type cxl_pmem_region_type = {
-	.name = "cxl_pmem_region",
-	.release = cxl_pmem_region_release,
-	.groups = cxl_pmem_region_attribute_groups,
-};
-
-bool is_cxl_pmem_region(struct device *dev)
-{
-	return dev->type == &cxl_pmem_region_type;
-}
-EXPORT_SYMBOL_NS_GPL(is_cxl_pmem_region, "CXL");
-
-struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev)
-{
-	if (dev_WARN_ONCE(dev, !is_cxl_pmem_region(dev),
-			  "not a cxl_pmem_region device\n"))
-		return NULL;
-	return container_of(dev, struct cxl_pmem_region, dev);
-}
-EXPORT_SYMBOL_NS_GPL(to_cxl_pmem_region, "CXL");
-
 struct cxl_poison_context {
 	struct cxl_port *port;
 	int part;
@@ -3236,64 +3196,6 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
 	return -ENXIO;
 }
 
-static struct lock_class_key cxl_pmem_region_key;
-
-static int cxl_pmem_region_alloc(struct cxl_region *cxlr)
-{
-	struct cxl_region_params *p = &cxlr->params;
-	struct cxl_nvdimm_bridge *cxl_nvb;
-	struct device *dev;
-	int i;
-
-	guard(rwsem_read)(&cxl_rwsem.region);
-	if (p->state != CXL_CONFIG_COMMIT)
-		return -ENXIO;
-
-	struct cxl_pmem_region *cxlr_pmem __free(kfree) =
-		kzalloc(struct_size(cxlr_pmem, mapping, p->nr_targets), GFP_KERNEL);
-	if (!cxlr_pmem)
-		return -ENOMEM;
-
-	cxlr_pmem->hpa_range.start = p->res->start;
-	cxlr_pmem->hpa_range.end = p->res->end;
-
-	/* Snapshot the region configuration underneath the cxl_rwsem.region */
-	cxlr_pmem->nr_mappings = p->nr_targets;
-	for (i = 0; i < p->nr_targets; i++) {
-		struct cxl_endpoint_decoder *cxled = p->targets[i];
-		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-		struct cxl_pmem_region_mapping *m = &cxlr_pmem->mapping[i];
-
-		/*
-		 * Regions never span CXL root devices, so by definition the
-		 * bridge for one device is the same for all.
-		 */
-		if (i == 0) {
-			cxl_nvb = cxl_find_nvdimm_bridge(cxlmd->endpoint);
-			if (!cxl_nvb)
-				return -ENODEV;
-			cxlr->cxl_nvb = cxl_nvb;
-		}
-		m->cxlmd = cxlmd;
-		get_device(&cxlmd->dev);
-		m->start = cxled->dpa_res->start;
-		m->size = resource_size(cxled->dpa_res);
-		m->position = i;
-	}
-
-	dev = &cxlr_pmem->dev;
-	device_initialize(dev);
-	lockdep_set_class(&dev->mutex, &cxl_pmem_region_key);
-	device_set_pm_not_required(dev);
-	dev->parent = &cxlr->dev;
-	dev->bus = &cxl_bus_type;
-	dev->type = &cxl_pmem_region_type;
-	cxlr_pmem->cxlr = cxlr;
-	cxlr->cxlr_pmem = no_free_ptr(cxlr_pmem);
-
-	return 0;
-}
-
 static void cxl_dax_region_release(struct device *dev)
 {
 	struct cxl_dax_region *cxlr_dax = to_cxl_dax_region(dev);
@@ -3357,92 +3259,6 @@ static struct cxl_dax_region *cxl_dax_region_alloc(struct cxl_region *cxlr)
 	return cxlr_dax;
 }
 
-static void cxlr_pmem_unregister(void *_cxlr_pmem)
-{
-	struct cxl_pmem_region *cxlr_pmem = _cxlr_pmem;
-	struct cxl_region *cxlr = cxlr_pmem->cxlr;
-	struct cxl_nvdimm_bridge *cxl_nvb = cxlr->cxl_nvb;
-
-	/*
-	 * Either the bridge is in ->remove() context under the device_lock(),
-	 * or cxlr_release_nvdimm() is cancelling the bridge's release action
-	 * for @cxlr_pmem and doing it itself (while manually holding the bridge
-	 * lock).
-	 */
-	device_lock_assert(&cxl_nvb->dev);
-	cxlr->cxlr_pmem = NULL;
-	cxlr_pmem->cxlr = NULL;
-	device_unregister(&cxlr_pmem->dev);
-}
-
-static void cxlr_release_nvdimm(void *_cxlr)
-{
-	struct cxl_region *cxlr = _cxlr;
-	struct cxl_nvdimm_bridge *cxl_nvb = cxlr->cxl_nvb;
-
-	scoped_guard(device, &cxl_nvb->dev) {
-		if (cxlr->cxlr_pmem)
-			devm_release_action(&cxl_nvb->dev, cxlr_pmem_unregister,
-					    cxlr->cxlr_pmem);
-	}
-	cxlr->cxl_nvb = NULL;
-	put_device(&cxl_nvb->dev);
-}
-
-/**
- * devm_cxl_add_pmem_region() - add a cxl_region-to-nd_region bridge
- * @cxlr: parent CXL region for this pmem region bridge device
- *
- * Return: 0 on success negative error code on failure.
- */
-static int devm_cxl_add_pmem_region(struct cxl_region *cxlr)
-{
-	struct cxl_pmem_region *cxlr_pmem;
-	struct cxl_nvdimm_bridge *cxl_nvb;
-	struct device *dev;
-	int rc;
-
-	rc = cxl_pmem_region_alloc(cxlr);
-	if (rc)
-		return rc;
-	cxlr_pmem = cxlr->cxlr_pmem;
-	cxl_nvb = cxlr->cxl_nvb;
-
-	dev = &cxlr_pmem->dev;
-	rc = dev_set_name(dev, "pmem_region%d", cxlr->id);
-	if (rc)
-		goto err;
-
-	rc = device_add(dev);
-	if (rc)
-		goto err;
-
-	dev_dbg(&cxlr->dev, "%s: register %s\n", dev_name(dev->parent),
-		dev_name(dev));
-
-	scoped_guard(device, &cxl_nvb->dev) {
-		if (cxl_nvb->dev.driver)
-			rc = devm_add_action_or_reset(&cxl_nvb->dev,
-						      cxlr_pmem_unregister,
-						      cxlr_pmem);
-		else
-			rc = -ENXIO;
-	}
-
-	if (rc)
-		goto err_bridge;
-
-	/* @cxlr carries a reference on @cxl_nvb until cxlr_release_nvdimm */
-	return devm_add_action_or_reset(&cxlr->dev, cxlr_release_nvdimm, cxlr);
-
-err:
-	put_device(dev);
-err_bridge:
-	put_device(&cxl_nvb->dev);
-	cxlr->cxl_nvb = NULL;
-	return rc;
-}
-
 static void cxlr_dax_unregister(void *_cxlr_dax)
 {
 	struct cxl_dax_region *cxlr_dax = _cxlr_dax;
-- 
2.52.0

