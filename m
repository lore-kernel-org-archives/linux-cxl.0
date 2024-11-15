Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09661D5ABE
	for <linux-cxl@vger.kernel.org>; Fri, 15 Nov 2024 18:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731696394; cv=none; b=E7w6oW6nN2rFnbyjs592h+MXjkQAygu4FpImXjc8xHtTq71XVBdTNz/+aeaorkRq+qaiqkQCdqBvoT7HJGAnQNHaQ2yVZwdBvBgUEzr6L8v6sFnDPzdrejl1y6dv5o2m5ELwvphK6pURylr2P0eUs2nurjE3x+P+r3hfFuuCC/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731696394; c=relaxed/simple;
	bh=YMdKA2RGM+4rycwcwrUUs1tZXNNeH8g15UUiSnncD/0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TE02agfB1sUthpEkfPSSfsOwRdE/6Ii0HUAZoYxI38MtQFb9o5tEyd4gDrDfoH0LiCijel7mdDexjkwXf/2nuzKBeOi8jWhc6eWU/XConO2I39wEBRCH6M+OVsbP4PJl6OERZMovP+6/inYmWwJDFmc4vpee/ccug8cYqKhfrQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZaggTBsV; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZaggTBsV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731696393; x=1763232393;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=YMdKA2RGM+4rycwcwrUUs1tZXNNeH8g15UUiSnncD/0=;
  b=ZaggTBsV2fVrpGq4QfTSWibrgxdJ2QFcljN+vvWxocfh7ci2vxnxBabl
   SIGigXEupjEowHODFTQmQKubJjoCJkAXjJkV6iQVkzehpbgHIB87xYzQr
   b+MNTl1SdokJNyvQAS8txgnBw6USePV0erpzU9SkEYN6IRGVIyLQG9/BR
   u1i186+gFVa9kZY8pC0eR0NiWARPhQjaWuLfVAoY4Nt+Pd6z9qgjgolDG
   0GBxNvzs/M46szSljVZbuh3gz4jfJZ7jSoDTIStDIU87Eb2oPMP+UBxk3
   EKIGkmF4fOXl34179d9juRQobsSQoVnFtgs8Z2iQyBxpaZHWuKx+Hzte4
   A==;
X-CSE-ConnectionGUID: cX6hASuHRyOPS4joSD/ykA==
X-CSE-MsgGUID: 0OWXlEdqQKW6UAJu4SBreg==
X-IronPort-AV: E=McAfee;i="6700,10204,11257"; a="31848430"
X-IronPort-AV: E=Sophos;i="6.12,157,1728975600"; 
   d="scan'208";a="31848430"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2024 10:46:29 -0800
X-CSE-ConnectionGUID: DnSobLYEQOS2HchTwCZRMQ==
X-CSE-MsgGUID: xpOkvP3lQrOHBBAQriFQeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,157,1728975600"; 
   d="scan'208";a="89392835"
Received: from ehanks-mobl1.amr.corp.intel.com (HELO localhost) ([10.125.108.112])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2024 10:46:28 -0800
From: Ira Weiny <ira.weiny@intel.com>
Date: Fri, 15 Nov 2024 12:46:20 -0600
Subject: [ndctl PATCH v3 2/9] ndctl/cxl/region: Report max size for region
 creation
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-dcd-region2-v3-2-585d480ccdab@intel.com>
References: <20241115-dcd-region2-v3-0-585d480ccdab@intel.com>
In-Reply-To: <20241115-dcd-region2-v3-0-585d480ccdab@intel.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>, 
 Jonathan Cameron <jonathan.cameron@Huawei.com>, Fan Ni <fan.ni@samsung.com>, 
 Navneet Singh <navneet.singh@intel.com>, 
 Dan Williams <dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
 linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev, 
 Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731696382; l=1059;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=YMdKA2RGM+4rycwcwrUUs1tZXNNeH8g15UUiSnncD/0=;
 b=xlhrpYAXv38PnwN9ztjfoZwGqOdXWArEcghreRSvqgyKMJl05RKr8QfOztRvYHcp+Md5VRzxg
 RYJwXeK9fsZDjdSnNBxKgkUCjc6SSzTcoXHXl3iEffRqLIylht+zmqJ
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

When creating a region if the size exceeds the max an error is printed.
However, the max available space is not reported which makes it harder
to determine what is wrong.

Add the max size available to the output error.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 cxl/region.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cxl/region.c b/cxl/region.c
index 96aa5931d2281c7577679b7f6165218964fa0425..207cf2d003148992255c715f286bc0f38de2ca84 100644
--- a/cxl/region.c
+++ b/cxl/region.c
@@ -677,8 +677,8 @@ static int create_region(struct cxl_ctx *ctx, int *count,
 	}
 	if (!default_size && size > max_extent) {
 		log_err(&rl,
-			"%s: region size %#lx exceeds max available space\n",
-			cxl_decoder_get_devname(p->root_decoder), size);
+			"%s: region size %#lx exceeds max available space (%#lx)\n",
+			cxl_decoder_get_devname(p->root_decoder), size, max_extent);
 		return -ENOSPC;
 	}
 

-- 
2.47.0

