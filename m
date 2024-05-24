Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72196E615
	for <linux-cxl@vger.kernel.org>; Fri, 24 May 2024 09:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716542941; cv=none; b=Yc4+5yuC5At6pZwvyvigf2FrLVnPVQMvaAOxYsVCtWdFj/XEdafT2fg5wOZ5Ej00Je9S1V+ICABPn3RyLEfmp049FV5rEdmWklhoGMqI4St1H1xvNL9pVV2E0RJ6M85/DJZEiZuEiB/LvPNeyxPhuDaEvwYnWWbSWqnjoqH6blU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716542941; c=relaxed/simple;
	bh=nm4DxHs6LONunrDKnOxBqOEaLvUU1LbDnltYEk/btUk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uNNpUbzZwM8drSbrnqG3ngsI336CFDUptBcDXCp24OqYK4TO+ekK8sfx8VXvRr39kSSqCIP1hVNnphfKLYv+t8I7Kviiqr1awYKGt9umFIHKdm9ntGltnlVRElkkZNFsAqrbvqyzuli7zNWplXKrZY6mpUP7WnO8zoEI4RGwTD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=o8MgsZbW; arc=none smtp.client-ip=139.138.36.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="o8MgsZbW"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1716542938; x=1748078938;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nm4DxHs6LONunrDKnOxBqOEaLvUU1LbDnltYEk/btUk=;
  b=o8MgsZbWnsx8X3r20tEpjNAy4tXvITReVPzS3GFIJqZkPUiDMcQbiaK+
   Ve2+1a9FXHZaJa9CYGfKPXXiXookdNO7ocoNcCYtnyBH/ZymIYMCeQWdg
   zaS/wRYc2y/Cj/0Q7S4xTPS+fXA/i3C4mPqbf2RjkCTJl5avHEIHNwd5C
   lPtPlXjRG6M279a0VWKfL3O+mqp7xKXS8ssZ/+MKxA9eldcJ1IeR+MN0X
   oyoRcyAWVUV+6eAYETtOmwqLYIRdczzx+GB22ipiokxV67WaIyRrAbH2s
   hWOEbejlJsiTAYmy51XzXBwsqXtZGcCw2jsT9nx4yxoiQ5uVfNZPG0m1a
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="148087470"
X-IronPort-AV: E=Sophos;i="6.08,185,1712588400"; 
   d="scan'208";a="148087470"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2024 18:27:47 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id ECC3DE8526
	for <linux-cxl@vger.kernel.org>; Fri, 24 May 2024 18:27:45 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 320F3D973B
	for <linux-cxl@vger.kernel.org>; Fri, 24 May 2024 18:27:45 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id ABF3829B2B0
	for <linux-cxl@vger.kernel.org>; Fri, 24 May 2024 18:27:44 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.225.88])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id B06361A000A;
	Fri, 24 May 2024 17:27:43 +0800 (CST)
From: Yao Xingtao <yaoxt.fnst@fujitsu.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	jim.harris@samsung.com
Cc: linux-cxl@vger.kernel.org,
	Yao Xingtao <yaoxt.fnst@fujitsu.com>
Subject: [PATCH v5] cxl/region: check interleave capability
Date: Fri, 24 May 2024 05:27:40 -0400
Message-Id: <20240524092740.4260-1-yaoxt.fnst@fujitsu.com>
X-Mailer: git-send-email 2.37.3
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28406.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28406.006
X-TMASE-Result: 10--7.918000-10.000000
X-TMASE-MatchedRID: p0IjHbiBDzaCKQp76hMfYYvefyp1glN04SkIdSwphgZNEl8XeFvcyOaL
	XqTzHpREkPI1/ZdqoS2kfiUvzNMZPM9LhMkLoGtYWTWEh5N2a9EbbhhV65kaY6ZR9gDesrZO6Ch
	K9oqyX+Qi+t+0AiFaYvL3NxFKQpq10UwGeYlGH8lKzjuZtPtIBDbXuwFqSl0ryPRAwD/3abYfJ5
	PxUiI1vnP+9mhbDjvtDqKK6FJU8p03+mZCDwntcqBw6BKdk7MxUTBIPA569SGOEENgsUAuYpKyP
	f1j7t43HT9iIIGMqIa4Yr4jUnU84o23IKRZfddangIgpj8eDcAZ1CdBJOsoY8RB0bsfrpPIfiAq
	rjYtFiTBhn6JxL3bGK45DRvzt+k4Fy1sB9u+DnNB8o6IW5YjpX7cGd19dSFd
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Since interleave capability is not verified, if the interleave
capability of a target does not match the region need, committing decoder
should have failed at the device end.

