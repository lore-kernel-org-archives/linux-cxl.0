Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB6436AB71
	for <linux-cxl@vger.kernel.org>; Tue, 13 Jan 2026 20:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768335743; cv=none; b=rdiyjYfUaSVwAXVElm8KP+tLPCH7ituB4WrQUYxKh+KoYOBhKdIkrvyeIsAhDwwlPvgakoe9UkKOm7F3YlKXv+egdnLxohDOfpRR8UyQkN6v7fn/KjICPXK7cDGdpaVqd8PQGdIRj5ax9ZTKUU2DM2FYP+4Ha9c+n+kBs1ppX58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768335743; c=relaxed/simple;
	bh=Ps6x9LR9M76Am+g7AZ+bZixj0zw8b0mCnW+J/ifG0Ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D+RlFEtzX7fbpIAbT+qjPEyxOmqg0/zPetzVOUEjWb12qQt5jcLTAwTqstNgycCk/O9iVWZvK3BypwqNoMrPKqJAjEWzf64lItTEfDjr8zSh5sYIza31MPcdyIp2n5Z2ICVwMjQTUY/OAJHaiEN/ftNXpC+STaM/YkH3Kd7QmNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ZzcJr0YV; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ZzcJr0YV"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8b2f0f9e4cbso16845685a.0
        for <linux-cxl@vger.kernel.org>; Tue, 13 Jan 2026 12:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768335741; x=1768940541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gL8Ki7O1G5w9RIAA64ayeFRTXUUjdgBJeiWvwl9E9k8=;
        b=ZzcJr0YVCTv1MumvyehqQT/X+DyXO7/vXRaBcmMW79WbOF8zVRW42H67UjJgEX7tNc
         J75PY6+mjS9u+xjQYW+tM79vqpUh2xb6258EX676dadhpH1ULJ5++yKPPZA+EqLe8wUm
         BggYfhCN4fyyboDbqNlfgp5/WXbckK3S0mn60rrSGS5mYigk9QQyuX4LqNUbK7uSswZo
         14EO4MQdBy+GJ5a03EqT98hgTZG3dlC0niFFLnrJU64rFcp00j1H50mF0OA7s6lnYmhm
         LV8vIopZVSPLypcik5shEArf1BCtTpw0jR9dVsQ8ec52oF9+3wUrOZWRPZouIuaSxEK3
         EytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768335741; x=1768940541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gL8Ki7O1G5w9RIAA64ayeFRTXUUjdgBJeiWvwl9E9k8=;
        b=G+dPECXdEbrXB7Qr3YnsXfPEXo6y8hppohq5KQxAZlE9TQKVymP8uNnrlYA4u2yaic
         wvccO9rHeg4gAopPXOhw76Eosh9ac09XPTy7/fUDgCS93saJC4MRNEpNUJVn2YCPLVIc
         9KKH6qr4VWfuoTsUSzn5sucUIA9LI9X+9JtLbraQHv5MeNOQJjrgyM21fGpFsyaLmItF
         u7o/XNfl66z0femH8Yy8/mr/i4kI8u6JkY9PiXio2Ppv34fFSJLzHB0rU6QFIS7FGGtY
         JkKbWbJm/DetGwDmzxOnDBcock3zhe6n9BIWYqkHQpWnbvUXSIG5Ub+CAZoGVlq8zfK6
         76DA==
X-Gm-Message-State: AOJu0YyRJg3O6q7fTAPLekrgwKDrK1dknAQHuihfLfqKeSsi/du+6ofg
	NOoI+Ua/qCJ4iEUKZsnMInRCmw2i1AOImOx67h7lf8NBCyuLGXnb5Jl6rVRE3kHaX0XrGXh9XHE
	BvwOXoM0=
X-Gm-Gg: AY/fxX7yOj0T+JJFyabqusNhEwmNJKDh9NNDmHZgVIpIx0bApx7rEi5c/kHQMmGH20i
	LavHtjloSHfoVm1uYtJW+lSo0WsXGvqkbjfpmND3y4j05xgoaN+59XMqZvgKJVXESEWxAds0Vwg
	lNKr64g482trDq9LGRhKd/C62ot+jZpLI3LjjmQ2OM2c8uRo1kSczPp4fZrSF1h3BUXcJCXOIJd
	TiZhMlgqZ7zYh3SqNVzIBlb/kenHQq2Evcp5NrfVaU6XZisFtS1DLnOXSNnPIZ0Amk1hddQjdUa
	tGwTc79/gdyunZF8ihVKDh6oytegffWbFr03YcFDXqjjMMflCqr/U0VwS0Q5i/RoAjrhvcWVy9Q
	DA17A1G/3HoAvWwoxmJFVuDTh6nAEYjp2kMDsniIvar2mPHLYsqOhu6HaWFq3JL7u3y4oyg8C+9
	jwQJohtOg34JmervQNA5OoXPyW7OREmGJju6MjbMXEcQBWOUxCJNOk00mOVk5bVRuj9QleRwCiy
	mA=
X-Received: by 2002:a05:620a:170f:b0:8c5:24bf:21ff with SMTP id af79cd13be357-8c5301f3a3cmr42808885a.1.1768335740474;
        Tue, 13 Jan 2026 12:22:20 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c530b74bc4sm3181885a.32.2026.01.13.12.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 12:22:19 -0800 (PST)
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
Subject: [PATCH v2 3/3] cxl/core/region: move dax region driver logic into dax_region
Date: Tue, 13 Jan 2026 15:21:38 -0500
Message-ID: <20260113202138.3021093-3-gourry@gourry.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260113202138.3021093-1-gourry@gourry.net>
References: <20260113202138.3021093-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the dax region driver logic from region.c into dax_region.c

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/Makefile     |   1 +
 drivers/cxl/core/core.h       |   1 +
 drivers/cxl/core/dax_region.c | 106 ++++++++++++++++++++++++++++++++++
 drivers/cxl/core/region.c     |  99 -------------------------------
 4 files changed, 108 insertions(+), 99 deletions(-)
 create mode 100644 drivers/cxl/core/dax_region.c

diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index 23269c81fd44..36f284d7c500 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -17,6 +17,7 @@ cxl_core-y += cdat.o
 cxl_core-y += ras.o
 cxl_core-$(CONFIG_TRACING) += trace.o
 cxl_core-$(CONFIG_CXL_REGION) += region.o
+cxl_core-$(CONFIG_CXL_REGION) += dax_region.o
 cxl_core-$(CONFIG_CXL_REGION) += pmem_region.o
 cxl_core-$(CONFIG_CXL_MCE) += mce.o
 cxl_core-$(CONFIG_CXL_FEATURES) += features.o
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index cd589e81f55e..3ea850408814 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -42,6 +42,7 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port);
 struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa);
 u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 		   u64 dpa);
+int devm_cxl_add_dax_region(struct cxl_region *cxlr);
 int devm_cxl_add_pmem_region(struct cxl_region *cxlr);
 
 #else
diff --git a/drivers/cxl/core/dax_region.c b/drivers/cxl/core/dax_region.c
new file mode 100644
index 000000000000..d7c38447f816
--- /dev/null
+++ b/drivers/cxl/core/dax_region.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2022 Intel Corporation. All rights reserved. */
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
+	NULL,
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
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index a61805542b56..1ca5f5b02b22 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3239,105 +3239,6 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
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
 static int match_decoder_by_range(struct device *dev, const void *data)
 {
 	const struct range *r1, *r2 = data;
-- 
2.52.0

