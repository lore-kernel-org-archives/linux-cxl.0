Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cGsFEcs/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C221712
	for <linux-cxl@vger.kernel.org>; Thu,  7 Dec 2023 15:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701991911; x=1733527911;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aO6P6WHCwy1u4K6n+r79HEbwzAsax4lm61MF2Nz/9js=;
  b=cGsFEcs/fxx78BOlkLeNzTv00ncm9jTBnrqvsAdZFS1IYdB0mBHaQ1FK
   QJMji1S4MgGz3MiuR2A4BfORSkq+dvagVyd/hni3MWcrRTwQGO5gBRChC
   lT3wj43nhill3jmAxJ2Z4u3dqZtH+cTOcDTpy5hxUR8NysDaPzzHojyzj
   evNTN87hng3Xy7nPFfrzydoTWIz7ZxoC+oaWJY/7KvhMPd1P2938WgTBt
   vURZalW2WGYJbCrrckEWE/eKupikeAK4RNg+KXxQaJ4NBaIdxgTO6YOCb
   iE7m6kujbMeSjvOcZ3ckeg6GdTULVKry7xs4RAMpZ8j2M6dUZKGc+7Xes
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="1431991"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="1431991"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 15:31:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="895326283"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="895326283"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.213.168.225])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 15:31:50 -0800
Subject: [PATCH 1/3] cxl/region: Calculate performance data for a region
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, jonathan.cameron@huawei.com, dave@stgolabs.net
Date: Thu, 07 Dec 2023 16:31:49 -0700
Message-ID: <170199190986.3543815.7111880145751330916.stgit@djiang5-mobl3>
In-Reply-To: <170199184936.3543815.17537965163543815359.stgit@djiang5-mobl3>
References: <170199184936.3543815.17537965163543815359.stgit@djiang5-mobl3>
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

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/region.c |   94 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h         |    1 
 2 files changed, 95 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 56e575c79bb4..d879f5702cf2 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2934,6 +2934,98 @@ static int is_system_ram(struct resource *res, void *arg)
 	return 1;
 }
 
+static int cxl_region_perf_data_calculate(struct cxl_region *cxlr)
+{
+	struct cxl_region_params *p = &cxlr->params;
+	struct cxl_endpoint_decoder *cxled;
+	unsigned int rd_bw = 0, rd_lat = 0;
+	unsigned int wr_bw = 0, wr_lat = 0;
+	struct access_coordinate *coord;
+	struct list_head *perf_list;
+	int rc = 0, i;
+
+	lockdep_assert_held(&cxl_region_rwsem);
+
+	/* No need to proceed if hmem attributes are already present */
+	if (cxlr->coord)
+		return 0;
+
+	coord = devm_kzalloc(&cxlr->dev, sizeof(*coord), GFP_KERNEL);
+	if (!coord)
+		return -ENOMEM;
+
+	cxled = p->targets[0];
+
+	for (i = 0; i < p->nr_targets; i++) {
+		struct range dpa = {
+			.start = cxled->dpa_res->start,
+			.end = cxled->dpa_res->end,
+		};
+		struct cxl_memdev_state *mds;
+		struct perf_prop_entry *perf;
+		struct cxl_dev_state *cxlds;
+		struct cxl_memdev *cxlmd;
+		bool found = false;
+
+		cxled = p->targets[i];
+		cxlmd = cxled_to_memdev(cxled);
+		cxlds = cxlmd->cxlds;
+		mds = to_cxl_memdev_state(cxlds);
+
+		switch (cxlr->mode) {
+		case CXL_DECODER_RAM:
+			perf_list = &mds->ram_perf_list;
+			break;
+		case CXL_DECODER_PMEM:
+			perf_list = &mds->pmem_perf_list;
+			break;
+		default:
+			rc = -EINVAL;
+			goto err;
+		}
+
+		if (list_empty(perf_list)) {
+			rc = -ENOENT;
+			goto err;
+		}
+
+		list_for_each_entry(perf, perf_list, list) {
+			if (range_contains(&perf->dpa_range, &dpa)) {
+				found = true;
+				break;
+			}
+		}
+
+		if (!found) {
+			rc = -ENOENT;
+			goto err;
+		}
+
+		/* Get total bandwidth and the worst latency for the cxl region */
+		rd_lat = max_t(unsigned int, rd_lat,
+			       perf->coord.read_latency);
+		rd_bw += perf->coord.read_bandwidth;
+		wr_lat = max_t(unsigned int, wr_lat,
+			       perf->coord.write_latency);
+		wr_bw += perf->coord.write_bandwidth;
+	}
+
+	*coord = (struct access_coordinate) {
+		.read_latency = rd_lat,
+		.read_bandwidth = rd_bw,
+		.write_latency = wr_lat,
+		.write_bandwidth = wr_bw,
+	};
+
+	cxlr->coord = coord;
+
+	return 0;
+
+err:
+	devm_kfree(&cxlr->dev, coord);
+	return rc;
+}
+
 static int cxl_region_probe(struct device *dev)
 {
 	struct cxl_region *cxlr = to_cxl_region(dev);
@@ -2959,6 +3051,8 @@ static int cxl_region_probe(struct device *dev)
 		goto out;
 	}
 
+	cxl_region_perf_data_calculate(cxlr);
+
 	/*
 	 * From this point on any path that changes the region's state away from
 	 * CXL_CONFIG_COMMIT is also responsible for releasing the driver.
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 004534cf0361..265da412c5bd 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -529,6 +529,7 @@ struct cxl_region {
 	struct cxl_pmem_region *cxlr_pmem;
 	unsigned long flags;
 	struct cxl_region_params params;
+	struct access_coordinate *coord;
 };
 
 struct cxl_nvdimm_bridge {


