Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575F132C302
	for <linux-cxl@vger.kernel.org>; Thu, 22 Jan 2026 03:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769052741; cv=none; b=I8We0RPVc5hhgo4d/XnUmFkoZg9ZsLsMtjJBvz9/GSPDwMcHrMj+envjQE0+6/wagZvCoBMRCWwDKnjlhwi97bdVhY4gklm9Ov8NzAzjAHQsMOk1+eHjErRPxr5UTTi9Aydhj1xNohbzfFu+AU0HtNgacxWf6Wz/ec1/WQC3Z9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769052741; c=relaxed/simple;
	bh=9/WM6Z9CoTRNTCZe+rRvPe7kLKRdgIBMlH3NonKpVGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U5WYOz3Cz5PWrkIpdEfvIrPWc6d7AOgd6uswy60eZlE4BMcCwtXW6UCv6PxYVeFB2cIHqCfCoTj9cY0WnhkOVhw6WIxzA2cwG6R4cWENbhrfSrLU36g+7+TYU3PSRiqBHLb7GtMeUzxwMUjTvNn8HNWZLT22ybJqa5ccHY+JiK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YH1+Ai9I; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YH1+Ai9I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769052739; x=1800588739;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9/WM6Z9CoTRNTCZe+rRvPe7kLKRdgIBMlH3NonKpVGA=;
  b=YH1+Ai9Ie1y8vmg9hnyqQHBYh9XOmegEglX4mOhX/60kM/XowDFhuXCW
   x31qKzvGxnc/xJ9y08dF93iLlkr5Ucpbm0ajRi554ZrWFfZPqIl0ZVDF6
   Kwh//sbocFCo1r6sJ5HXaJZidjpLjVvBwyRNCMBT/WCbWuzpdJAsWpNA1
   bqRXP6pvytjTEyvXmNqKj3ITIwCBD6Y9lrtzkw2IcKCUQY/9HaBoQeijD
   CnjUnaA6fEshe/ZGryE5Ys1rPq3/4XesbythgSPFc19w43Pbi4JC+rBOj
   JH3jpJN3NkeASYsMj5MlU+P9V5js7u1Sv6aRjY+fsMnGikhOR/hnTLbhu
   Q==;
X-CSE-ConnectionGUID: MjuZ6wdgTrWqlLWka0zArA==
X-CSE-MsgGUID: 5MLCKrtcQkWJfFhhzp1rgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="81734426"
X-IronPort-AV: E=Sophos;i="6.21,245,1763452800"; 
   d="scan'208";a="81734426"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 19:32:17 -0800
X-CSE-ConnectionGUID: fSpOwXCwSZSm31Kaj/dBgA==
X-CSE-MsgGUID: yBzVLaZYQUG37hOHSWOUhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,245,1763452800"; 
   d="scan'208";a="211064067"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa005.fm.intel.com with ESMTP; 21 Jan 2026 19:32:17 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: linux-cxl@vger.kernel.org
Cc: jonathan.cameron@huawei.com,
	dave@stgolabs.net,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com,
	terry.bowman@amd.com
Subject: [PATCH 0/9] cxl/port: Unify RAS setup across port types
Date: Wed, 21 Jan 2026 19:33:21 -0800
Message-ID: <20260122033330.1622168-1-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CXL Port Protocol error handling series grew to be over 30 patches
which is too much to handle at once given the various topics involved.
One of the sub-threads of the v14 review was confusion about the new
devres groups to manage port setup unwind failures [1].

[1]: http://lore.kernel.org/20260115144605.00000666@huawei.com

Given that review indicated a need to break up and better explain the
conversion, do that in a separate patch set. Build on top of the first
18 patches of that series [2] that are ready to merge (save one missing
ack from Bjorn).

[2]: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=for-7.0/cxl-aer-prep

The wider goals of the port protocol handling series are:

1/ Be minimally invasive to the ongoing maintenance burden of PCIe error
   handling. Just do the minimal enlightenment to forward "internal"
   errors for device with active CXL links to the CXL core.

2/ Build a framework for any driver that registers a 'struct cxl_memdev'
   (or in the future a 'struct cxl_cachedev') gets protocol error
   handling support.

This "Unify RAS setup across port types" set supports goal 2/. It
enables a model where all CXL error handling is relative to the common
'struct cxl_port' and 'struct cxl_dport' objects and is agnostic to
whether those objects are in support of the memory expansion class
device (driven by cxl_pci) or any other CXL endpoint in the system that
supports CXL.cachemem operation.

In support of that unification, the setup of RAS registers needs to be
centralized. That in turn requires new handling for early exit setup
failures and additional teardown support for resources optionally
acquired at port / dport creation time.

The devres group mechanism is deployed to cleanup some open coded
devm_release_action() calls. The devres group facility also comes in
handy for unwinding conditional setup steps in the port creation
process. Recall that ports defer probing their CXL resources until after
they are known to have a downstream CXL connection. So, early exit during
setup of a new dport may have more or less work to do depending on
whether the first or subsequent dport is being added.

Given probing port resources is a 'probe' action it fits more naturally
as a driver operation. If cxl_port_add_dport() then moves to cxl_port
driver operation alongside ->probe(), it enables a cxl_test cleanup. The
cxl_test approach has a hard time mocking interfaces that are internal
to the cxl_core.

The rest of the patches in this set finish off the conversion of 'struct
cxl_port' and 'struct cxl_dport' to be the only CXL objects that
interact with the CXL RAS.

Dan Williams (8):
  cxl/port: Cleanup handling of the nr_dports 0 -> 1 transition
  cxl/port: Reduce number of @dport variables in cxl_port_add_dport()
  cxl/port: Cleanup dport removal with a devres group
  cxl/port: Move decoder setup before dport creation
  cxl/port: Move dport probe operations to a driver event
  cxl/port: Move dport RAS setup to dport add time
  cxl/port: Move endpoint component register management to cxl_port
  cxl/port: Unify endpoint and switch port lookup

Terry Bowman (1):
  cxl/port: Map CXL Endpoint Port and CXL Switch Port RAS registers

 drivers/cxl/core/core.h              |   8 ++
 drivers/cxl/cxl.h                    |  27 ++---
 drivers/cxl/cxlmem.h                 |   4 +-
 drivers/cxl/cxlpci.h                 |  12 ++-
 tools/testing/cxl/exports.h          |  13 ---
 drivers/cxl/core/hdm.c               |   6 +-
 drivers/cxl/core/pci.c               |   8 +-
 drivers/cxl/core/port.c              | 153 +++++++++++++++++----------
 drivers/cxl/core/ras.c               |  50 ++++++---
 drivers/cxl/mem.c                    |   2 -
 drivers/cxl/pci.c                    |  63 +----------
 drivers/cxl/port.c                   | 132 +++++++++++++++++++++++
 tools/testing/cxl/cxl_core_exports.c |  22 ----
 tools/testing/cxl/test/mock.c        |  36 ++-----
 tools/testing/cxl/Kbuild             |   3 +-
 15 files changed, 310 insertions(+), 229 deletions(-)
 delete mode 100644 tools/testing/cxl/exports.h


base-commit: c61e99a20e7390bf8727a3b2cacbc00931b05d0b
-- 
2.52.0

