Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792804631;
	b=yOYjUtpR8oKzg4b+WIuO3SYrR6OIlHnEEmUxScOq9ZpwE4e3t5mVdOs2Hn+wwUwkPHHu
	 5NwPvjo9MkvMCyaSewI6Zx1k2CIi65RgVIcv/YC5soDDEqGWhpUlXjMUtNPu5CEY2FY5i
	 0Py94m+mz7VLJmyZ6GOlUMHuMueTgUWsm8OsE5unZWVoPXm1x2lW8Mqbsj0Me7owXztOQ
	 V4nMzAvaZD7GACnxN3TEL2EwoEUOb8LQWqwndGdNR45Bsu40DB1VRjJVgiLyT6tL6ZMRk
	 Pj5KcVFObeKeCnfmHUDPhLdhZVdbLf/PgBrZlrSfd3xp0UMIY5dlAuM3Q0wm6KPgQeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792804631;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=627EKtFKjJ1ob7JXuHRdT1b7yKCwoUtCJw/WrwqF3CQ=;
	b=ey9pLoGPFXmhtwkVDHgAja06A//0QkyUBGJFDUkoQ2bxb09z3DSCR2HewXRsp5fxsGEH
	 CR6AjbH0J2tGGsUJ4veIKtI+d5qyC8ECgidNj/tQTC4XOgDxYxU9q/LYq+6HwwVN43cy0
	 wvx03hUtM2Ei95V0lwvLX3enwzURm0LN5rs3pDSvUxzuNSOtiiTlnAqrCZmPGOzLAERi9
	 jKQBvvJVkilFbqpkD9O0YQV60nFgdPHhNu0Zt3/EZeE/X2KTFFhcSzk7giB5qduM7/6Ps
	 foRkE59BcmnmJ38ghOW2fVcGpginFvvyZhC0atizUF/j0HqbK+G5e4p4Ann3jjBkg7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jxT5V0oe;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAF9606A31B
	for <linux-cxl@vger.kernel.org>; Sat, 24 Oct 2026 01:17:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EAF9606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jxT5V0oe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792804629; x=1824340629;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ztsxDUNTV+bpt4NodmqEgp6WhvAF8YLCLODDiB2Cz5A=;
  b=jxT5V0oeyUz8qBuBqRyFeEwrJ9WNz2uBS3BOpg54QHUc8g0VGosiKhGf
   r/UkW1v3XxbLiDiaYX8SOkz5xZtYURTpTuAyApyrkFbBo022N1iNWr2ui
   5VEOOuxcVAB3xglr2Hj7t5UW2D2a4TspdAVxIOYavLAyygnCUk89Y8nrN
   pRa7AjZmC04ZGyH7MgTk04YBBX1hjZEb6nVkuZMcbQpRDNVxq5/xNrQd5
   Qy1xXowrRwm3FoZHQfSB5cbj3Fn1qq+TI1kdzxyyPxslpfJsRiogQBMWl
   4PbnB3xLGjJG0hHEE8VlkbjOB1H/WENXTqunnXIPPnSIem7wlUt5fziLJ
   g==;
X-CSE-ConnectionGUID: lq99jtKxQ4+6ajrbOr/vDA==
X-CSE-MsgGUID: ilxWjBp4TFOU0CTnmXAtzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11944"; a="1452119"
X-IronPort-AV: E=Sophos;i="6.27,175,1787036400"; 
   d="scan'208";a="1452119"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 18:17:08 -0700
X-CSE-ConnectionGUID: YOsDBa8VSXyGRMCgvWzfAQ==
X-CSE-MsgGUID: TU3w0rm1RfqqHf6HwYq5JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,175,1787036400"; 
   d="scan'208";a="3738450"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.108.17])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 18:17:08 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: nvdimm@lists.linux.dev
Cc: Alison Schofield <alison.schofield@intel.com>,
	linux-cxl@vger.kernel.org
Subject: [ndctl PATCH] Documentation/ndctl-load-keys: document CXL passphrase key recovery
Date: Fri, 23 Oct 2026 18:17:05 -0700
Message-ID: <20261024011706.552346-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
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

Kernels prior to Linux 7.3 use a different serial number format
than ndctl when looking up CXL nvdimm passphrase keys, preventing
auto-unlock after reboot.

Document how to recover affected devices on unfixed kernels and
migrate existing keys after upgrading to a fixed kernel.

Kernel commit in v7.3: https://git.kernel.org/linus/8a80d3d65cd0

