Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DD23A9DB2
	for <linux-cxl@vger.kernel.org>; Wed, 14 Oct 2026 04:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791951484; cv=none; b=VWmnhbDv2ffJedCaGOuAz6NBa+Jw9Xkx3Eadmzc4ceMrq21RlQmEKML/H/oqLqdaaCRrhHfFVwht6uyrYqvasHHougBrNQXQQPEzt7YBXHVgWB2h6mRjGw+fxQm0zHAaqaReyetnzr06i3V8qpiL3ywOV3hFcBl7npQN4WvkdVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791951484; c=relaxed/simple;
	bh=B8qyGRtlABhN0hKjohyw9Z9rruZV7wrWU4D6XCXt6sU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sG+egt9LKFVIKfrPib6so1vdust4HQ4QZmwbNkqU7fZIGPNcCvFhWYwP7f9NmhilsfN3NjuxGP+MN6nEVHF78c7hSR3qsA489H7dbIkV1XFbjsehYkAsF0ju3k2fLHtx2fZTS57k6W/FXZU5uS6B05I0kiCIOzrFQhIfFxxJzog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OLHg/yyg; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OLHg/yyg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791951483; x=1823487483;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B8qyGRtlABhN0hKjohyw9Z9rruZV7wrWU4D6XCXt6sU=;
  b=OLHg/yyguxvokeGhLWo2wnMOGMfSXyY6MZUr6bUpOYouwwjee0/cfNcG
   gEYl491JyaS/c9nYNg1toifJOjGCT2ULcyyzSA7VU8DofBgPtR18ydY7O
   gCWZXBMRl6mcGdO412Lf0X6lY3fZlics295c9gakcg/MWRgqnIui8wriU
   f1wRqusiMTjg8C/WZPjQ8TT1zCBSNY2xU/G6PxH/HrcJBFA+TXYrE/75y
   Xy53gwcoJfeqEnugfUIy3hNwdI+x3RfpY2BRW8FxEDCJMI+hDr7ILDygD
   VOj9Mk1BtBFWiaLm6OtbSlGOKcIRwjxEAy/96nw7mnyrMfxVMSzNknO9x
   A==;
X-CSE-ConnectionGUID: Pvv5ZQu4QW6dGFJ6vDWb1Q==
X-CSE-MsgGUID: j9I+XQlUTxae4ubmudyHuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="696239"
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="696239"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 21:18:01 -0700
X-CSE-ConnectionGUID: VbaVXJuqTO6j0yJm+LSYng==
X-CSE-MsgGUID: JUVy6PQuTP2JUrPXb3HLDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="1783572"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.192])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 21:18:01 -0700
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
Subject: [PATCH 1/4] Documentation/driver-api/cxl: Add a testing page
Date: Tue, 13 Oct 2026 21:17:52 -0700
Message-ID: <7af9e1341a24928799d88adaa6144c1ca82091f7.1791949910.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1791949910.git.alison.schofield@intel.com>
References: <cover.1791949910.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CXL documentation does not describe the subsystem's testing
infrastructure or provide guidance on choosing between cxl_test
and KUnit.

Add a testing page that describes when to use each framework, how
to run the tests, and how to add a CXL KUnit test.

Suggested-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 Documentation/driver-api/cxl/index.rst   |   1 +
 Documentation/driver-api/cxl/testing.rst | 117 +++++++++++++++++++++++
 2 files changed, 118 insertions(+)
 create mode 100644 Documentation/driver-api/cxl/testing.rst

diff --git a/Documentation/driver-api/cxl/index.rst b/Documentation/driver-api/cxl/index.rst
index 3dfae1d310ca..786c189366ca 100644
--- a/Documentation/driver-api/cxl/index.rst
+++ b/Documentation/driver-api/cxl/index.rst
@@ -15,6 +15,7 @@ that have impacts on each other.  The docs here break up configurations steps.
    theory-of-operation
    maturity-map
    conventions
+   testing
 
 .. toctree::
    :maxdepth: 2
