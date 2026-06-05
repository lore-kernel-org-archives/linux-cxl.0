Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5369D3D3CF2
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jun 2026 21:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780694386; cv=none; b=lh+JdSZQ9MJJEOTpilZPMLig/knLr1AiqEKBMftvduSNfqtxRFw8g6Fj7xiWSPGwm3c0RCphr0TashrjHx4aDR6REKgVTfBUw116HNsIRGQf/Qcl5mm8QW59NokBumidRlohKNe3uQrR8/OLePjcu63fPSZbsDqjvkIFBgtl2o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780694386; c=relaxed/simple;
	bh=Mh1oQ0uFlkU8AfZR8xtW2zvtlUdY/4dRdyJOeaNOMYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DuwXwcin4jDTM+wc5W6ZRPHOHoLxujqvn0Ul73aYneP0Hq2/cXe/yswq6q5qL5QF+w8GjJ8EZC+jAtfmvhE7BsADoyVGab+xrhcbwaht1MZKfzgbOjH5IPIHf3gjlU5Byc7aYP+Bj040mfg4rAPz32nSGJzUbS7gJ8I1Z/cg2iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=elwND/tp; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="elwND/tp"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8ce9d444173so28830846d6.2
        for <linux-cxl@vger.kernel.org>; Fri, 05 Jun 2026 14:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1780694373; x=1781299173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l77sljwLY2ZMyEKXbyo6m0iIvdzx8NQv05f4wwNhT4k=;
        b=elwND/tpDb3VBKDfYFF8ueWkRH9DetB77KKruGp0eXBXxfTBdou9SFVBf2KLTju3Qc
         +0euQnGzK6Kgu09fX2BBWo5TqfQBtik9HtG55rQhLwZEESfSbSQTNbgJlxI9O2W2An5B
         dHvqduQl+2SUkNz6M0ZX/FgEMoZOaHkq1/OMA4+4qDUFihMlaWeNHwSTOjwyYLin9geZ
         rq1SsMrAhCHa0hPim3LG8ZAOFIU8Z/KkOVRQSi+b6glV9GVVDWR8F1LD+bmlkIcjFSK2
         yskQKOM00pyfLMrQVTNA9SeJEVXtZEmpI0b7ndF3YqtOvvbxD0VM2nMj2AyVlkxd+fBR
         i06A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780694373; x=1781299173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l77sljwLY2ZMyEKXbyo6m0iIvdzx8NQv05f4wwNhT4k=;
        b=L0zyZkxOZzfJUo66PAfXJGSQG8puZMZp4ic0ypQE6GXXfh+KBERy3QzsDTKBNnftBm
         4824sEbA0BaumoGUvaPzsG9hzARKnnROOK//ywOCEYgWUCcm2CyD+lDc1hUuZl+3L5Tq
         lxd6qlFywXH8jEPfREMqS8lBobqyCNTRf8wmOqxcmRU5IFNIzqHiFdWiu8k35Lja0tMM
         1Tc3gOE5dBu363YJGjj73bQcAM0HZhVZMLEyg8uAuGcxJfqGWJPSiK8dvrCUytFcVPTa
         o4XJ9K7AS+INo4gt2byDFPyf7gi8rZhEyP8lLA//EhwxCTGlgfwQz6Cdk9Zoyf1meK5U
         tOMg==
X-Forwarded-Encrypted: i=1; AFNElJ8WO4pMaq53oqkm73FvJ3I0sADX9Kzri0S0svVv8x3CwbDNpa0FYOX9N172F6xN9Ps2FqkqQYvBsvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOlT4tj+fhUlnwGblXkeET2r8bUSoBxub3104M45peq1NagkKQ
	NghJFNDT7sQgDmKxCMA5ZB7X+FbqPU9zcKLMpDysK7N3rxeJ/8lW1+B7+k2dNLchUQQ=
