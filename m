Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D92AC74A44
	for <linux-cxl@archiver.kernel.org>; Fri, 10 Mar 2023 18:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjCJSt1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 10 Mar 2023 13:49:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjCJSt0 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 10 Mar 2023 13:49:26 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E13E190D
        for <linux-cxl@vger.kernel.org>; Fri, 10 Mar 2023 10:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678474165; x=1710010165;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Io4XAc3eyT8VA8FYIWrI43jwi/ifWRXfGUE4mU8olQg=;
  b=j+I/m3inqzxCH6R6OGr0soRYK/Wcs6XFfGA/JtguTXZ/92w9oz4WGne6
   RvbgV7S8dNJty6MHHMFJv+33AW4inNpseIxGDlJ7Edo/X5WGuRydgXKBH
   8BOkX4T7xrpuiViP/wTOb3QMD8ltILrc2C4FJD3KEanuXIrfCCr9SCQ4M
   EIszqul9dZVIWwQtK6jCD9CZtHXKEUNol84wxkrZ6Nj/MYjip7FsMSPQP
   +HDeA7dzB6N2LxUdv2p5Vs6FMrOEvlFIXujjVoXtaGr4gTDdnWTcRzrbt
   PFp3nrDLR8vZOX/ZeXTdjj9aQnzKa5Pf7StkK5PedWXUzqtx87jwGsKDp
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="316452278"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="316452278"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 10:49:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="680292287"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="680292287"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.255.228.62])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 10:49:23 -0800
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v4 1/8] cxl/memdev: Add support for the Inject Poison mailbox command
Date:   Fri, 10 Mar 2023 10:49:02 -0800
Message-Id: <5e17d5f924ebeb2ba03b4c501bc3cf4fa2bb60f0.1678471465.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1678471465.git.alison.schofield@intel.com>
References: <cover.1678471465.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

CXL devices optionally support the INJECT POISON mailbox command. Add
a sysfs attribute and memdev driver support for injecting poison. The
attribute is only visible for devices supporting the capability when
the kernel is built with CONFIG_CXL_POISON_INJECT.

When a Device Physical Address (DPA) is written to the inject_poison
sysfs attribute, send an inject poison command to the device for the
specified address.

Per the CXL Specification (3.0 8.2.9.8.4.2), after receiving a valid
inject poison request, the device will return poison when the address
is accessed through the CXL.mem bus. Injecting poison adds the address
to the device's Poison List and the error source is set to Injected.
In addition, the device adds a poison creation event to its internal
Informational Event log, updates the Event Status register, and if
configured, interrupts the host.

Also, per the CXL Specification, it is not an error to inject poison
into an address that already has poison present and no error is
returned from the device.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl | 22 ++++++
 drivers/cxl/Kconfig                     | 11 +++
 drivers/cxl/core/memdev.c               | 97 +++++++++++++++++++++++++
 drivers/cxl/cxlmem.h                    |  5 ++
 4 files changed, 135 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 02776fee6d4c..e82bbc90390d 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -429,3 +429,25 @@ Description:
 		attribute is only visible for devices supporting the
 		capability. The retrieved errors are logged as kernel
 		trace events with the label 'cxl_poison'.
+
+
+What:		/sys/bus/cxl/devices/memX/inject_poison
+Date:		March, 2023
+KernelVersion:	v6.4
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(WO) When a Device Physical Address (DPA) is written to this
+		attribute, the memdev driver sends an inject poison command to
+		the device for the specified address. The DPA must be 64-byte
+		aligned and the length of the injected poison is 64-bytes. If
+		successful, the device returns poison when the address is
+		accessed through the CXL.mem bus. Injecting poison adds the
+		address to the device's Poison List and the error source is set
+		to Injected. In addition, the device adds a poison creation
+		event to its internal Informational Event log, updates the
+		Event Status register, and if configured, interrupts the host.
+		It is not an error to inject poison into an address that
+		already has poison present and no error is returned. The
+		inject_poison attribute is only visible for devices supporting
+		the capability. Kconfig option CXL_POISON_INJECT must be on
+		to enable this option. The default is off.
diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index ff4e78117b31..a7ca0bbb8475 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -139,4 +139,15 @@ config CXL_REGION_INVALIDATION_TEST
 	  If unsure, or if this kernel is meant for production environments,
 	  say N.
 
+config CXL_POISON_INJECT
+	bool "CXL: Support CXL Memory Device Poison Inject"
+	depends on CXL_MEM
+	help
+	  Selecting this option creates the sysfs attributes inject_poison
+	  and clear_poison for CXL memory devices supporting the capability.
+	  This option is intended for debug scenarios only and is disabled
+	  by default. See Documentation/ABI/testing/sysfs-bus-cxl.
+
+	  If unsure, say N.
+
 endif
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 5e65818d2171..5ea175ef5e6b 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -168,6 +168,92 @@ static ssize_t trigger_poison_list_store(struct device *dev,
 }
 static DEVICE_ATTR_WO(trigger_poison_list);
 
