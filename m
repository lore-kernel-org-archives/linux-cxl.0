Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cY47CZWG"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F071717
	for <linux-cxl@vger.kernel.org>; Thu,  7 Dec 2023 14:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701989910; x=1733525910;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MEwO4OKa/UQHgXNFx6b7LSqX/J3zKraGTtxem08ymaM=;
  b=cY47CZWGd7WJ1B1+TWQk3oHNgqMW/5zJWkxgyGDy5ImKgf3iCMKVJXtc
   dAE7fQnbj8gBd1FbGONKV34Y4UrHClUsiPr3e03b1VYf47tctU/vQiDr5
   B21XlM2AvLsJmydJPsKLGyOf5DmyVqifO64lro8EvbXo1VchIBGWryI+H
   ymxN+oETNA+1UoH8vHb8CYJODKMw6yJLW6fu2rSc1D6DPEiT/a732YorE
   dsvks8+ertZ67ymfMi7xl5/tey9wnZEPs0+hJwpaPMvVxF2CqH+jT96Ge
   8EfRzLpnKk+AxvByoiSPvQVC+hNLoV3HU5BAhDcOyJqFxz+USSAV1+7T2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="458632430"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="458632430"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 14:58:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="1103360381"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="1103360381"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.213.168.225])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 14:58:28 -0800
Subject: [PATCH v13 01/19] lib/firmware_table: tables: Add CDAT table parsing
 support
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Thu, 07 Dec 2023 15:58:28 -0700
Message-ID: <170198990828.3522351.1442977127483943057.stgit@djiang5-mobl3>
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

The CDAT table is very similar to ACPI tables when it comes to sub-table
and entry structures. The helper functions can be also used to parse the
CDAT table. Add support to the helper functions to deal with an external
CDAT table, and also handle the endieness since CDAT can be processed by a
BE host. Export a function cdat_table_parse() for CXL driver to parse
a CDAT table.

In order to minimize ACPICA code changes, __force is being utilized to deal
with the case of a big endian (BE) host parsing a CDAT. All CDAT data
structure variables are being force casted to __leX as appropriate.

Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/tables.c    |    5 +++-
 include/linux/fw_table.h |   11 +++++++++
 lib/fw_table.c           |   54 +++++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 64 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index c1516337f668..b07f7d091d13 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -251,8 +251,9 @@ int __init_or_acpilib acpi_table_parse_entries_array(
 		return -ENODEV;
 	}
 
-	count = acpi_parse_entries_array(id, table_size, table_header,
-			proc, proc_num, max_entries);
+	count = acpi_parse_entries_array(id, table_size,
+					 (union fw_table_header *)table_header,
+					 proc, proc_num, max_entries);
 
 	acpi_put_table(table_header);
 	return count;
diff --git a/include/linux/fw_table.h b/include/linux/fw_table.h
index ca49947f0a77..52db483ae907 100644
--- a/include/linux/fw_table.h
+++ b/include/linux/fw_table.h
@@ -25,16 +25,25 @@ struct acpi_subtable_proc {
 	int count;
 };
 
+union fw_table_header {
+	struct acpi_table_header acpi;
+	struct acpi_table_cdat cdat;
+};
+
 union acpi_subtable_headers {
 	struct acpi_subtable_header common;
 	struct acpi_hmat_structure hmat;
 	struct acpi_prmt_module_header prmt;
 	struct acpi_cedt_header cedt;
+	struct acpi_cdat_header cdat;
 };
 
 int acpi_parse_entries_array(char *id, unsigned long table_size,
-			     struct acpi_table_header *table_header,
+			     union fw_table_header *table_header,
 			     struct acpi_subtable_proc *proc,
 			     int proc_num, unsigned int max_entries);
 
+int cdat_table_parse(enum acpi_cdat_type type,
+		     acpi_tbl_entry_handler_arg handler_arg, void *arg,
+		     struct acpi_table_cdat *table_header);
 #endif
