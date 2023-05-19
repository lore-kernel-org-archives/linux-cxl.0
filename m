Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F1BC7EE2E
	for <linux-cxl@archiver.kernel.org>; Fri, 19 May 2023 17:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjESRJb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 19 May 2023 13:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbjESRJO (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 19 May 2023 13:09:14 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F0410C3
        for <linux-cxl@vger.kernel.org>; Fri, 19 May 2023 10:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684516137; x=1716052137;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Rp2tUyYEe1sr89CvFY7nY5xayliz4gA00CfzX8Wu+NQ=;
  b=TS84vASLZYx2U4Tj/I/TVIkdVhWtFn7MgNxZSfXgWXVZrq8z0vIEj9eP
   n1dfdEoycqBpu6SLs8mhi3xXkpTXn6Eib1rDyTCEhu+2EjFheeTVfzgd4
   H3SvtqYoSW9wG2OomNNN42IF7pHtizq5i9i4tbq+V+7lNV1J+lP15c+LZ
   9bpV4gQ1Di1tBictWcefVMl5AyJci5kjipg6rcmaqGpyRB/3iHs/6EYOG
   MiIbg0+tOG5/CTod+9bncfW5bz6DOnoJDc4irP0lRvRbi4tKzwq25e/oA
   pDeswqp8IAsyH/PHRWbuqS8C5HvW3e6VFSKOXFbOdon+uoYP9fJiOLEvH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10715"; a="438778242"
X-IronPort-AV: E=Sophos;i="6.00,177,1681196400"; 
   d="scan'208";a="438778242"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2023 10:06:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10715"; a="876910831"
X-IronPort-AV: E=Sophos;i="6.00,177,1681196400"; 
   d="scan'208";a="876910831"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.29.189])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2023 10:06:52 -0700
Subject: [PATCH v6 03/11] cxl: Add callback to parse the SSLBIS subtable from
 CDAT
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com
Date:   Fri, 19 May 2023 10:06:52 -0700
Message-ID: <168451601243.3470703.9340908897464530349.stgit@djiang5-mobl3>
In-Reply-To: <168451588868.3470703.3527256859632103687.stgit@djiang5-mobl3>
References: <168451588868.3470703.3527256859632103687.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Provide a callback to parse the Switched Scoped Latency and Bandwidth
Information Structure (SSLBIS) in the CDAT structures. The SSLBIS
contains the bandwidth and latency information that's tied to the
CXL switch that the data table has been read from. The extracted
values are stored to the cxl_dport correlated by the port_id
depending on the SSLBIS entry.

Coherent Device Attribute Table 1.03 2.1 Switched Scoped Latency
and Bandwidth Information Structure (DSLBIS)

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v6:
- Adjust sslbis ptr w/o common header.
v5:
- Store data to cxl_dport directly instead. (Dan)
- Use acpi_table_parse_cdat().
v3:
- Add spec section in commit header (Alison)
- Move CDAT parse to cxl_switch_port_probe()
- Use 'struct node_hmem_attrs'
---
 drivers/cxl/core/cdat.c |   93 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h       |    8 ++++
 drivers/cxl/port.c      |    6 +++
 3 files changed, 107 insertions(+)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index 464e69a9c8e4..73ac96e754a0 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -152,5 +152,98 @@ void cxl_cdat_dsmas_list_destroy(struct list_head *dsmas_list)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cdat_dsmas_list_destroy, CXL);
 
