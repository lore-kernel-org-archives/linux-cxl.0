Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B0132B981
	for <linux-cxl@vger.kernel.org>; Sun, 22 Mar 2026 13:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774185409; cv=none; b=C9Reg1AcVFCXSotQ9lDBLBiOKq18DHyyBmjpk7rTbl67ivP8/PWckRgVS1cYDhtlcicFd49VRoRdLqrCSapkK/Jz9lbH18A/5Vf8e7O7mmGp7LfJTgBb5OOPDdhfOr+tLTaMd286hTcK7b+jYe5n0wCn+a/Kl2JyYbB7KBRFYfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774185409; c=relaxed/simple;
	bh=am2l4ajVSpFYKAgcYmT0ZaGpPJabmMJU5Ho5aT9U7yE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QQEcUQHWJd+oq9f8c9SorzfUWAob9R5xee3AIgnlOO1m8s2wsuSI6emYQKxqqun8FvE0vKFA72txOnSVyhJb9VTBWuPjWTyF0q2ocPo+07S5eeGmEFh+jHBisew92k+iuUADKFM+NJR+vZ4hTfC5luCAeaAizFxSwuXHX2xXHxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=UsnR9NDl; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="UsnR9NDl"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50b4001af28so21946731cf.1
        for <linux-cxl@vger.kernel.org>; Sun, 22 Mar 2026 06:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1774185407; x=1774790207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5j7yKCV7ZUdpMw3XuXoTn7FM0uAcRR3NJGx0Uz7xasI=;
        b=UsnR9NDlZ0iH+v1SMG9HdCi0s+K7aRH61PE5nvepURxQNZP5FH0pS4KP0lwC7jMt8b
         0z3sWTePrUZd4kOfX/r9h51j+YiPlW0n/F3fTjW4QiDnfWkh0Ba0YrcdYuu6zKE8sAG1
         mZm/c43XdB0crSnFPS6jqZhrHYOdLLQQbBFRz1A9+jdyumNpl/afWK+s9G2qY1FZ4/BX
         A6IBDCHCEoWe+aDPN/fMaxnFyPXlGP1/FN0W17KfrMD78mAMWqXSks0WC9CQw0ZW8FO+
         DvMp0AAIHCfAWb0AYGe0zrwIiEyriHTdMRuA2jHtYxMnxl7OnYbT0+fsBn+LnRrnVV8e
         HGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774185407; x=1774790207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5j7yKCV7ZUdpMw3XuXoTn7FM0uAcRR3NJGx0Uz7xasI=;
        b=nWeE+7QzwtHzSnC2W3TgrL5If2iPy8Ffks2dkNqzmD4tH4HNQrUOxCi2gBcsmu7dL9
         dF/d7kteFQ6Ob1lFLn/zoeFqAYMKEALc/6i9cI7DXJMuy+fiC34Zb3wAlpgL6xEDQ4jQ
         43SfuqGNjPl/evxN+xu05VzzKUUUlRPq9hHVQFYzlcZ86s4cINfReyhyzDEg+ay2XPWy
         yXLd564mzL2JnYlG7PQsuH1GOpqzjpNR3OKhtB8AwfR1raFWRLSPcJP2xUuTGtLroAUf
         FRr0+wwopTPbQl3PMRrFUYLaencdX9VVmvFNR4Xvx61Q7valoPqaCa9U6xTRwRtIA993
         tOQA==
X-Gm-Message-State: AOJu0YxpTAHp86IV5PgckROfz4z5LxUJjFrN8j47j93PM2fNuTAjWW6H
	+0DR+sTFthtK9WEbQtPcN+6bE/EiYPhfOFoASEh/F8BpS0jwSg6xO5+WVafljPYeQUE6HCaJ3gX
	jPpOp
X-Gm-Gg: ATEYQzzJ2vPxcyY0vTsl72lzaF5LFXSvrwUVn8UV3yjDdHjCQ5k3Z3vbD/qGmkVb218
	ekYGKyMkgkkJ87hkMwCRNqpZFrI6WX7sLLkPWwM5CiW50tuuzaG4CrMTGOW/LesZwJu3rEmD3aw
	XvyD8wTN6Qr+YlNzSaJMO1Sr/YHjN6a/k0WwKbm/hB6kASRS7FcfIZ6RcKTCxRcnwrkH9fjLqU0
	ELIdVGliwcyU6eC2c6T4CLiP5EIOcdZcRyvNONAcN0vUTWBBZkJAG/K8zJi4fSwvdizfmoCpVP7
	IVVxs1boFbYEg1HHeNo8Pdr2ZSd6nHxy4mjxB8a8p9lTYvRYphZngqrv3fkDJPwfBtr2AzbLb/q
	M4nSjxVW9h+7cwhjChYUL1V+OmqOyGqTwskcjFQU+YtUNh4YIb8NTXiVmX/JCchD6xKw4DfrhB8
	w3NMs1rt/VLznRt/Yvcfvo9VCrCH6BAu7SopPBm1DFwSi4blMUrkbdyh4z9ZGYeZzKaghqFf2G7
	/dKuPEFb6jbvJ8=
X-Received: by 2002:a05:622a:8c4:b0:509:2527:d789 with SMTP id d75a77b69052e-50b373bdd66mr151533221cf.6.1774185406713;
        Sun, 22 Mar 2026 06:16:46 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b36e35086sm59688651cf.18.2026.03.22.06.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 06:16:46 -0700 (PDT)
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
Subject: [PATCH v4 2/3] cxl/core/region: move dax region device logic into region_dax.c
Date: Sun, 22 Mar 2026 09:16:37 -0400
Message-ID: <20260322131638.3636725-3-gourry@gourry.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260322131638.3636725-1-gourry@gourry.net>
References: <20260322131638.3636725-1-gourry@gourry.net>
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
---
 drivers/cxl/core/Makefile     |   1 +
 drivers/cxl/core/core.h       |   1 +
 drivers/cxl/core/region.c     |  99 ------------------------------
 drivers/cxl/core/region_dax.c | 109 ++++++++++++++++++++++++++++++++++
 4 files changed, 111 insertions(+), 99 deletions(-)
 create mode 100644 drivers/cxl/core/region_dax.c

diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index d1484a0e5eb4..d3ec8aea64c5 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -16,6 +16,7 @@ cxl_core-y += pmu.o
 cxl_core-y += cdat.o
 cxl_core-$(CONFIG_TRACING) += trace.o
 cxl_core-$(CONFIG_CXL_REGION) += region.o
+cxl_core-$(CONFIG_CXL_REGION) += region_dax.o
 cxl_core-$(CONFIG_CXL_REGION) += region_pmem.o
 cxl_core-$(CONFIG_CXL_MCE) += mce.o
 cxl_core-$(CONFIG_CXL_FEATURES) += features.o
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
-- 
2.53.0

