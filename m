Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B95C433F5
	for <linux-cxl@archiver.kernel.org>; Sat, 30 Oct 2021 00:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0CCB6108F
	for <linux-cxl@archiver.kernel.org>; Sat, 30 Oct 2021 00:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbhJ3Axh (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 29 Oct 2021 20:53:37 -0400
Received: from mga07.intel.com ([134.134.136.100]:24564 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229614AbhJ3Axh (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 29 Oct 2021 20:53:37 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10152"; a="294241379"
X-IronPort-AV: E=Sophos;i="5.87,194,1631602800"; 
   d="scan'208";a="294241379"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 17:51:07 -0700
X-IronPort-AV: E=Sophos;i="5.87,194,1631602800"; 
   d="scan'208";a="666013510"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 17:51:07 -0700
Subject: [PATCH] cxl/core: Convert to EXPORT_SYMBOL_NS_GPL
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     ira.weiny@intel.com, ben.widawsky@intel.com,
        alison.schofield@intel.com, vishal.l.verma@intel.com
Date:   Fri, 29 Oct 2021 17:51:07 -0700
Message-ID: <163555506776.2553440.17247681249660176777.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

It turns out that the usb example of specifying the subsystem namespace
at build time is not preferred. The rationale for that preference has
become more apparent as CXL patches with plain EXPORT_SYMBOL_GPL beg the
question, "why would any code other than CXL care about this symbol?".
Make the namespace explicit.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/Makefile |    2 +-
 drivers/cxl/core/bus.c    |   20 ++++++++++----------
 drivers/cxl/core/mbox.c   |   10 +++++-----
 drivers/cxl/core/memdev.c |    6 +++---
 drivers/cxl/core/pmem.c   |   10 +++++-----
 drivers/cxl/core/regs.c   |    8 ++++----
 6 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index 07eb8e1fb8a6..40ab50318daf 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_CXL_BUS) += cxl_core.o
 
-ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=CXL -I$(srctree)/drivers/cxl
+ccflags-y += -I$(srctree)/drivers/cxl
 cxl_core-y := bus.o
 cxl_core-y += pmem.o
 cxl_core-y += regs.o
diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
index ebd061d03950..17a4fff029f8 100644
--- a/drivers/cxl/core/bus.c
+++ b/drivers/cxl/core/bus.c
@@ -200,7 +200,7 @@ bool is_root_decoder(struct device *dev)
 {
 	return dev->type == &cxl_decoder_root_type;
 }
-EXPORT_SYMBOL_GPL(is_root_decoder);
+EXPORT_SYMBOL_NS_GPL(is_root_decoder, CXL);
 
 struct cxl_decoder *to_cxl_decoder(struct device *dev)
 {
@@ -209,7 +209,7 @@ struct cxl_decoder *to_cxl_decoder(struct device *dev)
 		return NULL;
 	return container_of(dev, struct cxl_decoder, dev);
 }
-EXPORT_SYMBOL_GPL(to_cxl_decoder);
+EXPORT_SYMBOL_NS_GPL(to_cxl_decoder, CXL);
 
 static void cxl_dport_release(struct cxl_dport *dport)
 {
@@ -376,7 +376,7 @@ struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
 	put_device(dev);
 	return ERR_PTR(rc);
 }
-EXPORT_SYMBOL_GPL(devm_cxl_add_port);
+EXPORT_SYMBOL_NS_GPL(devm_cxl_add_port, CXL);
 
 static struct cxl_dport *find_dport(struct cxl_port *port, int id)
 {
@@ -451,7 +451,7 @@ int cxl_add_dport(struct cxl_port *port, struct device *dport_dev, int port_id,
 	cxl_dport_release(dport);
 	return rc;
 }
-EXPORT_SYMBOL_GPL(cxl_add_dport);
+EXPORT_SYMBOL_NS_GPL(cxl_add_dport, CXL);
 
 static int decoder_populate_targets(struct cxl_decoder *cxld,
 				    struct cxl_port *port, int *target_map)
@@ -521,7 +521,7 @@ struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets)
 	kfree(cxld);
 	return ERR_PTR(rc);
 }
-EXPORT_SYMBOL_GPL(cxl_decoder_alloc);
+EXPORT_SYMBOL_NS_GPL(cxl_decoder_alloc, CXL);
 
 int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map)
 {
@@ -550,7 +550,7 @@ int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map)
 
 	return device_add(dev);
 }
