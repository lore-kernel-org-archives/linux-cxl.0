Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E12C433FE
	for <linux-cxl@archiver.kernel.org>; Thu, 27 Jan 2022 21:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbiA0V3g (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 27 Jan 2022 16:29:36 -0500
Received: from mga03.intel.com ([134.134.136.65]:30536 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229610AbiA0V3g (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 27 Jan 2022 16:29:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643318976; x=1674854976;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t4zZwTnokNlqXGMfgu29KqGrhR4jjOjQZrlpar9zdDQ=;
  b=mBLhF2zvUSyXyKg5heW27kElKahjapiOTT2jdIyqqfG40Ain+t7x6wG4
   f0dFuxkVjY6rHn8uSfH+eoYEaZdbUgCq9q5966IscqGQT1MLNz6cRhJDr
   3x4ypflqjZ44Nt0VflJTZVDAkue+MeKhvVAoJ/DV+DdTQJxfRHHe2MusO
   FxWy3PPucGUf28dF5YlHfKMf+6xCXrwxcaWML7SbwgEKLHPlex07SraSe
   6iKDnEe3Ep6UfW0zRyoACrzP5CPUIoriqR71JYpEYoapf0gfOc6A9xie9
   kmWOylLtR+ZdvrqwdBNFJ3AVtbQKBjWm1WY6JomjkFWj0VLnTaClUw/XB
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="246914535"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="246914535"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 13:29:33 -0800
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="521402190"
Received: from vrao2-mobl1.gar.corp.intel.com (HELO localhost.localdomain) ([10.252.129.6])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 13:29:32 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     patches@lists.linux.dev, Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 2/4] cxl/core: Add more decoder attributes to sysfs
Date:   Thu, 27 Jan 2022 13:29:09 -0800
Message-Id: <20220127212911.127741-3-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220127212911.127741-1-ben.widawsky@intel.com>
References: <20220127212911.127741-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The decoder attributes are consumed by userspace in order to program and
verify the CXL topology.

An example of the new attributes is with x1 and 8192 granularity:
archlinux ~ # cat /sys/bus/cxl/devices/decoder0.0/interleave_{ways,granularity}
1
8192

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/core/port.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index f49783d8c845..631dec0fa79e 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -99,6 +99,25 @@ static ssize_t size_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(size);
 
+static ssize_t interleave_ways_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct cxl_decoder *cxld = to_cxl_decoder(dev);
+
+	return sysfs_emit(buf, "%d\n", cxld->interleave_ways);
+}
+static DEVICE_ATTR_RO(interleave_ways);
+
+static ssize_t interleave_granularity_show(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	struct cxl_decoder *cxld = to_cxl_decoder(dev);
+
+	return sysfs_emit(buf, "%d\n", cxld->interleave_granularity);
+}
+static DEVICE_ATTR_RO(interleave_granularity);
+
 #define CXL_DECODER_FLAG_ATTR(name, flag)                            \
 static ssize_t name##_show(struct device *dev,                       \
 			   struct device_attribute *attr, char *buf) \
@@ -186,6 +205,8 @@ static struct attribute *cxl_decoder_base_attrs[] = {
 	&dev_attr_start.attr,
 	&dev_attr_size.attr,
 	&dev_attr_locked.attr,
+	&dev_attr_interleave_ways.attr,
+	&dev_attr_interleave_granularity.attr,
 	NULL,
 };
 
-- 
2.35.0

