Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B212AB39
	for <linux-cxl@vger.kernel.org>; Thu, 12 Oct 2023 18:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TtPoUdVw"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9673C83
	for <linux-cxl@vger.kernel.org>; Thu, 12 Oct 2023 11:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697136838; x=1728672838;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zSGSBQ0N6OJAwNjL9h2bSlxcazYWsAvbzEo8Gbb7Ct4=;
  b=TtPoUdVw8r0d6Kc6OfTOyhEKXb3vi5rm6U7QyVa6Aymh8pzzO2iqm1ug
   jaH0sKP7qors1A9Ekgk9rji7gw6HFlCgwckbLTMWYEyLi8aEZkzCH7waf
   ffoCoNYFpVwo55w+4Gto/AR/GDCFOyUg8JJqF9ubaa7zth9mFvb82EC7o
   X8ymDH97dN/aRV9a1S1XLClUyJGNEcCgI1xJDxy/DRxWcS3wBo/iWcXly
   rlYCciyzsDpQJpYRskQOfsw99PGpEybIzn465flLMxmgvSqugtMvCZk8u
   l3OYbABnHbd2WEcgwdEt8330/5FxffGDRsw96AWUvCkjXD49y3qcXKdrP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="387864952"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="387864952"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 11:53:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="898245721"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="898245721"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.15.16])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 11:52:06 -0700
Subject: [PATCH v11 04/22] acpi: Move common tables helper functions to common
 lib
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Hanjun Guo <guohanjun@huawei.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Thu, 12 Oct 2023 11:53:54 -0700
Message-ID: <169713683430.2205276.17899451119920103445.stgit@djiang5-mobl3>
In-Reply-To: <169713674328.2205276.10184241477215488339.stgit@djiang5-mobl3>
References: <169713674328.2205276.10184241477215488339.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Some of the routines in ACPI driver/acpi/tables.c can be shared with
parsing CDAT. CDAT is a device-provided data structure that is formatted
similar to a platform provided ACPI table. CDAT is used by CXL and can
exist on platforms that do not use ACPI. Split out the common routine
from ACPI to accommodate platforms that do not support ACPI and move that
to /lib. The common routines can be built outside of ACPI if
FIRMWARE_TABLES is selected.

Link: https://lore.kernel.org/linux-cxl/CAJZ5v0jipbtTNnsA0-o5ozOk8ZgWnOg34m34a9pPenTyRLj=6A@mail.gmail.com/
Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 MAINTAINERS              |    2 
 drivers/acpi/Kconfig     |    1 
 drivers/acpi/tables.c    |  173 ------------------------------------------
 include/linux/acpi.h     |   42 +++-------
 include/linux/fw_table.h |   43 ++++++++++
 lib/Kconfig              |    3 +
 lib/Makefile             |    2 
 lib/fw_table.c           |  189 ++++++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 251 insertions(+), 204 deletions(-)
 create mode 100644 include/linux/fw_table.h
 create mode 100644 lib/fw_table.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 35977b269d5e..c6b08ec50109 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -294,6 +294,8 @@ F:	drivers/pnp/pnpacpi/
 F:	include/acpi/
 F:	include/linux/acpi.h
 F:	include/linux/fwnode.h
+F:	include/linux/fw_table.h
+F:	lib/fw_table.c
 F:	tools/power/acpi/
 
 ACPI APEI
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index cee82b473dc5..c0a2d43f8451 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -12,6 +12,7 @@ menuconfig ACPI
 	select PNP
 	select NLS
 	select CRC32
+	select FIRMWARE_TABLE
 	default y if X86
 	help
 	  Advanced Configuration and Power Interface (ACPI) support for 
diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 8ab0a82b4da4..c1516337f668 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -37,18 +37,6 @@ static struct acpi_table_desc initial_tables[ACPI_MAX_TABLES] __initdata;
 
 static int acpi_apic_instance __initdata_or_acpilib;
 
