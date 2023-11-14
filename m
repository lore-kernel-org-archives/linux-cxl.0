Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AD526AC0
	for <linux-cxl@vger.kernel.org>; Tue, 14 Nov 2023 23:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qqem4Mo5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A95D2
	for <linux-cxl@vger.kernel.org>; Tue, 14 Nov 2023 15:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700003140; x=1731539140;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Bj3S+yVXh+0pRsFKn5IqHx0nGu5TI+/uvQi0u+VLm+Y=;
  b=Qqem4Mo5eCj3s1p8xaEpIEquWiM0WgVcXFiKsixiadbNAkYl/M+YzvqO
   kxB6aBXxFSxnEadJsJne1tY1TOg2QJD1cIAR8mFwaKkYblYMAL2T/z7dz
   KCww0k0HT9eZbng9JgS43insofeDc/GE62Y9F+2ozKwFeh03Dp0KOvzdZ
   b26fS0+3fku7Yfk0OwupTrR7SyK42mm2P4+uJe3Cm1hU3euONsol8WDO6
   PlW687061hrvitVOV6xniZ0p90WxwL+6q+Um8Jw+ff8lJWOIzHXnhxJwU
   mVuJKQXQJdYFDHSsmgO+u4PBsQtWNMin3LguwsMHVQwj/tLsmxSAXcoAk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="12308519"
X-IronPort-AV: E=Sophos;i="6.03,303,1694761200"; 
   d="scan'208";a="12308519"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 15:05:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,303,1694761200"; 
   d="scan'208";a="12586008"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.87.32])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 15:05:39 -0800
Subject: [PATCH v12 15/18] cxl: Compute the entire CXL path latency and
 bandwidth data
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Tue, 14 Nov 2023 16:05:39 -0700
Message-ID: <170000313905.1974471.14743805514066092526.stgit@djiang5-mobl3>
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
 drivers/cxl/cxl.h  |    3 +++
 drivers/cxl/port.c |   58 +++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 58 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 912bde059666..78b45a7f46a2 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -880,6 +880,9 @@ struct dsmas_entry {
 	struct range dpa_range;
 	u8 handle;
 	struct access_coordinate coord;
+
+	int entries;
+	int qos_class;
 };
 
 int cxl_cdat_endpoint_process(struct cxl_port *port, struct list_head *list);
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


