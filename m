Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC03C38142
	for <linux-cxl@archiver.kernel.org>; Thu, 19 Jan 2023 05:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjASFIw (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 19 Jan 2023 00:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjASFH4 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 19 Jan 2023 00:07:56 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCC375708
        for <linux-cxl@vger.kernel.org>; Wed, 18 Jan 2023 21:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674104579; x=1705640579;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Sx0uccQ4oosE1n2lxfynE6BZ19LOQBqwXaC5rCcdO6c=;
  b=I7NtJJs41Gc7drDp3uxeyRzmpUqRFdJ5EefRGt1qtFdw2xcuwkURrRUL
   mrgkFaAMYoyvBcty7eFpublUrejV+/q8EG1jZrRR9FBaEHJCnd5+gxDZn
   0BOHSkEtpUexZ8hehlutah79Ru0zPDgI/g1sEhX6anb91VMFUUU6WtuwQ
   cIogRwU7pdr/QolWoPQfV7dFc+Gb4nFWMB93Dg4jtrWU4WKnisA4wTwH9
   TxpaKI0UzO5JR7cEWw5UAX/v57pWe9v2zNKX8gn0BVjUOP/jxfLs651jW
   zTJluzuK6Jm8JRYyJf2vpkrjPGajHavnbV+UIhCpsQjLC/CsW6NPKKKcU
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="304881180"
X-IronPort-AV: E=Sophos;i="5.97,228,1669104000"; 
   d="scan'208";a="304881180"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 21:00:25 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="783932561"
X-IronPort-AV: E=Sophos;i="5.97,228,1669104000"; 
   d="scan'208";a="783932561"
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
Subject: [PATCH v2 2/6] cxl/memdev: Add support for the Clear Poison mailbox command
Date:   Wed, 18 Jan 2023 21:00:17 -0800
Message-Id: <3ae253f32602a62fa7521d5787b1b26b1c808275.1674101475.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1674101475.git.alison.schofield@intel.com>
References: <cover.1674101475.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

CXL devices optionally support the CLEAR POISON mailbox command. Add
a sysfs attribute and memdev driver support for clearing poison.

When a Device Physical Address (DPA) is written to the clear_poison
sysfs attribute, send a clear poison command to the device for the
specified address.

Per the CXL Specification (3.0 8.2.9.8.4.3), after receiving a valid clear
poison request, the device removes the address from the device's Poison
List and writes 0 (zero) for 64 bytes starting at address. If the device
cannot clear poison from the address, it returns a permanent media error
and -ENXIO is returned to the user.

Additionally, and per the spec also, it is not an error to clear poison
of an address that is not poisoned. No error is returned from the device
and the address is not overwritten.

*Implementation note: Although the CXL specification defines the clear
command to accept 64 bytes of 'write-data' to be used when clearing
the poisoned address, this implementation always uses 0 (zeros) for
the write-data.

The clear_poison attribute is only visible for devices supporting the
capability when the kernel is built with CONFIG_CXL_POISON_INJECT.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl | 18 ++++++++
 drivers/cxl/core/memdev.c               | 57 ++++++++++++++++++++++++-
 drivers/cxl/cxlmem.h                    |  6 +++
 3 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index e9c6dd02bd09..7e4897e7bc05 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -438,3 +438,21 @@ Description:
 		inject_poison attribute is only visible for devices supporting
 		the capability. Kconfig option CXL_POISON_INJECT must be on
 		to enable this option. The default is off.
+
+
+What:		/sys/bus/cxl/devices/memX/clear_poison
+Date:		January, 2023
+KernelVersion:	v6.3
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(WO) When a Device Physical Address (DPA) is written to this
+		attribute, the memdev driver sends a clear poison command to
+		the device for the specified address. Clearing poison removes
+		the address from the device's Poison List and writes 0 (zero)
+		for 64 bytes starting at address. It is not an error to clear
+		poison from an address that does not have poison set, and if
+		poison was not set, the address is not overwritten. If the
+		device cannot clear poison from the address, -ENXIO is returned.
+		The clear_poison attribute is only visible for devices
+		supporting the capability. Kconfig option CXL_POISON_INJECT
+		must be on to enable this option. The default is off.
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 226662cf3331..4d86a4565c9e 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -197,6 +197,51 @@ static ssize_t inject_poison_store(struct device *dev,
 }
 static DEVICE_ATTR_WO(inject_poison);
 
+static ssize_t clear_poison_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t len)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_mbox_clear_poison clear;
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
+	/*
+	 * In CXL 3.0 Spec 8.2.9.8.4.3, the Clear Poison mailbox command
+	 * is defined to accept 64 bytes of 'write-data', along with the
+	 * address to clear. The device writes the data into the address
+	 * atomically, while clearing poison if the location is marked as
+	 * being poisoned.
+	 *
+	 * Always use '0' for the write-data.
+	 */
+	clear = (struct cxl_mbox_clear_poison) {
+		.address = cpu_to_le64(dpa)
+	};
+
+	mbox_cmd = (struct cxl_mbox_cmd) {
+		.opcode = CXL_MBOX_OP_CLEAR_POISON,
+		.size_in = sizeof(clear),
+		.payload_in = &clear,
+	};
+
+	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
+	if (rc)
+		return rc;
+
+	return len;
+}
+static DEVICE_ATTR_WO(clear_poison);
+
 static struct attribute *cxl_memdev_attributes[] = {
 	&dev_attr_serial.attr,
 	&dev_attr_firmware_version.attr,
@@ -205,6 +250,7 @@ static struct attribute *cxl_memdev_attributes[] = {
 	&dev_attr_numa_node.attr,
 	&dev_attr_trigger_poison_list.attr,
 	&dev_attr_inject_poison.attr,
+	&dev_attr_clear_poison.attr,
 	NULL,
 };
 
@@ -225,7 +271,8 @@ static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute *a,
 		return 0;
 
 	if (!IS_ENABLED(CONFIG_CXL_POISON_INJECT) &&
-	    a == &dev_attr_inject_poison.attr)
+	    (a == &dev_attr_inject_poison.attr ||
+	     a == &dev_attr_clear_poison.attr))
 		return 0;
 
 	if (a == &dev_attr_trigger_poison_list.attr) {
@@ -242,6 +289,14 @@ static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute *a,
 			      to_cxl_memdev(dev)->cxlds->enabled_cmds))
 			return 0;
 	}
+	if (a == &dev_attr_clear_poison.attr) {
+		struct device *dev = kobj_to_dev(kobj);
+
+		if (!test_bit(CXL_MEM_COMMAND_ID_CLEAR_POISON,
+			      to_cxl_memdev(dev)->cxlds->enabled_cmds)) {
+			return 0;
+		}
+	}
 	return a->mode;
 }
 
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 862ca4f4cc06..adcbd4a98819 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -441,6 +441,12 @@ struct cxl_mbox_inject_poison {
 	__le64 address;
 };
 
+/* Clear Poison  CXL 3.0 Spec 8.2.9.8.4.3 */
+struct cxl_mbox_clear_poison {
+	__le64 address;
+	u8 write_data[CXL_POISON_LEN_MULT];
+} __packed;
+
 /**
  * struct cxl_mem_command - Driver representation of a memory device command
  * @info: Command information as it exists for the UAPI
-- 
2.37.3

