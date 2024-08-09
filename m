Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684C119046B
	for <linux-cxl@vger.kernel.org>; Fri,  9 Aug 2024 09:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723196578; cv=none; b=ZWv5NtRsr2kVSof81jxCAZ2iEFMb6d+IIPUZncOrvp7KWRd+kjZOlscEh9retiOpzjf4h03BqpwrDBikG7yot0aKOzRh7qb8WIa5DizMECI4GBSxk453UGYjskwwUJSgdCbKLBHjBuioo0YRrRjbDeWEicLZMdMDS+PIg6VsHAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723196578; c=relaxed/simple;
	bh=5wHJUbj/qpi7ln8rZMf3F/Yw2SVmz5Yu3lNcdC9xkpQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dR3fg6o4QpM9S59Xi6Mf683/a9xR6BJmnkB8pSM82d5NB0XU2ASiJ+EN+Gxtx2NbCy8IM8/gp1y2nM87/teABIkM0xqXohe1ZFvOfNFUlutnVKmjPag3slb5ofMlY/RIqYlrrK6l1qJkjghgM/uZIxZxgj7MUHfeRTrJrYpaqmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CO/qSGn0; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CO/qSGn0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723196576; x=1754732576;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5wHJUbj/qpi7ln8rZMf3F/Yw2SVmz5Yu3lNcdC9xkpQ=;
  b=CO/qSGn0H92dz/bxS4rDu/J5AYod6xdqAv/DJdf5tt82/HuVsZlUdAj8
   plD49v7Jfhzkv8kNqQIT1MwNkR6bqqnpE2Lfg0khmdPwuFxJZhMiMfXld
   2/tlchSdn+vHZKPKOpl3Gg027ohAHvfUho/r/9VW+hcy50pNgyUc3tp21
   +0hBermRqHoaryCRbnXaTCdPt+Xyyly9rA8C0BbMyZyUdb9qiBHhL/CXf
   +3Q/VgZe/e3VCklAKATx0HlUp9WKbQlgdlPHxok+89UKz8wgn6dQHC+Hc
   ZfdgDo3QQ38GUb8At6j422V2JEQBeeCOypOjMIHdUtjWSTxJU90OduYSr
   w==;
X-CSE-ConnectionGUID: 9a7xlEj2R/iDa7yY2O41Zw==
X-CSE-MsgGUID: i0mphYRITdeXUhRO3vv+MQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="38869636"
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="38869636"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 02:42:56 -0700
X-CSE-ConnectionGUID: xlozcvDuQ8euLuxaLQsVtA==
X-CSE-MsgGUID: wiiqhbU6R6GMf0ONsF1z6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="62352829"
Received: from tower.bj.intel.com ([10.238.157.70])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 02:42:53 -0700
From: Yanfei Xu <yanfei.xu@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	ming4.li@intel.com,
	yanfei.xu@intel.com
Subject: [v2 1/4] cxl/pci: Fix to record only non-zero ranges
Date: Fri,  9 Aug 2024 17:34:39 +0800
Message-Id: <20240809093442.646545-2-yanfei.xu@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240809093442.646545-1-yanfei.xu@intel.com>
References: <20240809093442.646545-1-yanfei.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function cxl_dvsec_rr_decode() retrieves and records DVSEC
ranges into info->dvsec_range[], regardless of whether it is
non-zero range, and the variable info->ranges indicates the number
of non-zero ranges. However, in cxl_hdm_decode_init(), the validation
for info->dvsec_range[] occurs in a for loop that iterates based
on info->ranges. It may result in zero range to be validated but
non-zero range not be validated, in turn, the number of allowed
ranges is to be 0. Address it by only record non-zero ranges.

Fixes: 560f78559006 ("cxl/pci: Retrieve CXL DVSEC memory info")
Signed-off-by: Yanfei Xu <yanfei.xu@intel.com>
---
 drivers/cxl/core/pci.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index a663e7566c48..2d69340134da 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -390,10 +390,6 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,
 
 		size |= temp & CXL_DVSEC_MEM_SIZE_LOW_MASK;
 		if (!size) {
-			info->dvsec_range[i] = (struct range) {
-				.start = 0,
-				.end = CXL_RESOURCE_NONE,
-			};
 			continue;
 		}
 
@@ -411,12 +407,10 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,
 
 		base |= temp & CXL_DVSEC_MEM_BASE_LOW_MASK;
 
-		info->dvsec_range[i] = (struct range) {
+		info->dvsec_range[ranges++] = (struct range) {
 			.start = base,
 			.end = base + size - 1
 		};
-
-		ranges++;
 	}
 
 	info->ranges = ranges;
-- 
2.39.2