+static int cxl_dpa_mapped(struct device *dev, void *data)
+{
+	struct cxl_endpoint_decoder *cxled;
+	u64 *dpa = data;
+
+	if (!is_endpoint_decoder(dev))
+		return 0;
+
+	cxled = to_cxl_endpoint_decoder(dev);
+	if (!cxled->dpa_res || !resource_size(cxled->dpa_res))
+		return 0;
+
+	if (*dpa <= cxled->dpa_res->end && *dpa >= cxled->dpa_res->start) {
+		dev_dbg(dev, "dpa:0x%llx mapped in region:%s\n",
+			*dpa, dev_name(&cxled->cxld.region->dev));
+		return 1;
+	}
+
+	return 0;
+}
+
+static int cxl_validate_poison_dpa(struct cxl_memdev *cxlmd, u64 dpa)
+{
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_port *port;
+	int rc;
+
+	if (!resource_size(&cxlds->dpa_res)) {
+		dev_dbg(cxlds->dev, "device has no dpa resource\n");
+		return -EINVAL;
+	}
+	if (dpa < cxlds->dpa_res.start || dpa > cxlds->dpa_res.end) {
+		dev_dbg(cxlds->dev, "dpa:0x%llx not in resource:%pR\n",
+			dpa, &cxlds->dpa_res);
+		return -EINVAL;
+	}
+	if (!IS_ALIGNED(dpa, 64)) {
+		dev_dbg(cxlds->dev, "dpa:0x%llx is not 64-byte aligned\n", dpa);
+		return -EINVAL;
+	}
+	port = dev_get_drvdata(&cxlmd->dev);
+	if (port && is_cxl_endpoint(port) && port->commit_end != -1) {
+		rc = device_for_each_child(&port->dev, &dpa, cxl_dpa_mapped);
+		if (rc)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static ssize_t inject_poison_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t len)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_mbox_inject_poison inject;
+	struct cxl_mbox_cmd mbox_cmd;
+	u64 dpa;
+	int rc;
+
+	rc = kstrtou64(buf, 0, &dpa);
+	if (rc)
+		return rc;
+
+	down_read(&cxl_dpa_rwsem);
+	rc = cxl_validate_poison_dpa(cxlmd, dpa);
+	if (rc) {
+		up_read(&cxl_dpa_rwsem);
+		return rc;
+	}
+
+	inject = (struct cxl_mbox_inject_poison) {
+		.address = cpu_to_le64(dpa)
+	};
+	mbox_cmd = (struct cxl_mbox_cmd) {
+		.opcode = CXL_MBOX_OP_INJECT_POISON,
+		.size_in = sizeof(inject),
+		.payload_in = &inject,
+	};
+	rc = cxl_internal_send_cmd(cxlmd->cxlds, &mbox_cmd);
+
+	up_read(&cxl_dpa_rwsem);
+	return rc ? rc : len;
+}
+static DEVICE_ATTR_WO(inject_poison);
+
 static struct attribute *cxl_memdev_attributes[] = {
 	&dev_attr_serial.attr,
 	&dev_attr_firmware_version.attr,
@@ -175,6 +261,7 @@ static struct attribute *cxl_memdev_attributes[] = {
 	&dev_attr_label_storage_size.attr,
 	&dev_attr_numa_node.attr,
 	&dev_attr_trigger_poison_list.attr,
+	&dev_attr_inject_poison.attr,
 	NULL,
 };
 
@@ -201,6 +288,16 @@ static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute *a,
 			      to_cxl_memdev(dev)->cxlds->enabled_cmds))
 			return 0;
 	}
+	if (a == &dev_attr_inject_poison.attr) {
+		struct device *dev = kobj_to_dev(kobj);
+
+		if (!IS_ENABLED(CONFIG_CXL_POISON_INJECT))
+			return 0;
+
+		if (!test_bit(CXL_MEM_COMMAND_ID_INJECT_POISON,
+			      to_cxl_memdev(dev)->cxlds->enabled_cmds))
+			return 0;
+	}
 	return a->mode;
 }
 
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index a6eb1b42eb88..01d27f362cd6 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -602,6 +602,11 @@ struct cxl_mbox_poison_payload_out {
 #define CXL_POISON_SOURCE_INJECTED	3
 #define CXL_POISON_SOURCE_VENDOR	7
 
+/* Inject & Clear Poison  CXL 3.0 Spec 8.2.9.8.4.2/3 */
+struct cxl_mbox_inject_poison {
+	__le64 address;
+};
+
 /**
  * struct cxl_mem_command - Driver representation of a memory device command
  * @info: Command information as it exists for the UAPI
-- 
2.37.3

