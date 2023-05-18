Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21977C77B7D
	for <linux-cxl@archiver.kernel.org>; Thu, 18 May 2023 02:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjERCqg (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 17 May 2023 22:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjERCqf (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 17 May 2023 22:46:35 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D5A44BF
        for <linux-cxl@vger.kernel.org>; Wed, 17 May 2023 19:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684377973; x=1715913973;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=+qdtcDX7aPtUFG16xTDOpRYYrPeh1b8whv2sXdCmkMg=;
  b=QSaNJ/94QkEepeumsBJpsWMI/ftuws0ZFB9GV/QVVXNW/Sa5SwL8k0zH
   Pon66k4La8rc6uLgwGg4OfKekdo2ac1fjpdCfLJ1+MEnjD0O2d8Je3eVw
   AQ8DxZEZr7j5jL4DvMxC+548q+Y8DTS4IkeD7POe0jXkPSg2hBYGvqdnd
   VXbWNmqr57wsO2QnQg6mm0bsDJQsgVBNyspxodHV3LY0Q+51UI9aLQMAt
   qK38v7N1lArB8pvsr2mqhNtKi2AMttZN6bdgDJSK0JrQCAhh5hVwh/zn9
   RRUEnfI/2VwqjoMNp0WhoG0SLIIxHpejZTNUI20E3mXYllCBSyW2/Sx4j
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="380147117"
X-IronPort-AV: E=Sophos;i="5.99,284,1677571200"; 
   d="scan'208";a="380147117"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 19:46:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="652466748"
X-IronPort-AV: E=Sophos;i="5.99,284,1677571200"; 
   d="scan'208";a="652466748"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.209.143.168])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 19:46:07 -0700
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Wed, 17 May 2023 19:45:58 -0700
Subject: [PATCH RFC 5/5] hw/cxl: Add UIO HDM decoder register fields
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230517-rfc-type2-dev-v1-5-6eb2e470981b@intel.com>
References: <20230517-rfc-type2-dev-v1-0-6eb2e470981b@intel.com>
In-Reply-To: <20230517-rfc-type2-dev-v1-0-6eb2e470981b@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
        Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.13-dev-9a8cd
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684377956; l=2286;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=+qdtcDX7aPtUFG16xTDOpRYYrPeh1b8whv2sXdCmkMg=;
 b=1qJL70bed0jThaHUc+ucsX3tY2DnXquwk6PxAVz4qUOpUvEduJBAk0C6X1XNMpJZ9VieRM+dh
 z7G4wmZ4T7NAM6KU+UIXl7us0rSNk2ByujqzAbOiftoX55N4kSxj3EO
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

HDM decoders optionally support Unordered IO (UIO) access.  Devices
indicate UIO support by setting the capable bit.  Software can then set
up to UIO decoder count HDM's as UIO enabled when configuring the HDMs
on the device.

Define the UIO capable bit and decoder count.  Default type 2 devices to
support UIO for testing.

Not-Yet-Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 hw/cxl/cxl-component-utils.c   | 6 ++++++
 include/hw/cxl/cxl_component.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index a9efa252b4ae..252b2beb2110 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -173,6 +173,12 @@ static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
     ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, INTERLEAVE_256B, 1);
     ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, INTERLEAVE_4K, 1);
     ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, POISON_ON_ERR_CAP, 0);
+    if (type == CXL3_TYPE2_DEVICE) {
+        ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, UIO_CAPABLE, 1);
+        ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, UIO_DECODER_CNT,
+                         decoder_count);
+    }
+
     ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_GLOBAL_CONTROL,
                      HDM_DECODER_ENABLE, 0);
     write_msk[R_CXL_HDM_DECODER_GLOBAL_CONTROL] = 0x3;
diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
index a5b5512aed94..7c24e699ef80 100644
--- a/include/hw/cxl/cxl_component.h
+++ b/include/hw/cxl/cxl_component.h
@@ -162,6 +162,8 @@ REG32(CXL_HDM_DECODER_CAPABILITY, CXL_HDM_REGISTERS_OFFSET)
     FIELD(CXL_HDM_DECODER_CAPABILITY, INTERLEAVE_256B, 8, 1)
     FIELD(CXL_HDM_DECODER_CAPABILITY, INTERLEAVE_4K, 9, 1)
     FIELD(CXL_HDM_DECODER_CAPABILITY, POISON_ON_ERR_CAP, 10, 1)
+    FIELD(CXL_HDM_DECODER_CAPABILITY, UIO_CAPABLE, 13, 1)
+    FIELD(CXL_HDM_DECODER_CAPABILITY, UIO_DECODER_CNT, 16, 4)
 REG32(CXL_HDM_DECODER_GLOBAL_CONTROL, CXL_HDM_REGISTERS_OFFSET + 4)
     FIELD(CXL_HDM_DECODER_GLOBAL_CONTROL, POISON_ON_ERR_EN, 0, 1)
     FIELD(CXL_HDM_DECODER_GLOBAL_CONTROL, HDM_DECODER_ENABLE, 1, 1)

-- 
2.40.0

