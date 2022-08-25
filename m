Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D854ECAA27
	for <linux-cxl@archiver.kernel.org>; Thu, 25 Aug 2022 16:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240732AbiHYQJs (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 25 Aug 2022 12:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242641AbiHYQJr (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 25 Aug 2022 12:09:47 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965563A0
        for <linux-cxl@vger.kernel.org>; Thu, 25 Aug 2022 09:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661443785; x=1692979785;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M73zOZ/B+AB8d/4ltG96fC8ys7EpI+MwPP16HFR4vTQ=;
  b=bkFOQDEssBEWeQJGcTdnZCfmMFGKMzxnGoMjIz42kwo4vWWwLac4Qn3Y
   4qe/noThOSjKQwP/e7wKtfCHc+iItSUtKQduTRKP1RFNnC806OL+/Uis7
   jtKNQAk3jAr25uaKauN+sFKoMybVFgPhUmkRRiLBrA8/MpHP5X8zFeEqn
   t0e5m3wYcU6/+P639FO2dCfZjtFqO7rAqrnRclVKwEefqX9zTIfoZrEyT
   GumQNyDaMt5jDkuLaGqVtnFCkS7v207HdOsOz/+FPbeUDJSjP2Fos0ZkM
   RkY4HESyTU1i+FTUWQUG+qhZAKBveHy0LDiK6/fFm/XbC2tK0RRCJ+KuM
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="380574934"
X-IronPort-AV: E=Sophos;i="5.93,263,1654585200"; 
   d="scan'208";a="380574934"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 09:08:04 -0700
X-IronPort-AV: E=Sophos;i="5.93,263,1654585200"; 
   d="scan'208";a="938386808"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 09:08:04 -0700
Subject: [PATCH v5 5/6] cxl: export interleave address mask as port sysfs
 attribute
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com
Date:   Thu, 25 Aug 2022 09:08:04 -0700
Message-ID: <166144368419.745916.8544064496236189589.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166144343809.745916.16054560464363829844.stgit@djiang5-desk3.ch.intel.com>
References: <166144343809.745916.16054560464363829844.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Export the interleave address mask as a sysfs attribute for a port. The
interleave address mask is created based off the CXL HDM Decoder Capability
Register (CXL spec rev3.0 8.2.4.19.1) and sets the bits indicated by the
"A11to8 Interleave Capable" bit and the "A14to12 Interleave Capable" bit.
It indicates the decoder supports interleaving based on those address
bits. The exported sysfs attribute will help user region creation to do
more valid configuration checking.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl |   11 +++++++++++
 drivers/cxl/port.c                      |   19 +++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 8494ef27e8d2..96becbf4f7c5 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -191,6 +191,17 @@ Description:
 		the data is 0 reading the CDAT data failed.  Otherwise the CDAT
 		data is reported.
 
+What:		/sys/bus/cxl/devices/endpointX/interleave_mask
+		/sys/bus/cxl/devices/portX/interleave_mask
+Date:		Aug, 2020
+KernelVersion:	v6.1
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) Interleave address mask from the HDM decoder attached to the
+		port. The address bits are set depending on the CXL HDM Decoder
+		Capability Register (CXL spec rev3.0 8.2.4.19.1) where the "A11to8
+		Interleave Capable" bit and the "AA14to12 Interleave Capable" bits
+		are set.
 
 What:		/sys/bus/cxl/devices/decoderX.Y/mode
 Date:		May, 2022
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index c4aa073b7e31..0ca81f94b267 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -123,8 +123,27 @@ static struct attribute_group cxl_cdat_attribute_group = {
 	.is_bin_visible = cxl_port_bin_attr_is_visible,
 };
 
+static ssize_t interleave_mask_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct cxl_hdm *cxlhdm = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%#x\n", cxlhdm->interleave_mask);
+}
+static DEVICE_ATTR_RO(interleave_mask);
+
+static struct attribute *cxl_port_info_attributes[] = {
+	&dev_attr_interleave_mask.attr,
+	NULL
+};
+
+static struct attribute_group cxl_port_info_attribute_group = {
+	.attrs = cxl_port_info_attributes,
+};
+
 static const struct attribute_group *cxl_port_dynamic_attr_groups[] = {
 	&cxl_cdat_attribute_group,
+	&cxl_port_info_attribute_group,
 	NULL,
 };
 


