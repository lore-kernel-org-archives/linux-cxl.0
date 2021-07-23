Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35B7C432BE
	for <linux-cxl@archiver.kernel.org>; Fri, 23 Jul 2021 21:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0DB760F26
	for <linux-cxl@archiver.kernel.org>; Fri, 23 Jul 2021 21:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbhGWU0G (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 23 Jul 2021 16:26:06 -0400
Received: from mga14.intel.com ([192.55.52.115]:34284 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231534AbhGWU0E (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 23 Jul 2021 16:26:04 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10054"; a="211671182"
X-IronPort-AV: E=Sophos;i="5.84,265,1620716400"; 
   d="scan'208";a="211671182"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 14:06:35 -0700
X-IronPort-AV: E=Sophos;i="5.84,265,1620716400"; 
   d="scan'208";a="497436102"
Received: from rfrederi-mobl.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.136.168])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 14:06:35 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 03/23] cxl/core: Extract register and pmem functionality
Date:   Fri, 23 Jul 2021 14:06:03 -0700
Message-Id: <20210723210623.114073-4-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210723210623.114073-1-ben.widawsky@intel.com>
References: <20210723210623.114073-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Register mapping and pmem/nvdimm integration are distinct enough from
basic CXL bus functionality that it warrants being moved out of bus.c
Additionally, this aims to modularize for the sake of reducing the size
of bus.c

pmem and register programming have very clear separation and are done
together for that reason. Other parts of core, like ports and decoders
should be pulled out as well, but those are more integrated with core
and therefore saved for later.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 .../driver-api/cxl/memory-devices.rst         |   6 +
 drivers/cxl/Makefile                          |   1 +
 drivers/cxl/core/Makefile                     |   2 +-
 drivers/cxl/core/bus.c                        | 435 +-----------------
 drivers/cxl/core/core.h                       |  20 +
 drivers/cxl/core/pmem.c                       | 201 ++++++++
 drivers/cxl/core/regs.c                       | 235 ++++++++++
 7 files changed, 467 insertions(+), 433 deletions(-)
 create mode 100644 drivers/cxl/core/core.h
 create mode 100644 drivers/cxl/core/pmem.c
 create mode 100644 drivers/cxl/core/regs.c

diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/memory-devices.rst
index a86e2c7c551a..46847d8c70a0 100644
--- a/Documentation/driver-api/cxl/memory-devices.rst
+++ b/Documentation/driver-api/cxl/memory-devices.rst
@@ -39,6 +39,12 @@ CXL Core
 .. kernel-doc:: drivers/cxl/core/bus.c
    :doc: cxl core
 
+.. kernel-doc:: drivers/cxl/core/pmem.c
+   :internal:
+
+.. kernel-doc:: drivers/cxl/core/regs.c
+   :internal:
+
 External Interfaces
 ===================
 
diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
index d1aaabc940f3..febb2c3f5fc6 100644
--- a/drivers/cxl/Makefile
+++ b/drivers/cxl/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_CXL_MEM) += cxl_pci.o
 obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
 obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
 
+ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=CXL
 cxl_pci-y := pci.o
 cxl_acpi-y := acpi.o
 cxl_pmem-y := pmem.o
diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index c65e9f61abe9..289e8c8deebb 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -2,4 +2,4 @@
 obj-$(CONFIG_CXL_BUS) += cxl_core.o
 
 ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=CXL -I./drivers/cxl
