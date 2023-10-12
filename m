Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DDA358B5
	for <linux-cxl@vger.kernel.org>; Thu, 12 Oct 2023 18:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L8TEckoy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38CF83
	for <linux-cxl@vger.kernel.org>; Thu, 12 Oct 2023 11:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697136930; x=1728672930;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qpYA+mxsekueWxUrGQhYL9tjY3MrrmDar386K3k/iN8=;
  b=L8TEckoyMipY0AsWrVCaB70eYRlJwtUi0L9othf3v98sz/QLw2tkFAVe
   GQKgZF70k6rIizCLxrxET22UnMQ2GNYPRdvurYMllZ1HVrngiqG/XnIcG
   p7hkLi3xMl4HjHUUoKSGHxGu2Bwjwm0RAJ7PJ9EaHY2MQBuaqqxwGVBEF
   XNRoTDqaRTSqVwe7IVznLDVqncQYDjb4RfgwLyRfXGi/iDj3TE0SxPuy0
   N6xCYlvalEG0WBivzRuK0m0autbXgnfPaH6a51/Euhu5JvsabduGjOXOE
   CQbNML3CApOkur1L70PBbf5kJaglkKswf/aYfuazs0OvPoEe9yM8iKkl0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="3604267"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="3604267"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 11:55:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="824724621"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="824724621"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.15.16])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 11:55:24 -0700
Subject: [PATCH v11 19/22] cxl: Compute the entire CXL path latency and
 bandwidth data
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Thu, 12 Oct 2023 11:55:24 -0700
Message-ID: <169713692442.2205276.676765260116439939.stgit@djiang5-mobl3>
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

CXL Memory Device SW Guide [1] rev1.0 2.11.2 provides instruction on how to
calculate latency and bandwidth for CXL memory device. Calculate minimum
bandwidth and total latency for the path from the CXL device to the root
port. The QTG id is retrieved by providing the performance data as input
and calling the root port callback ->get_qos_class(). The retrieved id is
stored with the cxl_port of the CXL device.

For example for a device that is directly attached to a host bus:
Total Latency = Device Latency (from CDAT) + Dev to Host Bus (HB) Link
		Latency + Generic Port Latency
Min Bandwidth = Min bandwidth for link bandwidth between HB
		and CXL device, device CDAT bandwidth, and Generic Port
		Bandwidth

For a device that has a switch in between host bus and CXL device:
Total Latency = Device (CDAT) Latency + Dev to Switch Link Latency +
		Switch (CDAT) Latency + Switch to HB Link Latency +
		Generic Port Latency
Min Bandwidth = Min bandwidth for link bandwidth between CXL device
		to CXL switch, CXL device CDAT bandwidth, CXL switch CDAT
		bandwidth, CXL switch to HB bandwidth, and Generic Port
		Bandwidth.

[1]: https://cdrdv2-public.intel.com/643805/643805_CXL%20Memory%20Device%20SW%20Guide_Rev1p0.pdf

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v10:
- Update to new get_qos_class() API call. Only retrieve 1 QTG ID since
  this is what the kernel is using. Can expand to retrieve additional IDs
  in the future when needed. (Dan)
---
 drivers/cxl/cxl.h  |    4 ++++
 drivers/cxl/port.c |   58 +++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 59 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 61b58b25834d..9569ff70ea6e 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -859,12 +859,16 @@ static inline struct cxl_dax_region *to_cxl_dax_region(struct device *dev)
 }
 #endif
 
+
 /* CDAT related bits */
 struct dsmas_entry {
 	struct list_head list;
 	struct range dpa_range;
 	u8 handle;
 	struct access_coordinate coord;
+
+	int entries;
+	int qos_class;
 };
 
 #ifdef CONFIG_FIRMWARE_TABLE
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index f5e2be79f217..99a619360bc5 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -57,6 +57,54 @@ static int discover_region(struct device *dev, void *root)
 	return 0;
 }
 
+static int cxl_port_perf_data_calculate(struct cxl_port *port,
+					struct list_head *dsmas_list)
+{
+	struct access_coordinate c;
+	struct cxl_port *root_port;
+	struct cxl_root *cxl_root;
+	struct dsmas_entry *dent;
+	int valid_entries = 0;
+	int rc;
+
+	rc = cxl_endpoint_get_perf_coordinates(port, &c);
+	if (rc) {
+		dev_dbg(&port->dev, "Failed to retrieve perf coordinates.\n");
+		return rc;
+	}
+
+	root_port = find_cxl_root(port);
+	cxl_root = to_cxl_root(root_port);
+	if (!cxl_root->ops || !cxl_root->ops->get_qos_class)
+		return -EOPNOTSUPP;
+
+	list_for_each_entry(dent, dsmas_list, list) {
+		int qos_class;
+
+		dent->coord.read_latency = dent->coord.read_latency +
+					   c.read_latency;
+		dent->coord.write_latency = dent->coord.write_latency +
+					    c.write_latency;
+		dent->coord.read_bandwidth = min_t(int, c.read_bandwidth,
+						   dent->coord.read_bandwidth);
+		dent->coord.write_bandwidth = min_t(int, c.write_bandwidth,
+						    dent->coord.write_bandwidth);
+
+		dent->entries = 1;
+		rc = cxl_root->ops->get_qos_class(root_port, &dent->coord, 1, &qos_class);
+		if (rc != 1)
+			continue;
+
+		valid_entries++;
+		dent->qos_class = qos_class;
+	}
+
+	if (!valid_entries)
+		return -ENOENT;
+
+	return 0;
+}
+
 static int cxl_switch_port_probe(struct cxl_port *port)
 {
 	struct cxl_hdm *cxlhdm;
@@ -146,10 +194,14 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 		LIST_HEAD(dsmas_list);
 
 		rc = cxl_cdat_endpoint_process(port, &dsmas_list);
-		if (rc < 0)
+		if (rc < 0) {
 			dev_dbg(&port->dev, "Failed to parse CDAT: %d\n", rc);
-
-		/* Performance data processing */
+		} else {
+			rc = cxl_port_perf_data_calculate(port, &dsmas_list);
+			if (rc)
+				dev_dbg(&port->dev,
+					"Failed to do perf coord calculations.\n");
+		}
 
 		cxl_cdat_dsmas_list_destroy(&dsmas_list);
 	}


