Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1DFC636CD
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Feb 2023 01:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjBBBXk (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 1 Feb 2023 20:23:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjBBBXj (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 1 Feb 2023 20:23:39 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCFB757B4
        for <linux-cxl@vger.kernel.org>; Wed,  1 Feb 2023 17:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675301010; x=1706837010;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=qB93D8gcQzE8bWgRKNIX9AGpk9Y6HJXYcaDXaCc5Lzg=;
  b=ApiMtdMviiwNh2vRHZL2wrTnm7Ufux3DNaOsFYR3sgJ9NyN1ZSd4+T+e
   O0448lauOx5/Tv9ymP9EXsxKOGdwnp6Iu5FwRwYb+7d8X+41xDjCmzSms
   kYy/C5sjiIQtd88jW1WXVFiVxR4qFRsd7+mRiE5Jcx8pE56om5Ve7HxkO
   CvInXCFLRJKuD8XFcTCvsmbkiYJomgrD94t1+KwUDLWy9xRTQkipLp1Hd
   yEtLAzsYsYChLZ3XWqXhSWPurqf60J1/B5r0c7/ERhBrwwC+zv4rBIjoM
   tgSfyXRjEozsIT1liX1vMhz038s908tjyxpeuxZFhAW9J6v0euAPl/R1R
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="308661522"
X-IronPort-AV: E=Sophos;i="5.97,266,1669104000"; 
   d="scan'208";a="308661522"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 17:23:29 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="993888775"
X-IronPort-AV: E=Sophos;i="5.97,266,1669104000"; 
   d="scan'208";a="993888775"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.212.15.11])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 17:23:28 -0800
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Wed, 01 Feb 2023 17:23:10 -0800
Subject: [PATCH v3 1/4] cxl/mem: Remove unused CXL_CMD_FLAG_NONE define
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221222-cxl-misc-v3-1-60d4f35e4b39@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1675301007; l=641;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=qB93D8gcQzE8bWgRKNIX9AGpk9Y6HJXYcaDXaCc5Lzg=;
 b=ahbwdgzr3SFWf+4H7vHU8wSqaPoZ7gYi0KOYLXNdLbHs6+MiRLXdZ7y24KpCzZNFeNWCtO/6c5xk
 UKIhumeNAVoJwxBwozYaykFLQsM9RhZJe1HQbx6NqFMsdEJhjp54
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
