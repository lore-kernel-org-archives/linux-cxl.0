Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402A4322B88
	for <linux-cxl@vger.kernel.org>; Fri, 27 Mar 2026 02:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774576978; cv=none; b=G13g5T1UDgNO4hOnIUZyOXQuXjV08q4OdQfynpfJK9J4DHaGbMCNDBfl6flIij+mdQd5YKpJiknagcA4XZknLJKYtanGrVANCgDvrq+UGjbR96KDJkbBDTz3k42LN3Bjg64yEioPKm5V/LU6lElm7ix2vMbQgAmM4RnH2zu6JAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774576978; c=relaxed/simple;
	bh=GJkZbsOMxyuKEUzmOMOAdvQNabePidT+c067e403SrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y59/gKN8A/5zAY1x+ayfFtiWM4vtbw131oYqEq68x/6rz5jiT8yfORRl1GH0qutgJ+77OHX0Hc1HDe1EORU3kj3BhtMb7wYHE14vwFcNV6yUkJHuAaB594mELLu80rCROWgbbx6TotQUMuMU07dlFpU0i1kD7xxekDCyk8Ewkek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=OoSRlTge; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="OoSRlTge"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8cb5c9ba82bso273864685a.2
        for <linux-cxl@vger.kernel.org>; Thu, 26 Mar 2026 19:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1774576976; x=1775181776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EAfXSawMCt5sHFBALvulSehVg0ECXasiExSO+4PybuY=;
        b=OoSRlTge3XfewFN2m/C7lHB7MIL2y+cnR90NJDVWsxCs0x1WYwKpLXGawbTsMFU4kj
         ecXj9ztRLanW/iwBKprTDyWWVrUqSW1DxC3TzU5lwPyul2GhwvafXdj8aCvRYLVLpWyV
         rZl8PjcBMzUxkEieZAWDSymh0dwlI1yaTG5yy/nL9L8TLiBPVPL68o+oXhi6maaBY0n7
         zj0M7JypuF6qmriA6jhtBklNU7pUTURclLBPuCmrylt9e8b21pibkzkmh7GpY+vkiydL
         0XFf4b2S47d9Ac1E1lEm0YRRudsvNHHMBf6yA4u370MFOtnAkK/HJa+q1hRCQ8i7tv+l
         ucwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774576976; x=1775181776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EAfXSawMCt5sHFBALvulSehVg0ECXasiExSO+4PybuY=;
        b=ToilL9dM/rPCRwrQM1xPO/Gqhn4yOOV0/b/yxQn//ie3EaUKtUKQRsNpo2U9i3HA5H
         4Wm5SkWMa+/Y9LhofYRq1omMU0C1WhA0krE7neDZkX5wMy5uql4erh1AZGDNWUN54QLp
         CUkKaKc6t1DyOkduyQg9SDnQ4yqv+KMNHOlBnZX5GtZVKX8t4nsW9jkWDQ7o9IBH4fhr
         kyK3gBqySsgJ7zyyUjNLs+vHVoyWBIToOWljgzEeuSlNp6Y1WU73SJ7H5pMMZYAdNZ1h
         VwO1+lUxZi38eq4JWabtDe7vq5pLn9aL17LKNXVVYQGHekKL8a2Mvdv1vh+zB9d+taRg
         gCig==
X-Gm-Message-State: AOJu0YyzfN7eae3w/915oC+w2ROVPw2alhdAwgwyyxPrTvm1AekpgELO
	5QoeZ91LjwjIvOYbuNI6Oh4P1c5HIPu4dZL0K+07hQa48SpfRsBaLsrGqQi1U3+ac8tbPJTQgiY
	ik6Ux
X-Gm-Gg: ATEYQzzxr0jJzHiPvzREDagp7IVpooLx5TYRaS0eWoptu/+dZdusvMFlLLak99NRvt3
	e/0VT2K07R0nekUUpKccM/DHl2rn2aCd02sZQRvtUd+KwdWRhFJPddkT1REkMhN4pGBtsIATW3m
	FrfOk5Rc8ryZbMGKrMeMXCc3r2rRbfAyTbaLkq4W59EngSnl0KIOcz5y4bdMPWMwoA+waThD0/k
	EQqHY391jJAa5RIuEhCDsL5GGSTKAE5bkwL+vIC8Yyyz2atXFyXZXoBW2MzDPElztkZAY/YPvxu
	u03caJfbA2d7YNzsJ+1qc9S5LItRdZZM3MSuZrMpI+/k653HNdKrHTmkqv1RFRoo8r3trhn2yMf
	CX45H3CfXOO9gpWLgh+PsknpLIKmOo0679qGxeYf6FEoqvwUfL/8Gc/nNLL2rLhzgPo18Ud3CXG
	MGnJNzTVfY5SWVDVfgb7wQsqkcCyVu/tvC1LBufcuj9PIUOA==
X-Received: by 2002:ac8:7d0d:0:b0:50b:4167:7889 with SMTP id d75a77b69052e-50ba386bab6mr11558691cf.30.1774576975649;
        Thu, 26 Mar 2026 19:02:55 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([63.116.149.204])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b923c0fc1sm39158901cf.27.2026.03.26.19.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 19:02:55 -0700 (PDT)
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
Subject: [PATCH v5 2/3] cxl/core/region: move dax region device logic into region_dax.c
Date: Thu, 26 Mar 2026 22:02:02 -0400
Message-ID: <20260327020203.876122-3-gourry@gourry.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327020203.876122-1-gourry@gourry.net>
References: <20260327020203.876122-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

core/region.c is overloaded with per-region control logic (pmem, dax,
sysram, etc). Move the CXL DAX region device infrastructure from
region.c into a new region_dax.c file.

