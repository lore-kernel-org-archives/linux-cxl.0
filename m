Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17D52D94BF
	for <linux-cxl@vger.kernel.org>; Thu,  3 Jul 2025 23:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751585246; cv=none; b=rgeHaOLoDqRXk8PsM0ypY3wsSuCTbD1SdNAtsWrEbgiClSFfGTk8Q3aEEnmNuiPUmxQPXHx7dXCwJIip64lJK0xiuRQlcHflrtYO/sSBgkM7pqIDY/uCeHhhMD/Vk9FyPNKtBS24nbeHdNXNS86ZEbPGsDepNzIIu+3Et50eIqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751585246; c=relaxed/simple;
	bh=y5Y92ogrsbZ/bM0R1HDfK3JqZNiDh3v2IoK3KGa1UZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CxhHvHtmbOwQ1qfsyRr0mutOOtt+vV9NLJmb4z2PxzOVynSfFmtezC+IWHgt6HEl/N0c9Dm7fzrihLZQfBRW8ofJTV9cF7ZH+oxFZNVGL3ShRjNCoRcRfD4+GPbh36Jk0pvai4ofDi94t/Lm/nChsWzFMfP3sNVZ2ktG4vzdwDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69227C4CEE3;
	Thu,  3 Jul 2025 23:27:26 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	Gregory Price <gourry@gourry.net>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Li Ming <ming.li@zohomail.com>
Subject: [PATCH v5 07/10] cxl: Change sslbis handler to only handle single dport
Date: Thu,  3 Jul 2025 16:27:07 -0700
Message-ID: <20250703232710.3141436-8-dave.jiang@intel.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703232710.3141436-1-dave.jiang@intel.com>
References: <20250703232710.3141436-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While cxl_switch_parse_cdat() is harmless to be run multiple times, it is
not efficient in the current scheme where one dport is being updated at
a time by the memdev probe path. Change the input parameter to the
specific dport being updated to pick up the SSLBIS information for just
that dport.

Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/cdat.c | 23 ++++++++++-------------
 drivers/cxl/core/port.c |  2 +-
 drivers/cxl/cxl.h       |  2 +-
 3 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index 0ccef2f2a26a..58c21a2f22c1 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -440,8 +440,8 @@ static int cdat_sslbis_handler(union acpi_subtable_headers *header, void *arg,
 	} *tbl = (struct acpi_cdat_sslbis_table *)header;
 	int size = sizeof(header->cdat) + sizeof(tbl->sslbis_header);
 	struct acpi_cdat_sslbis *sslbis;
-	struct cxl_port *port = arg;
-	struct device *dev = &port->dev;
+	struct cxl_dport *dport = arg;
+	struct device *dev = &dport->port->dev;
 	int remain, entries, i;
 	u16 len;
 
@@ -467,8 +467,6 @@ static int cdat_sslbis_handler(union acpi_subtable_headers *header, void *arg,
 		u16 y = le16_to_cpu((__force __le16)tbl->entries[i].porty_id);
 		__le64 le_base;
 		__le16 le_val;
-		struct cxl_dport *dport;
-		unsigned long index;
 		u16 dsp_id;
 		u64 val;
 
@@ -499,28 +497,27 @@ static int cdat_sslbis_handler(union acpi_subtable_headers *header, void *arg,
 		val = cdat_normalize(le16_to_cpu(le_val), le64_to_cpu(le_base),
 				     sslbis->data_type);
 
-		xa_for_each(&port->dports, index, dport) {
-			if (dsp_id == ACPI_CDAT_SSLBIS_ANY_PORT ||
-			    dsp_id == dport->port_id) {
-				cxl_access_coordinate_set(dport->coord,
-							  sslbis->data_type,
-							  val);
-			}
+		if (dsp_id == ACPI_CDAT_SSLBIS_ANY_PORT ||
+		    dsp_id == dport->port_id) {
+			cxl_access_coordinate_set(dport->coord,
+						  sslbis->data_type, val);
+			return 0;
 		}
 	}
 
 	return 0;
 }
 
-void cxl_switch_parse_cdat(struct cxl_port *port)
+void cxl_switch_parse_cdat(struct cxl_dport *dport)
 {
+	struct cxl_port *port = dport->port;
 	int rc;
 
 	if (!port->cdat.table)
 		return;
 
 	rc = cdat_table_parse(ACPI_CDAT_TYPE_SSLBIS, cdat_sslbis_handler,
-			      port, port->cdat.table, port->cdat.length);
+			      dport, port->cdat.table, port->cdat.length);
 	rc = cdat_table_parse_output(rc);
 	if (rc)
 		dev_dbg(&port->dev, "Failed to parse SSLBIS: %d\n", rc);
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index ffd39c5b7222..1e57e7e9f0cc 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1614,7 +1614,7 @@ static int cxl_port_setup_with_dport(struct cxl_port *port,
 {
 	device_lock_assert(&port->dev);
 
-	cxl_switch_parse_cdat(port);
+	cxl_switch_parse_cdat(dport);
 
 	return update_decoders_with_dport(port, dport);
 }
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 340073265657..cc5e0858824b 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -891,7 +891,7 @@ static inline u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint,
 #endif
 
 void cxl_endpoint_parse_cdat(struct cxl_port *port);
-void cxl_switch_parse_cdat(struct cxl_port *port);
+void cxl_switch_parse_cdat(struct cxl_dport *dport);
 
 int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
 				      struct access_coordinate *coord);
-- 
2.50.0

