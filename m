Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E899FC48BE0
	for <linux-cxl@archiver.kernel.org>; Thu, 10 Jun 2021 18:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D236D61403
	for <linux-cxl@archiver.kernel.org>; Thu, 10 Jun 2021 18:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbhFJS7f (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 10 Jun 2021 14:59:35 -0400
Received: from mga06.intel.com ([134.134.136.31]:35899 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230265AbhFJS7f (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 10 Jun 2021 14:59:35 -0400
IronPort-SDR: kckhwmCeDjLifwtItOjix9gKMcGhZTYWbNLIy9EwkxbSkcRTBINn4WA0xe+SgoCO2+AYI6gNcO
 kVxs/OQi58xA==
X-IronPort-AV: E=McAfee;i="6200,9189,10011"; a="266527356"
X-IronPort-AV: E=Sophos;i="5.83,264,1616482800"; 
   d="scan'208";a="266527356"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 11:57:37 -0700
IronPort-SDR: saHShBUgcYetj/bTvykOn98mOGXoO7QvUK78tDn2AE6s3z9BpdTmtT6Z0qiXWmH58efrlWdLAm
 3KG9oB3sw1Kw==
X-IronPort-AV: E=Sophos;i="5.83,264,1616482800"; 
   d="scan'208";a="482963775"
Received: from millers-mobl.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.140.70])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 11:57:37 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [RFC PATCH 2/4] cxl/region: Create attribute structure / verify
Date:   Thu, 10 Jun 2021 11:57:23 -0700
Message-Id: <20210610185725.897541-3-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210610185725.897541-1-ben.widawsky@intel.com>
References: <20210610185725.897541-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Introduce a verification mechanism for a region. Regions have complex
configuration requirements and it is beneficial to provide a way to
verify the constraints are met before trying to bind. Primarily it adds
ABI to inform userspace of more detailed information about what failed
rather than the limited choices of errno at bind time.

It's important to point out that a verified region can still fail to
bind, but the first step in binding will be to run the same verification
algorithm.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

--

Functionally it might make sense to squash this patch in with other
patches adding attributes. From a discussion standpoint however, it's
nice to have this broken out as I suspect there might be some debate
about it.
---
 Documentation/ABI/testing/sysfs-bus-cxl | 13 +++++++++++++
 drivers/cxl/region.c                    | 22 +++++++++++++++++++++-
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 5bcbefd4ea38..699c8514fd7b 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -146,3 +146,16 @@ Contact:	linux-cxl@vger.kernel.org
 Description:
 		Deletes the named region. A region must be unbound from the
 		region driver before being deleted.
+
+What:		/sys/bus/cxl/devices/decoderX.Y/regionX.Y:Z/verify
+Date:		June, 2021
+KernelVersion:	v5.14
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		Instructs the kernel to verify that the regionX.Y:Z is properly
+		configured and provide more detailed information about
+		configuration errors. A value of 0 indicates the region is
+		properly configured and ready to bind, otherwise a negative
+		integer is returned describing the first error found in the
+		configuration. A verified region can still fail binding due to
+		lack of resources.
diff --git a/drivers/cxl/region.c b/drivers/cxl/region.c
index 1f47bc17bd50..ea1ac848c713 100644
--- a/drivers/cxl/region.c
+++ b/drivers/cxl/region.c
@@ -20,11 +20,31 @@
  * relationship between decoder and region when the region is interleaved.
  */
 
-static void cxl_region_release(struct device *dev);
+static ssize_t verify_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "0");
+}
+
+static DEVICE_ATTR_RO(verify);
+
+static struct attribute *region_attrs[] = {
+	&dev_attr_verify.attr,
+	NULL,
+};
 
+static const struct attribute_group region_group = {
+	.attrs = region_attrs,
+};
+
+static const struct attribute_group *region_groups[] = {
+	&region_group,
+};
+
+static void cxl_region_release(struct device *dev);
 static const struct device_type cxl_region_type = {
 	.name = "cxl_region",
 	.release = cxl_region_release,
+	.groups = region_groups,
 };
 
 static struct cxl_region *to_cxl_region(struct device *dev)
-- 
2.32.0

