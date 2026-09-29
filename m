Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5063AE6F5
	for <linux-cxl@vger.kernel.org>; Tue, 29 Sep 2026 05:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790660228; cv=none; b=RyuAuSZj9SIi8scY0mBPgevD9lHZ8JIOtLidyCp0SXch+saXTCMC4a871B/Z3Gp3dW1WitB3FWNTKhZmmrR0Jb/Ap0q5JB6KRwG0GR+WJ6mbh0KrtRDntHGh3iKRsb+BJ6/Lx8dmoDY/xcF/qKyn/JWwzV2tNtdniiAFMX8mZZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790660228; c=relaxed/simple;
	bh=Gg5cututDZt+K6F0ag1UEpkkF3MkIqXGhtuSxk+PCZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pi2EZzS2y0v8m9GXPUClyia3z+sKhYTw+TkfXhRePmDb1OXtSN2hmFdi4WNKu35/iSsYLyoQVNoVGdWec73q1OzI3ZhBwoEp6g041WpfHocak0AU4mOC1LBFOSq9Qe1y5e53nHcntLHMDwBsjSjQGqjDRubX4DiErrTKu9jSk44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HvTT6J3n; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HvTT6J3n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790660226; x=1822196226;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Gg5cututDZt+K6F0ag1UEpkkF3MkIqXGhtuSxk+PCZ4=;
  b=HvTT6J3n8eli0nuiWSVsUcmILIFedhVjkgAgbdn2gihMJYJMGr7uCGLn
   i3zT19r1kPePLQ/fQxvHra3pO152/F/yjZqQE2gBti2sVJQcoGmsyn1Yz
   P1nwWsa9cwQJCp7M24tK6nXPYdsl9jZg1Q2kRhf97SyFjWqZYeHdOEVQ2
   un9KuYdgcUfMiC5YXnE/HZoBVqgBvmS7EQZyQQVTKSgWlRfCwld0rKRHQ
   a9OBDeoSHYkJ0EvFv/l1gndklgqiSoDg7oODQHQSDbqa2QTIpj/+FCO+2
   4XDFb2U19+ky7s6YEfqLeylGr810mITMQcSt1/Xe7jHS9afcYUNoSfP9W
   g==;
X-CSE-ConnectionGUID: oHS3j5GpR9akoLNMxe7tnw==
X-CSE-MsgGUID: VPBDuMdKQaaNFOeSTWeWKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="100700062"
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="100700062"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 22:37:04 -0700
X-CSE-ConnectionGUID: Bb9ZMU7JRHyDEdOVb2USVw==
X-CSE-MsgGUID: 5W69uFBwTp61PImIKFI4GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="304767462"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.149])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 22:37:04 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org
Cc: Alison Schofield <alison.schofield@intel.com>
Subject: [ndctl PATCH 1/7] test/cxl-create-region.sh: fold in XOR coverage
Date: Mon, 28 Sep 2026 22:36:53 -0700
Message-ID: <a501e896ed7c59cdfbd45c94145de9cf54f1ed93.1790658549.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1790658549.git.alison.schofield@intel.com>
References: <cover.1790658549.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Region creation coverage is split between cxl-create-region.sh and
cxl-xor-region.sh.

Fold the XOR cases into cxl-create-region.sh so cxl create-region
coverage can share one test harness. Remove cxl-xor-region.sh.

Assisted-by: LLM
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 test/cxl-create-region.sh | 108 +++++++++++++++++++++++++++++++
 test/cxl-xor-region.sh    | 129 --------------------------------------
 test/meson.build          |   2 -
 3 files changed, 108 insertions(+), 131 deletions(-)
 delete mode 100644 test/cxl-xor-region.sh

diff --git a/test/cxl-create-region.sh b/test/cxl-create-region.sh
index 658b9b8ff58a..fcfcea0594bb 100644
--- a/test/cxl-create-region.sh
+++ b/test/cxl-create-region.sh
@@ -133,6 +133,98 @@ create_single()
 	destroy_regions "$region"
 }
 
