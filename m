Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8852F3C34
	for <linux-cxl@vger.kernel.org>; Fri, 31 Oct 2025 17:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761931946; cv=none; b=trXvEZYf0jf68iAJnzc686qdd/UBrN+QKq//pGeP/77L8zluGnxJKgHuUU0IIBbmHX1BPf/48418uO85GuLJPl/+hEzUDx6/uv6l975QGNWJYTjT5OXVsf+cKZTsYXVB7Xv/jSQY6LIXlgCmP2d/cInbtXKxYD3iuyOPQ1bEuuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761931946; c=relaxed/simple;
	bh=hihOkwfxZtksOG6u47btaLM2HDzI3CJOq3oUarmkrys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tdsTAs4SlinLmWaX1o0pylW+NIAfq/0mHyHRB6W8bxFawTxj2a2rU3f3980stittHXjGnN/4Ne10Qm7wXcqyTNRFx4SfEaoBFv0pjWKl+nJShoIdcVrVbYYO5iGTC8TC36ytQ6h/GHmeB8x8JqnMAOnktr80rgdjUvOmmuHmyd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E36C4CEE7;
	Fri, 31 Oct 2025 17:32:25 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: [PATCH 0/4] cxl/test: Add unit testing for extended linear cache
Date: Fri, 31 Oct 2025 10:32:20 -0700
Message-ID: <20251031173224.3537030-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The series adds support for mocking of extended linear cache support
in cxl_test. A module parameter is introduced to activate the mocking.
Tests will be added to CXL CLI user tools for regression testing.

This series depends on the patch [1] that provides the extended linear
cache size via sysfs.

[1]: https://lore.kernel.org/linux-cxl/20251022203052.4078527-1-dave.jiang@intel.com/

Dave Jiang (4):
  cxl/test: Standardize CXL auto region size
  cxl/test: Add cxl_test CFMWS support for extended linear cache
  cxl/test: Add support for acpi extended linear cache
  cxl: Adjust offset calculation for poison injection

 drivers/cxl/core/region.c     |  2 ++
 tools/testing/cxl/Kbuild      |  1 +
 tools/testing/cxl/test/cxl.c  | 55 ++++++++++++++++++++++++++++++++---
 tools/testing/cxl/test/mock.c | 20 +++++++++++++
 tools/testing/cxl/test/mock.h |  3 ++
 5 files changed, 77 insertions(+), 4 deletions(-)


base-commit: 659163e60a142e8c3bd66f9865e1f8ffcb8cbd9b
-- 
2.51.0

