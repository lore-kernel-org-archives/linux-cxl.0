Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF5125A647
	for <linux-cxl@vger.kernel.org>; Tue, 24 Jun 2025 21:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750801168; cv=none; b=c68PCZ2BMDCHEkT4Xa8FzL2fI/DXh8FvQzC9B6VKmWI6RoPTWtPOFTPmXqKgA89D3gFh0iKox3NSuiVsDOXYu5VCuJk/Jvo1G0KKCB2Moq89wNWAe8tPS+9lSlE0twptfv61UwOUSmS10SUAEhbQVlFqHjQGva5I0leRajS2aw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750801168; c=relaxed/simple;
	bh=uDh0hwIFOqjxp1Z3eRnIXlBE4lsyX5Mx5QF9GI4b718=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U3cLPFbw2skhgjOsBlEHyoxAmZDUMNW9d7OCm4tO9cnGBxPSI39WMogHY1r07oUQxYIa06P00HZ6uEz72L6fx+rBnSBt36ThW3X6DScaKP9xzPvRQUclXJ9tvgrMX8UdCrGQncdszXvFQC06A7roIRR8kfa8sI1/XSiyS11zt54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65648C4CEE3;
	Tue, 24 Jun 2025 21:39:28 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	rrichter@amd.com
Subject: [PATCH v4 6/9] cxl/test: Add mock version of devm_cxl_add_dport_by_dev()
Date: Tue, 24 Jun 2025 14:39:13 -0700
Message-ID: <20250624213916.1665889-7-dave.jiang@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250624213916.1665889-1-dave.jiang@intel.com>
References: <20250624213916.1665889-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devm_cxl_add_dport_by_dev() outside of cxl_test is done through PCI
hierarchy. However with cxl_test, it needs to be done through the
platform device hierarchy. Add the mock function for
devm_cxl_add_dport_by_dev().

When cxl_core calls a cxl_core exported function and that function is
mocked by cxl_test, the call chain causes a circular dependency issue. Dan
provided a workaround to avoid this issue. Apply the method to changes from
the late dport allocation changes in order to enable cxl-test.

In cxl_core they are defined with "__" added in front of the function. A
macro is used to define the original function names for when non-test
version of the kernel is built. A bit of macros and typedefs are used to
allow mocking of those functions in cxl_test.

Co-developed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/core.h              |  2 -
 drivers/cxl/core/pci.c               |  7 ++--
 drivers/cxl/cxl.h                    | 19 +++++++++
 tools/testing/cxl/Kbuild             |  1 +
 tools/testing/cxl/cxl_core_exports.c | 12 ++++++
 tools/testing/cxl/exports.h          | 10 +++++
 tools/testing/cxl/test/cxl.c         | 59 ++++++++++++++++++++++++++++
 tools/testing/cxl/test/mock.c        | 23 +++++++++++
 tools/testing/cxl/test/mock.h        |  2 +
 9 files changed, 130 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/cxl/exports.h

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 8cfead6f3b08..29b61828a847 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -122,8 +122,6 @@ void cxl_ras_exit(void);
 int cxl_gpf_port_setup(struct cxl_dport *dport);
 int cxl_acpi_get_extended_linear_cache_size(struct resource *backing_res,
 					    int nid, resource_size_t *size);
-struct cxl_dport *devm_cxl_add_dport_by_dev(struct cxl_port *port,
-					    struct device *dport_dev);
 
 #ifdef CONFIG_CXL_FEATURES
 struct cxl_feat_entry *
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 6e9b5ab69de0..cf3cbd674b1c 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -25,14 +25,14 @@ module_param(media_ready_timeout, ushort, 0644);
 MODULE_PARM_DESC(media_ready_timeout, "seconds to wait for media ready");
 
 /**
- * devm_cxl_add_dport_by_dev - allocate a dport by dport device
+ * __devm_cxl_add_dport_by_dev - allocate a dport by dport device
  * @port: cxl_port that hosts the dport
  * @dport_dev: 'struct device' of the dport
  *
  * Returns the allocate dport on success or ERR_PTR() of -errno on error
  */
