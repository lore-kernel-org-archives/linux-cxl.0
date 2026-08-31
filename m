Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13A637AA64
	for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 02:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788143021; cv=none; b=bklrlVZgkwbbSQ55ozs41zbBu8tyxgsQiGOxJZ7XaAWwSOxKD4lUxjG4cR30kGprEb+SXv7d3lot0IkZ28+UIJY1Zs2KhyzKuey+U1O0y9E0Ns/37UP35WsG63VhEE8vaWhZ1akkQI5BH1mC/Q1KfpqZsAYbZTIKZRClUAv8K0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788143021; c=relaxed/simple;
	bh=JfFtoKN/qdgOj3A9lANKsbktFZUUewgu65dOxEHAdww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TGuIClFpTqCNggq7THg6T0E3cOPj2uzVnmgJV1EUJhVct4r0troY3WTJvmypsLbtf+6J2zkqq7P8JXW4Bax5pCEGY6xr+TpmEaxPKbaBnIeJ4/SQ2NqFm5QPJgCZxbPVlimICFZQnniDTNWRrEyl+qGU7vpufYtYcbl6gQcE75I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=errHxEyR; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="errHxEyR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788143003; x=1819679003;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JfFtoKN/qdgOj3A9lANKsbktFZUUewgu65dOxEHAdww=;
  b=errHxEyROYQEppGHkEuyXYmpflzWpLYzkHfJapgFPxXbB2EQPyTzSbbB
   fDLNJppTGGh1/Tjr5P+rbrSyLNS4FTmbEq6RFKqC1olFX4p6gycnQDaWw
   OVX5kSjhI+TcBnLkaxfiYrmpb7LdNCwOaMGMFDoIc2bKkGOMO+SlPOCIG
   eyAGg9iSPFS28JXIwnJBBrL0vJlNMCD8SatSr9qERxciyOVf8TH5a6tlz
   ULLOnIxC4KzWtKOcaGCn/ngE1s8mSzCN3woFVzpplISG5ZVC7/yK1TiXI
   SywAW8Mmq4Y2fN9EoeXjBjVPZFVOtmr9VyVmaWaJtqnvgOj0oM+EmpHMw
   w==;
X-CSE-ConnectionGUID: Ovb/wXlNSwKPlc2d5n581Q==
X-CSE-MsgGUID: 7VLj94DUQFOuNgaSTrtLZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="99703149"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="99703149"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2026 19:23:11 -0700
X-CSE-ConnectionGUID: 6zp4s1G1SPylKnjVDBXrng==
X-CSE-MsgGUID: wHFmjOCJQ3m8BYGsjX6F6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="272859624"
Received: from junjie-desk-dev.bj.intel.com (HELO junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2026 19:23:09 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: mst@redhat.com,
	Shrihari E S <shrihari.s@samsung.com>,
	linux-cxl@vger.kernel.org,
	qemu-devel@nongnu.org
Subject: [PATCH] hw/cxl: fix the CDAT DOE overlapping the Flex Bus DVSEC when sn= is set
Date: Mon, 31 Aug 2026 10:23:02 +0800
Message-ID: <20260831022302.406740-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ct3_realize() adds the CDAT DOE at a fixed 0x190.  Since 8700ee15de the
four DVSECs take 0x90 bytes, which from 0x100 ends exactly at 0x190.
With sn= the Device Serial Number capability pushes the block to
0x10c..0x19c, and the DOE, added later, overwrites the last 12 bytes of
the Flex Bus Port DVSEC: Capability2, Control2 and Status2.  Nothing
catches this -- pcie_add_capability() checks bounds, not overlap, and
the chain still walks because the DVSEC's next pointer becomes 0x190,
inside its own body.  Most cxl-type3 examples in
docs/system/devices/cxl.rst set sn=.

Derive the offset from the DVSEC block instead, as cxl_upstream.c
already does.  Without sn= the layout is unchanged byte for byte; with
sn= the DOE moves to 0x19c, below the AER capability at 0x200.  The
type 3 device has no VMStateDescription, so its config space never
reaches the migration stream.

Fixes: 8700ee15de ("hw/cxl: Standardize all references on CXL r3.1 and minor updates")
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
Found while walking the extended capability chains for the UIO/SVC RFC
V2 review; independent of that series.

Tested at bde2492aac on q35 (pxb-cxl / cxl-rp / cxl-type3), dumping the
capability chain and raw config bytes from the guest with and without
sn=: the Flex Bus DVSEC keeps its full 0x20 bytes and the DOE sits at
0x19c; without sn= the bytes are identical before and after.  cxl-test
12/12.

On cxl-2026-03-25-draft REG_LOC_DVSEC_LENGTH is 0x34, so the overlap is
there without sn= too; with this change the DOE lands at 0x1a0/0x1ac.
cxl-2026-01-09-draft also fixes doe_comp at 0x1b0, which would then
collide -- the two want chaining.

 hw/mem/cxl_type3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 28f41fa623..e6eb2e0cba 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -936,8 +936,8 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
     }
 
     /* DOE Initialization */
-    pcie_doe_init(pci_dev, &ct3d->doe_cdat, 0x190, doe_cdat_prot, true,
-                  CXL_T3_MSIX_PCIE_DOE_TABLE_ACCESS);
+    pcie_doe_init(pci_dev, &ct3d->doe_cdat, cxl_cstate->dvsec_offset,
+                  doe_cdat_prot, true, CXL_T3_MSIX_PCIE_DOE_TABLE_ACCESS);
 
     cxl_cstate->cdat.build_cdat_table = ct3_build_cdat_table;
     cxl_cstate->cdat.free_cdat_table = ct3_free_cdat_table;

base-commit: d2e570cc0f97b936902a5b1b86b73c0f5998b475
-- 
2.43.0

