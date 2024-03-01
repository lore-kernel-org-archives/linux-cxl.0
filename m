Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E41C13F
	for <linux-cxl@vger.kernel.org>; Fri,  1 Mar 2024 00:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709254316; cv=none; b=ZlVp6HYr3RIXMRPmFRexyOLmiSe8mYohYD4yKdj+I7rNW7wWQlUkO05RtcSmtmNtsj5VVPhIY0v3ehkEGQi+G2kGcKb2bLAvAULsPjIMuQ6SYd/cKa+RSJKjmfN7ObrdcUXge9z4qtdYOL4pv1A6ryv4sdhkAaUwmzZUpphT0L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709254316; c=relaxed/simple;
	bh=H2nKZWLU/Zc37fbBrN/hp4oPe8PcyxocU2NBFXtc5jQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J7UjkW8jlZp1Ez4v9aOSHdKY0yXYvoBHrN4YgPstNBtbKaUdJq5QePWJ0n2rdP0EfmgAx16yanbSc1KN06n2EHa1o9z2hnheRiZkyTk2OERfIHSHQeK0gyPViEnN1V46tLn+o2zZsXA3mWZwAxyTHRJVIbay1ccsgleCQUx1q5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47E90C433F1;
	Fri,  1 Mar 2024 00:51:55 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net
Subject: [PATCH v2] cxl: Fix the incorrect assignment of SSLBIS entry pointer initial location
Date: Thu, 29 Feb 2024 17:51:53 -0700
Message-ID: <20240301005153.830228-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'entry' pointer in cdat_sslbis_handler() is set to header +
sizeof(common header). However, the math missed the addition of the SSLBIS
main header. It should be header + sizeof(common header) + sizeof(*sslbis).
Use a defined struct for all the SSLBIS parts in order to avoid pointer
math errors.

The bug causes incorrect parsing of the SSLBIS table and introduces incorrect
performance values to the access_coordinates during the CXL access_coordinate
calculation path if there are CXL switches present in the topology.

The issue was found during testing of new code being added to add additional
checks for invalid CDAT values during CXL access_coordinate calculation. The
testing was done on qemu with a CXL topology including a CXL switch.

Fixes: 80aa780dda20 ("cxl: Add callback to parse the SSLBIS subtable from CDAT")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v2:
- Add more details to commit log for the bug. (Dan)
- Use defined struct instead of pointer math. (Dan)
---
 drivers/cxl/core/cdat.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index 08fd0baea7a0..5250e489db5b 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -389,36 +389,38 @@ EXPORT_SYMBOL_NS_GPL(cxl_endpoint_parse_cdat, CXL);
 static int cdat_sslbis_handler(union acpi_subtable_headers *header, void *arg,
 			       const unsigned long end)
 {
-	struct acpi_cdat_sslbis *sslbis;
 	int size = sizeof(header->cdat) + sizeof(*sslbis);
+	struct acpi_cdat_sslbis_table {
+		struct acpi_cdat_header header;
+		struct acpi_cdat_sslbis sslbis_header;
+		struct acpi_cdat_sslbe entries[];
+	} *tbl = (struct acpi_cdat_sslbis_table *)header;
+	struct acpi_cdat_sslbis *sslbis;
 	struct cxl_port *port = arg;
 	struct device *dev = &port->dev;
-	struct acpi_cdat_sslbe *entry;
 	int remain, entries, i;
 	u16 len;
 
 	len = le16_to_cpu((__force __le16)header->cdat.length);
 	remain = len - size;
-	if (!remain || remain % sizeof(*entry) ||
+	if (!remain || remain % sizeof(struct acpi_cdat_sslbe) ||
 	    (unsigned long)header + len > end) {
 		dev_warn(dev, "Malformed SSLBIS table length: (%u)\n", len);
 		return -EINVAL;
 	}
 
-	/* Skip common header */
-	sslbis = (struct acpi_cdat_sslbis *)((unsigned long)header +
-					     sizeof(header->cdat));
-
+	sslbis = &tbl->sslbis_header;
 	/* Unrecognized data type, we can skip */
 	if (sslbis->data_type > ACPI_HMAT_WRITE_BANDWIDTH)
 		return 0;
 
-	entries = remain / sizeof(*entry);
-	entry = (struct acpi_cdat_sslbe *)((unsigned long)header + sizeof(*sslbis));
+	entries = remain / sizeof(struct acpi_cdat_sslbe);
+	if (struct_size(tbl, entries, entries) != len)
+		return -EINVAL;
 
 	for (i = 0; i < entries; i++) {
-		u16 x = le16_to_cpu((__force __le16)entry->portx_id);
-		u16 y = le16_to_cpu((__force __le16)entry->porty_id);
+		u16 x = le16_to_cpu((__force __le16)tbl->entries[i].portx_id);
+		u16 y = le16_to_cpu((__force __le16)tbl->entries[i].porty_id);
 		__le64 le_base;
 		__le16 le_val;
 		struct cxl_dport *dport;
@@ -448,8 +450,8 @@ static int cdat_sslbis_handler(union acpi_subtable_headers *header, void *arg,
 			break;
 		}
 
-		le_base = (__force __le64)sslbis->entry_base_unit;
-		le_val = (__force __le16)entry->latency_or_bandwidth;
+		le_base = (__force __le64)tbl->sslbis_header.entry_base_unit;
+		le_val = (__force __le16)tbl->entries[i].latency_or_bandwidth;
 
 		if (check_mul_overflow(le64_to_cpu(le_base),
 				       le16_to_cpu(le_val), &val))
@@ -462,8 +464,6 @@ static int cdat_sslbis_handler(union acpi_subtable_headers *header, void *arg,
 							  sslbis->data_type,
 							  val);
 		}
-
-		entry++;
 	}
 
 	return 0;
-- 
2.43.0

