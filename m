Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2271536654C
	for <linux-cxl@vger.kernel.org>; Mon, 12 Jan 2026 16:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768235760; cv=none; b=gHNjrcDfpRFvKqhGM776PLLCyWqQZureqL6l8sHNwMKr9Zx6U2bIjhWvQckHsNIO4s75MV0ILXPWXEHsDU7Eij7KTzNG+CrMDfh0EEzmZyOzyjFzvw1QPZ0b/IS/0r3nd+e/32a46JbyP/WLaBU+cXiGz+PzwIyT6wr+c2czaHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768235760; c=relaxed/simple;
	bh=8Lxk5q8Y8vH2rpMB8enFhlEA8toiRN4zlIRDGPRvUrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gb+ykMXs0/H9FLhsy0KZec2CrpUsg6O1C79zfdXufT5o/kufHPmxCMJLGwWFcHM3H42hKoSfnzTqhOzlQ35LClBa2xA4vV7PsU75CH5dWbzZrwDZlpMVkt3wWGSt8I45C1qB3vT8n7alD/ch78ZY6YOD/ROJeGGp82aH1v0IzL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=WH8Gde/s; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="WH8Gde/s"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8b25ed53fcbso138488385a.0
        for <linux-cxl@vger.kernel.org>; Mon, 12 Jan 2026 08:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768235757; x=1768840557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kitsfgvAgIwjSktv7QGOLbd42NqWt1GntcXx/7ro77s=;
        b=WH8Gde/s0PH2QzWDWcn6o5rKkEfLrLlwvZpp8IMw+X3FFRiTPvDa4vJAasVBm9chSY
         tVisJZBKi56poVQVA0gVLoZqNonnMYzkA1hU4n7Sr9Pu9kN1pglAfREIL5Rc61hcKzsK
         rnUfppOlkZ5pez8FkOPgIuv9ELdllC8AX3YuJD/5SD8aiek53HXLw0T99n1NsK+RKOVn
         lN21EDo3VX4BbiKqLrjIPgzFJs6Rm8rw5y2N+xiShgrfPjANzaJaBICL0u/inkmkbs/R
         waTjAWU5WtI+2LT61J8Uzd9fy5JBUlrBzK0jXLdZGod+zc6dwOh2VXxIZMA9VkVHy7K3
         htZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768235757; x=1768840557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kitsfgvAgIwjSktv7QGOLbd42NqWt1GntcXx/7ro77s=;
        b=xOjyHSK2yHa5gfs3OSCed8hhBYTRwbKeUkP+OG4loggqPnL4IdZDTlIUbCn8GT90+Z
         FTrJ/ptDkl0K5hWkVhQ+2KG4qsnxjOiQwUsXuZPQ+PHMgTN5/dtWsJede3KYIpDsQPu1
         LsDYrIRQv/dJWfpkauM8WCG78tTE2DxyE7Fi4uaEIHk0ILX2fu9lCERURG6pha2+M26V
         bNBufMxssyoEmEYpDLLisfTgwKeyHGRWO5ttvaNrQzkRH+IYQgC0SNGCFjY2ZlnGvRS5
         kek98YYoT5m98ne0CF0khtsx8EZGSj8Br32n2CoOgj0sCeT4oa5qEKIGTtRDzyukssrV
         Ui3w==
X-Gm-Message-State: AOJu0YzCvkjkr1/bjiMIU1hbF1wPvv3HuvTI+2wav/eazK8EX5BqlxOY
	73FOFK2Vv0oo5mzvbJTB/A5929es5l2lY6iwNwpVxiricC7tTuDQtBqX4RZUoMeYTzC6tYlhkvW
	RECgS