-cxl_core-y := bus.o
+cxl_core-y := bus.o pmem.o regs.o
diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
index 647b8a00ab36..33196813ebcb 100644
--- a/drivers/cxl/core/bus.c
+++ b/drivers/cxl/core/bus.c
@@ -6,8 +6,7 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/idr.h>
-#include <cxl.h>
-#include <mem.h>
+#include "core.h"
 
 /**
  * DOC: cxl core
@@ -37,7 +36,7 @@ static struct attribute *cxl_base_attributes[] = {
 	NULL,
 };
 
-static struct attribute_group cxl_base_attribute_group = {
+struct attribute_group cxl_base_attribute_group = {
 	.attrs = cxl_base_attributes,
 };
 
@@ -514,11 +513,6 @@ cxl_decoder_alloc(struct cxl_port *port, int nr_targets, resource_size_t base,
 	return ERR_PTR(rc);
 }
 
-static void unregister_dev(void *dev)
-{
-	device_unregister(dev);
-}
-
 struct cxl_decoder *
 devm_cxl_add_decoder(struct device *host, struct cxl_port *port, int nr_targets,
 		     resource_size_t base, resource_size_t len,
@@ -543,7 +537,7 @@ devm_cxl_add_decoder(struct device *host, struct cxl_port *port, int nr_targets,
 	if (rc)
 		goto err;
 
-	rc = devm_add_action_or_reset(host, unregister_dev, dev);
+	rc = devm_add_action_or_reset(host, unregister_cxl_dev, dev);
 	if (rc)
 		return ERR_PTR(rc);
 	return cxld;
@@ -554,429 +548,6 @@ devm_cxl_add_decoder(struct device *host, struct cxl_port *port, int nr_targets,
 }
 EXPORT_SYMBOL_GPL(devm_cxl_add_decoder);
 
-/**
- * cxl_probe_component_regs() - Detect CXL Component register blocks
- * @dev: Host device of the @base mapping
- * @base: Mapping containing the HDM Decoder Capability Header
- * @map: Map object describing the register block information found
- *
- * See CXL 2.0 8.2.4 Component Register Layout and Definition
- * See CXL 2.0 8.2.5.5 CXL Device Register Interface
- *
- * Probe for component register information and return it in map object.
- */
-void cxl_probe_component_regs(struct device *dev, void __iomem *base,
-			      struct cxl_component_reg_map *map)
-{
-	int cap, cap_count;
-	u64 cap_array;
-
-	*map = (struct cxl_component_reg_map) { 0 };
-
-	/*
-	 * CXL.cache and CXL.mem registers are at offset 0x1000 as defined in
-	 * CXL 2.0 8.2.4 Table 141.
-	 */
-	base += CXL_CM_OFFSET;
-
-	cap_array = readq(base + CXL_CM_CAP_HDR_OFFSET);
-
-	if (FIELD_GET(CXL_CM_CAP_HDR_ID_MASK, cap_array) != CM_CAP_HDR_CAP_ID) {
-		dev_err(dev,
-			"Couldn't locate the CXL.cache and CXL.mem capability array header./n");
-		return;
-	}
-
-	/* It's assumed that future versions will be backward compatible */
-	cap_count = FIELD_GET(CXL_CM_CAP_HDR_ARRAY_SIZE_MASK, cap_array);
-
-	for (cap = 1; cap <= cap_count; cap++) {
-		void __iomem *register_block;
-		u32 hdr;
-		int decoder_cnt;
-		u16 cap_id, offset;
-		u32 length;
-
-		hdr = readl(base + cap * 0x4);
-
-		cap_id = FIELD_GET(CXL_CM_CAP_HDR_ID_MASK, hdr);
-		offset = FIELD_GET(CXL_CM_CAP_PTR_MASK, hdr);
-		register_block = base + offset;
-
-		switch (cap_id) {
-		case CXL_CM_CAP_CAP_ID_HDM:
-			dev_dbg(dev, "found HDM decoder capability (0x%x)\n",
-				offset);
-
-			hdr = readl(register_block);
-
-			decoder_cnt = cxl_hdm_decoder_count(hdr);
-			length = 0x20 * decoder_cnt + 0x10;
-
-			map->hdm_decoder.valid = true;
-			map->hdm_decoder.offset = CXL_CM_OFFSET + offset;
-			map->hdm_decoder.size = length;
-			break;
-		default:
-			dev_dbg(dev, "Unknown CM cap ID: %d (0x%x)\n", cap_id,
-				offset);
-			break;
-		}
-	}
-}
-EXPORT_SYMBOL_GPL(cxl_probe_component_regs);
-
-static void cxl_nvdimm_bridge_release(struct device *dev)
-{
-	struct cxl_nvdimm_bridge *cxl_nvb = to_cxl_nvdimm_bridge(dev);
-
-	kfree(cxl_nvb);
-}
-
-static const struct attribute_group *cxl_nvdimm_bridge_attribute_groups[] = {
-	&cxl_base_attribute_group,
-	NULL,
-};
-
-static const struct device_type cxl_nvdimm_bridge_type = {
-	.name = "cxl_nvdimm_bridge",
-	.release = cxl_nvdimm_bridge_release,
-	.groups = cxl_nvdimm_bridge_attribute_groups,
-};
-
-struct cxl_nvdimm_bridge *to_cxl_nvdimm_bridge(struct device *dev)
-{
-	if (dev_WARN_ONCE(dev, dev->type != &cxl_nvdimm_bridge_type,
-			  "not a cxl_nvdimm_bridge device\n"))
-		return NULL;
-	return container_of(dev, struct cxl_nvdimm_bridge, dev);
-}
-EXPORT_SYMBOL_GPL(to_cxl_nvdimm_bridge);
-
-static struct cxl_nvdimm_bridge *
-cxl_nvdimm_bridge_alloc(struct cxl_port *port)
-{
-	struct cxl_nvdimm_bridge *cxl_nvb;
-	struct device *dev;
-
-	cxl_nvb = kzalloc(sizeof(*cxl_nvb), GFP_KERNEL);
-	if (!cxl_nvb)
-		return ERR_PTR(-ENOMEM);
-
-	dev = &cxl_nvb->dev;
-	cxl_nvb->port = port;
-	cxl_nvb->state = CXL_NVB_NEW;
-	device_initialize(dev);
-	device_set_pm_not_required(dev);
-	dev->parent = &port->dev;
-	dev->bus = &cxl_bus_type;
-	dev->type = &cxl_nvdimm_bridge_type;
-
-	return cxl_nvb;
-}
-
-static void unregister_nvb(void *_cxl_nvb)
-{
-	struct cxl_nvdimm_bridge *cxl_nvb = _cxl_nvb;
-	bool flush;
-
-	/*
-	 * If the bridge was ever activated then there might be in-flight state
-	 * work to flush. Once the state has been changed to 'dead' then no new
-	 * work can be queued by user-triggered bind.
-	 */
-	device_lock(&cxl_nvb->dev);
-	flush = cxl_nvb->state != CXL_NVB_NEW;
-	cxl_nvb->state = CXL_NVB_DEAD;
-	device_unlock(&cxl_nvb->dev);
-
-	/*
-	 * Even though the device core will trigger device_release_driver()
-	 * before the unregister, it does not know about the fact that
-	 * cxl_nvdimm_bridge_driver defers ->remove() work. So, do the driver
-	 * release not and flush it before tearing down the nvdimm device
-	 * hierarchy.
-	 */
-	device_release_driver(&cxl_nvb->dev);
-	if (flush)
-		flush_work(&cxl_nvb->state_work);
-	device_unregister(&cxl_nvb->dev);
-}
-
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
-	rc = dev_set_name(dev, "nvdimm-bridge");
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
-EXPORT_SYMBOL_GPL(devm_cxl_add_nvdimm_bridge);
-
-static void cxl_nvdimm_release(struct device *dev)
-{
-	struct cxl_nvdimm *cxl_nvd = to_cxl_nvdimm(dev);
-
-	kfree(cxl_nvd);
-}
-
-static const struct attribute_group *cxl_nvdimm_attribute_groups[] = {
-	&cxl_base_attribute_group,
-	NULL,
-};
-
-static const struct device_type cxl_nvdimm_type = {
-	.name = "cxl_nvdimm",
-	.release = cxl_nvdimm_release,
-	.groups = cxl_nvdimm_attribute_groups,
-};
-
-bool is_cxl_nvdimm(struct device *dev)
-{
-	return dev->type == &cxl_nvdimm_type;
-}
-EXPORT_SYMBOL_GPL(is_cxl_nvdimm);
-
-struct cxl_nvdimm *to_cxl_nvdimm(struct device *dev)
-{
-	if (dev_WARN_ONCE(dev, !is_cxl_nvdimm(dev),
-			  "not a cxl_nvdimm device\n"))
-		return NULL;
-	return container_of(dev, struct cxl_nvdimm, dev);
-}
-EXPORT_SYMBOL_GPL(to_cxl_nvdimm);
-
-static struct cxl_nvdimm *cxl_nvdimm_alloc(struct cxl_memdev *cxlmd)
-{
-	struct cxl_nvdimm *cxl_nvd;
-	struct device *dev;
-
-	cxl_nvd = kzalloc(sizeof(*cxl_nvd), GFP_KERNEL);
-	if (!cxl_nvd)
-		return ERR_PTR(-ENOMEM);
-
-	dev = &cxl_nvd->dev;
-	cxl_nvd->cxlmd = cxlmd;
-	device_initialize(dev);
-	device_set_pm_not_required(dev);
-	dev->parent = &cxlmd->dev;
-	dev->bus = &cxl_bus_type;
-	dev->type = &cxl_nvdimm_type;
-
-	return cxl_nvd;
-}
-
-int devm_cxl_add_nvdimm(struct device *host, struct cxl_memdev *cxlmd)
-{
-	struct cxl_nvdimm *cxl_nvd;
-	struct device *dev;
-	int rc;
-
-	cxl_nvd = cxl_nvdimm_alloc(cxlmd);
-	if (IS_ERR(cxl_nvd))
-		return PTR_ERR(cxl_nvd);
-
-	dev = &cxl_nvd->dev;
-	rc = dev_set_name(dev, "pmem%d", cxlmd->id);
-	if (rc)
-		goto err;
-
-	rc = device_add(dev);
-	if (rc)
-		goto err;
-
-	dev_dbg(host, "%s: register %s\n", dev_name(dev->parent),
-		dev_name(dev));
-
-	return devm_add_action_or_reset(host, unregister_dev, dev);
-
-err:
-	put_device(dev);
-	return rc;
-}
-EXPORT_SYMBOL_GPL(devm_cxl_add_nvdimm);
-
-/**
- * cxl_probe_device_regs() - Detect CXL Device register blocks
- * @dev: Host device of the @base mapping
- * @base: Mapping of CXL 2.0 8.2.8 CXL Device Register Interface
- * @map: Map object describing the register block information found
- *
- * Probe for device register information and return it in map object.
- */
-void cxl_probe_device_regs(struct device *dev, void __iomem *base,
-			   struct cxl_device_reg_map *map)
-{
-	int cap, cap_count;
-	u64 cap_array;
-
-	*map = (struct cxl_device_reg_map){ 0 };
-
-	cap_array = readq(base + CXLDEV_CAP_ARRAY_OFFSET);
-	if (FIELD_GET(CXLDEV_CAP_ARRAY_ID_MASK, cap_array) !=
-	    CXLDEV_CAP_ARRAY_CAP_ID)
-		return;
-
-	cap_count = FIELD_GET(CXLDEV_CAP_ARRAY_COUNT_MASK, cap_array);
-
-	for (cap = 1; cap <= cap_count; cap++) {
-		u32 offset, length;
-		u16 cap_id;
-
-		cap_id = FIELD_GET(CXLDEV_CAP_HDR_CAP_ID_MASK,
-				   readl(base + cap * 0x10));
-		offset = readl(base + cap * 0x10 + 0x4);
-		length = readl(base + cap * 0x10 + 0x8);
-
-		switch (cap_id) {
-		case CXLDEV_CAP_CAP_ID_DEVICE_STATUS:
-			dev_dbg(dev, "found Status capability (0x%x)\n", offset);
-
-			map->status.valid = true;
-			map->status.offset = offset;
-			map->status.size = length;
-			break;
-		case CXLDEV_CAP_CAP_ID_PRIMARY_MAILBOX:
-			dev_dbg(dev, "found Mailbox capability (0x%x)\n", offset);
-			map->mbox.valid = true;
-			map->mbox.offset = offset;
-			map->mbox.size = length;
-			break;
-		case CXLDEV_CAP_CAP_ID_SECONDARY_MAILBOX:
-			dev_dbg(dev, "found Secondary Mailbox capability (0x%x)\n", offset);
-			break;
-		case CXLDEV_CAP_CAP_ID_MEMDEV:
-			dev_dbg(dev, "found Memory Device capability (0x%x)\n", offset);
-			map->memdev.valid = true;
-			map->memdev.offset = offset;
-			map->memdev.size = length;
-			break;
-		default:
-			if (cap_id >= 0x8000)
-				dev_dbg(dev, "Vendor cap ID: %#x offset: %#x\n", cap_id, offset);
-			else
-				dev_dbg(dev, "Unknown cap ID: %#x offset: %#x\n", cap_id, offset);
-			break;
-		}
-	}
-}
-EXPORT_SYMBOL_GPL(cxl_probe_device_regs);
-
-static void __iomem *devm_cxl_iomap_block(struct device *dev,
-					  resource_size_t addr,
-					  resource_size_t length)
-{
-	void __iomem *ret_val;
-	struct resource *res;
-
-	res = devm_request_mem_region(dev, addr, length, dev_name(dev));
-	if (!res) {
-		resource_size_t end = addr + length - 1;
-
-		dev_err(dev, "Failed to request region %pa-%pa\n", &addr, &end);
-		return NULL;
-	}
-
-	ret_val = devm_ioremap(dev, addr, length);
-	if (!ret_val)
-		dev_err(dev, "Failed to map region %pr\n", res);
-
-	return ret_val;
-}
-
-int cxl_map_component_regs(struct pci_dev *pdev,
-			   struct cxl_component_regs *regs,
-			   struct cxl_register_map *map)
-{
-	struct device *dev = &pdev->dev;
-	resource_size_t phys_addr;
-	resource_size_t length;
-
-	phys_addr = pci_resource_start(pdev, map->barno);
-	phys_addr += map->block_offset;
-
-	phys_addr += map->component_map.hdm_decoder.offset;
-	length = map->component_map.hdm_decoder.size;
-	regs->hdm_decoder = devm_cxl_iomap_block(dev, phys_addr, length);
-	if (!regs->hdm_decoder)
-		return -ENOMEM;
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(cxl_map_component_regs);
-
-int cxl_map_device_regs(struct pci_dev *pdev,
-			struct cxl_device_regs *regs,
-			struct cxl_register_map *map)
-{
-	struct device *dev = &pdev->dev;
-	resource_size_t phys_addr;
-
-	phys_addr = pci_resource_start(pdev, map->barno);
-	phys_addr += map->block_offset;
-
-	if (map->device_map.status.valid) {
-		resource_size_t addr;
-		resource_size_t length;
-
-		addr = phys_addr + map->device_map.status.offset;
-		length = map->device_map.status.size;
-		regs->status = devm_cxl_iomap_block(dev, addr, length);
-		if (!regs->status)
-			return -ENOMEM;
-	}
-
-	if (map->device_map.mbox.valid) {
-		resource_size_t addr;
-		resource_size_t length;
-
-		addr = phys_addr + map->device_map.mbox.offset;
-		length = map->device_map.mbox.size;
-		regs->mbox = devm_cxl_iomap_block(dev, addr, length);
-		if (!regs->mbox)
-			return -ENOMEM;
-	}
-
-	if (map->device_map.memdev.valid) {
-		resource_size_t addr;
-		resource_size_t length;
-
-		addr = phys_addr + map->device_map.memdev.offset;
-		length = map->device_map.memdev.size;
-		regs->memdev = devm_cxl_iomap_block(dev, addr, length);
-		if (!regs->memdev)
-			return -ENOMEM;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(cxl_map_device_regs);
-
 /**
  * __cxl_driver_register - register a driver for the cxl bus
  * @cxl_drv: cxl driver structure to attach
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
new file mode 100644
index 000000000000..5e5862e4d6af
--- /dev/null
+++ b/drivers/cxl/core/core.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2020 Intel Corporation. */
+
+#ifndef __CXL_CORE_H__
+#define __CXL_CORE_H__
+
+#include <cxl.h>
+#include <mem.h>
+
+extern const struct device_type cxl_nvdimm_bridge_type;
+extern const struct device_type cxl_nvdimm_type;
+
+extern struct attribute_group cxl_base_attribute_group;
+
+static inline void unregister_cxl_dev(void *dev)
+{
+	device_unregister(dev);
+}
+
+#endif /* __CXL_CORE_H__ */
diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
new file mode 100644
index 000000000000..b6bf99c1c9bd
--- /dev/null
+++ b/drivers/cxl/core/pmem.c
@@ -0,0 +1,201 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2020 Intel Corporation. */
+
+#include <linux/device.h>
+#include <linux/slab.h>
+#include "core.h"
+
+static void cxl_nvdimm_bridge_release(struct device *dev)
+{
+	struct cxl_nvdimm_bridge *cxl_nvb = to_cxl_nvdimm_bridge(dev);
+
+	kfree(cxl_nvb);
+}
+
+static const struct attribute_group *cxl_nvdimm_bridge_attribute_groups[] = {
+	&cxl_base_attribute_group,
+	NULL,
+};
+
+const struct device_type cxl_nvdimm_bridge_type = {
+	.name = "cxl_nvdimm_bridge",
+	.release = cxl_nvdimm_bridge_release,
+	.groups = cxl_nvdimm_bridge_attribute_groups,
+};
+
+struct cxl_nvdimm_bridge *to_cxl_nvdimm_bridge(struct device *dev)
+{
+	if (dev_WARN_ONCE(dev, dev->type != &cxl_nvdimm_bridge_type,
+			  "not a cxl_nvdimm_bridge device\n"))
+		return NULL;
+	return container_of(dev, struct cxl_nvdimm_bridge, dev);
+}
+EXPORT_SYMBOL_GPL(to_cxl_nvdimm_bridge);
+
+static struct cxl_nvdimm_bridge *
+cxl_nvdimm_bridge_alloc(struct cxl_port *port)
+{
+	struct cxl_nvdimm_bridge *cxl_nvb;
+	struct device *dev;
+
+	cxl_nvb = kzalloc(sizeof(*cxl_nvb), GFP_KERNEL);
+	if (!cxl_nvb)
+		return ERR_PTR(-ENOMEM);
+
+	dev = &cxl_nvb->dev;
+	cxl_nvb->port = port;
+	cxl_nvb->state = CXL_NVB_NEW;
+	device_initialize(dev);
+	device_set_pm_not_required(dev);
+	dev->parent = &port->dev;
+	dev->bus = &cxl_bus_type;
+	dev->type = &cxl_nvdimm_bridge_type;
+
+	return cxl_nvb;
+}
+
+static void unregister_nvb(void *_cxl_nvb)
+{
+	struct cxl_nvdimm_bridge *cxl_nvb = _cxl_nvb;
+	bool flush;
+
+	/*
+	 * If the bridge was ever activated then there might be in-flight state
+	 * work to flush. Once the state has been changed to 'dead' then no new
+	 * work can be queued by user-triggered bind.
+	 */
+	device_lock(&cxl_nvb->dev);
+	flush = cxl_nvb->state != CXL_NVB_NEW;
+	cxl_nvb->state = CXL_NVB_DEAD;
+	device_unlock(&cxl_nvb->dev);
+
+	/*
+	 * Even though the device core will trigger device_release_driver()
+	 * before the unregister, it does not know about the fact that
+	 * cxl_nvdimm_bridge_driver defers ->remove() work. So, do the driver
+	 * release not and flush it before tearing down the nvdimm device
+	 * hierarchy.
+	 */
+	device_release_driver(&cxl_nvb->dev);
+	if (flush)
+		flush_work(&cxl_nvb->state_work);
+	device_unregister(&cxl_nvb->dev);
+}
+
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
+	rc = dev_set_name(dev, "nvdimm-bridge");
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
+EXPORT_SYMBOL_GPL(devm_cxl_add_nvdimm_bridge);
+
+static void cxl_nvdimm_release(struct device *dev)
+{
+	struct cxl_nvdimm *cxl_nvd = to_cxl_nvdimm(dev);
+
+	kfree(cxl_nvd);
+}
+
+static const struct attribute_group *cxl_nvdimm_attribute_groups[] = {
+	&cxl_base_attribute_group,
+	NULL,
+};
+
+const struct device_type cxl_nvdimm_type = {
+	.name = "cxl_nvdimm",
+	.release = cxl_nvdimm_release,
+	.groups = cxl_nvdimm_attribute_groups,
+};
+
+bool is_cxl_nvdimm(struct device *dev)
+{
+	return dev->type == &cxl_nvdimm_type;
+}
+EXPORT_SYMBOL_GPL(is_cxl_nvdimm);
+
+struct cxl_nvdimm *to_cxl_nvdimm(struct device *dev)
+{
+	if (dev_WARN_ONCE(dev, !is_cxl_nvdimm(dev),
+			  "not a cxl_nvdimm device\n"))
+		return NULL;
+	return container_of(dev, struct cxl_nvdimm, dev);
+}
+EXPORT_SYMBOL_GPL(to_cxl_nvdimm);
+
+static struct cxl_nvdimm *cxl_nvdimm_alloc(struct cxl_memdev *cxlmd)
+{
+	struct cxl_nvdimm *cxl_nvd;
+	struct device *dev;
+
+	cxl_nvd = kzalloc(sizeof(*cxl_nvd), GFP_KERNEL);
+	if (!cxl_nvd)
+		return ERR_PTR(-ENOMEM);
+
+	dev = &cxl_nvd->dev;
+	cxl_nvd->cxlmd = cxlmd;
+	device_initialize(dev);
+	device_set_pm_not_required(dev);
+	dev->parent = &cxlmd->dev;
+	dev->bus = &cxl_bus_type;
+	dev->type = &cxl_nvdimm_type;
+
+	return cxl_nvd;
+}
+
+int devm_cxl_add_nvdimm(struct device *host, struct cxl_memdev *cxlmd)
+{
+	struct cxl_nvdimm *cxl_nvd;
+	struct device *dev;
+	int rc;
+
+	cxl_nvd = cxl_nvdimm_alloc(cxlmd);
+	if (IS_ERR(cxl_nvd))
+		return PTR_ERR(cxl_nvd);
+
+	dev = &cxl_nvd->dev;
+	rc = dev_set_name(dev, "pmem%d", cxlmd->id);
+	if (rc)
+		goto err;
+
+	rc = device_add(dev);
+	if (rc)
+		goto err;
+
+	dev_dbg(host, "%s: register %s\n", dev_name(dev->parent),
+		dev_name(dev));
+
+	return devm_add_action_or_reset(host, unregister_cxl_dev, dev);
+
+err:
+	put_device(dev);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(devm_cxl_add_nvdimm);
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
new file mode 100644
index 000000000000..d05946a6bf53
--- /dev/null
+++ b/drivers/cxl/core/regs.c
@@ -0,0 +1,235 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2020 Intel Corporation. */
+
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <linux/pci.h>
+#include "core.h"
+
+/**
+ * cxl_probe_component_regs() - Detect CXL Component register blocks
+ * @dev: Host device of the @base mapping
+ * @base: Mapping containing the HDM Decoder Capability Header
+ * @map: Map object describing the register block information found
+ *
+ * See CXL 2.0 8.2.4 Component Register Layout and Definition
+ * See CXL 2.0 8.2.5.5 CXL Device Register Interface
+ *
+ * Probe for component register information and return it in map object.
+ */
+void cxl_probe_component_regs(struct device *dev, void __iomem *base,
+			      struct cxl_component_reg_map *map)
+{
+	int cap, cap_count;
+	u64 cap_array;
+
+	*map = (struct cxl_component_reg_map) { 0 };
+
+	/*
+	 * CXL.cache and CXL.mem registers are at offset 0x1000 as defined in
+	 * CXL 2.0 8.2.4 Table 141.
+	 */
+	base += CXL_CM_OFFSET;
+
+	cap_array = readq(base + CXL_CM_CAP_HDR_OFFSET);
+
+	if (FIELD_GET(CXL_CM_CAP_HDR_ID_MASK, cap_array) != CM_CAP_HDR_CAP_ID) {
+		dev_err(dev,
+			"Couldn't locate the CXL.cache and CXL.mem capability array header./n");
+		return;
+	}
+
+	/* It's assumed that future versions will be backward compatible */
+	cap_count = FIELD_GET(CXL_CM_CAP_HDR_ARRAY_SIZE_MASK, cap_array);
+
+	for (cap = 1; cap <= cap_count; cap++) {
+		void __iomem *register_block;
+		u32 hdr;
+		int decoder_cnt;
+		u16 cap_id, offset;
+		u32 length;
+
+		hdr = readl(base + cap * 0x4);
+
+		cap_id = FIELD_GET(CXL_CM_CAP_HDR_ID_MASK, hdr);
+		offset = FIELD_GET(CXL_CM_CAP_PTR_MASK, hdr);
+		register_block = base + offset;
+
+		switch (cap_id) {
+		case CXL_CM_CAP_CAP_ID_HDM:
+			dev_dbg(dev, "found HDM decoder capability (0x%x)\n",
+				offset);
+
+			hdr = readl(register_block);
+
+			decoder_cnt = cxl_hdm_decoder_count(hdr);
+			length = 0x20 * decoder_cnt + 0x10;
+
+			map->hdm_decoder.valid = true;
+			map->hdm_decoder.offset = CXL_CM_OFFSET + offset;
+			map->hdm_decoder.size = length;
+			break;
+		default:
+			dev_dbg(dev, "Unknown CM cap ID: %d (0x%x)\n", cap_id,
+				offset);
+			break;
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(cxl_probe_component_regs);
+
+/**
+ * cxl_probe_device_regs() - Detect CXL Device register blocks
+ * @dev: Host device of the @base mapping
+ * @base: Mapping of CXL 2.0 8.2.8 CXL Device Register Interface
+ * @map: Map object describing the register block information found
+ *
+ * Probe for device register information and return it in map object.
+ */
+void cxl_probe_device_regs(struct device *dev, void __iomem *base,
+			   struct cxl_device_reg_map *map)
+{
+	int cap, cap_count;
+	u64 cap_array;
+
+	*map = (struct cxl_device_reg_map){ 0 };
+
+	cap_array = readq(base + CXLDEV_CAP_ARRAY_OFFSET);
+	if (FIELD_GET(CXLDEV_CAP_ARRAY_ID_MASK, cap_array) !=
+	    CXLDEV_CAP_ARRAY_CAP_ID)
+		return;
+
+	cap_count = FIELD_GET(CXLDEV_CAP_ARRAY_COUNT_MASK, cap_array);
+
+	for (cap = 1; cap <= cap_count; cap++) {
+		u32 offset, length;
+		u16 cap_id;
+
+		cap_id = FIELD_GET(CXLDEV_CAP_HDR_CAP_ID_MASK,
+				   readl(base + cap * 0x10));
+		offset = readl(base + cap * 0x10 + 0x4);
+		length = readl(base + cap * 0x10 + 0x8);
+
+		switch (cap_id) {
+		case CXLDEV_CAP_CAP_ID_DEVICE_STATUS:
+			dev_dbg(dev, "found Status capability (0x%x)\n", offset);
+
+			map->status.valid = true;
+			map->status.offset = offset;
+			map->status.size = length;
+			break;
+		case CXLDEV_CAP_CAP_ID_PRIMARY_MAILBOX:
+			dev_dbg(dev, "found Mailbox capability (0x%x)\n", offset);
+			map->mbox.valid = true;
+			map->mbox.offset = offset;
+			map->mbox.size = length;
+			break;
+		case CXLDEV_CAP_CAP_ID_SECONDARY_MAILBOX:
+			dev_dbg(dev, "found Secondary Mailbox capability (0x%x)\n", offset);
+			break;
+		case CXLDEV_CAP_CAP_ID_MEMDEV:
+			dev_dbg(dev, "found Memory Device capability (0x%x)\n", offset);
+			map->memdev.valid = true;
+			map->memdev.offset = offset;
+			map->memdev.size = length;
+			break;
+		default:
+			if (cap_id >= 0x8000)
+				dev_dbg(dev, "Vendor cap ID: %#x offset: %#x\n", cap_id, offset);
+			else
+				dev_dbg(dev, "Unknown cap ID: %#x offset: %#x\n", cap_id, offset);
+			break;
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(cxl_probe_device_regs);
+
+static void __iomem *devm_cxl_iomap_block(struct device *dev,
+					  resource_size_t addr,
+					  resource_size_t length)
+{
+	void __iomem *ret_val;
+	struct resource *res;
+
+	res = devm_request_mem_region(dev, addr, length, dev_name(dev));
+	if (!res) {
+		resource_size_t end = addr + length - 1;
+
+		dev_err(dev, "Failed to request region %pa-%pa\n", &addr, &end);
+		return NULL;
+	}
+
+	ret_val = devm_ioremap(dev, addr, length);
+	if (!ret_val)
+		dev_err(dev, "Failed to map region %pr\n", res);
+
+	return ret_val;
+}
+
+int cxl_map_component_regs(struct pci_dev *pdev,
+			   struct cxl_component_regs *regs,
+			   struct cxl_register_map *map)
+{
+	struct device *dev = &pdev->dev;
+	resource_size_t phys_addr;
+	resource_size_t length;
+
+	phys_addr = pci_resource_start(pdev, map->barno);
+	phys_addr += map->block_offset;
+
+	phys_addr += map->component_map.hdm_decoder.offset;
+	length = map->component_map.hdm_decoder.size;
+	regs->hdm_decoder = devm_cxl_iomap_block(dev, phys_addr, length);
+	if (!regs->hdm_decoder)
+		return -ENOMEM;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cxl_map_component_regs);
+
+int cxl_map_device_regs(struct pci_dev *pdev,
+			struct cxl_device_regs *regs,
+			struct cxl_register_map *map)
+{
+	struct device *dev = &pdev->dev;
+	resource_size_t phys_addr;
+
+	phys_addr = pci_resource_start(pdev, map->barno);
+	phys_addr += map->block_offset;
+
+	if (map->device_map.status.valid) {
+		resource_size_t addr;
+		resource_size_t length;
+
+		addr = phys_addr + map->device_map.status.offset;
+		length = map->device_map.status.size;
+		regs->status = devm_cxl_iomap_block(dev, addr, length);
+		if (!regs->status)
+			return -ENOMEM;
+	}
+
+	if (map->device_map.mbox.valid) {
+		resource_size_t addr;
+		resource_size_t length;
+
+		addr = phys_addr + map->device_map.mbox.offset;
+		length = map->device_map.mbox.size;
+		regs->mbox = devm_cxl_iomap_block(dev, addr, length);
+		if (!regs->mbox)
+			return -ENOMEM;
+	}
+
+	if (map->device_map.memdev.valid) {
+		resource_size_t addr;
+		resource_size_t length;
+
+		addr = phys_addr + map->device_map.memdev.offset;
+		length = map->device_map.memdev.size;
+		regs->memdev = devm_cxl_iomap_block(dev, addr, length);
+		if (!regs->memdev)
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cxl_map_device_regs);
-- 
2.32.0

