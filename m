Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A55CE7AB9
	for <linux-cxl@archiver.kernel.org>; Mon, 25 Sep 2023 18:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjIYSHE (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 25 Sep 2023 14:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjIYSHD (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 25 Sep 2023 14:07:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA789B
        for <linux-cxl@vger.kernel.org>; Mon, 25 Sep 2023 11:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695665217; x=1727201217;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Y6IaDQPPRxEM9g/APXC1Fl2gCSLiqq1MxIHTjfeQIMA=;
  b=eCEPwxTZJbWcgggNt3QPNU29GY3vQ6rpLQdZ++VVAO+P6olasnRVB0Dh
   zttuxoVf/UFCZr8iHyUaEsz/2N6YQmiQw/mN8QctRmd/hDxzop602+eq5
   f0wNFUUIBRQa6A9rmqqAUjGG6IoHoKgUtx/pOyXhP6mjiq5tPNkiqrj8K
   3HEji5ZakUry00DBPf7dD5SBiR8eWJiYLraUHEv2/vW98/xPcVQSVaaaY
   iXIw7+VxvH0qxIxAZDndYqwB0NRojQdeas6R/YNJxUlLqhntdAN7LXTYc
   RGJhfEtVPo6EGfvW4LoUEnzB3b5hCKEiXpEWjCsYbRfaQsS1c5GnSDcZy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="381231754"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="381231754"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 11:06:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="922077440"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="922077440"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.209.161.86])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 11:05:56 -0700
Subject: [PATCH] cxl: Add committed sysfs attribute to CXL decoder
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dave@stgolabs.net, jonathan.cameron@huawei.com,
        alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, dan.j.williams@intel.com
Date:   Mon, 25 Sep 2023 11:05:56 -0700
Message-ID: <169566515694.3697523.714600762835841180.stgit@djiang5-mobl3>
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

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl |    7 +++++++
 drivers/cxl/core/port.c                 |   11 +++++++++++
 2 files changed, 18 insertions(+)

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
index 724be8448eb4..ab5b9bc26d56 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -277,12 +277,23 @@ static ssize_t interleave_ways_show(struct device *dev,
 
 static DEVICE_ATTR_RO(interleave_ways);
 
+static ssize_t committed_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct cxl_decoder *cxld = to_cxl_decoder(dev);
+
+	return sysfs_emit(buf, "%d\n", !!(cxld->flags & CXL_DECODER_F_ENABLE));
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
 


