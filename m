Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91217E7E648
	for <linux-cxl@archiver.kernel.org>; Tue, 26 Sep 2023 15:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235098AbjIZPaB (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 26 Sep 2023 11:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235099AbjIZPaA (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 26 Sep 2023 11:30:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8593120
        for <linux-cxl@vger.kernel.org>; Tue, 26 Sep 2023 08:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695742193; x=1727278193;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=g331IkKgBlOAbAb8j2otMrqcoun3jbO1QcU5zXQNZG0=;
  b=ORoetm4KLX0Z/cc4Pa3LckG2Bdv+IffRp3TleKSizRRGIqZBm91JBA0o
   +KWT4n0QMdADtT/rY7W4x2ajuQmZhKJpzlbROtfMng37aN0frx82FQZrM
   ehAC2GpPqxXHnEK8gsgzP9XTReDFOpeqTZ+JlcspZaX+T8PNWNNKQ5bQq
   9CXBC2az5uSGxrjYHj+xnO7IesOwWvVc4xoWyHiWEk5g2B/sLP6GSq29o
   plxdyjI/D8wc+RjCUcNJOnzZOAfDqv6LojBv/VLmoOgf3IVx6pBKZ55K/
   v/pEMQTtxDpTTWia0BCyLnsmuATDGLnCglegERSOeGW9X5i9aClHVd6vp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="361843721"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="361843721"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 08:29:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="819062768"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="819062768"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.65.171])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 08:29:51 -0700
Subject: [PATCH v2] cxl: Add committed sysfs attribute to CXL decoder
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dave@stgolabs.net, jonathan.cameron@huawei.com,
        alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, dan.j.williams@intel.com
Date:   Tue, 26 Sep 2023 08:29:51 -0700
Message-ID: <169574219129.3884437.11954592650115343944.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Expose the committed status of a CXL decoder. The status assists CXL CLI in
determining as a sure way whether a region is active. Of coruse this is
still best effort as it's a snapshot of the state and not atomic for the
user region disable operation.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v2:
- Use FIELD_GET() (Jonathan)
---
 Documentation/ABI/testing/sysfs-bus-cxl |    7 +++++++
 drivers/cxl/core/port.c                 |   12 ++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 087f762ebfd5..ef3fc9fe9d0d 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -369,6 +369,13 @@ Description:
 		provided it is currently idle / not bound to a driver.
 
 
+What:		/sys/bus/cxl/devices/decoderX.Y/committed
+Date:		Sep, 2023
+KernelVersion:	v6.7
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) Indicates whether the decoder is committed.
+
 What:		/sys/bus/cxl/devices/regionZ/uuid
 Date:		May, 2022
 KernelVersion:	v6.0
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 724be8448eb4..fc65ef55db0f 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -277,12 +277,24 @@ static ssize_t interleave_ways_show(struct device *dev,
 
 static DEVICE_ATTR_RO(interleave_ways);
 
+static ssize_t committed_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct cxl_decoder *cxld = to_cxl_decoder(dev);
+
+	return sysfs_emit(buf, "%d\n",
+			  FIELD_GET(CXL_DECODER_F_ENABLE, cxld->flags));
+}
+
+static DEVICE_ATTR_RO(committed);
+
 static struct attribute *cxl_decoder_base_attrs[] = {
 	&dev_attr_start.attr,
 	&dev_attr_size.attr,
 	&dev_attr_locked.attr,
 	&dev_attr_interleave_granularity.attr,
 	&dev_attr_interleave_ways.attr,
+	&dev_attr_committed.attr,
 	NULL,
 };
 


