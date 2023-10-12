Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FBF33986
	for <linux-cxl@vger.kernel.org>; Thu, 12 Oct 2023 18:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ddK8b3Y3"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DD5BE
	for <linux-cxl@vger.kernel.org>; Thu, 12 Oct 2023 11:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697136841; x=1728672841;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bi0CevuUkg4bEOhHj2TAK8AMG2eLo29iczB+qNDwgRQ=;
  b=ddK8b3Y3bOerdBLGweUyBdEaMUT+0cjISuPynlIl0KXYc+o9TqeOLQbk
   4NIq1ALPWuwEt6w86S7Q0CrNlEAAtl83k2kInqQ8NjS+vgx3Ihmeiukmj
   u66DRPrcnrvmjcbKENfnfQZ3uXrAj6fON1EbEWC1dQS4BWfMPtqjHrSYf
   Hhaifc2hCqlyt3SqReDmfo0FRqnBJ0N53J3U0QKQxaUiBMxULCSMGnhV1
   /l1/tPCzln0N+p8sibfFgEE2GYD1SBge3SUIwLQmfqzLUyUSoX8PfJ5Je
   yeXA34NGLQcl6GLW0yjyGmsIHLx5VUY62yRSHi6kBhLCS4HF+voHzuetu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="387864978"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="387864978"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 11:54:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="731040604"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="731040604"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.15.16])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 11:54:00 -0700
Subject: [PATCH v11 05/22] lib/firmware_table: tables: Add CDAT table parsing
 support
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Thu, 12 Oct 2023 11:54:00 -0700
Message-ID: <169713684023.2205276.10694121707579364992.stgit@djiang5-mobl3>
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
index ff8fa58d5818..a97d368df520 100644
--- a/include/linux/fw_table.h
+++ b/include/linux/fw_table.h
@@ -28,16 +28,25 @@ struct acpi_subtable_proc {
 #include <linux/acpi.h>
 #include <acpi/acpi.h>
 
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
index e84bd0866e10..108f1db3f1a6 100644
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
@@ -187,3 +215,23 @@ acpi_parse_entries_array(char *id, unsigned long table_size,
 	return errs ? -EINVAL : count;
 }
 EXPORT_SYMBOL_GPL(acpi_parse_entries_array);
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


