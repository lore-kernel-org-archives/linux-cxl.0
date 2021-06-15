Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2553C48BE5
	for <linux-cxl@archiver.kernel.org>; Tue, 15 Jun 2021 23:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B70461245
	for <linux-cxl@archiver.kernel.org>; Tue, 15 Jun 2021 23:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbhFOXUd (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 15 Jun 2021 19:20:33 -0400
Received: from mga12.intel.com ([192.55.52.136]:51237 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231420AbhFOXUd (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Tue, 15 Jun 2021 19:20:33 -0400
IronPort-SDR: JZZ1KWuP0V+KguAymJEvbl4qreeEV+KEvzAKyJkCDDUBQVemsClqPYaCtcHbd+Kdx8EwEkQZIf
 +A6tRhy51z6A==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="185776159"
X-IronPort-AV: E=Sophos;i="5.83,276,1616482800"; 
   d="scan'208";a="185776159"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 16:18:28 -0700
IronPort-SDR: FPel43yAGe7C6TXE6cpYEMs/5YBQvb4RH0W11fkuSIaQbkdQ52xUpyFAaRP7272S7KnJYu7FOI
 HiPnqL+ENJ1A==
X-IronPort-AV: E=Sophos;i="5.83,276,1616482800"; 
   d="scan'208";a="487940036"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 16:18:28 -0700
Subject: [PATCH v2 4/5] libnvdimm: Drop unused device power management
 support
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev
Date:   Tue, 15 Jun 2021 16:18:28 -0700
Message-ID: <162379910795.2993820.10130417680551632288.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <162379908663.2993820.16543025953842049041.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <162379908663.2993820.16543025953842049041.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

LIBNVDIMM device objects register sysfs power attributes despite nothing
requiring that support. Clean up sysfs remove the power/ attribute
group. This requires a device_create() and a device_register() usage to
be converted to the device_initialize() + device_add() pattern.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Link: https://lore.kernel.org/r/162336397948.2462439.5230237265829121099.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/bus.c |   45 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 8 deletions(-)

diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index a11821df83b5..e6aa87043a95 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -363,8 +363,13 @@ struct nvdimm_bus *nvdimm_bus_register(struct device *parent,
 	nvdimm_bus->dev.groups = nd_desc->attr_groups;
 	nvdimm_bus->dev.bus = &nvdimm_bus_type;
 	nvdimm_bus->dev.of_node = nd_desc->of_node;
-	dev_set_name(&nvdimm_bus->dev, "ndbus%d", nvdimm_bus->id);
-	rc = device_register(&nvdimm_bus->dev);
+	device_initialize(&nvdimm_bus->dev);
+	device_set_pm_not_required(&nvdimm_bus->dev);
+	rc = dev_set_name(&nvdimm_bus->dev, "ndbus%d", nvdimm_bus->id);
+	if (rc)
+		goto err;
+
+	rc = device_add(&nvdimm_bus->dev);
 	if (rc) {
 		dev_dbg(&nvdimm_bus->dev, "registration failed: %d\n", rc);
 		goto err;
@@ -525,6 +530,7 @@ void __nd_device_register(struct device *dev)
 		set_dev_node(dev, to_nd_region(dev)->numa_node);
 
 	dev->bus = &nvdimm_bus_type;
+	device_set_pm_not_required(dev);
 	if (dev->parent) {
 		get_device(dev->parent);
 		if (dev_to_node(dev) == NUMA_NO_NODE)
@@ -717,18 +723,41 @@ const struct attribute_group nd_numa_attribute_group = {
 	.is_visible = nd_numa_attr_visible,
 };
 
+static void ndctl_release(struct device *dev)
+{
+	kfree(dev);
+}
+
 int nvdimm_bus_create_ndctl(struct nvdimm_bus *nvdimm_bus)
 {
 	dev_t devt = MKDEV(nvdimm_bus_major, nvdimm_bus->id);
 	struct device *dev;
+	int rc;
 
-	dev = device_create(nd_class, &nvdimm_bus->dev, devt, nvdimm_bus,
-			"ndctl%d", nvdimm_bus->id);
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return -ENOMEM;
+	device_initialize(dev);
+	device_set_pm_not_required(dev);
+	dev->class = nd_class;
+	dev->parent = &nvdimm_bus->dev;
+	dev->devt = devt;
+	dev->release = ndctl_release;
+	rc = dev_set_name(dev, "ndctl%d", nvdimm_bus->id);
+	if (rc)
+		goto err;
 
-	if (IS_ERR(dev))
-		dev_dbg(&nvdimm_bus->dev, "failed to register ndctl%d: %ld\n",
-				nvdimm_bus->id, PTR_ERR(dev));
-	return PTR_ERR_OR_ZERO(dev);
+	rc = device_add(dev);
+	if (rc) {
+		dev_dbg(&nvdimm_bus->dev, "failed to register ndctl%d: %d\n",
+				nvdimm_bus->id, rc);
+		goto err;
+	}
+	return 0;
+
+err:
+	put_device(dev);
+	return rc;
 }
 
 void nvdimm_bus_destroy_ndctl(struct nvdimm_bus *nvdimm_bus)