This will also allow us to add additional dax-driver integration paths
that don't further dirty the core region.c logic.

No functional changes.

Signed-off-by: Gregory Price <gourry@gourry.net>
Co-developed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/core/Makefile     |   2 +-
 drivers/cxl/core/core.h       |   1 +
 drivers/cxl/core/region.c     |  99 ------------------------------
 drivers/cxl/core/region_dax.c | 109 ++++++++++++++++++++++++++++++++++
 tools/testing/cxl/Kbuild      |   2 +-
 5 files changed, 112 insertions(+), 101 deletions(-)
 create mode 100644 drivers/cxl/core/region_dax.c

diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index f73776fe323b..ce7213818d3c 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -15,7 +15,7 @@ cxl_core-y += hdm.o
 cxl_core-y += pmu.o
 cxl_core-y += cdat.o
 cxl_core-$(CONFIG_TRACING) += trace.o
-cxl_core-$(CONFIG_CXL_REGION) += region.o region_pmem.o
+cxl_core-$(CONFIG_CXL_REGION) += region.o region_pmem.o region_dax.o
 cxl_core-$(CONFIG_CXL_MCE) += mce.o
 cxl_core-$(CONFIG_CXL_FEATURES) += features.o
 cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += edac.o
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index ef03966eeabd..82ca3a476708 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -50,6 +50,7 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port);
 struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa);
 u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 		   u64 dpa);
+int devm_cxl_add_dax_region(struct cxl_region *cxlr);
 int devm_cxl_add_pmem_region(struct cxl_region *cxlr);
 
 #else
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 72aee1408efb..6a2ef3475764 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3436,105 +3436,6 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
 	return -ENXIO;
 }
 
-static void cxl_dax_region_release(struct device *dev)
-{
-	struct cxl_dax_region *cxlr_dax = to_cxl_dax_region(dev);
-
-	kfree(cxlr_dax);
-}
-
-static const struct attribute_group *cxl_dax_region_attribute_groups[] = {
-	&cxl_base_attribute_group,
-	NULL,
-};
-
-const struct device_type cxl_dax_region_type = {
-	.name = "cxl_dax_region",
-	.release = cxl_dax_region_release,
-	.groups = cxl_dax_region_attribute_groups,
-};
-
-static bool is_cxl_dax_region(struct device *dev)
-{
-	return dev->type == &cxl_dax_region_type;
-}
-
-struct cxl_dax_region *to_cxl_dax_region(struct device *dev)
-{
-	if (dev_WARN_ONCE(dev, !is_cxl_dax_region(dev),
-			  "not a cxl_dax_region device\n"))
-		return NULL;
-	return container_of(dev, struct cxl_dax_region, dev);
-}
-EXPORT_SYMBOL_NS_GPL(to_cxl_dax_region, "CXL");
-
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
-	cxlr_dax = kzalloc_obj(*cxlr_dax);
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
 static int match_root_decoder(struct device *dev, const void *data)
 {
 	const struct range *r1, *r2 = data;
diff --git a/drivers/cxl/core/region_dax.c b/drivers/cxl/core/region_dax.c
new file mode 100644
index 000000000000..fe367759ac69
--- /dev/null
+++ b/drivers/cxl/core/region_dax.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright(c) 2022 Intel Corporation. All rights reserved.
+ * Copyright(c) 2026 Meta Technologies Inc. All rights reserved.
+ */
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <cxlmem.h>
+#include <cxl.h>
+#include "core.h"
+
+static void cxl_dax_region_release(struct device *dev)
+{
+	struct cxl_dax_region *cxlr_dax = to_cxl_dax_region(dev);
+
+	kfree(cxlr_dax);
+}
+
+static const struct attribute_group *cxl_dax_region_attribute_groups[] = {
+	&cxl_base_attribute_group,
+	NULL
+};
+
+const struct device_type cxl_dax_region_type = {
+	.name = "cxl_dax_region",
+	.release = cxl_dax_region_release,
+	.groups = cxl_dax_region_attribute_groups,
+};
+
+static bool is_cxl_dax_region(struct device *dev)
+{
+	return dev->type == &cxl_dax_region_type;
+}
+
+struct cxl_dax_region *to_cxl_dax_region(struct device *dev)
+{
+	if (dev_WARN_ONCE(dev, !is_cxl_dax_region(dev),
+			  "not a cxl_dax_region device\n"))
+		return NULL;
+	return container_of(dev, struct cxl_dax_region, dev);
+}
+EXPORT_SYMBOL_NS_GPL(to_cxl_dax_region, "CXL");
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
+	cxlr_dax = kzalloc_obj(*cxlr_dax);
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
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index f53d79a05661..d2b291e5f842 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -59,7 +59,7 @@ cxl_core-y += $(CXL_CORE_SRC)/hdm.o
 cxl_core-y += $(CXL_CORE_SRC)/pmu.o
 cxl_core-y += $(CXL_CORE_SRC)/cdat.o
 cxl_core-$(CONFIG_TRACING) += $(CXL_CORE_SRC)/trace.o
-cxl_core-$(CONFIG_CXL_REGION) += $(CXL_CORE_SRC)/region.o $(CXL_CORE_SRC)/region_pmem.o
+cxl_core-$(CONFIG_CXL_REGION) += $(CXL_CORE_SRC)/region.o $(CXL_CORE_SRC)/region_pmem.o $(CXL_CORE_SRC)/region_dax.o
 cxl_core-$(CONFIG_CXL_MCE) += $(CXL_CORE_SRC)/mce.o
 cxl_core-$(CONFIG_CXL_FEATURES) += $(CXL_CORE_SRC)/features.o
 cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += $(CXL_CORE_SRC)/edac.o
-- 
2.53.0

