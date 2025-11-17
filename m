Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD0C22A1D5
	for <linux-cxl@vger.kernel.org>; Mon, 17 Nov 2025 14:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763390777; cv=none; b=e/8ZcJzUeFC26PkRsZL8yj04BhBgIqRcJf4OJm4n7XvuqqhzqQYrOY0d1ua3hVtAPojKqWDFyDXFwohP3sqpK6f+CvrcChxFIZdgzZyS0do6PcweHYxiBh6ch84JE5dPSjizWsBb9ye7nBoVgFopJKkJgeS4b2avqvp6ONGg1i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763390777; c=relaxed/simple;
	bh=8gnHrVaiAmxH6SwyfaefrlkawgAEq3SFPM0jZCg3uRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AXPVgQ0nibPvZynaPnH295bkWNaYUPiRD5RZnfyegwWAtP1GgF3feU82Q+UdXRlOSca94ahAcRkURgAN2B0AJ2cAVNa223OURaVFycViGRfCEDueiDzJ0i6MdCJVGDjWolOVs4kuKXqEetWklVIjhwMyKYveI+YZGel8W4hpRhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 525FDC113D0;
	Mon, 17 Nov 2025 14:46:17 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: [PATCH v2 0/3] cxl/test: Add unit testing for extended linear cache
Date: Mon, 17 Nov 2025 07:46:08 -0700
Message-ID: <20251117144611.903692-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2:
- Use a global variable 'mock_auto_region_size' instead of a static define.
  Expectation is LMH will change that value for its testing.

The series adds support for mocking of extended linear cache support
in cxl_test. A module parameter is introduced to activate the mocking.
Tests will be added to CXL CLI user tools for regression testing.

This series depends on the patch [1] that provides the extended linear
cache size via sysfs.

[1]: https://lore.kernel.org/linux-cxl/20251022203052.4078527-1-dave.jiang@intel.com/

Dave Jiang (3):
  cxl/test: Standardize CXL auto region size
  cxl/test: Add cxl_test CFMWS support for extended linear cache
  cxl/test: Add support for acpi extended linear cache

 tools/testing/cxl/Kbuild      |  1 +
 tools/testing/cxl/test/cxl.c  | 56 ++++++++++++++++++++++++++++++++---
 tools/testing/cxl/test/mock.c | 20 +++++++++++++
 tools/testing/cxl/test/mock.h |  3 ++
 4 files changed, 76 insertions(+), 4 deletions(-)


base-commit: e9a6fb0bcdd7609be6969112f3fbfcce3b1d4a7c
-- 
2.51.1

