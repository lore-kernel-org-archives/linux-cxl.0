Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F053C2FF661
	for <linux-cxl@vger.kernel.org>; Wed, 11 Feb 2026 23:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770852399; cv=none; b=V+xmclvX7pa53vhVW/8y17O4ddf2EVV6tN3dzDUUjSCjzdCgOjSKaihrAbK0UP9QlYxC5PG/QWCKSDJBCQQ8eydIPTKuDxz6KH6TEdcFxZ1CK6VAnsc7MZkvE2cwkMn0frsaUFtd5+C6TFTaGZZIsEs35HzhRyP+RZ5FxT9MYaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770852399; c=relaxed/simple;
	bh=GMhsqgtHzrxMSAIWy3adgRTZpGCjAESw/sL/uL9q+hU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U+nVL8Ccbo2tlrr06mooKQoKwpkSMPTHEM3DCVU59V5qHEwLpHPsbQ/V9dVllSytr3V5B+i7qE/63tOylre0fYDZBMoXYdq2Hbc0IhQraKMA9xYYz5u2AN2qWfCFyok7KPTaabDeMBaGAQV2yWmsjfx6Rr1nZVlqI9R7Bat9quA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 787D0C4CEF7;
	Wed, 11 Feb 2026 23:26:38 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: [PATCH v2 1/3] cxl: Move devm_cxl_add_nvdimm_bridge() to cxl_pmem.ko
Date: Wed, 11 Feb 2026 16:26:28 -0700
Message-ID: <20260211232630.480509-2-dave.jiang@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260211232630.480509-1-dave.jiang@intel.com>
References: <20260211232630.480509-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Moving devm_cxl_add_nvdimm_bridge() and related functions to
drivers/cxl/cxl_pmem.c, so that cxl_pmem can export a symbol that gives
cxl_acpi a depedency on cxl_pmem kernel module. This is a prepatory patch
to resolve the issue of a race for nvdimm_bus object that is created
during cxl_acpi_probe().

No functional changes besides moving code.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/core.h |  1 -
 drivers/cxl/core/pmem.c | 86 ++---------------------------------------
 drivers/cxl/cxl.h       |  1 +
 drivers/cxl/pmem.c      | 84 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 88 insertions(+), 84 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 007b8aff0238..8ee0c3bb2065 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -7,7 +7,6 @@
 #include <cxl/mailbox.h>
 #include <linux/rwsem.h>
 
-extern const struct device_type cxl_nvdimm_bridge_type;
 extern const struct device_type cxl_nvdimm_type;
 extern const struct device_type cxl_pmu_type;
 
diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
index e7b1e6fa0ea0..50557d71a45f 100644
--- a/drivers/cxl/core/pmem.c
+++ b/drivers/cxl/core/pmem.c
@@ -21,7 +21,8 @@
  * operations, for example, namespace label access commands.
  */
 
