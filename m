Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EAD57302
	for <linux-cxl@vger.kernel.org>; Mon,  1 Apr 2024 23:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712014491; cv=none; b=JpsAGgLaOYngO36fXXtq8qZwhGR4XyBPDUUnlU+1TPPI/kiFsEiRIPdUhVr+NCY3h47fFVhOlQ4vDTsGplF9zvbvu51QHFvD+1zVtjwyVmfL70ivZgHPkOvf0OTM/sEa7t3r8bs2qFo8dEHqgZOOzeVBA6u4EGSqk/eiTryXTXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712014491; c=relaxed/simple;
	bh=V5zYMM+qqFkbecc5j/iYrJK4Hd3o49Oq0F9Zo+6g5Q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ww5QrMofsi2eAyogvqPk4t2mW+BzuppkP06C+XXJDJ3XV8jg0ir0dX6wd+OtQbteQIZYpBYqeol4xSTCEV6+F7TXbqSY2ceYs06WqnKjv6kPjVkhHE3qIbAGh2lnVuxjHQ4sz0hFGisLUnt95Hypnez0L5Z/WMBG/pedWJXXGBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3DC0C43390;
	Mon,  1 Apr 2024 23:34:50 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net
Subject: [PATCH v6 3/4] cxl: Fix incorrect region perf data calculation
Date: Mon,  1 Apr 2024 16:33:01 -0700
Message-ID: <20240401233445.3057332-4-dave.jiang@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401233445.3057332-1-dave.jiang@intel.com>
References: <20240401233445.3057332-1-dave.jiang@intel.com>
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

Normalize values from CDAT to nanoseconds. Adjust sub-nanoseconds latency
to at least 1. Remove adjustment of perf numbers from the generic target
since hmat handling code has already normalized those numbers. Now all
computation and stored numbers should be in nanoseconds.

Fixes: 3d9f4a197230 ("cxl/region: Calculate performance data for a region")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v6:
- Normalize values from CDAT to nanoseconds. (Dan)
---
 drivers/cxl/acpi.c      | 13 +---------
 drivers/cxl/core/cdat.c | 54 ++++++++++++++++++++++++++---------------
 2 files changed, 36 insertions(+), 31 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 0cfd141c0bed..cb8c155a2c9b 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -525,22 +525,11 @@ static int get_genport_coordinates(struct device *dev, struct cxl_dport *dport)
 {
 	struct acpi_device *hb = to_cxl_host_bridge(NULL, dev);
 	u32 uid;
-	int rc;
 
 	if (kstrtou32(acpi_device_uid(hb), 0, &uid))
 		return -EINVAL;
 
-	rc = acpi_get_genport_coordinates(uid, dport->coord);
-	if (rc < 0)
-		return rc;
-
-	/* Adjust back to picoseconds from nanoseconds */
-	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
-		dport->coord[i].read_latency *= 1000;
-		dport->coord[i].write_latency *= 1000;
-	}
-
-	return 0;
+	return acpi_get_genport_coordinates(uid, dport->coord);
 }
 
 static int add_host_bridge_dport(struct device *match, void *arg)
diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index 5b75d2d56099..85fd1bfbe038 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -20,6 +20,37 @@ struct dsmas_entry {
 	int qos_class;
 };
 
+static u32 cdat_normalize(u16 entry, u64 base, u8 type)
+{
+	u32 value;
+
+	/*
+	 * Check for invalid and overflow values
+	 */
+	if (entry == 0xffff || !entry)
+		return 0;
+	else if (base > (UINT_MAX / (entry)))
+		return 0;
+
+	value = entry * base;
+	switch (type) {
+	case ACPI_HMAT_ACCESS_LATENCY:
+	case ACPI_HMAT_READ_LATENCY:
+	case ACPI_HMAT_WRITE_LATENCY:
+		value = DIV_ROUND_UP(value, 1000);
+		/*
+		 * With latency being converted from picoseconds to nanoseconds,
+		 * ensure that latency is at least 1 for sub-nanosecond latency
+		 * values.
+		 */
+		value = min_not_zero((u32)1, value);
+		break;
+	default:
+		break;
+	}
+	return value;
+}
+
 static int cdat_dsmas_handler(union acpi_subtable_headers *header, void *arg,
 			      const unsigned long end)
 {
@@ -104,7 +135,6 @@ static int cdat_dslbis_handler(union acpi_subtable_headers *header, void *arg,
 	__le16 le_val;
 	u64 val;
 	u16 len;
-	int rc;
 
 	len = le16_to_cpu((__force __le16)hdr->length);
 	if (len != size || (unsigned long)hdr + len > end) {
@@ -131,10 +161,8 @@ static int cdat_dslbis_handler(union acpi_subtable_headers *header, void *arg,
 
 	le_base = (__force __le64)dslbis->entry_base_unit;
 	le_val = (__force __le16)dslbis->entry[0];
-	rc = check_mul_overflow(le64_to_cpu(le_base),
-				le16_to_cpu(le_val), &val);
-	if (rc)
-		pr_warn("DSLBIS value overflowed.\n");
+	val = cdat_normalize(le16_to_cpu(le_val), le64_to_cpu(le_base),
+			     dslbis->data_type);
 
 	cxl_access_coordinate_set(dent->coord, dslbis->data_type, val);
 
@@ -456,10 +484,8 @@ static int cdat_sslbis_handler(union acpi_subtable_headers *header, void *arg,
 
 		le_base = (__force __le64)tbl->sslbis_header.entry_base_unit;
 		le_val = (__force __le16)tbl->entries[i].latency_or_bandwidth;
-
-		if (check_mul_overflow(le64_to_cpu(le_base),
-				       le16_to_cpu(le_val), &val))
-			dev_warn(dev, "SSLBIS value overflowed!\n");
+		val = cdat_normalize(le16_to_cpu(le_val), le64_to_cpu(le_base),
+				     sslbis->data_type);
 
 		xa_for_each(&port->dports, index, dport) {
 			if (dsp_id == ACPI_CDAT_SSLBIS_ANY_PORT ||
@@ -559,16 +585,6 @@ void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
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

