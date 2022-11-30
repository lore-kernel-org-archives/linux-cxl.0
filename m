Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC39EC47088
	for <linux-cxl@archiver.kernel.org>; Wed, 30 Nov 2022 04:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbiK3Eet (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 29 Nov 2022 23:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbiK3Een (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 29 Nov 2022 23:34:43 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DC955C84
        for <linux-cxl@vger.kernel.org>; Tue, 29 Nov 2022 20:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669782882; x=1701318882;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5cZfmmuNG8UN8a9/1iXtoDrmN0X5aqXhF850c9jyTDs=;
  b=POBjChHpGLY6LHh+V+y2ux4b0L8y4vTezIPnPPWd2roqFbFyRifJ+itA
   AmM4Gb5cl2BklhvQVmlv7CbHdnWGf85V3wHNodDctc8eTVcCxDptVQARN
   7+Gg4O7nihfzcYhtnuBsUnD89O4wc7V86/7meSOm6iK1L8ueiueXMyifn
   6m8jo09dZNbNG4KtwuhjoXJWwnz58Rs0OqE/jybJKXxXfZMX1UbcuYvDw
   RnRlnaUfP4/Un9IiLZ5HTwBUkeZ9L5QBlnXH+tzEFCNvZFy1V5THngYDa
   oSFloQLfXgrRXsPSiJ3chHsexqMgJWwnsOgjNMiWoOY/5LTKX/4Op78d6
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="379583230"
X-IronPort-AV: E=Sophos;i="5.96,205,1665471600"; 
   d="scan'208";a="379583230"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 20:34:42 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="594525689"
X-IronPort-AV: E=Sophos;i="5.96,205,1665471600"; 
   d="scan'208";a="594525689"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.50.166])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 20:34:41 -0800
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH 1/5] cxl/memdev: Add support for the Inject Poison mailbox command
Date:   Tue, 29 Nov 2022 20:34:33 -0800
Message-Id: <3c260749c833f51d5cad9ae3912debcdf8b82753.1669781852.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1669781852.git.alison.schofield@intel.com>
References: <cover.1669781852.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

CXL devices optionally support the INJECT POISON mailbox command. Add
a sysfs attribute and memdev driver support for injecting poison.

When a Device Physical Address (DPA) is written to the inject_poison
sysfs attribute send an inject poison command to the device for the
specified address.

Per the CXL Specification (8.2.9.8.4.2), after receiving a valid
inject poison request, the device will return poison when the address
is accessed through the CXL.mem bus. Injecting poison adds the address
to the device's Poison List and the error source is set to injected
error. In addition, the device adds a poison creation event to its
internal Informational Event log, updates the Event Status register,
and if configured, interrupts the host.

Also, per the CXL Specification, it is not an error to inject poison
into an address that already has poison present and no error is returned
from the device. The memdev driver performs basic sanity checking on the
address, however, it does not go as far as reading the poison list to see
if the address is on the list. That discovery is left to the device.

The inject_poison attribute is only visible for devices supporting
the capability.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl | 19 +++++++++
 drivers/cxl/core/memdev.c               | 53 +++++++++++++++++++++++++
 drivers/cxl/cxlmem.h                    |  3 ++
 3 files changed, 75 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index b715a4609718..20db97f7a1aa 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -416,3 +416,22 @@ Description:
 		if accessed, and the source of the poison. The retrieved
 		errors are logged as kernel trace events with the label
 		'cxl_poison'.
+
+
+What:		/sys/bus/cxl/devices/memX/inject_poison
+Date:		December, 2022
+KernelVersion:	v6.2
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(WO) When a Device Physical Address (DPA) is written to this
+		attribute the memdev driver sends an inject poison command to
+		the device for the specified address. If successful, the device
+		returns poison when the address is accessed through the CXL.mem
+		bus. Injecting poison adds the address to the device's Poison
+		List and the error source is set to injected error. In addition,
+		the device adds a poison creation event to its internal
+		Informational Event log, updates the Event Status register, and
+		if configured, interrupts the host. It is not an error to inject
+		poison into an address that already has poison present and no
+		error is returned. The inject_poison attribute is only visible
+                for devices supporting the capability.
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index d08b7295a01c..71130813030f 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -142,6 +142,51 @@ static ssize_t trigger_poison_list_store(struct device *dev,
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
+	if ((dpa & CXL_POISON_INJECT_RESERVED) != 0) {
+		dev_dbg(cxlds->dev, "dpa reserve bit(s) [5:0] set 0x%llx\n",
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
+	u64 dpa;
+	int rc;
+
+	rc = kstrtou64(buf, 0, &dpa);
+	if (rc)
+		return rc;
+	rc = cxl_validate_poison_dpa(cxlds, dpa);
+	if (rc)
+		return rc;
+
+	dpa = cpu_to_le64(dpa);
+	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_INJECT_POISON, &dpa,
+			       sizeof(dpa), NULL, cxlds->payload_size);
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
@@ -149,6 +194,7 @@ static struct attribute *cxl_memdev_attributes[] = {
 	&dev_attr_label_storage_size.attr,
 	&dev_attr_numa_node.attr,
 	&dev_attr_trigger_poison_list.attr,
+	&dev_attr_inject_poison.attr,
 	NULL,
 };
 
@@ -175,6 +221,13 @@ static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute *a,
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
index 19a9e545ac19..0d4c34be7335 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -396,6 +396,9 @@ struct cxl_mbox_poison_payload_out {
 #define CXL_POISON_SOURCE_INJECTED	3
 #define CXL_POISON_SOURCE_VENDOR	7
 
+/* Inject & Clear Poison  CXL 3.0 Spec 8.2.9.8.4.2/3 */
+#define CXL_POISON_INJECT_RESERVED	GENMASK_ULL(5, 0)
+
 /**
  * struct cxl_mem_command - Driver representation of a memory device command
  * @info: Command information as it exists for the UAPI
-- 
2.37.3

