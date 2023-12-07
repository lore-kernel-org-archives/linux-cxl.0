Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HMe9/Qja"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA3B1725
	for <linux-cxl@vger.kernel.org>; Thu,  7 Dec 2023 14:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701989965; x=1733525965;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wi5X4Y/UqkQ7rNH7POY1bROVKtc/wPAg5X4xtwnVV5w=;
  b=HMe9/QjaX0OgyYoQvdGqpsCjWiGQvYg7nnU9GGjlUX5eKSYvuR4cG1ZJ
   jnS01P4QyAWWtxndGOjhyVKGTY9slnBKipgmQmyPjd7nXsfWfu2WZLbKa
   XRC+eypLjnPyO6WT5D31eShcfp0ndB7gKuKmUEfC0GpgLecNHbRHvBuqW
   vZ98wF8rAQv8KsA0tJBNdhyZAkBmTMY0R8ya/i/pylICzeFyWpNtjh72c
   wbiptIq3lb3yBbYKaVvXHZGD7jSaiCMtCgumAY8/+3wCdE4f1X+xVWZUM
   ALxT9eZi5T5La4qBjOevK6VTGd85IvgrdlkMdjzwkR6rCzA+s+rnkEy6T
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="1185247"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="1185247"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 14:59:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="842380512"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="842380512"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.213.168.225])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 14:59:23 -0800
Subject: [PATCH v13 10/19] cxl: Add callback to parse the SSLBIS subtable from
 CDAT
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Thu, 07 Dec 2023 15:59:22 -0700
Message-ID: <170198996288.3522351.13002588807584740344.stgit@djiang5-mobl3>
In-Reply-To: <170198976423.3522351.8359845516235306693.stgit@djiang5-mobl3>
References: <170198976423.3522351.8359845516235306693.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

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
 drivers/cxl/core/cdat.c |   93 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h       |    3 ++
 drivers/cxl/port.c      |    6 +++
 3 files changed, 102 insertions(+)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index e8587406441d..a2a29f92bfbf 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -159,4 +159,97 @@ void cxl_cdat_dsmas_xa_destroy(struct xarray *dsmas_xa)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cdat_dsmas_xa_destroy, CXL);
 
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
+				cxl_access_coordinate_set(&dport->sw_coord,
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
index 5f73cb1d4512..b3abac9c60ca 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -635,6 +635,7 @@ struct cxl_rcrb_info {
  * @rch: Indicate whether this dport was enumerated in RCH or VH mode
  * @port: reference to cxl_port that contains this downstream port
  * @regs: Dport parsed register blocks
+ * @sw_coord: access coordinates (performance) for switch from CDAT
  */
 struct cxl_dport {
 	struct device *dport_dev;
@@ -644,6 +645,7 @@ struct cxl_dport {
 	bool rch;
 	struct cxl_port *port;
 	struct cxl_regs regs;
+	struct access_coordinate sw_coord;
 };
 
 /**
@@ -849,6 +851,7 @@ struct dsmas_entry {
 
 int cxl_cdat_endpoint_process(struct cxl_port *port, struct xarray *dsmas_xa);
 void cxl_cdat_dsmas_xa_destroy(struct xarray *dsmas_xa);
+int cxl_cdat_switch_process(struct cxl_port *port);
 
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 1bae77913c82..9cd6cbbdd3b4 100644
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


