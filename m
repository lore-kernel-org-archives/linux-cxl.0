Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8DCECAA25
	for <linux-cxl@archiver.kernel.org>; Thu, 25 Aug 2022 16:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239640AbiHYQIl (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 25 Aug 2022 12:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237841AbiHYQIl (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 25 Aug 2022 12:08:41 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CB7B2CE3
        for <linux-cxl@vger.kernel.org>; Thu, 25 Aug 2022 09:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661443720; x=1692979720;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xkfCp7LYmNdkgX5sp6jWftzcjyUMKzlNCZ99re74Wq8=;
  b=YjzlCvMp9cQ49QwDV8t5YlCCqRBH80Hd2K/kJU89wgJcfOxlgWmqs3WJ
   /22JOhIeyTiu7PQPV2OGiZP7z8CvcTbta3zarti8YnbZkSKvOln3y1f7z
   q9Z2LoDBHLCg5ld5qqop1omSj9PCUb6C44nZqBr2ohugOQ4f8Px22tnBO
   vWr8ajNHzLugdN+H6/YUjhFcbkTB/HiGNPe24dpceFxxYEuletJmR9Adm
   sGvBD1MQ8xQNnYRyXdlXxbmN9GSdZzBkkAilrz7Zu9M729P0nfAq7u65I
   uq8V7WJYXT78qk+djTcdDduHEVDhPj685cGU9ZX485q6lVPdiClQ0ze6i
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="295061488"
X-IronPort-AV: E=Sophos;i="5.93,263,1654585200"; 
   d="scan'208";a="295061488"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 09:08:11 -0700
X-IronPort-AV: E=Sophos;i="5.93,263,1654585200"; 
   d="scan'208";a="786058040"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 09:08:11 -0700
Subject: [PATCH v5 6/6] cxl: export intereleave capability as port sysfs
 attribute
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com
Date:   Thu, 25 Aug 2022 09:08:09 -0700
Message-ID: <166144368990.745916.1792181347596381868.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166144343809.745916.16054560464363829844.stgit@djiang5-desk3.ch.intel.com>
References: <166144343809.745916.16054560464363829844.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Export the interleave capability as a sysfs attribute for a port. The
exported mask is interpreted from the CXL HDM Decoder Capability Register
(CXL spec rev3.0 8.2.4.19.1). Each bit in the mask represents the number of
interleave ways the decoder supports. For example, CXL devices designed
from CXL spec v2.0 supports 1, 2, 4, and 8 interleave ways. The exported
mask would show 0x116. The exported sysfs attribute will help user region
creation to do more valid configuration checking.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl |   13 +++++++++++++
 drivers/cxl/port.c                      |   10 ++++++++++
 2 files changed, 23 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 96becbf4f7c5..0fce54d962bd 100644
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
+		the decoder supports. For CXL devices designed from CXL spec rev2.0 or
+		earlier, 1, 2, 4, and 8 interleave ways are supported. With CXL spec
+		v3.0 or later, the capability register (CXL spec rev3 8.2.4.19.1)
+		indicates 3, 6, and 12 ways supported or 16 ways supported.
+
 What:		/sys/bus/cxl/devices/decoderX.Y/mode
 Date:		May, 2022
 KernelVersion:	v5.20
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 0ca81f94b267..4dee8b8c416f 100644
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
 	NULL
 };
 


