Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5E9EB64D7
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Jun 2023 21:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjFPVmU (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 16 Jun 2023 17:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244034AbjFPVmT (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 16 Jun 2023 17:42:19 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93393AB4
        for <linux-cxl@vger.kernel.org>; Fri, 16 Jun 2023 14:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686951735; x=1718487735;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YyG/Cuw60zNywCB9zlRLunD6Bd+wP9OjUFPvgUaTZEY=;
  b=JghdSSNIhLB1dXwnggsnExkxf1/iJrDRRWk/xrDdMZcVrGJJi9SmVMgR
   uMo/+0X1DmCRERc1GYpii39iUiRPZncHwCANk4+ezZ7LG1GkleCxE7K0w
   KjVZqVAosQQLLJ/31swUT+k9C/zPtxFyIjioR/9vY/wdS+3UDkBEaEAx6
   WetmTjKXyt0XcmDGnCbSFUDyCor831Mx8+vHR5IF0ZzVHIw40nsa/+fsa
   sSV/50IgBDLp2elibHUbv1jf8g0Bc35ODFnlcX1qJk7uxAnceKO2jywhI
   wt2F6gFGA7lR9IoG4iBIeLJ0rhrQpVWoL/bRyoGFzG3HYdj95pJD3ovWW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="362733625"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="362733625"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 14:42:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="959757361"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="959757361"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.16.91])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 14:42:13 -0700
Subject: [PATCH v7 06/11] cxl: Store the access coordinates for the generic
 ports
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com
Date:   Fri, 16 Jun 2023 14:42:14 -0700
Message-ID: <168695173453.3031571.10697142055227463943.stgit@djiang5-mobl3>
In-Reply-To: <168695160531.3031571.4875512229068707023.stgit@djiang5-mobl3>
References: <168695160531.3031571.4875512229068707023.stgit@djiang5-mobl3>
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

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v7:
- Directly return from acpi_get_genport_coordinates(). (Jonathan)
v6:
- Change memcpy to strncpy. ACPI HID and UID are strings.
---
 drivers/cxl/acpi.c |   17 +++++++++++++++++
 drivers/cxl/cxl.h  |    2 ++
 2 files changed, 19 insertions(+)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 8247df06d683..b54c325f9db3 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -557,8 +557,21 @@ static int cxl_get_chbcr(union acpi_subtable_headers *header, void *arg,
 	return 0;
 }
 
+static int get_genport_coordinates(struct device *dev, struct cxl_dport *dport)
+{
+	struct acpi_device *hb = to_cxl_host_bridge(NULL, dev);
+	u8 handle[ACPI_SRAT_DEVICE_HANDLE_SIZE] = { 0 };
+
+	/* ACPI spec 6.5 table 5.65 */
+	strncpy(handle, acpi_device_hid(hb), 8);
+	strncpy(&handle[8], acpi_device_uid(hb), 4);
+
+	return acpi_get_genport_coordinates(handle, &dport->hb_access);
+}
+
 static int add_host_bridge_dport(struct device *match, void *arg)
 {
+	int ret;
 	acpi_status rc;
 	struct device *bridge;
 	unsigned long long uid;
@@ -614,6 +627,10 @@ static int add_host_bridge_dport(struct device *match, void *arg)
 	if (IS_ERR(dport))
 		return PTR_ERR(dport);
 
+	ret = get_genport_coordinates(match, dport);
+	if (ret)
+		dev_dbg(match, "Failed to get generic port perf coordinates.\n");
+
 	return 0;
 }
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 208e98225abf..e55a62c461fd 100644
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


