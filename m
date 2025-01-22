Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983F31CAA98
	for <linux-cxl@vger.kernel.org>; Wed, 22 Jan 2025 23:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737589925; cv=none; b=XHJYE6bSxVjBiBjlU+VdOk/4h2DxfZtGPNHpVRYlpvQP3/KE+l/hHqblxD5v5nLjf0aWB3uPzBkd+7ewzb9GQZN/tbnColqCW3+OidSxhSyrW0h4MdsfuEVvwnfuVfDIHZZO0Npo8Tt0J2Afqviicu2J2VYjYeqWXL0rLZIUR/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737589925; c=relaxed/simple;
	bh=EV39FRmte87bFtxXj+S/b5LWCv8dzhXqKmB+NThGIdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qBVgCrY4GpfqwcOlc3N6xr6me560v9R7t6oNKa6XndREUGa9Rw05t1Ojfib0O15tzom5JQWNJ9hpsSOc9mnALQQw5e4Kly4sdEaCAU7fTUTYUy2JQRsXA7uWWcAI6lKNfXMABdpfntVyvEbNiOkKAc86gxuB21eDiY13mF6uqqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E37F9C4CEE4;
	Wed, 22 Jan 2025 23:52:04 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net,
	jgg@nvidia.com,
	shiju.jose@huawei.com
Subject: [PATCH v1 02/19] cxl: Add skeletal features driver
Date: Wed, 22 Jan 2025 16:50:33 -0700
Message-ID: <20250122235159.2716036-3-dave.jiang@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250122235159.2716036-1-dave.jiang@intel.com>
References: <20250122235159.2716036-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the basic bits of a features driver to handle all CXL feature related
services. The driver is expected to handle all CXL mailbox feature command
related operations.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/Kconfig                   | 11 +++++
 drivers/cxl/Makefile                  |  3 ++
 drivers/cxl/core/Makefile             |  1 +
 drivers/cxl/core/core.h               |  1 +
 drivers/cxl/core/features.c           | 71 +++++++++++++++++++++++++++
 drivers/cxl/core/port.c               |  3 ++
 drivers/cxl/cxl.h                     |  1 +
 drivers/cxl/features.c                | 44 +++++++++++++++++
 drivers/cxl/pci.c                     | 19 +++++++
 include/cxl/features.h                | 23 +++++++++
 include/cxl/mailbox.h                 |  3 ++
 tools/testing/cxl/Kbuild              |  7 +++
 tools/testing/cxl/cxl_features_test.c |  6 +++
 13 files changed, 193 insertions(+)
 create mode 100644 drivers/cxl/core/features.c
 create mode 100644 drivers/cxl/features.c
 create mode 100644 include/cxl/features.h
 create mode 100644 tools/testing/cxl/cxl_features_test.c

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 876469e23f7a..9a6ffd81ac0e 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -146,4 +146,15 @@ config CXL_REGION_INVALIDATION_TEST
 	  If unsure, or if this kernel is meant for production environments,
 	  say N.
 
+config CXL_FEATURES
+	tristate "CXL: Features support"
+	default CXL_BUS
+	help
+	  Enable CXL features support that are tied to a CXL mailbox.
+	  The support for features including the feature mailbox
+	  commands and also FWCTL support of the commands via user
+	  space.
+
+	  If unsure say 'y'.
+
 endif
diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
index 2caa90fa4bf2..4696fc218df4 100644
--- a/drivers/cxl/Makefile
+++ b/drivers/cxl/Makefile
@@ -7,15 +7,18 @@
 # - 'mem' and 'pmem' before endpoint drivers so that memdevs are
 #   immediately enabled
 # - 'pci' last, also mirrors the hardware enumeration hierarchy
+# - 'features' comes after pci device is enumerated
 obj-y += core/
 obj-$(CONFIG_CXL_PORT) += cxl_port.o
 obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
 obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
 obj-$(CONFIG_CXL_MEM) += cxl_mem.o
 obj-$(CONFIG_CXL_PCI) += cxl_pci.o
+obj-$(CONFIG_CXL_FEATURES) += cxl_features.o
 
 cxl_port-y := port.o
 cxl_acpi-y := acpi.o
 cxl_pmem-y := pmem.o security.o
 cxl_mem-y := mem.o
 cxl_pci-y := pci.o
+cxl_features-y := features.o
diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index 9259bcc6773c..73b6348afd67 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -14,5 +14,6 @@ cxl_core-y += pci.o
 cxl_core-y += hdm.o
 cxl_core-y += pmu.o
 cxl_core-y += cdat.o
+cxl_core-y += features.o
 cxl_core-$(CONFIG_TRACING) += trace.o
 cxl_core-$(CONFIG_CXL_REGION) += region.o
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 23761340e65c..e8a3df226643 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -9,6 +9,7 @@
 extern const struct device_type cxl_nvdimm_bridge_type;
 extern const struct device_type cxl_nvdimm_type;
 extern const struct device_type cxl_pmu_type;