-enum acpi_subtable_type {
-	ACPI_SUBTABLE_COMMON,
-	ACPI_SUBTABLE_HMAT,
-	ACPI_SUBTABLE_PRMT,
-	ACPI_SUBTABLE_CEDT,
-};
-
-struct acpi_subtable_entry {
-	union acpi_subtable_headers *hdr;
-	enum acpi_subtable_type type;
-};
-
 /*
  * Disable table checksum verification for the early stage due to the size
  * limitation of the current x86 early mapping implementation.
@@ -237,167 +225,6 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 	}
 }
 
-static unsigned long __init_or_acpilib
-acpi_get_entry_type(struct acpi_subtable_entry *entry)
-{
-	switch (entry->type) {
-	case ACPI_SUBTABLE_COMMON:
-		return entry->hdr->common.type;
-	case ACPI_SUBTABLE_HMAT:
-		return entry->hdr->hmat.type;
-	case ACPI_SUBTABLE_PRMT:
-		return 0;
-	case ACPI_SUBTABLE_CEDT:
-		return entry->hdr->cedt.type;
-	}
-	return 0;
-}
-
-static unsigned long __init_or_acpilib
-acpi_get_entry_length(struct acpi_subtable_entry *entry)
-{
-	switch (entry->type) {
-	case ACPI_SUBTABLE_COMMON:
-		return entry->hdr->common.length;
-	case ACPI_SUBTABLE_HMAT:
-		return entry->hdr->hmat.length;
-	case ACPI_SUBTABLE_PRMT:
-		return entry->hdr->prmt.length;
-	case ACPI_SUBTABLE_CEDT:
-		return entry->hdr->cedt.length;
-	}
-	return 0;
-}
-
-static unsigned long __init_or_acpilib
-acpi_get_subtable_header_length(struct acpi_subtable_entry *entry)
-{
-	switch (entry->type) {
-	case ACPI_SUBTABLE_COMMON:
-		return sizeof(entry->hdr->common);
-	case ACPI_SUBTABLE_HMAT:
-		return sizeof(entry->hdr->hmat);
-	case ACPI_SUBTABLE_PRMT:
-		return sizeof(entry->hdr->prmt);
-	case ACPI_SUBTABLE_CEDT:
-		return sizeof(entry->hdr->cedt);
-	}
-	return 0;
-}
-
-static enum acpi_subtable_type __init_or_acpilib
-acpi_get_subtable_type(char *id)
-{
-	if (strncmp(id, ACPI_SIG_HMAT, 4) == 0)
-		return ACPI_SUBTABLE_HMAT;
-	if (strncmp(id, ACPI_SIG_PRMT, 4) == 0)
-		return ACPI_SUBTABLE_PRMT;
-	if (strncmp(id, ACPI_SIG_CEDT, 4) == 0)
-		return ACPI_SUBTABLE_CEDT;
-	return ACPI_SUBTABLE_COMMON;
-}
-
-static __init_or_acpilib bool has_handler(struct acpi_subtable_proc *proc)
-{
-	return proc->handler || proc->handler_arg;
-}
-
-static __init_or_acpilib int call_handler(struct acpi_subtable_proc *proc,
-					  union acpi_subtable_headers *hdr,
-					  unsigned long end)
-{
-	if (proc->handler)
-		return proc->handler(hdr, end);
-	if (proc->handler_arg)
-		return proc->handler_arg(hdr, proc->arg, end);
-	return -EINVAL;
-}
-
-/**
- * acpi_parse_entries_array - for each proc_num find a suitable subtable
- *
- * @id: table id (for debugging purposes)
- * @table_size: size of the root table
- * @table_header: where does the table start?
- * @proc: array of acpi_subtable_proc struct containing entry id
- *        and associated handler with it
- * @proc_num: how big proc is?
- * @max_entries: how many entries can we process?
- *
- * For each proc_num find a subtable with proc->id and run proc->handler
- * on it. Assumption is that there's only single handler for particular
- * entry id.
- *
- * The table_size is not the size of the complete ACPI table (the length
- * field in the header struct), but only the size of the root table; i.e.,
- * the offset from the very first byte of the complete ACPI table, to the
- * first byte of the very first subtable.
- *
- * On success returns sum of all matching entries for all proc handlers.
- * Otherwise, -ENODEV or -EINVAL is returned.
- */
-static int __init_or_acpilib acpi_parse_entries_array(
-	char *id, unsigned long table_size,
-	struct acpi_table_header *table_header, struct acpi_subtable_proc *proc,
-	int proc_num, unsigned int max_entries)
-{
-	struct acpi_subtable_entry entry;
-	unsigned long table_end, subtable_len, entry_len;
-	int count = 0;
-	int errs = 0;
-	int i;
-
-	table_end = (unsigned long)table_header + table_header->length;
-
-	/* Parse all entries looking for a match. */
-
-	entry.type = acpi_get_subtable_type(id);
-	entry.hdr = (union acpi_subtable_headers *)
-	    ((unsigned long)table_header + table_size);
-	subtable_len = acpi_get_subtable_header_length(&entry);
-
-	while (((unsigned long)entry.hdr) + subtable_len  < table_end) {
-		if (max_entries && count >= max_entries)
-			break;
-
-		for (i = 0; i < proc_num; i++) {
-			if (acpi_get_entry_type(&entry) != proc[i].id)
-				continue;
-			if (!has_handler(&proc[i]) ||
-			    (!errs &&
-			     call_handler(&proc[i], entry.hdr, table_end))) {
-				errs++;
-				continue;
-			}
-
-			proc[i].count++;
-			break;
-		}
-		if (i != proc_num)
-			count++;
-
-		/*
-		 * If entry->length is 0, break from this loop to avoid
-		 * infinite loop.
-		 */
-		entry_len = acpi_get_entry_length(&entry);
-		if (entry_len == 0) {
-			pr_err("[%4.4s:0x%02x] Invalid zero length\n", id, proc->id);
-			return -EINVAL;
-		}
-
-		entry.hdr = (union acpi_subtable_headers *)
-		    ((unsigned long)entry.hdr + entry_len);
-	}
-
-	if (max_entries && count > max_entries) {
-		pr_warn("[%4.4s:0x%02x] found the maximum %i entries\n",
-			id, proc->id, count);
-	}
-
-	return errs ? -EINVAL : count;
-}
-
 int __init_or_acpilib acpi_table_parse_entries_array(
 	char *id, unsigned long table_size, struct acpi_subtable_proc *proc,
 	int proc_num, unsigned int max_entries)
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index a73246c3c35e..0d334975c0c9 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -15,6 +15,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/property.h>
 #include <linux/uuid.h>
