Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A008EC001DB
	for <linux-cxl@archiver.kernel.org>; Fri,  4 Aug 2023 11:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjHDL4U (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 4 Aug 2023 07:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHDL4U (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 4 Aug 2023 07:56:20 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79CFB1
        for <linux-cxl@vger.kernel.org>; Fri,  4 Aug 2023 04:56:17 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RHPGp4V8Gz6J6jn;
        Fri,  4 Aug 2023 19:52:50 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 12:56:15 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-cxl@vger.kernel.org>
CC:     Dan Williams <dan.j.williams@intel.com>, <linuxarm@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>,
        Gregory Price <gregory.price@memverge.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH v5 4/4] cxl/pci: Add support for stand alone CXL Switch mailbox CCI
Date:   Fri, 4 Aug 2023 12:54:14 +0100
Message-ID: <20230804115414.14391-5-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230804115414.14391-1-Jonathan.Cameron@huawei.com>
References: <20230804115414.14391-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

CXL 3.0 defines a mailbox PCI function independent of any other CXL
components. The intent is that instances of this mailbox will be found
as additional PCI functions of upstream CXL switch ports.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v5: Fully break the connection between cxlmem and cxlswd by moving
a bunch of stuff into cxlmbox.h and dropping shared use of cxl_dev_state.
This leaves a few ugly corners that we may elect to live with - e.g.
  Status register - used to see if the mbox is active, but also
  for a bunch of other things in CXL memory devices.  To make it
   available for both usecases without mapping it twice, we need the
   mbox register mapping to only optionally map it and in the case
   where it already is mapped we have to stitch up the lack of
   an address after setting up the Mbox registers masp.

Rename files etc as per Dan's comment on v1 that I'd missed.
Also share the CDEV space, ida etc.

Care needed with races in release path. I think a simple dying
flag is enough here, but if people can take a look that would be great.
---
 drivers/cxl/Kconfig          |  14 +++
 drivers/cxl/Makefile         |   2 +
 drivers/cxl/core/Makefile    |   1 +
 drivers/cxl/core/core.h      |   9 ++
 drivers/cxl/core/mbox.c      |   5 ++
 drivers/cxl/core/memdev.c    |  12 +--
 drivers/cxl/core/regs.c      |   6 +-
 drivers/cxl/core/switchdev.c | 129 ++++++++++++++++++++++++++
 drivers/cxl/cxl.h            |   2 +-
 drivers/cxl/cxlmbox.h        |   4 +
 drivers/cxl/pci.c            |   7 +-
 drivers/cxl/switch.h         |  19 ++++
 drivers/cxl/switchdev.c      | 170 +++++++++++++++++++++++++++++++++++
 include/uapi/linux/cxl_mem.h |   4 +
 14 files changed, 371 insertions(+), 13 deletions(-)

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 8ea1d340e438..2acf4073febc 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -153,5 +153,19 @@ config CXL_PMU
 	  Say 'y/m' to enable a driver that will attach to performance
 	  monitoring units and provide standard perf based interfaces.
 
+	  If unsure say 'm'.
+
+config CXL_SWITCH
+	tristate "CXL switch mailbox access"
+	help
+	  The CXL r3.0 specification defines a "CXL switch CCI" sub-class in the
+	  PCI "Serial" base class of devices. Device's identified by
+	  this class code provide a mailbox interface to allow control of CXL
+	  switch configuration over inband PCI.
+
+	  Say 'y/m' to enable a driver that will attach to CXL Switch CCI
+	  devices enumerated by the CXL switch CCI class code for configuration
+	  and management primarily via the mailbox interface.
+
 	  If unsure say 'm'.
 endif
diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
index db321f48ba52..b98babe05abf 100644
--- a/drivers/cxl/Makefile
+++ b/drivers/cxl/Makefile
@@ -5,9 +5,11 @@ obj-$(CONFIG_CXL_MEM) += cxl_mem.o
 obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
 obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
 obj-$(CONFIG_CXL_PORT) += cxl_port.o
+obj-$(CONFIG_CXL_SWITCH) += cxl_switchdev.o
 
 cxl_mem-y := mem.o
 cxl_pci-y := pci.o
 cxl_acpi-y := acpi.o
 cxl_pmem-y := pmem.o security.o
 cxl_port-y := port.o
+cxl_switchdev-y := switchdev.o
diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index 1f66b5d4d935..562aa63d225f 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -13,5 +13,6 @@ cxl_core-y += mbox.o
 cxl_core-y += pci.o
 cxl_core-y += hdm.o
 cxl_core-y += pmu.o
+cxl_core-y += switchdev.o
 cxl_core-$(CONFIG_TRACING) += trace.o
 cxl_core-$(CONFIG_CXL_REGION) += region.o
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 5491d3a3c095..676b63193080 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -87,4 +87,13 @@ enum cxl_poison_trace_type {
 	CXL_POISON_TRACE_CLEAR,
 };
 
+/*
+ * An entire PCI topology full of devices should be enough for any
+ * config
+ */
+#define CXL_MEM_MAX_DEVS 65536
+
+extern int cxl_mem_major;
+extern struct ida cxl_memdev_ida;
+extern struct rw_semaphore cxl_memdev_rwsem;
 #endif /* __CXL_CORE_H__ */
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index f279efb763ff..89a3f050e0f8 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -9,6 +9,7 @@
 #include <cxlmbox.h>
 #include <cxlpci.h>
 #include <cxlmem.h>
+#include <cxlpci.h>
 #include <cxl.h>
 
 #include "core.h"
@@ -56,6 +57,7 @@ static bool cxl_raw_allow_all;
  * 0, and the user passed in 1, it is an error.
  */
 static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
+	CXL_CMD(INFO_STAT_IDENTIFY, 0, 0x12, 0),
 	CXL_CMD(IDENTIFY, 0, 0x43, CXL_CMD_FLAG_FORCE_ENABLE),
 #ifdef CONFIG_CXL_MEM_RAW_COMMANDS
 	CXL_CMD(RAW, CXL_VARIABLE_PAYLOAD, CXL_VARIABLE_PAYLOAD, 0),
@@ -73,6 +75,9 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
 	CXL_CMD(GET_SHUTDOWN_STATE, 0, 0x1, 0),
 	CXL_CMD(SET_SHUTDOWN_STATE, 0x1, 0, 0),
 	CXL_CMD(GET_SCAN_MEDIA_CAPS, 0x10, 0x4, 0),
+	CXL_CMD(IDENTIFY_SWITCH_DEVICE, 0, 0x49, 0),
+	CXL_CMD(TUNNEL_MANAGEMENT_COMMAND, CXL_VARIABLE_PAYLOAD,
+		CXL_VARIABLE_PAYLOAD, 0),
 };
 
 /*
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 15b540bec6fa..b233d6016c55 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -11,16 +11,10 @@
 #include "trace.h"
 #include "core.h"
 
-static DECLARE_RWSEM(cxl_memdev_rwsem);
+DECLARE_RWSEM(cxl_memdev_rwsem);
 
-/*
- * An entire PCI topology full of devices should be enough for any
- * config
- */
-#define CXL_MEM_MAX_DEVS 65536
-
-static int cxl_mem_major;
-static DEFINE_IDA(cxl_memdev_ida);
+int cxl_mem_major;
+DEFINE_IDA(cxl_memdev_ida);
 
 static void cxl_memdev_release(struct device *dev)
 {
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index b783bf89d687..aeb97daaf9ee 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -268,7 +268,7 @@ int cxl_map_device_regs(const struct cxl_register_map *map,
 EXPORT_SYMBOL_NS_GPL(cxl_map_device_regs, CXL);
 
 int cxl_map_mbox_regs(const struct cxl_register_map *map,
-		      void __iomem **mbox_regs)
+		      void __iomem **mbox_regs, void __iomem **status_regs)
 {
 	struct device *dev = map->dev;
 	resource_size_t phys_addr = map->resource;
@@ -277,10 +277,12 @@ int cxl_map_mbox_regs(const struct cxl_register_map *map,
 		void __iomem **addr;
 	} mapinfo[] = {
 		{ &map->device_map.mbox, mbox_regs, },
+		{ &map->device_map.status, status_regs, },
 	};
+	int limit = status_regs ? ARRAY_SIZE(mapinfo) : 1;
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(mapinfo); i++) {
+	for (i = 0; i < limit; i++) {
 		struct mapinfo *mi = &mapinfo[i];
 		resource_size_t length;
 		resource_size_t addr;
diff --git a/drivers/cxl/core/switchdev.c b/drivers/cxl/core/switchdev.c
new file mode 100644
index 000000000000..72f6b81357d9
--- /dev/null
+++ b/drivers/cxl/core/switchdev.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include "cxlpci.h"
+#include "switch.h"
+#include "core.h"
+
+static inline struct cxl_swdev *to_cxl_swdev(struct device *dev)
+{
+	return container_of(dev, struct cxl_swdev, dev);
+}
+
+static char *cxl_swdev_devnode(const struct device *dev, umode_t *mode, kuid_t *uid,
+			kgid_t *gid)
+{
+	return kasprintf(GFP_KERNEL, "cxl/%s", dev_name(dev));
+}
+
+static long __cxl_swdev_ioctl(struct cxl_swdev *cxlswd, unsigned int cmd,
+			       unsigned long arg)
+{
+	switch (cmd) {
+	case CXL_MEM_SEND_COMMAND:
+		return cxl_send_cmd(&cxlswd->mbox, (void __user *)arg);
+	default:
+		return -ENOTTY;
+	}
+}
+
+static long cxl_swdev_ioctl(struct file *file, unsigned int cmd,
+			    unsigned long arg)
+{
+	struct cxl_swdev *cxlswd = file->private_data;
+	int rc = -ENXIO;
+
+	down_read(&cxl_memdev_rwsem);
+	if (!cxlswd->dying)
+		rc = __cxl_swdev_ioctl(cxlswd, cmd, arg);
+	up_read(&cxl_memdev_rwsem);
+
+	return rc;
+}
+
+static int cxl_swdev_open(struct inode *inode, struct file *file)
+{
+	struct cxl_swdev *cxlswd =
+		container_of(inode->i_cdev, typeof(*cxlswd), cdev);
+
+	get_device(&cxlswd->dev);
+	file->private_data = cxlswd;
+
+	return 0;
+}
+
+static int cxl_swdev_release_file(struct inode *inode, struct file *file)
+{
+	struct cxl_swdev *cxlswd =
+		container_of(inode->i_cdev, typeof(*cxlswd), cdev);
+
+	put_device(&cxlswd->dev);
+
+	return 0;
+}
+
+static const struct file_operations cxl_swdev_fops = {
+	.owner = THIS_MODULE,
+	.unlocked_ioctl = cxl_swdev_ioctl,
+	.open = cxl_swdev_open,
+	.release = cxl_swdev_release_file,
+	.compat_ioctl = compat_ptr_ioctl,
+	.llseek = noop_llseek,
+};
+
+void cxl_swdev_shutdown(struct cxl_swdev *cxlswd)
+{
+	down_write(&cxl_memdev_rwsem);
+	cxlswd->dying = true;
+	up_write(&cxl_memdev_rwsem);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_swdev_shutdown, CXL);
+
+static void cxl_swdev_release(struct device *dev)
+{
+	struct cxl_swdev *cxlswd = to_cxl_swdev(dev);
+
+	ida_free(&cxl_memdev_ida, cxlswd->id);
+	kfree(cxlswd);
+}
+
+static const struct device_type cxl_swdev_type = {
+	.name = "cxl_swdev",
+	.release = cxl_swdev_release,
+	.devnode = cxl_swdev_devnode,
+};
+
+struct cxl_swdev *cxl_swdev_alloc(struct device *parent)
+{
+	struct cxl_swdev *cxlswd;
+	struct device *dev;
+	struct cdev *cdev;
+	int rc;
+
+	cxlswd = kzalloc(sizeof(*cxlswd), GFP_KERNEL);
+	if (!cxlswd)
+		return ERR_PTR(-ENOMEM);
+
+	rc = ida_alloc_max(&cxl_memdev_ida, CXL_MEM_MAX_DEVS - 1, GFP_KERNEL);
+	if (rc < 0) {
+		kfree(cxlswd);
+		return ERR_PTR(rc);
+	}
+
+	cxlswd->id = rc;
+	dev = &cxlswd->dev;
+	device_initialize(dev);
+	dev->bus = &cxl_bus_type;
+	dev->parent = parent;
+	dev->devt = MKDEV(cxl_mem_major, cxlswd->id);
+	dev->type = &cxl_swdev_type;
+	device_set_pm_not_required(dev);
+	cdev = &cxlswd->cdev;
+	cdev_init(cdev, &cxl_swdev_fops);
+	rc = dev_set_name(dev, "switch%d", cxlswd->id);
+	if (rc) {
+		put_device(dev);
+		return ERR_PTR(rc);
+	}
+
+	return cxlswd;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_swdev_alloc, CXL);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index dad80c5857f6..0f0d51730df8 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -279,7 +279,7 @@ int cxl_map_component_regs(const struct cxl_register_map *map,
 int cxl_map_device_regs(const struct cxl_register_map *map,
 			struct cxl_device_regs *regs);
 int cxl_map_mbox_regs(const struct cxl_register_map *map,
-		      void __iomem **mbox_reg);
+		      void __iomem **mbox_reg, void __iomem **status_reg);
 int cxl_map_pmu_regs(struct pci_dev *pdev, struct cxl_pmu_regs *regs,
 		     struct cxl_register_map *map);
 
diff --git a/drivers/cxl/cxlmbox.h b/drivers/cxl/cxlmbox.h
index eaaf51904d2a..e5da27c54fae 100644
--- a/drivers/cxl/cxlmbox.h
+++ b/drivers/cxl/cxlmbox.h
@@ -154,6 +154,8 @@ static inline int cxl_mbox_cmd_rc2errno(struct cxl_mbox_cmd *mbox_cmd)
 
 enum cxl_opcode {
 	CXL_MBOX_OP_INVALID		= 0x0000,
+	CXL_MBOX_OP_INFO_STAT_IDENTIFY	= 0x0001,
+	CXL_MBOX_OP_GET_BG_CMD_STATUS	= 0x0002,
 	CXL_MBOX_OP_RAW			= CXL_MBOX_OP_INVALID,
 	CXL_MBOX_OP_GET_EVENT_RECORD	= 0x0100,
 	CXL_MBOX_OP_CLEAR_EVENT_RECORD	= 0x0101,
@@ -189,6 +191,8 @@ enum cxl_opcode {
 	CXL_MBOX_OP_UNLOCK		= 0x4503,
 	CXL_MBOX_OP_FREEZE_SECURITY	= 0x4504,
 	CXL_MBOX_OP_PASSPHRASE_SECURE_ERASE	= 0x4505,
+	CXL_MBOX_OP_IDENTIFY_SWITCH_DEVICE	= 0x5100,
+	CXL_MBOX_OP_TUNNEL_MANAGEMENT_COMMAND	= 0x5300,
 	CXL_MBOX_OP_MAX			= 0x10000
 };
 
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 0ec524c62196..3c1307330cab 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -627,9 +627,14 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
-	rc = cxl_map_mbox_regs(&map, &mds->mbox.mbox);
+	/* Status register already mapped */
+	rc = cxl_map_mbox_regs(&map, &mds->mbox.mbox, NULL);
 	if (rc)
 		return rc;
+
+	/* Connect up the status register access for the mbox */
+	mds->mbox.status = cxlds->regs.status;
+
 	/*
 	 * If the component registers can't be found, the cxl_pci driver may
 	 * still be useful for management functions so don't return an error.
diff --git a/drivers/cxl/switch.h b/drivers/cxl/switch.h
new file mode 100644
index 000000000000..14e8e1cb87e7
--- /dev/null
+++ b/drivers/cxl/switch.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __CXL_SWITCH_H__
+#define __CXL_SWITCH_H__
+
+#include <linux/device.h>
+#include <linux/cdev.h>
+#include "cxlmbox.h"
+
+struct cxl_swdev {
+	struct device dev;
+	struct cdev cdev;
+	struct cxl_mbox mbox;
+	int id;
+	bool dying;
+};
+
+struct cxl_swdev *cxl_swdev_alloc(struct device *parent);
+void cxl_swdev_shutdown(struct cxl_swdev *cxlswd);
+#endif /* __CXL_SWITCH_H__ */
diff --git a/drivers/cxl/switchdev.c b/drivers/cxl/switchdev.c
new file mode 100644
index 000000000000..caef216d08ec
--- /dev/null
+++ b/drivers/cxl/switchdev.c
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright(c) Huawei Technologies
+ * Based on cxl/pci.c Copyright(c) 2020 Intel Corporation. All rights reserved.
+ */
+
+#include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/moduleparam.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/sizes.h>
+#include <linux/mutex.h>
+#include <linux/list.h>
+#include <linux/pci.h>
+#include <linux/io.h>
+#include "cxlpci.h"
+#include "switch.h"
+#include "cxl.h"
+
+static irqreturn_t cxl_swmb_mbox_irq(int irq, void *d)
+{
+	return cxl_mbox_irq(irq, d);
+}
+
+static int cxl_swmb_setup_mailbox(struct cxl_mbox *mbox)
+{
+	const int cap = readl(mbox->mbox + CXLDEV_MBOX_CAPS_OFFSET);
+
+	/*
+	 * A command may be in flight from a previous driver instance,
+	 * think kexec, do one doorbell wait so that
+	 * __cxl_pci_mbox_send_cmd() can assume that it is the only
+	 * source for future doorbell busy events.
+	 */
+	if (cxl_pci_mbox_wait_for_doorbell(mbox) != 0) {
+		dev_err(mbox->dev, "timeout awaiting mailbox idle");
+
+		return -ETIMEDOUT;
+	}
+
+	mbox->payload_size =
+		1 << FIELD_GET(CXLDEV_MBOX_CAP_PAYLOAD_SIZE_MASK, cap);
+
+	/*
+	 * CXL 2.0 8.2.8.4.3 Mailbox Capabilities Register
+	 *
+	 * If the size is too small, mandatory commands will not work and so
+	 * there's no point in going forward. If the size is too large, there's
+	 * no harm is soft limiting it.
+	 */
+	mbox->payload_size = min_t(size_t, mbox->payload_size, SZ_1M);
+	if (mbox->payload_size < 256) {
+		dev_err(mbox->dev, "Mailbox is too small (%zub)",
+			mbox->payload_size);
+		return -ENXIO;
+	}
+
+	dev_dbg(mbox->dev, "Mailbox payload sized %zu", mbox->payload_size);
+
+	rcuwait_init(&mbox->mbox_wait);
+
+	if (cap & CXLDEV_MBOX_CAP_BG_CMD_IRQ) {
+		u32 ctrl;
+		int irq, msgnum, rc;
+		struct pci_dev *pdev = to_pci_dev(mbox->dev);
+
+		msgnum = FIELD_GET(CXLDEV_MBOX_CAP_IRQ_MSGNUM_MASK, cap);
+		irq = pci_irq_vector(pdev, msgnum);
+		if (irq < 0)
+			goto mbox_poll;
+
+		rc = devm_request_threaded_irq(mbox->dev, irq, cxl_swmb_mbox_irq,
+					       NULL, IRQF_SHARED | IRQF_ONESHOT,
+					       NULL, mbox);
+		if (rc)
+			goto mbox_poll;
+
+		/* enable background command mbox irq support */
+		ctrl = readl(mbox->mbox + CXLDEV_MBOX_CTRL_OFFSET);
+		ctrl |= CXLDEV_MBOX_CTRL_BG_CMD_IRQ;
+		writel(ctrl, mbox->mbox + CXLDEV_MBOX_CTRL_OFFSET);
+
+		return 0;
+	}
+
+mbox_poll:
+
+	dev_dbg(mbox->dev, "Mailbox interrupts are unsupported");
+	return 0;
+}
+
+
+static int cxl_swmb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct cxl_register_map map;
+	struct cxl_swdev *cxlswd;
+	int rc;
+
+	rc = pcim_enable_device(pdev);
+	if (rc)
+		return rc;
+
+	cxlswd = cxl_swdev_alloc(&pdev->dev);
+	if (IS_ERR(cxlswd))
+		return PTR_ERR(cxlswd);
+
+	mutex_init(&cxlswd->mbox.mbox_mutex);
+	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
+	if (rc)
+		return rc;
+	rc = cxl_setup_regs(&map);
+	if (rc)
+		return rc;
+
+	rc = cxl_map_mbox_regs(&map, &cxlswd->mbox.mbox, &cxlswd->mbox.status);
+	if (rc)
+		return rc;
+
+	cxlswd->mbox.dev = &pdev->dev;
+
+	rc = cxl_swmb_setup_mailbox(&cxlswd->mbox);
+	if (rc)
+		return rc;
+
+
+	pci_set_drvdata(pdev, cxlswd);
+
+	rc = cxl_enumerate_cmds(&cxlswd->mbox);
+	if (rc)
+		goto error_put_device;
+
+	rc = cdev_device_add(&cxlswd->cdev, &cxlswd->dev);
+	if (rc)
+		goto error_put_device;
+
+	return 0;
+
+error_put_device:
+	cxl_swdev_shutdown(cxlswd);
+	put_device(&cxlswd->dev);
+	return rc;
+}
+
+static void cxl_swbm_remove(struct pci_dev *pdev)
+{
+	struct cxl_swdev *cxlswd = pci_get_drvdata(pdev);
+	struct device *dev = &cxlswd->dev;
+
+	cxl_swdev_shutdown(cxlswd);
+	cdev_device_del(&cxlswd->cdev, dev);
+	put_device(&cxlswd->dev);
+}
+
+static const struct pci_device_id cxl_swmb_pci_tbl[] = {
+	{ PCI_DEVICE_CLASS(PCI_CLASS_SERIAL_CXL_SWITCH_CCI, ~0) },
+	{}
+};
+MODULE_DEVICE_TABLE(pci, cxl_swmb_pci_tbl);
+
+static struct pci_driver cxl_swmb_driver = {
+	.name = KBUILD_MODNAME,
+	.id_table = cxl_swmb_pci_tbl,
+	.probe = cxl_swmb_probe,
+	.remove = cxl_swbm_remove,
+};
+
+module_pci_driver(cxl_swmb_driver);
+MODULE_DESCRIPTION("CXL Switch CCI mailbox access driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(CXL);
diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
index 14bc6e742148..b62aeba9d5c6 100644
--- a/include/uapi/linux/cxl_mem.h
+++ b/include/uapi/linux/cxl_mem.h
@@ -46,6 +46,10 @@
 	___C(GET_SCAN_MEDIA_CAPS, "Get Scan Media Capabilities"),         \
 	___DEPRECATED(SCAN_MEDIA, "Scan Media"),                          \
 	___DEPRECATED(GET_SCAN_MEDIA, "Get Scan Media Results"),          \
+	___C(INFO_STAT_IDENTIFY, "Get Information"),			  \
+	___C(GET_BG_CMD_STATUS, "Background Command Status"),	\
+	___C(IDENTIFY_SWITCH_DEVICE, "Identify Switch Device"),		\
+	___C(TUNNEL_MANAGEMENT_COMMAND, "Tunnel Management Command"),     \
 	___C(MAX, "invalid / last command")
 
 #define ___C(a, b) CXL_MEM_COMMAND_ID_##a
-- 
2.39.2

