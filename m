Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3063C7EE25
	for <linux-cxl@archiver.kernel.org>; Thu, 18 May 2023 18:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjERSdb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 18 May 2023 14:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjERSd3 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 18 May 2023 14:33:29 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC77E6B;
        Thu, 18 May 2023 11:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684434796; x=1715970796;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LNZ475whOSsnQ6FkXed6RBXv7ecgGn8gYpLhyzS8534=;
  b=M2rE9hZNC26RChF5YLmmEc1aw4T1OT6x6Xkn/aWc1N8fnuMBMKcMZtYB
   vnybJuT4LPLdVWAvZlUNNFQ4au5/gxSWfTprbMrWKQOl7WtV4cqFZGL2e
   wj4sFv1NFsJlWSTuuV+SW89Ke4voKxE7IcL6kfAA9S7ffUZ7E5kfOilOQ
   Kr4ff92Cq/8YXe7yq29RwWsDqeaM92jPalI/q0ittsU9P5BO1eo6vABqe
   /4DDTlX+TYFDoshWVHmeRKyeN6hFoiyBsthHnZ8LHxblH0ZSP9tbel2g9
   RtCK6U+JoRqto8YiIkwjoW6uz7zgaODpATaz5Q2msz9fcBdJmQgzyNblg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="341588772"
X-IronPort-AV: E=Sophos;i="6.00,174,1681196400"; 
   d="scan'208";a="341588772"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 11:33:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="814420327"
X-IronPort-AV: E=Sophos;i="6.00,174,1681196400"; 
   d="scan'208";a="814420327"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.16.136])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 11:33:14 -0700
Subject: [PATCH v2 3/4] acpi: fix misnamed define for CDAT DSMAS
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, rafael@kernel.org,
        lenb@kernel.org, dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        lukas@wunner.de, Jonathan.Cameron@huawei.com
Date:   Thu, 18 May 2023 11:33:14 -0700
Message-ID: <168443479457.2966470.18010229834586488037.stgit@djiang5-mobl3>
In-Reply-To: <168443445827.2966470.16511867875780059322.stgit@djiang5-mobl3>
References: <168443445827.2966470.16511867875780059322.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

ACPI_CEDT_DSMAS_NON_VOLATILE should be defined as
ACPI_CDAT_DSMAS_NON_VOLATILE. Fix misspelled define.

Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
See https://github.com/acpica/acpica/pull/874
Merged
---
 include/acpi/actbl1.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 81b9e794424d..15df363b9144 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -356,7 +356,7 @@ struct acpi_cdat_dsmas {
 
 /* Flags for subtable above */
 
-#define ACPI_CEDT_DSMAS_NON_VOLATILE        (1 << 2)
+#define ACPI_CDAT_DSMAS_NON_VOLATILE        (1 << 2)
 
 /* Subtable 1: Device scoped Latency and Bandwidth Information Structure (DSLBIS) */
 


