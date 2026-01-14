Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE133A35AB
	for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 21:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768427221; cv=none; b=StvuvGOYdF4QrniKSN/hgIeqFei+ycGcHmNEt9uLs4MoAqR/GXZGJPpDHn4b4ueB/0otXtcWf3zpS7Gn2o1kThcyl4x4k6aVxrJR042CjEG5z9mWV2lVf5lf6HGUKM8x+DjdJ3ECL3CVdgLPVdZIEg5CmovCFlpeOjA8VKCtSVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768427221; c=relaxed/simple;
	bh=UH7UVmm/ifZMz2a7ctzEVAj9QL1YqJfv9TEsJAmqvl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S2GZm4mnKcuGHGjz71DRLKtV8YYnXuMjxtW6KX2FXgxMduVvtQuA8GrMjTAliKzooPCV3aNOyRrfO8oKKCsjbLb1645ybccpAss+UEjwpLKY9Egj7FUaNHvYMdt/ll6MirIAL4p+lxD4BDFY6rUhhNrBtRmMzMEAIq3bSD/8MSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U1x22Y2N; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1x22Y2N"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7cfcbe7d176so194135a34.3
        for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 13:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768427188; x=1769031988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ezmCIUYTCpc47N9MRFviC1UdzpKfkRUPsUPtXb573Uk=;
        b=U1x22Y2NCadasD+0/b0bPw8Jn26D+SpJIsuZ4rfvGJuun0FUtpy0yEVTNC3SEZP49O
         kQVrOW6VEUFevmJ8Tfwfloc26DmUxyJoZ481dP5SY8Vnr0yaGCBUcA9VTM7MT7dob2CR
         oiiiZipKAFt6EypCdSmvuGhN7YU6+rNC/Omt2OxUb6Bpqs/brbeXxwniyW2pSoKXlr1j
         5Nmyyb9fjC0sh1XqduP4U+K+mNhMYvlCQ/YkkA6Ud9AjV5bJHdFrgw5fg/85+1DcnwsH
         sECOWV2MlG2C9LRm5loBKJOi81lh/7zVpq8T+4On6fvrdPc3x9pbcjsq464wKeTHGJhD
         hpWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768427188; x=1769031988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ezmCIUYTCpc47N9MRFviC1UdzpKfkRUPsUPtXb573Uk=;
        b=Ya7eSD0Hhp2IaHy7wobc4SiJUN3PLawFt0k9kD2lzYsqSluACBR+GNmAOp0+lmzIfa
         meV0HbKccD1j5qPhwhr25tmgAOirNQDw7lvIC9Ya0V1bG74eHZkQ53yAs2JAewJEAGHj
         NfA+u322f1mjL+/bm3kl96LmziMEq0raY02exgk2W7dC3onOBPmq+oAkbYrZEU601zOF
         VYAhYrtTxtCrQSEwu6fYmI8UEJOg4/trSbUIOxQC1aCVtzO5+vYPXDDLaEqx4aZIt6FY
         83jefTDv1pxw4Eydqk4sgczvKkxyl0hjDLIr1hswpPUIw6GaUtNroXzA5Jk3CHM8/qBt
         40WQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZs7R9tG7eCGxP8eSoRN4+J/u9xsABaHwLL0p1jaZIBBbiBzbIO736U4rXzgOW1PD4JqWdL1EDjgg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh9LEPnb2IDfm9QHRR9+CS6iUjvGlvAxhD188qRmTDBkCeXV2p
	nTOqp8SR42nrblawX3ASSRp2Tlc4DrWxl+FBfgu5LULbycO68aG2ay3T
X-Gm-Gg: AY/fxX5cuDQfreNenbU7nGY+FAAvHQ+sY6f4cTG9bZOSuqiULOrks6/ee7IEEy5AJo4
	ezniP+fu86J8FOkD9pznn3LZ071bt/qyX1A2hkhldDw4BG/xw79s5ADyLBrB/rDaYoWsj+bfuv4
	AMP8nVkDUhgbQ4/lD4l2jwVo6JdYGneZTZMdIGFNjO/SnhFY85XB3khi4GdzgUjAnh0Ox8hkZHI
	Z+Drd3eLTtn5pRZg9DMaUEu+8cpZxF/eBQTtBy8cHwbQ/wkkPYeutGIL+zxnkkAFhWd9b67Xd9z
	xa2LaQqQoM/slvMXpOW30OvvvdX/NyV3yTqEjB8oT8mvwUJbRH4sp9USJrpdeFSVzymCGnEa/NK
	zPCG754oDPw0BFxNnJD1lcZkQJhNuZSs7ZlD4SJ/REEnH+VekMAaWA8Hb+SIq5mE6FVV+YPpnFs
	UCgVmzB5Tdz6QrRPXPKq3BIqrvwfEVyHWqnvwGf0MlNz7/
