Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793317482;
	b=SJ4W75ToZ7u/MMOQHuLkXenPgaEixp17URcMLRKAEA8gsez1HpOgk7uzrTLwGwGAn9vJ
	 OLAIML1UbfRb3jdaJxKfumuaEtGSPZsj2ga/thvGXMr1/a+KpX87y24FRbhUCVldXVgbP
	 nRwKontYTkIWyayXlHYoO7yBcnyPGbOmKDCaB7+c5Po+6YqiGY2FGlTzyN6Sawtirno/H
	 Ja9YWiklIroLyAsO8WJqZASWh59PhY1ILrNqWxsltncwb7sa20mQfYIlldLciXWCQfr1M
	 JVMFNGp/9CsIIzZlZ1ysi0Q4c3RWM/A+SHkaGWEVcIZI7fPQsT0HTYxA+svte37y/WA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793317482;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yb373LVMahPHXhPARb7KPryWsGd0kAlYzWpNgah5AIU=;
	b=pbC16i1ThSvldoMgnQm4xWKBYSezQu4FG1EdUW5C5phkrcc3mvzQ5XoWhTEUWn1pz/eq
	 M3aO8dPwcdC9Iu76EKY7/vhJAxnurVTi7N2r/bZzKtcIusqPnpIudzAZOiQcOXIrhdSy0
	 FeDqGs9xGoY4PJoIZjhz5X07YmEHP+HFrvnlDV6QtO78R2ptIaWGs622xseuZl85FXfuL
	 wEUCUpHcR7I1Zrei2MW/AFgzk7JeSSzVmu+JiIuaBfzJpkzJ3b1/7VeWTLNPOcxPW3pXJ
	 3WR0zelo3oEnLBMwITB2FQCFN0URRlTqznmRc16QjE+TN/cBqfyupVQ/hHKTB1DRYSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CwGSR4r9;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB35606A32E
	for <linux-cxl@vger.kernel.org>; Thu, 29 Oct 2026 23:44:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CB35606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CwGSR4r9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793317465; x=1824853465;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xoByWkV84r1/uYTNFWAQVV9c9j5HC5kAXMCdLV3J0+k=;
  b=CwGSR4r9Upx5rqaq+bV3oQXqTjGLlmd5+5VGh4Ksi0iqvX8vnNI6QCbu
   jZiURuOGyGRBWXtRYb27OjyoLps28XDb5mVP+nmCF0fhW9wDOpaPTVGGU
   MShqJjivlK/zEu6yoKBLw9OS77l1oXg+9RTYf+S/yOjDv+yVDCU7dVR9+
   wqtvdY0wzYK3HDA5gVhYZHuvjMAXni9716uXPel+l5pTiXg2KnOXGgu6f
   tCbdYg2y/V12pFmxPltMj8ztmBzTuZXOhuIR3yOiwVtv6Ae6zE/5/6CsU
   5jTS9EOuJ533++1bxNBltkiWCXT6mJVgFHJi4QrCwhaybU/1R/KDNtyY0
   Q==;
X-CSE-ConnectionGUID: b+BOzDIJRlKzzJ7XfhZmyQ==
X-CSE-MsgGUID: D9swkf0MSdSUuKIRxWQRlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2100450"
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="2100450"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 16:44:11 -0700
X-CSE-ConnectionGUID: lVPcZyI1SPi4KbkujdzGBw==
X-CSE-MsgGUID: oTJGEC3DQySnXyYKvCcMow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="5385226"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.109.57])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 16:44:10 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: nvdimm@lists.linux.dev,
	Gregory Price <gourry@gourry.net>
Cc: Alison Schofield <alison.schofield@intel.com>,
	linux-cxl@vger.kernel.org
Subject: [ndctl PATCH v2 4/4] test/daxctl-create.sh: count memory blocks across dax mappings
Date: Thu, 29 Oct 2026 16:44:03 -0700
Message-ID: <4f8ccd305a70f3f63f98a0b489b47ea67773c7f8.1793315621.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1793315621.git.alison.schofield@intel.com>
References: <cover.1793315621.git.alison.schofield@intel.com>
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

