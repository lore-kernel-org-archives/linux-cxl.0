Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DA9ECAAA1
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Sep 2022 23:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiIPXLn (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 16 Sep 2022 19:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiIPXLm (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 16 Sep 2022 19:11:42 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6357C32C
        for <linux-cxl@vger.kernel.org>; Fri, 16 Sep 2022 16:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663369901; x=1694905901;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e0YZmFJCpFJF3RrTonPHui8NqIYRM1Frx/pGXfoJwBs=;
  b=kzQPJdVnhmWq7YPfZZmj1mEOJLatFPf9hQhgEzP8Ebv92uhq9wJFNZvV
   lqjh/M2kO9ugmAYR2kl6EhQIkLICx0Jh4l5P0p3I5WwzRyGf57KDhS733
   xkiBSxPsVTWBdeZ8rDWCA/WiCdqu3mTAH6GBWdI27X5KcHo87RlUa5RxO
   LA1wX7p4rwtd+X2w5RjZXdZhNU6lgqS9Y6NPjOLb/vf1GJtnCmDaV1qeo
   S+atKorbX1Z/deJI8sGQ5A/14QQ4LhVd2nDg4bj6gtQxVfRpV/1hE1i8V
   uy2Y23IWklq9ZCCYQyNTJbnRFsvGhw7pqxzBPGL94FX8tD3GgMf1T1rZY
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="385389697"
X-IronPort-AV: E=Sophos;i="5.93,321,1654585200"; 
   d="scan'208";a="385389697"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 16:11:40 -0700
X-IronPort-AV: E=Sophos;i="5.93,321,1654585200"; 
   d="scan'208";a="686305387"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 16:11:40 -0700
Subject: [PATCH RFC v2 8/9] cxl/pci: add tracepoint events for CXL RAS
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        bwidawsk@kernel.org, dan.j.williams@intel.com,
        jonathan.cameron@huawei.com, shiju.jose@huawei.com,
        rrichter@amd.com
Date:   Fri, 16 Sep 2022 16:11:39 -0700
Message-ID: <166336989980.3803215.5292431481210955312.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166336972295.3803215.1047199449525031921.stgit@djiang5-desk3.ch.intel.com>
References: <166336972295.3803215.1047199449525031921.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Add tracepoint events for recording the CXL uncorrectable and correctable
errors. For uncorrectable errors, there is additional data up to 512B from
the header log register (CXL spec rev3 8.2.4.16.7). The content of the
register depends on the Uncorrectable Errors (UC) register status (CXL spec
rev3 8.2.4.16.1).  This implementation supports the Receiver_Overflow error
where the definition is defined as first 3 bits of the Header Log data. The
trace event will intake a dynamic array that will dump the Header Log data
based on error. If multiple errors are set in the status register, then the
'first error' field (CXL spec rev3 v8.2.4.16.6) is read from the Error
Capabilities and Control Register in order to determine the error.

This implementation does not include CXL IDE Error details.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/pci.c              |    2 +
 include/trace/events/cxl_ras.h |  117 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 119 insertions(+)
 create mode 100644 include/trace/events/cxl_ras.h

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 610b3a77f205..357de704e42c 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -13,6 +13,8 @@
 #include "cxlmem.h"
 #include "cxlpci.h"
 #include "cxl.h"
+#define CREATE_TRACE_POINTS
+#include <trace/events/cxl_ras.h>
 
 /**
  * DOC: cxl pci
diff --git a/include/trace/events/cxl_ras.h b/include/trace/events/cxl_ras.h
new file mode 100644
index 000000000000..6bb41c3b87c8
--- /dev/null
+++ b/include/trace/events/cxl_ras.h
@@ -0,0 +1,117 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM cxl_ras
+
+#if !defined(_CXL_RAS_EVENTS_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _CXL_RAS_EVENTS_H
+
+#include <linux/tracepoint.h>
+
+#define CXL_RAS_UC_CACHE_DATA_PARITY	BIT(0)
+#define CXL_RAS_UC_CACHE_ADDR_PARITY	BIT(1)
+#define CXL_RAS_UC_CACHE_BE_PARITY	BIT(2)
+#define CXL_RAS_UC_CACHE_DATA_ECC	BIT(3)
+#define CXL_RAS_UC_MEM_DATA_PARITY	BIT(4)
+#define CXL_RAS_UC_MEM_ADDR_PARITY	BIT(5)
+#define CXL_RAS_UC_MEM_BE_PARITY	BIT(6)
+#define CXL_RAS_UC_MEM_DATA_ECC		BIT(7)
+#define CXL_RAS_UC_REINIT_THRESH	BIT(8)
+#define CXL_RAS_UC_RSVD_ENCODE		BIT(9)
+#define CXL_RAS_UC_POISON		BIT(10)
+#define CXL_RAS_UC_RECV_OVERFLOW	BIT(11)
+#define CXL_RAS_UC_INTERNAL_ERR		BIT(14)
+#define CXL_RAS_UC_IDE_TX_ERR		BIT(15)
+#define CXL_RAS_UC_IDE_RX_ERR		BIT(16)
+
+#define show_uc_errs(status)	__print_flags(status, " | ",		  \
+	{ CXL_RAS_UC_CACHE_DATA_PARITY, "Cache Data Parity Error" },	  \
+	{ CXL_RAS_UC_CACHE_ADDR_PARITY, "Cache Address Parity Error" },	  \
+	{ CXL_RAS_UC_CACHE_BE_PARITY, "Cache Byte Enable Parity Error" }, \
+	{ CXL_RAS_UC_CACHE_DATA_ECC, "Cache Data ECC Error" },		  \
+	{ CXL_RAS_UC_MEM_DATA_PARITY, "Memory Data Parity Error" },	  \
+	{ CXL_RAS_UC_MEM_ADDR_PARITY, "Memory Address Parity Error" },	  \
+	{ CXL_RAS_UC_MEM_BE_PARITY, "Memory Byte Enable Parity Error" },  \
+	{ CXL_RAS_UC_MEM_DATA_ECC, "Memory Data ECC Error" },		  \
+	{ CXL_RAS_UC_REINIT_THRESH, "REINIT Threshold Hit" },		  \
+	{ CXL_RAS_UC_RSVD_ENCODE, "Received Unrecognized Encoding" },	  \
+	{ CXL_RAS_UC_POISON, "Received Poison From Peer" },		  \
+	{ CXL_RAS_UC_RECV_OVERFLOW, "Receiver Overflow" },		  \
+	{ CXL_RAS_UC_INTERNAL_ERR, "Component Specific Error" },	  \
+	{ CXL_RAS_UC_IDE_TX_ERR, "IDE Tx Error" },			  \
+	{ CXL_RAS_UC_IDE_RX_ERR, "IDE Rx Error" }			  \
+)
+
+#define CXL_RAS_UC_OVFL_D2H_REQ		BIT(0)
+#define CXL_RAS_UC_OVFL_D2H_RSP		BIT(1)
+#define CXL_RAS_UC_OVFL_D2H_DATA	BIT(2)
+#define CXL_RAS_UC_OVFL_S2M_NDR		BIT(3)
+#define CXL_RAS_UC_OVFL_S2M_DRS		BIT(4)
+
+#define show_uc_ovfl(hl)	__print_flags(hl, " | ",		\
+	{ CXL_RAS_UC_OVFL_D2H_REQ, "Receiver Overflow D2H Req" },	\
+	{ CXL_RAS_UC_OVFL_D2H_RSP, "Receiver Overflow D2H Rsp" },	\
+	{ CXL_RAS_UC_OVFL_D2H_DATA, "Receiver Overflow D2H Data" },	\
+	{ CXL_RAS_UC_OVFL_S2M_NDR, "Receiver Overflow S2M NDR" },	\
+	{ CXL_RAS_UC_OVFL_S2M_DRS, "Receiver Overflow S2M DRS" }	\
+)
+
+TRACE_EVENT(cxl_ras_uc,
+	TP_PROTO(const char *dev_name, u32 status, u32 fe, u8 *hl, int hl_len),
+	TP_ARGS(dev_name, status, fe, hl, hl_len),
+	TP_STRUCT__entry(
+		__string(dev_name, dev_name)
+		__field(u32, status)
+		__field(u32, first_error)
+		__dynamic_array(u8, header_log, hl_len)
+		__field(int, header_log_len)
+	),
+	TP_fast_assign(
+		__assign_str(dev_name, dev_name);
+		__entry->status = status;
+		__entry->first_error = fe;
+		memcpy(__get_dynamic_array(header_log), hl, hl_len);
+		__entry->header_log_len = hl_len;
+	),
+	TP_printk("%s: status: '%s' first_error: '%s' header log: %s",
+		  __get_str(dev_name), show_uc_errs(__entry->status),
+		  show_uc_errs(__entry->first_error),
+		  __print_array(__get_dynamic_array(header_log), __entry->header_log_len, 1)
+	)
+);
+
+#define CXL_RAS_CE_CACHE_DATA_ECC	BIT(0)
+#define CXL_RAS_CE_MEM_DATA_ECC		BIT(1)
+#define CXL_RAS_CE_CRC_THRESH		BIT(2)
+#define CXL_RAS_CE_CACHE_POISON		BIT(3)
+#define CXL_RAS_CE_MEM_POISON		BIT(4)
+#define CXL_RAS_CE_PHYS_LAYER_ERR	BIT(5)
+
+#define show_ce_errs(status)	__print_flags(status, " | ",			\
+	{ CXL_RAS_CE_CACHE_DATA_ECC, "Cache Data ECC Error" },			\
+	{ CXL_RAS_CE_MEM_DATA_ECC, "Memory Data Ecc Error" },			\
+	{ CXL_RAS_CE_CRC_THRESH, "CRC Threshold Hit" },				\
+	{ CXL_RAS_CE_CACHE_POISON, "Received Cache Poison From Peer" },		\
+	{ CXL_RAS_CE_MEM_POISON, "Received Memory Poison From Peer" },		\
+	{ CXL_RAS_CE_PHYS_LAYER_ERR, "Received Error From Physical Layer" }	\
+)
+
+TRACE_EVENT(cxl_ras_ce,
+	TP_PROTO(const char *dev_name, u32 status),
+	TP_ARGS(dev_name, status),
+	TP_STRUCT__entry(
+		__string(dev_name, dev_name)
+		__field(u32, status)
+	),
+	TP_fast_assign(
+		__assign_str(dev_name, dev_name);
+		__entry->status = status;
+	),
+	TP_printk("%s: status: '%s'",
+		  __get_str(dev_name), show_ce_errs(__entry->status)
+	)
+);
+
+#endif /* _CXL_RAS_EVENTS_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>


