Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA091352C5C
	for <linux-cxl@vger.kernel.org>; Wed, 11 Feb 2026 20:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770842538; cv=none; b=u8qnE9qX5yRMqp2xbhpF0pvmWtBx2rMwGEO9lbvbS81G3bFoONplU+CB6NpI90K/DkCq0/deZ69RKQ9x//gV4upq3CrYQ2OSbB2zcfYf++Q9aAdV7rKQBEuLILK4GGubhU8UQh8MXJQPHqDOwOiwKk2YkAMWNLYBPgFb/z7k73I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770842538; c=relaxed/simple;
	bh=dc0/f+72fO066qR70nZo/P4imNLuNHmky2aGyXv5bYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QE8qqeISQfkD6Qm10qkcvKUUZ4MAFQm8ew3tU2GY0enBWjwXRrbiQ8FbWDz247owZQhN5x/1LEg2dggOCYOI63FNgmjCQDyNY5NWDor8JN8rrz+JWD7V08lDccRgxBKhsprhJy3KLMjFSiJGCqxDGZI0T6lux5bxd10ZwXZH2aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=k7frlLQx; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="k7frlLQx"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50331ac1fedso72469091cf.0
        for <linux-cxl@vger.kernel.org>; Wed, 11 Feb 2026 12:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1770842535; x=1771447335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hPnkt2HqQSF9t7HcwfsUe1t/3CrGC8q8jLWUL6hw2HQ=;
        b=k7frlLQxTORDD9+3nRBpf9XuS8Q5kSBu2nJwh4dH4zB2xbP9/8uh+phLuvbr9MtCJ4
         mTvpqW4FJaq1JyIKWUrhuqv/mirOSvYGUesV0jcFElJHOjtphHxcEbXid11qLi4j5/Qq
         DBl27y7j/uLFxsezcXojVScwEwemXrzzUuSaNGeMqSk1uk5aq2mrbI3dBEEeSXV8B6iZ
         ud3IinDhBw9PjyjObtOr9WHdkgxm8vNlvZq5JP3qbjCCfHT5uP0dD9aJL6mHp0FRFEck
         67p0aRzyHGgPVgf/qQrSoM0sNdxi2LGaysVQvOnwA5jczQCRvK1N7nCsT3Gpfbtp9YZn
         /TOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770842535; x=1771447335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hPnkt2HqQSF9t7HcwfsUe1t/3CrGC8q8jLWUL6hw2HQ=;
        b=CfvQL/l37FIMoRf//QbCUssZSKZY4WMZl3MIzJ2pA17q8K4vpvt+YTLGCHgqisCtBz
         KkOpVkqGl7UP0BsW2xfZPMXjPMBT0B2rH1WAf0aen52a8TV1hOgnJMJwsjlMHPD0R2Rm
         cDB1LgPRwIC2OCSIsBc5TpDWuOxkyuEDAByTGCSGOwVgrck33OoLwD+szmGSGSbbTDgL
         07EY/J6NiY45XWz9mOELTYzGB9cy5VMOzPMj7CYxEQeiZe7lsG9w9o+KWseTr8yW1F4Q
         iA9mFem7L5HJpmd34xvrsSk1vu9unB0j0FXfaJXFiRom+efook5wv5bL1gWeXsIcpHOX
         DHBw==
X-Gm-Message-State: AOJu0Ywb+HbTlRZeyWrg67i14jqCw/O70VPJyPRijZlZoP1UDnPjlh50
	9vyrsYJ+pCU1yJygr6R6OhHD75jQhputjJcgzbNg7EVfp7V1At0nWQucMMDrmP7ngTzgKhOKGei
	+mWK+
X-Gm-Gg: AZuq6aKtZy+ycfeQXCOylEMekPMCApC9y3krM+RFP3ayDWIX8OzqfVJHtZ6B/dLPwk+
	rTHYvwvafzUrzqYBn2TQoccZCeXHUZZsrhZropx50N3psTWzepPDUlYAxYmF4syqRLMTgVPwDgA
	FT10BOaMezLesbz6dAl/zjtXQ9mixgUZh8VPBmutW8Bi1qrcxFN4suDBiUwErWWKkHyx2SMyPKt
	40PA+YtksZf49SY3sgKvs4gdvB5i1HQyHDbMW0GC3pbtY11tEFIx16JhlPlSKHse9e84XKMZmL1
	73+YaNtdzClp1VfjFPaTYuVXUFe6xiiBJbJOTdLP86LIgHus/iat2E9St2GGAUhc0Ly5A0Ag7HR
	VSUDTpJbi115P65afYGvMQfDrlZ6pD0JbngPI19Mv9LYozQClDskMmCAE7DPhfh04ezEf//KW6E
	EAElRfQjTAoKNW8hnGFx1aeFLWHd9W1tCLR3HopTuSth/4nLM9zqQkYXjVBDt6z92MjYb5jObom
	tAyGfj72/CCi5Q=
X-Received: by 2002:a05:622a:1a89:b0:501:3c88:131 with SMTP id d75a77b69052e-50691a3643fmr11189491cf.22.1770842535613;
        Wed, 11 Feb 2026 12:42:15 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-506847d77cesm20173591cf.3.2026.02.11.12.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 12:42:15 -0800 (PST)
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
	dan.j.williams@intel.com,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: [PATCH v3 2/3] cxl/core/region: move dax region device logic into region_dax.c
Date: Wed, 11 Feb 2026 15:42:05 -0500
Message-ID: <20260211204206.2171525-3-gourry@gourry.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260211204206.2171525-1-gourry@gourry.net>
References: <20260211204206.2171525-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

core/region.c is overloaded with per-region control logic (pmem, dax).
Move CXL DAX region device logic from region.c into region_dax.c.

No functional changes.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
Acked-by: Davidlohr Bueso <dave@stgolabs.net>
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
index ced65a779a09..a89e0d6d9e7b 100644
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
index 1c322318d70e..0c37caa60f2a 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3392,105 +3392,6 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
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
index 000000000000..c8dd2bd1d9b9
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
2.47.3

