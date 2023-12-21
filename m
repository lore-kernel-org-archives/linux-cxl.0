Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8525477B5A
	for <linux-cxl@vger.kernel.org>; Thu, 21 Dec 2023 22:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FYDYS0NS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703196246; x=1734732246;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JKHQNT2JcBCxJzUHK3X7zl3GrHb2vUHUVTe13gCMFD0=;
  b=FYDYS0NSA+W2g6DrrP7ydKc6tMJAu5xcE9mzPDhhQ3MGdgDBGvS0AFCg
   7S0UrlExnxYkzXBQ0IcK3mTelSM8Zt1OrfsJ3mjmvk5PwDnXfKH2iH50h
   5fMN/LRik/7ozxBtRdx0dErykFYrr/eqpWy/DQ6y3YNhyDH3WShF2UkcA
   5cve4X6AGY7Ix0eMD1I1gcnxbkzNXVUpZyLR6RIu5l7GDjR64ZzDwP4oy
   2kNb2mJ1bamUD76tHkI4RqwtIyjK2OoS/bnqnVqArhSmgc928U81UB9FK
   sWfX7kP0NryGLXBNrDapQhKMgUxQOKw5CAwi33Mp+XGzzoqrFoumHViUh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="376184561"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="376184561"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 14:04:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="25116440"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.31.86])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 14:04:05 -0800
Subject: [PATCH v15 16/19] cxl: Compute the entire CXL path latency and
 bandwidth data
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Thu, 21 Dec 2023 15:04:04 -0700
Message-ID: <170319624458.2212653.13252496567443656371.stgit@djiang5-mobl3>
In-Reply-To: <170319606771.2212653.5435838660860735129.stgit@djiang5-mobl3>
References: <170319606771.2212653.5435838660860735129.stgit@djiang5-mobl3>
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
 drivers/cxl/core/cdat.c |   59 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index b3ab47d250e1..43dfef80fb84 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -12,6 +12,9 @@ struct dsmas_entry {
 	struct range dpa_range;
 	u8 handle;
 	struct access_coordinate coord;
+
+	int entries;
+	int qos_class;
 };
 
 static int cdat_dsmas_handler(union acpi_subtable_headers *header, void *arg,
@@ -154,6 +157,55 @@ static int cxl_cdat_endpoint_process(struct cxl_port *port,
 	return cdat_table_parse_output(rc);
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
+	if (!cxl_root->ops || !cxl_root->ops->qos_class)
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
+		rc = cxl_root->ops->qos_class(root_port, &dent->coord, 1, &qos_class);
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
 static void discard_dsmas(struct xarray *xa)
 {
 	unsigned long index;
@@ -183,7 +235,12 @@ void cxl_endpoint_parse_cdat(struct cxl_port *port)
 		return;
 	}
 
-	/* Performance data processing */
+	rc = cxl_port_perf_data_calculate(port, dsmas_xa);
+	if (rc) {
+		dev_dbg(&port->dev, "Failed to do perf coord calculations.\n");
+		return;
+	}
+
 }
 EXPORT_SYMBOL_NS_GPL(cxl_endpoint_parse_cdat, CXL);
 


