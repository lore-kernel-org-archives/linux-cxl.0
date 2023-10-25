Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2468328B4
	for <linux-cxl@vger.kernel.org>; Wed, 25 Oct 2023 20:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mlPV43xu"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3EC93
	for <linux-cxl@vger.kernel.org>; Wed, 25 Oct 2023 13:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698264152; x=1729800152;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mstY9Glp73MGR6N9+LQc/gmMhqlxUDyMxwFQt9dhnfE=;
  b=mlPV43xulSAIPjWXhkEPCg1OwfMbG4b4h5XClGjZXmsAPM6HG7+saou2
   rDoIBjy4/Fd1argEsU17rPAJKK0c5Rfo3I4lM+1wnQagMNcCL0XptpB9W
   FPDsMSWcm85AFHGX8If93MuNcsZRoz3MPSv42gj1DQ9CyIs71HW6nuRrs
   HEjZUyELFEF3oiX+rMDg2ZXZ5Z3uZtI4bEwuxwlt6EUC1AK6mx0snO4Iq
   c+EGcYoeWe/D0ib+o6EFsJMMn1aVJc4uSYy0Mg5l0fC616DM4WUc6i08d
   YqE7HliTBL2ab4V8PeECx4C4Ze5twBX5DgYW6VVz1MqhqcSIgq/KpcV6T
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="473624433"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="473624433"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 13:01:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="902664750"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="902664750"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.181.198])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 12:59:15 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v4 2/3] cxl/region: Calculate a target position in a region interleave
Date: Wed, 25 Oct 2023 13:01:33 -0700
Message-Id: <0ac32c75cf81dd8b86bf07d70ff139d33c2300bc.1698263080.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1698263080.git.alison.schofield@intel.com>
References: <cover.1698263080.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

Introduce a calculation to find a target's position in a region
interleave. Perform a self-test of the calculation on user-defined
regions.

The region driver uses the kernel sort() function to put region
targets in relative order. Positions are assigned based on each
target's index in that sorted list. That relative sort doesn't
consider the offset of a port into its parent port which causes
some auto-discovered regions to fail creation. In one failure case,
a 2 + 2 config (2 host bridges each with 2 endpoints), the sort
puts all the targets of one port ahead of another port when they
were expected to be interleaved.

In preparation for repairing the autodiscovery region assembly,
introduce a new method for discovering a target position in the
region interleave.

cxl_calc_interleave_pos() adds a method to find the target position by
ascending from an endpoint to a root decoder. The calculation starts
with the endpoint's local position and position in the parent port. It
traverses towards the root decoder and examines both position and ways
in order to allow the position to be refined all the way to the root
decoder.

This calculation: position = position * parent_ways + parent_pos;
applied iteratively yields the correct position.

Include a self-test that exercises this new position calculation against
every successfully configured user-defined region.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 122 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index eea8e89a6860..481aab3234bf 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1501,6 +1501,108 @@ static int match_switch_decoder_by_range(struct device *dev, void *data)
 	return (r1->start == r2->start && r1->end == r2->end);
 }
 
