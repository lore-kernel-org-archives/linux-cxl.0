Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c2ScQwVI"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D03D5
	for <linux-cxl@vger.kernel.org>; Wed, 13 Dec 2023 08:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702485685; x=1734021685;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qYIGk0T/CwKy5pvLvIXYCkllyHTwOAyn2VelNvj5Z4U=;
  b=c2ScQwVINbyZt26lp7aenNcoHJqqt3atvAa5SyW9RW+Nj5Rz5trnT6LG
   Nm43BMii3QFzecTTgAn65z+np1rwjProXIeIWi+2vgadzWtz9JhWJIc6Q
   kVtq4pqiA/AUEFtlIN+zekxSeZM2UmdCiYMairneeDC7xyoro0PaRKixd
   WBZh0gb6+lp79aUQVyblEM4xEM0ridXpNhNODp0Aj6eiMq3z0JnNBqNLq
   N3XpPUKm9azORbbyCToPZmAT1Lepq0GkQUpv648Nc11DeF6QfHVcgi+I0
   YhHikoVjvAaFbymSYwSNvtnh+mgtSAlfsfP+jiwDpLCBGrr/bwTrQlcwv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="459309737"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="459309737"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 08:41:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="17675802"
Received: from mmaccool-mobl.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.76.225])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 08:41:24 -0800
Subject: [PATCH v14 01/19] lib/firmware_table: tables: Add CDAT table parsing
 support
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Wed, 13 Dec 2023 09:41:23 -0700
Message-ID: <170248568326.801570.6361795234223443195.stgit@djiang5-mobl3>
In-Reply-To: <170248552797.801570.14580769385012396142.stgit@djiang5-mobl3>
References: <170248552797.801570.14580769385012396142.stgit@djiang5-mobl3>
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
v14:
- Add __init_or_fwtbl_lib wrappers (Dan)
https://download.01.org/0day-ci/archive/20231209/202312092036.qmxTynjF-lkp@intel.com/reproduce
- Fix section mismatch (Dan)
https://download.01.org/0day-ci/archive/20231209/202312092155.I071PJA4-lkp@intel.com/reproduce
---
 drivers/acpi/tables.c    |    5 ++-
 include/linux/fw_table.h |   21 ++++++++++++-
 lib/fw_table.c           |   75 +++++++++++++++++++++++++++++++++++++++-------
 3 files changed, 86 insertions(+), 15 deletions(-)

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
index ca49947f0a77..95421860397a 100644
--- a/include/linux/fw_table.h
+++ b/include/linux/fw_table.h
@@ -25,16 +25,35 @@ struct acpi_subtable_proc {
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
+
+/* CXL is the only non-ACPI consumer of the FIRMWARE_TABLE library */
+#if IS_ENABLED(CONFIG_ACPI) && !IS_ENABLED(CONFIG_CXL_BUS)
+#define EXPORT_SYMBOL_FWTBL_LIB(x) EXPORT_SYMBOL_ACPI_LIB(x)
+#define __init_or_fwtbl_lib __init_or_acpilib
+#else
+#define EXPORT_SYMBOL_FWTBL_LIB(x) EXPORT_SYMBOL_NS_GPL(x, CXL)
+#define __init_or_fwtbl_lib
+#endif
+
 #endif
diff --git a/lib/fw_table.c b/lib/fw_table.c
index 294df54e33b6..1e5e0b2f7012 100644
--- a/lib/fw_table.c
+++ b/lib/fw_table.c
@@ -12,12 +12,14 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/types.h>
+#include <linux/fw_table.h>
 
 enum acpi_subtable_type {
 	ACPI_SUBTABLE_COMMON,
 	ACPI_SUBTABLE_HMAT,
 	ACPI_SUBTABLE_PRMT,
 	ACPI_SUBTABLE_CEDT,
+	CDAT_SUBTABLE,
 };
 
 struct acpi_subtable_entry {
@@ -25,7 +27,7 @@ struct acpi_subtable_entry {
 	enum acpi_subtable_type type;
 };
 
-static unsigned long __init_or_acpilib
+static unsigned long __init_or_fwtbl_lib
 acpi_get_entry_type(struct acpi_subtable_entry *entry)
 {
 	switch (entry->type) {
@@ -37,11 +39,13 @@ acpi_get_entry_type(struct acpi_subtable_entry *entry)
 		return 0;
 	case ACPI_SUBTABLE_CEDT:
 		return entry->hdr->cedt.type;
+	case CDAT_SUBTABLE:
+		return entry->hdr->cdat.type;
 	}
 	return 0;
 }
 
-static unsigned long __init_or_acpilib
+static unsigned long __init_or_fwtbl_lib
 acpi_get_entry_length(struct acpi_subtable_entry *entry)
 {
 	switch (entry->type) {
@@ -53,11 +57,16 @@ acpi_get_entry_length(struct acpi_subtable_entry *entry)
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
 
-static unsigned long __init_or_acpilib
+static unsigned long __init_or_fwtbl_lib
 acpi_get_subtable_header_length(struct acpi_subtable_entry *entry)
 {
 	switch (entry->type) {
@@ -69,11 +78,13 @@ acpi_get_subtable_header_length(struct acpi_subtable_entry *entry)
 		return sizeof(entry->hdr->prmt);
 	case ACPI_SUBTABLE_CEDT:
 		return sizeof(entry->hdr->cedt);
+	case CDAT_SUBTABLE:
+		return sizeof(entry->hdr->cdat);
 	}
 	return 0;
 }
 
-static enum acpi_subtable_type __init_or_acpilib
+static enum acpi_subtable_type __init_or_fwtbl_lib
 acpi_get_subtable_type(char *id)
 {
 	if (strncmp(id, ACPI_SIG_HMAT, 4) == 0)
@@ -82,17 +93,32 @@ acpi_get_subtable_type(char *id)
 		return ACPI_SUBTABLE_PRMT;
 	if (strncmp(id, ACPI_SIG_CEDT, 4) == 0)
 		return ACPI_SUBTABLE_CEDT;
+	if (strncmp(id, ACPI_SIG_CDAT, 4) == 0)
+		return CDAT_SUBTABLE;
 	return ACPI_SUBTABLE_COMMON;
 }
 
-static __init_or_acpilib bool has_handler(struct acpi_subtable_proc *proc)
+static unsigned long __init_or_fwtbl_lib
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
+static __init_or_fwtbl_lib bool has_handler(struct acpi_subtable_proc *proc)
 {
 	return proc->handler || proc->handler_arg;
 }
 
-static __init_or_acpilib int call_handler(struct acpi_subtable_proc *proc,
-					  union acpi_subtable_headers *hdr,
-					  unsigned long end)
+static __init_or_fwtbl_lib int call_handler(struct acpi_subtable_proc *proc,
+					    union acpi_subtable_headers *hdr,
+					    unsigned long end)
 {
 	if (proc->handler)
 		return proc->handler(hdr, end);
@@ -124,23 +150,26 @@ static __init_or_acpilib int call_handler(struct acpi_subtable_proc *proc,
  * On success returns sum of all matching entries for all proc handlers.
  * Otherwise, -ENODEV or -EINVAL is returned.
  */
-int __init_or_acpilib
+int __init_or_fwtbl_lib
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
@@ -186,3 +215,25 @@ acpi_parse_entries_array(char *id, unsigned long table_size,
 
 	return errs ? -EINVAL : count;
 }
+
+int __init_or_fwtbl_lib
+cdat_table_parse(enum acpi_cdat_type type,
+		 acpi_tbl_entry_handler_arg handler_arg,
+		 void *arg,
+		 struct acpi_table_cdat *table_header)
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
+EXPORT_SYMBOL_FWTBL_LIB(cdat_table_parse);


