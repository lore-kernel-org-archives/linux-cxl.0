Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC6D810
	for <linux-cxl@vger.kernel.org>; Wed, 11 Oct 2023 01:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F0q9jFty"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B29A4
	for <linux-cxl@vger.kernel.org>; Tue, 10 Oct 2023 18:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696986402; x=1728522402;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BjzrQ+MCGnwetZJgdD9yr2HxKw4XgpwZJGY9Fb1f+JU=;
  b=F0q9jFtyBytcAKihYBE96sHt2PKXABDl5uLdKjVGotFlvlLqAxUdoFBF
   ofcUpAcZN4k2xy9gYJCN7UNSX0L8LnS35/yIg/mr+DM9dhyGHeVrfFghi
   RaB4whVvkbJy/kW7M76Shgcq4Ez/+9cghOQTzFNAl5osw3ejA2BlNuH2p
   ZKtbTxyk69EWdQijdmOmY1RpMyeZ69ca8/M89O5kOr/YhQMc+KuXP29EX
   EzC5vxQehQGzmsGx3sjzIre7Rein+vYgh/1AGppAnSRbII2e8Q33h4QQI
   LBEggtaW6wvlBW9ZhLzAUEtfyuz76M6G2g/Izb+T3vVwxbbiYvJtFSBEV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="451043450"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="451043450"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 18:06:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="753647081"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="753647081"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.35.251])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 18:06:41 -0700
Subject: [PATCH v10 17/22] cxl: Store the access coordinates for the generic
 ports
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Tue, 10 Oct 2023 18:06:41 -0700
Message-ID: <169698640115.1991735.9205716695726309354.stgit@djiang5-mobl3>
In-Reply-To: <169698612949.1991735.1140524325982776941.stgit@djiang5-mobl3>
References: <169698612949.1991735.1140524325982776941.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
 drivers/cxl/acpi.c |   17 +++++++++++++++++
 drivers/cxl/cxl.h  |    2 ++
 2 files changed, 19 insertions(+)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index a84fef73f8ce..b149be97c233 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -512,8 +512,21 @@ static int cxl_get_chbs(struct device *dev, struct acpi_device *hb,
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
 	struct cxl_dport *dport;
@@ -563,6 +576,10 @@ static int add_host_bridge_dport(struct device *match, void *arg)
 	if (IS_ERR(dport))
 		return PTR_ERR(dport);
 
+	ret = get_genport_coordinates(match, dport);
+	if (ret)
+		dev_dbg(match, "Failed to get generic port perf coordinates.\n");
+
 	return 0;
 }
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index f1c43f02d65e..f7bbd57d9bcf 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -655,6 +655,7 @@ struct cxl_rcrb_info {
  * @rcrb: Data about the Root Complex Register Block layout
  * @rch: Indicate whether this dport was enumerated in RCH or VH mode
  * @port: reference to cxl_port that contains this downstream port
+ * @genport_coord: access coordinates (performance) from ACPI generic port
  * @coord: access coordinates (performance) for switch from CDAT
  * @link_latency: calculated PCIe downstream latency
  */
@@ -665,6 +666,7 @@ struct cxl_dport {
 	struct cxl_rcrb_info rcrb;
 	bool rch;
 	struct cxl_port *port;
+	struct access_coordinate hb_access;
 	struct access_coordinate coord;
 	long link_latency;
 };


