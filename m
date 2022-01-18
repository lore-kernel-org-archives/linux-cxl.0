Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF99C4332F
	for <linux-cxl@archiver.kernel.org>; Tue, 18 Jan 2022 20:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349122AbiARUUb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 18 Jan 2022 15:20:31 -0500
Received: from mga07.intel.com ([134.134.136.100]:58421 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349138AbiARUUb (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Tue, 18 Jan 2022 15:20:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642537231; x=1674073231;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+vOG/MGG3HFOK6Q+Ameq9bNgHeIQFxU/FTVdUSHEkes=;
  b=C8S1hpq8Lb5TGRhmm/NQAhxVTVByHJjDZ3bEcnhY3C3DZPhj2RSEKqbH
   vJcA6DwcOS0Ps7nIvQkK4AyVAEuDEcFnkE8VKi4DGlAQZAt1bqb91unF4
   gbZ72JWncCvwOBNWNiepNuVt6Pc4thCrJWO8yIxIrtUd2jc5XAYK4Dyb8
   bPaz0ACgRH7jqoTkEWWtlJzYK627HmRKZvIipkYZNNYWLIDbyCX3GIKgB
   wAJEv5rRdk7qkSltr9yV/KdoR1Syeebq1daXdd7bBL2fzkj5Hz3D35iYF
   NjgY3T1mtdUG8FUqN5N/ZXHpK50mmzya3DPp5HiZxARFluJY4KyT8+A4E
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="308250311"
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="308250311"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 12:20:31 -0800
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="671953858"
Received: from alison-desk.jf.intel.com (HELO localhost) ([10.54.74.41])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 12:20:30 -0800
From:   alison.schofield@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Subject: [ndctl PATCH v3 3/6] libcxl: return the partition alignment field in bytes
Date:   Tue, 18 Jan 2022 12:25:12 -0800
Message-Id: <6e295b9c3ab676906e6f58588b54071ea968e0cd.1642535478.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1642535478.git.alison.schofield@intel.com>
References: <cover.1642535478.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Per the CXL specification, the partition alignment field reports
the alignment value in multiples of 256MB. In the libcxl API, values
for all capacity fields are defined to return bytes.

Update the partition alignment accessor to return bytes so that it
is in sync with other capacity related fields.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 cxl/lib/libcxl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index 1fd584a..5b1fc32 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -1089,7 +1089,7 @@ CXL_EXPORT unsigned long long cxl_cmd_identify_get_partition_align(
 	if (cmd->status < 0)
 		return cmd->status;
 
-	return le64_to_cpu(id->partition_align);
+	return le64_to_cpu(id->partition_align) * CXL_CAPACITY_MULTIPLIER;
 }
 
 CXL_EXPORT unsigned int cxl_cmd_identify_get_label_size(struct cxl_cmd *cmd)
-- 
2.31.1

