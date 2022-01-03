Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067F1C433FE
	for <linux-cxl@archiver.kernel.org>; Mon,  3 Jan 2022 20:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiACULe (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 3 Jan 2022 15:11:34 -0500
Received: from mga12.intel.com ([192.55.52.136]:35284 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230076AbiACULe (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 3 Jan 2022 15:11:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641240694; x=1672776694;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eN99uTDmncVh4iL2OAQGr2qLxxRilTkwPt0bI8R2V3I=;
  b=FvNIu3hrRKlvGdO/CGg+yTyhheXeuoJp31EnclIMUh6F8zpg2NoABP+L
   getshAiWDS1jIisDOgGYc8qyaKz4MmCaRC7uTxwcuwAgOndIzAkz8jPsl
   3mR61E0m9OQ+K910kN/OmkeAANr7ZZrOv7s+Rlv6Sm9jW3D+ucznmD2AW
   3bF02JoH5f91WAM655OynRZ/mhBIX0+aHaCN0g11O+mrByNtkHafhorg4
   /5O38zLTQHtG/FaCj7MiVa50zBFB9EtvorFumbA9CBL+3tnxcj/aNRGkD
   mqwKEcrIlfY9z9yKpJxRVR3JyQhTLoQnOAicMYV1hWMbhFMp3+HxROHcz
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="222105776"
X-IronPort-AV: E=Sophos;i="5.88,258,1635231600"; 
   d="scan'208";a="222105776"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2022 12:11:34 -0800
X-IronPort-AV: E=Sophos;i="5.88,258,1635231600"; 
   d="scan'208";a="525709395"
Received: from alison-desk.jf.intel.com (HELO localhost) ([10.54.74.41])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2022 12:11:33 -0800
From:   alison.schofield@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Subject: [ndctl PATCH 3/7] libcxl: apply CXL_CAPACITY_MULTIPLIER to partition alignment field
Date:   Mon,  3 Jan 2022 12:16:14 -0800
Message-Id: <a5ff95fd75d42c29a15d285caee81cb9ea4c05d8.1641233076.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1641233076.git.alison.schofield@intel.com>
References: <cover.1641233076.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

The IDENTIFY mailbox command returns the partition alignment field
expressed in multiples of 256 MB. Use CXL_CAPACITY_MULTIPLIER when
returning this field.

This is in sync with all the other partitioning related fields using
the multiplier.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 cxl/lib/libcxl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index 715d8e4..85a6c0e 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -1086,7 +1086,7 @@ CXL_EXPORT unsigned long long cxl_cmd_identify_get_partition_align(
 	if (cmd->status < 0)
 		return cmd->status;
 
-	return le64_to_cpu(id->partition_align);
+	return le64_to_cpu(id->partition_align) * CXL_CAPACITY_MULTIPLIER;
 }
 
 CXL_EXPORT unsigned int cxl_cmd_identify_get_label_size(struct cxl_cmd *cmd)
-- 
2.31.1

