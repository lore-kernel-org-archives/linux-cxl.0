Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF45CC433EF
	for <linux-cxl@archiver.kernel.org>; Wed, 13 Apr 2022 18:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236393AbiDMSkQ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 13 Apr 2022 14:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237755AbiDMSkO (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 13 Apr 2022 14:40:14 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5014F55237
        for <linux-cxl@vger.kernel.org>; Wed, 13 Apr 2022 11:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649875073; x=1681411073;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x8b/LibVqBx1G9rOTQThgsQbECDv7IbBtNdHI9yYHsw=;
  b=eZAtq9218YL0rcPR8LAuceNhVa7RFvrmiVDNTLNIHDJmc2eOq0woMJ5h
   JEjVJR+ZSb2dIdglcLbjL9wYO3+X4k+5N+yeRn2rbiZ1FIyhcft19lwOw
   laSEGFgf1Q2M/ddeWqnvymGdBOjv+cGTVQZHo0P7/TAJ2vpD7kL+GBwwr
   j/EI7diCGliad95r/sGo49XkMewSFKPU3PR+SpmzfeUuWnrpTWmLA4Fun
   4uMRoIe87wsNWVCPinKcCnAtW4jzxf++NKD4LMDD7E0XDwp407CIoqr+I
   Vr9DoQ1CIEUv7OQHwPYQsuniGUf7hzhhv6cfwOXQ9bJ7qRMBKOTWgbqNH
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="262497753"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="262497753"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 11:37:51 -0700
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="725013632"
Received: from sushobhi-mobl.amr.corp.intel.com (HELO localhost.localdomain) ([10.252.131.238])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 11:37:51 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Cc:     patches@lists.linux.dev, Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [RFC PATCH 13/15] cxl/core/port: Add attrs for root ways & granularity
Date:   Wed, 13 Apr 2022 11:37:18 -0700
Message-Id: <20220413183720.2444089-14-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220413183720.2444089-1-ben.widawsky@intel.com>
References: <20220413183720.2444089-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Region programming requires knowledge of root decoder attributes. For
example, if the root decoder supports only 256b granularity then a
region with > 256b granularity cannot work. Add sysfs attributes in
order to provide this information to userspace. The CXL driver controls
programming of switch and endpoint decoders, but the attributes are also
exported for informational purposes.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/core/port.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 5ef8a6e1ea23..19cf1fd16118 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -318,10 +318,31 @@ static ssize_t target_list_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(target_list);
 
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
+static ssize_t interleave_ways_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct cxl_decoder *cxld = to_cxl_decoder(dev);
+
+	return sysfs_emit(buf, "%d\n", cxld->interleave_ways);
+}
+static DEVICE_ATTR_RO(interleave_ways);
+
 static struct attribute *cxl_decoder_base_attrs[] = {
 	&dev_attr_start.attr,
 	&dev_attr_size.attr,
 	&dev_attr_locked.attr,
+	&dev_attr_interleave_granularity.attr,
+	&dev_attr_interleave_ways.attr,
 	NULL,
 };
 
-- 
2.35.1

