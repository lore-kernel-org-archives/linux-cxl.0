Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEAEC6FA90
	for <linux-cxl@archiver.kernel.org>; Wed, 21 Sep 2022 15:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiIUPin (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 21 Sep 2022 11:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbiIUPiM (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 21 Sep 2022 11:38:12 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF61A00CC
        for <linux-cxl@vger.kernel.org>; Wed, 21 Sep 2022 08:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663774455; x=1695310455;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jX8JO1P69KAy73uPzM66u7y9O6bAbVjq3UbYUkeOMiw=;
  b=NU+1r8eJfwNxmX4wuoVxHRJ3JinDeVJnJdS5T+5H3CsJGsgVUO6ABWHs
   DE5cyaWwx6t+9yQn0GDXUYkZyTGlN8HMvLeF+A/lIjomKX5L1yK2+nomF
   ZMHjxI/cQSLzpWPziV5dYpG7jPTzpSyGiNHhPp3kqcfpfj/THA+SoWDex
   N3wUEEUt3wjQaYW8Avxmad9jhxuhADsp55XoSmfnMPcq4gJDtkIBl8GY0
   7mbOzB24MJseZEKcvjV14bC1qutiPbP3YRANXtQGe41wyJKfZChicJKjx
   FYNd/RqBnQkjbYRAYYyj+Cfup4MvVI8aDq2j20EzRGnbL7aNvDM8AnEKF
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="297636679"
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="297636679"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 08:32:58 -0700
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="597034842"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 08:32:57 -0700
Subject: [PATCH v2 15/19] cxl/pmem: add id attribute to CXL based nvdimm
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     nvdimm@lists.linux.dev, dan.j.williams@intel.com,
        bwidawsk@kernel.org, ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, dave@stgolabs.net,
        Jonathan.Cameron@huawei.com
Date:   Wed, 21 Sep 2022 08:32:57 -0700
Message-ID: <166377437758.430546.16461184844990298793.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166377414787.430546.3863229455285366312.stgit@djiang5-desk3.ch.intel.com>
References: <166377414787.430546.3863229455285366312.stgit@djiang5-desk3.ch.intel.com>
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

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/pmem.c |   29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
index 24bec4ca3866..9f34f8701b57 100644
--- a/drivers/cxl/pmem.c
+++ b/drivers/cxl/pmem.c
@@ -48,6 +48,32 @@ static void unregister_nvdimm(void *nvdimm)
 	cxl_nvd->bridge = NULL;
 }
 
+static ssize_t id_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct nvdimm *nvdimm = to_nvdimm(dev);
+	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
+	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
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
@@ -77,7 +103,8 @@ static int cxl_nvdimm_probe(struct device *dev)
 	set_bit(ND_CMD_GET_CONFIG_SIZE, &cmd_mask);
 	set_bit(ND_CMD_GET_CONFIG_DATA, &cmd_mask);
 	set_bit(ND_CMD_SET_CONFIG_DATA, &cmd_mask);
-	nvdimm = __nvdimm_create(cxl_nvb->nvdimm_bus, cxl_nvd, NULL, flags,
+	nvdimm = __nvdimm_create(cxl_nvb->nvdimm_bus, cxl_nvd,
+				 cxl_dimm_attribute_groups, flags,
 				 cmd_mask, 0, NULL, NULL, cxl_security_ops, NULL);
 	if (!nvdimm) {
 		rc = -ENOMEM;


