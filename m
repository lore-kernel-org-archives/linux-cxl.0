Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25465364046
	for <linux-cxl@vger.kernel.org>; Mon, 12 Jan 2026 16:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768235766; cv=none; b=tKYDRxWtBrE/OSsiGMVkYoC5S7KU0fQuhtwsgBuwXfj7qhvqwJDxQy0KnlJ6oVFqYg2nSbyTuSFGL+zDprdjpNBBR4njGr6OMcYaN1L5sNAUYRFM1M2qgv+UtDbLf4gsXpDbL5Fa/zk1/nsVia4gm7f3fKUcisu43IxumhWuMqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768235766; c=relaxed/simple;
	bh=+vbo+ow3/N5FLNf+VKIFLg2lCo3Oq70TF5BpjObwuvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BcYfE+yFPLwv3L8Q6XzPK8c9XEeBXUnf0yP8VhwnLSksGDhsEpNXEP0+EVWD30hzkm5IwJLG55vdXy1jxaZuA8bx7IGflOcGsKJ2Ye14pw/r5oWwSbfkQG4y5HdX1k3+sbqDE2++tL/nS4r5Gg+m67dO8bfGUQpPj7nbF195bm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=r/5qGLht; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="r/5qGLht"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8b2148ca40eso952831785a.1
        for <linux-cxl@vger.kernel.org>; Mon, 12 Jan 2026 08:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768235762; x=1768840562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aMVuY/Qzumrs9qaMsiMla3bJLkpnnRK5ZTojwjJEFPc=;
        b=r/5qGLhtTIfbS6LcQ8/HYhjPVZLxjvtjqnHnezScyqWfhgg6XfWSbPLl1RaU/jIwi4
         CLJoIdV7oOLThgRbq2bbFn7ZlTphh2nNMLQkPGYSopmp8Le5z9yDpdrtXrdK+HzN10ql
         8rlAsNZVWskFmX4ASL4wjH5M9E3h/xFRoEjvrfCs6nisgQXzCngLRWIzj5DU15qw97x9
         dFuqlGdhpqcE+CMKe9bPtLVtM/TFbuv8ku3qgcncen9afoLi0P8t8pxckjyW+A4+SN0G
         pWLUNCetvLFBPZtraiDEv0JN+OtsHw2c1J9QydxALylfXawf6qjPr7H0iYboj9nFMSCh
         CSlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768235762; x=1768840562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aMVuY/Qzumrs9qaMsiMla3bJLkpnnRK5ZTojwjJEFPc=;
        b=JgIWwpA+QXZmfy+acHmoHGjquit7tpTVCLOOWXd8G9oqa2wvZhqF/5yvnCFnmkzO5g
         3M/x0D/8di/wiN7Z5jvO4+zhc0szsxQ3jYuCXuNtKwemz/SXuDrMxbJQW9H6aKZ2syJ7
         xQTm7B1gHCZTAy9ttRtITS1s+Un6U3VAluT54hcAff6CyS8nbe7Q2uzDDEFQvi97bw/z
         VVYYba172xK6/9JmiUhNGXJzQ8YmZ8TzvbI9YEFt1VP/MRyESRsEGoMb2fm/Ckda09Ke
         lYoAOy4skFEEhnhfDx7baNXHG7sARfRLJTGJtJW+U9ytV3M1bNXV7Xfk1vnOpEaFa5uR
         lptQ==
X-Gm-Message-State: AOJu0YwWq8sK3uavkHy6iNXVD4N9jKNGOkWd2S/3ugzLJrzEjv6aF7rV
	8ZW0QsYF7b8G7A1X8ALiRMc+oXTwpn2CSyN62vE8xMddPiS25441HgiGjn+8FnP0O8ADrwYDM3F
	7XuP6
