Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFDE17BBF
	for <linux-cxl@vger.kernel.org>; Mon, 27 May 2024 06:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716792426; cv=none; b=NlUoY0cvbQJtlb/X5x4LWwT456Y12MZuzM/ntn4PugIHjiRn7uGMrrWtR5YFOtI6oFsz9oyw1a9D8oHXl/UbGZ7Qo9K4Wk1Kr0r8lyukikJQadkenEq31tqH0mNbPEqVxQ/ec3HsSTECPJgFzlJ/FdtUC/Nn5n+pbbYeUQmDNM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716792426; c=relaxed/simple;
	bh=BcokBG31RIq2vbFCGm1102SQQoWJEZIhpCd4S1uIbJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jxpmbDTO4skZXWGAZHWYovlGs/OqxJ3pz3t2K9t1tO7I2NKDgdZjg3vqaZBcGFvoAHrFD92mBov4wPq7pcdbHAhNF5jdDv3hsefA7Yg6Gcx7FB86ELFKtlDtgD81oZ+JQq7CPBUDWiuOTNaVOB/37V6It3d69thh8+K+4ba+prw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=FedDaZhA; arc=none smtp.client-ip=68.232.139.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="FedDaZhA"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1716792425; x=1748328425;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BcokBG31RIq2vbFCGm1102SQQoWJEZIhpCd4S1uIbJ8=;
  b=FedDaZhAV2asxLtViHJJ6J3TZ7SGUFwtHIe5f8f+W+bhbKYL1NjWdLJf
   Sx9Ptzl1M7farTWXBqWxrVc3KeU/F/K1QJFBY5I9tzWAyrDnDvaS/6RWT
   B0DNK428HvNrTP5hbSn6OM18WF1lVPFtibw0JJ5pQ15IE1I2mG/C85OeU
   NaDtVo7CVHX7sqNGHY+QbRitPqQLvOZlnohv/6u3muUysLxYtq+fy6WRD
   yA4HC+HRP2PIY7CsM6W5G5+1CCYYyCQ60gzxrsSFuvv5FT9UgiDwA+OIE
   jVNK0FeMw6GfWCi38RUZwJpq/2h9s9OzJkU0qDFYwMYOyTGR53Q+WH1wG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="162285740"
X-IronPort-AV: E=Sophos;i="6.08,191,1712588400"; 
   d="scan'208";a="162285740"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 15:45:53 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
	by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 47709CA1EA
	for <linux-cxl@vger.kernel.org>; Mon, 27 May 2024 15:45:51 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 763FFD73A8
	for <linux-cxl@vger.kernel.org>; Mon, 27 May 2024 15:45:50 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 0CC212239F0
	for <linux-cxl@vger.kernel.org>; Mon, 27 May 2024 15:45:50 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 9D1471A000C;
	Mon, 27 May 2024 14:45:49 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>
Subject: [ndctl PATCH 2/2] daxctl: Fix create-device manual
Date: Mon, 27 May 2024 14:45:39 +0800
Message-Id: <20240527064539.819487-2-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240527064539.819487-1-lizhijian@fujitsu.com>
References: <20240527064539.819487-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28412.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28412.005
X-TMASE-Result: 10--2.187100-10.000000
X-TMASE-MatchedRID: n1gbV5OfaTUZHQl0dvECsfsgrpDX6v2eTJDl9FKHbrk6FHRWx2FGsI3c
	eRXYSJoDIvrftAIhWmJwk5p7o69tnQQBdUgWg+akdqNHliz4AWdAApRfVHzqNL8r2YKZauYGUHw
	ogQlwTkm/CU9ohIHhuE/hQBftKoDgIQJt3nwJw/BIcJTn2HkqsZ0JB6wB6Cqm/gMNehoKqTtSDH
	rkR3VZi7DvP+hClj+P0m70v5AMjBFVLEbPNu9Klwrcxrzwsv5uUrr7Qc5WhKhR965L821jzDbhh
	Nf8h3mb4vM1YF6AJbbCCfuIMF6xLSdET58jp62SdtpFtAk6aGii3lCeAQ44COMpWTAf6sgyfHnV
	g5nrEt5+V/VnK6LQVLB+v6+QiPLRGSORX8zrVelCTGHVw2pg4VUkhRnV9rSXwGC8e6520fKw0PJ
	t06oJaHpaQl5xviY7wxgWdRvK9Un9g+oMf9KM6Q==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

create-device can accept more options, see `daxctl help create-device`
or the code for more details.

Reuse reconfigure options from reconfigure-device and include movable
options.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 Documentation/daxctl/daxctl-create-device.txt |  2 +
 .../daxctl/daxctl-reconfigure-device.txt      | 39 +-----------------
 Documentation/daxctl/reconfigure-options.txt  | 40 +++++++++++++++++++
 3 files changed, 43 insertions(+), 38 deletions(-)
 create mode 100644 Documentation/daxctl/reconfigure-options.txt

