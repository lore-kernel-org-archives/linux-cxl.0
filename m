Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C430FC7EE39
	for <linux-cxl@archiver.kernel.org>; Fri, 19 May 2023 17:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjESRJe (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 19 May 2023 13:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbjESRJ1 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 19 May 2023 13:09:27 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F821A1
        for <linux-cxl@vger.kernel.org>; Fri, 19 May 2023 10:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684516154; x=1716052154;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HQE7u7MtWpYtQfOgdXuDYgh4z8uJ6pdIS40kuv+tT/I=;
  b=aH32AkGnvo8cqYMjYc06fIO+sXZ2z27xEJmclTGWFBXvfaipG2pI4FPE
   tHQ/a4AAQmvetCB8b54OIn1sghLAJIWHY6Ph0hEHtNV5YZc+j8qGrG3sR
   8ALu+YNttvWAoK41skHIeuxV6R7aMzfX5aT4kmGoDcue9+dtwOeFfNYiF
   BX29hILq0uZYcFE6WjlQJ14rTtLgTawHE4VaEo2BUP441JVtau0DWoG2g
   /cXXsnAgRp/F0HPBO0h96nUabgXeYdRbfNxTDgu9G9hDjuovc0EB/9cT9
   ruPGnx/TMpIPB+3K8tkVocgOL8mrDMu6sVoBrMzTmjSSYpYh/ybOukEKg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10715"; a="438778326"
X-IronPort-AV: E=Sophos;i="6.00,177,1681196400"; 
   d="scan'208";a="438778326"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2023 10:07:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10715"; a="876911011"
X-IronPort-AV: E=Sophos;i="6.00,177,1681196400"; 
   d="scan'208";a="876911011"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.29.189])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2023 10:07:10 -0700
Subject: [PATCH v6 06/11] cxl: Store the access coordinates for the generic
 ports
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com
Date:   Fri, 19 May 2023 10:07:10 -0700
Message-ID: <168451603029.3470703.13447576080193633262.stgit@djiang5-mobl3>
In-Reply-To: <168451588868.3470703.3527256859632103687.stgit@djiang5-mobl3>
References: <168451588868.3470703.3527256859632103687.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Each CXL host bridge is represented by an ACPI0016 device. A generic port
device handle that is an ACPI device is represented by a string of
ACPI0016 device HID and UID. Create a device handle from the ACPI device
and retrieve the access coordinates from the stored memory targets. The
access coordinates are stored under the cxl_dport that is associated with
the CXL host bridge.

The access coordinates struct is dynamically allocated under cxl_dport in
order for code later on to detect whether the data exists or not.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v6:
- Change memcpy to strncpy. ACPI HID and UID are strings.
---
 drivers/cxl/acpi.c |   22 ++++++++++++++++++++++
 drivers/cxl/cxl.h  |    2 ++
 2 files changed, 24 insertions(+)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 8247df06d683..0c22cc9dbcba 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -557,8 +557,26 @@ static int cxl_get_chbcr(union acpi_subtable_headers *header, void *arg,
 	return 0;
 }
 
+static int get_genport_coordinates(struct device *dev, struct cxl_dport *dport)
+{
+	struct acpi_device *hb = to_cxl_host_bridge(NULL, dev);
+	u8 handle[ACPI_SRAT_DEVICE_HANDLE_SIZE] = { 0 };
+	int rc;
+
+	/* ACPI spec 6.5 table 5.65 */
+	strncpy(handle, acpi_device_hid(hb), 8);
+	strncpy(&handle[8], acpi_device_uid(hb), 4);
+
+	rc = acpi_get_genport_coordinates(handle, &dport->hb_access);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
 static int add_host_bridge_dport(struct device *match, void *arg)
 {
+	int ret;
 	acpi_status rc;
 	struct device *bridge;
 	unsigned long long uid;
@@ -614,6 +632,10 @@ static int add_host_bridge_dport(struct device *match, void *arg)
 	if (IS_ERR(dport))
 		return PTR_ERR(dport);
 
+	ret = get_genport_coordinates(match, dport);
+	if (ret)
+		dev_dbg(match, "Failed to get generic port perf coordinates.\n");
+
 	return 0;
 }
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 3d0c8c63f6d6..2369e91add63 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -636,6 +636,7 @@ cxl_find_dport_by_dev(struct cxl_port *port, const struct device *dport_dev)
  * @rcrb: base address for the Root Complex Register Block
  * @rch: Indicate whether this dport was enumerated in RCH or VH mode
  * @port: reference to cxl_port that contains this downstream port
+ * @genport_coord: access coordinates (performance) from ACPI generic port
  * @coord: access coordinates (performance) for switch from CDAT
  * @link_latency: calculated PCIe downstream latency
  */
@@ -646,6 +647,7 @@ struct cxl_dport {
 	resource_size_t rcrb;
 	bool rch;
 	struct cxl_port *port;
+	struct access_coordinate hb_access;
 	struct access_coordinate coord;
 	long link_latency;
 };