-static DEFINE_IDA(cxl_nvdimm_bridge_ida);
+DEFINE_IDA(cxl_nvdimm_bridge_ida);
+EXPORT_SYMBOL_NS_GPL(cxl_nvdimm_bridge_ida, "CXL");
 
 static void cxl_nvdimm_bridge_release(struct device *dev)
 {
@@ -41,6 +42,7 @@ const struct device_type cxl_nvdimm_bridge_type = {
 	.release = cxl_nvdimm_bridge_release,
 	.groups = cxl_nvdimm_bridge_attribute_groups,
 };
+EXPORT_SYMBOL_NS_GPL(cxl_nvdimm_bridge_type, "CXL");
 
 struct cxl_nvdimm_bridge *to_cxl_nvdimm_bridge(struct device *dev)
 {
@@ -75,88 +77,6 @@ struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_find_nvdimm_bridge, "CXL");
 
-static struct lock_class_key cxl_nvdimm_bridge_key;
-
-static struct cxl_nvdimm_bridge *cxl_nvdimm_bridge_alloc(struct cxl_port *port)
-{
-	struct cxl_nvdimm_bridge *cxl_nvb;
-	struct device *dev;
-	int rc;
-
-	cxl_nvb = kzalloc(sizeof(*cxl_nvb), GFP_KERNEL);
-	if (!cxl_nvb)
-		return ERR_PTR(-ENOMEM);
-
-	rc = ida_alloc(&cxl_nvdimm_bridge_ida, GFP_KERNEL);
-	if (rc < 0)
-		goto err;
-	cxl_nvb->id = rc;
-
-	dev = &cxl_nvb->dev;
-	cxl_nvb->port = port;
-	device_initialize(dev);
-	lockdep_set_class(&dev->mutex, &cxl_nvdimm_bridge_key);
-	device_set_pm_not_required(dev);
-	dev->parent = &port->dev;
-	dev->bus = &cxl_bus_type;
-	dev->type = &cxl_nvdimm_bridge_type;
-
-	return cxl_nvb;
-
-err:
-	kfree(cxl_nvb);
-	return ERR_PTR(rc);
-}
-
-static void unregister_nvb(void *_cxl_nvb)
-{
-	struct cxl_nvdimm_bridge *cxl_nvb = _cxl_nvb;
-
-	device_unregister(&cxl_nvb->dev);
-}
-
-/**
- * devm_cxl_add_nvdimm_bridge() - add the root of a LIBNVDIMM topology
- * @host: platform firmware root device
- * @port: CXL port at the root of a CXL topology
- *
- * Return: bridge device that can host cxl_nvdimm objects
- */
-struct cxl_nvdimm_bridge *devm_cxl_add_nvdimm_bridge(struct device *host,
-						     struct cxl_port *port)
-{
-	struct cxl_nvdimm_bridge *cxl_nvb;
-	struct device *dev;
-	int rc;
-
-	if (!IS_ENABLED(CONFIG_CXL_PMEM))
-		return ERR_PTR(-ENXIO);
-
-	cxl_nvb = cxl_nvdimm_bridge_alloc(port);
-	if (IS_ERR(cxl_nvb))
-		return cxl_nvb;
-
-	dev = &cxl_nvb->dev;
-	rc = dev_set_name(dev, "nvdimm-bridge%d", cxl_nvb->id);
-	if (rc)
-		goto err;
-
-	rc = device_add(dev);
-	if (rc)
-		goto err;
-
-	rc = devm_add_action_or_reset(host, unregister_nvb, cxl_nvb);
-	if (rc)
-		return ERR_PTR(rc);
-
-	return cxl_nvb;
-
-err:
-	put_device(dev);
-	return ERR_PTR(rc);
-}
-EXPORT_SYMBOL_NS_GPL(devm_cxl_add_nvdimm_bridge, "CXL");
-
 static void cxl_nvdimm_release(struct device *dev)
 {
 	struct cxl_nvdimm *cxl_nvd = to_cxl_nvdimm(dev);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 04c673e7cdb0..3b79d5c4765a 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -877,6 +877,7 @@ int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
 bool is_cxl_region(struct device *dev);
 
 extern const struct bus_type cxl_bus_type;
+extern const struct device_type cxl_nvdimm_bridge_type;
 
 /*
  * Note, add_dport() is expressly for the cxl_port driver. TODO: investigate a
diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
index e197883690ef..6f010b3cce44 100644
--- a/drivers/cxl/pmem.c
+++ b/drivers/cxl/pmem.c
@@ -13,6 +13,90 @@
 
 static __read_mostly DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
 
+extern struct ida cxl_nvdimm_bridge_ida;
+
+static struct lock_class_key cxl_nvdimm_bridge_key;
+
+static struct cxl_nvdimm_bridge *cxl_nvdimm_bridge_alloc(struct cxl_port *port)
+{
+	struct cxl_nvdimm_bridge *cxl_nvb;
+	struct device *dev;
+	int rc;
+
+	cxl_nvb = kzalloc(sizeof(*cxl_nvb), GFP_KERNEL);
+	if (!cxl_nvb)
+		return ERR_PTR(-ENOMEM);
+
+	rc = ida_alloc(&cxl_nvdimm_bridge_ida, GFP_KERNEL);
+	if (rc < 0)
+		goto err;
+	cxl_nvb->id = rc;
+
+	dev = &cxl_nvb->dev;
+	cxl_nvb->port = port;
+	device_initialize(dev);
+	lockdep_set_class(&dev->mutex, &cxl_nvdimm_bridge_key);
+	device_set_pm_not_required(dev);
+	dev->parent = &port->dev;
+	dev->bus = &cxl_bus_type;
+	dev->type = &cxl_nvdimm_bridge_type;
+
+	return cxl_nvb;
+
+err:
+	kfree(cxl_nvb);
+	return ERR_PTR(rc);
+}
+
+static void unregister_nvb(void *_cxl_nvb)
+{
+	struct cxl_nvdimm_bridge *cxl_nvb = _cxl_nvb;
+
+	device_unregister(&cxl_nvb->dev);
+}
+
+/**
+ * devm_cxl_add_nvdimm_bridge() - add the root of a LIBNVDIMM topology
+ * @host: platform firmware root device
+ * @port: CXL port at the root of a CXL topology
+ *
+ * Return: bridge device that can host cxl_nvdimm objects
+ */
+struct cxl_nvdimm_bridge *devm_cxl_add_nvdimm_bridge(struct device *host,
+						     struct cxl_port *port)
+{
+	struct cxl_nvdimm_bridge *cxl_nvb;
+	struct device *dev;
+	int rc;
+
+	if (!IS_ENABLED(CONFIG_CXL_PMEM))
+		return ERR_PTR(-ENXIO);
+
+	cxl_nvb = cxl_nvdimm_bridge_alloc(port);
+	if (IS_ERR(cxl_nvb))
+		return cxl_nvb;
+
+	dev = &cxl_nvb->dev;
+	rc = dev_set_name(dev, "nvdimm-bridge%d", cxl_nvb->id);
+	if (rc)
+		goto err;
+
+	rc = device_add(dev);
+	if (rc)
+		goto err;
+
+	rc = devm_add_action_or_reset(host, unregister_nvb, cxl_nvb);
+	if (rc)
+		return ERR_PTR(rc);
+
+	return cxl_nvb;
+
+err:
+	put_device(dev);
+	return ERR_PTR(rc);
+}
+EXPORT_SYMBOL_NS_GPL(devm_cxl_add_nvdimm_bridge, "CXL");
+
 static void clear_exclusive(void *mds)
 {
 	clear_exclusive_cxl_commands(mds, exclusive_cmds);
-- 
2.52.0

