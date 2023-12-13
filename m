Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VkzZCcN4"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2293A98
	for <linux-cxl@vger.kernel.org>; Wed, 13 Dec 2023 08:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702485767; x=1734021767;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tzCSM3wjz6jq58jQJgSpYbriyMPLdGBzcFyZW2+vRuQ=;
  b=VkzZCcN4mJc0B58e6NvlypF1CssU20J/PjGRoLW9OwBnmkCxxMsSgLBI
   9XSQeu7n5mcwXdEzwmrUn3DKe1LuLyl0GVaWQkkIvO/JMGCEeIrVSjqkA
   yshgtAXbrZXSmNFIGXHQ/J/B/7OGX9xEvJr51xjKaoEX385ZCXaFgaDbl
   PzouBhj0Lhn5DZst81Mx9x2fsBoIKWM7bdVUnSkTXv4CV29Ywp4RswPvW
   yKcSaDzqB1fyww8QaApVXPHU4An3Eu+E2K/57tQaOdN4nmrtI94e2Gkce
   U32SttqpYlEG1o1+fYhiVj5UQzhX2UpBekMMsd+JqzSBgqo0elxu3uq82
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="394745593"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="394745593"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 08:42:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="808218627"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="808218627"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.76.225])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 08:42:45 -0800
Subject: [PATCH v14 14/19] cxl: Store the access coordinates for the generic
 ports
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Wed, 13 Dec 2023 09:42:44 -0700
Message-ID: <170248576478.801570.6671865426704700354.stgit@djiang5-mobl3>
In-Reply-To: <170248552797.801570.14580769385012396142.stgit@djiang5-mobl3>
References: <170248552797.801570.14580769385012396142.stgit@djiang5-mobl3>
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
index 2f7de910ce57..afc712264d1c 100644
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
index 7da8db919a20..dd234f3b9ed4 100644
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
 


