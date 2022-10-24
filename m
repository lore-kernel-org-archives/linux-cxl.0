Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66EF7ECAAA1
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Oct 2022 17:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234268AbiJXRkr (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 24 Oct 2022 13:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233417AbiJXRjo (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 24 Oct 2022 13:39:44 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B1DCAE7D
        for <linux-cxl@vger.kernel.org>; Mon, 24 Oct 2022 09:15:25 -0700 (PDT)
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Mwzzs44ZKz67WpY;
        Mon, 24 Oct 2022 23:50:17 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 17:53:45 +0200
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 16:53:44 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-cxl@vger.kernel.org>, <jonathan.cameron@huawei.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>, <linuxarm@huawei.com>,
        "Viacheslav A . Dubeyko" <viacheslav.dubeyko@bytedance.com>
Subject: [RFC PATCH 1/1] cxl/pci: Add support for stand alone CXL Switch mailbox CCI
Date:   Mon, 24 Oct 2022 16:53:22 +0100
Message-ID: <20221024155322.16661-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221024155322.16661-1-Jonathan.Cameron@huawei.com>
References: <20221024155322.16661-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

CXL 3.0 defines a mailbox PCI function independent of any other CXL
components. The intent is that instances of this mailbox will be found
as additional PCI functions of upstream CXL switch ports.

RFC: Including this directly in cxl/pci.c as a second pci_driver, is a
bit hacky.  The alternative is to factor out all the common
infrastructure to a library module shared by the Type 3 PCI driver
and the Switch CCI driver.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---

Options to consider:
1 - Factor out all the shared code and have a separate module for
    switch CCI driver. Messy!
2 - Is sharing the allow lists between type 3 devices and switch CCI
    an issue? Not a whole lot of overlap...
---
 drivers/cxl/core/Makefile     |   1 +
 drivers/cxl/core/core.h       |   1 +
 drivers/cxl/core/mbox.c       |  20 ++++-
 drivers/cxl/core/port.c       |   4 +
 drivers/cxl/core/switch-cci.c | 142 ++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlmem.h          |   3 +
 drivers/cxl/cxlpci.h          |   3 +
 drivers/cxl/cxlswitch.h       |  17 ++++
 drivers/cxl/pci.c             |  93 +++++++++++++++++++++-
 include/uapi/linux/cxl_mem.h  |   3 +
 10 files changed, 282 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index 79c7257f4107..18275e153437 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -10,4 +10,5 @@ cxl_core-y += memdev.o
 cxl_core-y += mbox.o
 cxl_core-y += pci.o
 cxl_core-y += hdm.o
+cxl_core-y += switch-cci.o
 cxl_core-$(CONFIG_CXL_REGION) += region.o
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 1d8f87be283f..8ac1a0e2c98f 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -70,5 +70,6 @@ static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
 int cxl_memdev_init(void);
 void cxl_memdev_exit(void);
 void cxl_mbox_init(void);
+int cxl_switch_cci_init(void);
 
 #endif /* __CXL_CORE_H__ */
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 0c90f13870a4..a4e2cb454094 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -5,6 +5,7 @@
 #include <linux/debugfs.h>
 #include <linux/mutex.h>
 #include <cxlmem.h>
+#include <cxlpci.h>
 #include <cxl.h>
 
 #include "core.h"
@@ -43,6 +44,8 @@ static bool cxl_raw_allow_all;
  * 0, and the user passed in 1, it is an error.
  */
 static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
+	CXL_CMD(INFO_STAT_IDENTIFY, 0, 18, 0),
+	CXL_CMD(GET_BG_CMD_STATUS, 0, 8, 0),
 	CXL_CMD(IDENTIFY, 0, 0x43, CXL_CMD_FLAG_FORCE_ENABLE),
 #ifdef CONFIG_CXL_MEM_RAW_COMMANDS
 	CXL_CMD(RAW, CXL_VARIABLE_PAYLOAD, CXL_VARIABLE_PAYLOAD, 0),
@@ -65,6 +68,7 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
 	CXL_CMD(GET_SCAN_MEDIA_CAPS, 0x10, 0x4, 0),
 	CXL_CMD(SCAN_MEDIA, 0x11, 0, 0),
 	CXL_CMD(GET_SCAN_MEDIA, 0, CXL_VARIABLE_PAYLOAD, 0),
+	CXL_CMD(IDENTIFY_SWITCH_DEVICE, 0, 0x49, 0),
 };
 
 /*
@@ -526,10 +530,9 @@ static int handle_mailbox_cmd_from_user(struct cxl_dev_state *cxlds,
 	return rc;
 }
 
-int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s)
+int __cxl_send_cmd(struct cxl_dev_state *cxlds, struct device *dev,
+		   struct cxl_send_command __user *s)
 {
-	struct cxl_dev_state *cxlds = cxlmd->cxlds;
-	struct device *dev = &cxlmd->dev;
 	struct cxl_send_command send;
 	struct cxl_mbox_cmd mbox_cmd;
 	int rc;
@@ -539,7 +542,7 @@ int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s)
 	if (copy_from_user(&send, s, sizeof(send)))
 		return -EFAULT;
 
-	rc = cxl_validate_cmd_from_user(&mbox_cmd, cxlmd->cxlds, &send);
+	rc = cxl_validate_cmd_from_user(&mbox_cmd, cxlds, &send);
 	if (rc)
 		return rc;
 
@@ -553,6 +556,15 @@ int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(__cxl_send_cmd);
+
+int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s)
+{
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct device *dev = &cxlmd->dev;
+
+	return __cxl_send_cmd(cxlds, dev, s);
+}
 
 static int cxl_xfer_log(struct cxl_dev_state *cxlds, uuid_t *uuid, u32 size, u8 *out)
 {
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index bffde862de0b..3b2e93bc4684 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1859,6 +1859,10 @@ static __init int cxl_core_init(void)
 	if (rc)
 		return rc;
 
+	rc = cxl_switch_cci_init();
+	if (rc)
+		return rc;
+
 	cxl_bus_wq = alloc_ordered_workqueue("cxl_port", 0);
 	if (!cxl_bus_wq) {
 		rc = -ENOMEM;
diff --git a/drivers/cxl/core/switch-cci.c b/drivers/cxl/core/switch-cci.c
new file mode 100644
index 000000000000..1ce51cc07cba
--- /dev/null
+++ b/drivers/cxl/core/switch-cci.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <cxlswitch.h>
+#include "cxlmem.h" /* For now to get the cxl_device_state */
+#include "cxlpci.h"
+#include "core.h"
+
+
+static int cxl_sw_major;
+static DEFINE_IDA(cxl_swdev_ida);
+static DECLARE_RWSEM(cxl_swdev_rwsem);
+
+static inline struct cxl_swdev *to_cxl_swdev(struct device *dev)
+{
+	return container_of(dev, struct cxl_swdev, dev);
+}
+
+static char *cxl_swdev_devnode(struct device *dev, umode_t *mode, kuid_t *uid,
+			kgid_t *gid)
+{
+	return kasprintf(GFP_KERNEL, "cxl/%s", dev_name(dev));
+}
+
+static void cxl_swdev_release(struct device *dev)
+{
+	struct cxl_swdev *cxlswd = to_cxl_swdev(dev);
+
+	ida_free(&cxl_swdev_ida, cxlswd->id);
+	kfree(cxlswd);
+}
+
+static const struct device_type cxl_swdev_type = {
+	.name = "cxl_swdev",
+	.release = cxl_swdev_release,
+	.devnode = cxl_swdev_devnode,
+};
+
+static long __cxl_swdev_ioctl(struct cxl_swdev *cxlswd, unsigned int cmd,
+			       unsigned long arg)
+{
+	switch (cmd) {
+	case CXL_MEM_SEND_COMMAND:
+		return __cxl_send_cmd(cxlswd->cxlds, &cxlswd->dev, (void __user *)arg);
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
+	down_read(&cxl_swdev_rwsem);
+	if (cxlswd->cxlds)
+		rc = __cxl_swdev_ioctl(cxlswd, cmd, arg);
+	up_read(&cxl_swdev_rwsem);
+
+	return rc;
+}
+
+static int cxl_swdev_open(struct inode *inode, struct file *file)
+{
+	struct cxl_memdev *cxlswd =
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
+struct cxl_swdev *cxl_swdev_alloc(struct cxl_dev_state *cxlds)
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
+	rc = ida_alloc_range(&cxl_swdev_ida, 0, 10, GFP_KERNEL);
+	if (rc < 0) {
+		kfree(cxlswd);
+		return ERR_PTR(rc);
+	}
+
+	cxlswd->id = rc;
+	cxlswd->cxlds = cxlds;
+	dev = &cxlswd->dev;
+	device_initialize(dev);
+	dev->parent = cxlds->dev;
+	dev->bus = &cxl_bus_type;
+	dev->devt = MKDEV(cxl_sw_major, cxlswd->id);
+	dev->type = &cxl_swdev_type;
+	device_set_pm_not_required(dev);
+	cdev = &cxlswd->cdev;
+	cdev_init(cdev, &cxl_swdev_fops);
+	rc = dev_set_name(dev, "swcci%d", cxlswd->id);
+	if (rc) {
+		put_device(dev);
+		ida_free(&cxl_swdev_ida, cxlswd->id);
+		return ERR_PTR(rc);
+	}
+
+	return cxlswd;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_swdev_alloc, CXL);
+
+__init int cxl_switch_cci_init(void)
+{
+	dev_t devt;
+	int rc;
+
+	rc = alloc_chrdev_region(&devt, 0, 10, "cxlsw");
+	if (rc)
+		return rc;
+	cxl_sw_major = MAJOR(devt);
+
+	return 0;
+}
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 88e3a8e54b6a..ef9c0c347daf 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -252,6 +252,8 @@ struct cxl_dev_state {
 
 enum cxl_opcode {
 	CXL_MBOX_OP_INVALID		= 0x0000,
+	CXL_MBOX_OP_INFO_STAT_IDENTIFY	= 0x0001,
+	CXL_MBOX_OP_GET_BG_CMD_STATUS	= 0x0002,
 	CXL_MBOX_OP_RAW			= CXL_MBOX_OP_INVALID,
 	CXL_MBOX_OP_GET_FW_INFO		= 0x0200,
 	CXL_MBOX_OP_ACTIVATE_FW		= 0x0202,
@@ -273,6 +275,7 @@ enum cxl_opcode {
 	CXL_MBOX_OP_GET_SCAN_MEDIA_CAPS	= 0x4303,
 	CXL_MBOX_OP_SCAN_MEDIA		= 0x4304,
 	CXL_MBOX_OP_GET_SCAN_MEDIA	= 0x4305,
+	CXL_MBOX_OP_IDENTIFY_SWITCH_DEVICE	= 0x5100,
 	CXL_MBOX_OP_MAX			= 0x10000
 };
 
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index eec597dbe763..7f53b601ad7c 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -75,4 +75,7 @@ int devm_cxl_port_enumerate_dports(struct cxl_port *port);
 struct cxl_dev_state;
 int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm);
 void read_cdat_data(struct cxl_port *port);
+struct cxl_send_command;
+int __cxl_send_cmd(struct cxl_dev_state *cxlds, struct device *dev,
+		   struct cxl_send_command __user *s);
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/cxlswitch.h b/drivers/cxl/cxlswitch.h
new file mode 100644
index 000000000000..4d1689db653c
--- /dev/null
+++ b/drivers/cxl/cxlswitch.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef CXLSWITCH_H
+#define CXLSWITCH_H
+#include <linux/cdev.h>
+#include <linux/device.h>
+#include "cxl.h"
+
+struct cxl_dev_state;
+struct cxl_swdev {
+	struct device dev;
+	struct cdev cdev;
+	struct cxl_dev_state *cxlds;
+	int id;
+};
+
+struct cxl_swdev *cxl_swdev_alloc(struct cxl_dev_state *cxlds);
+#endif
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index faeb5d9d7a7a..a7aec6247e86 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -12,6 +12,7 @@
 #include <linux/io.h>
 #include "cxlmem.h"
 #include "cxlpci.h"
+#include "cxlswitch.h"
 #include "cxl.h"
 
 /**
@@ -520,6 +521,96 @@ static struct pci_driver cxl_pci_driver = {
 	},
 };
 
+static int cxl_swmbcci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct cxl_dev_state *cxlds;
+	struct cxl_register_map map;
+	struct cxl_swdev *cxlswd;
+	int rc;
+
+	rc = pcim_enable_device(pdev);
+	if (rc)
+		return rc;
+
+	cxlds = cxl_dev_state_create(&pdev->dev);
+	if (IS_ERR(cxlds))
+		return PTR_ERR(cxlds);
+
+	rc = cxl_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
+	if (rc)
+		return rc;
+
+	rc = cxl_map_regs(cxlds, &map);
+	if (rc)
+		return rc;
+
+	rc = cxl_pci_setup_mailbox(cxlds);
+	if (rc)
+		return rc;
+
+	cxlswd = cxl_swdev_alloc(cxlds);
+	if (IS_ERR(cxlswd))
+		return PTR_ERR(cxlswd);
+
+	pci_set_drvdata(pdev, cxlswd);
+
+	rc = cxl_enumerate_cmds(cxlds);
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
+	put_device(&cxlswd->dev);
+	return rc;
+}
+
+static void cxl_swbmcci_remove(struct pci_dev *pdev)
+{
+	struct cxl_swdev *cxlswd = pci_get_drvdata(pdev);
+	struct device *dev = &cxlswd->dev;
+
+	cdev_device_del(&cxlswd->cdev, dev);
+	put_device(&cxlswd->dev);
+}
+
+static const struct pci_device_id cxl_swmbcci_pci_tbl[] = {
+	{ PCI_DEVICE_CLASS((0x0c0b << 8 | 0), ~0)},
+	{}
+};
+
+static struct pci_driver cxl_swmbcci_driver = {
+	.name = "cxl_swmbcci",
+	.id_table = cxl_swmbcci_pci_tbl,
+	.probe = cxl_swmbcci_probe,
+	.remove = cxl_swbmcci_remove,
+};
+
+static int __init cxl_pci_init(void)
+{
+	int rc;
+
+	rc = pci_register_driver(&cxl_pci_driver);
+	if (rc)
+		return rc;
+
+	rc = pci_register_driver(&cxl_swmbcci_driver);
+	if (rc) {
+		pci_unregister_driver(&cxl_pci_driver);
+		return rc;
+	}
+	return 0;
+}
+module_init(cxl_pci_init);
+static void __exit cxl_pci_exit(void)
+{
+	pci_unregister_driver(&cxl_swmbcci_driver);
+	pci_unregister_driver(&cxl_pci_driver);
+}
+module_exit(cxl_pci_exit);
 MODULE_LICENSE("GPL v2");
-module_pci_driver(cxl_pci_driver);
 MODULE_IMPORT_NS(CXL);
diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
index c71021a2a9ed..ea03a289e56f 100644
--- a/include/uapi/linux/cxl_mem.h
+++ b/include/uapi/linux/cxl_mem.h
@@ -41,6 +41,9 @@
 	___C(GET_SCAN_MEDIA_CAPS, "Get Scan Media Capabilities"),         \
 	___C(SCAN_MEDIA, "Scan Media"),                                   \
 	___C(GET_SCAN_MEDIA, "Get Scan Media Results"),                   \
+	___C(INFO_STAT_IDENTIFY, "Get Information"),			  \
+	___C(GET_BG_CMD_STATUS, "Background Command Status"),             \
+	___C(IDENTIFY_SWITCH_DEVICE, "Identify Switch Device"),           \
 	___C(MAX, "invalid / last command")
 
 #define ___C(a, b) CXL_MEM_COMMAND_ID_##a
-- 
2.37.2

