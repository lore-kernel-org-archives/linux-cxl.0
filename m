Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793646920;
	b=oQLhUx9ZNzODyKfP1akTcOlJzR1K2eKZezr9FNKYWAjl7bcsXoAp1GotTH9S2D4Ed8x9
	 uvrvqY54hkL9FeZxiq9c25r97VBBclHnwqRWN+/YLSUDnzhpp/Mc+Mh6rlLddHLMHa2Ys
	 elskSKPyR5u7rz73HnsIoOJomxQiXiMvqy+Aqa3wXGxw9T67JkkY+TP0ov/RsNSDDNB1e
	 jdXLeV92Shv3nifWKy5nxF+lJgco+RzEsRWGAZ8KSFXipLQc7P4NgeEXB3d5dJXDx462s
	 vlC7Vqrqzi11RCz21nPUiyX3Di5IUKtiiD4bzMIIrJfRsB3aVd5Y1brH45PyTQX9F4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793646920;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GM9wWFUXHYJFvTJ25KwUKfNBMPoN0wQH6bLJNW2JTBw=;
	b=FMZVnzAPAHqHWvhUF0fpeCL+N/E1kjzCITOk4EBCwz275f1yiviccg5GvGQ/iXplp5Px
	 z+eQahlawGnqmlUbJM/rbd8ssdDwB/QBRdZKNYWTAnvKb27BS+UfqRAPgr8axM9TzrgVC
	 auhCRWca0eB/z+JxI6iZOPuqT6f8oxt+658ideO41Xkc8VPDEgbJHEHITPd1ocNDtH7o+
	 ezuI20EhWI3R0rmU9avRrLZvloWuKsfti74JXnu3DHqf3ubdFtFAnV3uM41oMNRdVQXE3
	 EZZrQNgx94u+S9zurG2pCFmE06f9zBYbeq+PGe4odjnvlxv7uV0yqkAYIhPcyzaXAgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KbW3C2gq;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89998606A33F
	for <linux-cxl@vger.kernel.org>; Mon,  2 Nov 2026 19:15:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89998606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KbW3C2gq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793646919; x=1825182919;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9AVwROzHqm6D2/bEIwyXhjiYjaqm6sS5eu0VkrJhXOs=;
  b=KbW3C2gqsksSfq8Xm8nNwRr8WzIvyZeKaswQDFaf0FfI1kcejPjFOYJe
   +wRvVCvljsirqGZvYMozpJQq75m+y5hX8zV/qiCyHiJZR9R3QgnoLR1Fh
   yRLGmy5pZrnn2nKJfWSaQAMnJ0e4fzhwXwsU4v8YQH49ov95HKno4ctri
   z9D4dfH4z/CoDS1YIzN7lSgAH/Lh+wuTws0Qhr1t8eZjnCJEKcidLCYxG
   +vnz1OUd0yB6WVgtC9kKBtZAE5/k+gsP238ltn4Tp6yZCmDqV4NO8rl1k
   wrNqlKBmOOvBqo6tzhLpPdd+7iC7u7SqibqpdxyUyYcTYtexd3pXHKJs0
   g==;
X-CSE-ConnectionGUID: ZbkxGR1rTQm8w7rXRvvfgQ==
X-CSE-MsgGUID: N696IGybQymAwtdRMTmWvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2383468"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2383468"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 11:15:18 -0800
X-CSE-ConnectionGUID: yWiOc/JbScq9075NXKqiVg==
X-CSE-MsgGUID: 3kqtMqGBTcSbp3Hg0iIc+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6294140"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.109.173])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 11:15:17 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Richard Cheng <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org,
	Anisa Su <anisa.su@samsung.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v2 1/4] Documentation/driver-api/cxl: Add a testing page
Date: Mon,  2 Nov 2026 11:15:11 -0800
Message-ID: <6d6857ad64f05580dca8dbbb2d09b37b7e190406.1793645996.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1793645996.git.alison.schofield@intel.com>
References: <cover.1793645996.git.alison.schofield@intel.com>
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

The CXL documentation does not describe the subsystem's testing
infrastructure or provide guidance on choosing between cxl_test
and KUnit.

Add a testing page that describes when to use each framework, how
to run the tests, and how to add a CXL KUnit test.

Suggested-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Anisa Su <anisa.su@samsung.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 Documentation/driver-api/cxl/index.rst   |   1 +
 Documentation/driver-api/cxl/testing.rst | 136 +++++++++++++++++++++++
 2 files changed, 137 insertions(+)
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
index 000000000000..923492b6bfa9
--- /dev/null
+++ b/Documentation/driver-api/cxl/testing.rst
@@ -0,0 +1,136 @@
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
+Use --arch=<arch> to run the tests under QEMU instead.
+Use --arch=help to list supported architectures.
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
+access even when the resulting value does not cause a test assertion to fail. Run
+under QEMU, for example x86_64::
+
+  ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/cxl \
+      --arch=x86_64 --kconfig_add CONFIG_KASAN=y
+
+Maintaining KUnit tests
+-----------------------
+
+Use loop bounds and table sizes from the code under test, such as ARRAY_SIZE()
+of a lookup table, so tests adapt as the code evolves. Derive expected results
+from the specification, not the implementation, so tests can detect unintended
+behavior changes.
+
+When a patch changes behavior covered by a test, update the test in the same
+patch. For example, add newly supported encodings to a valid-value table or
+adjust the expected errno for a new return code.
+
+A failing test may indicate a regression or a test that needs updating. Run the
+CXL KUnit tests throughout development, not just before posting, to catch either
+case while making changes.
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
+  CONFIG_CXL_REGION, make the test build conditional on that option in
+  tests/Makefile and enable it in drivers/cxl/.kunitconfig.
+
+- Use exported interfaces where possible, importing the CXL symbol namespace as
+  needed.
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

