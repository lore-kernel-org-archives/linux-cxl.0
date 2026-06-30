Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67109331EA8
	for <linux-cxl@vger.kernel.org>; Tue, 30 Jun 2026 21:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782854350; cv=none; b=C96hlNMIAP4LJvkdmkYUFvWE3tqzrLVoRq2L+r0Nhv0fTBV7LJbj9y8DfRtrTYtXtU6XvBhwR3r8Pp+fL0GM5/Gxmho+F0m9mFUUZqVpO2T8J3fdKxeiDekOmHmEEYG28/UJ+UAjlwyY3AlKtPBH/xV8o/hjU/RftL/qcls2900=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782854350; c=relaxed/simple;
	bh=NMLEQyApfn67zy+KR0tXHlfxllmDKoOrz1Z9hs9Q/eI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tGtiXRmn7fW4XVivjdm9fPHm9rzeAYF7zVSbEazGN+OZWHIriS2MWcDxrqhUABXOgarsXVfvGjaJZbcBQ/TobIRSqzSno2CPRlqhXH2yHLsn5h5cZKbkjqSrou/zBDmM3KA9qrhr+7CbK+iNlBmYoY56IvOjkadjwz/NGCViRJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=E2IWc4aj; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="E2IWc4aj"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-92b21f65b60so105626185a.1
        for <linux-cxl@vger.kernel.org>; Tue, 30 Jun 2026 14:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1782854347; x=1783459147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dr7k1s5kclXSnhlA0wjw73kcYoyYlKmbVekQHgXAunw=;
        b=E2IWc4ajhajVOyfrP3j/A9tGTB1DOq5xWWpof3lgfqYHk67Fr7T3mtfwM7wLq7AUbp
         lSY5/Biha5bbPGej0zBoRXbykIH0KybZUhj48h+W4MOq4iBrlwVfYzBaWZ0q5aZcbxhP
         QXCjPhroUI38r69e/6Dj839Zq5wYH4FZXTdTpLORB7FGPLoFRVZKCRSWjKgbXJOnLff8
         sW9grgjy9dF8oGd03Is4Ctf9i0O6cqi2faUWVpj6ZtbqJeky/yBG3cfzY8sqZlwY0jwT
         RwDS+lq7LTV8GD3oNeJU77cj/KPqLgQHVWigY3c9kY5bUhJ7IpSsdO9+3XXNqY2XbfmH
         ql5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782854347; x=1783459147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Dr7k1s5kclXSnhlA0wjw73kcYoyYlKmbVekQHgXAunw=;
        b=XJGlP0+EKimWhBLTQq/LS7c2+RzXTgZInCmM7OaL5c558vtIlp3c4Bu3LuQh8wATEA
         lGyUVdpCTya4q854nZzwT3PaFGAsTc53tUuXpVR2vR2CjUveaesy+yDh/0xYSiUEZ4k4
         7nEMHjbXu/KQekNFhZ4D2Rysg8P9sHBp235/+GYbzkTb90Qxh/uPtZUOzUHp8z8Pjlla
         E4MXUjlo7JKCGFuKn4Z/8l15Xv5sZwB8ejVzG8Kpa4ngL+VQD7SR48CSSkxlujzbr8YO
         ouv3AC5kOYQKutCpihOz7CgwiYUNQFtMxvAbz5++XmSK7N6YG2PP5ryhcXr9U/9W4rGx
         7ugQ==
X-Forwarded-Encrypted: i=1; AFNElJ/1c6EScRJe01nG2U9X3leIzXBCMWeSkuV53B/c1eSA/oAXC/gAEoRURJbkW5l4vrECY8wUN2GZhqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOHlYTC0V5lbGbzqnKjTNXC3K5AxDgiBrykGrJ8YaWcBnTQVT6
	UTUyhe1OMCWBcCDql32JGtg9t4TZ6AF/PmKM5U8nav3fxAQPYDrSNk1iOhoe9W0cMkU=
