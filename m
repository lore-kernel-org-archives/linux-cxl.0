Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF18E36EAA8
	for <linux-cxl@vger.kernel.org>; Wed, 22 Jul 2026 20:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784753593; cv=none; b=qE6c7XsSCpk/aQMnGMdLq1BNhSQvFIjBcQLHPtsrNN7hrNIrmEnKrvEvaL2MoHVRLBgDxdQ1g6jy4Sct49wmonANnwM7hlKGSTiahxDxozAc1+bU2fri3QEpc/xEWsaq0yzs8yfFH7acuAUg9gF8NZf1K70TaFzYBLABeU5iKQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784753593; c=relaxed/simple;
	bh=BDPqKXMQ0IagP7RclhNR5u7kLOobvYI3QY5vG5KLOE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e89aRDzlFVC+mtH4OizX8jAj7PN5f+MYbt4RBqG8e7o3qHd4UTNHNVUgRJisd1s48v/gO01LllNmMaAMwKMaBCiNz92oSLH+F/swggY+Gxt9xrRkjnfPbn4/jUX+8kSFyS8Nqbs+tWUX0z3l4ZmOGZ3Dy46cNc2a8stpRUIkVhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 900A51F000E9;
	Wed, 22 Jul 2026 20:53:11 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: djbw@kernel.org,
	dave@stgolabs.net,
	jic23@kernel.org,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	sashiko-bot@kernel.org
Subject: [PATCH 3/3] cxl/memdev: Don't mask an earlier partition's poison query error
Date: Wed, 22 Jul 2026 13:53:02 -0700
Message-ID: <20260722205303.3184787-4-dave.jiang@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260722205303.3184787-1-dave.jiang@intel.com>
References: <20260722205303.3184787-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cxl_get_poison_by_memdev() reassigns rc every partition iteration with
no early exit, so an error from an earlier partition (e.g. -EIO on
partition 0) is overwritten when a later partition succeeds, hiding the
failure from the trigger_poison_list sysfs write.

Break on the first failure, after the -EFAULT-on-RAM exception that
intentionally tolerates devices without volatile poison-list support.

Fixes: be5cbd084027 ("cxl: Kill enum cxl_decoder_mode")
Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260708074228.43654-1-icheng@nvidia.com?part=5
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/memdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 33a3d2e7b13a..8718964b9c5e 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -231,6 +231,8 @@ static int cxl_get_poison_by_memdev(struct cxl_memdev *cxlmd)
 		 */
 		if (rc == -EFAULT && cxlds->part[i].mode == CXL_PARTMODE_RAM)
 			rc = 0;
+		if (rc)
+			break;
 	}
 	return rc;
 }
-- 
2.55.0