X-Gm-Gg: Acq92OHQBDReLk7DuACHZ0a5EwijabxtAj7Aj/KjvHReiv/SJiw6X4KuEof3B5BpkoN
	cVdCscx+ZMf7L7pXWfdWSYGC9wo0DKNpO9Ev/uTKOdse+Pd5i6E7Par83asKSSEjyVFtBM9P1LD
	AFxgCj57uoAP+jhk7e+n1VDUvE80/0bQrInVEeC3EehRAVf++EtZ1+A0TW3k1r+Lndv2YYwuTo0
	SRvV+N92LyZbqpbNFQ+jFm5/KJ19oyOUW/an7U0W+sT8wTb8mzuhFYQJ+NRyTaHF6RCuH02DVqU
	CaMXv7H02GoIbwS6ZqVNP/uDTVtW3NCwKnec8pvTHyrXEh0SjRRyWKezfdiRMmpSieRdbyX/KzH
	kzdjKJGawVR4+wf87FXb2s1n1lHZNPaWFp7bZFlO+jMV4c/EcFX1neueKy372oPNot0prMo9Enw
	wnBOpqWUgAVF37ZeLQ7xp22DfCdFLazkU4BNsSvofZnXR6eePMmxjUwaWOTGCuyxVFFTL3nFTPl
	NNq/+oZPwOGxcb8HxhuOxGjWI7SSX0MpQ==
X-Received: by 2002:a05:6214:2aad:b0:8ca:2559:8886 with SMTP id 6a1803df08f44-8cee5fbda5cmr92189846d6.13.1780694373324;
        Fri, 05 Jun 2026 14:19:33 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd277bbcsm90518196d6.49.2026.06.05.14.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 14:19:32 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org,
	nvdimm@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	linux-cxl@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	djbw@kernel.org,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	osalvador@suse.de,
	shuah@kernel.org,
	gourry@gourry.net,
	alison.schofield@intel.com,
	Smita.KoralahalliChannabasappa@amd.com,
	ira.weiny@intel.com,
	apopple@nvidia.com
Subject: [PATCH v4 9/9] selftests/dax: add dax/kmem hotplug sysfs regression test
Date: Fri,  5 Jun 2026 22:19:11 +0100
Message-ID: <20260605211911.2160954-10-gourry@gourry.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605211911.2160954-1-gourry@gourry.net>
References: <20260605211911.2160954-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a kselftest for the dax/kmem whole-device "hotplug" sysfs attribute
(/sys/bus/dax/devices/daxX.Y/hotplug), which transitions a kmem-backed
dax device between "unplugged", "online" and "online_movable".

Provisioning a devdax device and binding it to kmem needs daxctl/ndctl
(or the tools/testing/nvdimm emulation) and is out of scope for an
in-tree selftest, so the test discovers an already kmem-bound dax device
and SKIPs (KSFT_SKIP) when none is present or when the memory cannot be
freed to reach a known baseline.

When a device is available it validates the interface contract:
  - online / online_movable actually add memory (MemTotal grows),
  - online is idempotent,
  - switching between online types without an intervening unplug is
    rejected,
  - unplug removes the memory and the reported state matches reality,
  - invalid input is rejected.

In particular it covers the online -> unplug -> online_movable -> unplug
cycle: a re-online must re-reserve the per-range resources so that a
subsequent unplug actually offlines and removes the memory instead of
silently reporting success while the memory stays online.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/dax/Makefile          |   6 +
 tools/testing/selftests/dax/config            |   4 +
 .../testing/selftests/dax/dax-kmem-hotplug.sh | 145 ++++++++++++++++++
 tools/testing/selftests/dax/settings          |   1 +
 5 files changed, 157 insertions(+)
 create mode 100644 tools/testing/selftests/dax/Makefile
 create mode 100644 tools/testing/selftests/dax/config
 create mode 100755 tools/testing/selftests/dax/dax-kmem-hotplug.sh
 create mode 100644 tools/testing/selftests/dax/settings

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 6e59b8f63e41..8c2b4f97619c 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -14,6 +14,7 @@ TARGETS += core
 TARGETS += cpufreq
 TARGETS += cpu-hotplug
 TARGETS += damon
+TARGETS += dax
 TARGETS += devices/error_logs
 TARGETS += devices/probe
 TARGETS += dmabuf-heaps
