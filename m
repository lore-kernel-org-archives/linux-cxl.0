Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793849317;
	b=OBqs6wFVnQ0pY7Xi1Q5HY1XtX+IhRO0jcznhrjEQq3UsENa+txCqsPpHvUon4d9PZvvj
	 QtlzgOi5MBQqPSfNQNms3YrbQsCblLlOlP7eHBX5DdstjPNCEjRNlvSQGJY2U3Ss4KNFz
	 WgevKR+DilVMaVjIJd7pF9C+C6X/xUdiQ0DAsHjKCyl7tVCFJRYVf7AX3DnZ0wP8DRrx3
	 6+UWtdLKYGvDSIbW0chOv39O+HJ+TQFHA1Ba63lDjnclMDqSsExnsvZZR5EUbYs2fkqG3
	 BDR2FN4aM/0m9B1HK3WE0l+p0ceKebIzMq10r5cw6F7CSO3KId10HqoDZUae4JX890w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793849317;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=jApso1K7HRSOLsb3cAssSCQ8+KTBUfXNTbFEA3rEqVU=;
	b=P5ReFmPTBRn1isTY3OoTEPB+9DU2wfEGo2/wnLpp7ezWkAHHaU0ZP9pzF3fLMnwmUT2q
	 PLyRrqMFMtR/PQ7GDSJuuAmcfU8g0ko2qwulcT6kKdYeNx/j3c+9YGLAIvdFZw521Us+b
	 qMUKQo1JbRqROuYi1nNAQLGvr3AFA3qbz8YqfeyyMXMSjCQdWMhaso66CylPHy428UToL
	 nd093oGz1vIQUH6aFnrFssDUbv7ozdan2rrDZgYgKkVP/nuGGpFJ6bm6YibVE6I/0a/Lf
	 XYvcf+gFWJ6iZIvKx4U8qezYXQx+vn0YDhV9eUJdCResCOx7AQplmZxzRL+3JGtVGbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Or79uquD;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F61E606A326
	for <linux-cxl@vger.kernel.org>; Thu,  5 Nov 2026 03:28:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F61E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Or79uquD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793849317; x=1825385317;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=P8Nr7u4Mtp3Edkz9+fnZSqBBTA+DHYPjnKUsAvPRItY=;
  b=Or79uquDzpM1oOdshCo77BQxR6Vm6+5vIQnKWT29d8w+pWRvJrTppL0P
   6AcdCIZOAKUrBQAxsG4mbAcZrRwXQ6nPPu++Al94u8XI7ebazXJsLKfxh
   w71e9ydBv01b37hRmMWT2Nl13PiyF97/+txpyhugFEGhMPQAmvNzlHMfB
   K5GZJoU8G75TAmfA5ndelF4GNghHz5ByN/9gRp2mvtRys+IMjw3YP/Zto
   8lQgubV36GPG9vbIyJOyQXKCQeTk3a86bRfBtS3N6P04k71bDQKOqpaho
   c7hirZB3C3MLb8ZfBQ092hH+yO28UDv/UX0/jGrHMkj6pCm9u3hZJybYi
   g==;
X-CSE-ConnectionGUID: 27N2zHN5Rcuh3vfuleVBKQ==
X-CSE-MsgGUID: mJ6QydbbTxiujeSMIDGRnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2511480"
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="2511480"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 19:28:36 -0800
X-CSE-ConnectionGUID: fbPlhfFjQDekVFC/o9NXjg==
X-CSE-MsgGUID: IaR6/qG/SdKBeiUYI9L4Ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="6913279"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.110.56])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 19:28:36 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Richard Cheng <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH 0/4] cxl/region: Update and test performance calculations
Date: Wed,  4 Nov 2026 19:28:27 -0800
Message-ID: <cover.1793847269.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CXL regions expose latency and bandwidth through their access0 and access1
attributes. The same performance data also contributes to NUMA node access
coordinates and memory tier placement.

This series updates region performance calculation and reporting,
consolidates the completion-time operations, and adds cxl_test support
for validating the results.

This work was prompted by AI-assisted patch reviews that identified ways
stale contributions from failed or removed targets could affect region
performance data.

Patch 1 addresses stale contributions to region performance data by
recalculating from the attached targets only when the region completes.

Patch 2 makes region access attributes visible as soon as performance
data is available.

Patch 3 consolidates the three completion-time operations into one helper
shared by user-created and autodiscovered regions.

Patch 4 assigns distinct latency and bandwidth values to cxl_test memdevs
so that region performance calculations can be tested.

A new CXL unit test will be posted separately.
Testing with cxl_test:
- With all four patches, the new test and existing ndctl CXL tests pass.
- Without patch 1, rejected, cleared, and rebuilt target cases report
  incorrect latency or bandwidth.
- Without patch 2, the region access0 and access1 directories remain empty.

Based on v7.4-rc1.


Alison Schofield (4):
  cxl/region: Calculate performance data once all targets are attached
  cxl/region: Show access attributes once performance data is calculated
  cxl/region: Consolidate region performance completion
  cxl/test: Give each mock memdev its own performance data

 drivers/cxl/core/cdat.c      | 19 +++++++++++++++--
 drivers/cxl/core/region.c    | 40 +++++++++++++++++++++---------------
 drivers/cxl/cxl.h            |  3 +--
 tools/testing/cxl/test/cxl.c | 21 ++++++++++++++-----
 4 files changed, 57 insertions(+), 26 deletions(-)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.37.3

