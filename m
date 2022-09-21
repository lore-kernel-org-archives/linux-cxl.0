Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71717C6FA8E
	for <linux-cxl@archiver.kernel.org>; Wed, 21 Sep 2022 15:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiIUPjf (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 21 Sep 2022 11:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbiIUPiL (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 21 Sep 2022 11:38:11 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4EDA9C2CA
        for <linux-cxl@vger.kernel.org>; Wed, 21 Sep 2022 08:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663774447; x=1695310447;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H1IkV4mJ7QzoLK2yUqSaO7cBp/erS0OV1wCnr6ymy6g=;
  b=KQZU1XMa1jVHW/FmliihYGb+CKnmCOpJ/yRk0RCx6o+bAEEEOMmwwdgq
   6uE3jKKLil+rHBuQ0lrDA+wzhtYgx0ak7EP82HeukD64a3Wl0z7l7eOBL
   NarFb5QlwCJaXe1cIC4rvjg1DRvYwMXm88XwasBmx+I4VNcqwaCNMMMcj
   egcemTmbYthptsOaY6RBPGacAJNkzEEUjz5Yq9ROIKvlwg2JwGwjLD698
   3O1kHeOCq04QUU2Q/97eDiC9g8sBa69k149l4E7elffkoEw3uvCxS19UQ
   dWCxkCMZy/75CQTcVCr75X9Q/tybkYSKrIfMdkXncvBuoe/DL9wavi8KW
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="280407773"
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="280407773"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 08:33:10 -0700
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="597034939"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 08:33:09 -0700
Subject: [PATCH v2 17/19] cxl/pmem: add provider name to cxl pmem dimm
 attribute group
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     nvdimm@lists.linux.dev, dan.j.williams@intel.com,
        bwidawsk@kernel.org, ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, dave@stgolabs.net,
        Jonathan.Cameron@huawei.com
Date:   Wed, 21 Sep 2022 08:33:09 -0700
Message-ID: <166377438921.430546.5550361331475412529.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166377414787.430546.3863229455285366312.stgit@djiang5-desk3.ch.intel.com>
References: <166377414787.430546.3863229455285366312.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Add provider name in order to associate cxl test dimm from cxl_test to the
cxl pmem device when going through sysfs for security testing.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/pmem.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
index 9f34f8701b57..cb303edb925d 100644
--- a/drivers/cxl/pmem.c
+++ b/drivers/cxl/pmem.c
@@ -48,6 +48,15 @@ static void unregister_nvdimm(void *nvdimm)
 	cxl_nvd->bridge = NULL;
 }
 
+static ssize_t provider_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct nvdimm *nvdimm = to_nvdimm(dev);
+	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
+
+	return sysfs_emit(buf, "%s\n", dev_name(&cxl_nvd->dev));
+}
+static DEVICE_ATTR_RO(provider);
+
 static ssize_t id_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct nvdimm *nvdimm = to_nvdimm(dev);
@@ -61,6 +70,7 @@ static DEVICE_ATTR_RO(id);
 
 static struct attribute *cxl_dimm_attributes[] = {
 	&dev_attr_id.attr,
+	&dev_attr_provider.attr,
 	NULL
 };
 


