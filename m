Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D54C7EE26
	for <linux-cxl@archiver.kernel.org>; Mon,  8 May 2023 20:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbjEHUrs (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 8 May 2023 16:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233079AbjEHUrr (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 8 May 2023 16:47:47 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C155859D3
        for <linux-cxl@vger.kernel.org>; Mon,  8 May 2023 13:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683578865; x=1715114865;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MxDcpaop7BEJXbAJJ/mIUTokUJIg6NVkc2lo++oUdkM=;
  b=ONLCQ3pwzEkTRC9ci+aXKMas8gsbVlHLqhJxoQKUf8STgNRPFV2mtaQ1
   yK/E89/gENG+5CqnqkrA2nsdzHqf2B3XWfoNS9kOHM/Iwh+dvueH+iVbT
   KAKGaV12ZmQXBhj7mr1IhNUlV9o1K8OUhhPDfNbMxtEB9j7soW/RhaFGH
   uLJ4Y2xE1S/eAETPRwjLsgOtzi8mJR56EoF4QmKx7XnYJNQG6xvfKOSdO
   PEJhL9IxhFKjddWWXF5Peqcd+XdGfFQoMU7KrsnfuMWpqp+fFAUDBh9GU
   XA6xq9ZokrRp6H4gLnSfvFj6sisjL4sG4Ao7+B/m2XV6KY7SLeQ5gBfyH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="338976835"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="338976835"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 13:47:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="731431702"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="731431702"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.213.172.228])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 13:47:30 -0700
Subject: [PATCH v5 06/14] cxl: Store the access coordinates for the generic
 ports
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com
Date:   Mon, 08 May 2023 13:47:29 -0700
Message-ID: <168357884996.2756219.11067819935569345137.stgit@djiang5-mobl3>
In-Reply-To: <168357873843.2756219.5839806150467356492.stgit@djiang5-mobl3>
References: <168357873843.2756219.5839806150467356492.stgit@djiang5-mobl3>
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

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/acpi.c |   28 ++++++++++++++++++++++++++++
 drivers/cxl/cxl.h  |    2 ++
 2 files changed, 30 insertions(+)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index f9b35e8fe810..675a4f423f4b 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -537,8 +537,26 @@ static int cxl_get_chbcr(union acpi_subtable_headers *header, void *arg,
 	return 0;
 }
 
+static int get_genport_coordinates(struct device *dev, struct cxl_dport *dport)
+{
+	struct acpi_device *hb = to_cxl_host_bridge(NULL, dev);
+	u8 handle[ACPI_SRAT_DEVICE_HANDLE_SIZE] = { 0 };
+	int rc;
+
+	/* ACPI spec 6.5 tABLE 5.65 */
+	memcpy(handle, acpi_device_hid(hb), 8);
+	memcpy(&handle[8], acpi_device_uid(hb), 4);
+
+	rc = acpi_get_genport_coordinates(handle, dport->genport_coord);
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
@@ -594,6 +612,16 @@ static int add_host_bridge_dport(struct device *match, void *arg)
 	if (IS_ERR(dport))
 		return PTR_ERR(dport);
 
+	dport->genport_coord = devm_kzalloc(dport->dport,
+					    sizeof(*dport->genport_coord),
+					    GFP_KERNEL);
+	if (!dport->genport_coord)
+		return -ENOMEM;
+
+	ret = get_genport_coordinates(match, dport);
+	if (ret)
+		dev_dbg(match, "Failed to get generic port perf coordinates.\n");
+
 	return 0;
 }
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index c1e2c3703a63..033b822a20f2 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -626,6 +626,7 @@ cxl_find_dport_by_dev(struct cxl_port *port, const struct device *dport_dev)
  * @rcrb: base address for the Root Complex Register Block
  * @rch: Indicate whether this dport was enumerated in RCH or VH mode
  * @port: reference to cxl_port that contains this downstream port
+ * @genport_coord: access coordinates (performance) from ACPI generic port
  * @coord: access coordinates (performance) for switch from CDAT
  * @link_latency: calculated PCIe downstream latency
  */
@@ -636,6 +637,7 @@ struct cxl_dport {
 	resource_size_t rcrb;
 	bool rch;
 	struct cxl_port *port;
+	struct access_coordinate *genport_coord;
 	struct access_coordinate coord;
 	long link_latency;
 };


