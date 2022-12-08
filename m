Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F526C4332F
	for <linux-cxl@archiver.kernel.org>; Thu,  8 Dec 2022 21:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiLHV3b (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 8 Dec 2022 16:29:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiLHV32 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 8 Dec 2022 16:29:28 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10315A507A
        for <linux-cxl@vger.kernel.org>; Thu,  8 Dec 2022 13:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670534968; x=1702070968;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QAJFQRhtPwzwpUKZtzMWwK4wTVkkYfpEnNbLpyK/lBE=;
  b=Ba621qUfXq25xbpeYs4tU0QDpNj/dvmchB5NiVVtDzeZdhcPszWelnB2
   z4pZ+CX9y6UiFB2kW/k+I+1/u2vN55Xw+1W7S1LqPzUbkjhNoPH+/O7Uz
   ZLk+7Ali10rg9oDhN1Ia/U1+moKBgsG9bLKcXJ8ThBCcLdr7BmL08NTeb
   rtcl63hJ2T4/2brHq5pbFWIbfsJxmTQszVPDAMj8fInKvDHMIBDdIBxLi
   WNxuZgOtFSXD+YfEaAilLJLiJ0HNtut9TuiBR6PSagrbJgoD88HdpPjDr
   gavkhDZ5WoCOsHzve68Aro+vbLobD4UwMZRzGbVUclh+mR2lCtz4/nSNY
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="304950801"
X-IronPort-AV: E=Sophos;i="5.96,228,1665471600"; 
   d="scan'208";a="304950801"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2022 13:29:27 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="649323145"
X-IronPort-AV: E=Sophos;i="5.96,228,1665471600"; 
   d="scan'208";a="649323145"
Received: from kputnam-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.251.25.149])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2022 13:29:27 -0800
Subject: [ndctl PATCH v2 15/18] cxl/Documentation: Fix whitespace typos in
 create-region man page
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     vishal.l.verma@intel.com, alison.schofield@intel.com,
        nvdimm@lists.linux.dev, vishal.l.verma@intel.com
Date:   Thu, 08 Dec 2022 13:29:26 -0800
Message-ID: <167053496662.582963.12739035781728195815.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <167053487710.582963.17616889985000817682.stgit@dwillia2-xfh.jf.intel.com>
References: <167053487710.582963.17616889985000817682.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


---
 Documentation/cxl/cxl-create-region.txt |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/cxl/cxl-create-region.txt b/Documentation/cxl/cxl-create-region.txt
index 6b740d5b8d96..e0e6818cfdd1 100644
--- a/Documentation/cxl/cxl-create-region.txt
+++ b/Documentation/cxl/cxl-create-region.txt
@@ -28,7 +28,7 @@ be emitted on stderr.
 EXAMPLE
 -------
 ----
-#cxl create - region - m - d decoder0 .1 - w 2 - g 1024 mem0 mem1
+#cxl create-region -m -d decoder0.1 -w 2 -g 1024 mem0 mem1
 {
   "region":"region0",
   "resource":"0xc90000000",