X-Gm-Gg: AfdE7ckAzB6SPdAfJoLQZUgiArcCSYnsUjFm0HuJXHwsbomTi1zQ3LQUzZw6pie4KnP
	0Rhi4+ZTDw1PGy7/h/T9EFetQmz9IQNDBjuWdHpZE0eG8/PdqNSzf9cnpoHR7/ftov9awpnOWoD
	c/NnlbeM1FbPBVtVjboxuwgSBt81Ol187fQ+AC1WFV6PE8pVS/QxqTEreYr1ttL5eIFInpp4Pe/
	C4pvgMi1Ln6cqLCxkvsTvmmC533nF/jqvNUpnOk5xGU7w4QOpAPhonb3ho57P8f2Y4d7E5QFwVK
	/hXzlgfWtTMleZEjPodDzML5SMuRVbfLaobVJnh8hEvA9GoVFGA/6FYuVOIX9XoC34IzR6KKV24
	ooqzcMagHqBxXBW0/15lP03H6y8g/jsaZjPRNh01rsmYkiXI/9FsqJHr7Rfbe4opDOEYJCrSitM
	7bcAZO/qeb9/Rbe+QG6DYwRDo/EwkwpFznACMSt8a6TNSlvnjovRMJYxC2WbWaxJgxHLCQmojlD
	/6X57VgGz4c
X-Received: by 2002:a05:620a:4008:b0:92e:5232:91f8 with SMTP id af79cd13be357-92e698667f9mr485377585a.43.1782854347322;
        Tue, 30 Jun 2026 14:19:07 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e62366303sm335924285a.40.2026.06.30.14.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 14:19:06 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	kernel-team@meta.com,
	david@kernel.org,
	osalvador@suse.de,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	djbw@kernel.org,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	akpm@linux-foundation.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	shuah@kernel.org,
	gourry@gourry.net,
	iweiny@kernel.org,
	Smita.KoralahalliChannabasappa@amd.com,
	apopple@nvidia.com
Subject: [PATCH v6 10/10] selftests/dax: add dax/kmem hotplug sysfs regression test
Date: Tue, 30 Jun 2026 17:18:42 -0400
Message-ID: <20260630211842.2252800-11-gourry@gourry.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260630211842.2252800-1-gourry@gourry.net>
References: <20260630211842.2252800-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a kselftest for the dax/kmem whole-device "state" sysfs attribute
(/sys/bus/dax/devices/daxX.Y/state), which transitions a kmem-backed
dax device between "unplugged", "online" and "online_movable".

The kselftest also includes a test to demonstrate the force-unbind
does not deadlock - but this is a destructive test.  The dax device
can never be rebound after doing this.

Provisioning a devdax device and binding it to kmem needs daxctl/ndctl
out of scope for an in-tree selftest, so the test discovers an already
kmem-bound dax device and SKIPs when none are present or the memory
cannot be freed to reach a known baseline.

When a device is available it validates the interface contract:
  - online / online_movable actually add memory (MemTotal grows),
  - online is idempotent,
  - switching between online types without unplug is rejected,
  - unplug removes memory and the reported state is "unplugged"
  - invalid input is rejected.

One specific regression test:
    online -> unplug -> online_movable -> unplug

