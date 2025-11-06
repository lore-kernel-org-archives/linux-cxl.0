Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574C825A633
	for <linux-cxl@vger.kernel.org>; Thu,  6 Nov 2025 17:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762448491; cv=none; b=Cq8ZSdPHqcyxitAcXFXXf/GxGRtPbOsNi7hvjStXPghC06y5WMqJYBo3MHrLnceUFsA+mJiDh7JSV6LMIwA+ro4rVnjA4V+Kds8MgmkX7lBRxR8HeABbTPArximYUxTC0Sk0fqWt3G9IJBx17/06PtAfZrgpILcbao1diEP5WFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762448491; c=relaxed/simple;
	bh=glDndQjGI4SNbN82bp+wiBe+sEZbNZFZSo20A3XxNk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g7BK2LMwu1Ugt/aHzTpoPpCoGlSuSIIoqtNryQ3RJm8l5qkeoFdiBQSJNypIAoKpvEYXlmY5uiZQpqN5O27TtvbK9nypPF1HRc92G2gaZwLdf6RkBSNn8sbzSd7CBlk/Fq6Y+s+0lW4hO+YX0v3wst6TmL6cQNRPdQ219n07sco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F53DC4CEF7;
	Thu,  6 Nov 2025 17:01:30 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com
Subject: [PATCH 2/2] cxl: Clarify comment in spa_maps_hpa()
Date: Thu,  6 Nov 2025 10:01:08 -0700
Message-ID: <20251106170108.1468304-3-dave.jiang@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251106170108.1468304-1-dave.jiang@intel.com>
References: <20251106170108.1468304-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the comment in spa_maps_hpa() to clearly convey the construction
of extended linear cache.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Link: https://lore.kernel.org/linux-cxl/68eea19c7e67e_2f899100a8@dwillia2-mobl4.notmuch/
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/region.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 302db75dc908..a5906d8b6064 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -845,9 +845,9 @@ static bool spa_maps_hpa(const struct cxl_region_params *p,
 		return false;
 
 	/*
-	 * If an extended linear cache region then the CXL range is assumed
-	 * to be fronted by the DRAM range in current known implementation.
-	 * This assumption will be made until a variant implementation exists.
+	 * The extended linear cache region is constructed by a 1:1 ratio
+	 * where the SPA maps equal amounts of DRAM and CXL HPA capacity with
+	 * CXL decoders at the high end of the SPA range.
 	 */
 	return p->res->start + p->cache_size == range->start &&
 		p->res->end == range->end;
-- 
2.51.1