X-Gm-Gg: AY/fxX735tejjO1FEWoPOFh1QYcWwyq13Qr62pQPkyo5rmu0RTm+pyYiuZOiZplyFRB
	M9fnsCOV4AVf9Ko0OCAXh4hvfmQI/nGJEhlavRnRK7n4yeyGpkte+irPUibAk/EPDc35xqlDMPs
	q6I47EVeFzYrNNwXiqyEjN93AnTb1G8HDq0odUhg0f6/bYWgCHtfZMnhDdmCiXTovBewrl/Jyc7
	Hv+UNvJpf2OXp5nXLmUoOj+AgJmt+NL5aeJcse+MNCnkHaqC5WdY/jyeLKnYapV7zlagEQkLQIF
	laDaiHmPBGIaDjRC/lKg26MfxUmOyNRubR/T1erDZN/ijrDSTTji1XSJ0lXt57/TfuT2RXMykqD
	wFaQi9KwKU5Pf44R+laPIfTx4woOVJGFw+jkeaExE/WYYKwGGTtFscVFmDyRGLMgstfzCg1j3pz
	3B1sWtXTmHxoHJD/WH2FF5yG7BXPYvpHONnTdh85bu4cPw82/LaRmdcA7OuIaKM7Uf0ygGho9eG
	Xk=
X-Google-Smtp-Source: AGHT+IHQLRoHgdIof3w2MBkwi0guFaozrTsZkg3IhdJhjNNFlSv9rRMzr4LIL1PmoNVhqPsAyCN6MA==
X-Received: by 2002:a05:620a:2592:b0:815:630d:2cbd with SMTP id af79cd13be357-8c38938b1ccmr2586207285a.34.1768235762141;
        Mon, 12 Jan 2026 08:36:02 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4a7962sm1489152685a.11.2026.01.12.08.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 08:36:01 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: [PATCH 3/6] cxl/core/region: move pmem memctrl logic into memctrl/pmem_region
Date: Mon, 12 Jan 2026 11:35:11 -0500
Message-ID: <20260112163514.2551809-4-gourry@gourry.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112163514.2551809-1-gourry@gourry.net>
References: <20260112163514.2551809-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the pmem_region logic from region.c into memctrl/pmem_region.c.
Restrict the valid controllers for pmem to the pmem controller.
Simplify the controller selection logic in region probe.

Cc: 
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/core.h                |   1 +
 drivers/cxl/core/memctrl/Makefile      |   1 +
 drivers/cxl/core/memctrl/memctrl.c     |   2 +
 drivers/cxl/core/memctrl/pmem_region.c | 191 +++++++++++++++++++++
 drivers/cxl/core/region.c              | 221 +++----------------------
 drivers/cxl/cxl.h                      |   2 +
 6 files changed, 217 insertions(+), 201 deletions(-)
 create mode 100644 drivers/cxl/core/memctrl/pmem_region.c

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 18cb84950500..59175890a6ac 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -46,6 +46,7 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 		   u64 dpa);
 int cxl_enable_memctrl(struct cxl_region *cxlr);
 int devm_cxl_add_dax_region(struct cxl_region *cxlr);
