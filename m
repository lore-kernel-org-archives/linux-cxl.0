Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69763BB40
	for <linux-cxl@vger.kernel.org>; Thu,  5 Feb 2026 00:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770250598; cv=none; b=JQmI+ObPQ6XSsv7Mvk5fRUl1FeGLRmYlDBbTGBTz0/7HMeCwTm5tKB5WwHMMgiUGqgDYp1BSI5fJdapMKtv51n/5GsnQZDfBns5Nm82kB4g2O5S6sB1hu/j7WwvWXrmX21/jcOOiZ5J3a819F8cW3cc4vmOLJsMyhmTuY8YQCAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770250598; c=relaxed/simple;
	bh=O0z3FJOshZHtytOMrsetGRbwoF3uBmas/Vud3sCE07U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u3x1JoREYMINhqLztAGYHPaqQ+9ySW1mv75DMmGnwxT3OLwgMIDdd1DpbRfC6EMU80ovhinNrjKwvsgNvETgjS1y5tXRsB69VHUpooWexZB+wzmR+J/gY6bDxG48aEVVUgPIYM4uNf5czXNwbWStrSfxQVGWsoVIwa4aBZu1+QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C5CC4CEF7;
	Thu,  5 Feb 2026 00:16:38 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: [PATCH 0/2] cxl: Fix nvdimm_bus race for nvdimm_bridge
Date: Wed,  4 Feb 2026 17:16:31 -0700
Message-ID: <20260205001633.1813643-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A small series to address a race for nvdimm_bus object when using the
nvdimm_bridge object.


Dave Jiang (2):
  cxl/test: Removal of nvdimm_bus_register() wrapper in cxl_test
  cxl: Fix race of nvdimm_bus for the nvdimm_bridge object

 drivers/cxl/core/pmem.c       | 236 +++++++++++++++++++++++++++++++---
 drivers/cxl/pmem.c            | 199 +---------------------------
 include/linux/libnvdimm.h     |   2 +-
 tools/testing/cxl/Kbuild      |   1 -
 tools/testing/cxl/test/mock.c |  15 ---
 5 files changed, 221 insertions(+), 232 deletions(-)


base-commit: 18f7fcd5e69a04df57b563360b88be72471d6b62
-- 
2.52.0