+static int cdat_sslbis_handler(union acpi_subtable_headers *header, void *arg,
+			       const unsigned long end)
+{
+	struct acpi_cdat_sslbis *sslbis;
+	int size = sizeof(header->cdat) + sizeof(*sslbis);
+	struct cxl_port *port = arg;
+	struct device *dev = &port->dev;
+	struct acpi_cdat_sslbe *entry;
+	int remain, entries, i;
+	u16 len;
+
+	len = le16_to_cpu((__force __le16)header->cdat.length);
+	remain = len - size;
+	if (!remain || remain % sizeof(*entry) ||
+	    (unsigned long)header + len > end) {
+		dev_warn(dev, "Malformed SSLBIS table length: (%u)\n", len);
+		return -EINVAL;
+	}
+
+	/* Skip common header */
+	sslbis = (struct acpi_cdat_sslbis *)((unsigned long)header +
+					     sizeof(header->cdat));
+
+	/* Unrecognized data type, we can skip */
+	if (sslbis->data_type > ACPI_HMAT_WRITE_BANDWIDTH)
+		return 0;
+
+	entries = remain / sizeof(*entry);
+	entry = (struct acpi_cdat_sslbe *)((unsigned long)header + sizeof(*sslbis));
+
+	for (i = 0; i < entries; i++) {
+		u16 x = le16_to_cpu((__force __le16)entry->portx_id);
+		u16 y = le16_to_cpu((__force __le16)entry->porty_id);
+		__le64 le_base;
+		__le16 le_val;
+		struct cxl_dport *dport;
+		unsigned long index;
+		u16 dsp_id;
+		u64 val;
+
+		switch (x) {
+		case ACPI_CDAT_SSLBIS_US_PORT:
+			dsp_id = y;
+			break;
+		case ACPI_CDAT_SSLBIS_ANY_PORT:
+			switch (y) {
+			case ACPI_CDAT_SSLBIS_US_PORT:
+				dsp_id = x;
+				break;
+			case ACPI_CDAT_SSLBIS_ANY_PORT:
+				dsp_id = ACPI_CDAT_SSLBIS_ANY_PORT;
+				break;
+			default:
+				dsp_id = y;
+				break;
+			}
+			break;
+		default:
+			dsp_id = x;
+			break;
+		}
+
+		le_base = (__force __le64)sslbis->entry_base_unit;
+		le_val = (__force __le16)entry->latency_or_bandwidth;
+
+		if (check_mul_overflow(le64_to_cpu(le_base),
+				       le16_to_cpu(le_val), &val))
+			dev_warn(dev, "SSLBIS value overflowed!\n");
+
+		xa_for_each(&port->dports, index, dport) {
+			if (dsp_id == ACPI_CDAT_SSLBIS_ANY_PORT ||
+			    dsp_id == dport->port_id)
+				cxl_access_coordinate_set(&dport->coord,
+							  sslbis->data_type,
+							  val);
+		}
+
+		entry++;
+	}
+
+	return 0;
+}
+
+int cxl_cdat_switch_process(struct cxl_port *port)
+{
+	int rc;
+
+	rc = cdat_table_parse(ACPI_CDAT_TYPE_SSLBIS, cdat_sslbis_handler,
+			      port, port->cdat.table);
+	return cdat_table_parse_output(rc);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_cdat_switch_process, CXL);
+
 MODULE_IMPORT_NS(CXL);
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 87b9e80d834c..d18306b55a2d 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -600,6 +600,7 @@ cxl_find_dport_by_dev(struct cxl_port *port, const struct device *dport_dev)
  * @rcrb: base address for the Root Complex Register Block
  * @rch: Indicate whether this dport was enumerated in RCH or VH mode
  * @port: reference to cxl_port that contains this downstream port
+ * @coord: access coordinates (performance) for switch from CDAT
  */
 struct cxl_dport {
 	struct device *dport;
@@ -608,6 +609,7 @@ struct cxl_dport {
 	resource_size_t rcrb;
 	bool rch;
 	struct cxl_port *port;
+	struct access_coordinate coord;
 };
 
 /**
@@ -804,6 +806,7 @@ struct dsmas_entry {
 #ifdef CONFIG_ACPI_TABLES_LIB
 int cxl_cdat_endpoint_process(struct cxl_port *port, struct list_head *list);
 void cxl_cdat_dsmas_list_destroy(struct list_head *dsmas_list);
+int cxl_cdat_switch_process(struct cxl_port *port);
 #else
 static inline int cxl_cdat_endpoint_process(struct cxl_port *port,
 					    struct list_head *list)
@@ -814,6 +817,11 @@ static inline int cxl_cdat_endpoint_process(struct cxl_port *port,
 static inline void cxl_cdat_dsmas_list_destroy(struct list_head *dsmas_list)
 {
 }
+
+static inline int cxl_cdat_switch_process(struct cxl_port *port)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 /*
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 6b73e7b8660e..0f9c25645e1d 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -78,6 +78,12 @@ static int cxl_switch_port_probe(struct cxl_port *port)
 		return PTR_ERR(cxlhdm);
 	}
 
+	if (port->cdat.table) {
+		rc = cxl_cdat_switch_process(port);
+		if (rc < 0)
+			dev_warn(&port->dev, "Failed to parse SSLBIS: %d\n", rc);
+	}
+
 	if (rc == 1) {
 		dev_dbg(&port->dev, "Fallback to passthrough decoder\n");
 		return devm_cxl_add_passthrough_decoder(port);