X-Gm-Gg: AY/fxX4FW2nk4xEo7iI7gb8w3F3OPbkyRConBwkdEuEX6LTuudUn5OLvwlvhwvbfjCg
	Vq0wa2G5ToptA+SbaDHdKL62GIoYQnb+r5J1FaOelbKHC3c68eFfNhQQqLcNA2pEodbA4exNaIq
	o3AQNlV4ehsii9t9BKawOWrI5W8O/e45KPfqHgIisQpfi9VVEwKwiBnkqMq/OGd16bvkKfG8/0n
	v2bw2jD9vRkozujmWiDW5Gk4abbaP14NcpsiISf7Ul+o1UJ7bfgY7gQ7bs6zUlqHh4eFGntMsGz
	o0vkv6G705/y7PQp/NLL9iKGwu6Jr2VX6kaO9pi5Fl23SbOI9m6FP96LmtoAv5puRV4zxfLZq4x
	Bside50+GHO4eZhZaYw/EbG9xdtGyj8V1ebNA4gycK3bVgDCnE37ESKESlEIrGb0ESALZeYk9TR
	ssbJkXW0rxe0uZTKdGxcoiCw+Gjp+dbjFypnLsyYA3esor6faxKVRftXmP7jw9yDtKL1lfjZZnf
	Rs=
X-Google-Smtp-Source: AGHT+IEfsLXkvZ5Af7pEDx7TCXcw8AH3MCvjCGKobIA4iIxO4KEaAk5ecCJQJ+qJH2eNNZ5KFkYuBA==
X-Received: by 2002:a05:620a:458c:b0:8ba:419f:c79e with SMTP id af79cd13be357-8c3893f5027mr2124194685a.55.1768235756801;
        Mon, 12 Jan 2026 08:35:56 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4a7962sm1489152685a.11.2026.01.12.08.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 08:35:56 -0800 (PST)
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
Subject: [PATCH 1/6] drivers/cxl: add cxl_memctrl_mode and region->memctrl
Date: Mon, 12 Jan 2026 11:35:09 -0500
Message-ID: <20260112163514.2551809-2-gourry@gourry.net>
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

The CXL driver presently hands policy management over to DAX subsystem
for sysram regions, which makes building policy around the entire region
clunky and at time difficult (e.g. multiple actions to offline and
hot-unplug memory reliably).

To support multiple backend controllers for memory regions (for example
dax vs direct hotplug), implement a memctrl field in cxl_region allows
switching uncomitted regions between different "memory controllers".

CXL_CONTROL_NONE: No selected controller, probe will fail.
CXL_CONTROL_AUTO: If memory is already online as SysRAM, no controller
                  otherwise register a dax_region
CXL_CONTROL_DAX : register a dax_region

Auto regions will either be static sysram (BIOS-onlined) and has no
region controller associated with it - or if the SP bit was set a
DAX device will be created.

Rather than default all regions to the auto-controller, only default
auto-regions to the auto controller.

Non-auto regions will be defaulted to CXL_CONTROL_NONE, which will cause
a failure to probe unless a controller is selected.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/Makefile             |   1 +
 drivers/cxl/core/core.h               |   2 +
 drivers/cxl/core/memctrl/Makefile     |   4 +
 drivers/cxl/core/memctrl/dax_region.c |  79 +++++++++++++++
 drivers/cxl/core/memctrl/memctrl.c    |  42 ++++++++
 drivers/cxl/core/region.c             | 136 ++++++++++----------------
 drivers/cxl/cxl.h                     |  14 +++
 7 files changed, 192 insertions(+), 86 deletions(-)
 create mode 100644 drivers/cxl/core/memctrl/Makefile
 create mode 100644 drivers/cxl/core/memctrl/dax_region.c
 create mode 100644 drivers/cxl/core/memctrl/memctrl.c

diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index 5ad8fef210b5..79de20e3f8aa 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -17,6 +17,7 @@ cxl_core-y += cdat.o
 cxl_core-y += ras.o
 cxl_core-$(CONFIG_TRACING) += trace.o
 cxl_core-$(CONFIG_CXL_REGION) += region.o
+include $(src)/memctrl/Makefile
 cxl_core-$(CONFIG_CXL_MCE) += mce.o
 cxl_core-$(CONFIG_CXL_FEATURES) += features.o
 cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += edac.o
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 1fb66132b777..1156a4bd0080 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -42,6 +42,8 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port);
 struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa);
 u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 		   u64 dpa);
