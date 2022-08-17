Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA37C25B08
	for <linux-cxl@archiver.kernel.org>; Wed, 17 Aug 2022 21:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233446AbiHQVWF (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 17 Aug 2022 17:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241519AbiHQVWE (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 17 Aug 2022 17:22:04 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407ACA5992
        for <linux-cxl@vger.kernel.org>; Wed, 17 Aug 2022 14:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660771324; x=1692307324;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DuV2w/E/x5CRj5hRlf24x5UhznIR6oKB5UmE6BcvlHI=;
  b=M8K3EQ17Op1AHEvPr03/YCdcsGEq806ZPpYuVF1BzTCtXmByKiP0c7zF
   DzNgOzE6RzcJEokduVewd6GgCOxoA5PuQxvFsiNDLEDHriHwzelhX55LD
   4774reuH6DpMtezjuEO2TZhJr5i+HFfRQ242vqaNtIPBnhtoUoCY2+joR
   FjqsSVxlVQsBsTThnKhzODnIGfaAHzFcjDf+7RROyYlV3GZ6rfr4WOU//
   QZIiqnHlhrldjPyJdTAqVLbdrk5KRWuI2UQGjaoKeZBYQivMd+i/pzHls
   TzVbGwiRVwe+1wrCGWEf2P9XS2HjkXVVDPRWzSKg8lVTBHJp2IdK4XTFQ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="279571168"
X-IronPort-AV: E=Sophos;i="5.93,244,1654585200"; 
   d="scan'208";a="279571168"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 14:22:04 -0700
X-IronPort-AV: E=Sophos;i="5.93,244,1654585200"; 
   d="scan'208";a="607589365"
Received: from djiang5-desk4.jf.intel.com ([10.165.157.96])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 14:22:04 -0700
Subject: [PATCH v4 5/6] cxl: export interleave address mask as port sysfs
 attribute
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com
Date:   Wed, 17 Aug 2022 14:22:04 -0700
Message-ID: <166077132400.1743055.3807533324287792337.stgit@djiang5-desk4.jf.intel.com>
In-Reply-To: <166077102447.1743055.17158560277276060113.stgit@djiang5-desk4.jf.intel.com>
References: <166077102447.1743055.17158560277276060113.stgit@djiang5-desk4.jf.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Export the interleave address mask as a sysfs attribute for a port. The
interleave address mask is created based off the CXL HDM Decoder Capability
Register (CXL spec v3 8.2.4.19.1) and sets the bits indicated by th "A11to8
Interleave Capable" bit and the "A14to12 Interleave Capable" bit. It
indicates the decoder supports interleaveing based on those address bits.
The exported sysfs attribute will help user region creation to do more
valid configuration checking.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl |   11 +++++++++++
 drivers/cxl/port.c                      |   19 +++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 8494ef27e8d2..c6f533f47e50 100644
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
+		(RO) Interleve address mask from the HDM decoder attached to the
+		port. The address bits are set depending on the CXL HDM Decoder
+		Capability Register (CXL spec v3 8.2.4.19.1) where the "A11to8
+		Interleave Capable" bit and the "AA14to12 Interleave Capable" bits
+		are set.
 
 What:		/sys/bus/cxl/devices/decoderX.Y/mode
 Date:		May, 2022
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index c4aa073b7e31..567f62fd4ded 100644
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
+	NULL,
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
 