-struct cxl_dport *devm_cxl_add_dport_by_dev(struct cxl_port *port,
-					    struct device *dport_dev)
+struct cxl_dport *__devm_cxl_add_dport_by_dev(struct cxl_port *port,
+					      struct device *dport_dev)
 {
 	struct cxl_register_map map;
 	struct pci_dev *pdev;
@@ -61,6 +61,7 @@ struct cxl_dport *devm_cxl_add_dport_by_dev(struct cxl_port *port,
 	port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
 	return devm_cxl_add_dport(port, &pdev->dev, port_num, map.resource);
 }
+EXPORT_SYMBOL_NS_GPL(__devm_cxl_add_dport_by_dev, "CXL");
 
 struct cxl_walk_context {
 	struct pci_bus *bus;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 5f598fb542e5..a1596c9561a9 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -907,6 +907,10 @@ void cxl_coordinates_combine(struct access_coordinate *out,
 
 bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
 int cxl_port_get_total_dports(struct cxl_port *port);
+struct cxl_dport *devm_cxl_add_dport_by_dev(struct cxl_port *port,
+					    struct device *dport_dev);
+struct cxl_dport *__devm_cxl_add_dport_by_dev(struct cxl_port *port,
+					      struct device *dport_dev);
 
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version
@@ -928,4 +932,19 @@ static inline struct rw_semaphore *rwsem_read_intr_acquire(struct rw_semaphore *
 
 DEFINE_FREE(rwsem_read_release, struct rw_semaphore *, if (_T) up_read(_T))
 
+/*
+ * Declaration for functions that are mocked by cxl_test that are called by
+ * cxl_core. The respective functions are defined as __foo() and called by
+ * cxl_core as foo(). The macros below ensures that those functions would
+ * exist as foo(). See tools/testing/cxl/cxl_core_exports.c and
+ * tools/testing/cxl/exports.h for setting up the mock functions. The dance
+ * is done to avoid a circular dependency where cxl_core calls a function that
+ * ends up being a mock function and goes to * cxl_test where it calls a
+ * cxl_core function.
+ */
+#ifndef CXL_TEST_ENABLE
+#define DECLARE_TESTABLE(x) __##x
+#define devm_cxl_add_dport_by_dev DECLARE_TESTABLE(devm_cxl_add_dport_by_dev)
+#endif
+
 #endif /* __CXL_H__ */
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 1f05497c44e1..d77717645ac7 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -22,6 +22,7 @@ CXL_SRC := $(DRIVERS)/cxl
 CXL_CORE_SRC := $(DRIVERS)/cxl/core
 ccflags-y := -I$(srctree)/drivers/cxl/
 ccflags-y += -D__mock=__weak
+ccflags-y += -DCXL_TEST_ENABLE=1
 ccflags-y += -DTRACE_INCLUDE_PATH=$(CXL_CORE_SRC) -I$(srctree)/drivers/cxl/core/
 
 obj-m += cxl_acpi.o
diff --git a/tools/testing/cxl/cxl_core_exports.c b/tools/testing/cxl/cxl_core_exports.c
index f088792a8925..0d18abc1f5a3 100644
--- a/tools/testing/cxl/cxl_core_exports.c
+++ b/tools/testing/cxl/cxl_core_exports.c
@@ -2,6 +2,18 @@
 /* Copyright(c) 2022 Intel Corporation. All rights reserved. */
 
 #include "cxl.h"
+#include "exports.h"
 
 /* Exporting of cxl_core symbols that are only used by cxl_test */
 EXPORT_SYMBOL_NS_GPL(cxl_num_decoders_committed, "CXL");
+
+cxl_add_dport_by_dev_fn _devm_cxl_add_dport_by_dev =
+	__devm_cxl_add_dport_by_dev;
+EXPORT_SYMBOL_NS_GPL(_devm_cxl_add_dport_by_dev, "CXL");
+
+struct cxl_dport *devm_cxl_add_dport_by_dev(struct cxl_port *port,
+					    struct device *dport_dev)
+{
+	return _devm_cxl_add_dport_by_dev(port, dport_dev);
+}
+EXPORT_SYMBOL_NS_GPL(devm_cxl_add_dport_by_dev, "CXL");
diff --git a/tools/testing/cxl/exports.h b/tools/testing/cxl/exports.h
new file mode 100644
index 000000000000..9261ce6f1197
--- /dev/null
+++ b/tools/testing/cxl/exports.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2025 Intel Corporation */
+#ifndef __MOCK_CXL_EXPORTS_H_
+#define __MOCK_CXL_EXPORTS_H_
+
+typedef struct cxl_dport *(*cxl_add_dport_by_dev_fn)(struct cxl_port *port,
+							  struct device *dport_dev);
+extern cxl_add_dport_by_dev_fn _devm_cxl_add_dport_by_dev;
+
+#endif
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 5d6585d4b15e..b13f9796687c 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -1037,6 +1037,64 @@ static int mock_cxl_port_enumerate_dports(struct cxl_port *port)
 	return 0;
 }
 
+static struct cxl_dport *mock_cxl_add_dport_by_dev(struct cxl_port *port,
+						   struct device *dport_dev)
+{
+	struct platform_device **array;
+	int i, array_size;
+
+	if (port->depth == 1) {
+		if (is_multi_bridge(port->uport_dev)) {
+			array_size = ARRAY_SIZE(cxl_root_port);
+			array = cxl_root_port;
+		} else if (is_single_bridge(port->uport_dev)) {
+			array_size = ARRAY_SIZE(cxl_root_single);
+			array = cxl_root_single;
+		} else {
+			dev_dbg(&port->dev, "%s: unknown bridge type\n",
+				dev_name(port->uport_dev));
+			return ERR_PTR(-ENXIO);
+		}
+	} else if (port->depth == 2) {
+		struct cxl_port *parent = to_cxl_port(port->dev.parent);
+
+		if (is_multi_bridge(parent->uport_dev)) {
+			array_size = ARRAY_SIZE(cxl_switch_dport);
+			array = cxl_switch_dport;
+		} else if (is_single_bridge(parent->uport_dev)) {
+			array_size = ARRAY_SIZE(cxl_swd_single);
+			array = cxl_swd_single;
+		} else {
+			dev_dbg(&port->dev, "%s: unknown bridge type\n",
+				dev_name(port->uport_dev));
+			return ERR_PTR(-ENXIO);
+		}
+	} else {
+		dev_WARN_ONCE(&port->dev, 1, "unexpected depth %d\n",
+			      port->depth);
+		return ERR_PTR(-ENXIO);
+	}
+
+	for (i = 0; i < array_size; i++) {
+		struct platform_device *pdev = array[i];
+
+		if (pdev->dev.parent != port->uport_dev) {
+			dev_dbg(&port->dev, "%s: mismatch parent %s\n",
+				dev_name(port->uport_dev),
+				dev_name(pdev->dev.parent));
+			continue;
+		}
+
+		if (&pdev->dev != dport_dev)
+			continue;
+
+		return devm_cxl_add_dport(port, &pdev->dev, pdev->id,
+					  CXL_RESOURCE_NONE);
+	}
+
+	return ERR_PTR(-ENODEV);
+}
+
 /*
  * Faking the cxl_dpa_perf for the memdev when appropriate.
  */
@@ -1099,6 +1157,7 @@ static struct cxl_mock_ops cxl_mock_ops = {
 	.devm_cxl_add_passthrough_decoder = mock_cxl_add_passthrough_decoder,
 	.devm_cxl_enumerate_decoders = mock_cxl_enumerate_decoders,
 	.cxl_endpoint_parse_cdat = mock_cxl_endpoint_parse_cdat,
+	.devm_cxl_add_dport_by_dev = mock_cxl_add_dport_by_dev,
 	.list = LIST_HEAD_INIT(cxl_mock_ops.list),
 };
 
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index c92cc3a4f0b9..d9fdaaf311cd 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -10,12 +10,18 @@
 #include <cxlmem.h>
 #include <cxlpci.h>
 #include "mock.h"
+#include "../exports.h"
 
 static LIST_HEAD(mock);
 
+static struct cxl_dport *
+redirect_devm_cxl_add_dport_by_dev(struct cxl_port *port,
+				   struct device *dport_dev);
+
 void register_cxl_mock_ops(struct cxl_mock_ops *ops)
 {
 	list_add_rcu(&ops->list, &mock);
+	_devm_cxl_add_dport_by_dev = redirect_devm_cxl_add_dport_by_dev;
 }
 EXPORT_SYMBOL_GPL(register_cxl_mock_ops);
 
@@ -23,6 +29,7 @@ DEFINE_STATIC_SRCU(cxl_mock_srcu);
 
 void unregister_cxl_mock_ops(struct cxl_mock_ops *ops)
 {
+	_devm_cxl_add_dport_by_dev = __devm_cxl_add_dport_by_dev;
 	list_del_rcu(&ops->list);
 	synchronize_srcu(&cxl_mock_srcu);
 }
@@ -326,6 +333,22 @@ void __wrap_cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device
 }
 EXPORT_SYMBOL_NS_GPL(__wrap_cxl_dport_init_ras_reporting, "CXL");
 
+struct cxl_dport *redirect_devm_cxl_add_dport_by_dev(struct cxl_port *port,
+						     struct device *dport_dev)
+{
+	int index;
+	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
+	struct cxl_dport *dport;
+
+	if (ops && ops->is_mock_port(port->uport_dev))
+		dport = ops->devm_cxl_add_dport_by_dev(port, dport_dev);
+	else
+		dport = devm_cxl_add_dport_by_dev(port, dport_dev);
+	put_cxl_mock_ops(index);
+
+	return dport;
+}
+
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("cxl_test: emulation module");
 MODULE_IMPORT_NS("ACPI");
diff --git a/tools/testing/cxl/test/mock.h b/tools/testing/cxl/test/mock.h
index 9f9685d0f00c..60aa7ea5a0f3 100644
--- a/tools/testing/cxl/test/mock.h
+++ b/tools/testing/cxl/test/mock.h
@@ -27,6 +27,8 @@ struct cxl_mock_ops {
 	int (*devm_cxl_enumerate_decoders)(
 		struct cxl_hdm *hdm, struct cxl_endpoint_dvsec_info *info);
 	void (*cxl_endpoint_parse_cdat)(struct cxl_port *port);
+	struct cxl_dport *(*devm_cxl_add_dport_by_dev)(
+		struct cxl_port *port, struct device *dport_dev);
 };
 
 void register_cxl_mock_ops(struct cxl_mock_ops *ops);
-- 
2.49.0