+int cxl_enable_memctrl(struct cxl_region *cxlr);
+int devm_cxl_add_dax_region(struct cxl_region *cxlr);
 
 #else
 static inline u64 cxl_dpa_to_hpa(struct cxl_region *cxlr,
diff --git a/drivers/cxl/core/memctrl/Makefile b/drivers/cxl/core/memctrl/Makefile
new file mode 100644
index 000000000000..8165aad5a52a
--- /dev/null
+++ b/drivers/cxl/core/memctrl/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+
+cxl_core-$(CONFIG_CXL_REGION) += memctrl/memctrl.o
+cxl_core-$(CONFIG_CXL_REGION) += memctrl/dax_region.o
diff --git a/drivers/cxl/core/memctrl/dax_region.c b/drivers/cxl/core/memctrl/dax_region.c
new file mode 100644
index 000000000000..90d7fdb97013
--- /dev/null
+++ b/drivers/cxl/core/memctrl/dax_region.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2022 Intel Corporation. All rights reserved. */
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <cxlmem.h>
+#include <cxl.h>
+#include "../core.h"
+
+static struct lock_class_key cxl_dax_region_key;
+
+static struct cxl_dax_region *cxl_dax_region_alloc(struct cxl_region *cxlr)
+{
+	struct cxl_region_params *p = &cxlr->params;
+	struct cxl_dax_region *cxlr_dax;
+	struct device *dev;
+
+	guard(rwsem_read)(&cxl_rwsem.region);
+	if (p->state != CXL_CONFIG_COMMIT)
+		return ERR_PTR(-ENXIO);
+
+	cxlr_dax = kzalloc(sizeof(*cxlr_dax), GFP_KERNEL);
+	if (!cxlr_dax)
+		return ERR_PTR(-ENOMEM);
+
+	cxlr_dax->hpa_range.start = p->res->start;
+	cxlr_dax->hpa_range.end = p->res->end;
+
+	dev = &cxlr_dax->dev;
+	cxlr_dax->cxlr = cxlr;
+	device_initialize(dev);
+	lockdep_set_class(&dev->mutex, &cxl_dax_region_key);
+	device_set_pm_not_required(dev);
+	dev->parent = &cxlr->dev;
+	dev->bus = &cxl_bus_type;
+	dev->type = &cxl_dax_region_type;
+
+	return cxlr_dax;
+}
+
+static void cxlr_dax_unregister(void *_cxlr_dax)
+{
+	struct cxl_dax_region *cxlr_dax = _cxlr_dax;
+
+	device_unregister(&cxlr_dax->dev);
+}
+
+/*
+ * The dax controller is the default controller and simply hands the
+ * control pattern over to the dax driver.  It does with a dax_region
+ * built by dax/cxl.c
+ */
+int devm_cxl_add_dax_region(struct cxl_region *cxlr)
+{
+	struct cxl_dax_region *cxlr_dax;
+	struct device *dev;
+	int rc;
+
+	cxlr_dax = cxl_dax_region_alloc(cxlr);
+	if (IS_ERR(cxlr_dax))
+		return PTR_ERR(cxlr_dax);
+
+	dev = &cxlr_dax->dev;
+	rc = dev_set_name(dev, "dax_region%d", cxlr->id);
+	if (rc)
+		goto err;
+
+	rc = device_add(dev);
+	if (rc)
+		goto err;
+
+	dev_dbg(&cxlr->dev, "%s: register %s\n", dev_name(dev->parent),
+		dev_name(dev));
+
+	return devm_add_action_or_reset(&cxlr->dev, cxlr_dax_unregister,
+					cxlr_dax);
+err:
+	put_device(dev);
+	return rc;
+}
diff --git a/drivers/cxl/core/memctrl/memctrl.c b/drivers/cxl/core/memctrl/memctrl.c
new file mode 100644
index 000000000000..24e0e14b39c7
--- /dev/null
+++ b/drivers/cxl/core/memctrl/memctrl.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2022 Intel Corporation. All rights reserved. */
+/* Copyright(c) 2026 Meta Inc. All rights reserved. */
+#include <linux/device.h>
+#include <linux/ioport.h>
+#include <cxlmem.h>
+#include <cxl.h>
+#include "../core.h"
+
+static int is_system_ram(struct resource *res, void *arg)
+{
+	struct cxl_region *cxlr = arg;
+	struct cxl_region_params *p = &cxlr->params;
+
+	dev_dbg(&cxlr->dev, "%pr has System RAM: %pr\n", p->res, res);
+	return 1;
+}
+
+int cxl_enable_memctrl(struct cxl_region *cxlr)
+{
+	struct cxl_region_params *p = &cxlr->params;
+
+	switch (cxlr->memctrl) {
+	case CXL_MEMCTRL_AUTO:
+		/*
+		 * The region can not be manged by CXL if any portion of
+		 * it is already online as 'System RAM'
+		 */
+		if (walk_iomem_res_desc(IORES_DESC_NONE,
+					IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
+					p->res->start, p->res->end, cxlr,
+					is_system_ram) > 0)
+			return 0;
+		return devm_cxl_add_dax_region(cxlr);
+	case CXL_MEMCTRL_DAX:
+		return devm_cxl_add_dax_region(cxlr);
+	default:
+		return -EINVAL;
+	}
+}
+
+
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index ae899f68551f..02d7d9ae0252 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -626,6 +626,50 @@ static ssize_t mode_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(mode);
 
+static ssize_t ctrl_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct cxl_region *cxlr = to_cxl_region(dev);
+	const char *desc;
+
+	switch (cxlr->memctrl) {
+	case CXL_MEMCTRL_AUTO:
+		desc = "auto";
+		break;
+	case CXL_MEMCTRL_DAX:
+		desc = "dax";
+		break;
+	default:
+		desc = "";
+		break;
+	}
+
+	return sysfs_emit(buf, "%s\n", desc);
+}
+
+static ssize_t ctrl_store(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t len)
+{
+	struct cxl_region *cxlr = to_cxl_region(dev);
+	struct cxl_region_params *p = &cxlr->params;
+	int rc;
+
+	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
+	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
+		return rc;
+
+	if (p->state >= CXL_CONFIG_COMMIT)
+		return -EBUSY;
+
+	if (sysfs_streq(buf, "dax"))
+		cxlr->memctrl = CXL_MEMCTRL_DAX;
+	else
+		return -EINVAL;
+
+	return len;
+}
+static DEVICE_ATTR_RW(ctrl);
+
 static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
 {
 	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
@@ -772,6 +816,7 @@ static struct attribute *cxl_region_attrs[] = {
 	&dev_attr_size.attr,
 	&dev_attr_mode.attr,
 	&dev_attr_extended_linear_cache_size.attr,
+	&dev_attr_ctrl.attr,
 	NULL,
 };
 
@@ -2598,6 +2643,7 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
 		return cxlr;
 	cxlr->mode = mode;
 	cxlr->type = type;
+	cxlr->memctrl = CXL_MEMCTRL_NONE;
 
 	dev = &cxlr->dev;
 	rc = dev_set_name(dev, "region%d", id);
@@ -3307,37 +3353,6 @@ struct cxl_dax_region *to_cxl_dax_region(struct device *dev)
 }
 EXPORT_SYMBOL_NS_GPL(to_cxl_dax_region, "CXL");
 
