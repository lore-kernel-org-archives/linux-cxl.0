Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750F2C77B7F
	for <linux-cxl@archiver.kernel.org>; Thu, 18 May 2023 02:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjERCqD (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 17 May 2023 22:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjERCqC (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 17 May 2023 22:46:02 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140BD3C02
        for <linux-cxl@vger.kernel.org>; Wed, 17 May 2023 19:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684377961; x=1715913961;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=ALosJLPeK/xQ//Ur5NIceXWhZEbxkQaR0DQfbRf0RQM=;
  b=LN9hBJSfIeyF/bFp7tB1zgsCbUBBs3Wp0osAOUykokQA++cP1xfaa+qI
   oAvlixtQ4JgnrxkAJpJAmQH9i5qFXqoykFwxmYCDBzs2h5ng87fXopaMF
   dantWhvSGOr3UU0nhDOCXK2LY7gx8DXYv6859GxwOTIhJUR4wvVNAlOxm
   ta9kMuZlxDZeDAkKkf2L+rxDtTuy/r7QhBREQ8SD8Fmxrt8bHVgQfeAlR
   P8p2ozL+wBU7WKmVKLQG2DQWmp0QRafa5xaIOUC7AS4Ia6Z3icKxYgfc7
   fh3GwiKTzf7Qen3UFUm2WMDzEWkeHyXL8gbppajnRLt+WPFh5760iZxSo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="380147095"
X-IronPort-AV: E=Sophos;i="5.99,284,1677571200"; 
   d="scan'208";a="380147095"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 19:46:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="652466710"
X-IronPort-AV: E=Sophos;i="5.99,284,1677571200"; 
   d="scan'208";a="652466710"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.209.143.168])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 19:45:59 -0700
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Wed, 17 May 2023 19:45:54 -0700
Subject: [PATCH RFC 1/5] hw/cxl: Use define for build bug detection
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230517-rfc-type2-dev-v1-1-6eb2e470981b@intel.com>
References: <20230517-rfc-type2-dev-v1-0-6eb2e470981b@intel.com>
In-Reply-To: <20230517-rfc-type2-dev-v1-0-6eb2e470981b@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
        Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.13-dev-9a8cd
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684377956; l=1245;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=ALosJLPeK/xQ//Ur5NIceXWhZEbxkQaR0DQfbRf0RQM=;
 b=PTXLvgQFzxf6kFAXs/JRAWGbNfCHUPHulVnutVi+rrKIFhXkSG47HH5dDRPWhMLgGJcr8nGGR
 KT5/B7ZTijJDdHPdhFyfIS7WU2ze14Xt2rLktKwvF3c8GLqVY5beLQx
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Magic numbers can be confusing.

Use the range size define for CXL.cachemem rather than a magic number.
Update/add spec references.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 include/hw/cxl/cxl_component.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
index 52b6a2d67f40..bca2b756c202 100644
--- a/include/hw/cxl/cxl_component.h
+++ b/include/hw/cxl/cxl_component.h
@@ -10,7 +10,7 @@
 #ifndef CXL_COMPONENT_H
 #define CXL_COMPONENT_H
 
-/* CXL 2.0 - 8.2.4 */
+/* CXL 3.0 - 8.2.3 */
 #define CXL2_COMPONENT_IO_REGION_SIZE 0x1000
 #define CXL2_COMPONENT_CM_REGION_SIZE 0x1000
 #define CXL2_COMPONENT_BLOCK_SIZE 0x10000
@@ -173,7 +173,9 @@ HDM_DECODER_INIT(3);
     (CXL_IDE_REGISTERS_OFFSET + CXL_IDE_REGISTERS_SIZE)
 #define CXL_SNOOP_REGISTERS_SIZE   0x8
 
-QEMU_BUILD_BUG_MSG((CXL_SNOOP_REGISTERS_OFFSET + CXL_SNOOP_REGISTERS_SIZE) >= 0x1000,
+/* CXL 3.0 8.2.3 Table 8-21 */
+QEMU_BUILD_BUG_MSG((CXL_SNOOP_REGISTERS_OFFSET +
+                    CXL_SNOOP_REGISTERS_SIZE) >= CXL2_COMPONENT_CM_REGION_SIZE,
                    "No space for registers");
 
 typedef struct component_registers {

-- 
2.40.0