X-Received: by 2002:a05:6830:2541:b0:7cf:cc11:f7cc with SMTP id 46e09a7af769-7cfcc11f982mr2409830a34.36.1768427188084;
        Wed, 14 Jan 2026 13:46:28 -0800 (PST)
Received: from localhost.localdomain ([2603:8080:1500:3d89:4c85:2962:e438:72c4])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cfc3692f3asm3936197a34.10.2026.01.14.13.46.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 14 Jan 2026 13:46:27 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
From: John Groves <John@Groves.net>
X-Google-Original-From: John Groves <john@groves.net>
To: John Groves <John@Groves.net>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Dan Williams <dan.j.williams@intel.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Alison Schofield <alison.schofield@intel.com>
Cc: John Groves <jgroves@micron.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	David Hildenbrand <david@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Stefan Hajnoczi <shajnocz@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	James Morse <james.morse@arm.com>,
	Fuad Tabba <tabba@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Shivank Garg <shivankg@amd.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Gregory Price <gourry@gourry.net>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>,
	venkataravis@micron.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH V2 2/2] Add test/daxctl-famfs.sh to test famfs mode transitions:
Date: Wed, 14 Jan 2026 15:45:19 -0600
Message-ID: <20260114214519.29999-3-john@groves.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114214519.29999-1-john@groves.net>
References: <20260114153133.29420.compound@groves.net>
 <20260114214519.29999-1-john@groves.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: John Groves <John@Groves.net>

- devdax <-> famfs mode switches
- Verify famfs -> system-ram is rejected (must go via devdax)
- Test JSON output shows correct mode
- Test error handling for invalid modes

The test is added to the destructive test suite since it
modifies device modes.

Signed-off-by: John Groves <john@groves.net>
---
 test/daxctl-famfs.sh | 253 +++++++++++++++++++++++++++++++++++++++++++
 test/meson.build     |   2 +
 2 files changed, 255 insertions(+)
 create mode 100755 test/daxctl-famfs.sh