Existing tests use single-range devices and cannot detect incorrect memory
block accounting across discontiguous mappings. A two-range device exposed
this bug by reporting only one of its two blocks.

Create a device with two separated mappings and verify its memory block
count against the expected count from both mappings.

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 test/daxctl-create.sh | 58 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/test/daxctl-create.sh b/test/daxctl-create.sh
index 954a112d0f18..c4fe369eac3a 100755
--- a/test/daxctl-create.sh
+++ b/test/daxctl-create.sh
@@ -7,6 +7,9 @@ rc=77
 
 trap 'cleanup $LINENO' ERR
 
+policy=/sys/devices/system/memory/auto_online_blocks
+saved_policy=
+
 modprobe -r cxl_test
 modprobe cxl_test
 $CXL list
@@ -14,6 +17,7 @@ $CXL list
 cleanup()
 {
 	printf "Error at line %d\n" "$1"
+	[[ $saved_policy ]] && echo "$saved_policy" > "$policy"
 	[[ $testdev ]] && reset_dax
 	exit $rc
 }
@@ -396,6 +400,59 @@ daxctl_test7()
 	test_pass
 }
 
+# Test 8: multi-range system-ram
+# Successfully counts every memory block of a device whose two ranges
+# have a gap between them. The memory is never onlined: cxl_test memory
+# is not backed by RAM.
+daxctl_test8()
+{
+	local daxdev_1 daxdev_2 daxdev path m start end n nmaps=0 total=0
+	local bs size
+
+	bs=$((0x$(cat /sys/devices/system/memory/block_size_bytes)))
+	size=$((available / 4))
+	if (( size < bs || size % bs )); then
+		echo "test8: skipped, region too small for $bs byte memory blocks"
+		return 0
+	fi
+
+	# a devdax device in the gap between the two ranges, it has no
+	# memory blocks to be miscounted
+	daxdev_1=$("$DAXCTL" create-device -r "$region_id" -s $size | jq -er '.[].chardev')
+	daxdev_2=$("$DAXCTL" create-device -r "$region_id" -s $size | jq -er '.[].chardev')
+	test -n "$daxdev_2"
+	"$DAXCTL" disable-device "$daxdev_1" && "$DAXCTL" destroy-device "$daxdev_1"
+
+	daxdev=$("$DAXCTL" create-device -r "$region_id" -s $((size * 2)) | jq -er '.[].chardev')
+	test "$(daxctl_get_nr_mappings "$daxdev")" -eq 2
+
+	# memory blocks wholly inside each mapping
+	path=$(readlink -f /sys/bus/dax/devices/"$daxdev")
+	for m in "$path"/mapping[0-9]*; do
+		start=$(cat "$m"/start)
+		end=$(cat "$m"/end)
+		n=$(((end + 1) / bs - (start + bs - 1) / bs))
+		(( n > 0 ))
+		total=$((total + n))
+		nmaps=$((nmaps + 1))
+	done
+	test "$nmaps" -eq 2
+
+	saved_policy=$(cat "$policy")
+	echo offline > "$policy"
+	"$DAXCTL" reconfigure-device -N -m system-ram "$daxdev"
+	test "$("$DAXCTL" list -d "$daxdev" | jq -er '.[].total_memblocks')" -eq "$total"
+	"$DAXCTL" reconfigure-device -m devdax "$daxdev"
+	echo "$saved_policy" > "$policy"
+	saved_policy=
+
+	"$DAXCTL" disable-device -r "$region_id" all
+	"$DAXCTL" destroy-device -r "$region_id" all
+
+	clear_dev
+	test_pass
+}
+
 find_testdev
 rc=1
 setup_dev
@@ -407,6 +464,7 @@ daxctl_test4
 daxctl_test5
 daxctl_test6
 daxctl_test7
+daxctl_test8
 reset_dev
 modprobe -r cxl_test
 exit 0
-- 
2.37.3

