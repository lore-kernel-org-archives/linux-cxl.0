Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8823E936EC
	for <linux-cxl@archiver.kernel.org>; Wed,  4 Oct 2023 22:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjJDWDf (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 4 Oct 2023 18:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjJDWDf (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 4 Oct 2023 18:03:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725B5BD
        for <linux-cxl@vger.kernel.org>; Wed,  4 Oct 2023 15:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696457012; x=1727993012;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z3a9MdOWOzbu7i7T5Livudb5C+FYjzr5pR/yeShMSwc=;
  b=FypU8m1e8E7T4xQ99Ny6uGPOudb5N7htOKkAw1ardiEoUW9WjGsCUdhg
   i/EXHCxP1Y+6OU9V+HP6AjhJeMdAmFvxAk4Pm4dvzhNArQ1mwrrJ+gszF
   9mnCjIUb/ATCQJ/OQPRc/M30os6vuTvG/zM+UIimLAUEk719bJgE/JBwe
   eSd5U/3s5gGq9ExIJ9PVdyFRBkuLzjgJ4mo/5y0H6nLTu7jeStySceWCJ
   RK+HmohvJ1WxlkBoUEmddJwUfw6VFw0fs37v2kb1qrzdx9rMJ0dRIC0i2
   FIqbviFujiJetw2u0xIRmxYcaLJwUz942+hjF4cQEuqx+1ABzuIGvag7T
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="383222856"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="383222856"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 15:03:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="895154843"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="895154843"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.213.170.46])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 15:02:03 -0700
Subject: [PATCH RESEND 2/2] cxl: Add decoders_committed sysfs attribute to
 cxl_port
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dave@stgolabs.net, jonathan.cameron@huawei.com,
        alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, dan.j.williams@intel.com
Date:   Wed, 04 Oct 2023 15:03:30 -0700
Message-ID: <169645701068.623072.15760571436586081042.stgit@djiang5-mobl3>
In-Reply-To: <169645700414.623072.3893376765415910289.stgit@djiang5-mobl3>
References: <169645700414.623072.3893376765415910289.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

This attribute allows cxl-cli to determine whether there are decoders
committed to a memdev.  This is only a snapshot of the state, and
doesn't offer any protection or serialization against a concurrent
disable-region operation.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/port.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 16efb68eacfa..284d37f71bc6 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -527,8 +527,33 @@ static void cxl_port_release(struct device *dev)
 	kfree(port);
 }
 
+static ssize_t decoders_committed_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	struct cxl_port *port = to_cxl_port(dev);
+	int rc;
+
+	down_read(&cxl_dpa_rwsem);
+	rc = sysfs_emit(buf, "%d\n", cxl_decoders_committed(port));
+	up_read(&cxl_dpa_rwsem);
+
+	return rc;
+}
+
+static DEVICE_ATTR_RO(decoders_committed);
+
+static struct attribute *cxl_port_attrs[] = {
+	&dev_attr_decoders_committed.attr,
+	NULL,
+};
+
+static struct attribute_group cxl_port_attribute_group = {
+	.attrs = cxl_port_attrs,
+};
+
 static const struct attribute_group *cxl_port_attribute_groups[] = {
 	&cxl_base_attribute_group,
+	&cxl_port_attribute_group,
 	NULL,
 };
 


