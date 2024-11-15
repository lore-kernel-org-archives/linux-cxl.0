Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6AF1FB3E3
	for <linux-cxl@vger.kernel.org>; Fri, 15 Nov 2024 21:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731706080; cv=none; b=ey7uV5qn6J228owGtYTTLjbd8iYhbcOU8IEazmacavK0c6wJoJ4sYOTk/p6CgvZhfvsHLTZPofHSXcDBR0gSdXWCCrCs+JLvhggxgudmyYrdr8g1antWll9jM+VWNeTQmROWs3b5YPcaKVN0Bjs6o/1+FajqYSKWJTgCvPGTZ2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731706080; c=relaxed/simple;
	bh=WkeqDWUBilVzjwKPBgCZ1O1lmHPzg0T5Z+jxtS84B0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bNpevzbMGF3Sjr0WwSZldi4qhxvfsned9cbGA5J+MFNzCDLIiyA56NunEWwwqBv5IxtxnA9gzYmHu9vNXSB6Tl42hSCYIw+DpM/983HT4FCFKsJ+jJgkLEmcr86kklGBGvxNaDuLTSaGT62eCq57vbmaF9ogxCOpMy2ArFQKl0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84EC5C4CECF;
	Fri, 15 Nov 2024 21:27:59 +0000 (UTC)
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
Subject: [RFC PATCH v2 08/20] cxl: Move cxl_driver related bits to be usable by external drivers
Date: Fri, 15 Nov 2024 14:25:41 -0700
Message-ID: <20241115212745.869552-9-dave.jiang@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115212745.869552-1-dave.jiang@intel.com>
References: <20241115212745.869552-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the code related to cxl_driver to allow external drivers such as
cxl_fwctl to utilize the cxl_bus.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/cxl.h | 32 +-------------------------------
 include/cxl/cxl.h | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 31 deletions(-)
 create mode 100644 include/cxl/cxl.h

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 5406e3ab3d4a..18e78b2c3612 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -11,6 +11,7 @@
 #include <linux/log2.h>
 #include <linux/node.h>
 #include <linux/io.h>
+#include <cxl/cxl.h>
 
 extern const struct nvdimm_security_ops *cxl_security_ops;
 
@@ -819,37 +820,6 @@ bool is_cxl_region(struct device *dev);
 
 extern struct bus_type cxl_bus_type;
 
-struct cxl_driver {
-	const char *name;
-	int (*probe)(struct device *dev);
-	void (*remove)(struct device *dev);
-	struct device_driver drv;
-	int id;
-};
-
-#define to_cxl_drv(__drv)	container_of_const(__drv, struct cxl_driver, drv)
-
-int __cxl_driver_register(struct cxl_driver *cxl_drv, struct module *owner,
-			  const char *modname);
-#define cxl_driver_register(x) __cxl_driver_register(x, THIS_MODULE, KBUILD_MODNAME)
-void cxl_driver_unregister(struct cxl_driver *cxl_drv);
-
-#define module_cxl_driver(__cxl_driver) \
-	module_driver(__cxl_driver, cxl_driver_register, cxl_driver_unregister)
-
-#define CXL_DEVICE_NVDIMM_BRIDGE	1
-#define CXL_DEVICE_NVDIMM		2
-#define CXL_DEVICE_PORT			3
-#define CXL_DEVICE_ROOT			4
-#define CXL_DEVICE_MEMORY_EXPANDER	5
-#define CXL_DEVICE_REGION		6
-#define CXL_DEVICE_PMEM_REGION		7
-#define CXL_DEVICE_DAX_REGION		8
-#define CXL_DEVICE_PMU			9
-
-#define MODULE_ALIAS_CXL(type) MODULE_ALIAS("cxl:t" __stringify(type) "*")
-#define CXL_MODALIAS_FMT "cxl:t%d"
-
 struct cxl_nvdimm_bridge *to_cxl_nvdimm_bridge(struct device *dev);
 struct cxl_nvdimm_bridge *devm_cxl_add_nvdimm_bridge(struct device *host,
 						     struct cxl_port *port);
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
new file mode 100644
index 000000000000..07a2983275a0
--- /dev/null
+++ b/include/cxl/cxl.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2024 Intel Corporation. */
+#ifndef __CXL_GLOBAL_H__
+#define __CXL_GLOBAL_H__
+
+struct cxl_driver {
+	const char *name;
+	int (*probe)(struct device *dev);
+	void (*remove)(struct device *dev);
+	struct device_driver drv;
+	int id;
+};
+
+#define to_cxl_drv(__drv)      container_of_const(__drv, struct cxl_driver, drv)
+
+int __cxl_driver_register(struct cxl_driver *cxl_drv, struct module *owner,
+			  const char *modname);
+#define cxl_driver_register(x) __cxl_driver_register(x, THIS_MODULE, KBUILD_MODNAME)
+void cxl_driver_unregister(struct cxl_driver *cxl_drv);
+
+#define module_cxl_driver(__cxl_driver) \
+	module_driver(__cxl_driver, cxl_driver_register, cxl_driver_unregister)
+
+#define CXL_DEVICE_NVDIMM_BRIDGE	1
+#define CXL_DEVICE_NVDIMM		2
+#define CXL_DEVICE_PORT			3
+#define CXL_DEVICE_ROOT			4
+#define CXL_DEVICE_MEMORY_EXPANDER	5
+#define CXL_DEVICE_REGION		6
+#define CXL_DEVICE_PMEM_REGION		7
+#define CXL_DEVICE_DAX_REGION		8
+#define CXL_DEVICE_PMU			9
+
+#define MODULE_ALIAS_CXL(type) MODULE_ALIAS("cxl:t" __stringify(type) "*")
+#define CXL_MODALIAS_FMT "cxl:t%d"
+
+#endif
-- 
2.47.0