-static struct lock_class_key cxl_dax_region_key;
-
-static struct cxl_dax_region *cxl_dax_region_alloc(struct cxl_region *cxlr)
-{
-	struct cxl_region_params *p = &cxlr->params;
-	struct cxl_dax_region *cxlr_dax;
-	struct device *dev;
-
-	guard(rwsem_read)(&cxl_rwsem.region);
-	if (p->state != CXL_CONFIG_COMMIT)
-		return ERR_PTR(-ENXIO);
-
-	cxlr_dax = kzalloc(sizeof(*cxlr_dax), GFP_KERNEL);
-	if (!cxlr_dax)
-		return ERR_PTR(-ENOMEM);
-
-	cxlr_dax->hpa_range.start = p->res->start;
-	cxlr_dax->hpa_range.end = p->res->end;
-
-	dev = &cxlr_dax->dev;
-	cxlr_dax->cxlr = cxlr;
-	device_initialize(dev);
-	lockdep_set_class(&dev->mutex, &cxl_dax_region_key);
-	device_set_pm_not_required(dev);
-	dev->parent = &cxlr->dev;
-	dev->bus = &cxl_bus_type;
-	dev->type = &cxl_dax_region_type;
-
-	return cxlr_dax;
-}
-
 static void cxlr_pmem_unregister(void *_cxlr_pmem)
 {
 	struct cxl_pmem_region *cxlr_pmem = _cxlr_pmem;
@@ -3424,42 +3439,6 @@ static int devm_cxl_add_pmem_region(struct cxl_region *cxlr)
 	return rc;
 }
 
