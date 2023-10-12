Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85F02AB39
	for <linux-cxl@vger.kernel.org>; Thu, 12 Oct 2023 18:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EbtkrpcO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E0483
	for <linux-cxl@vger.kernel.org>; Thu, 12 Oct 2023 11:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697136927; x=1728672927;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dGvthp3qvPH1lghkUXhbfXG/Iv6vqSOgP0V0xvaNpOI=;
  b=EbtkrpcO1RNP1i4GmAVdsPpM4yAgzIBqzVVlNIEHaOIXNA2Go+j0J9h4
   pMNd49yK2+AmkPlM1aC1YO5/hU0HCQ+d18Us0nzD9y4c9fXvEtQqY7S9S
   4bIA7G4Ng76i/aFNKwghv+9rUa6VxsjeRDO8yWNnhmSrfEqn3AuYoDs3n
   oiDJDOcw3HglgdIf/bJAgeeWhLgVBn6lqeyNifrupQMZwZifwsCQS0HjT
   Fj7rlRpf+xp0mcdflOhIt8Y4zZhtbcInWtUYoOSMsH3e/fa/BWz7/fpV+
   LoMkLqib0GmPlKVfDVVwr8BnrXe8YodsGqcLZV/IGnK3S56Gt3eMmcy2P
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="3604209"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="3604209"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 11:55:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="824724538"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="824724538"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.15.16])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 11:55:13 -0700
Subject: [PATCH v11 17/22] cxl: Store the access coordinates for the generic
 ports
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Thu, 12 Oct 2023 11:55:12 -0700
Message-ID: <169713691235.2205276.8146804174143909257.stgit@djiang5-mobl3>
In-Reply-To: <169713674328.2205276.10184241477215488339.stgit@djiang5-mobl3>
References: <169713674328.2205276.10184241477215488339.stgit@djiang5-mobl3>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
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
index 1eb477e8274c..cfce4cc7a719 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -513,8 +513,21 @@ static int cxl_get_chbs(struct device *dev, struct acpi_device *hb,
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
@@ -564,6 +577,10 @@ static int add_host_bridge_dport(struct device *match, void *arg)
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


