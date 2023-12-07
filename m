Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q3w04Sgd"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0E8D5B
	for <linux-cxl@vger.kernel.org>; Thu,  7 Dec 2023 14:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701989998; x=1733525998;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7nuH4omvvsYXw7JaehmplD23BXLqgtq3Hsf4NhQ65W4=;
  b=Q3w04Sgd7GsTTWjKgL962mi5vZEHh7iEII2NpNZ9dpKu1nbvea4hmufY
   6BHLKG+wl+ButjRMnrQoSBmaqMcF+V/0zFVEs+ejpBGjXm9sQ6YxsXzqN
   B3lLzWHk0c/o0KqhWhnxwsnT3YfIFKu/0OH9FljOstqD1GBjoW+H1utx0
   YRfPUj0gt6m410h5+T/ZBX9oiG5AwXCXkpydTINw0VDjDDjoNRgPR+/Wz
   dM80fsD4LKH3mqCGqvmyOTkV5LE2z7KGXaJlwL1rJjuI6zRN67nEReZUW
   B+3Kzmmrp1CmNnaoljZEIkSTOvPa0RT/e7wqyaeBigFDL7df5PvPqzUzG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="397107796"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="397107796"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 14:59:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="895312825"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="895312825"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.213.168.225])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 14:59:48 -0800
Subject: [PATCH v13 14/19] cxl: Store the access coordinates for the generic
 ports
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Thu, 07 Dec 2023 15:59:47 -0700
Message-ID: <170198998791.3522351.9593377199566058103.stgit@djiang5-mobl3>
In-Reply-To: <170198976423.3522351.8359845516235306693.stgit@djiang5-mobl3>
References: <170198976423.3522351.8359845516235306693.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

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
 drivers/cxl/acpi.c |   25 +++++++++++++++++++++++++
 drivers/cxl/cxl.h  |    2 ++
 2 files changed, 27 insertions(+)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index ba30b405d260..948b1e7eb8f7 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -513,8 +513,29 @@ static int cxl_get_chbs(struct device *dev, struct acpi_device *hb,
 	return 0;
 }
 
+static int get_genport_coordinates(struct device *dev, struct cxl_dport *dport)
+{
+	struct acpi_device *hb = to_cxl_host_bridge(NULL, dev);
+	u32 uid;
+	int rc;
+
+	if (kstrtou32(acpi_device_uid(hb), 0, &uid))
+		return -EINVAL;
+
+	rc = acpi_get_genport_coordinates(uid, &dport->hb_coord);
+	if (rc < 0)
+		return rc;
+
+	/* Adjust back to picoseconds from nanoseconds */
+	dport->hb_coord.read_latency *= 1000;
+	dport->hb_coord.write_latency *= 1000;
+
+	return 0;
+}
+
 static int add_host_bridge_dport(struct device *match, void *arg)
 {
+	int ret;
 	acpi_status rc;
 	struct device *bridge;
 	struct cxl_dport *dport;
@@ -564,6 +585,10 @@ static int add_host_bridge_dport(struct device *match, void *arg)
 	if (IS_ERR(dport))
 		return PTR_ERR(dport);
 
+	ret = get_genport_coordinates(match, dport);
+	if (ret)
+		dev_dbg(match, "Failed to get generic port perf coordinates.\n");
+
 	return 0;
 }
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 1abfc7035311..e4995cfa6822 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -661,6 +661,7 @@ struct cxl_rcrb_info {
  * @port: reference to cxl_port that contains this downstream port
  * @regs: Dport parsed register blocks
  * @sw_coord: access coordinates (performance) for switch from CDAT
+ * @hb_coord: access coordinates (performance) from ACPI generic port (host bridge)
  * @link_latency: calculated PCIe downstream latency
  */
 struct cxl_dport {
@@ -672,6 +673,7 @@ struct cxl_dport {
 	struct cxl_port *port;
 	struct cxl_regs regs;
 	struct access_coordinate sw_coord;
+	struct access_coordinate hb_coord;
 	long link_latency;
 };
 


