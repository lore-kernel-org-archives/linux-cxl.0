Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36AB6C46467
	for <linux-cxl@archiver.kernel.org>; Tue, 27 Dec 2022 14:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiL0OwW (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 27 Dec 2022 09:52:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiL0OwV (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 27 Dec 2022 09:52:21 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7185B2C4
        for <linux-cxl@vger.kernel.org>; Tue, 27 Dec 2022 06:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672152740; x=1703688740;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=/AnCDDXekLJWQdFDzrW3G5Aups/eA3ZFrlACCUraY1o=;
  b=VYDJYfzczfv+JsveFPDAZnbBItgKbtjqqSk7JYfDaW164eD94ZTu9fQz
   9Me0pWc7iQ7w58XipATvrbXQyRLBeuHD1VdTrX/iTZm/LHg9EtMleSbjl
   aiAPtB8N8t+2oGbdtUsVYjv2JN3y0kx5RFYmkJBd4NbPUjdx6EbyI68Vp
   GoV6wkwN+b6etTtv6O1OBpcdonoCzKcBltK7se3vVtfqZ5oxiMvUzdX07
   LZGJeMkKQOGtS6HBGUGuehGENHSFOIZBbaW9mncIRZrGXyx5ke8Akv1+6
   X4+JN7fj8FHt68jOlpy5tvTyhFeVj/afl1aP3YBx8TFVIPHznQj/i0kW6
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="300398220"
X-IronPort-AV: E=Sophos;i="5.96,278,1665471600"; 
   d="scan'208";a="300398220"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2022 06:52:20 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="777175367"
X-IronPort-AV: E=Sophos;i="5.96,278,1665471600"; 
   d="scan'208";a="777175367"
Received: from yguan1-mobl.amr.corp.intel.com (HELO localhost) ([10.212.93.223])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2022 06:52:19 -0800
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Tue, 27 Dec 2022 06:52:10 -0800
Subject: [PATCH 2/3] cxl/mem: Remove unused CXL_CMD_FLAG_NONE define
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221222-cxl-misc-v1-2-9343bab16e72@intel.com>
References: <20221222-cxl-misc-v1-0-9343bab16e72@intel.com>
In-Reply-To: <20221222-cxl-misc-v1-0-9343bab16e72@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Jiang, Dave" <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.11.0-dev-e429b
X-Developer-Signature: v=1; a=ed25519-sha256; t=1672152737; l=532;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=/AnCDDXekLJWQdFDzrW3G5Aups/eA3ZFrlACCUraY1o=;
 b=Qp5/i84K1fuDoROd8PRzuRdEhwqu/G9Tp7CK3AGTUVbfsaKxIz4jB4lK3dg9SOIp94Df20l2IK/S
 7tWNsgr2B2uW9UTDliLb+W1aTBb3BmTRjX1nDF5jAD5vtgeOsoDk
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

CXL_CMD_FLAG_NONE is not used, remove it.

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
2.38.1
