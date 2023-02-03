Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56675C6379F
	for <linux-cxl@archiver.kernel.org>; Fri,  3 Feb 2023 01:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbjBCBFc (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 2 Feb 2023 20:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232409AbjBCBFb (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 2 Feb 2023 20:05:31 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9052754573
        for <linux-cxl@vger.kernel.org>; Thu,  2 Feb 2023 17:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675386330; x=1706922330;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=NDzI6WbNEgD6Cpe2U35qUyQ0qr523OSvCxvoyB+CSA8=;
  b=C2mv24Ns3nFznVLYJ6K+N7ZKevXSiwociAf27fr2LhsLTZa9KU6CwajG
   nV1DqkqtqPf+eEH3pMYnUDi6W1x4u23Nr1dIGqo1Vh8DyT/LtLtHcQNCg
   Qk2PX0YztoOGtuVIfsFmTBO9SUS8nVv+ddMwzU6cxNzduYYSGDbD1YrzM
   XELK5+BWaRspduSWQ5sYO552irYLCbTBJnHSmgmza6lRJP2JgElRtA9+V
   1zG6ZBUnsT/BYman2cXVZCbHGg4VzDjP9t/hgmy4RZCw9LY7MSPcUJM7g
   L2eS+dREC57WSBbBJFU8/4yV2CDPoDdChqs4aigXsgBlS6Qmtdf3YoP/f
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="393215340"
X-IronPort-AV: E=Sophos;i="5.97,269,1669104000"; 
   d="scan'208";a="393215340"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 17:04:40 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="839412557"
X-IronPort-AV: E=Sophos;i="5.97,269,1669104000"; 
   d="scan'208";a="839412557"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.212.229.82])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 17:04:39 -0800
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Thu, 02 Feb 2023 17:04:27 -0800
Subject: [PATCH v4 4/4] cxl/mem: Fix UAPI command comment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221222-cxl-misc-v4-4-62f701c1cdd1@intel.com>
References: <20221222-cxl-misc-v4-0-62f701c1cdd1@intel.com>
In-Reply-To: <20221222-cxl-misc-v4-0-62f701c1cdd1@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Jiang, Dave" <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Robert Richter <rrichter@amd.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.11.0-dev-e429b
X-Developer-Signature: v=1; a=ed25519-sha256; t=1675386275; l=1411;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=NDzI6WbNEgD6Cpe2U35qUyQ0qr523OSvCxvoyB+CSA8=;
 b=2hGscOWMEPp7Lvl8qIz9IAX0UX7k3kCD9dvmXO7KiWMGZAUEs5dear1QOwORPSgUIWRLiCobpTrF
 uJUtvO1+B/qU5WSR8Tu5UPbCKl1vS/qtROa7rcNrPdhAus+gTm5u
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The command comment had grammatical errors.  In an attempt to fix those
it was noted that the comment and the query command were not in sync.

Now that the query command returns excluded and device unsupported
command information.  Update the kdoc and fix the grammatical errors.

[1] https://lore.kernel.org/all/63b4ec4e37cc1_5178e2941d@dwillia2-xfh.jf.intel.com.notmuch/

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 include/uapi/linux/cxl_mem.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
index 9fe832afee37..86bbacf2a315 100644
--- a/include/uapi/linux/cxl_mem.h
+++ b/include/uapi/linux/cxl_mem.h
@@ -11,9 +11,10 @@
 /**
  * DOC: UAPI
  *
- * Not all of all commands that the driver supports are always available for use
- * by userspace. Userspace must check the results from the QUERY command in
- * order to determine the live set of commands.
+ * Not all of the commands that the driver supports are available for use by
+ * userspace at all times.  Userspace can check the result of the QUERY command
+ * to determine the live set of commands.  Alternatively, it can issue the
+ * command and check for failure.
  */
 
 #define CXL_MEM_QUERY_COMMANDS _IOR(0xCE, 1, struct cxl_mem_query_commands)

-- 
2.39.1
