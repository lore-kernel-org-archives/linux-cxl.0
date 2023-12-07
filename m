Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c97VOnPO"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A3610EF
	for <linux-cxl@vger.kernel.org>; Thu,  7 Dec 2023 15:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701990002; x=1733526002;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3TN/dm5Wo3eJvJJHwUJiBgISPJOXma1XJ/joYXzeOPM=;
  b=c97VOnPO2LKAATCe5VKuSSJLcoF3tSrtlODCJ+Lg6g6HEl3T+LPbFVa5
   tVwtpdtKoI3ytZMCDFNplXDvcSqMqkx+/e2xv4877/qQeW4R1YO2Gn9rJ
   b8iXyCTnqsKvzmTVd31y3sN0WRZ3ZzJri+fhFqzeM8vbKsYiS8s4RooGn
   Qwf7L3EfdZ5YUi94Kqhq3yympnOp3xpsVlYcN1eOCp7qWGuvjncoiQ9Ts
   ke+UoUT2wf1vIt6VSMo6hekduztZE189d0MyFa0TK+NRZh1MnoayTv0SC
   6/6oSfTd3Wxj8gG6H+eNMOs9fc7EEhpjWcnIe72o0RkDTupIeEq6Wwkhe
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="397107818"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="397107818"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 15:00:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="895312974"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="895312974"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.213.168.225])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 15:00:01 -0800
Subject: [PATCH v13 16/19] cxl: Compute the entire CXL path latency and
 bandwidth data
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Thu, 07 Dec 2023 16:00:01 -0700
Message-ID: <170199000099.3522351.3838553674091112628.stgit@djiang5-mobl3>
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
v13:
- Convert list usage to xarray (Dan)
---
 drivers/cxl/cxl.h  |    3 +++
 drivers/cxl/port.c |   59 +++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 59 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index dbf2a1e601bf..004534cf0361 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -878,6 +878,9 @@ struct dsmas_entry {
 	struct range dpa_range;
 	u8 handle;
 	struct access_coordinate coord;
+
+	int entries;
+	int qos_class;
 };
 
 int cxl_cdat_endpoint_process(struct cxl_port *port, struct xarray *dsmas_xa);
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 9cd6cbbdd3b4..1a059d48154f 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -57,6 +57,55 @@ static int discover_region(struct device *dev, void *root)
 	return 0;
 }
 
+static int cxl_port_perf_data_calculate(struct cxl_port *port,
+					struct xarray *dsmas_xa)
+{
+	struct access_coordinate c;
+	struct cxl_port *root_port;
+	struct cxl_root *cxl_root;
+	struct dsmas_entry *dent;
+	int valid_entries = 0;
+	unsigned long index;
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
+	xa_for_each(dsmas_xa, index, dent) {
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
@@ -146,10 +195,14 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 		DEFINE_XARRAY(dsmas_xa);
 
 		rc = cxl_cdat_endpoint_process(port, &dsmas_xa);
-		if (rc < 0)
+		if (rc < 0) {
 			dev_dbg(&port->dev, "Failed to parse CDAT: %d\n", rc);
-
-		/* Performance data processing */
+		} else {
+			rc = cxl_port_perf_data_calculate(port, &dsmas_xa);
+			if (rc)
+				dev_dbg(&port->dev,
+					"Failed to do perf coord calculations.\n");
+		}
 
 		cxl_cdat_dsmas_xa_destroy(&dsmas_xa);
 	}


