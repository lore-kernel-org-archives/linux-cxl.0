Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B40E2C7EE32
	for <linux-cxl@archiver.kernel.org>; Fri, 19 May 2023 17:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjESRJd (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 19 May 2023 13:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbjESRJV (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 19 May 2023 13:09:21 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9876610FA
        for <linux-cxl@vger.kernel.org>; Fri, 19 May 2023 10:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684516143; x=1716052143;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C+IRYEmeky+jiKMTFQYjJ2nrfEME3gDPoL+KaHbx/BI=;
  b=iHuPo6VKJxkce5nUOwx9Ebi6oqItnRplgA76KfAS/4Dacy/4xOJ+jyNQ
   9F16INjxFdNDqvRH0vI1v+dcuk4ZH8MlSeEUBAZuHVBAbh2WAKnxbEhzh
   49nLSJPHaO6VADgsyeqCRd1T3glsnb1HQL67omwnYLqCJ0ZuxPzk5iDX9
   RGGp4cga67ecrB4fchcLD7Y+lTP+CL0g6dy+8+H+693C97oMNLH9GwgKh
   63vASSsFsZh/NguD1kpVmhOXiujCkHHHT/mpS4DLmiVBtTjEtzOLG6nFB
   ZdNVQOnqAijjmZkqxE/2sIJOP8TmfI/SoLWKePtTrICIWIaCohcdewT1d
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10715"; a="337018625"
X-IronPort-AV: E=Sophos;i="6.00,177,1681196400"; 
   d="scan'208";a="337018625"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2023 10:07:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10715"; a="846951245"
X-IronPort-AV: E=Sophos;i="6.00,177,1681196400"; 
   d="scan'208";a="846951245"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.29.189])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2023 10:07:34 -0700
Subject: [PATCH v6 10/11] cxl: Export sysfs attributes for memory device QoS
 class
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, Jonathan.Cameron@huawei.com
Date:   Fri, 19 May 2023 10:07:34 -0700
Message-ID: <168451605449.3470703.14744276101463857790.stgit@djiang5-mobl3>
In-Reply-To: <168451588868.3470703.3527256859632103687.stgit@djiang5-mobl3>
References: <168451588868.3470703.3527256859632103687.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Export qos_class sysfs attributes for the CXL memory device. The QoS clas
should show up as /sys/bus/cxl/devices/memX/ram/qos_class for the volatile
partition and /sys/bus/cxl/devices/memX/pmem/qos_class for the persistent
partition. The QTG ID is retrieved via _DSM after supplying the
calculated bandwidth and latency for the entire CXL path from device to
the CPU. This ID is used to match up to the root decoder QoS class to
determine which CFMWS the memory range of a hotplugged CXL mem device
should be assigned under.

While there may be multiple DSMAS exported by the device CDAT, the driver
will only expose the first QTG ID per partition in sysfs for now. In the
future when multiple QTG IDs are necessary, they can be exposed. [1]

[1]: https://lore.kernel.org/linux-cxl/167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local/T/#md2a47b1ead3e1ba08f50eab29a4af1aed1d215ab

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v6:
- Provide full ordered QTG IDs from _DSM. (Jonathan)
v5:
- Change qtg_id to qos_class
v4:
- Change kernel version for documentation to v6.5
v3:
- Expand description of qtg_id. (Alison)
---
 Documentation/ABI/testing/sysfs-bus-cxl |   34 +++++++++++++++++++
 drivers/cxl/core/memdev.c               |   55 +++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index ccfc7ecc61f5..7a4cacd382f9 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -28,6 +28,23 @@ Description:
 		Payload in the CXL-2.0 specification.
 
 
