Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA0BEB64D9
	for <linux-cxl@archiver.kernel.org>; Thu, 15 Jun 2023 01:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236934AbjFOBaT (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 14 Jun 2023 21:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236869AbjFOBaS (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 14 Jun 2023 21:30:18 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F0F2126
        for <linux-cxl@vger.kernel.org>; Wed, 14 Jun 2023 18:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686792616; x=1718328616;
  h=subject:from:to:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=zz/xoJThXx4zNCJuYveUUKwi5txNjIs3nY0bfnR4DY8=;
  b=UaXwj9nzcHboGP632MD+LmFYGW+YM/bPFn98iEqd49w9INeyn5NzWQNa
   S/V+1FVdIxRQwetNOiZL8VXWgJCOkfDLDN5OACpdCPcUvxpJ3QZDLB2md
   qsNVRJ9rspcqzEDcXq270UUXfc9IgGXv6o/j8l0Fv4T9Luuo0HbyAxUfC
   wyQEuvcqsFeMKAh9y0ispBVh1BTz7Xb1ZYgs7DOMhaIVKttImy3LLQyOa
   8bLxVrvAXGDi0LLBz4c24LsVmqZx2TSLIotpd1PU3B26cEXOGO91hPWe9
   jgrLTkHg6EuCET1Gav72qFxo7vrLb7snJP4/y5vRDBfV5/KxfQwbDeR8/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="338412367"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="338412367"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 18:30:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="782307125"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="782307125"
Received: from rtpearso-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.87.28])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 18:30:08 -0700
Subject: [PATCH v2 06/12] cxl/memdev: Make mailbox functionality optional
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Date:   Wed, 14 Jun 2023 18:30:07 -0700
Message-ID: <168679260782.3436160.7587293613945445365.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <168679257511.3436160.9707734364766526576.stgit@dwillia2-xfh.jf.intel.com>
References: <168679257511.3436160.9707734364766526576.stgit@dwillia2-xfh.jf.intel.com>
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
Once cxl-cli has dropped that requirement this workaround can be
deprecated.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/mbox.c   |    1 +
 drivers/cxl/core/memdev.c |   10 +++++++++-
 drivers/cxl/cxlmem.h      |   18 ++++++++++++++++++
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index ab9d455e8579..1990a5940b7c 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1272,6 +1272,7 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
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
index b1a72e01e4de..1b39afeb369e 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -254,6 +254,20 @@ struct cxl_poison_state {
 	struct mutex lock;  /* Protect reads of poison list */
 };
 
+/*
+ * enum cxl_devtype - delineate type-2 from a generic type-3 device
+ * @CXL_DEVTYPE_DEVMEM - Vendor specific CXL Type-2 device implementing HDM-D or
+ *			 HDM-DB, no requirement that this device implements a
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
@@ -272,6 +286,7 @@ struct cxl_poison_state {
  * @ram_res: Active Volatile memory capacity configuration
  * @component_reg_phys: register base of component registers
  * @serial: PCIe Device Serial Number
+ * @type: Generic Memory Class device or Vendor Specific Memory device
  */
 struct cxl_dev_state {
 	struct device *dev;
@@ -285,6 +300,7 @@ struct cxl_dev_state {
 	struct resource ram_res;
 	resource_size_t component_reg_phys;
 	u64 serial;
+	enum cxl_devtype type;
 };
 
 /**
@@ -343,6 +359,8 @@ struct cxl_memdev_state {
 static inline struct cxl_memdev_state *
 to_cxl_memdev_state(struct cxl_dev_state *cxlds)
 {
+	if (cxlds->type != CXL_DEVTYPE_CLASSMEM)
+		return NULL;
 	return container_of(cxlds, struct cxl_memdev_state, cxlds);
 }
 

