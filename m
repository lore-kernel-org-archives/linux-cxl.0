Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDABFC61DA7
	for <linux-cxl@archiver.kernel.org>; Sat, 28 Jan 2023 00:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjA1AKi (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 27 Jan 2023 19:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjA1AKg (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 27 Jan 2023 19:10:36 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1901961B7
        for <linux-cxl@vger.kernel.org>; Fri, 27 Jan 2023 16:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674864627; x=1706400627;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=eR6Sb3Krrjwo+AFS/sYpWntPZQmMvUise5SzB9GKdCE=;
  b=dG+qfGp1HhvKjQfXwKlOZLjd7mZoLXNAm1FSYaKe4ih5VlJ8Pmffbdd9
   OsKHFFIJ1OL/AWl2lAFGqXwxBx/9ojO6d+TmevhtRF+xzMRdKZu/LBRCB
   cv6h7dXEbCcTZerP18vzCQ5CDH8fuUhOXDqBMH9IcLv8wChk7Je/17Pwn
   Wx5NdpShF5QDaX7qaPBxhefi9lhlVPjiJiDQEknhpvefsGBvddbuBmgHh
   dE/QStTSskIvRZVeU7kw8S37+6y43Nf58ukkVVRUAxHQJvU99pFxlq+OO
   k4GpQoRM3ZvnciLRhZW2Ue5jkxvemKLRtdpfnVeBIcoyaRLS+8pnTq+ov
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="389608235"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="389608235"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 16:09:50 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="656793065"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="656793065"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.212.64.226])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 16:09:49 -0800
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Fri, 27 Jan 2023 16:09:41 -0800
Subject: [PATCH v2 4/4] cxl/mem: Fix UAPI command comment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221222-cxl-misc-v2-4-60403cc37257@intel.com>
References: <20221222-cxl-misc-v2-0-60403cc37257@intel.com>
In-Reply-To: <20221222-cxl-misc-v2-0-60403cc37257@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1674864584; l=1448;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=eR6Sb3Krrjwo+AFS/sYpWntPZQmMvUise5SzB9GKdCE=;
 b=/fNvIpkzxDz36Wtuwe4qldbKXaeeETee4DajrlYe8ardzP29LPZ57mvTb4SinrHDqZ1WI4hj80Op
 xojAsWJXAVoVPzvrROjsbupBYY3zVKOFHwQOMCS0OSUGpz2fImhq
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The command comment had grammatical errors.  In an attempt to fix those
it was noted that the comment and the query command were not in sync.

Now that the query command accounts for excluded and device unsupported
commands.  Update the kdoc and fix the grammatical errors.

[1] https://lore.kernel.org/all/63b4ec4e37cc1_5178e2941d@dwillia2-xfh.jf.intel.com.notmuch/

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for v2:
	Add patch to fix the query command and adjust the comment for
	that support.
---
 include/uapi/linux/cxl_mem.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
index 459a3f7f764b..c58101437ea7 100644
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