+What:		/sys/bus/cxl/devices/memX/ram/qos_class
+Date:		May, 2023
+KernelVersion:	v6.5
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) For CXL host platforms that support "QoS Telemmetry"
+		this attribute conveys a comma delimited list of platform
+		specific cookies that identifies a QoS performance class
+		for the volatile partition of the CXL mem device. These
+		class-ids can be compared against a similar "qos_class"
+		published for a root decoder. While it is not required
+		that the endpoints map their local memory-class to a
+		matching platform class, mismatches are not recommended
+		and there are platform specific side-effects that may
+		result.
+
+
 What:		/sys/bus/cxl/devices/memX/pmem/size
 Date:		December, 2020
 KernelVersion:	v5.12
@@ -38,6 +55,23 @@ Description:
 		Payload in the CXL-2.0 specification.
 
 
+What:		/sys/bus/cxl/devices/memX/pmem/qos_class
+Date:		May, 2023
+KernelVersion:	v6.5
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) For CXL host platforms that support "QoS Telemmetry"
+		this attribute conveys a comma delimited list of platform
+		specific cookies that identifies a QoS performance class
+		for the persistent partition of the CXL mem device. These
+		class-ids can be compared against a similar "qos_class"
+		published for a root decoder. While it is not required
+		that the endpoints map their local memory-class to a
+		matching platform class, mismatches are not recommended
+		and there are platform specific side-effects that may
+		result.
+
+
 What:		/sys/bus/cxl/devices/memX/serial
 Date:		January, 2022
 KernelVersion:	v5.18
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 057a43267290..9366257e3183 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -77,6 +77,32 @@ static ssize_t ram_size_show(struct device *dev, struct device_attribute *attr,
 static struct device_attribute dev_attr_ram_size =
 	__ATTR(size, 0444, ram_size_show, NULL);
 
+static ssize_t ram_qos_class_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct qos_class *qos_class = cxlds->ram_qos_class;
+	int count, i;
+
+	if (!qos_class)
+		return 0;
+
+	for (i = 0, count = 0; i < qos_class->nr; i++) {
+		count += sysfs_emit_at(buf, count, "%d",
+				       qos_class->entries[i]);
+		if (i + 1 == qos_class->nr)
+			count += sysfs_emit_at(buf, count, "\n");
+		else
+			count += sysfs_emit_at(buf, count, ", ");
+	}
+
+	return count;
+}
+
+static struct device_attribute dev_attr_ram_qos_class =
+	__ATTR(qos_class, 0444, ram_qos_class_show, NULL);
+
 static ssize_t pmem_size_show(struct device *dev, struct device_attribute *attr,
 			      char *buf)
 {
@@ -90,6 +116,33 @@ static ssize_t pmem_size_show(struct device *dev, struct device_attribute *attr,
 static struct device_attribute dev_attr_pmem_size =
 	__ATTR(size, 0444, pmem_size_show, NULL);
 
+static ssize_t pmem_qos_class_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct qos_class *qos_class = cxlds->pmem_qos_class;
+	int count, i;
+
+	if (!qos_class)
+		return 0;
+
+	for (i = 0, count = 0; i < qos_class->nr; i++) {
+		count += sysfs_emit_at(buf, count, "%d",
+				       qos_class->entries[i]);
+
+		if (i + 1 == qos_class->nr)
+			count += sysfs_emit_at(buf, count, "\n");
+		else
+			count += sysfs_emit_at(buf, count, ", ");
+	}
+
+	return count;
+}
+
+static struct device_attribute dev_attr_pmem_qos_class =
+	__ATTR(qos_class, 0444, pmem_qos_class_show, NULL);
+
 static ssize_t serial_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
@@ -344,11 +397,13 @@ static struct attribute *cxl_memdev_attributes[] = {
 
 static struct attribute *cxl_memdev_pmem_attributes[] = {
 	&dev_attr_pmem_size.attr,
+	&dev_attr_pmem_qos_class.attr,
 	NULL,
 };
 
 static struct attribute *cxl_memdev_ram_attributes[] = {
 	&dev_attr_ram_size.attr,
+	&dev_attr_ram_qos_class.attr,
 	NULL,
 };
 