Re-online must re-reserve per-range resources so subsequent unplug
actually offlines and removes instead of silently reporting success
while the memory stays online.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/dax/Makefile          |   6 +
 tools/testing/selftests/dax/config            |   4 +
 .../testing/selftests/dax/dax-kmem-hotplug.sh | 190 ++++++++++++++++++
 tools/testing/selftests/dax/settings          |   1 +
 5 files changed, 202 insertions(+)
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
index 000000000000..c8bbaf6178ed
--- /dev/null
+++ b/tools/testing/selftests/dax/dax-kmem-hotplug.sh
@@ -0,0 +1,190 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Exercise the dax/kmem "state" sysfs attribute:
+#   /sys/bus/dax/devices/daxX.Y/state  ->  unplugged | online | online_kernel | online_movable
+#
+# The test needs a dax device already bound to the kmem driver.
+# If no suitable device is found the tests SKIP.
+#
+# A dax device can be provisioned with the memmap= boot param, e.g.:
+#   memmap=2G!4G
+#
+# then, in the booted system:
+#
+#   ndctl create-namespace -m devdax -e namespace0.0 -f
+#   daxctl reconfigure-device -N -m system-ram dax0.0   # bind kmem
+#   ./dax-kmem-hotplug.sh
+
+# shellcheck disable=SC1091
+DIR="$(dirname "$(readlink -f "$0")")"
+. "$DIR"/../kselftest/ktap_helpers.sh
+
+DAX_BASE=/sys/bus/dax/devices
+
+memtotal_kb() { awk '/^MemTotal:/ {print $2}' /proc/meminfo; }
+get_state() { cat "$HP" 2>/dev/null; }
+# set_state STATE -- write a state to the state attribute; returns the
+# write's exit status (0 = accepted by the kernel)
+set_state() { echo "$1" > "$HP" 2>/dev/null; }
+
+find_kmem_dax() {
+	local d drv
+	for d in "$DAX_BASE"/dax*; do
+		[ -e "$d/state" ] || continue
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
+	ktap_skip_all "no kmem-bound dax device with a state attribute"
+	exit "$KSFT_SKIP"
+fi
+HP=$DAX_BASE/$DAX/state
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
+DRV=/sys/bus/dax/drivers/kmem
+AOB=/sys/devices/system/memory/auto_online_blocks
+
+ktap_print_msg "using $DAX (initial state was: $ORIG)"
+ktap_set_plan 8
+
+# A public (N_MEMORY) kmem node onlined into a kernel zone (online/online_kernel)
+# collects unmovable allocations and can then never be offlined, which would
+# wedge the device for the rest of this test.  So this test only ever
+# successfully onlines online_movable, the one mode that is reliably unpluggable.
+
+set_state online_movable; rc=$?
+mt_online=$(memtotal_kb)
+if [ "$rc" = 0 ] && [ "$(get_state)" = online_movable ] && [ "$mt_online" -gt "$mt_unplugged" ]; then
+	ktap_test_pass "online_movable: state=online_movable, MemTotal $mt_unplugged -> $mt_online kB"
+else
+	ktap_test_fail "online_movable: rc=$rc state=$(get_state) MemTotal $mt_unplugged -> $mt_online"
+fi
+
+set_state online_movable; rc=$?
+if [ "$rc" = 0 ] && [ "$(get_state)" = online_movable ]; then
+	ktap_test_pass "online_movable idempotent"
+else
+	ktap_test_fail "online_movable idempotent: rc=$rc state=$(get_state)"
+fi
+
+# A different online type is rejected without an intervening unplug.  The write
+# is refused before any hotplug, so this never actually onlines a kernel zone.
+set_state online_kernel; rc=$?
+if [ "$rc" != 0 ] && [ "$(get_state)" = online_movable ]; then
+	ktap_test_pass "reject online_kernel without intervening unplug (no kernel-zone online)"
+else
+	ktap_test_fail "online_movable->online_kernel not rejected: rc=$rc state=$(get_state)"
+fi
+
+set_state unplugged; rc=$?
+mt=$(memtotal_kb)
+if [ "$rc" = 0 ] && [ "$(get_state)" = unplugged ] && [ "$mt" -lt "$mt_online" ]; then
+	ktap_test_pass "unplug from online_movable: MemTotal $mt_online -> $mt kB"
+else
+	ktap_test_fail "unplug from online_movable: rc=$rc state=$(get_state) MemTotal $mt_online -> $mt"
+fi
+
+before=$(get_state)
+set_state bogus_state; rc=$?
+if [ "$rc" != 0 ] && [ "$(get_state)" = "$before" ]; then
+	ktap_test_pass "reject invalid state string"
+else
+	ktap_test_fail "invalid state not rejected: rc=$rc state=$(get_state)"
+fi
+
+# The online_movable -> unplug cycle once regressed: a re-online failed to
+# re-reserve the per-range resources, so a later unplug reported success while
+# leaving the memory online.  Assert each iteration really adds and frees memory.
+set_state unplugged
+cycle_ok=1; fail_i=0; on=0; off=0
+for i in 1 2 3; do
+	if ! set_state online_movable; then cycle_ok=0; fail_i=$i; break; fi
+	on=$(memtotal_kb)
+	if ! set_state unplugged; then cycle_ok=0; fail_i=$i; break; fi
+	off=$(memtotal_kb)
+	if [ "$on" -le "$mt_unplugged" ] || [ "$off" -ge "$on" ]; then
+		cycle_ok=0; fail_i=$i; break
+	fi
+done
+if [ "$cycle_ok" = 1 ]; then
+	ktap_test_pass "online_movable/unplug cycle re-acquires resources (3x: added and freed each time)"
+else
+	ktap_test_fail "online_movable/unplug cycle regressed at iteration $fail_i (on=$on off=$off baseline=$mt_unplugged)"
+fi
+
+# change system default online policy while the device is unbound, and show
+# the new system default policy is utilized across bindings.
+set_state unplugged
+if [ -w "$AOB" ] && [ -w "$DRV/unbind" ] && [ -w "$DRV/bind" ]; then
+	orig_aob=$(cat "$AOB")
+	echo "$DAX" > "$DRV/unbind" 2>/dev/null
+	echo offline > "$AOB" 2>/dev/null
+	echo "$DAX" > "$DRV/bind" 2>/dev/null
+	sleep 1
+	st=$(get_state)
+	echo "$orig_aob" > "$AOB" 2>/dev/null		# restore system policy
+	if [ "$st" = offline ]; then
+		ktap_test_pass "online policy resolved at bind: auto_online_blocks=offline -> state=offline"
+	else
+		ktap_test_fail "bind-time policy not honored: state=$st (expected offline)"
+	fi
+	set_state unplugged 2>/dev/null
+else
+	ktap_test_skip "auto_online_blocks or driver bind/unbind not writable"
+fi
+
+[ -n "$ORIG" ] && set_state "$ORIG"
+
+# DESTRUCTIVE: unbinding the driver while memory is online causes the resources
+# to leak - but the unbind should not deadlock.  Instead the driver leaks it
+# with a single "stuck online" warning. This leaves the memory online and the
+# device unbound until reboot, so it runs last - and only if we can run it,
+# leaving the restored state above untouched otherwise.  online_movable only:
+# this test never onlines a public node into a kernel zone.
+if [ -w "$DRV/unbind" ]; then
+	set_state unplugged; set_state online_movable
+fi
+if [ "$(get_state)" = online_movable ] && [ -w "$DRV/unbind" ]; then
+	mt_on=$(memtotal_kb)
+	dmesg -C 2>/dev/null
+	echo "$DAX" > "$DRV/unbind" 2>/dev/null
+	mt_after=$(memtotal_kb)
+	# The leaked "System RAM (kmem)" regions stay in the iomem tree; reading
+	# their names dereferences res_name, which a buggy unbind already freed.
+	# Walk /proc/iomem to provoke that use-after-free (caught by KASAN).
+	cat /proc/iomem > /dev/null 2>&1
+	splat=$(dmesg 2>/dev/null | grep -ciE "KASAN|BUG:|use-after-free|general protection|Oops|refcount_t")
+	if [ "$splat" = 0 ] && [ "$mt_after" -ge "$mt_on" ]; then
+		ktap_test_pass "unbind while online: memory left online, no UAF/oops (MemTotal $mt_on -> $mt_after kB)"
+	else
+		ktap_test_fail "unbind while online regressed: splat=$splat MemTotal $mt_on -> $mt_after kB"
+	fi
+else
+	ktap_test_skip "could not online device for unbind-while-online test"
+fi
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
2.53.0-Meta

