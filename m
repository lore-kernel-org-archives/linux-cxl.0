Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2295EC7EE2D
	for <linux-cxl@archiver.kernel.org>; Sun,  4 Jun 2023 23:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbjFDXcC (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 4 Jun 2023 19:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232526AbjFDXcB (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 4 Jun 2023 19:32:01 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625F2AB
        for <linux-cxl@vger.kernel.org>; Sun,  4 Jun 2023 16:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685921520; x=1717457520;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YWxyujD062M/qDP72JB9fA9thx57E9s72nvmHGUugsU=;
  b=NWBKm1OXXqFUU6YRKOPcypk+qHqz7Ehg7vQlXdirDubiV62ocl96mXBZ
   kueK+ELAOKiD87hWETzWCNglgDuUvYl1y+H6Ho3T9I9JMC2QNuLEKFBG4
   5jrry0pS/fz1RSkBx5AWjJ2GkdRsCqJrOWh7zvYjLBRp0QbxZJhmeXRbC
   S4tdQb0VPcxBW2x0mGnA6+SMEhgieRLPhizKqZ326Dju1LlRcM6J+IKH2
   gTTo+/uy5ccMROrGJQKEpllN7zqA37HLhKUwdfk5DOusdpdW56+8r6O4J
   VdH5QwtZ+MBkTFA9jHa7/xdwmxIJU41zULDAy04L33uJ8an/SapmG0F1P
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="384534729"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="384534729"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 16:32:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="832611398"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="832611398"
Received: from ezaker-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.85.189])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 16:31:59 -0700
Subject: [PATCH 04/19] cxl/memdev: Make mailbox functionality optional
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     ira.weiny@intel.com, navneet.singh@intel.com
Date:   Sun, 04 Jun 2023 16:31:59 -0700
Message-ID: <168592151963.1948938.7831940219025967692.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
References: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

In support of the Linux CXL core scaling for a wider set of CXL devices,
allow for the creation of memdevs with some memory device capabilities
disabled. Specifically, allow for CXL devices outside of those claiming
to be compliant with the generic CXL memory device class code, like
vendor specific Type-2/3 devices that host CXL.mem. This implies, allow
for the creation of memdevs that only support component-registers, not
necessarily memory-device-registers (like mailbox registers). A memdev
derived from a CXL endpoint that does not support generic class code
expectations is tagged "CXL_DEVTYPE_DEVMEM", while a memdev derived from a
class-code compliant endpoint is tagged "CXL_DEVTYPE_CLASSMEM".

The primary assumption of a CXL_DEVTYPE_DEVMEM memdev is that it
optionally may not host a mailbox. Disable the command passthrough ioctl
for memdevs that are not CXL_DEVTYPE_CLASSMEM, and return empty strings
from memdev attributes associated with data retrieved via the
class-device-standard IDENTIFY command. Note that empty strings were
chosen over attribute visibility to maintain compatibility with shipping
versions of cxl-cli that expect those attributes to always be present.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/mbox.c   |    1 +
 drivers/cxl/core/memdev.c |   10 +++++++++-
 drivers/cxl/cxlmem.h      |   18 ++++++++++++++++++
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 14805dae5a74..3ca0bf12c55f 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1273,6 +1273,7 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
 	mutex_init(&mds->mbox_mutex);
 	mutex_init(&mds->event.log_lock);
 	mds->cxlds.dev = dev;
+	mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
 
 	return mds;
 }
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 15434b1b4909..3f2d54f30548 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -41,6 +41,8 @@ static ssize_t firmware_version_show(struct device *dev,
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
 
+	if (!mds)
+		return sysfs_emit(buf, "\n");
 	return sysfs_emit(buf, "%.16s\n", mds->firmware_version);
 }
 static DEVICE_ATTR_RO(firmware_version);
@@ -52,6 +54,8 @@ static ssize_t payload_max_show(struct device *dev,
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
 
+	if (!mds)
+		return sysfs_emit(buf, "\n");
 	return sysfs_emit(buf, "%zu\n", mds->payload_size);
 }
 static DEVICE_ATTR_RO(payload_max);
@@ -63,6 +67,8 @@ static ssize_t label_storage_size_show(struct device *dev,
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
 
+	if (!mds)
+		return sysfs_emit(buf, "\n");
 	return sysfs_emit(buf, "%zu\n", mds->lsa_size);
 }
 static DEVICE_ATTR_RO(label_storage_size);
@@ -517,10 +523,12 @@ static long cxl_memdev_ioctl(struct file *file, unsigned int cmd,
 			     unsigned long arg)
 {
 	struct cxl_memdev *cxlmd = file->private_data;
+	struct cxl_dev_state *cxlds;
 	int rc = -ENXIO;
 
 	down_read(&cxl_memdev_rwsem);
-	if (cxlmd->cxlds)
+	cxlds = cxlmd->cxlds;
+	if (cxlds && cxlds->type == CXL_DEVTYPE_CLASSMEM)
 		rc = __cxl_memdev_ioctl(cxlmd, cmd, arg);
 	up_read(&cxl_memdev_rwsem);
 
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index d3fe73d5ba4d..b8bdf7490d2c 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -254,6 +254,20 @@ struct cxl_poison_state {
 	struct mutex lock;  /* Protect reads of poison list */
 };
 
+/*
+ * enum cxl_devtype - delineate type-2 from a generic type-3 device
+ * @CXL_DEVTYPE_DEVMEM - Vendor specific CXL Type-2 device implementing HDM-D or
+ *			 HDM-DB, no expectation that this device implements a
+ *			 mailbox, or other memory-device-standard manageability
+ *			 flows.
+ * @CXL_DEVTYPE_CLASSMEM - Common class definition of a CXL Type-3 device with
+ *			   HDM-H and class-mandatory memory device registers
+ */
+enum cxl_devtype {
+	CXL_DEVTYPE_DEVMEM,
+	CXL_DEVTYPE_CLASSMEM,
+};
+
 /**
  * struct cxl_dev_state - The driver device state
  *
@@ -273,6 +287,7 @@ struct cxl_poison_state {
  * @component_reg_phys: register base of component registers
  * @info: Cached DVSEC information about the device.
  * @serial: PCIe Device Serial Number
+ * @type: Generic Memory Class device or Vendor Specific Memory device
  */
 struct cxl_dev_state {
 	struct device *dev;
@@ -286,6 +301,7 @@ struct cxl_dev_state {
 	struct resource ram_res;
 	resource_size_t component_reg_phys;
 	u64 serial;
+	enum cxl_devtype type;
 };
 
 /**
@@ -344,6 +360,8 @@ struct cxl_memdev_state {
 static inline struct cxl_memdev_state *
 to_cxl_memdev_state(struct cxl_dev_state *cxlds)
 {
+	if (cxlds->type != CXL_DEVTYPE_CLASSMEM)
+		return NULL;
 	return container_of(cxlds, struct cxl_memdev_state, cxlds);
 }
 

