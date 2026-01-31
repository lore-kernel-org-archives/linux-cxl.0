Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636D84A3C
	for <linux-cxl@vger.kernel.org>; Sat, 31 Jan 2026 00:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769817771; cv=none; b=UFRxzKmNPRtVD4h1tEQFKvtfgOStWshi7T4sZtRr7uEs8Ag/Vc2o/Hil3p9y8k3MMAwsBMvegwwt6aOIfZSMr5FAF2UD6BCM4c5kHQIhXdrtrZhMWV/N35sftvLY5z4gmS4CuT2wfvlllikU76BdZLjGaMKScANeIGXXnPNQqNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769817771; c=relaxed/simple;
	bh=HG/WFHzImIrNtPXIhwFDlDSgDkqQKWjGeVH6g9EokKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b+bXGZo7mNNwbL3hOBDtewbmKRjaONqfROcBU2FyKm3xqCkhdpJoL18WaW690SfwJSGuWHPADaTs6r9uVn4S6nqUqWxW0WKddB5B3dS9PRuva5Zmv30s521Xa2udYUMRSAFc3oCYfX1BfKIv350+NyFT8o6hWZytUl1n5Tk+9wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q9D3FVRI; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q9D3FVRI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769817770; x=1801353770;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HG/WFHzImIrNtPXIhwFDlDSgDkqQKWjGeVH6g9EokKQ=;
  b=Q9D3FVRIUKfuNKFr5ZzU/pZUC8r43/pCHkKQ5pQoqzyDnP4BBQum5r5C
   OWQvR2N1xZObWIpGs6I7Q1K1ixyReSTdEDkri4CGKaDjxl4YHaF7VU5I1
   wll8o2bmCN6gbrXnAipzk3YoH96qYuRN+WRUCcE4LI4KNhamiQRfiZF/f
   +KG+VWTrjZpBdtk6eFmZACubGW2Mhgqi0G5hV06FdkEUqybw5eAeN4mfS
   /vtpDw10aKVcWeLr3P0AaJjtfmwoN8dPMB9IAPY17Lfx809xrwNU2ewPL
   llI//G58y3WvXAFCKkIzfFlG4Ua6X2aO7+mS05GfneuL47K8Eutru9dft
   w==;
X-CSE-ConnectionGUID: TScv76xCQF+D/+1rzwrUJQ==
X-CSE-MsgGUID: d8nmJ6AeTX22nzDLrSTC8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11687"; a="71156890"
X-IronPort-AV: E=Sophos;i="6.21,264,1763452800"; 
   d="scan'208";a="71156890"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 16:02:49 -0800
X-CSE-ConnectionGUID: xxesjJE3S7yj+0MH9H3cNg==
X-CSE-MsgGUID: AEJHOh7iSkmt9+oyhoaRHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,264,1763452800"; 
   d="scan'208";a="208093707"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by orviesa006.jf.intel.com with ESMTP; 30 Jan 2026 16:02:49 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Jonathan.Cameron@huawei.com,
	dave@stgolabs.net,
	alison.schofield@intel.com,
	dave.jiang@intel.com,
	terry.bowman@amd.com
Subject: [PATCH v2 0/9] cxl/port: Unify RAS setup across port types
Date: Fri, 30 Jan 2026 16:03:54 -0800
Message-ID: <20260131000403.2135324-1-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v1 [1]:
- Cleanup the diff by keeping the order of dport_exists() relative to
  the dev->driver check in cxl_port_add_dport() (Jonathan)
- Drop some repetitive de-referencing with a local @port variable in
  dport_to_host() (Jonathan)
- s/group/dr_group/ throughout to clarify "devres group" (Jonathan)
- Reuse del_dport() for cxl_dport_release_dr_group() (Jonathan)
- Drop the thin wrappers for devres_{open,close}_group() for the port
  group.
- Add a comment and a cleanup TODO for the 'add_dport()' operation in
  'struct cxl_driver'. (Jonathan)
- Change patch 7 subject to just: "cxl/port: Map Port RAS registers"
  since it is only introducing a helper that is later used in the
  endpoint case. (Jonathan)

[1]: http://lore.kernel.org/20260122033330.1622168-1-dan.j.williams@intel.com

Original cover letter:

---

The CXL Port Protocol error handling series grew to be over 30 patches
which is too much to handle at once given the various topics involved.
One of the sub-threads of the v14 review was confusion about the new
devres groups to manage port setup unwind failures [2].

[2]: http://lore.kernel.org/20260115144605.00000666@huawei.com

Given that review indicated a need to break up and better explain the
conversion, do that in a separate patch set. Build on top of the first
18 patches of that series [3] that are ready to merge.

[3]: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=for-7.0/cxl-aer-prep

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
  cxl/port: Map Port RAS registers

 drivers/cxl/core/core.h              |  10 ++
 drivers/cxl/cxl.h                    |  33 +++---
 drivers/cxl/cxlmem.h                 |   4 +-
 drivers/cxl/cxlpci.h                 |  12 +-
 tools/testing/cxl/exports.h          |  13 ---
 drivers/cxl/core/hdm.c               |   6 +-
 drivers/cxl/core/pci.c               |   8 +-
 drivers/cxl/core/port.c              | 159 +++++++++++++++++----------
 drivers/cxl/core/ras.c               |  50 ++++++---
 drivers/cxl/mem.c                    |   2 -
 drivers/cxl/pci.c                    |  63 +----------
 drivers/cxl/port.c                   | 122 ++++++++++++++++++++
 tools/testing/cxl/cxl_core_exports.c |  22 ----
 tools/testing/cxl/test/mock.c        |  36 ++----
 tools/testing/cxl/Kbuild             |   3 +-
 15 files changed, 310 insertions(+), 233 deletions(-)
 delete mode 100644 tools/testing/cxl/exports.h


base-commit: 9a8920ca8ebfb99604f639e7fbc681d0d04518a0
-- 
2.52.0