-static void cxlr_dax_unregister(void *_cxlr_dax)
-{
-	struct cxl_dax_region *cxlr_dax = _cxlr_dax;
-
-	device_unregister(&cxlr_dax->dev);
-}
-
-static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
-{
-	struct cxl_dax_region *cxlr_dax;
-	struct device *dev;
-	int rc;
-
-	cxlr_dax = cxl_dax_region_alloc(cxlr);
-	if (IS_ERR(cxlr_dax))
-		return PTR_ERR(cxlr_dax);
-
-	dev = &cxlr_dax->dev;
-	rc = dev_set_name(dev, "dax_region%d", cxlr->id);
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
-	return devm_add_action_or_reset(&cxlr->dev, cxlr_dax_unregister,
-					cxlr_dax);
-err:
-	put_device(dev);
-	return rc;
-}
-
 static int match_decoder_by_range(struct device *dev, const void *data)
 {
 	const struct range *r1, *r2 = data;
@@ -3579,6 +3558,9 @@ static int __construct_region(struct cxl_region *cxlr,
 
 	set_bit(CXL_REGION_F_AUTO, &cxlr->flags);
 
+	/* Auto-regions will either be static sysram (onlined by BIOS) or DAX */
+	cxlr->memctrl = CXL_MEMCTRL_AUTO;
+
 	res = kmalloc(sizeof(*res), GFP_KERNEL);
 	if (!res)
 		return -ENOMEM;
@@ -3755,15 +3737,6 @@ u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 spa)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_port_get_spa_cache_alias, "CXL");
 
-static int is_system_ram(struct resource *res, void *arg)
-{
-	struct cxl_region *cxlr = arg;
-	struct cxl_region_params *p = &cxlr->params;
-
-	dev_dbg(&cxlr->dev, "%pr has System RAM: %pr\n", p->res, res);
-	return 1;
-}
-
 static void shutdown_notifiers(void *_cxlr)
 {
 	struct cxl_region *cxlr = _cxlr;
@@ -3965,16 +3938,7 @@ static int cxl_region_probe(struct device *dev)
 			dev_dbg(&cxlr->dev, "CXL EDAC registration for region_id=%d failed\n",
 				cxlr->id);
 
-		/*
-		 * The region can not be manged by CXL if any portion of
-		 * it is already online as 'System RAM'
-		 */
-		if (walk_iomem_res_desc(IORES_DESC_NONE,
-					IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
-					p->res->start, p->res->end, cxlr,
-					is_system_ram) > 0)
-			return 0;
-		return devm_cxl_add_dax_region(cxlr);
+		return cxl_enable_memctrl(cxlr);
 	default:
 		dev_dbg(&cxlr->dev, "unsupported region mode: %d\n",
 			cxlr->mode);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index ba17fa86d249..b8fabaa77262 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -502,6 +502,19 @@ enum cxl_partition_mode {
 	CXL_PARTMODE_PMEM,
 };
 
+
+/*
+ * Memory Controller modes:
+ *   None - No controller selected
+ *   Auto - either BIOS-configured as SysRAM, or default to DAX
+ *   DAX  - creates a dax_region controller for the cxl_region
+ */
+enum cxl_memctrl_mode {
+	CXL_MEMCTRL_NONE,
+	CXL_MEMCTRL_AUTO,
+	CXL_MEMCTRL_DAX,
+};
+
 /*
  * Indicate whether this region has been assembled by autodetection or
  * userspace assembly. Prevent endpoint decoders outside of automatic
@@ -543,6 +556,7 @@ struct cxl_region {
 	struct device dev;
 	int id;
 	enum cxl_partition_mode mode;
+	enum cxl_memctrl_mode memctrl;
 	enum cxl_decoder_type type;
 	struct cxl_nvdimm_bridge *cxl_nvb;
 	struct cxl_pmem_region *cxlr_pmem;
-- 
2.52.0

