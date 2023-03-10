Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C15C6FA99
	for <linux-cxl@archiver.kernel.org>; Fri, 10 Mar 2023 18:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjCJSt2 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 10 Mar 2023 13:49:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjCJSt2 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 10 Mar 2023 13:49:28 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB18DE190D
        for <linux-cxl@vger.kernel.org>; Fri, 10 Mar 2023 10:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678474166; x=1710010166;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=coP8Dj9fVFKw2AdhTjSXNfCbezadZAo7RdO+AQhrLdM=;
  b=cQ60wb+9Eu8KqcRTZIFnmW/hVamB8twRybpxENcmIKbahTzAvMtZyQGp
   5HpRIT3ZUPBd49kyF2ChhxGRDSuFT2gyy8jlRlHWqbimjJIOWb6Reyu1r
   JLgQAw1KTiTbPBDk9tVef1P2Vb7ebdOTnLaLDBhWktn0lbMl0Q4gjGiFn
   lLDrZDSpSDqnNVoaIV2kmTxK+5QSaAbxQBNEJkoFbem6NyjXQgQdBXdds
   Aw2ZDvqcz1qi3jjCkYwDw6i6rPdlDmyPGH9JKi1z2wBoJwesw2uZkkNX7
   ebxxeEW/gqQvNM2RJvPn5QP5sS0XPgOYkGa9GP/WOZhEu9iSYTE4B0JRK
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="316452294"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="316452294"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 10:49:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="680292294"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="680292294"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.255.228.62])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 10:49:25 -0800
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v4 2/8] cxl/memdev: Add support for the Clear Poison mailbox command
Date:   Fri, 10 Mar 2023 10:49:03 -0800
Message-Id: <98843b78e53834be2d79a95c6b6a51cea295fc2b.1678471465.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1678471465.git.alison.schofield@intel.com>
References: <cover.1678471465.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

CXL devices optionally support the CLEAR POISON mailbox command. Add
a sysfs attribute and memdev driver support for clearing poison. The
attribute is only visible for devices supporting the capability when
the kernel is built with CONFIG_CXL_POISON_INJECT.

When a Device Physical Address (DPA) is written to the clear_poison
sysfs attribute, send a clear poison command to the device for the
specified address.

Per the CXL Specification (3.0 8.2.9.8.4.3), after receiving a valid
clear poison request, the device removes the address from the device's
Poison List and writes 0 (zero) for 64 bytes starting at address. If
the device cannot clear poison from the address, it returns a permanent
media error and -ENXIO is returned to the user.

Additionally, and per the spec also, it is not an error to clear poison
of an address that is not poisoned. In this case, the device does not
overwrite the address and the device does not return an error.

*Implementation note: Although the CXL specification defines the clear
command to accept 64 bytes of 'write-data' to be used when clearing
the poisoned address, this implementation always uses 0 (zeros) for
the write-data.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl | 18 ++++++++
 drivers/cxl/core/memdev.c               | 59 +++++++++++++++++++++++++
 drivers/cxl/cxlmem.h                    |  6 +++
 3 files changed, 83 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index e82bbc90390d..d277f18699be 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -451,3 +451,21 @@ Description:
 		inject_poison attribute is only visible for devices supporting
 		the capability. Kconfig option CXL_POISON_INJECT must be on
 		to enable this option. The default is off.
+
+
+What:		/sys/bus/cxl/devices/memX/clear_poison
+Date:		March, 2023
+KernelVersion:	v6.4
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
index 5ea175ef5e6b..5dd334c4caf2 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -254,6 +254,53 @@ static ssize_t inject_poison_store(struct device *dev,
 }
 static DEVICE_ATTR_WO(inject_poison);
 
+static ssize_t clear_poison_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t len)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_mbox_clear_poison clear;
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
+	rc = cxl_internal_send_cmd(cxlmd->cxlds, &mbox_cmd);
+
+	up_read(&cxl_dpa_rwsem);
+	return rc ? rc : len;
+}
+static DEVICE_ATTR_WO(clear_poison);
+
 static struct attribute *cxl_memdev_attributes[] = {
 	&dev_attr_serial.attr,
 	&dev_attr_firmware_version.attr,
@@ -262,6 +309,7 @@ static struct attribute *cxl_memdev_attributes[] = {
 	&dev_attr_numa_node.attr,
 	&dev_attr_trigger_poison_list.attr,
 	&dev_attr_inject_poison.attr,
+	&dev_attr_clear_poison.attr,
 	NULL,
 };
 
@@ -298,6 +346,17 @@ static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute *a,
 			      to_cxl_memdev(dev)->cxlds->enabled_cmds))
 			return 0;
 	}
+	if (a == &dev_attr_clear_poison.attr) {
+		struct device *dev = kobj_to_dev(kobj);
+
+		if (!IS_ENABLED(CONFIG_CXL_POISON_INJECT))
+			return 0;
+
+		if (!test_bit(CXL_MEM_COMMAND_ID_CLEAR_POISON,
+			      to_cxl_memdev(dev)->cxlds->enabled_cmds)) {
+			return 0;
+		}
+	}
 	return a->mode;
 }
 
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 01d27f362cd6..8a15274789a6 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -607,6 +607,12 @@ struct cxl_mbox_inject_poison {
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

