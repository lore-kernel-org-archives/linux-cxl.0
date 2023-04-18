Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97ED4C77B75
	for <linux-cxl@archiver.kernel.org>; Tue, 18 Apr 2023 17:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbjDRRjd (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 18 Apr 2023 13:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbjDRRjW (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 18 Apr 2023 13:39:22 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCFC9764
        for <linux-cxl@vger.kernel.org>; Tue, 18 Apr 2023 10:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681839560; x=1713375560;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cRXqcqpNg2tO6KNx1YiexRx+syom8U1DU5YRmRkis0M=;
  b=lt/4iqDLlu6a9rqFAroTECN4Vaopzh1x93Jl6dE6eIXNlmElKKjkQT76
   Oa/+uzMweQ84oOPizspL7tSbG2PrgoDs5X8T2BGlsVpWiIFNkd1W4LXtm
   Vgv9393AVrFmI+dLuAP8GeT8QD/RDeLwNf6r7A5Y07C1X+BTCGslhZhrW
   AcTUNU/9MBMEGx0WopEhqilfGCl4CRXqoAjotbYdyxDziqvoGwxyX5H7c
   SWhrrr+U5MjPNQJAGVE7mBnz24cS5XUJHxV7I17ZJ4YmvLC2+JZtyBXty
   8L0Ns6kjxZY4g55Zh/wHWxl8l9EnBDFt5didUqyjC9dB48259ivQjBOw4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="410470737"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="410470737"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 10:39:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="865505441"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="865505441"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.152.117])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 10:39:19 -0700
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v13 6/9] cxl/memdev: Add trigger_poison_list sysfs attribute
Date:   Tue, 18 Apr 2023 10:39:06 -0700
Message-Id: <1081cfdc8a349dc754779642d584707e56db26ba.1681838291.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1681838291.git.alison.schofield@intel.com>
References: <cover.1681838291.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

When a boolean 'true' is written to this attribute the memdev driver
retrieves the poison list from the device. The list consists of
addresses that are poisoned, or would result in poison if accessed,
and the source of the poison. This attribute is only visible for
devices supporting the capability. The retrieved errors are logged
as kernel events when cxl_poison event tracing is enabled.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl | 14 ++++++++
 drivers/cxl/core/memdev.c               | 43 +++++++++++++++++++++++++
 drivers/cxl/cxlmem.h                    |  3 +-
 drivers/cxl/mem.c                       | 43 +++++++++++++++++++++++++
 4 files changed, 102 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 3acf2f17a73f..48ac0d911801 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -415,3 +415,17 @@ Description:
 		1), and checks that the hardware accepts the commit request.
 		Reading this value indicates whether the region is committed or
 		not.
+
+
+What:		/sys/bus/cxl/devices/memX/trigger_poison_list
+Date:		April, 2023
+KernelVersion:	v6.4
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(WO) When a boolean 'true' is written to this attribute the
+		memdev driver retrieves the poison list from the device. The
+		list consists of addresses that are poisoned, or would result
+		in poison if accessed, and the source of the poison. This
+		attribute is only visible for devices supporting the
+		capability. The retrieved errors are logged as kernel
+		events when cxl_poison event tracing is enabled.
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 0af8856936dc..71f5ec6ba6c1 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -106,6 +106,49 @@ static ssize_t numa_node_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(numa_node);
 