In order to checkout this error as quickly as possible, driver needs
to check the interleave capability of target during attaching it to
region.

According to the CXL specification (section 8.2.4.20 CXL HDM Decoder
Capability Structure), bits 11 and 12 within the 'CXL HDM Decoder
Capability Register' indicate the capability to establish interleaving
in 3, 6, 12, and 16 ways. If these bits are not set, the target cannot
be attached to a region utilizing such interleave ways.

Additionally, bits 8 and 9 in the same register represent the capability
of the bits used for interleaving in the address, Linux tracks this in the
cxl_port interleave_mask.

Regarding 'Decoder Protection':
If IW is less than 8 (for interleave ways of 1, 2, 4, 8, 16), the
interleave bits start at bit position IG + 8 and end at IG + IW + 8 - 1.

If the IW is greater than or equal to 8 (for interleave ways of 3, 6, 12),
the interleave bits start at bit position IG + 8 and end at IG + IW - 1.

If the interleave mask is insufficient to cover the required interleave
bits, the target cannot be attached to the region.

Fixes: 384e624bb211 ("cxl/region: Attach endpoint decoders")
Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
---
 drivers/cxl/core/hdm.c    | 10 +++++
 drivers/cxl/core/region.c | 83 +++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h         |  2 +
 drivers/cxl/cxlmem.h      |  1 +
 4 files changed, 96 insertions(+)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 7d97790b893d..5b7dff19bbfa 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -52,6 +52,11 @@ int devm_cxl_add_passthrough_decoder(struct cxl_port *port)
 	struct cxl_dport *dport = NULL;
 	int single_port_map[1];
 	unsigned long index;
+	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
+
+	/* allow all the interleave capabilities for passthrough decoder */
+	cxlhdm->interleave_mask = GENMASK(14, 8);
+	cxlhdm->iw_cap_mask = BIT(1) | BIT(2) | BIT(4) | BIT(8);
 
 	cxlsd = cxl_switch_decoder_alloc(port, 1);
 	if (IS_ERR(cxlsd))
@@ -79,6 +84,11 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
 		cxlhdm->interleave_mask |= GENMASK(11, 8);
 	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_14_12, hdm_cap))
 		cxlhdm->interleave_mask |= GENMASK(14, 12);
