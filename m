Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A843D8916;
	Fri,  3 Apr 2026 20:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775249977; cv=none; b=m3FDBEOmwvfoxcJmXEvRPpxV70n6dY1Opq1oUlACJz2WTtAvyYxdrvphK0rBNfWV15sxJi2BppqPIhb+1MZC+1ShTrLPIKSgSuw89Lj/LsKIteDWmD2pVFn0KxMxqZf2lxfYZut/KGOY9FVT867lJrLkMIxoSn3DWRornFzk2Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775249977; c=relaxed/simple;
	bh=hyQKvQwp0GaqCbyQ4ZH4jFd7NtavtNNrGg227z+weo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T54jZasWe9DC5XsQJQ/Yt+KI3zkaxfbCaAYvWqG72o6o8hxRNxCafE01uYGBPLzLh9At278vdu77W7OiKahouruzLV8GurjRBOrPVrE3FW4LWnsYGXZUqde6S9g1cKPar/OptT9kOvbtlpUEO6N+HGD0TtBO0TdgRbMdjUp82A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CKBjnZVq; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CKBjnZVq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775249976; x=1806785976;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hyQKvQwp0GaqCbyQ4ZH4jFd7NtavtNNrGg227z+weo4=;
  b=CKBjnZVqazPNvvAs3r9jKCqTdB+FzZxxoYB2efwiWGGlbJup5Iv6lKgd
   AzFrBymBXbgH/JatKn7+Bl64uY5XjBsgIuURWm5lbWT9f+7GNkLoi47xr
   X/BxFgeTdye+6pG2sIe5qVP5qWw3ieQsBxc2DGyFCqwJOkN+JsWvhhT1+
   yGUb4llKX4+dkitYEPxnv+c7Ab7Kix93TCnVSE272o+UmC2svmKH1W3iS
   haFLZMRS0T69QRpsntFw0ECSFvMFXMN9+Dm640fqVz42GBGt9zEp9Kqs6
   r0ykJKCQib9YMK8EIZsOZ+9gcv1hV2wbQ0YO3d31a9GmhWnFI/2hCk+Bj
   Q==;
X-CSE-ConnectionGUID: GsyDkNBpSNy8MDbmupGQfg==
X-CSE-MsgGUID: vXAyKcxTQ4ez0sTMVHOAlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11748"; a="76281470"
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="76281470"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 13:59:34 -0700
X-CSE-ConnectionGUID: y8g+Ce2jTiKDL7XeavsahA==
X-CSE-MsgGUID: lIDsgZwKTOOiqzznUMDMtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="265280480"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by orviesa001.jf.intel.com with ESMTP; 03 Apr 2026 13:59:33 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: dave.jiang@intel.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alejandro.lucero-palau@amd.com
Subject: [RFC PATCH 2/4] cxl/region: Move region lock error code to -EBUSY
Date: Fri,  3 Apr 2026 14:00:48 -0700
Message-ID: <20260403210050.1058650-3-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403210050.1058650-1-dan.j.williams@intel.com>
References: <20260403210050.1058650-1-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

-EPERM is permission check. Root is permitted to manage a region, but at
any given point in time the region may be busy. In preparation for adding
another region operation failure due to region lock, move the existing
error indication to -EBUSY.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/region.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 3edb5703d6de..600c96be0888 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -426,7 +426,7 @@ static ssize_t commit_store(struct device *dev, struct device_attribute *attr,
 	}
 
 	if (test_bit(CXL_REGION_F_LOCK, &cxlr->flags))
-		return -EPERM;
+		return -EBUSY;
 
 	rc = queue_reset(cxlr);
 	if (rc)
-- 
2.53.0

