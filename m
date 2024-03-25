Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AEB81AB0
	for <linux-cxl@vger.kernel.org>; Mon, 25 Mar 2024 23:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711407762; cv=none; b=GnVIRmXp4rUMbk7RR47sLQ0TuDijcTypJZbl6NIe5cBgvPTzALTuRlhusZFeWIoF0uE4FJxsQ1hC1xLOEJhdPHa2n2m+HoDgtLoyvvdtjttpYadMy9Yo53vBBe7sak052a0/5wGCGhST8jhm6x2VfXCMwjCoRzLDOf5WMSQl48U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711407762; c=relaxed/simple;
	bh=OTkJbE6uMPbLN11mx4/LLj1/4A7IYM21A40wUF6VVHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ST5tfMV5wdov+6s+sFfM/eq8HHNXko5tz+6QkR1eaNRq0jNeuHYHZnVn6wNCwJFyUavG0GLLBvzIIAZeld1MOeuRKJxzEz6DS7HkJ+AYWuizu7mVxPS4qoMRvTHpgw5XhjHp0CJAbYf5lWFMIlh9NeeJeC3IVlorXo6L7x+t02Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0635FC433F1;
	Mon, 25 Mar 2024 23:02:41 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net
Subject: [PATCH v5 3/4] cxl: Fix incorrect region perf data calculation
Date: Mon, 25 Mar 2024 16:00:50 -0700
Message-ID: <20240325230234.1847525-4-dave.jiang@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240325230234.1847525-1-dave.jiang@intel.com>
References: <20240325230234.1847525-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current math in cxl_region_perf_data_calculate divides the latency by 1000
every time the function gets called. This causes the region latency to be
divided by 1000 per memory device and the math is incorrect. This is user
visible as the latency access_coordinate exposed via sysfs will show
incorrect latency data.

Move the latency adjustment to where dpa_perf is set and this should
provide the appropriate latency for the region for each endpoint.

Fixes: 3d9f4a197230 ("cxl/region: Calculate performance data for a region")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/cdat.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index 5b75d2d56099..a1b204d451d3 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -214,8 +214,19 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
 static void update_perf_entry(struct device *dev, struct dsmas_entry *dent,
 			      struct cxl_dpa_perf *dpa_perf)
 {
-	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++)
+	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
 		dpa_perf->coord[i] = dent->coord[i];
+		/*
+		 * Convert latency to nanosec from picosec to be consistent
+		 * with the resulting latency coordinates computed by the
+		 * HMAT_REPORTING code.
+		 */
+		dpa_perf->coord[i].read_latency =
+			DIV_ROUND_UP(dpa_perf->coord[i].read_latency, 1000);
+		dpa_perf->coord[i].write_latency =
+			DIV_ROUND_UP(dpa_perf->coord[i].write_latency, 1000);
+	}
+
 	dpa_perf->dpa_range = dent->dpa_range;
 	dpa_perf->qos_class = dent->qos_class;
 	dev_dbg(dev,
@@ -559,16 +570,6 @@ void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
 						     perf->coord[i].write_latency);
 		cxlr->coord[i].read_bandwidth += perf->coord[i].read_bandwidth;
 		cxlr->coord[i].write_bandwidth += perf->coord[i].write_bandwidth;
-
-		/*
-		 * Convert latency to nanosec from picosec to be consistent
-		 * with the resulting latency coordinates computed by the
-		 * HMAT_REPORTING code.
-		 */
-		cxlr->coord[i].read_latency =
-			DIV_ROUND_UP(cxlr->coord[i].read_latency, 1000);
-		cxlr->coord[i].write_latency =
-			DIV_ROUND_UP(cxlr->coord[i].write_latency, 1000);
 	}
 }
 
-- 
2.44.0