+static int find_pos_and_ways(struct cxl_port *port, struct range *range,
+			     int *pos, int *ways)
+{
+	struct cxl_switch_decoder *cxlsd;
+	struct cxl_port *parent;
+	struct device *dev;
+	int rc = -ENXIO;
+
+	parent = next_port(port);
+	if (!parent)
+		return rc;
+
+	dev = device_find_child(&parent->dev, range,
+				match_switch_decoder_by_range);
+	if (!dev) {
+		dev_err(port->uport_dev,
+			"failed to find decoder mapping %#llx-%#llx\n",
+			range->start, range->end);
+		return rc;
+	}
+	cxlsd = to_cxl_switch_decoder(dev);
+	*ways = cxlsd->cxld.interleave_ways;
+
+	for (int i = 0; i < *ways; i++) {
+		if (cxlsd->target[i] == port->parent_dport) {
+			*pos = i;
+			rc = 0;
+			break;
+		}
+	}
+	put_device(dev);
+
+	return rc;
+}
+
+/**
+ * cxl_calc_interleave_pos() - calculate an endpoint position in a region
+ * @cxled: the endpoint decoder
+ *
+ * The endpoint position is calculated by traversing from the endpoint to
+ * the root decoder and iteratively applying this calculation:
+ *	position = position * parent_ways + parent_pos;
+ *
+ * For example, the expected interleave order of the 4-way region shown
+ * below is: mem0, mem2, mem1, mem3
+ *
+ *		  root_port
+ *                 /      \
+ *      host_bridge_0    host_bridge_1
+ *        |    |           |    |
+ *       mem0 mem1        mem2 mem3
+ *
+ * In the example the calculator will iterate twice. The first iteration
+ * uses the mem position in the host-bridge and the ways of the host-
+ * bridge to generate the first, or local, position. The second iteration
+ * uses the host-bridge position in the root_port and the ways of the
+ * root_port to refine the position.
+ *
+ * A trace of the calculation per endpoint looks like this:
+ * mem0:	pos = 0 * 2 + 0		mem2:	pos = 0 * 2 + 0
+ *		pos = 0 * 2 + 0			pos = 0 * 2 + 1
+ *		pos: 0				pos: 1
+ *
+ * mem1:	pos = 0 * 2 + 1		mem3:	pos = 0 * 2 + 1
+ *		pos = 1 * 2 + 0			pos = 1 * 2 + 1
+ *		pos: 2				pos = 3
+ *
+ * Note that while this example is simple, the method applies to more
+ * complex topologies, including those with switches.
+ *
+ * Return: position >= 0 on success
+ *	   -ENXIO on failure
+ */
+
+static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_port *iter, *port = cxled_to_port(cxled);
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct range *range = &cxled->cxld.hpa_range;
+	int parent_ways = 0, parent_pos = 0, pos = 0;
+	int rc;
+
+	/* Iterate from endpoint to root_port refining the position */
+	for (iter = port; iter; iter = next_port(iter)) {
+		if (is_cxl_root(iter))
+			break;
+
+		rc = find_pos_and_ways(iter, range, &parent_pos, &parent_ways);
+		if (rc)
+			return rc;
+
+		pos = pos * parent_ways + parent_pos;
+	}
+
+	dev_dbg(&cxlmd->dev,
+		"decoder:%s parent:%s port:%s range:%#llx-%#llx pos:%d\n",
+		dev_name(&cxled->cxld.dev), dev_name(cxlmd->dev.parent),
+		dev_name(&port->dev), range->start, range->end, pos);
+
+	return pos;
+}
+
 static void find_positions(const struct cxl_switch_decoder *cxlsd,
 			   const struct cxl_port *iter_a,
 			   const struct cxl_port *iter_b, int *a_pos,
@@ -1764,6 +1866,26 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		.end = p->res->end,
 	};
 
+	if (p->nr_targets != p->interleave_ways)
+		return 0;
+
+	/*
+	 * Test the auto-discovery position calculator function
+	 * against this successfully created user-defined region.
+	 * A fail message here means that this interleave config
+	 * will fail when presented as CXL_REGION_F_AUTO.
+	 */
+	for (int i = 0; i < p->nr_targets; i++) {
+		struct cxl_endpoint_decoder *cxled = p->targets[i];
+		int test_pos;
+
+		test_pos = cxl_calc_interleave_pos(cxled);
+		dev_dbg(&cxled->cxld.dev,
+			"Test cxl_calc_interleave_pos(): %s test_pos:%d cxled->pos:%d\n",
+			(test_pos == cxled->pos) ? "success" : "fail",
+			test_pos, cxled->pos);
+	}
+
 	return 0;
 
 err_decrement:
-- 
2.37.3