diff --git a/Documentation/driver-api/cxl/testing.rst b/Documentation/driver-api/cxl/testing.rst
new file mode 100644
index 000000000000..e3e2613172a2
--- /dev/null
+++ b/Documentation/driver-api/cxl/testing.rst
@@ -0,0 +1,117 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===========
+Testing CXL
+===========
+
+CXL testing uses two complementary frameworks: cxl_test exercises the driver
+stack against an emulated CXL topology, while KUnit tests self-contained logic
+in isolation. Changes should preserve existing test coverage and extend the
+framework appropriate to the behavior being changed.
+
+cxl_test
+========
+
+The cxl_test modules, built from tools/testing/cxl/, emulate a CXL topology with
+host bridges, switches, memory devices, and mailboxes. This allows the CXL driver
+stack to be tested without hardware. The tests are maintained in the ndctl repo
+at https://github.com/pmem/ndctl, under test/cxl-<name>.sh.
+
+Use cxl_test for behavior that depends on a live topology: port and endpoint
+enumeration, region creation and assembly, decoder commit, and anything that
+crosses the sysfs ABI.
+
+Build the cxl_test modules from the top of the kernel tree::
+
+  make M=tools/testing/cxl
+
+After installing the modules for the running kernel, run the CXL suite from an
+ndctl build::
+
+  meson test -C build --suite cxl
+
+For more on building and running the ndctl unit tests, see:
+
+- the Unit Tests section of the ndctl README,
+  https://github.com/pmem/ndctl?tab=readme-ov-file#unit-tests
+- the ndctl test runner,
+  https://github.com/pmem/ndctl-test-runner?tab=readme-ov-file#ndctl-test-runner
+
+
+KUnit
+=====
+
+KUnit tests run self-contained logic in the kernel without any CXL topology.
+KUnit is suited to logic that can be exercised with controlled test inputs,
+including encode/decode helpers, address translation and interleave calculations,
+parsers of device- or firmware-supplied data, and mailbox command handling
+through a stub transport.
+
+To run all of the CXL KUnit tests, from the top of the kernel tree::
+
+  ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/cxl
+
+This builds a test kernel in .kunit/ using drivers/cxl/.kunitconfig and runs it
+under User Mode Linux (UML). The running kernel is not modified, and no
+installation is required. The test kernel runs the tests, reports the results,
+and exits.
+
+Add --arch=x86_64 to run the tests under QEMU instead.
+
+Running during development
+--------------------------
+
+kunit.py builds in .kunit/, but kbuild does not allow an out-of-tree build when
+the source tree already contains an in-tree build. If you build the kernel
+in-tree, use a separate worktree for KUnit. The worktree contains the committed
+sources at the selected revision::
+
+  git worktree add ../linux-kunit HEAD
+  cd ../linux-kunit
+  ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/cxl
+
+To run a single suite, name it::
+
+  ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/cxl cxl_core_mbox
+
+Enable KASAN when testing memory safety error paths. It can detect an out-of-bounds
+access even when the resulting value does not cause a test assertion to fail::
+
+  ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/cxl \
+      --arch=x86_64 --kconfig_add CONFIG_KASAN=y
+
+Adding a KUnit test
+-------------------
+
+A CXL KUnit test follows these rules:
+
+- Place the test in a tests/ directory beside the code under test, in a
+  file named <name>_kunit.c.
+
+- Derive the module and suite names from the path below drivers/cxl/, excluding
+  tests/. For example, drivers/cxl/core/tests/port_kunit.c produces module
+  cxl_core_port_kunit and suite cxl_core_port, while drivers/cxl/tests/port_kunit.c
+  produces module cxl_port_kunit and suite cxl_port.
+
+- Build new suites under CONFIG_CXL_KUNIT_TEST rather than introducing a separate
+  Kconfig option for each suite. Individual suites can be selected by name with
+  kunit.py or by loading their module.
+
+- If the code under test depends on another configuration option, such as
+  CONFIG_CXL_REGION, make the test build conditional on that option in tests/Makefile
+  and enable it in drivers/cxl/.kunitconfig.
+
+- Use exported interfaces where possible, importing the CXL symbol namespace as needed.
+
+When to add a test
+==================
+
+New or modified self-contained logic should be accompanied by KUnit coverage where
+practical. Extend an existing suite when possible, or introduce a new one for
+functionality that is not yet covered.
+
+Bug fixes should include regression coverage that reproduces the problem without
+the fix.
+
+Changes to topology-dependent behavior should be covered by cxl_test tests in ndctl.
+KUnit coverage complements, but does not replace, cxl_test.
-- 
2.37.3

