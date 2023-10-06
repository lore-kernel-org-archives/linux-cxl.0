Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8472563DE
	for <linux-cxl@vger.kernel.org>; Fri,  6 Oct 2023 07:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jJOQgUD/"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B95BEA
	for <linux-cxl@vger.kernel.org>; Fri,  6 Oct 2023 00:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696577511; x=1728113511;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wCgkH/9ZLlrpDJn3Yyc1ccLVt5SWnpL98QOz+1Svdio=;
  b=jJOQgUD/NOB5x8X2wA77BvoAZ3SwbF66vsao83trHWwDX56gNgujlOYT
   bwLJdjGMwlsjp6VbrQrqeFa49Cor83x2qT9pNk6DM9ZFN9vL6P9QY7sjc
   kkr+W4eMSWat9J2dyjFCNMupSM6RuvWgACNFH125vyVBn/SthX8TpeBVB
   eH0LSVAD4Ea81zLxwgov0L4tx5VKpU4dE67ud4C/lE3fgfJqv8kAp2ULg
   AOmSjbpUDAsXjrBP7UqC6+2mU0WezxmSpmtyVo60CXmn4BtT3vB4vWvLB
   1MnJMaQ61+Cc+/czEVIbJ6fXxegt/8wCjwxIHyLm45R7FyR6+ITcjuI/P
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="368775580"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="368775580"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 00:31:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="842736360"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="842736360"
Received: from wbleichn-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.147.24])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 00:31:46 -0700
Subject: [ndctl PATCH 2/2] cxl/test: Validate sanitize notifications
From: Dan Williams <dan.j.williams@intel.com>
To: vishal.l.verma@intel.com
Cc: Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org
Date: Fri, 06 Oct 2023 00:31:46 -0700
Message-ID: <169657750601.1491881.9906006449269786700.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <169657749402.1491881.12666757616880845510.stgit@dwillia2-xfh.jf.intel.com>
References: <169657749402.1491881.12666757616880845510.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Exercise the memX/security/sanitize and memX/security/state ABIs by setting
up cxl_test to emulate a 2 second sanitize operation, and use 'cxl
wait-sanitize' to validate the notification fires.

Also implement a negative test for the kernel protecting against submitting
sanitize while a device has mapped decoders.

Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 test/cxl-sanitize.sh |   76 ++++++++++++++++++++++++++++++++++++++++++++++++++
 test/meson.build     |    2 +
 2 files changed, 78 insertions(+)
 create mode 100644 test/cxl-sanitize.sh

diff --git a/test/cxl-sanitize.sh b/test/cxl-sanitize.sh
new file mode 100644
index 000000000000..9c161014ccb7
--- /dev/null
+++ b/test/cxl-sanitize.sh
@@ -0,0 +1,76 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2022 Intel Corporation. All rights reserved.
+
+. $(dirname $0)/common
+
+rc=77
+
+set -ex
+
+trap 'err $LINENO' ERR
+
+check_prereq "jq"
+
+modprobe -r cxl_test
+modprobe cxl_test
+rc=1
+
+# THEORY OF OPERATION: Find a memdev with programmed decoders, validate
+# that sanitize requests fail. Find a memdev without programmed
+# decoders, validate that submission succeeds, and validate that the
+# notifier fires.
+
+mem_to_host()
+{
+	host=$("$CXL" list -m $1 | jq -r '.[].host')
+	echo $host
+}
+
+set_timeout()
+{
+	host=$(mem_to_host $1)
+	echo $2 > /sys/bus/platform/devices/$host/sanitize_timeout
+}
+
+# find all memdevs
+readarray -t all_mem < <("$CXL" list -b cxl_test -M | jq -r '.[].memdev')
+
+# try to sanitize an active memdev
+readarray -t active_mem < <("$CXL" list -b cxl_test -RT | jq -r '.[].mappings[].memdev')
+count=${#active_mem[@]}
+((count > 0)) || err $LINENO
+
+# set timeout to 2 seconds
+set_timeout ${active_mem[0]} 2000
+
+# sanitize with an active memdev should fail
+echo 1 > /sys/bus/cxl/devices/${active_mem[0]}/security/sanitize && err $LINENO
+
+# find an inactive mem
+inactive=""
+for mem in ${all_mem[@]}; do
+	inactive=$mem
+	for active in ${active_mem[@]}; do
+		if [ $mem = $active ]; then
+			inactive=""
+		fi
+	done
+	if [ -z $inactive ]; then
+		continue;
+	fi
+	break
+done
+[ -z $inactive ] && err $LINENO
+
+# kickoff a background sanitize and make sure the wait takes a couple
+# secounds
+set_timeout $inactive 3000
+start=$SECONDS
+echo 1 > /sys/bus/cxl/devices/${inactive}/security/sanitize &
+"$CXL" wait-sanitize $inactive || err $LINENO
+((SECONDS > start + 2)) || err $LINENO
+
+check_dmesg "$LINENO"
+
+modprobe -r cxl_test
diff --git a/test/meson.build b/test/meson.build
index 224adaf41fcc..b7c44f319dad 100644
--- a/test/meson.build
+++ b/test/meson.build
@@ -157,6 +157,7 @@ cxl_create_region = find_program('cxl-create-region.sh')
 cxl_xor_region = find_program('cxl-xor-region.sh')
 cxl_update_firmware = find_program('cxl-update-firmware.sh')
 cxl_events = find_program('cxl-events.sh')
+cxl_sanitize = find_program('cxl-sanitize.sh')
 
 tests = [
   [ 'libndctl',               libndctl,		  'ndctl' ],
@@ -186,6 +187,7 @@ tests = [
   [ 'cxl-create-region.sh',   cxl_create_region,  'cxl'   ],
   [ 'cxl-xor-region.sh',      cxl_xor_region,     'cxl'   ],
   [ 'cxl-events.sh',          cxl_events,         'cxl'   ],
+  [ 'cxl-sanitize.sh',        cxl_sanitize,       'cxl'   ],
 ]
 
 if get_option('destructive').enabled()

