Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6271126AC0
	for <linux-cxl@vger.kernel.org>; Tue, 14 Nov 2023 23:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h174qKRx"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9554DD1
	for <linux-cxl@vger.kernel.org>; Tue, 14 Nov 2023 15:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700003131; x=1731539131;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4HstgDDU5Tk2FgUZ/bpNEBPubFvtyO47MTlSmT9pLB0=;
  b=h174qKRx/gS1NdoXy2Vl4CbpRGwq5vsv9VKN5SsVRy/wkOOTJLpMig6x
   ujwEFJ+8H94um6PySsMDq/4onk5UD9ndN1qGj/R4XAqxaA+KQH4Qqrr+J
   3rejDBQx79PjNIjCuQucLN73Qt8QJI722zWd04PmmSv0kc2ee2aPE5yAP
   63i84aUYLaOoMbKfPbDK8VoLD5UetsIK7pIjYScJ/d7/fBA1OxLhp33HC
   k//HC1TEAvFFDaJArgWXaFERAiNv1yVBZ1vpJEgKBD4l59xGmakttNOKc
   ONMvnsiR4GeFjx7Vjup8tBMe7akPRgNx+F22e3gGlIKaWwUD2lmkdDW61
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="476985906"
X-IronPort-AV: E=Sophos;i="6.03,303,1694761200"; 
   d="scan'208";a="476985906"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 15:05:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="793952878"
X-IronPort-AV: E=Sophos;i="6.03,303,1694761200"; 
   d="scan'208";a="793952878"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.87.32])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 15:05:26 -0800
Subject: [PATCH v12 13/18] cxl: Store the access coordinates for the generic
 ports
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Tue, 14 Nov 2023 16:05:26 -0700
Message-ID: <170000312622.1974471.18000426927665630466.stgit@djiang5-mobl3>
In-Reply-To: <170000290509.1974471.16084327074615798619.stgit@djiang5-mobl3>
References: <170000290509.1974471.16084327074615798619.stgit@djiang5-mobl3>
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
v12:
- Change hb_access to hb_coord
- Update calling of acpi_get_genport_coordinates() with uid
- Adjust latency from nsec to psec
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
index 4833c53c486e..77db32a95215 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -662,6 +662,7 @@ struct cxl_rcrb_info {
  * @port: reference to cxl_port that contains this downstream port
  * @regs: Dport parsed register blocks
  * @sw_coord: access coordinates (performance) for switch from CDAT
+ * @hb_coord: access coordinates (performance) from ACPI generic port (host bridge)
  * @link_latency: calculated PCIe downstream latency
  */
 struct cxl_dport {
@@ -673,6 +674,7 @@ struct cxl_dport {
 	struct cxl_port *port;
 	struct cxl_regs regs;
 	struct access_coordinate sw_coord;
+	struct access_coordinate hb_coord;
 	long link_latency;
 };
 