-EXPORT_SYMBOL_GPL(cxl_decoder_add);
+EXPORT_SYMBOL_NS_GPL(cxl_decoder_add, CXL);
 
 static void cxld_unregister(void *dev)
 {
@@ -561,7 +561,7 @@ int cxl_decoder_autoremove(struct device *host, struct cxl_decoder *cxld)
 {
 	return devm_add_action_or_reset(host, cxld_unregister, &cxld->dev);
 }
-EXPORT_SYMBOL_GPL(cxl_decoder_autoremove);
+EXPORT_SYMBOL_NS_GPL(cxl_decoder_autoremove, CXL);
 
 /**
  * __cxl_driver_register - register a driver for the cxl bus
@@ -594,13 +594,13 @@ int __cxl_driver_register(struct cxl_driver *cxl_drv, struct module *owner,
 
 	return driver_register(&cxl_drv->drv);
 }
-EXPORT_SYMBOL_GPL(__cxl_driver_register);
+EXPORT_SYMBOL_NS_GPL(__cxl_driver_register, CXL);
 
 void cxl_driver_unregister(struct cxl_driver *cxl_drv)
 {
 	driver_unregister(&cxl_drv->drv);
 }
-EXPORT_SYMBOL_GPL(cxl_driver_unregister);
+EXPORT_SYMBOL_NS_GPL(cxl_driver_unregister, CXL);
 
 static int cxl_device_id(struct device *dev)
 {
@@ -642,7 +642,7 @@ struct bus_type cxl_bus_type = {
 	.probe = cxl_bus_probe,
 	.remove = cxl_bus_remove,
 };
-EXPORT_SYMBOL_GPL(cxl_bus_type);
+EXPORT_SYMBOL_NS_GPL(cxl_bus_type, CXL);
 
 static __init int cxl_core_init(void)
 {
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 576796a5d9f3..c57137fb01c9 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -184,7 +184,7 @@ int cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm, u16 opcode, void *in,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(cxl_mem_mbox_send_cmd);
+EXPORT_SYMBOL_NS_GPL(cxl_mem_mbox_send_cmd, CXL);
 
 static bool cxl_mem_raw_command_allowed(u16 opcode)
 {
@@ -626,7 +626,7 @@ int cxl_mem_enumerate_cmds(struct cxl_mem *cxlm)
 	kvfree(gsl);
 	return rc;
 }
-EXPORT_SYMBOL_GPL(cxl_mem_enumerate_cmds);
+EXPORT_SYMBOL_NS_GPL(cxl_mem_enumerate_cmds, CXL);
 
 /**
  * cxl_mem_get_partition_info - Get partition info
@@ -711,7 +711,7 @@ int cxl_mem_identify(struct cxl_mem *cxlm)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(cxl_mem_identify);
+EXPORT_SYMBOL_NS_GPL(cxl_mem_identify, CXL);
 
 int cxl_mem_create_range_info(struct cxl_mem *cxlm)
 {
@@ -750,7 +750,7 @@ int cxl_mem_create_range_info(struct cxl_mem *cxlm)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(cxl_mem_create_range_info);
+EXPORT_SYMBOL_NS_GPL(cxl_mem_create_range_info, CXL);
 
 struct cxl_mem *cxl_mem_create(struct device *dev)
 {
@@ -767,7 +767,7 @@ struct cxl_mem *cxl_mem_create(struct device *dev)
 
 	return cxlm;
 }
-EXPORT_SYMBOL_GPL(cxl_mem_create);
+EXPORT_SYMBOL_NS_GPL(cxl_mem_create, CXL);
 
 static struct dentry *cxl_debugfs;
 
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index bf1b04d00ff4..a398f289518c 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -150,7 +150,7 @@ void set_exclusive_cxl_commands(struct cxl_mem *cxlm, unsigned long *cmds)
 		  CXL_MEM_COMMAND_ID_MAX);
 	up_write(&cxl_memdev_rwsem);
 }
-EXPORT_SYMBOL_GPL(set_exclusive_cxl_commands);
+EXPORT_SYMBOL_NS_GPL(set_exclusive_cxl_commands, CXL);
 
 /**
  * clear_exclusive_cxl_commands() - atomically enable user cxl commands
@@ -164,7 +164,7 @@ void clear_exclusive_cxl_commands(struct cxl_mem *cxlm, unsigned long *cmds)
 		      CXL_MEM_COMMAND_ID_MAX);
 	up_write(&cxl_memdev_rwsem);
 }
-EXPORT_SYMBOL_GPL(clear_exclusive_cxl_commands);
+EXPORT_SYMBOL_NS_GPL(clear_exclusive_cxl_commands, CXL);
 
 static void cxl_memdev_shutdown(struct device *dev)
 {
@@ -318,7 +318,7 @@ devm_cxl_add_memdev(struct cxl_mem *cxlm)
 	put_device(dev);
 	return ERR_PTR(rc);
 }
-EXPORT_SYMBOL_GPL(devm_cxl_add_memdev);
+EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, CXL);
 
 __init int cxl_memdev_init(void)
 {
diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
index 5032f4c1c69d..76a4fa39834c 100644
--- a/drivers/cxl/core/pmem.c
+++ b/drivers/cxl/core/pmem.c
@@ -49,7 +49,7 @@ struct cxl_nvdimm_bridge *to_cxl_nvdimm_bridge(struct device *dev)
 		return NULL;
 	return container_of(dev, struct cxl_nvdimm_bridge, dev);
 }
-EXPORT_SYMBOL_GPL(to_cxl_nvdimm_bridge);
+EXPORT_SYMBOL_NS_GPL(to_cxl_nvdimm_bridge, CXL);
 
 __mock int match_nvdimm_bridge(struct device *dev, const void *data)
 {
@@ -65,7 +65,7 @@ struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_nvdimm *cxl_nvd)
 		return NULL;
 	return to_cxl_nvdimm_bridge(dev);
 }
-EXPORT_SYMBOL_GPL(cxl_find_nvdimm_bridge);
+EXPORT_SYMBOL_NS_GPL(cxl_find_nvdimm_bridge, CXL);
 
 static struct cxl_nvdimm_bridge *
 cxl_nvdimm_bridge_alloc(struct cxl_port *port)
@@ -167,7 +167,7 @@ struct cxl_nvdimm_bridge *devm_cxl_add_nvdimm_bridge(struct device *host,
 	put_device(dev);
 	return ERR_PTR(rc);
 }
-EXPORT_SYMBOL_GPL(devm_cxl_add_nvdimm_bridge);
+EXPORT_SYMBOL_NS_GPL(devm_cxl_add_nvdimm_bridge, CXL);
 
 static void cxl_nvdimm_release(struct device *dev)
 {
@@ -191,7 +191,7 @@ bool is_cxl_nvdimm(struct device *dev)
 {
 	return dev->type == &cxl_nvdimm_type;
 }
-EXPORT_SYMBOL_GPL(is_cxl_nvdimm);
+EXPORT_SYMBOL_NS_GPL(is_cxl_nvdimm, CXL);
 
 struct cxl_nvdimm *to_cxl_nvdimm(struct device *dev)
 {
@@ -200,7 +200,7 @@ struct cxl_nvdimm *to_cxl_nvdimm(struct device *dev)
 		return NULL;
 	return container_of(dev, struct cxl_nvdimm, dev);
 }
-EXPORT_SYMBOL_GPL(to_cxl_nvdimm);
+EXPORT_SYMBOL_NS_GPL(to_cxl_nvdimm, CXL);
 
 static struct cxl_nvdimm *cxl_nvdimm_alloc(struct cxl_memdev *cxlmd)
 {
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 41de4a136ecd..e37e23bf4355 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -90,7 +90,7 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 		}
 	}
 }
-EXPORT_SYMBOL_GPL(cxl_probe_component_regs);
+EXPORT_SYMBOL_NS_GPL(cxl_probe_component_regs, CXL);
 
 /**
  * cxl_probe_device_regs() - Detect CXL Device register blocks
@@ -156,7 +156,7 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
 		}
 	}
 }
-EXPORT_SYMBOL_GPL(cxl_probe_device_regs);
+EXPORT_SYMBOL_NS_GPL(cxl_probe_device_regs, CXL);
 
 static void __iomem *devm_cxl_iomap_block(struct device *dev,
 					  resource_size_t addr,
@@ -199,7 +199,7 @@ int cxl_map_component_regs(struct pci_dev *pdev,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(cxl_map_component_regs);
+EXPORT_SYMBOL_NS_GPL(cxl_map_component_regs, CXL);
 
 int cxl_map_device_regs(struct pci_dev *pdev,
 			struct cxl_device_regs *regs,
@@ -246,4 +246,4 @@ int cxl_map_device_regs(struct pci_dev *pdev,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(cxl_map_device_regs);
+EXPORT_SYMBOL_NS_GPL(cxl_map_device_regs, CXL);

