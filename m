Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373E215E8B
	for <linux-cxl@vger.kernel.org>; Wed,  7 May 2025 00:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746578596; cv=none; b=NTIKMJ/EFt4k0b//sFTFFbcfiEnEVDd+Q+R1Rg2qAKZZDWsOG+mbtIE68LyJyhgRERo46aqSn3rs1cuY35e8rPdqi19iiOGvUrTs7rfTqOKfADq40SDBk4yvWh9/o4LioyDjzV5/5Wl+54moxHCKtxkLAupNsRLk+0y0E+Lu0dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746578596; c=relaxed/simple;
	bh=bCw2YCf51awiG5TGn5ZB58hyLK394iqxaAPDtFDiw1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TBLy73S0I75ii8kZGaFkVIApZcazVYXfNh+9Pb1e7Z4xFy7pkl7//iMbnGIrvlYk+yGK2XqJoR7rTWA1b/d0gJ+YbZ5d3SIS4ezkt+9iyaMn2QY+VtPQWR6VDoB7zo44PSwfuQ4Iok5lQwr/UdOBN6myT1ZJA/jXRVmaJx7xXbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F06C4CEEE;
	Wed,  7 May 2025 00:43:15 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com,
	rrichter@amd.com,
	ming.li@zohomail.com
Subject: [PATCH v2 03/10] cxl: Rename find_dport() to provide better function intent
Date: Tue,  6 May 2025 17:43:03 -0700
Message-ID: <20250507004310.3536991-4-dave.jiang@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507004310.3536991-1-dave.jiang@intel.com>
References: <20250507004310.3536991-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename find_dport() to find_dport_by_num() to indicate that the function
is trying to match a dport by its hardware number index.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/port.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index e9c02e4d0d4c..1d7a4a2ef6ad 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1045,7 +1045,7 @@ void put_cxl_root(struct cxl_root *cxl_root)
 }
 EXPORT_SYMBOL_NS_GPL(put_cxl_root, "CXL");
 
-static struct cxl_dport *find_dport(struct cxl_port *port, int port_num)
+static struct cxl_dport *find_dport_by_num(struct cxl_port *port, int port_num)
 {
 	struct cxl_dport *dport;
 	unsigned long index;
@@ -1063,7 +1063,7 @@ static int add_dport(struct cxl_port *port, struct cxl_dport *dport)
 	int rc;
 
 	device_lock_assert(&port->dev);
-	dup = find_dport(port, dport->port_num);
+	dup = find_dport_by_num(port, dport->port_num);
 	if (dup) {
 		dev_err(&port->dev,
 			"unable to add dport%d-%s non-unique port num (%s)\n",
@@ -1275,13 +1275,13 @@ EXPORT_SYMBOL_NS_GPL(devm_cxl_add_dport, "CXL");
  * devm_cxl_add_rch_dport - append RCH downstream port data to a cxl_port
  * @port: the cxl_port that references this dport
  * @dport_dev: firmware or PCI device representing the dport
- * @port_id: identifier for this dport in a decoder's target list
+ * @port_num: identifier for this dport in a decoder's target list
  * @rcrb: mandatory location of a Root Complex Register Block
  *
  * See CXL 3.0 9.11.8 CXL Devices Attached to an RCH
  */
 struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
-					 struct device *dport_dev, int port_id,
+					 struct device *dport_dev, int port_num,
 					 resource_size_t rcrb)
 {
 	struct cxl_dport *dport;
@@ -1291,7 +1291,7 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
 		return ERR_PTR(-EINVAL);
 	}
 
-	dport = __devm_cxl_add_dport(port, dport_dev, port_id,
+	dport = __devm_cxl_add_dport(port, dport_dev, port_num,
 				     CXL_RESOURCE_NONE, rcrb);
 	if (IS_ERR(dport)) {
 		dev_dbg(dport_dev, "failed to add RCH dport to %s: %ld\n",
@@ -1764,7 +1764,7 @@ static int decoder_populate_targets(struct cxl_switch_decoder *cxlsd,
 
 	guard(rwsem_write)(&cxl_region_rwsem);
 	for (i = 0; i < cxlsd->cxld.interleave_ways; i++) {
-		struct cxl_dport *dport = find_dport(port, target_map[i]);
+		struct cxl_dport *dport = find_dport_by_num(port, target_map[i]);
 
 		if (!dport)
 			return -ENXIO;
-- 
2.49.0