+int devm_cxl_add_pmem_region(struct cxl_region *cxlr);
 
 #else
 static inline u64 cxl_dpa_to_hpa(struct cxl_region *cxlr,
diff --git a/drivers/cxl/core/memctrl/Makefile b/drivers/cxl/core/memctrl/Makefile
index 1c52c7d75570..efffc8ba2c0b 100644
--- a/drivers/cxl/core/memctrl/Makefile
+++ b/drivers/cxl/core/memctrl/Makefile
@@ -3,3 +3,4 @@
 cxl_core-$(CONFIG_CXL_REGION) += memctrl/memctrl.o
 cxl_core-$(CONFIG_CXL_REGION) += memctrl/dax_region.o
 cxl_core-$(CONFIG_CXL_REGION) += memctrl/sysram_region.o
+cxl_core-$(CONFIG_CXL_REGION) += memctrl/pmem_region.o
diff --git a/drivers/cxl/core/memctrl/memctrl.c b/drivers/cxl/core/memctrl/memctrl.c
index 40ffb59353bb..1b661465bdeb 100644
--- a/drivers/cxl/core/memctrl/memctrl.c
+++ b/drivers/cxl/core/memctrl/memctrl.c
@@ -36,6 +36,8 @@ int cxl_enable_memctrl(struct cxl_region *cxlr)
 		return devm_cxl_add_dax_region(cxlr);
 	case CXL_MEMCTRL_SYSRAM:
 		return devm_cxl_add_sysram_region(cxlr);
+	case CXL_MEMCTRL_PMEM:
+		return devm_cxl_add_pmem_region(cxlr);
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/cxl/core/memctrl/pmem_region.c b/drivers/cxl/core/memctrl/pmem_region.c
new file mode 100644
index 000000000000..57668dd82d71
--- /dev/null
+++ b/drivers/cxl/core/memctrl/pmem_region.c
@@ -0,0 +1,191 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2022 Intel Corporation. All rights reserved. */
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <cxlmem.h>
+#include <cxl.h>
+#include "../core.h"
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
index eeab091f043a..85c20a09246d 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -642,6 +642,9 @@ static ssize_t ctrl_show(struct device *dev, struct device_attribute *attr,
 	case CXL_MEMCTRL_SYSRAM:
 		desc = "sysram";
 		break;
+	case CXL_MEMCTRL_PMEM:
+		desc = "pmem";
+		break;
 	default:
 		desc = "";
 		break;
@@ -661,6 +664,10 @@ static ssize_t ctrl_store(struct device *dev, struct device_attribute *attr,
 	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
 		return rc;
 
+	/* PMEM only has one controller - the pmem controller */
+	if (cxlr->mode == CXL_PARTMODE_PMEM)
+		return -EBUSY;
+
 	if (p->state >= CXL_CONFIG_COMMIT)
 		return -EBUSY;
 
@@ -2648,7 +2655,11 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
 		return cxlr;
 	cxlr->mode = mode;
 	cxlr->type = type;
-	cxlr->memctrl = CXL_MEMCTRL_NONE;
+
+	if (mode == CXL_PARTMODE_PMEM)
+		cxlr->memctrl = CXL_MEMCTRL_PMEM;
+	else
+		cxlr->memctrl = CXL_MEMCTRL_NONE;
 
 	dev = &cxlr->dev;
 	rc = dev_set_name(dev, "region%d", id);
@@ -2797,46 +2808,6 @@ static ssize_t delete_region_store(struct device *dev,
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
@@ -3268,64 +3239,6 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
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
@@ -3358,92 +3271,6 @@ struct cxl_dax_region *to_cxl_dax_region(struct device *dev)
 }
 EXPORT_SYMBOL_NS_GPL(to_cxl_dax_region, "CXL");
 
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
 static int match_decoder_by_range(struct device *dev, const void *data)
 {
 	const struct range *r1, *r2 = data;
@@ -3929,26 +3756,18 @@ static int cxl_region_probe(struct device *dev)
 			return rc;
 	}
 
-	switch (cxlr->mode) {
-	case CXL_PARTMODE_PMEM:
-		rc = devm_cxl_region_edac_register(cxlr);
-		if (rc)
-			dev_dbg(&cxlr->dev, "CXL EDAC registration for region_id=%d failed\n",
-				cxlr->id);
-
-		return devm_cxl_add_pmem_region(cxlr);
-	case CXL_PARTMODE_RAM:
-		rc = devm_cxl_region_edac_register(cxlr);
-		if (rc)
-			dev_dbg(&cxlr->dev, "CXL EDAC registration for region_id=%d failed\n",
-				cxlr->id);
-
-		return cxl_enable_memctrl(cxlr);
-	default:
+	if (cxlr->mode > CXL_PARTMODE_PMEM) {
 		dev_dbg(&cxlr->dev, "unsupported region mode: %d\n",
 			cxlr->mode);
 		return -ENXIO;
 	}
+
+	rc = devm_cxl_region_edac_register(cxlr);
+	if (rc)
+		dev_dbg(&cxlr->dev, "CXL EDAC registration for region_id=%d failed\n",
+			cxlr->id);
+
+	return cxl_enable_memctrl(cxlr);
 }
 
 static struct cxl_driver cxl_region_driver = {
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index bb4f877b4e8f..c69d27a2e97d 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -509,12 +509,14 @@ enum cxl_partition_mode {
  *   Auto   - either BIOS-configured as SysRAM, or default to DAX
  *   DAX    - creates a dax_region controller for the cxl_region
  *   SYSRAM - hotplugs the region directly as System RAM
+ *   PMEM   - persistent memory controller (nvdimm)
  */
 enum cxl_memctrl_mode {
 	CXL_MEMCTRL_NONE,
 	CXL_MEMCTRL_AUTO,
 	CXL_MEMCTRL_DAX,
 	CXL_MEMCTRL_SYSRAM,
+	CXL_MEMCTRL_PMEM,
 };
 
 /*
-- 
2.52.0

