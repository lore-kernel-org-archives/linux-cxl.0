Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E31EB64D8
	for <linux-cxl@archiver.kernel.org>; Wed, 14 Jun 2023 19:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbjFNTTq (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 14 Jun 2023 15:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjFNTTp (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 14 Jun 2023 15:19:45 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954EB2135
        for <linux-cxl@vger.kernel.org>; Wed, 14 Jun 2023 12:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686770384; x=1718306384;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to;
  bh=wc3sJukGyeQA36C7Ys0D/O75E9VKGDdHLKsuYCJXNV0=;
  b=DB+alultGLMxge1Xi++nfZwlGZgLUiXV0yYcwS0P4jvSLBd+Ggwi6X5Q
   KB92dwccXd7rs/YD1xqqUezj7yNy9p8ln8IA4YA5M2Fs0MTJJ1Mz5SSwx
   k7ZmqugjMEUTUEoHwTODG5d6sOp8aSfRt0yv8n+m9T6l1boZGChCGA4XC
   lHEjkFlXsinTCTPecg2EnST0rgKIJoXhzhyCE1k7I3xsmKqLMLygZ2Dlr
   e1ZWlJ9DnS2VlwXqOA0+N4aC9B+ItYPBz5xd9FcDZDJ+aUD3LKrKLfUHo
   Gnz2SPv5ICebgxarNAUo+Pv15dzU8YC9a2Zv6Xvk1mloT+5bdIUA6Qim4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="338347329"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="338347329"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 12:19:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="886384262"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="886384262"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.116.198])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 12:19:42 -0700
From:   ira.weiny@intel.com
Date:   Wed, 14 Jun 2023 12:16:30 -0700
Subject: [PATCH 3/5] cxl/mem : Expose dynamic capacity configuration to
 userspace
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230604-dcd-type2-upstream-v1-3-71b6341bae54@intel.com>
References: <20230604-dcd-type2-upstream-v1-0-71b6341bae54@intel.com>
In-Reply-To: <20230604-dcd-type2-upstream-v1-0-71b6341bae54@intel.com>
To:     Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org
X-Mailer: b4 0.13-dev-9a8cd
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686770367; l=3766;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=fljXcPz+ZQgKoffq99siBW3SK44DWVen0PdBI49pnCM=;
 b=+M2qKT6J7yGGimy4rXyHTr1x1qQJ2lTdEkAGcMTfPebtq7VOu3ZHcl3lQxT+01YYQm4ksyUXw
 O1ZsrSSHtwlAx9gNlabVqPHnOfrVMc72hYYFwWIp/8cMxlEz0J+ntvx
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Navneet Singh <navneet.singh@intel.com>

Exposing driver cached dynamic capacity configuration through sysfs
attributes.User will create one or more dynamic capacity
cxl regions based on this information and map the dynamic capacity of
the device into HDM ranges using one or more HDM decoders.

Signed-off-by: Navneet Singh <navneet.singh@intel.com>

---
[iweiny: fixups]
[djbw: fixups, no sign-off: preview only]
---
 drivers/cxl/core/memdev.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 5d1ba7a72567..beeb5fa3a0aa 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -99,6 +99,20 @@ static ssize_t pmem_size_show(struct device *dev, struct device_attribute *attr,
 static struct device_attribute dev_attr_pmem_size =
 	__ATTR(size, 0444, pmem_size_show, NULL);
 
+static ssize_t dc_regions_count_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
+	int len = 0;
+
+	len = sysfs_emit(buf, "0x%x\n", mds->nr_dc_region);
+	return len;
+}
+
+struct device_attribute dev_attr_dc_regions_count =
+	__ATTR(dc_regions_count, 0444, dc_regions_count_show, NULL);
+
 static ssize_t serial_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
@@ -362,6 +376,57 @@ static struct attribute *cxl_memdev_ram_attributes[] = {
 	NULL,
 };
 
+static ssize_t show_size_regionN(struct cxl_memdev *cxlmd, char *buf, int pos)
+{
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
+
+	return sysfs_emit(buf, "0x%llx\n", mds->dc_region[pos].decode_len);
+}
+
+#define SIZE_ATTR_RO(n)                                              \
+static ssize_t dc##n##_size_show(                                       \
+	struct device *dev, struct device_attribute *attr, char *buf)  \
+{                                                                      \
+	return show_size_regionN(to_cxl_memdev(dev), buf, (n));             \
+}                                                                      \
+static DEVICE_ATTR_RO(dc##n##_size)
+SIZE_ATTR_RO(0);
+SIZE_ATTR_RO(1);
+SIZE_ATTR_RO(2);
+SIZE_ATTR_RO(3);
+SIZE_ATTR_RO(4);
+SIZE_ATTR_RO(5);
+SIZE_ATTR_RO(6);
+SIZE_ATTR_RO(7);
+
+static struct attribute *cxl_memdev_dc_attributes[] = {
+	&dev_attr_dc0_size.attr,
+	&dev_attr_dc1_size.attr,
+	&dev_attr_dc2_size.attr,
+	&dev_attr_dc3_size.attr,
+	&dev_attr_dc4_size.attr,
+	&dev_attr_dc5_size.attr,
+	&dev_attr_dc6_size.attr,
+	&dev_attr_dc7_size.attr,
+	&dev_attr_dc_regions_count.attr,
+	NULL,
+};
+
+static umode_t cxl_dc_visible(struct kobject *kobj, struct attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
+
+	if (a == &dev_attr_dc_regions_count.attr)
+		return a->mode;
+
+	if (n < mds->nr_dc_region)
+		return a->mode;
+
+	return 0;
+}
+
 static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute *a,
 				  int n)
 {
@@ -385,10 +450,17 @@ static struct attribute_group cxl_memdev_pmem_attribute_group = {
 	.attrs = cxl_memdev_pmem_attributes,
 };
 
+static struct attribute_group cxl_memdev_dc_attribute_group = {
+	.name = "dc",
+	.attrs = cxl_memdev_dc_attributes,
+	.is_visible = cxl_dc_visible,
+};
+
 static const struct attribute_group *cxl_memdev_attribute_groups[] = {
 	&cxl_memdev_attribute_group,
 	&cxl_memdev_ram_attribute_group,
 	&cxl_memdev_pmem_attribute_group,
+	&cxl_memdev_dc_attribute_group,
 	NULL,
 };
 

-- 
2.40.0