+extern const struct device_type cxl_features_type;
 
 extern struct attribute_group cxl_base_attribute_group;
 
diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
new file mode 100644
index 000000000000..eb6eb191a32e
--- /dev/null
+++ b/drivers/cxl/core/features.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2024-2025 Intel Corporation. All rights reserved. */
+#include <linux/device.h>
+#include "cxl.h"
+#include "core.h"
+
+#define CXL_FEATURE_MAX_DEVS 65536
+static DEFINE_IDA(cxl_features_ida);
+
+static void cxl_features_release(struct device *dev)
+{
+	struct cxl_features *features = to_cxl_features(dev);
+
+	ida_free(&cxl_features_ida, features->id);
+	kfree(features);
+}
+
+static void remove_features_dev(void *dev)
+{
+	device_unregister(dev);
+}
+
+const struct device_type cxl_features_type = {
+	.name = "features",
+	.release = cxl_features_release,
+};
+EXPORT_SYMBOL_NS_GPL(cxl_features_type, "CXL");
+
+struct cxl_features *cxl_features_alloc(struct cxl_mailbox *cxl_mbox,
+					struct device *parent)
+{
+	struct device *dev;
+	int rc;
+
+	struct cxl_features *features __free(kfree) =
+		kzalloc(sizeof(*features), GFP_KERNEL);
+	if (!features)
+		return ERR_PTR(-ENOMEM);
+
+	rc = ida_alloc_max(&cxl_features_ida, CXL_FEATURE_MAX_DEVS - 1,
+			   GFP_KERNEL);
+	if (rc < 0)
+		return ERR_PTR(rc);
+
+	features->id = rc;
+	features->cxl_mbox = cxl_mbox;
+	dev = &features->dev;
+	device_initialize(dev);
+	device_set_pm_not_required(dev);
+	dev->parent = parent;
+	dev->bus = &cxl_bus_type;
+	dev->type = &cxl_features_type;
+	rc = dev_set_name(dev, "features%d", features->id);
+	if (rc)
+		goto err;
+
+	rc = device_add(dev);
+	if (rc)
+		goto err;
+
+	rc = devm_add_action_or_reset(parent, remove_features_dev, dev);
+	if (rc)
+		goto err;
+
+	return no_free_ptr(features);
+
+err:
+	put_device(dev);
+	return ERR_PTR(rc);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_features_alloc, "CXL");
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 78a5c2c25982..cc53a597cae6 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -74,6 +74,9 @@ static int cxl_device_id(const struct device *dev)
 		return CXL_DEVICE_REGION;
 	if (dev->type == &cxl_pmu_type)
 		return CXL_DEVICE_PMU;
+	if (dev->type == &cxl_features_type)
+		return CXL_DEVICE_FEATURES;
+
 	return 0;
 }
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index f6015f24ad38..ee29d1a1c8df 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -855,6 +855,7 @@ void cxl_driver_unregister(struct cxl_driver *cxl_drv);
 #define CXL_DEVICE_PMEM_REGION		7
 #define CXL_DEVICE_DAX_REGION		8
 #define CXL_DEVICE_PMU			9
+#define CXL_DEVICE_FEATURES		10
 
 #define MODULE_ALIAS_CXL(type) MODULE_ALIAS("cxl:t" __stringify(type) "*")
 #define CXL_MODALIAS_FMT "cxl:t%d"
diff --git a/drivers/cxl/features.c b/drivers/cxl/features.c
new file mode 100644
index 000000000000..644add26975f
--- /dev/null
+++ b/drivers/cxl/features.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2024,2025 Intel Corporation. All rights reserved. */
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <cxl/features.h>
+
+#include "cxl.h"
+
+static int cxl_features_probe(struct device *dev)
+{
+	struct cxl_features *features = to_cxl_features(dev);
+	struct cxl_features_state *cfs __free(kfree) =
+		kzalloc(sizeof(*cfs), GFP_KERNEL);
+
+	if (!cfs)
+		return -ENOMEM;
+
+	cfs->features = features;
+	dev_set_drvdata(dev, no_free_ptr(cfs));
+
+	return 0;
+}
+
+static void cxl_features_remove(struct device *dev)
+{
+	struct cxl_features_state *cfs = dev_get_drvdata(dev);
+
+	kfree(cfs);
+}
+
+static struct cxl_driver cxl_features_driver = {
+	.name = "cxl_features",
+	.probe = cxl_features_probe,
+	.remove = cxl_features_remove,
+	.id = CXL_DEVICE_FEATURES,
+};
+
+module_cxl_driver(cxl_features_driver);
+
+MODULE_DESCRIPTION("CXL: Features");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("CXL");
+MODULE_ALIAS_CXL(CXL_DEVICE_FEATURES);
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 6d94ff4a4f1a..eb68dd3f8b21 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -386,6 +386,21 @@ static int cxl_pci_mbox_send(struct cxl_mailbox *cxl_mbox,
 	return rc;
 }
 