+#include <linux/fw_table.h>
 
 struct irq_domain;
 struct irq_domain_ops;
@@ -24,6 +25,16 @@ struct irq_domain_ops;
 #endif
 #include <acpi/acpi.h>
 
+#ifdef CONFIG_ACPI_TABLE_LIB
+#define EXPORT_SYMBOL_ACPI_LIB(x) EXPORT_SYMBOL_NS_GPL(x, ACPI)
+#define __init_or_acpilib
+#define __initdata_or_acpilib
+#else
+#define EXPORT_SYMBOL_ACPI_LIB(x)
+#define __init_or_acpilib __init
+#define __initdata_or_acpilib __initdata
+#endif
+
 #ifdef	CONFIG_ACPI
 
 #include <linux/list.h>
@@ -119,21 +130,8 @@ enum acpi_address_range_id {
 
 
 /* Table Handlers */
-union acpi_subtable_headers {
-	struct acpi_subtable_header common;
-	struct acpi_hmat_structure hmat;
-	struct acpi_prmt_module_header prmt;
-	struct acpi_cedt_header cedt;
-};
-
 typedef int (*acpi_tbl_table_handler)(struct acpi_table_header *table);
 
-typedef int (*acpi_tbl_entry_handler)(union acpi_subtable_headers *header,
-				      const unsigned long end);
-
-typedef int (*acpi_tbl_entry_handler_arg)(union acpi_subtable_headers *header,
-					  void *arg, const unsigned long end);
-
 /* Debugger support */
 
 struct acpi_debugger_ops {
@@ -207,14 +205,6 @@ static inline int acpi_debugger_notify_command_complete(void)
 		(!entry) || (unsigned long)entry + sizeof(*entry) > end ||  \
 		((struct acpi_subtable_header *)entry)->length < sizeof(*entry))
 
-struct acpi_subtable_proc {
-	int id;
-	acpi_tbl_entry_handler handler;
-	acpi_tbl_entry_handler_arg handler_arg;
-	void *arg;
-	int count;
-};
-
 void __iomem *__acpi_map_table(unsigned long phys, unsigned long size);
 void __acpi_unmap_table(void __iomem *map, unsigned long size);
 int early_acpi_boot_init(void);
@@ -229,16 +219,6 @@ void acpi_reserve_initial_tables (void);
 void acpi_table_init_complete (void);
 int acpi_table_init (void);
 
-#ifdef CONFIG_ACPI_TABLE_LIB
-#define EXPORT_SYMBOL_ACPI_LIB(x) EXPORT_SYMBOL_NS_GPL(x, ACPI)
-#define __init_or_acpilib
-#define __initdata_or_acpilib
-#else
-#define EXPORT_SYMBOL_ACPI_LIB(x)
-#define __init_or_acpilib __init
-#define __initdata_or_acpilib __initdata
-#endif
-
 int acpi_table_parse(char *id, acpi_tbl_table_handler handler);
 int __init_or_acpilib acpi_table_parse_entries(char *id,
 		unsigned long table_size, int entry_id,
diff --git a/include/linux/fw_table.h b/include/linux/fw_table.h
new file mode 100644
index 000000000000..ff8fa58d5818
--- /dev/null
+++ b/include/linux/fw_table.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *  fw_tables.h - Parsing support for ACPI and ACPI-like tables provided by
+ *                platform or device firmware
+ *
+ *  Copyright (C) 2001 Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
+ *  Copyright (C) 2023 Intel Corp.
+ */
+#ifndef _FW_TABLE_H_
+#define _FW_TABLE_H_
+
+union acpi_subtable_headers;
+
+typedef int (*acpi_tbl_entry_handler)(union acpi_subtable_headers *header,
+				      const unsigned long end);
+
+typedef int (*acpi_tbl_entry_handler_arg)(union acpi_subtable_headers *header,
+					  void *arg, const unsigned long end);
+
+struct acpi_subtable_proc {
+	int id;
+	acpi_tbl_entry_handler handler;
+	acpi_tbl_entry_handler_arg handler_arg;
+	void *arg;
+	int count;
+};
+
+#include <linux/acpi.h>
+#include <acpi/acpi.h>
+
+union acpi_subtable_headers {
+	struct acpi_subtable_header common;
+	struct acpi_hmat_structure hmat;
+	struct acpi_prmt_module_header prmt;
+	struct acpi_cedt_header cedt;
+};
+
+int acpi_parse_entries_array(char *id, unsigned long table_size,
+			     struct acpi_table_header *table_header,
+			     struct acpi_subtable_proc *proc,
+			     int proc_num, unsigned int max_entries);
+
+#endif
diff --git a/lib/Kconfig b/lib/Kconfig
index c686f4adc124..d0474e251da5 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -764,3 +764,6 @@ config ASN1_ENCODER
 
 config POLYNOMIAL
        tristate
+
+config FIRMWARE_TABLE
+	bool
diff --git a/lib/Makefile b/lib/Makefile
index 740109b6e2c8..f113b44bc4e4 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -405,6 +405,8 @@ obj-$(CONFIG_SIPHASH_KUNIT_TEST) += siphash_kunit.o
 
 obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) += devmem_is_allowed.o
 
+obj-$(CONFIG_FIRMWARE_TABLE) += fw_table.o
+
 # FORTIFY_SOURCE compile-time behavior tests
 TEST_FORTIFY_SRCS = $(wildcard $(srctree)/$(src)/test_fortify/*-*.c)
 TEST_FORTIFY_LOGS = $(patsubst $(srctree)/$(src)/%.c, %.log, $(TEST_FORTIFY_SRCS))
diff --git a/lib/fw_table.c b/lib/fw_table.c
new file mode 100644
index 000000000000..e84bd0866e10
--- /dev/null
+++ b/lib/fw_table.c
@@ -0,0 +1,189 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  fw_tables.c - Parsing support for ACPI and ACPI-like tables provided by
+ *                platform or device firmware
+ *
+ *  Copyright (C) 2001 Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
+ *  Copyright (C) 2023 Intel Corp.
+ */
+#include <linux/errno.h>
+#include <linux/fw_table.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/types.h>
+
+enum acpi_subtable_type {
+	ACPI_SUBTABLE_COMMON,
+	ACPI_SUBTABLE_HMAT,
+	ACPI_SUBTABLE_PRMT,
+	ACPI_SUBTABLE_CEDT,
+};
+
+struct acpi_subtable_entry {
+	union acpi_subtable_headers *hdr;
+	enum acpi_subtable_type type;
+};
+
+static unsigned long __init_or_acpilib
+acpi_get_entry_type(struct acpi_subtable_entry *entry)
+{
+	switch (entry->type) {
+	case ACPI_SUBTABLE_COMMON:
+		return entry->hdr->common.type;
+	case ACPI_SUBTABLE_HMAT:
+		return entry->hdr->hmat.type;
+	case ACPI_SUBTABLE_PRMT:
+		return 0;
+	case ACPI_SUBTABLE_CEDT:
+		return entry->hdr->cedt.type;
+	}
+	return 0;
+}
+
+static unsigned long __init_or_acpilib
+acpi_get_entry_length(struct acpi_subtable_entry *entry)
+{
+	switch (entry->type) {
+	case ACPI_SUBTABLE_COMMON:
+		return entry->hdr->common.length;
+	case ACPI_SUBTABLE_HMAT:
+		return entry->hdr->hmat.length;
+	case ACPI_SUBTABLE_PRMT:
+		return entry->hdr->prmt.length;
+	case ACPI_SUBTABLE_CEDT:
+		return entry->hdr->cedt.length;
+	}
+	return 0;
+}
+
+static unsigned long __init_or_acpilib
+acpi_get_subtable_header_length(struct acpi_subtable_entry *entry)
+{
+	switch (entry->type) {
+	case ACPI_SUBTABLE_COMMON:
+		return sizeof(entry->hdr->common);
+	case ACPI_SUBTABLE_HMAT:
+		return sizeof(entry->hdr->hmat);
+	case ACPI_SUBTABLE_PRMT:
+		return sizeof(entry->hdr->prmt);
+	case ACPI_SUBTABLE_CEDT:
+		return sizeof(entry->hdr->cedt);
+	}
+	return 0;
+}
+
+static enum acpi_subtable_type __init_or_acpilib
+acpi_get_subtable_type(char *id)
+{
+	if (strncmp(id, ACPI_SIG_HMAT, 4) == 0)
+		return ACPI_SUBTABLE_HMAT;
+	if (strncmp(id, ACPI_SIG_PRMT, 4) == 0)
+		return ACPI_SUBTABLE_PRMT;
+	if (strncmp(id, ACPI_SIG_CEDT, 4) == 0)
+		return ACPI_SUBTABLE_CEDT;
+	return ACPI_SUBTABLE_COMMON;
+}
+
+static __init_or_acpilib bool has_handler(struct acpi_subtable_proc *proc)
+{
+	return proc->handler || proc->handler_arg;
+}
+
+static __init_or_acpilib int call_handler(struct acpi_subtable_proc *proc,
+					  union acpi_subtable_headers *hdr,
+					  unsigned long end)
+{
+	if (proc->handler)
+		return proc->handler(hdr, end);
+	if (proc->handler_arg)
+		return proc->handler_arg(hdr, proc->arg, end);
+	return -EINVAL;
+}
+
+/**
+ * acpi_parse_entries_array - for each proc_num find a suitable subtable
+ *
+ * @id: table id (for debugging purposes)
+ * @table_size: size of the root table
+ * @table_header: where does the table start?
+ * @proc: array of acpi_subtable_proc struct containing entry id
+ *        and associated handler with it
+ * @proc_num: how big proc is?
+ * @max_entries: how many entries can we process?
+ *
+ * For each proc_num find a subtable with proc->id and run proc->handler
+ * on it. Assumption is that there's only single handler for particular
+ * entry id.
+ *
+ * The table_size is not the size of the complete ACPI table (the length
+ * field in the header struct), but only the size of the root table; i.e.,
+ * the offset from the very first byte of the complete ACPI table, to the
+ * first byte of the very first subtable.
+ *
+ * On success returns sum of all matching entries for all proc handlers.
+ * Otherwise, -ENODEV or -EINVAL is returned.
+ */
+int __init_or_acpilib
+acpi_parse_entries_array(char *id, unsigned long table_size,
+			 struct acpi_table_header *table_header,
+			 struct acpi_subtable_proc *proc,
+			 int proc_num, unsigned int max_entries)
+{
+	unsigned long table_end, subtable_len, entry_len;
+	struct acpi_subtable_entry entry;
+	int count = 0;
+	int errs = 0;
+	int i;
+
+	table_end = (unsigned long)table_header + table_header->length;
+
+	/* Parse all entries looking for a match. */
+
+	entry.type = acpi_get_subtable_type(id);
+	entry.hdr = (union acpi_subtable_headers *)
+	    ((unsigned long)table_header + table_size);
+	subtable_len = acpi_get_subtable_header_length(&entry);
+
+	while (((unsigned long)entry.hdr) + subtable_len  < table_end) {
+		if (max_entries && count >= max_entries)
+			break;
+
+		for (i = 0; i < proc_num; i++) {
+			if (acpi_get_entry_type(&entry) != proc[i].id)
+				continue;
+			if (!has_handler(&proc[i]) ||
+			    (!errs &&
+			     call_handler(&proc[i], entry.hdr, table_end))) {
+				errs++;
+				continue;
+			}
+
+			proc[i].count++;
+			break;
+		}
+		if (i != proc_num)
+			count++;
+
+		/*
+		 * If entry->length is 0, break from this loop to avoid
+		 * infinite loop.
+		 */
+		entry_len = acpi_get_entry_length(&entry);
+		if (entry_len == 0) {
+			pr_err("[%4.4s:0x%02x] Invalid zero length\n", id, proc->id);
+			return -EINVAL;
+		}
+
+		entry.hdr = (union acpi_subtable_headers *)
+		    ((unsigned long)entry.hdr + entry_len);
+	}
+
+	if (max_entries && count > max_entries) {
+		pr_warn("[%4.4s:0x%02x] found the maximum %i entries\n",
+			id, proc->id, count);
+	}
+
+	return errs ? -EINVAL : count;
+}
+EXPORT_SYMBOL_GPL(acpi_parse_entries_array);


