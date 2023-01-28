Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E3EC38142
	for <linux-cxl@archiver.kernel.org>; Sat, 28 Jan 2023 00:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjA1AK2 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 27 Jan 2023 19:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjA1AK1 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 27 Jan 2023 19:10:27 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D54079201
        for <linux-cxl@vger.kernel.org>; Fri, 27 Jan 2023 16:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674864602; x=1706400602;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=xK757HYbD5E5voYrhmr4eBRtiUEU73YoAE8Qb5jBj90=;
  b=FlILrfg3880hwssgT8fWwLS4g8pwXDdDrL5PU/wUXR3nGzKt3Jgp3z0X
   RIJ0U3F6OvZhysXeBvOGJRPxsv75+k6EREDV5Dzg+/EouD/epI1Dinq4z
   vlWTAPh4LkhUn8xI/56yHZtcXOo0NgmPmlucbgKQf+dgm1wjIZHnOcdSu
   58jKbFqH3NMzhBWqVxjAvhW9tSdWINOVOZ+jA8dJerDoU46S8/TvfzXdc
   ny2Etgjsw0rMrbmC6PpWJrqSgqW+nI0EMH6ggRK7dUuY3cgca1mx8Uy6E
   /ikZWqZRMKx/WlF/LXDJvJXFMC2prYM+2vLyTuEbK6/+zOCumqFDcL2sh
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="389608222"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="389608222"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 16:09:46 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="656793053"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="656793053"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.212.64.226])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 16:09:46 -0800
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Fri, 27 Jan 2023 16:09:38 -0800
Subject: [PATCH v2 1/4] cxl/mem: Remove unused CXL_CMD_FLAG_NONE define
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221222-cxl-misc-v2-1-60403cc37257@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1674864584; l=631;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=xK757HYbD5E5voYrhmr4eBRtiUEU73YoAE8Qb5jBj90=;
 b=c+EGENkTw8yi+Vf1VbTu3Uq3FWDS1g34Z92ho47u1Fz18GhGbZDXrsBVG34rEZnZMd/jn8Sy9/4J
 gZ8tevh3DcxJ8/EFmcFo8R/zKog+4GlCh0uXt/+8uKGZpnjRVkWh
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

CXL_CMD_FLAG_NONE is not used, remove it.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for v2:
	Pick up tag
---
 drivers/cxl/cxlmem.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index ab138004f644..2d85776236dd 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -393,7 +393,6 @@ struct cxl_mem_command {
 	struct cxl_command_info info;
 	enum cxl_opcode opcode;
 	u32 flags;
-#define CXL_CMD_FLAG_NONE 0
 #define CXL_CMD_FLAG_FORCE_ENABLE BIT(0)
 };
 

-- 
2.39.1
