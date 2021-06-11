Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEF4C49360
	for <linux-cxl@archiver.kernel.org>; Fri, 11 Jun 2021 00:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55B99613D5
	for <linux-cxl@archiver.kernel.org>; Fri, 11 Jun 2021 00:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhFKAY3 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 10 Jun 2021 20:24:29 -0400
Received: from mga05.intel.com ([192.55.52.43]:34366 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231396AbhFKAY2 (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 10 Jun 2021 20:24:28 -0400
IronPort-SDR: /SYsY0Ib0NaCFgyXCGle6prNWVw+1jAYDZ/HVNDczKuP40sxEVuMUbd+TEi5CiiIAWF3Zcl8Za
 S+uoI9ABiDog==
X-IronPort-AV: E=McAfee;i="6200,9189,10011"; a="291064275"
X-IronPort-AV: E=Sophos;i="5.83,264,1616482800"; 
   d="scan'208";a="291064275"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 17:22:31 -0700
IronPort-SDR: PcsiBMx0cui7c74ucbclh7j8UrVuV0gF3hnz4N4LDj0Bz22jveN1h/7oOyht8y+KFOr364OqPB
 /3lc1PSIGQog==
X-IronPort-AV: E=Sophos;i="5.83,264,1616482800"; 
   d="scan'208";a="638530603"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 17:22:31 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH 3/3] cxl/mem: Add partition information to sysfs
Date:   Thu, 10 Jun 2021 17:22:24 -0700
Message-Id: <20210611002224.1594913-4-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20210611002224.1594913-1-ira.weiny@intel.com>
References: <20210611002224.1594913-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Partitionable space is added to the ram and pmem size sysfs attributes
but this does not show the entire story.

Add full partition information about the device under <sysfs>/partition.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/pci.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index bcc2829e4475..7e4e9605e4ed 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1226,6 +1226,42 @@ static ssize_t pmem_size_show(struct device *dev, struct device_attribute *attr,
 static struct device_attribute dev_attr_pmem_size =
 	__ATTR(size, 0444, pmem_size_show, NULL);
 
+static ssize_t part_vo_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_mem *cxlm = cxlmd->cxlm;
+
+	return sysfs_emit(buf, "%#llx\n", cxlm->volatile_cap_bytes);
+}
+
+static struct device_attribute dev_attr_part_vo =
+	__ATTR(volatile_only, 0444, part_vo_show, NULL);
+
+static ssize_t part_po_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_mem *cxlm = cxlmd->cxlm;
+
+	return sysfs_emit(buf, "%#llx\n", cxlm->persistent_cap_bytes);
+}
+
+static struct device_attribute dev_attr_part_po =
+	__ATTR(persistent_only, 0444, part_po_show, NULL);
+
+static ssize_t part_total_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_mem *cxlm = cxlmd->cxlm;
+
+	return sysfs_emit(buf, "%#llx\n", cxlm->total_cap_bytes);
+}
+
+static struct device_attribute dev_attr_part_total =
+	__ATTR(total, 0444, part_total_show, NULL);
+
 static struct attribute *cxl_memdev_attributes[] = {
 	&dev_attr_firmware_version.attr,
 	&dev_attr_payload_max.attr,
@@ -1243,6 +1279,13 @@ static struct attribute *cxl_memdev_ram_attributes[] = {
 	NULL,
 };
 
+static struct attribute *cxl_memdev_part_attributes[] = {
+	&dev_attr_part_vo.attr,
+	&dev_attr_part_po.attr,
+	&dev_attr_part_total.attr,
+	NULL,
+};
+
 static struct attribute_group cxl_memdev_attribute_group = {
 	.attrs = cxl_memdev_attributes,
 };
@@ -1257,10 +1300,16 @@ static struct attribute_group cxl_memdev_pmem_attribute_group = {
 	.attrs = cxl_memdev_pmem_attributes,
 };
 
+static struct attribute_group cxl_memdev_part_attribute_group = {
+	.name = "partition",
+	.attrs = cxl_memdev_part_attributes,
+};
+
 static const struct attribute_group *cxl_memdev_attribute_groups[] = {
 	&cxl_memdev_attribute_group,
 	&cxl_memdev_ram_attribute_group,
 	&cxl_memdev_pmem_attribute_group,
+	&cxl_memdev_part_attribute_group,
 	NULL,
 };
 
-- 
2.28.0.rc0.12.gb6a658bd00c9