+static int cxl_get_poison_by_memdev(struct cxl_memdev *cxlmd)
+{
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	u64 offset, length;
+	int rc = 0;
+
+	/* CXL 3.0 Spec 8.2.9.8.4.1 Separate pmem and ram poison requests */
+	if (resource_size(&cxlds->pmem_res)) {
+		offset = cxlds->pmem_res.start;
+		length = resource_size(&cxlds->pmem_res);
+		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
+		if (rc)
+			return rc;
+	}
+	if (resource_size(&cxlds->ram_res)) {
+		offset = cxlds->ram_res.start;
+		length = resource_size(&cxlds->ram_res);
+		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
+		/*
+		 * Invalid Physical Address is not an error for
+		 * volatile addresses. Device support is optional.
+		 */
+		if (rc == -EFAULT)
+			rc = 0;
+	}
+	return rc;
+}
+
+int cxl_trigger_poison_list(struct cxl_memdev *cxlmd)
+{
+	int rc;
+
+	rc = down_read_interruptible(&cxl_dpa_rwsem);
+	if (rc)
+		return rc;
+
+	rc = cxl_get_poison_by_memdev(cxlmd);
+	up_read(&cxl_dpa_rwsem);
+
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_trigger_poison_list, CXL);
+
 static struct attribute *cxl_memdev_attributes[] = {
 	&dev_attr_serial.attr,
 	&dev_attr_firmware_version.attr,
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 07775ab5af4e..68b9db545aae 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -145,7 +145,7 @@ struct cxl_mbox_cmd {
 	C(FWROLLBACK, -ENXIO, "rolled back to the previous active FW"),         \
 	C(FWRESET, -ENXIO, "FW failed to activate, needs cold reset"),		\
 	C(HANDLE, -ENXIO, "one or more Event Record Handles were invalid"),     \
-	C(PADDR, -ENXIO, "physical address specified is invalid"),		\
+	C(PADDR, -EFAULT, "physical address specified is invalid"),		\
 	C(POISONLMT, -ENXIO, "poison injection limit has been reached"),        \
 	C(MEDIAFAILURE, -ENXIO, "permanent issue with the media"),		\
 	C(ABORT, -ENXIO, "background cmd was aborted by device"),               \
@@ -688,6 +688,7 @@ int cxl_set_timestamp(struct cxl_dev_state *cxlds);
 int cxl_poison_state_init(struct cxl_dev_state *cxlds);
 int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 		       struct cxl_region *cxlr);
+int cxl_trigger_poison_list(struct cxl_memdev *cxlmd);
 
 #ifdef CONFIG_CXL_SUSPEND
 void cxl_mem_active_inc(void);
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 39c4b54f0715..b6a413facbd7 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -176,10 +176,53 @@ static int cxl_mem_probe(struct device *dev)
 	return devm_add_action_or_reset(dev, enable_suspend, NULL);
 }
 
+static ssize_t trigger_poison_list_store(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf, size_t len)
+{
+	bool trigger;
+	int rc;
+
+	if (kstrtobool(buf, &trigger) || !trigger)
+		return -EINVAL;
+
+	rc = cxl_trigger_poison_list(to_cxl_memdev(dev));
+
+	return rc ? rc : len;
+}
+static DEVICE_ATTR_WO(trigger_poison_list);
+
+static umode_t cxl_mem_visible(struct kobject *kobj, struct attribute *a, int n)
+{
+	if (a == &dev_attr_trigger_poison_list.attr) {
+		struct device *dev = kobj_to_dev(kobj);
+
+		if (!test_bit(CXL_POISON_ENABLED_LIST,
+			      to_cxl_memdev(dev)->cxlds->poison.enabled_cmds))
+			return 0;
+	}
+	return a->mode;
+}
+
+static struct attribute *cxl_mem_attrs[] = {
+	&dev_attr_trigger_poison_list.attr,
+	NULL
+};
+
+static struct attribute_group cxl_mem_group = {
+	.attrs = cxl_mem_attrs,
+	.is_visible = cxl_mem_visible,
+};
+
+__ATTRIBUTE_GROUPS(cxl_mem);
+
 static struct cxl_driver cxl_mem_driver = {
 	.name = "cxl_mem",
 	.probe = cxl_mem_probe,
 	.id = CXL_DEVICE_MEMORY_EXPANDER,
+	.drv = {
+		.dev_groups = cxl_mem_groups,
+	},
 };
 
 module_cxl_driver(cxl_mem_driver);
-- 
2.37.3