diff --git a/lib/fw_table.c b/lib/fw_table.c
index 294df54e33b6..5d3adabca7e5 100644
--- a/lib/fw_table.c
+++ b/lib/fw_table.c
@@ -18,6 +18,7 @@ enum acpi_subtable_type {
 	ACPI_SUBTABLE_HMAT,
 	ACPI_SUBTABLE_PRMT,
 	ACPI_SUBTABLE_CEDT,
+	CDAT_SUBTABLE,
 };
 
 struct acpi_subtable_entry {
@@ -37,6 +38,8 @@ acpi_get_entry_type(struct acpi_subtable_entry *entry)
 		return 0;
 	case ACPI_SUBTABLE_CEDT:
 		return entry->hdr->cedt.type;
+	case CDAT_SUBTABLE:
+		return entry->hdr->cdat.type;
 	}
 	return 0;
 }
@@ -53,6 +56,11 @@ acpi_get_entry_length(struct acpi_subtable_entry *entry)
 		return entry->hdr->prmt.length;
 	case ACPI_SUBTABLE_CEDT:
 		return entry->hdr->cedt.length;
+	case CDAT_SUBTABLE: {
+		__le16 length = (__force __le16)entry->hdr->cdat.length;
+
+		return le16_to_cpu(length);
+	}
 	}
 	return 0;
 }
@@ -69,6 +77,8 @@ acpi_get_subtable_header_length(struct acpi_subtable_entry *entry)
 		return sizeof(entry->hdr->prmt);
 	case ACPI_SUBTABLE_CEDT:
 		return sizeof(entry->hdr->cedt);
+	case CDAT_SUBTABLE:
+		return sizeof(entry->hdr->cdat);
 	}
 	return 0;
 }
@@ -82,9 +92,24 @@ acpi_get_subtable_type(char *id)
 		return ACPI_SUBTABLE_PRMT;
 	if (strncmp(id, ACPI_SIG_CEDT, 4) == 0)
 		return ACPI_SUBTABLE_CEDT;
+	if (strncmp(id, ACPI_SIG_CDAT, 4) == 0)
+		return CDAT_SUBTABLE;
 	return ACPI_SUBTABLE_COMMON;
 }
 
+static unsigned long __init_or_acpilib
+acpi_table_get_length(enum acpi_subtable_type type,
+		      union fw_table_header *header)
+{
+	if (type == CDAT_SUBTABLE) {
+		__le32 length = (__force __le32)header->cdat.length;
+
+		return le32_to_cpu(length);
+	}
+
+	return header->acpi.length;
+}
+
 static __init_or_acpilib bool has_handler(struct acpi_subtable_proc *proc)
 {
 	return proc->handler || proc->handler_arg;
@@ -126,21 +151,24 @@ static __init_or_acpilib int call_handler(struct acpi_subtable_proc *proc,
  */
 int __init_or_acpilib
 acpi_parse_entries_array(char *id, unsigned long table_size,
-			 struct acpi_table_header *table_header,
+			 union fw_table_header *table_header,
 			 struct acpi_subtable_proc *proc,
 			 int proc_num, unsigned int max_entries)
 {
 	unsigned long table_end, subtable_len, entry_len;
 	struct acpi_subtable_entry entry;
+	enum acpi_subtable_type type;
 	int count = 0;
 	int errs = 0;
 	int i;
 
-	table_end = (unsigned long)table_header + table_header->length;
+	type = acpi_get_subtable_type(id);
+	table_end = (unsigned long)table_header +
+		    acpi_table_get_length(type, table_header);
 
 	/* Parse all entries looking for a match. */
 
-	entry.type = acpi_get_subtable_type(id);
+	entry.type = type;
 	entry.hdr = (union acpi_subtable_headers *)
 	    ((unsigned long)table_header + table_size);
 	subtable_len = acpi_get_subtable_header_length(&entry);
@@ -186,3 +214,23 @@ acpi_parse_entries_array(char *id, unsigned long table_size,
 
 	return errs ? -EINVAL : count;
 }
+
+int cdat_table_parse(enum acpi_cdat_type type,
+		     acpi_tbl_entry_handler_arg handler_arg, void *arg,
+		     struct acpi_table_cdat *table_header)
+{
+	struct acpi_subtable_proc proc = {
+		.id		= type,
+		.handler_arg	= handler_arg,
+		.arg		= arg,
+	};
+
+	if (!table_header)
+		return -EINVAL;
+
+	return acpi_parse_entries_array(ACPI_SIG_CDAT,
+					sizeof(struct acpi_table_cdat),
+					(union fw_table_header *)table_header,
+					&proc, 1, 0);
+}
+EXPORT_SYMBOL_NS_GPL(cdat_table_parse, CXL);


