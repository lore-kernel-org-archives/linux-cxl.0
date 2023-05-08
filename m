Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44785C7EE22
	for <linux-cxl@archiver.kernel.org>; Mon,  8 May 2023 20:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbjEHUsN (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 8 May 2023 16:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjEHUsM (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 8 May 2023 16:48:12 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62A659FF
        for <linux-cxl@vger.kernel.org>; Mon,  8 May 2023 13:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683578891; x=1715114891;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Iz8HaHenMHkAaNw5LvBDDwYjz+eqlAY8w/hDmaiVtC0=;
  b=F52wKDQRHZ4z7W9b8TqW6/jwy5TeuIZfb/imtutaqP7wPlTkSyd1Jjoj
   ByTOjlzSg1ooio4RMXoKKjNgat3MNl4BmthuZlMc6bg54oprV6Ip9dOkD
   /ONBCV4rNyxF0j+1Yc9hipQ1vuEqtV5NcpoT40cBXre3Uc21tFPd4toHJ
   4f5zZTjsD3lM1Y+3PINTIBTT1UjLMrxsEjURGYLLfMwLbzBtUvQHSJyuZ
   7NOGqrqv1T5KxK31m4R0SF9dBd0ogy6KX5sCk/fAs4TyS1EjR+7M8NKKm
   5qnkoPeMedTElETAAgOgEj7EL7IotwI9Ebm0vnRLNDwZWDE42Z+QNq0TM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="436072464"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="436072464"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 13:48:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="944996826"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="944996826"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.213.172.228])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 13:48:11 -0700
Subject: [PATCH v5 13/14] cxl: Export sysfs attributes for memory device QoS
 class
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, Jonathan.Cameron@huawei.com
Date:   Mon, 08 May 2023 13:48:10 -0700
Message-ID: <168357889098.2756219.3746540473463747491.stgit@djiang5-mobl3>
In-Reply-To: <168357873843.2756219.5839806150467356492.stgit@djiang5-mobl3>
References: <168357873843.2756219.5839806150467356492.stgit@djiang5-mobl3>
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
v5:
- Change qtg_id to qos_class
v4:
- Change kernel version for documentation to v6.5
v3:
- Expand description of qtg_id. (Alison)
---
 Documentation/ABI/testing/sysfs-bus-cxl |   32 +++++++++++++++++++++++++++++++
 drivers/cxl/core/memdev.c               |   26 +++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 2f24e42ef36d..c13ae49dd9aa 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -28,6 +28,22 @@ Description:
 		Payload in the CXL-2.0 specification.
 
 
+What:		/sys/bus/cxl/devices/memX/ram/qos_class
+Date:		May, 2023
+KernelVersion:	v6.5
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) For CXL host platforms that support "QoS Telemmetry"
+		this attribute conveys a platform specific cookie that
+		identifies a QoS performance class for the volatile
+		partition of the CXL mem device. This class-id can be
+		compared against a similar "qos_class" published for
+		a root decoder. While it is not required that the endpoints
+		map their local memory-class to a matching platform class,
+		mismatches are not recommended and there are platform specific
+		side-effects that may result.
+
+
 What:		/sys/bus/cxl/devices/memX/pmem/size
 Date:		December, 2020
 KernelVersion:	v5.12
@@ -38,6 +54,22 @@ Description:
 		Payload in the CXL-2.0 specification.
 
 
+What:		/sys/bus/cxl/devices/memX/pmem/qos_class
+Date:		May, 2023
+KernelVersion:	v6.5
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) For CXL host platforms that support "QoS Telemmetry"
+		this attribute conveys a platform specific cookie that
+		identifies a QoS performance class for the persistent
+		partition of the CXL mem device. This class-id can be
+		compared against a similar "qos_class" published for
+		a root decoder. While it is not required that the endpoints
+		map their local memory-class to a matching platform class,
+		mismatches are not recommended and there are platform specific
+		side-effects that may result.
+
+
 What:		/sys/bus/cxl/devices/memX/serial
 Date:		January, 2022
 KernelVersion:	v5.18
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 28a05f2fe32d..8e183bef33e8 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -76,6 +76,18 @@ static ssize_t ram_size_show(struct device *dev, struct device_attribute *attr,
 static struct device_attribute dev_attr_ram_size =
 	__ATTR(size, 0444, ram_size_show, NULL);
 
+static ssize_t ram_qos_class_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+
+	return sysfs_emit(buf, "%d\n", cxlds->ram_qos_class);
+}
+
+static struct device_attribute dev_attr_ram_qos_class =
+	__ATTR(qos_class, 0444, ram_qos_class_show, NULL);
+
 static ssize_t pmem_size_show(struct device *dev, struct device_attribute *attr,
 			      char *buf)
 {
@@ -89,6 +101,18 @@ static ssize_t pmem_size_show(struct device *dev, struct device_attribute *attr,
 static struct device_attribute dev_attr_pmem_size =
 	__ATTR(size, 0444, pmem_size_show, NULL);
 
+static ssize_t pmem_qos_class_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+
+	return sysfs_emit(buf, "%d\n", cxlds->pmem_qos_class);
+}
+
+static struct device_attribute dev_attr_pmem_qos_class =
+	__ATTR(qos_class, 0444, pmem_qos_class_show, NULL);
+
 static ssize_t serial_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
@@ -117,11 +141,13 @@ static struct attribute *cxl_memdev_attributes[] = {
 
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
 


