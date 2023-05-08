Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0ABC77B7F
	for <linux-cxl@archiver.kernel.org>; Mon,  8 May 2023 20:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjEHUrd (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 8 May 2023 16:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjEHUrc (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 8 May 2023 16:47:32 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64255587
        for <linux-cxl@vger.kernel.org>; Mon,  8 May 2023 13:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683578850; x=1715114850;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nNHJZbx6SzN4jOJjU2bW6mMF7KMFWeDCyYy+tiNgg+Q=;
  b=evQ0z1pWpoA7hejhUjkB/dBbx7Wm5QKdX7v0xp3cYJhl06zztvvqV7DA
   vkE3v8mxCK3t/M9Bh6AgqqbgJ2Yvntsy3w6zSC5OzOYE/vGr+3silU/Qw
   DiBgDO1wmy+TNawI/DaqBJD60/aAIyv9OUDU6N8bCelvXLwSuaOQ9C5f9
   xmLZLaBWOOrZhQ363lyVsdWUePFccT5++QZ/VqQxhzDZi0ijpTao0KaPl
   UJEcU9MpzyipwlZRoFrYgxmq/mUF31grgk0HK2PW98uZpmgiWccrif4fK
   1DNAXRuPGU8lK246dyB19MtkV9kBQJ3r1ayxUTyDI9EtfK0IWTdT193tC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="338976604"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="338976604"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 13:47:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="731431665"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="731431665"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.213.172.228])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 13:47:12 -0700
Subject: [PATCH v5 03/14] cxl: Add callback to parse the SSLBIS subtable from
 CDAT
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com
Date:   Mon, 08 May 2023 13:47:11 -0700
Message-ID: <168357883158.2756219.14426990857899261700.stgit@djiang5-mobl3>
In-Reply-To: <168357873843.2756219.5839806150467356492.stgit@djiang5-mobl3>
References: <168357873843.2756219.5839806150467356492.stgit@djiang5-mobl3>
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
v5:
- Store data to cxl_dport directly instead. (Dan)
- Use acpi_table_parse_cdat().
v3:
- Add spec section in commit header (Alison)
- Move CDAT parse to cxl_switch_port_probe()
- Use 'struct node_hmem_attrs'
---
 drivers/cxl/core/cdat.c |   88 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h       |    8 ++++
 drivers/cxl/port.c      |   12 ++++++
 include/acpi/actbl1.h   |    3 ++
 4 files changed, 110 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index 6e14d04c0453..37b135c900d5 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -124,3 +124,91 @@ int cxl_cdat_endpoint_process(struct cxl_port *port, struct list_head *list)
 	return rc;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cdat_endpoint_process, CXL);
+
+static int cdat_sslbis_handler(union acpi_subtable_headers *header, void *arg,
+			       const unsigned long end)
+{
+	struct acpi_cdat_sslbis *sslbis = (struct acpi_cdat_sslbis *)header;
+	struct acpi_cdat_sslbe *entry;
+	struct cxl_port *port = arg;
+	struct device *dev = &port->dev;
+	int remain, entries, i;
+	u16 len;
+
+	len = le16_to_cpu((__force __le16)sslbis->header.length);
+	remain = len - sizeof(*sslbis);
+	if (!remain || remain % sizeof(*entry) ||
+	    (unsigned long)header + len > end) {
+		dev_warn(dev, "Malformed SSLBIS table length: (%u)\n", len);
+		return -EINVAL;
+	}
+
+	/* Unrecognized data type, we can skip */
+	if (sslbis->data_type > ACPI_HMAT_WRITE_BANDWIDTH)
+		return 0;
+
+	entries = remain / sizeof(*entry);
+	entry = (struct acpi_cdat_sslbe *)((unsigned long)header + sizeof(*sslbis));
+
+	for (i = 0; i < entries; i++) {
+		u16 x = le16_to_cpu(entry->portx_id);
+		u16 y = le16_to_cpu(entry->porty_id);
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
+		if (check_mul_overflow(le64_to_cpu(sslbis->entry_base_unit),
+				       le16_to_cpu(entry->latency_or_bandwidth),
+				       &val))
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
+	rc = acpi_table_parse_cdat(ACPI_CDAT_TYPE_SSLBIS,
+				   cdat_sslbis_handler,
+				   port, port->cdat.table);
+	if (rc == 0)
+		rc = -ENOENT;
+
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_cdat_switch_process, CXL);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index ca3d0d74f2e5..3e8020e0a132 100644
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
@@ -803,12 +805,18 @@ struct dsmas_entry {
 
 #ifdef CONFIG_ACPI
 int cxl_cdat_endpoint_process(struct cxl_port *port, struct list_head *list);
+int cxl_cdat_switch_process(struct cxl_port *port);
 #else
 static inline int cxl_cdat_endpoint_process(struct cxl_port *port,
 					    struct list_head *list)
 {
 	return -EOPNOTSUPP;
 }
+
+static inline int cxl_cdat_switch_process(struct cxl_port *port)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 /*
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index da023feaa6e2..c5a24b75bf03 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -86,7 +86,17 @@ static int cxl_switch_port_probe(struct cxl_port *port)
 	if (IS_ERR(cxlhdm))
 		return PTR_ERR(cxlhdm);
 
-	return devm_cxl_enumerate_decoders(cxlhdm, NULL);
+	rc = devm_cxl_enumerate_decoders(cxlhdm, NULL);
+	if (rc < 0)
+		return rc;
+
+	if (port->cdat.table) {
+		rc = cxl_cdat_switch_process(port);
+		if (rc < 0)
+			dev_warn(&port->dev, "Failed to parse SSLBIS: %d\n", rc);
+	}
+
+	return 0;
 }
 
 static int cxl_endpoint_port_probe(struct cxl_port *port)
diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 8ea7e5d64bc1..82def138a7e4 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -419,6 +419,9 @@ struct acpi_cdat_sslbis {
 	u64 entry_base_unit;
 };
 
+#define ACPI_CDAT_SSLBIS_US_PORT	0x0100
+#define ACPI_CDAT_SSLBIS_ANY_PORT	0xffff
+
 /* Sub-subtable for above, sslbe_entries field */
 
 struct acpi_cdat_sslbe {


