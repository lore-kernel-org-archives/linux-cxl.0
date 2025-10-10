Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D8D25A32E
	for <linux-cxl@vger.kernel.org>; Fri, 10 Oct 2025 20:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760129877; cv=none; b=eqDfDDIESZxpmRy1qNfvS9kQ1Be2KBzd7quoU3c33oAUpcd78KuXy2mqDwf3rAggMPDDCDTOesg5dkXXLwwYv4s9R/kkzNkXPB4YRMePL5Jkmm/ejlPWqlm0Hf5cq3urNFV4zo4A5fCTTMpt40tYpjmi1cQGZ8QjwgQK+WGKPTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760129877; c=relaxed/simple;
	bh=v2RVIcgzQkXXHq3jOY60x8LGeSsrkZS+jamUKUcQXss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nPwa1Z5N8Co+SdTT28vmIYGhad7s+wlbY+eRe3ZJkTUUGJSpOLzDwJXG91ls4xLUorFXME/8U/ute6jEdXYJ1kucIn0NnGhEIp9GODhdaJMJFDEVIf/ufkSmN5770H107B69QclpJqA1fBGjNBHyz65lJyx9Z2sNz/gaxR75iFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BAA2C4CEF1;
	Fri, 10 Oct 2025 20:57:57 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: [PATCH 0/3] cxl: Fixes for extended linear cache
Date: Fri, 10 Oct 2025 13:57:52 -0700
Message-ID: <20251010205755.205280-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series contains 2 fixes for extended-linear cache to make
it functional again. One is a regression from code refactoring. The
other is a missed range compare during region matching.

Dave Jiang (3):
  cxl/acpi: Fix setup of memory resource in cxl_acpi_set_cache_size()
  cxl: Set range param for region_res_match_cxl_range() as const
  cxl: Fix match_region_by_range() to use region_res_match_cxl_range()

 drivers/cxl/acpi.c        | 2 +-
 drivers/cxl/core/region.c | 7 ++-----
 2 files changed, 3 insertions(+), 6 deletions(-)


base-commit: c8e0f4f4be40a20f976344a821615e2b1bdb1f2b
-- 
2.51.0