+static int cxl_pci_setup_features(struct cxl_memdev_state *mds)
+{
+	struct cxl_dev_state *cxlds = &mds->cxlds;
+	struct cxl_mailbox *cxl_mbox = &cxlds->cxl_mbox;
+	struct cxl_features *features;
+
+	features = cxl_features_alloc(cxl_mbox, cxlds->dev);
+	if (IS_ERR(features))
+		return PTR_ERR(features);
+
+	cxl_mbox->features = features;
+
+	return 0;
+}
+
 static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds, bool irq_avail)
 {
 	struct cxl_dev_state *cxlds = &mds->cxlds;
@@ -980,6 +995,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
+	rc = cxl_pci_setup_features(mds);
+	if (rc)
+		return rc;
+
 	rc = cxl_set_timestamp(mds);
 	if (rc)
 		return rc;
diff --git a/include/cxl/features.h b/include/cxl/features.h
new file mode 100644
index 000000000000..b92da1e92780
--- /dev/null
+++ b/include/cxl/features.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2024-2025 Intel Corporation. */
+#ifndef __CXL_FEATURES_H__
+#define __CXL_FEATURES_H__
+
+struct cxl_mailbox;
+
+struct cxl_features {
+	int id;
+	struct device dev;
+	struct cxl_mailbox *cxl_mbox;
+};
+#define to_cxl_features(dev) container_of(dev, struct cxl_features, dev)
+
+struct cxl_features_state {
+	struct cxl_features *features;
+	int num_features;
+};
+
+struct cxl_features *cxl_features_alloc(struct cxl_mailbox *cxl_mbox,
+					struct device *parent);
+
+#endif
diff --git a/include/cxl/mailbox.h b/include/cxl/mailbox.h
index cc894f07a435..6caab0d406ba 100644
--- a/include/cxl/mailbox.h
+++ b/include/cxl/mailbox.h
@@ -3,6 +3,7 @@
 #ifndef __CXL_MBOX_H__
 #define __CXL_MBOX_H__
 #include <linux/rcuwait.h>
+#include <cxl/features.h>
 #include <uapi/linux/cxl_mem.h>
 
 /**
@@ -50,6 +51,7 @@ struct cxl_mbox_cmd {
  *                (CXL 3.1 8.2.8.4.3 Mailbox Capabilities Register)
  * @mbox_mutex: mutex protects device mailbox and firmware
  * @mbox_wait: rcuwait for mailbox
+ * @features: pointer to cxl_features device
  * @mbox_send: @dev specific transport for transmitting mailbox commands
  */
 struct cxl_mailbox {
@@ -59,6 +61,7 @@ struct cxl_mailbox {
 	size_t payload_size;
 	struct mutex mbox_mutex; /* lock to protect mailbox context */
 	struct rcuwait mbox_wait;
+	struct cxl_features *features;
 	int (*mbox_send)(struct cxl_mailbox *cxl_mbox, struct cxl_mbox_cmd *cmd);
 };
 
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index b1256fee3567..8b62341bb5df 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -50,6 +50,12 @@ cxl_mem-y := $(CXL_SRC)/mem.o
 cxl_mem-y += config_check.o
 cxl_mem-y += cxl_mem_test.o
 
+obj-m += cxl_features.o
+
+cxl_features-y := $(CXL_SRC)/features.o
+cxl_features-y += config_check.o
+cxl_features-y += cxl_features_test.o
+
 obj-m += cxl_core.o
 
 cxl_core-y := $(CXL_CORE_SRC)/port.o
@@ -61,6 +67,7 @@ cxl_core-y += $(CXL_CORE_SRC)/pci.o
 cxl_core-y += $(CXL_CORE_SRC)/hdm.o
 cxl_core-y += $(CXL_CORE_SRC)/pmu.o
 cxl_core-y += $(CXL_CORE_SRC)/cdat.o
+cxl_core-y += $(CXL_CORE_SRC)/features.o
 cxl_core-$(CONFIG_TRACING) += $(CXL_CORE_SRC)/trace.o
 cxl_core-$(CONFIG_CXL_REGION) += $(CXL_CORE_SRC)/region.o
 cxl_core-y += config_check.o
diff --git a/tools/testing/cxl/cxl_features_test.c b/tools/testing/cxl/cxl_features_test.c
new file mode 100644
index 000000000000..b117977b5ab2
--- /dev/null
+++ b/tools/testing/cxl/cxl_features_test.c
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2025 Intel Corporation. All rights reserved. */
+
+#include "watermark.h"
+
+cxl_test_watermark(cxl_features);
-- 
2.47.1

