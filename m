Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5517D2D600
	for <linux-cxl@vger.kernel.org>; Thu,  4 Jan 2024 23:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C7PF2A5U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704412104; x=1735948104;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=url24CLh1PXmjzNkYYq8gFMkF74u6JeDBRKwjMyaZTg=;
  b=C7PF2A5UnCYTmSEvP6cOsa/Zo48/GUn3S+w2F5w5cQ7m1Juyw9b+KAkK
   0uyCFA3aJuWsuvwedae0J/BTEVfmPfu/9unchhY0duC8Hob0QJ2jDTv4P
   YWn0yv3aGOi7ESYPze9+unlL+F4y9x3bSHM/uWpmQou4gj3rdfo4P4xzn
   ms9heV6bh3i60EboMmKoZU/ScKXTKoUBMWoAtRQY/9RwMpl7JhsSPr8o8
   m8XvYV9ZqocVdxIcBr65GiPCGWRO8MqTykAvMFtPxPZjCTQ1JeGqfjDTl
   zjBa2Euw9ykztPlZcXFZaei7Hrf762ZGajSVnWZbNrU1E1F7HUABecmc3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="382369859"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="382369859"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 15:48:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="871087837"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="871087837"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.121.50])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 15:48:23 -0800
Subject: [PATCH v3 1/3] cxl/region: Calculate performance data for a region
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Thu, 04 Jan 2024 16:48:23 -0700
Message-ID: <170441210328.3574076.8557138214621981436.stgit@djiang5-mobl3>
In-Reply-To: <170441200977.3574076.13110207881243626581.stgit@djiang5-mobl3>
References: <170441200977.3574076.13110207881243626581.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Calculate and store the performance data for a CXL region. Find the worst
read and write latency for all the included ranges from each of the devices
that attributes to the region and designate that as the latency data. Sum
all the read and write bandwidth data for each of the device region and
that is the total bandwidth for the region.

The perf list is expected to be constructed before the endpoint decoders
are registered and thus there should be no early reading of the entries
from the region assemble action. The calling of the region qos calculate
function is under the protection of cxl_dpa_rwsem and will ensure that
all DPA associated work has completed.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v3:
- Clarify calculated data is same base as the coordinates computed from the
  HMAT tables. (Jonathan)
---
 drivers/cxl/core/cdat.c   |   53 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/region.c |    2 ++
 drivers/cxl/cxl.h         |    5 ++++
 3 files changed, 60 insertions(+)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index cd84d87f597a..78e1cdcb9d89 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -515,3 +515,56 @@ void cxl_switch_parse_cdat(struct cxl_port *port)
 EXPORT_SYMBOL_NS_GPL(cxl_switch_parse_cdat, CXL);
 
 MODULE_IMPORT_NS(CXL);
+
+void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
+				    struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
+	struct range dpa = {
+			.start = cxled->dpa_res->start,
+			.end = cxled->dpa_res->end,
+	};
+	struct list_head *perf_list;
+	struct cxl_dpa_perf *perf;
+	bool found = false;
+
+	switch (cxlr->mode) {
+	case CXL_DECODER_RAM:
+		perf_list = &mds->ram_perf_list;
+		break;
+	case CXL_DECODER_PMEM:
+		perf_list = &mds->pmem_perf_list;
+		break;
+	default:
+		return;
+	}
+
+	list_for_each_entry(perf, perf_list, list) {
+		if (range_contains(&perf->dpa_range, &dpa)) {
+			found = true;
+			break;
+		}
+	}
+
+	if (!found)
+		return;
+
+	/* Get total bandwidth and the worst latency for the cxl region */
+	cxlr->coord.read_latency = max_t(unsigned int,
+					 cxlr->coord.read_latency,
+					 perf->coord.read_latency);
+	cxlr->coord.write_latency = max_t(unsigned int,
+					  cxlr->coord.write_latency,
+					  perf->coord.write_latency);
+	cxlr->coord.read_bandwidth += perf->coord.read_bandwidth;
+	cxlr->coord.write_bandwidth += perf->coord.write_bandwidth;
+
+	/*
+	 * Convert latency to nanosec from picosec to be consistent with the
+	 * resulting latency coordinates computed by HMAT code.
+	 */
+	cxlr->coord.read_latency = DIV_ROUND_UP(cxlr->coord.read_latency, 1000);
+	cxlr->coord.write_latency = DIV_ROUND_UP(cxlr->coord.write_latency, 1000);
+}
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 57a5901d5a60..7f19b533c5ae 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1722,6 +1722,8 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		return -EINVAL;
 	}
 
+	cxl_region_perf_data_calculate(cxlr, cxled);
+
 	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
 		int i;
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 492dbf63935f..4639d0d6ef54 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -519,6 +519,7 @@ struct cxl_region_params {
  * @cxlr_pmem: (for pmem regions) cached copy of the nvdimm bridge
  * @flags: Region state flags
  * @params: active + config params for the region
+ * @coord: QoS access coordinates for the region
  */
 struct cxl_region {
 	struct device dev;
@@ -529,6 +530,7 @@ struct cxl_region {
 	struct cxl_pmem_region *cxlr_pmem;
 	unsigned long flags;
 	struct cxl_region_params params;
+	struct access_coordinate coord;
 };
 
 struct cxl_nvdimm_bridge {
@@ -879,6 +881,9 @@ void cxl_switch_parse_cdat(struct cxl_port *port);
 int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
 				      struct access_coordinate *coord);
 
+void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
+				    struct cxl_endpoint_decoder *cxled);
+
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version
  * of these symbols in tools/testing/cxl/.