diff --git a/Documentation/daxctl/daxctl-create-device.txt b/Documentation/daxctl/daxctl-create-device.txt
index 05f4dbd9d61c..ad6f177fa3b9 100644
--- a/Documentation/daxctl/daxctl-create-device.txt
+++ b/Documentation/daxctl/daxctl-create-device.txt
@@ -72,6 +72,8 @@ EFI memory map with EFI_MEMORY_SP. The resultant ranges mean that it's
 OPTIONS
 -------
 include::region-option.txt[]
+include::movable-options.txt[]
+include::reconfigure-options.txt[]
 
 -s::
 --size=::
diff --git a/Documentation/daxctl/daxctl-reconfigure-device.txt b/Documentation/daxctl/daxctl-reconfigure-device.txt
index 09691d202514..32f28a5b8e82 100644
--- a/Documentation/daxctl/daxctl-reconfigure-device.txt
+++ b/Documentation/daxctl/daxctl-reconfigure-device.txt
@@ -196,47 +196,10 @@ include::region-option.txt[]
 
 	This option is mutually exclusive with -m or --mode.
 
--m::
---mode=::
-	Specify the mode to which the dax device(s) should be reconfigured.
-	- "system-ram": hotplug the device into system memory.
-
-	- "devdax": switch to the normal "device dax" mode. This requires the
-	  kernel to support hot-unplugging 'kmem' based memory. If this is not
-	  available, a reboot is the only way to switch back to 'devdax' mode.
-
--N::
---no-online::
-	By default, memory sections provided by system-ram devices will be
-	brought online automatically and immediately with the 'online_movable'
-	policy. Use this option to disable the automatic onlining behavior.
-
--C::
---check-config::
-	Get reconfiguration parameters from the global daxctl config file.
-	This is typically used when daxctl-reconfigure-device is called from
-	a systemd-udevd device unit file. The reconfiguration proceeds only
-	if the match parameters in a 'reconfigure-device' section of the
-	config match the dax device specified on the command line. See the
-	'PERSISTENT RECONFIGURATION' section for more details.
+include::reconfigure-options.txt[]
 
 include::movable-options.txt[]
 
--f::
---force::
-	- When converting from "system-ram" mode to "devdax", it is expected
-	that all the memory sections are first made offline. By default,
-	daxctl won't touch online memory. However with this option, attempt
-	to offline the memory on the NUMA node associated with the dax device
-	before converting it back to "devdax" mode.
-
-	- Additionally, if a kernel policy to auto-online blocks is detected,
-	reconfiguration to system-ram fails. With this option, the failure can
-	be overridden to allow reconfiguration regardless of kernel policy.
-	Doing this may result in a successful reconfiguration, but it may
-	not be possible to subsequently offline the memory without a reboot.
-
-
 include::human-option.txt[]
 
 include::verbose-option.txt[]
diff --git a/Documentation/daxctl/reconfigure-options.txt b/Documentation/daxctl/reconfigure-options.txt
new file mode 100644
index 000000000000..f174729eb023
--- /dev/null
+++ b/Documentation/daxctl/reconfigure-options.txt
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
+
+
+-m::
+--mode=::
+	Specify the mode to which the dax device(s) should be reconfigured.
+	- "system-ram": hotplug the device into system memory.
+
+	- "devdax": switch to the normal "device dax" mode. This requires the
+	  kernel to support hot-unplugging 'kmem' based memory. If this is not
+	  available, a reboot is the only way to switch back to 'devdax' mode.
+
+-N::
+--no-online::
+	By default, memory sections provided by system-ram devices will be
+	brought online automatically and immediately with the 'online_movable'
+	policy. Use this option to disable the automatic onlining behavior.
+
+-C::
+--check-config::
+	Get reconfiguration parameters from the global daxctl config file.
+	This is typically used when daxctl-reconfigure-device is called from
+	a systemd-udevd device unit file. The reconfiguration proceeds only
+	if the match parameters in a 'reconfigure-device' section of the
+	config match the dax device specified on the command line. See the
+	'PERSISTENT RECONFIGURATION' section for more details.
+
+-f::
+--force::
+	- When converting from "system-ram" mode to "devdax", it is expected
+	that all the memory sections are first made offline. By default,
+	daxctl won't touch online memory. However with this option, attempt
+	to offline the memory on the NUMA node associated with the dax device
+	before converting it back to "devdax" mode.
+
+	- Additionally, if a kernel policy to auto-online blocks is detected,
+	reconfiguration to system-ram fails. With this option, the failure can
+	be overridden to allow reconfiguration regardless of kernel policy.
+	Doing this may result in a successful reconfiguration, but it may
+	not be possible to subsequently offline the memory without a reboot.
-- 
2.29.2

