Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA0925A633
	for <linux-cxl@vger.kernel.org>; Thu,  6 Nov 2025 17:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762448487; cv=none; b=LxChd2skdh/myS5WsMH8+uEE4GGhOM5fC/rUdD+lDYS6hQxW3K7j4yBdDmc/PG1WKh/o2xA/1dXlz9lIjaPJDROXKb0y63mrvzP/sOJnLHCKxj6rx+YZKhmF2u1tZDrJ6yHaI5YwJRUM6bdBULlbZXswULIBeKDIbTxTS6XaZG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762448487; c=relaxed/simple;
	bh=/alq9cUP6tCxS1fr2tnCuBU+A3tKEJ0Pz6B2ra2lQTk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mZCrmPZ+SrKXnbmTrjnqpyGmYpg8j19Vr62I/dZ7+iAejhCvk5AO4FPJFNm/uoLuBOnC+SV2yPOzfMwVOIq0st2u5W8RE3tc83bvhojS+zHkYSc6m+chDho3czd62I3bPv3NYgXHMkGZADFTKykqg8Pa8xrIMvsG+5CkmE488dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44ABBC16AAE;
	Thu,  6 Nov 2025 17:01:27 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com
Subject: [PATCH 0/2] cxl: Cleanup region_res_match_cxl_range() function
Date: Thu,  6 Nov 2025 10:01:06 -0700
Message-ID: <20251106170108.1468304-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Small series rename and clean up comment of region_res_match_cxl_range().

Dave Jiang (2):
  cxl: Rename region_res_match_cxl_range() to spa_maps_hpa()
  cxl: Clarify comment in spa_maps_hpa()

 drivers/cxl/core/region.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)


base-commit: 6146a0f1dfae5d37442a9ddcba012add260bceb0
-- 
2.51.1