diff --git a/test/daxctl-famfs.sh b/test/daxctl-famfs.sh
new file mode 100755
index 0000000..12fbfef
--- /dev/null
+++ b/test/daxctl-famfs.sh
@@ -0,0 +1,253 @@
+#!/bin/bash -Ex
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2025 Micron Technology, Inc. All rights reserved.
+#
+# Test daxctl famfs mode transitions and mode detection
+
+rc=77
+. $(dirname $0)/common
+
+trap 'cleanup $LINENO' ERR
+
+daxdev=""
+original_mode=""
+
+cleanup()
+{
+	printf "Error at line %d\n" "$1"
+	# Try to restore to original mode if we know it
+	if [[ $daxdev && $original_mode ]]; then
+		"$DAXCTL" reconfigure-device -f -m "$original_mode" "$daxdev" 2>/dev/null || true
+	fi
+	exit $rc
+}
+
+# Check if fsdev_dax module is available
+check_fsdev_dax()
+{
+	if modinfo fsdev_dax &>/dev/null; then
+		return 0
+	fi
+	if grep -qF "fsdev_dax" "/lib/modules/$(uname -r)/modules.builtin" 2>/dev/null; then
+		return 0
+	fi
+	printf "fsdev_dax module not available, skipping\n"
+	exit 77
+}
+
+# Check if kmem module is available (needed for system-ram mode tests)
+check_kmem()
+{
+	if modinfo kmem &>/dev/null; then
+		return 0
+	fi
+	if grep -qF "kmem" "/lib/modules/$(uname -r)/modules.builtin" 2>/dev/null; then
+		return 0
+	fi
+	printf "kmem module not available, skipping system-ram tests\n"
+	return 1
+}
+
+# Find an existing dax device to test with
+find_daxdev()
+{
+	# Look for any available dax device
+	daxdev=$("$DAXCTL" list | jq -er '.[0].chardev // empty' 2>/dev/null) || true
+
+	if [[ ! $daxdev ]]; then
+		printf "No dax device found, skipping\n"
+		exit 77
+	fi
+
+	# Save the original mode so we can restore it
+	original_mode=$("$DAXCTL" list -d "$daxdev" | jq -er '.[].mode')
+
+	printf "Found dax device: %s (current mode: %s)\n" "$daxdev" "$original_mode"
+}
+
+daxctl_get_mode()
+{
+	"$DAXCTL" list -d "$1" | jq -er '.[].mode'
+}
+
+# Ensure device is in devdax mode for testing
+ensure_devdax_mode()
+{
+	local mode
+	mode=$(daxctl_get_mode "$daxdev")
+
+	if [[ "$mode" == "devdax" ]]; then
+		return 0
+	fi
+
+	if [[ "$mode" == "system-ram" ]]; then
+		printf "Device is in system-ram mode, attempting to convert to devdax...\n"
+		"$DAXCTL" reconfigure-device -f -m devdax "$daxdev"
+	elif [[ "$mode" == "famfs" ]]; then
+		printf "Device is in famfs mode, converting to devdax...\n"
+		"$DAXCTL" reconfigure-device -m devdax "$daxdev"
+	else
+		printf "Device is in unknown mode: %s\n" "$mode"
+		return 1
+	fi
+
+	[[ $(daxctl_get_mode "$daxdev") == "devdax" ]]
+}
+
+#
+# Test basic mode transitions involving famfs
+#
+test_famfs_mode_transitions()
+{
+	printf "\n=== Testing famfs mode transitions ===\n"
+
+	# Ensure starting in devdax mode
+	ensure_devdax_mode
+	[[ $(daxctl_get_mode "$daxdev") == "devdax" ]]
+	printf "Initial mode: devdax - OK\n"
+
+	# Test: devdax -> famfs
+	printf "Testing devdax -> famfs... "
+	"$DAXCTL" reconfigure-device -m famfs "$daxdev"
+	[[ $(daxctl_get_mode "$daxdev") == "famfs" ]]
+	printf "OK\n"
+
+	# Test: famfs -> famfs (re-enable in same mode)
+	printf "Testing famfs -> famfs (re-enable)... "
+	"$DAXCTL" reconfigure-device -m famfs "$daxdev"
+	[[ $(daxctl_get_mode "$daxdev") == "famfs" ]]
+	printf "OK\n"
+
+	# Test: famfs -> devdax
+	printf "Testing famfs -> devdax... "
+	"$DAXCTL" reconfigure-device -m devdax "$daxdev"
+	[[ $(daxctl_get_mode "$daxdev") == "devdax" ]]
+	printf "OK\n"
+
+	# Test: devdax -> devdax (re-enable in same mode)
+	printf "Testing devdax -> devdax (re-enable)... "
+	"$DAXCTL" reconfigure-device -m devdax "$daxdev"
+	[[ $(daxctl_get_mode "$daxdev") == "devdax" ]]
+	printf "OK\n"
+}
+
+#
+# Test mode transitions with system-ram (requires kmem)
+#
+test_system_ram_transitions()
+{
+	printf "\n=== Testing system-ram transitions with famfs ===\n"
+
+	# Ensure we start in devdax mode
+	ensure_devdax_mode
+	[[ $(daxctl_get_mode "$daxdev") == "devdax" ]]
+
+	# Test: devdax -> system-ram
+	printf "Testing devdax -> system-ram... "
+	"$DAXCTL" reconfigure-device -N -m system-ram "$daxdev"
+	[[ $(daxctl_get_mode "$daxdev") == "system-ram" ]]
+	printf "OK\n"
+
+	# Test: system-ram -> famfs should fail
+	printf "Testing system-ram -> famfs (should fail)... "
+	if "$DAXCTL" reconfigure-device -m famfs "$daxdev" 2>/dev/null; then
+		printf "FAILED - should have been rejected\n"
+		return 1
+	fi
+	printf "OK (correctly rejected)\n"
+
+	# Test: system-ram -> devdax -> famfs (proper path)
+	printf "Testing system-ram -> devdax -> famfs... "
+	"$DAXCTL" reconfigure-device -f -m devdax "$daxdev"
+	[[ $(daxctl_get_mode "$daxdev") == "devdax" ]]
+	"$DAXCTL" reconfigure-device -m famfs "$daxdev"
+	[[ $(daxctl_get_mode "$daxdev") == "famfs" ]]
+	printf "OK\n"
+
+	# Restore to devdax for subsequent tests
+	"$DAXCTL" reconfigure-device -m devdax "$daxdev"
+}
+
+#
+# Test JSON output shows correct mode
+#
+test_json_output()
+{
+	printf "\n=== Testing JSON output for mode field ===\n"
+
+	# Test devdax mode in JSON
+	ensure_devdax_mode
+	printf "Testing JSON output for devdax mode... "
+	mode=$("$DAXCTL" list -d "$daxdev" | jq -er '.[].mode')
+	[[ "$mode" == "devdax" ]]
+	printf "OK\n"
+
+	# Test famfs mode in JSON
+	"$DAXCTL" reconfigure-device -m famfs "$daxdev"
+	printf "Testing JSON output for famfs mode... "
+	mode=$("$DAXCTL" list -d "$daxdev" | jq -er '.[].mode')
+	[[ "$mode" == "famfs" ]]
+	printf "OK\n"
+
+	# Restore to devdax
+	"$DAXCTL" reconfigure-device -m devdax "$daxdev"
+}
+
+#
+# Test error messages for invalid transitions
+#
+test_error_handling()
+{
+	printf "\n=== Testing error handling ===\n"
+
+	# Ensure we're in famfs mode
+	"$DAXCTL" reconfigure-device -m famfs "$daxdev"
+
+	# Test that invalid mode is rejected
+	printf "Testing invalid mode rejection... "
+	if "$DAXCTL" reconfigure-device -m invalidmode "$daxdev" 2>/dev/null; then
+		printf "FAILED - invalid mode should be rejected\n"
+		return 1
+	fi
+	printf "OK (correctly rejected)\n"
+
+	# Restore to devdax
+	"$DAXCTL" reconfigure-device -m devdax "$daxdev"
+}
+
+#
+# Main test sequence
+#
+main()
+{
+	check_fsdev_dax
+	find_daxdev
+
+	rc=1  # From here on, failures are real failures
+
+	test_famfs_mode_transitions
+	test_json_output
+	test_error_handling
+
+	# System-ram tests require kmem module
+	if check_kmem; then
+		# Save and disable online policy for system-ram tests
+		saved_policy="$(cat /sys/devices/system/memory/auto_online_blocks)"
+		echo "offline" > /sys/devices/system/memory/auto_online_blocks
+
+		test_system_ram_transitions
+
+		# Restore online policy
+		echo "$saved_policy" > /sys/devices/system/memory/auto_online_blocks
+	fi
+
+	# Restore original mode
+	printf "\nRestoring device to original mode: %s\n" "$original_mode"
+	"$DAXCTL" reconfigure-device -f -m "$original_mode" "$daxdev"
+
+	printf "\n=== All famfs tests passed ===\n"
+
+	exit 0
+}
+
+main
diff --git a/test/meson.build b/test/meson.build
index 615376e..ad1d393 100644
--- a/test/meson.build
+++ b/test/meson.build
@@ -209,6 +209,7 @@ if get_option('destructive').enabled()
   device_dax_fio = find_program('device-dax-fio.sh')
   daxctl_devices = find_program('daxctl-devices.sh')
   daxctl_create = find_program('daxctl-create.sh')
+  daxctl_famfs = find_program('daxctl-famfs.sh')
   dm = find_program('dm.sh')
   mmap_test = find_program('mmap.sh')
 
@@ -226,6 +227,7 @@ if get_option('destructive').enabled()
     [ 'device-dax-fio.sh', device_dax_fio, 'dax'   ],
     [ 'daxctl-devices.sh', daxctl_devices, 'dax'   ],
     [ 'daxctl-create.sh',  daxctl_create,  'dax'   ],
+    [ 'daxctl-famfs.sh',   daxctl_famfs,   'dax'   ],
     [ 'dm.sh',             dm,		   'dax'   ],
     [ 'mmap.sh',           mmap_test,	   'dax'   ],
   ]
-- 
2.49.0

