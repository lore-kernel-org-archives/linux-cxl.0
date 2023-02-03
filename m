Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D08CC63797
	for <linux-cxl@archiver.kernel.org>; Fri,  3 Feb 2023 01:05:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbjBCBFb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 2 Feb 2023 20:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232866AbjBCBFa (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 2 Feb 2023 20:05:30 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BFF470AE
        for <linux-cxl@vger.kernel.org>; Thu,  2 Feb 2023 17:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675386329; x=1706922329;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=qB93D8gcQzE8bWgRKNIX9AGpk9Y6HJXYcaDXaCc5Lzg=;
  b=AIo0EVK2m/1Gkcx2Zi7hVJqNgk8fYlbTN3Iy/ACceHi1UCAiZgenkUUy
   plFJ8UTj2DMTq4kN/FehdYqeQpBE51Cw73nHCe7cB1hgnZf1P685LRWXZ
   V84P6rYbKUHlIUqGmqAEV+Wtcxn3izOPZsaS+WOmQA5Ho2rAZQ2UzoeyE
   jFEcunaZ7AEOAX+F7PXmNGe/Jr4BYCxQ0+xieNxPd9ETwahmgZK/hUSQF
   Mme6ZTR6ojdYHZQFrcZOPh8SjNWHGyvyQDPiYrf11auECkr+RM6izsF/5
   UFbnbv/lEPuelt16JQllXLxm8HtnPtflktKdOkdMaTwPuN2+EDPwkeZf4
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="393215317"
X-IronPort-AV: E=Sophos;i="5.97,269,1669104000"; 
   d="scan'208";a="393215317"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 17:04:37 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="839412544"
X-IronPort-AV: E=Sophos;i="5.97,269,1669104000"; 
   d="scan'208";a="839412544"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.212.229.82])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 17:04:37 -0800
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Thu, 02 Feb 2023 17:04:24 -0800
Subject: [PATCH v4 1/4] cxl/mem: Remove unused CXL_CMD_FLAG_NONE define
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221222-cxl-misc-v4-1-62f701c1cdd1@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1675386275; l=641;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=qB93D8gcQzE8bWgRKNIX9AGpk9Y6HJXYcaDXaCc5Lzg=;
 b=NLscQIUsOFf1KqCP9u174u4OsarPf5ioNrqCLlMivQpSZ/9xVr7zSgxhUGdnf5LOqSQeaUHKXrnq
 BxXnzwpqDq5vi83Kdd1GyJ6CR9IRMYzWKaHu053aACYE64Abldi4
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

CXL_CMD_FLAG_NONE is not used, remove it.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
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