+	cxlhdm->iw_cap_mask = BIT(1) | BIT(2) | BIT(4) | BIT(8);
+	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY, hdm_cap))
+		cxlhdm->iw_cap_mask |= BIT(3) | BIT(6) | BIT(12);
+	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_16_WAY, hdm_cap))
+		cxlhdm->iw_cap_mask |= BIT(16);
 }
 
 static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 5c186e0a39b9..6b7400313cb2 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1054,6 +1054,7 @@ static int cxl_port_attach_region(struct cxl_port *port,
 	struct cxl_decoder *cxld;
 	unsigned long index;
 	int rc = -EBUSY;
+	struct cxl_switch_decoder *cxlsd;
 
 	lockdep_assert_held_write(&cxl_region_rwsem);
 
@@ -1101,6 +1102,23 @@ static int cxl_port_attach_region(struct cxl_port *port,
 	}
 	cxld = cxl_rr->decoder;
 
+	/*
+	 * the number of targets should not exceed the target_count
+	 * of the decoder
+	 */
+	if (is_switch_decoder(&cxld->dev)) {
+		cxlsd = to_cxl_switch_decoder(&cxld->dev);
+		if (cxl_rr->nr_targets > cxlsd->nr_targets) {
+			dev_dbg(&cxlr->dev,
+				"%s:%s %s add: %s:%s @ %d overflows targets: %d\n",
+				dev_name(port->uport_dev), dev_name(&port->dev),
+				dev_name(&cxld->dev), dev_name(&cxlmd->dev),
+				dev_name(&cxled->cxld.dev), pos,
+				cxlsd->nr_targets);
+			goto out_erase;
+		}
+	}
+
 	rc = cxl_rr_ep_add(cxl_rr, cxled);
 	if (rc) {
 		dev_dbg(&cxlr->dev,
@@ -1210,6 +1228,53 @@ static int check_last_peer(struct cxl_endpoint_decoder *cxled,
 	return 0;
 }
 
+static int check_interleave_cap(struct cxl_decoder *cxld, int iw, int ig)
+{
+	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
+	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
+	unsigned int interleave_mask;
+	u8 eiw;
+	u16 eig;
+	int rc, high_pos, low_pos;
+
+	rc = ways_to_eiw(iw, &eiw);
+	if (rc)
+		return rc;
+
+	if (!test_bit(iw, &cxlhdm->iw_cap_mask))
+		return -ENXIO;
+
+	rc = granularity_to_eig(ig, &eig);
+	if (rc)
+		return rc;
+
+	/*
+	 * Per CXL specification (8.2.3.20.13 Decoder Protection in r3.1)
+	 * if eiw < 8, the interleave bits start at bit position eig + 8, and
+	 * end at eig + eiw + 8 - 1.
+	 * if eiw >= 8, the interleave bits start at bit position eig + 8, and
+	 * end at eig + eiw - 1.
+	 */
+	if (eiw >= 8)
+		high_pos = eiw + eig - 1;
+	else
+		high_pos = eiw + eig + 7;
+	low_pos = eig + 8;
+	/*
+	 * when the eiw is 0 or 8 (interlave way is 1 or 3), the num of
+	 * interleave bits is 0, there is no interleaving, the following
+	 * check is ignored.
+	 */
+	if (low_pos > high_pos)
+		return 0;
+
+	interleave_mask = GENMASK(high_pos, low_pos);
+	if (interleave_mask & ~cxlhdm->interleave_mask)
+		return -ENXIO;
+
+	return 0;
+}
+
 static int cxl_port_setup_targets(struct cxl_port *port,
 				  struct cxl_region *cxlr,
 				  struct cxl_endpoint_decoder *cxled)
@@ -1360,6 +1425,15 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 			return -ENXIO;
 		}
 	} else {
+		rc = check_interleave_cap(cxld, iw, ig);
+		if (rc) {
+			dev_dbg(&cxlr->dev,
+				"%s:%s iw: %d ig: %d is not supported\n",
+				dev_name(port->uport_dev),
+				dev_name(&port->dev), iw, ig);
+			return rc;
+		}
+
 		cxld->interleave_ways = iw;
 		cxld->interleave_granularity = ig;
 		cxld->hpa_range = (struct range) {
@@ -1796,6 +1870,15 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 	struct cxl_dport *dport;
 	int rc = -ENXIO;
 
+	rc = check_interleave_cap(&cxled->cxld, p->interleave_ways,
+				  p->interleave_granularity);
+	if (rc) {
+		dev_dbg(&cxlr->dev, "%s iw: %d ig: %d is not supported\n",
+			dev_name(&cxled->cxld.dev), p->interleave_ways,
+			p->interleave_granularity);
+		return rc;
+	}
+
 	if (cxled->mode != cxlr->mode) {
 		dev_dbg(&cxlr->dev, "%s region mode: %d mismatch: %d\n",
 			dev_name(&cxled->cxld.dev), cxlr->mode, cxled->mode);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 036d17db68e0..dc8e46a1fe82 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -45,6 +45,8 @@
 #define   CXL_HDM_DECODER_TARGET_COUNT_MASK GENMASK(7, 4)
 #define   CXL_HDM_DECODER_INTERLEAVE_11_8 BIT(8)
 #define   CXL_HDM_DECODER_INTERLEAVE_14_12 BIT(9)
+#define   CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY BIT(11)
+#define   CXL_HDM_DECODER_INTERLEAVE_16_WAY BIT(12)
 #define CXL_HDM_DECODER_CTRL_OFFSET 0x4
 #define   CXL_HDM_DECODER_ENABLE BIT(1)
 #define CXL_HDM_DECODER0_BASE_LOW_OFFSET(i) (0x20 * (i) + 0x10)
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 36cee9c30ceb..6b8cf20ff375 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -853,6 +853,7 @@ struct cxl_hdm {
 	unsigned int decoder_count;
 	unsigned int target_count;
 	unsigned int interleave_mask;
+	unsigned long iw_cap_mask;
 	struct cxl_port *port;
 };
 
-- 
2.37.3

