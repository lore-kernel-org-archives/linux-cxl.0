Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5CB2673AA
	for <linux-cxl@vger.kernel.org>; Fri, 13 Feb 2026 22:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771022441; cv=none; b=sM5waZH7s97+4aOrYB7rwv86Yv4McjF3zu7iwDYqK7BA1KKSv2urRn58B4LlPehDzyu3WprBeZFM6lB9kbEQD1607WrnlILGy8RLICw4IJYfoDsqBVGK/5SuxeloGScmdCSbFQsKfCjobTKN71yWRRhHPjDaGMgUevb2kdzusVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771022441; c=relaxed/simple;
	bh=zl565uv2hBapdB3SbOQUbkquKvjrQ0AVHL/uwDm1AuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fyU8N/XITsgtSQdQk9vSud3E5eM0rj1s7UmAc2e6chD3p1yE2KHGZhR07YuTAh+wIoEpb8pspYzuh/oa+EqDi9ufgHuh6WvR7UYJnAJ54n0RSePG/gcAmiwvlieervZyqvC0sMsztLQZ6QSa5t+dSUbN9Si3u21G+UZjJZNXtq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACCA7C116C6;
	Fri, 13 Feb 2026 22:40:40 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: [PATCH v3 0/2] cxl: Fix nvdimm_bus race for nvdimm devices
Date: Fri, 13 Feb 2026 15:40:36 -0700
Message-ID: <20260213224038.549798-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v3:
- Just move the symbol of devm_cxl_add_nvdimm_bridge() with a wrapper function. (Dan)
- Squash the functionality of patch 2 and 3. (Dan)
- Introduce a flag to invalidate cxl_nvdimm when releasing nvdimm_bus. (Dan)
- With cxl_nvdimm marked as "invalidated" no need the check in cxl_nvdimm_driver. (Dan)

v2:
- Try a different approach

A small series to address a race for nvdimm_bus object when using the
nvdimm_bridge object.

Dave Jiang (2):
  cxl: Move devm_cxl_add_nvdimm_bridge() to cxl_pmem.ko
  cxl: Fix race of nvdimm_bus object when creating nvdimm objects

 drivers/cxl/core/pmem.c | 40 ++++++++++++++++++++++++++++++----------
 drivers/cxl/cxl.h       |  7 +++++++
 drivers/cxl/pmem.c      | 22 +++++++++++++++++++++-
 3 files changed, 58 insertions(+), 11 deletions(-)


base-commit: 63fbf275fa9f18f7020fb8acf54fa107e51d0f23
-- 
2.53.0

