Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C8A179A3
	for <linux-cxl@vger.kernel.org>; Tue, 24 Jun 2025 00:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750726423; cv=none; b=p37OaX5qKg3PrpSTJzCcNMznCAxoIsmIPhSQvkdu5Ihj6TCy/gJH34K3iCzqFEXxF7JUZ2kzI8k2qn8N2gSaAzi57MM057vLWNmnYX4Fz9GGrKNW1CeD3U/jXQwQUiJOpZR+Ak6Yj3S+IKgsNUdGdjYXFONiZhqMUY3RTX8S+rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750726423; c=relaxed/simple;
	bh=34gUeH1aF+5W/BdnrfT/V7c7noMktiGyCa+uWVUs6xI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fS1Pv70ae9LMdaFgrNff6DhAQEFWwsF3tReEuY7KfB9TQooKIwyrutumLSO3Rj7sZLObH+g8eVCEON5l3OIG5fcURMfes75SnH9PAfIktkjs6pSE8yLesqOYhSf4KzzfzJKcZgJh1uR5gtc2TfDN/NJ6ybxLrwXC2JfvPj/iRck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oEtYUGah; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oEtYUGah"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750726422; x=1782262422;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=34gUeH1aF+5W/BdnrfT/V7c7noMktiGyCa+uWVUs6xI=;
  b=oEtYUGah64QKhZr4ggb83ZrtNs2AF6aD/Ih3P3A1qS5446xKEfsXPsnb
   Ce7A0ArSh2yaMO8HIqDj1ap43MUBfeU69hIkc21A94RfgbvaQLBAL5gPK
   wf2GAj75wdFibsXurG+7rSXc8wooLKLZvYv1MrHZfpZIlxg6KascLnIAO
   4tnuZAOwemGmLmv3TsbKC4t/aQk3wzpU5CYShJjJMfZu4eDkfq9r3JUnj
   SZ4ky5fQ5TrBfv3nb+IKphiKeXq5I6mVpr3ZTXIqLvm0oR1i/axSG9KFw
   hAIBaiPqEhqTQRl7uY4uH+ytuahEONEIjRw3cROqoPaoYoESA8f6zdp2l
   w==;
X-CSE-ConnectionGUID: l2LnNIkmTcig/lrO6j/x/Q==
X-CSE-MsgGUID: 6lrl8VZuRA6/6LhqUm0tHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="56728800"
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="56728800"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 17:53:41 -0700
X-CSE-ConnectionGUID: nMrZjsLZT4i7zEFvXc5bXw==
X-CSE-MsgGUID: i8QgNcfBSru+wygz08I5RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="156129143"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.202])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 17:53:41 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH 0/3] cxl: Support Poison Inject & Clear by HPA
Date: Mon, 23 Jun 2025 17:53:33 -0700
Message-ID: <cover.1750725512.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

This series allows expert users to inject and clear poison by writing a
Host Physical Address (HPA) to a region debugfs files. At the core of this
new functionality is a helper that translates an HPA into a Device Physical
Address (DPA) and a memdev based on the region's decoder configuration.

The set is not merely a convenience wrapper for these region poison
operations as it enables these operations for XOR interleaved regions
where they were previously impossible.

Patch 1 adds a locked variant of the inject and clear poison ops to
support callers that must hold locks during the entire translation and
operation sequence.

Patch 2 introduces the translation logic capable of returning the memdev
and DPA for a given HPA.

Patch 3 exposes the capability through region debugfs attributes that 
only appear when all participating memdevs support the poison commands.

These patches build on the existing memdev poison and region address
translation infrastructure and target debug and platform validation
scenarios.

Watch for the CXL Unit Test update to cxl-poison.sh posted separately
on this list.


Alison Schofield (3):
  cxl/core: Add locked variants of the poison inject and clear funcs
  cxl/region: Introduce HPA to DPA address translation
  cxl/region: Add inject and clear poison by HPA

 Documentation/ABI/testing/debugfs-cxl |  33 +++++
 drivers/cxl/core/core.h               |   4 +
 drivers/cxl/core/memdev.c             |  88 +++++++----
 drivers/cxl/core/region.c             | 201 ++++++++++++++++++++++++++
 drivers/cxl/cxlmem.h                  |   2 +
 5 files changed, 301 insertions(+), 27 deletions(-)


base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
-- 
2.37.3

