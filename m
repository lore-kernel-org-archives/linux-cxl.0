Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBF1C636CD
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Feb 2023 01:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjBBBXt (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 1 Feb 2023 20:23:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbjBBBXs (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 1 Feb 2023 20:23:48 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5176A728
        for <linux-cxl@vger.kernel.org>; Wed,  1 Feb 2023 17:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675301019; x=1706837019;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=7PhF1Q7E2qMzGGQiJjo+QsGen/5l8XdaAtvrNQSJs8o=;
  b=YlLuOUDNAkrL6YhMIeb7Nxya+s3X3s96LVhud/m76vUInZ8NY2DQfNTt
   /V6XHPMwd2/+DZq+19yyriubFFw+rsvlJ37WQiPhwcY+lOWbP0ag3MLpu
   uCml/gZWk/O4oksO/LG/r69Q/Imk4JrSHuVtPV1GrFK5Atx2jM0wWvJtk
   lSUDKaOr4YD7MIxSu5M/kqOWY/PfYPm8sTFHJcotuctkPSHP5mX2sHx6v
   9xndNeJpJHRhrss7bWsf3kJR9GuSmUtJyt9TqaGQhx5r0Pns0npXHdQsK
   Ha8ju8Jw4a+Hwv6t69xd82DiGOtLmHxmUEVKsLPmUOrE9Zu62LCGtDL3F
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="308661535"
X-IronPort-AV: E=Sophos;i="5.97,266,1669104000"; 
   d="scan'208";a="308661535"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 17:23:30 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="993888789"
X-IronPort-AV: E=Sophos;i="5.97,266,1669104000"; 
   d="scan'208";a="993888789"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.212.15.11])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 17:23:30 -0800
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Wed, 01 Feb 2023 17:23:13 -0800
Subject: [PATCH v3 4/4] cxl/mem: Fix UAPI command comment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221222-cxl-misc-v3-4-60d4f35e4b39@intel.com>
References: <20221222-cxl-misc-v3-0-60d4f35e4b39@intel.com>
In-Reply-To: <20221222-cxl-misc-v3-0-60d4f35e4b39@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1675301007; l=1434;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=7PhF1Q7E2qMzGGQiJjo+QsGen/5l8XdaAtvrNQSJs8o=;
 b=THWGImun12SQ1WKHPTGf0vfmTUuDh30U8ebHd9m6M+Kahakmw8Nrj4z0oyKBx6KAL4YZuOiObrKs
 cMu3So7YCohHD+xJKHgK26sAOd6JHeobOAboHeMw/8rgD7c8BJ8y
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

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for v3:
	Adjust commit message for updated query command behavior.
---
 include/uapi/linux/cxl_mem.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
index 4aee64b7cc1a..b1d41e3be4e5 100644
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
