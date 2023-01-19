Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46696C00A5A
	for <linux-cxl@archiver.kernel.org>; Thu, 19 Jan 2023 05:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjASFIq (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 19 Jan 2023 00:08:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjASFHy (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 19 Jan 2023 00:07:54 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6249975707
        for <linux-cxl@vger.kernel.org>; Wed, 18 Jan 2023 21:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674104575; x=1705640575;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5ZA3aABBuyh7lekWgCfd2NhDh26kgnzFSrHebyGhZRI=;
  b=Bfgn9FCFoIn9m7wBkMshu+8OjzZUFbBPRqv5T8lKjQHcpXmKmMdA4nDL
   g6tPwoDn+Zoog3Ic8pmtp+MPZimug8wVqwaKYK4qWuVSIb5/TZ/g9q08o
   GVWJScCyQx7VOXTOnOmq1QR01+uEZpyCC9L4mj4vRzjB9tWxCItJ1qWxC
   S+dSymauAH4KAroob7c4IlrZ8NlfjbK6qM/PO/w99Rj2fUNj5oKIyh9Be
   8euhvRoGu5vpPaSEo9Q0cdXZ1gDNggOgS394A5dqArbqd0IikdKhbPIHf
   /JFHk4214p93K/AemVFRHpNrSErx1RoEgPs+G9/vCf2f8QDrRQanyH6rP
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="304881145"
X-IronPort-AV: E=Sophos;i="5.97,228,1669104000"; 
   d="scan'208";a="304881145"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 21:00:24 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="783932554"
X-IronPort-AV: E=Sophos;i="5.97,228,1669104000"; 
   d="scan'208";a="783932554"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.119.104])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 21:00:24 -0800
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 1/6] cxl/memdev: Add support for the Inject Poison mailbox command
Date:   Wed, 18 Jan 2023 21:00:16 -0800
Message-Id: <97a0b128d0d0df56cea1a1a4ead65a40b9cf008e.1674101475.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1674101475.git.alison.schofield@intel.com>
References: <cover.1674101475.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

CXL devices optionally support the INJECT POISON mailbox command. Add
a sysfs attribute and memdev driver support for injecting poison.

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

The inject_poison attribute is only visible for devices supporting
the capability when the kernel is built with CONFIG_CXL_POISON_INJECT.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl | 22 ++++++++
 drivers/cxl/Kconfig                     | 10 ++++
 drivers/cxl/core/memdev.c               | 67 +++++++++++++++++++++++++
 drivers/cxl/cxlmem.h                    |  5 ++
 4 files changed, 104 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index b715a4609718..e9c6dd02bd09 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -416,3 +416,25 @@ Description:
 		if accessed, and the source of the poison. The retrieved
 		errors are logged as kernel trace events with the label
 		'cxl_poison'.
+
+
+What:		/sys/bus/cxl/devices/memX/inject_poison
+Date:		January, 2023
+KernelVersion:	v6.3
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
index 0ac53c422c31..6541f54725cd 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -129,4 +129,14 @@ config CXL_REGION_INVALIDATION_TEST
 	  If unsure, or if this kernel is meant for production environments,
 	  say N.
 
+config CXL_POISON_INJECT
+	bool "CXL: Support CXL Memory Device Poison Inject"
+	depends on CXL_MEM
+	help
+	  Selecting this option creates the sysfs attributes inject_poison
+	  and clear_poison for CXL memory devices supporting the capability.
+	  See Documentation/ABI/testing/sysfs-bus-cxl.
+
+	  If unsure, say N.
+
 endif
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index e0af7e9c9989..226662cf3331 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -142,6 +142,61 @@ static ssize_t trigger_poison_list_store(struct device *dev,
 }
 static DEVICE_ATTR_WO(trigger_poison_list);
 
+static int cxl_validate_poison_dpa(struct cxl_dev_state *cxlds, u64 dpa)
+{
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
+		dev_dbg(cxlds->dev, "dpa:0x%llx is not 64-byte aligned\n",
+			dpa);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static ssize_t inject_poison_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t len)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_mbox_inject_poison inject;
+	struct cxl_mbox_cmd mbox_cmd;
+	u64 dpa;
+	int rc;
+
+	rc = kstrtou64(buf, 0, &dpa);
+	if (rc)
+		return rc;
+
+	rc = cxl_validate_poison_dpa(cxlds, dpa);
+	if (rc)
+		return rc;
+
+	inject = (struct cxl_mbox_inject_poison) {
+		.address = cpu_to_le64(dpa)
+	};
+	mbox_cmd = (struct cxl_mbox_cmd) {
+		.opcode = CXL_MBOX_OP_INJECT_POISON,
+		.size_in = sizeof(inject),
+		.payload_in = &inject,
+	};
+
+	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
+	if (rc)
+		return rc;
+
+	return len;
+}
+static DEVICE_ATTR_WO(inject_poison);
+
 static struct attribute *cxl_memdev_attributes[] = {
 	&dev_attr_serial.attr,
 	&dev_attr_firmware_version.attr,
@@ -149,6 +204,7 @@ static struct attribute *cxl_memdev_attributes[] = {
 	&dev_attr_label_storage_size.attr,
 	&dev_attr_numa_node.attr,
 	&dev_attr_trigger_poison_list.attr,
+	&dev_attr_inject_poison.attr,
 	NULL,
 };
 
@@ -168,6 +224,10 @@ static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute *a,
 	if (!IS_ENABLED(CONFIG_NUMA) && a == &dev_attr_numa_node.attr)
 		return 0;
 
+	if (!IS_ENABLED(CONFIG_CXL_POISON_INJECT) &&
+	    a == &dev_attr_inject_poison.attr)
+		return 0;
+
 	if (a == &dev_attr_trigger_poison_list.attr) {
 		struct device *dev = kobj_to_dev(kobj);
 
@@ -175,6 +235,13 @@ static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute *a,
 			      to_cxl_memdev(dev)->cxlds->enabled_cmds))
 			return 0;
 	}
+	if (a == &dev_attr_inject_poison.attr) {
+		struct device *dev = kobj_to_dev(kobj);
+
+		if (!test_bit(CXL_MEM_COMMAND_ID_INJECT_POISON,
+			      to_cxl_memdev(dev)->cxlds->enabled_cmds))
+			return 0;
+	}
 	return a->mode;
 }
 
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 28ba0cd8f2d3..862ca4f4cc06 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -436,6 +436,11 @@ struct cxl_mbox_poison_payload_out {
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

