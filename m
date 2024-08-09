Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3DA18FDD0
	for <linux-cxl@vger.kernel.org>; Fri,  9 Aug 2024 08:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723193910; cv=none; b=Eo+HsikeINaEV2ED1TjvI53OdeYGvvmfUgo929s0JvyRpghv+n7RMjlotETQdJHfhyIgIYeBYi0iB8i7muukZDyfOcVXwiULzRLykG5A7UV7ovxXJ3YBXaZjS8z5pd0A9qklRRov1BqcUcSqoXqPZ/FgG9/vkmA70aZQSjHrAf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723193910; c=relaxed/simple;
	bh=6pEZquy8orhHZvOHNSun1kxpAHpdMw7xLJAtNs3rRuo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xu2YWZ0liBIxVyCUVvsdmtcTBYK4HE32NwvPFlUR8hO4xOFtEMiDqdtwZf9+I2++n8BpLNrfiN/Ge99f1eh1+FIJGTex+4GRKCnWJ+cdnK0/2RsEMtp+qbN80rQreu0pCB4tYhZAAIOe+0Ridljt4g6Yd2NlPBhp/DZUPsImJdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KCt/YUSp; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KCt/YUSp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723193909; x=1754729909;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6pEZquy8orhHZvOHNSun1kxpAHpdMw7xLJAtNs3rRuo=;
  b=KCt/YUSpoGIQYZ13h2WZEPVvkhZ7xHZjlfLwnqkHSOp5bbjJy08s62jk
   Q7a57Z/Z+2G7dNlX6htezL9A3LnIMM5y01A7U+WxpZD9WvrkIHNYVDgD3
   XB60o0he39Ov1s5KOCzzjukFtH4N4YoT8W4DS/0cWexhd2G3p3vL3rQII
   BGFSetevfvxvOnQoOpPIMqIS/t34YcJfQsawjzHToln55V2bDl3uRxe2J
   JtLhdv7oF4H1ZnK0gAogXg8NGl2+1i9I1RidLgo1/v/6YmdqBu7nzvzWB
   cz+JBpjXcA8M9hd9YqEg5pSZcpx0buRzNumgEfMmix21OTbJ4W1FsUU8q
   A==;
X-CSE-ConnectionGUID: pmVbE8yFRyGoFIvvdHaH3g==
X-CSE-MsgGUID: TV8WUHJhR1S/9u9Qdm+3GQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="32507240"
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="32507240"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 01:58:21 -0700
X-CSE-ConnectionGUID: 9T73IJDgQheA8gSHsdvZvQ==
X-CSE-MsgGUID: 0z8tthZTSr2WzOp/Epi8tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="57164175"
Received: from s2600wttr.bj.intel.com ([10.240.192.138])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 01:58:18 -0700
From: Li Ming <ming4.li@intel.com>
To: linux-cxl@vger.kernel.org,
	rrichter@amd.com,
	terry.bowman@amd.com,
	dan.j.williams@intel.com,
	alison.schofield@intel.com,
	pengfei.xu@intel.com
Cc: Li Ming <ming4.li@intel.com>
Subject: [PATCH v2 2/2] cxl/test: Skip cxl_setup_parent_dport() for emulated dports
Date: Fri,  9 Aug 2024 08:27:50 +0000
Message-Id: <20240809082750.3015641-3-ming4.li@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240809082750.3015641-1-ming4.li@intel.com>
References: <20240809082750.3015641-1-ming4.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cxl_test unit test environment on qemu always hits below call trace
with KASAN enabled:

 BUG: KASAN: slab-out-of-bounds in cxl_setup_parent_dport+0x480/0x530 [cxl_core]
 Read of size 1 at addr ff110000676014f8 by task (udev-worker)/676[   24.424403] CPU: 2 PID: 676 Comm: (udev-worker) Tainted: G           O     N 6.10.0-qemucxl #1
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk2-20240214-2.el9 02/14/2024
 Call Trace:
  <TASK>
  dump_stack_lvl+0xea/0x150
  print_report+0xce/0x610
  ? kasan_complete_mode_report_info+0x40/0x200
  kasan_report+0xcc/0x110
  __asan_report_load1_noabort+0x18/0x20
  cxl_setup_parent_dport+0x480/0x530 [cxl_core]
  cxl_mem_probe+0x49b/0xaa0 [cxl_mem]

cxl_test module models a CXL topology for testing, it creates some
emulated dports with platform devices in the CXL topology, so the
dport_dev of an emulated dport points to a platform device rather than a
pci device or a pci host bridge in the case. Currently,
cxl_setup_parent_dport() is used to set up RAS and AER capability on the
dport connected to the CXL memory device, but cxl_test does not support
RAS or AER functionality yet, so the fix is implementing a
__wrap_cxl_setup_parent_dport() to filter out all emulated dports,
guarantees only real dports can be handled by cxl_setup_parent_dport().

Fixes: f05fd10d138d ("cxl/pci: Add RCH downstream port AER register discovery")
Reported-by: Pengfei Xu <pengfei.xu@intel.com>
Closes: https://lore.kernel.org/linux-cxl/ZrHTBp2O+HtUe6kt@xpf.sh.intel.com/T/#t
Signed-off-by: Li Ming <ming4.li@intel.com>
---
 tools/testing/cxl/Kbuild      |  1 +
 tools/testing/cxl/test/mock.c | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 030b388800f0..3d1ca9e38b1f 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -14,6 +14,7 @@ ldflags-y += --wrap=cxl_dvsec_rr_decode
 ldflags-y += --wrap=devm_cxl_add_rch_dport
 ldflags-y += --wrap=cxl_rcd_component_reg_phys
 ldflags-y += --wrap=cxl_endpoint_parse_cdat
+ldflags-y += --wrap=cxl_setup_parent_dport
 
 DRIVERS := ../../../drivers
 CXL_SRC := $(DRIVERS)/cxl
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index 6f737941dc0e..d619672faa49 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -299,6 +299,18 @@ void __wrap_cxl_endpoint_parse_cdat(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(__wrap_cxl_endpoint_parse_cdat, CXL);
 
+void __wrap_cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport)
+{
+	int index;
+	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
+
+	if (!ops || !ops->is_mock_port(dport->dport_dev))
+		cxl_setup_parent_dport(host, dport);
+
+	put_cxl_mock_ops(index);
+}
+EXPORT_SYMBOL_NS_GPL(__wrap_cxl_setup_parent_dport, CXL);
+
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS(ACPI);
 MODULE_IMPORT_NS(CXL);
-- 
2.40.1