+create_and_destroy_region()
+{
+	region=$($CXL create-region -d "$decoder" -m "$memdevs" |
+		jq -r ".region")
+
+	if [[ ! $region ]]; then
+		echo "create-region failed for $decoder"
+		err "$LINENO"
+	fi
+
+	destroy_regions "$region"
+}
+
+setup_x1()
+{
+	# Find an x1 decoder
+	decoder=$($CXL list -b cxl_test -D -d root | jq -r ".[] |
+		select(.pmem_capable == true) |
+		select(.nr_targets == 1) |
+		.decoder")
+
+	# Find a memdev for this host-bridge
+	port_dev0=$($CXL list -T -d "$decoder" | jq -r ".[] |
+		.targets | .[] | select(.position == 0) | .target")
+	mem0=$($CXL list -M -p "$port_dev0" | jq -r ".[0].memdev")
+	memdevs="$mem0"
+}
+
+setup_x2()
+{
+	# Find an x2 decoder
+	decoder=$($CXL list -b cxl_test -D -d root | jq -r ".[] |
+		select(.pmem_capable == true) |
+		select(.nr_targets == 2) |
+		.decoder")
+
+	# Find a memdev for each host-bridge interleave position
+	port_dev0=$($CXL list -T -d "$decoder" | jq -r ".[] |
+		.targets | .[] | select(.position == 0) | .target")
+	port_dev1=$($CXL list -T -d "$decoder" | jq -r ".[] |
+		.targets | .[] | select(.position == 1) | .target")
+	mem0=$($CXL list -M -p "$port_dev0" | jq -r ".[0].memdev")
+	mem1=$($CXL list -M -p "$port_dev1" | jq -r ".[0].memdev")
+	memdevs="$mem0 $mem1"
+}
+
+setup_x4()
+{
+	# find an x2 decoder
+	decoder=$($CXL list -b cxl_test -D -d root | jq -r ".[] |
+		select(.pmem_capable == true) |
+		select(.nr_targets == 2) |
+		.decoder")
+
+	# Find a memdev for each host-bridge interleave position
+	port_dev0=$($CXL list -T -d "$decoder" | jq -r ".[] |
+		.targets | .[] | select(.position == 0) | .target")
+	port_dev1=$($CXL list -T -d "$decoder" | jq -r ".[] |
+		.targets | .[] | select(.position == 1) | .target")
+	mem0=$($CXL list -M -p "$port_dev0" | jq -r ".[0].memdev")
+	mem1=$($CXL list -M -p "$port_dev1" | jq -r ".[0].memdev")
+	mem2=$($CXL list -M -p "$port_dev0" | jq -r ".[1].memdev")
+	mem3=$($CXL list -M -p "$port_dev1" | jq -r ".[1].memdev")
+	memdevs="$mem0 $mem1 $mem2 $mem3"
+}
+
+setup_x3()
+{
+	# find an x3 decoder
+	decoder=$($CXL list -b cxl_test -D -d root | jq -r ".[] |
+		select(.pmem_capable == true) |
+		select(.nr_targets == 3) |
+		.decoder")
+
+	if [[ ! $decoder ]]; then
+		echo "no x3 decoder found, skipping xor-x3 test"
+		return
+	fi
+
+	# Find a memdev for each host-bridge interleave position
+	port_dev0=$($CXL list -T -d "$decoder" | jq -r ".[] |
+		.targets | .[] | select(.position == 0) | .target")
+	port_dev1=$($CXL list -T -d "$decoder" | jq -r ".[] |
+		.targets | .[] | select(.position == 1) | .target")
+	port_dev2=$($CXL list -T -d "$decoder" | jq -r ".[] |
+		.targets | .[] | select(.position == 2) | .target")
+	mem0=$($CXL list -M -p "$port_dev0" | jq -r ".[0].memdev")
+	mem1=$($CXL list -M -p "$port_dev1" | jq -r ".[0].memdev")
+	mem2=$($CXL list -M -p "$port_dev2" | jq -r ".[0].memdev")
+	memdevs="$mem0 $mem1 $mem2"
+}
+
 # test region creation on devices behind a single-port host-bridge
 create_single
 
@@ -149,6 +241,22 @@ for mem in ${mems[@]}; do
 	create_subregions "$mem"
 done
 
+# Repeat x1/x2/x3/x4 region creation with XOR interleave arithmetic.
+modprobe -r cxl_test
+modprobe cxl_test interleave_arithmetic=1
+
+setup_x1
+create_and_destroy_region
+setup_x2
+create_and_destroy_region
+setup_x4
+create_and_destroy_region
+# x3 decoder may not be available in cxl/test topo yet
+setup_x3
+if [[ $decoder ]]; then
+	create_and_destroy_region
+fi
+
 check_dmesg "$LINENO"
 
 modprobe -r cxl_test
diff --git a/test/cxl-xor-region.sh b/test/cxl-xor-region.sh
deleted file mode 100644
index fb4f9a0a1515..000000000000
--- a/test/cxl-xor-region.sh
+++ /dev/null
@@ -1,129 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
-# Copyright (C) 2022 Intel Corporation. All rights reserved.
-
-. $(dirname $0)/common
-
-rc=77
-
-set -ex
-
-trap 'err $LINENO' ERR
-
-check_prereq "jq"
-
-modprobe -r cxl_test
-modprobe cxl_test interleave_arithmetic=1
-rc=1
-
-# THEORY OF OPERATION: Create x1,2,3,4 regions to exercise the XOR math
-# option of the CXL driver. As with other cxl_test tests, changes to the
-# CXL topology in tools/testing/cxl/test/cxl.c may require an update here.
-
-create_and_destroy_region()
-{
-	region=$($CXL create-region -d "$decoder" -m "$memdevs" |
-		jq -r ".region")
-
-	if [[ ! $region ]]; then
-		echo "create-region failed for $decoder"
-		err "$LINENO"
-	fi
-
-	$CXL destroy-region -f -b cxl_test "$region"
-}
-
-setup_x1()
-{
-	# Find an x1 decoder
-	decoder=$($CXL list -b cxl_test -D -d root | jq -r ".[] |
-		select(.pmem_capable == true) |
-		select(.nr_targets == 1) |
-		.decoder")
-
-	# Find a memdev for this host-bridge
-	port_dev0=$($CXL list -T -d "$decoder" | jq -r ".[] |
-		.targets | .[] | select(.position == 0) | .target")
-	mem0=$($CXL list -M -p "$port_dev0" | jq -r ".[0].memdev")
-	memdevs="$mem0"
-}
-
-setup_x2()
-{
-	# Find an x2 decoder
-	decoder=$($CXL list -b cxl_test -D -d root | jq -r ".[] |
-		select(.pmem_capable == true) |
-		select(.nr_targets == 2) |
-		.decoder")
-
-	# Find a memdev for each host-bridge interleave position
-	port_dev0=$($CXL list -T -d "$decoder" | jq -r ".[] |
-		.targets | .[] | select(.position == 0) | .target")
-	port_dev1=$($CXL list -T -d "$decoder" | jq -r ".[] |
-		.targets | .[] | select(.position == 1) | .target")
-	mem0=$($CXL list -M -p "$port_dev0" | jq -r ".[0].memdev")
-	mem1=$($CXL list -M -p "$port_dev1" | jq -r ".[0].memdev")
-	memdevs="$mem0 $mem1"
-}
-
-setup_x4()
-{
-	# find an x2 decoder
-	decoder=$($CXL list -b cxl_test -D -d root | jq -r ".[] |
-		select(.pmem_capable == true) |
-		select(.nr_targets == 2) |
-		.decoder")
-
-	# Find a memdev for each host-bridge interleave position
-	port_dev0=$($CXL list -T -d "$decoder" | jq -r ".[] |
-		.targets | .[] | select(.position == 0) | .target")
-	port_dev1=$($CXL list -T -d "$decoder" | jq -r ".[] |
-		.targets | .[] | select(.position == 1) | .target")
-	mem0=$($CXL list -M -p "$port_dev0" | jq -r ".[0].memdev")
-	mem1=$($CXL list -M -p "$port_dev1" | jq -r ".[0].memdev")
-	mem2=$($CXL list -M -p "$port_dev0" | jq -r ".[1].memdev")
-	mem3=$($CXL list -M -p "$port_dev1" | jq -r ".[1].memdev")
-	memdevs="$mem0 $mem1 $mem2 $mem3"
-}
-
-setup_x3()
-{
-	# find an x3 decoder
-	decoder=$($CXL list -b cxl_test -D -d root | jq -r ".[] |
-		select(.pmem_capable == true) |
-		select(.nr_targets == 3) |
-		.decoder")
-
-	if [[ ! $decoder ]]; then
-		echo "no x3 decoder found, skipping xor-x3 test"
-		return
-	fi
-
-	# Find a memdev for each host-bridge interleave position
-	port_dev0=$($CXL list -T -d "$decoder" | jq -r ".[] |
-		.targets | .[] | select(.position == 0) | .target")
-	port_dev1=$($CXL list -T -d "$decoder" | jq -r ".[] |
-		.targets | .[] | select(.position == 1) | .target")
-	port_dev2=$($CXL list -T -d "$decoder" | jq -r ".[] |
-		.targets | .[] | select(.position == 2) | .target")
-	mem0=$($CXL list -M -p "$port_dev0" | jq -r ".[0].memdev")
-	mem1=$($CXL list -M -p "$port_dev1" | jq -r ".[0].memdev")
-	mem2=$($CXL list -M -p "$port_dev2" | jq -r ".[0].memdev")
-	memdevs="$mem0 $mem1 $mem2"
-}
-
-setup_x1
-create_and_destroy_region
-setup_x2
-create_and_destroy_region
-setup_x4
-create_and_destroy_region
-# x3 decoder may not be available in cxl/test topo yet
-setup_x3
-if [[ $decoder ]]; then
-	create_and_destroy_region
-fi
-
-check_dmesg "$LINENO"
-
-modprobe -r cxl_test
diff --git a/test/meson.build b/test/meson.build
index 07c8618cbc6e..d6cd2a3d4b10 100644
--- a/test/meson.build
+++ b/test/meson.build
@@ -162,7 +162,6 @@ cxl_topo = find_program('cxl-topology.sh')
 cxl_sysfs = find_program('cxl-region-sysfs.sh')
 cxl_labels = find_program('cxl-labels.sh')
 cxl_create_region = find_program('cxl-create-region.sh')
-cxl_xor_region = find_program('cxl-xor-region.sh')
 cxl_update_firmware = find_program('cxl-update-firmware.sh')
 cxl_events = find_program('cxl-events.sh')
 cxl_sanitize = find_program('cxl-sanitize.sh')
@@ -201,7 +200,6 @@ tests = [
   [ 'cxl-region-sysfs.sh',    cxl_sysfs,	  'cxl'   ],
   [ 'cxl-labels.sh',          cxl_labels,	  'cxl'   ],
   [ 'cxl-create-region.sh',   cxl_create_region,  'cxl'   ],
-  [ 'cxl-xor-region.sh',      cxl_xor_region,     'cxl'   ],
   [ 'cxl-events.sh',          cxl_events,         'cxl'   ],
   [ 'cxl-sanitize.sh',        cxl_sanitize,       'cxl'   ],
   [ 'cxl-destroy-region.sh',  cxl_destroy_region, 'cxl'   ],
-- 
2.37.3

