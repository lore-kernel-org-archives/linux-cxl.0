Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04669C25B08
	for <linux-cxl@archiver.kernel.org>; Wed, 17 Aug 2022 21:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241533AbiHQVWM (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 17 Aug 2022 17:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233026AbiHQVWK (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 17 Aug 2022 17:22:10 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7CDA5992
        for <linux-cxl@vger.kernel.org>; Wed, 17 Aug 2022 14:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660771329; x=1692307329;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/Qs+Fndfo4GMPthFtjTpWI6qxU2HSfduBs/vgpdS1SM=;
  b=gz79qU4fYDeTTeIl1rm9qFEFNGx/hceR79n68qMsW0Z1Tghk+mgxE+w+
   11HSFKbHgGvp4UBERLjy2cR7QHuQhwstVN5aGhrHutrXdGJr2j6rzJfWs
   0y/r7p1Bbsv1bHLhxa+3shZyu/tNn7vaFKVnN60mEOu1ZOgB/rDbH/AGo
   HY4p3NBc75al55e3MIlyI2C7kgmfCmLjBsnB94+Q/fIRDCmYLJEB5xp00
   wLWiGjbg8cvF676U+/F3svORLxRZuA6Q6WZuU+7bttg7aaWit15ysrJTK
   5u4A2Beg0sy5Ho+zXM3Q/oJ8hVI1kB3SszydUdvkSrzCkYLcjz0CKSeDw
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="275657571"
X-IronPort-AV: E=Sophos;i="5.93,244,1654585200"; 
   d="scan'208";a="275657571"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 14:22:09 -0700
X-IronPort-AV: E=Sophos;i="5.93,244,1654585200"; 
   d="scan'208";a="733825843"
Received: from djiang5-desk4.jf.intel.com ([10.165.157.96])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 14:22:09 -0700
Subject: [PATCH v4 6/6] cxl: export intereleave capability as port sysfs
 attribute
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com
Date:   Wed, 17 Aug 2022 14:22:09 -0700
Message-ID: <166077132912.1743055.6028619361637977647.stgit@djiang5-desk4.jf.intel.com>
In-Reply-To: <166077102447.1743055.17158560277276060113.stgit@djiang5-desk4.jf.intel.com>
References: <166077102447.1743055.17158560277276060113.stgit@djiang5-desk4.jf.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Export the interleave capability as a sysfs attribute for a port. The
exported mask is interpreted from the CXL HDM Decoder Capability Register
(CXL spec v 8.2.4.19.1). Each bit in the mask represents the number of
interleave ways the decoder supports. For example, CXL devices designed
from CXL spec v2.0 supports 1, 2, 4, and 8 interleave ways. The exported
mask would show 0x116. The exported sysfs attribute will help user region
creation to do more valid configuration checking.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl |   13 +++++++++++++
 drivers/cxl/port.c                      |   10 ++++++++++
 2 files changed, 23 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index c6f533f47e50..5a13806a77ab 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -203,6 +203,19 @@ Description:
 		Interleave Capable" bit and the "AA14to12 Interleave Capable" bits
 		are set.
 
+What:		/sys/bus/cxl/devices/endpointX/interleave_cap
+		/sys/bus/cxl/devices/portX/interleave_cap
+Date:		Aug, 2020
+KernelVersion:	v6.1
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) Interleave capability mask from the HDM decoder attached to the
+		port. Each bit in the mask represents the number of interleave ways
+		the decoder supports. For CXL devices designed from CXL spec v2.0 or
+		earlier, 1, 2, 4, and 8 interleave ways are supported. With CXL spec
+		v3.0 or later, the capability register (CXL spec v3 8.2.4.19.1)
+		indicates 3, 6, and 12 ways supported or 16 ways supported.
+
 What:		/sys/bus/cxl/devices/decoderX.Y/mode
 Date:		May, 2022
 KernelVersion:	v5.20
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 567f62fd4ded..f856a31bec65 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -132,8 +132,18 @@ static ssize_t interleave_mask_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(interleave_mask);
 
+static ssize_t interleave_cap_show(struct device *dev, struct device_attribute *attr,
+				   char *buf)
+{
+	struct cxl_hdm *cxlhdm = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%#lx\n", cxlhdm->interleave_cap);
+}
+static DEVICE_ATTR_RO(interleave_cap);
+
 static struct attribute *cxl_port_info_attributes[] = {
 	&dev_attr_interleave_mask.attr,
+	&dev_attr_interleave_cap.attr,
 	NULL,
 };
 