Closes: https://github.com/pmem/ndctl/issues/299
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 Documentation/ndctl/ndctl-load-keys.txt | 96 +++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/Documentation/ndctl/ndctl-load-keys.txt b/Documentation/ndctl/ndctl-load-keys.txt
index 70db57441820..ddb324830e05 100644
--- a/Documentation/ndctl/ndctl-load-keys.txt
+++ b/Documentation/ndctl/ndctl-load-keys.txt
@@ -43,6 +43,102 @@ OPTIONS
 	then this option will override (but not overwrite) anything that is
 	in the file.
 
+CXL SERIAL NUMBER KEY MISMATCH
+------------------------------
+This section applies to passphrase-protected CXL NVDIMMs that fail to
+auto-unlock after reboot on kernels without commit 8a80d3d65cd0, or that
+fail to auto-unlock after upgrading to a kernel with that fix. It does
+not apply to NVDIMMs without a passphrase or devices that unlock
+normally.
+
+Kernels without the fix look up passphrase keys using hexadecimal serial
+numbers, while ndctl names them using decimal. The mismatch affects
+serial numbers of 10 or greater. The fix, included in Linux 7.3 and some
+stable kernels, uses unsigned decimal for both. Devices with serial
+number bit 63 set may need their saved keys migrated after upgrading.
+
+The examples below use nmem0 for the affected nvdimm and the default
+key path:
+[subs="attributes"]
+----
+# keydir={ndctl_keysdir}
+----
+
+=== Recovery on a kernel without the fix
+
+Confirm that the device is locked:
+----
+# ndctl list -i -d nmem0 | jq -r '.[].dimms[0].security'
+locked
+----
+
+If it reports 'disabled', the device has no passphrase enrolled and this
+is a different problem. If it reports 'unlocked', there is nothing to
+recover.
+
+Check whether the device is affected by the serial number mismatch.
+Show the decimal 'id' that ndctl uses to name the key, and the
+hexadecimal serial number of the CXL memdev that backs nmem0:
+----
+# id=$(cat /sys/bus/nd/devices/nmem0/cxl/id)
+# prov=$(cat /sys/bus/nd/devices/nmem0/cxl/provider)
+# serial=$(cat /sys/bus/cxl/devices/${prov}/../serial)
+# echo "$id $serial"
+----
+
+If the 'id' is 10 or greater, or is negative, the device is affected.
+Confirm that the key blob ndctl saved exists:
+----
+# ls "${keydir}/nvdimm_${id}_$(hostname).blob"
+----
+
+If the blob is missing, this recovery procedure does not apply. Check
+that the correct key directory and hostname are being used.
+
+Copy the blob to a name that uses the hexadecimal serial number,
+without its 0x prefix, so that 'load-keys' also installs the key the
+kernel requests:
+----
+# hexid=${serial#0x}
+# cp "${keydir}/nvdimm_${id}_$(hostname).blob" \
+     "${keydir}/nvdimm_${hexid}_$(hostname).blob"
+----
+
+Reload the keys and enable the dimm. 'load-keys' names each key after
+its blob file, so the copy is installed as the key the kernel requests:
+----
+# ndctl load-keys
+# ndctl enable-dimm nmem0
+# ndctl list -i -d nmem0 | jq -r '.[].dimms[0].security'
+unlocked
+----
+
+=== Migration after upgrading to a fixed kernel
+
+Only serial numbers with bit 63 set need to be migrated. Their blob is
+named by the negative 'id' that the previous kernel reported, while the
+fixed kernel requests the key by the unsigned decimal serial number.
+Other serial numbers require no migration. A hexadecimal copy made by
+the recovery procedure above is no longer used and may be removed.
+
+Copy the blob from the previous negative 'id' to the current 'id'.
+Shell arithmetic cannot portably represent these values, so compute the
+previous 'id' with bc(1), which must be installed:
+----
+# id=$(cat /sys/bus/nd/devices/nmem0/cxl/id)
+# oldid=$(echo "$id - 2^64" | bc)
+# cp "${keydir}/nvdimm_${oldid}_$(hostname).blob" \
+     "${keydir}/nvdimm_${id}_$(hostname).blob"
+----
+
+Reload the keys and enable the dimm:
+----
+# ndctl load-keys
+# ndctl enable-dimm nmem0
+# ndctl list -i -d nmem0 | jq -r '.[].dimms[0].security'
+unlocked
+----
+
 include::intel-nvdimm-security.txt[]
 
 include::../copyright.txt[]
-- 
2.37.3

