Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04A0E7E654
	for <linux-cxl@archiver.kernel.org>; Tue, 26 Sep 2023 18:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235576AbjIZSqg (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 26 Sep 2023 14:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235395AbjIZSqf (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 26 Sep 2023 14:46:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B220F11D
        for <linux-cxl@vger.kernel.org>; Tue, 26 Sep 2023 11:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695753989; x=1727289989;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rfr1iOKtUiVYDJeJ0pTUvE2cP657m7K7UPgpdwhKOSg=;
  b=lFgBvfK1FDTw9aIYnM65mhh71VgxO9f574nRIB0sH2nxt/Gb6vWYnjSy
   pgftix3rJ8xS4n7QBUzdMpffMkTZ5lSc1A7VDTc137rQM7lkuxDg2AFKI
   YiTTw92YKD4qwRSEt1ohQZ4rtExqUo5Um378lOBOzhVBEHQxdZ7WR0Kow
   US89zltFMtpgEtyth6hD9Z6AgcsWRjK+zKiMl8j4+XsoOrdesTwXozQH4
   uAWJBjM5IXnkMbsR8k2Jt2V7qQQSg2vaMMnu3hsHujR2oBj+8RZkz9UXp
   WVGgSuep9FArT4Luc6cBB4SlaMjRt0jXRu3ME+siEcdzuGZctPP7hVjpS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="361020785"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="361020785"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 11:46:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="864501227"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="864501227"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.65.171])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 11:46:28 -0700
Subject: [PATCH v3] cxl: Add committed sysfs attribute to CXL decoder
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dave@stgolabs.net, jonathan.cameron@huawei.com,
        alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, dan.j.williams@intel.com
Date:   Tue, 26 Sep 2023 11:46:28 -0700
Message-ID: <169575398814.4028282.11591056324662123995.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

This attribute allows cxl-cli to determine whether a decoder is
actively participating in a region. This is only a snapshot of the
state, and doesn't offer any protection or serialization against a
concurrent disable-region operation.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v3:
- Update commit log verbiage. (Vishal)
- Change code to conform with existing code. (Dan)
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
index 724be8448eb4..20919ffbc1a4 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -277,12 +277,24 @@ static ssize_t interleave_ways_show(struct device *dev,
 
 static DEVICE_ATTR_RO(interleave_ways);
 
+static ssize_t committed_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct cxl_decoder *cxld = to_cxl_decoder(dev);
+	bool enabled = cxld->flags & CXL_DECODER_F_ENABLE;
+
+	return sysfs_emit(buf, "%d\n", enabled);
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
 


