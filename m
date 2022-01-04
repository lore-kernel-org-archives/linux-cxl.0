Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A96C433EF
	for <linux-cxl@archiver.kernel.org>; Tue,  4 Jan 2022 23:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235474AbiADXQA (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 4 Jan 2022 18:16:00 -0500
Received: from mga14.intel.com ([192.55.52.115]:40421 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235171AbiADXP7 (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Tue, 4 Jan 2022 18:15:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641338159; x=1672874159;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=S1o6r96fELfVNKBlAzseju5isD6GQqERt+JC/gxshQs=;
  b=mkgpV9KT2KV3K2tPRJu02P0OIQ8Hbz8KrDv17GG6XHQrjN2PPgzb6jgz
   GyH5NMq1Gy32ilmdvP9LqT1tlZR+EDDHgQga7b0xpw1/JeE3Kd157xeT5
   Kf7X9CRbGzwDf9HfySCQ4vpEWuS6aMfWe7ky2YkI8C3E89YS9HvsPsoeY
   NXpLYr6iP5xUSj2ldlgLnyUMM2fbCZy/mwaqa9uQ4DeJiy1Jz0r05lhJK
   JQnuliGBSpcOMzEssvYAVqMgG59mEujg0NFaGbUgzz6hcylmZAo9iY5z+
   gBBs5A21Zj9Uv0MGmv4MlEniv5N3rytEn+5KkEiJbF58vwdyCigJy1+7/
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="242528364"
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="242528364"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 15:15:59 -0800
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="512679784"
Received: from alison-desk.jf.intel.com (HELO localhost) ([10.54.74.41])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 15:15:59 -0800
From:   alison.schofield@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH] cxl/mbox: Use __le32 in get,set_lsa mailbox structures
Date:   Tue,  4 Jan 2022 15:21:14 -0800
Message-Id: <20220104232114.789948-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

CXL specification defines these as little endian.

Fixes: 60b8f17215de ("cxl/pmem: Translate NVDIMM label commands to CXL label commands")
Reported-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/cxlmem.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 8d96d009ad90..eae2a687ea5d 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -221,13 +221,13 @@ struct cxl_mbox_identify {
 } __packed;
 
 struct cxl_mbox_get_lsa {
-	u32 offset;
-	u32 length;
+	__le32 offset;
+	__le32 length;
 } __packed;
 
 struct cxl_mbox_set_lsa {
-	u32 offset;
-	u32 reserved;
+	__le32 offset;
+	__le32 reserved;
 	u8 data[];
 } __packed;
 

base-commit: 53989fad1286e652ea3655ae3367ba698da8d2ff
-- 
2.31.1

