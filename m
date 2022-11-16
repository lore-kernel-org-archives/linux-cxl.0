Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E6E5C4332F
	for <linux-cxl@archiver.kernel.org>; Wed, 16 Nov 2022 21:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbiKPVTM (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 16 Nov 2022 16:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbiKPVTJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 16 Nov 2022 16:19:09 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF225BD6C
        for <linux-cxl@vger.kernel.org>; Wed, 16 Nov 2022 13:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668633548; x=1700169548;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Js4USYcZRaJSpoXX1b4fn9SJ4aIXwvOtMXi1W+ZEWLk=;
  b=F2Bgec6d89vnM2zr/xHoP/RGwUVTQdIF4XVV1JFPWEkBUB9hYaW6Sa4V
   jfx0A1TYUNr3XQfzZEhNmjv1mUprImYiwQA9JJan08aJeM7WPSf+roLDP
   jmzrXa6ou7OFGaOaKToKwdUBeC+qf/CzK6r4OsV0uEhV5u9CDe/9QhZ+Q
   mP5E2v1TSECYfgO/vcaZArT2XAcuwNnwq/WPalsVv8lG6538oHprlwXQL
   biHmjQ6A9NNqfVwwLjEQsm0BfwuA2xog3uBDOzl9RZqUSy1oX+UGMNhL9
   6rN0cvqV+s4HMCi4bJ756Mvk6FkWiWnmmU9yU1Kw+uUhnbAIeojWTaYiE
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="339491239"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="339491239"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 13:19:07 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="617330410"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="617330410"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 13:19:07 -0800
Subject: [PATCH v5 14/18] cxl/pmem: add id attribute to CXL based nvdimm
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com, dave@stgolabs.net,
        benjamin.cheatham@amd.com
Date:   Wed, 16 Nov 2022 14:19:06 -0700
Message-ID: <166863354669.80269.13034158320684797571.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166863336073.80269.10366236775799773727.stgit@djiang5-desk3.ch.intel.com>
References: <166863336073.80269.10366236775799773727.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Add an id group attribute for CXL based nvdimm object. The addition allows
ndctl to display the "unique id" for the nvdimm. The serial number for the
CXL memory device will be used for this id.

[
  {
      "dev":"nmem10",
      "id":"0x4",
      "security":"disabled"
  },
]

The id attribute is needed by the ndctl security key management to setup a
keyblob with a unique file name tied to the mem device.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-nvdimm |    6 ++++++
 drivers/cxl/pmem.c                         |   28 +++++++++++++++++++++++++++-
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-nvdimm b/Documentation/ABI/testing/sysfs-bus-nvdimm
index 1c1f5acbf53d..91945211e53b 100644
--- a/Documentation/ABI/testing/sysfs-bus-nvdimm
+++ b/Documentation/ABI/testing/sysfs-bus-nvdimm
@@ -41,3 +41,9 @@ KernelVersion:  5.18
 Contact:        Kajol Jain <kjain@linux.ibm.com>
 Description:	(RO) This sysfs file exposes the cpumask which is designated to
 		to retrieve nvdimm pmu event counter data.
+
+What:		/sys/bus/nd/devices/nmemX/id
+Date:		November 2022
+KernelVersion:	6.2
+Contact:	Dave Jiang <dave.jiang@intel.com>
+Description:	(RO) Show the id (serial) of the device.
diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
index 24bec4ca3866..9209c7dd72d0 100644
--- a/drivers/cxl/pmem.c
+++ b/drivers/cxl/pmem.c
@@ -48,6 +48,31 @@ static void unregister_nvdimm(void *nvdimm)
 	cxl_nvd->bridge = NULL;
 }
 
+static ssize_t id_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct nvdimm *nvdimm = to_nvdimm(dev);
+	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
+	struct cxl_dev_state *cxlds = cxl_nvd->cxlmd->cxlds;
+
+	return sysfs_emit(buf, "%lld\n", cxlds->serial);
+}
+static DEVICE_ATTR_RO(id);
+
+static struct attribute *cxl_dimm_attributes[] = {
+	&dev_attr_id.attr,
+	NULL
+};
+
+static const struct attribute_group cxl_dimm_attribute_group = {
+	.name = "cxl",
+	.attrs = cxl_dimm_attributes,
+};
+
+static const struct attribute_group *cxl_dimm_attribute_groups[] = {
+	&cxl_dimm_attribute_group,
+	NULL
+};
+
 static int cxl_nvdimm_probe(struct device *dev)
 {
 	struct cxl_nvdimm *cxl_nvd = to_cxl_nvdimm(dev);
@@ -77,7 +102,8 @@ static int cxl_nvdimm_probe(struct device *dev)
 	set_bit(ND_CMD_GET_CONFIG_SIZE, &cmd_mask);
 	set_bit(ND_CMD_GET_CONFIG_DATA, &cmd_mask);
 	set_bit(ND_CMD_SET_CONFIG_DATA, &cmd_mask);
-	nvdimm = __nvdimm_create(cxl_nvb->nvdimm_bus, cxl_nvd, NULL, flags,
+	nvdimm = __nvdimm_create(cxl_nvb->nvdimm_bus, cxl_nvd,
+				 cxl_dimm_attribute_groups, flags,
 				 cmd_mask, 0, NULL, NULL, cxl_security_ops, NULL);
 	if (!nvdimm) {
 		rc = -ENOMEM;


