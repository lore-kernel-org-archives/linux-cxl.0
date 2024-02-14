Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E1811706
	for <linux-cxl@vger.kernel.org>; Wed, 14 Feb 2024 07:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707894822; cv=none; b=i3HLR+X8b7dVqGwPWD/OEfcNz8G+0eNcppQODZ3obgsW+6wH0pw9eI2IjE9kDocgg84vf5qT1wFGOK7Rf8tKq3L2JfWw+N3ksgOCb8WVFc77nMols0HfpGpmfm+SOInMgDkoUvOGF5Bj2+ViMRDLieqFSzz3lKBtEp5zN8Ci0JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707894822; c=relaxed/simple;
	bh=Kj+bNqO/Cf0xASTAk7Z82Qb0ZtmJcuW5M4v1WVwqW/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Axt+p9Jqm1ZALYWHFQItZtVCTOb4ALCQKijaJ/IO1Re+m1CLfUpzkxLYtU2cqSFkGmUlF1HbeqmwuTzd8Y/kW8x9io1NeHacmY2HGZ6tR7IctjoJwtm/3FQQbrEmAd/e41Wj0PHAq9z3+xf39l/TSDDMcCZnTK+JglkrbKTQAc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cEgkTf1d; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cEgkTf1d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707894820; x=1739430820;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Kj+bNqO/Cf0xASTAk7Z82Qb0ZtmJcuW5M4v1WVwqW/Q=;
  b=cEgkTf1ddb+UmvdeiLXrDi/Q8WZxJpNrKB4TpfkRj2uqhVdja/PFcGwL
   01uVsUa8TA1upEJfY7el6CeAV+Ao1vaQwzNp6UlcGrz3WP+d4d9l0uf/2
   19Z2l9DNqLQn9M3dZ8fo9b097RlnHniIQpw33yuO6Lf4XMupBFQ7y52Wc
   mAn5EFx5neF7Sgp7R4iwi0XKc/xX89pWm+Y+8pTqGxmbLDl7VHLMID51I
   vIBH5zUa1RoHzMMWNulY1xicaLdZYuHWGgJ15nKuA8NJ/Um7Jf7Pgp2hH
   /wV9DuE8b1pLG2gpf9W+S7oFZlcjb8cy2xQc4ySMEz9CzgWu7sdt7mXiX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="27374442"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="27374442"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 23:13:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="7758531"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.66.223])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 23:13:39 -0800
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH 0/2] XOR 3-6-12 HB Interleave Calc Repair
Date: Tue, 13 Feb 2024 23:13:34 -0800
Message-Id: <cover.1707891715.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

This includes a CXL driver fix for finding a targets position in
HB interleaves that are multiples of 3, plus a cxl_test module
patch to support testing this fix.

A patch is also being posted to ndctl:
cxl/test: Add 3-way HB interleave testcase to cxl-xor-region.sh


Alison Schofield (2):
  cxl/acpi: Fix XOR 3-6-12 way host bridge look-up calculation
  cxl/test: Replace an illegal CFMWS definition with a useful x3 CFMWS

 drivers/cxl/acpi.c           | 51 ++++++++++++++++--------------------
 tools/testing/cxl/test/cxl.c |  6 ++---
 2 files changed, 25 insertions(+), 32 deletions(-)


base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
-- 
2.37.3