diff --git a/tools/testing/selftests/dax/Makefile b/tools/testing/selftests/dax/Makefile
new file mode 100644
index 000000000000..25a4f3d73a5b
--- /dev/null
+++ b/tools/testing/selftests/dax/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+all:
+
+TEST_PROGS := dax-kmem-hotplug.sh
+
+include ../lib.mk
diff --git a/tools/testing/selftests/dax/config b/tools/testing/selftests/dax/config
new file mode 100644
index 000000000000..4c9aaeb6ceb4
--- /dev/null
+++ b/tools/testing/selftests/dax/config
@@ -0,0 +1,4 @@
+CONFIG_DEV_DAX=m
+CONFIG_DEV_DAX_KMEM=m
+CONFIG_MEMORY_HOTPLUG=y
+CONFIG_MEMORY_HOTREMOVE=y
diff --git a/tools/testing/selftests/dax/dax-kmem-hotplug.sh b/tools/testing/selftests/dax/dax-kmem-hotplug.sh
new file mode 100755
index 000000000000..705a34cc3c6d
--- /dev/null
+++ b/tools/testing/selftests/dax/dax-kmem-hotplug.sh
@@ -0,0 +1,145 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Exercise the dax/kmem whole-device "hotplug" sysfs attribute:
+#   /sys/bus/dax/devices/daxX.Y/hotplug  ->  unplugged | online | online_movable
+#
+# The test needs a dax device already bound to the kmem driver (so the
+# 'hotplug' attribute exists).  Provisioning a devdax device and binding it to
+# kmem requires daxctl/ndctl (or the tools/testing/nvdimm emulation) and is out
+# of scope here; if no suitable device is found the test SKIPs.
+#
+# To actually run it, provision a kmem-backed dax device first.  For example,
+# carve a chunk of RAM into an emulated pmem region via the kernel command line
+# (the region must be at least one memory block, e.g. 128MiB on x86):
+#
+#   memmap=2G!4G
+#
+# then, in the booted system:
+#
+#   ndctl create-namespace -m devdax -e namespace0.0 -f
+#   daxctl reconfigure-device -N -m system-ram dax0.0   # binds the kmem driver
+#   ./dax-kmem-hotplug.sh
+
+DIR="$(dirname "$(readlink -f "$0")")"
+. "$DIR"/../kselftest/ktap_helpers.sh
+
+DAX_BASE=/sys/bus/dax/devices
+
+memtotal_kb() { awk '/^MemTotal:/ {print $2}' /proc/meminfo; }
+get_state() { cat "$HP" 2>/dev/null; }
+# set_state STATE -- write a state to the hotplug attribute; returns the
+# write's exit status (0 = accepted by the kernel)
+set_state() { echo "$1" > "$HP" 2>/dev/null; }
+
+find_kmem_dax() {
+	local d drv
+	for d in "$DAX_BASE"/dax*; do
+		[ -e "$d/hotplug" ] || continue
+		drv=$(readlink "$d/driver" 2>/dev/null)
+		[ "$(basename "${drv:-}")" = kmem ] || continue
+		basename "$d"
+		return 0
+	done
+	return 1
+}
+
+ktap_print_header
+
+if [ "$UID" != 0 ]; then
+	ktap_skip_all "must be run as root"
+	exit "$KSFT_SKIP"
+fi
+
+DAX=$(find_kmem_dax)
+if [ -z "$DAX" ]; then
+	ktap_skip_all "no kmem-bound dax device with a hotplug attribute"
+	exit "$KSFT_SKIP"
+fi
+HP=$DAX_BASE/$DAX/hotplug
+ORIG=$(get_state)
+
+# A failure to reach the baseline is environmental (memory in use), not an
+# interface failure, so skip rather than fail.
+set_state unplugged; rc=$?
+if [ "$rc" != 0 ] || [ "$(get_state)" != unplugged ]; then
+	ktap_skip_all "$DAX: cannot reach 'unplugged' baseline (memory in use?)"
+	[ -n "$ORIG" ] && set_state "$ORIG"
+	exit "$KSFT_SKIP"
+fi
+mt_unplugged=$(memtotal_kb)
+
+ktap_print_msg "using $DAX (initial state was: $ORIG)"
+ktap_set_plan 8
+
+set_state online; rc=$?
+mt_online=$(memtotal_kb)
+if [ "$rc" = 0 ] && [ "$(get_state)" = online ] && [ "$mt_online" -gt "$mt_unplugged" ]; then
+	ktap_test_pass "online: state=online, MemTotal $mt_unplugged -> $mt_online kB"
+else
+	ktap_test_fail "online: rc=$rc state=$(get_state) MemTotal $mt_unplugged -> $mt_online"
+fi
+
+set_state online; rc=$?
+if [ "$rc" = 0 ] && [ "$(get_state)" = online ]; then
+	ktap_test_pass "online idempotent"
+else
+	ktap_test_fail "online idempotent: rc=$rc state=$(get_state)"
+fi
+
+set_state online_movable; rc=$?
+if [ "$rc" != 0 ] && [ "$(get_state)" = online ]; then
+	ktap_test_pass "reject online_movable without intervening unplug"
+else
+	ktap_test_fail "online->online_movable not rejected: rc=$rc state=$(get_state)"
+fi
+
+set_state unplugged; rc=$?
+mt=$(memtotal_kb)
+if [ "$rc" = 0 ] && [ "$(get_state)" = unplugged ] && [ "$mt" -lt "$mt_online" ]; then
+	ktap_test_pass "unplug from online: MemTotal $mt_online -> $mt kB"
+else
+	ktap_test_fail "unplug from online: rc=$rc state=$(get_state) MemTotal $mt_online -> $mt"
+fi
+
+set_state online_movable; rc=$?
+mt_mov=$(memtotal_kb)
+if [ "$rc" = 0 ] && [ "$(get_state)" = online_movable ] && [ "$mt_mov" -gt "$mt_unplugged" ]; then
+	ktap_test_pass "online_movable after unplug: MemTotal $mt_unplugged -> $mt_mov kB"
+else
+	ktap_test_fail "online_movable after unplug: rc=$rc state=$(get_state) MemTotal=$mt_mov"
+fi
+
+# The online -> unplug -> online_movable -> unplug cycle once regressed: a
+# re-online failed to re-reserve the per-range resources, so this final unplug
+# reported success while leaving the memory online.  Assert it is really freed.
+set_state unplugged; rc=$?
+mt=$(memtotal_kb)
+if [ "$rc" != 0 ]; then
+	ktap_test_skip "unplug from movable not accepted (memory in use?) rc=$rc"
+elif [ "$(get_state)" = unplugged ] && [ "$mt" -lt "$mt_mov" ]; then
+	ktap_test_pass "unplug from online_movable removed memory: $mt_mov -> $mt kB"
+else
+	ktap_test_fail "unplug success but memory remained: $(get_state) $mt_mov -> $mt kB"
+fi
+
+set_state online_kernel; rc=$?
+mt=$(memtotal_kb)
+if [ "$rc" = 0 ] && [ "$(get_state)" = online_kernel ] && [ "$mt" -gt "$mt_unplugged" ]; then
+	ktap_test_pass "online_kernel: MemTotal $mt_unplugged -> $mt kB"
+else
+	ktap_test_fail "online_kernel: rc=$rc state=$(get_state) MemTotal=$mt"
+fi
+set_state unplugged
+
+before=$(get_state)
+set_state bogus_state; rc=$?
+if [ "$rc" != 0 ] && [ "$(get_state)" = "$before" ]; then
+	ktap_test_pass "reject invalid state string"
+else
+	ktap_test_fail "invalid state not rejected: rc=$rc state=$(get_state)"
+fi
+
+[ -n "$ORIG" ] && set_state "$ORIG"
+
+ktap_finished
diff --git a/tools/testing/selftests/dax/settings b/tools/testing/selftests/dax/settings
new file mode 100644
index 000000000000..ba4d85f74cd6
--- /dev/null
+++ b/tools/testing/selftests/dax/settings
@@ -0,0 +1 @@
+timeout=90
-- 
2.54.0

