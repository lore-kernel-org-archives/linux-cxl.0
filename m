Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C8636A030
	for <linux-cxl@vger.kernel.org>; Mon, 23 Feb 2026 19:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771874029; cv=none; b=JUj72sNkGYBtkbdp7qKXr24OieAkejS4ggwfLDqYcS1RiIDn2raqHYrUNmzC1NjCeW9Zt1o+5GGsyro9bL7xiHZFU+dWF9C44xz4OFJu5WzkfEDlkoj0bnAGyA9w15HTLOeKv+YMzjr8EQXpUrun5v3YriZiaoBtcT7WhoASWkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771874029; c=relaxed/simple;
	bh=l80F4MoCzywVLEYMZZ+lA5WsSGa3Sa8PiH9faAXw5O4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vaiv1ulOtRNA+2Is+SJpu6eyoFox/uTpzFWUYMiUHMXj5WYSGj3ALpz8nkriv7GFtxLfjgNdRxrvDn8vbKbSV2IgsbFAAeAM4UCF+9/8iQfaU52y+mosG/bB+JV8GUsSeU1sGbedkyadkM4qHeIvlrGSFgaeqNXL9feVeRdM8Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FkZ83Z/2; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FkZ83Z/2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771874028; x=1803410028;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l80F4MoCzywVLEYMZZ+lA5WsSGa3Sa8PiH9faAXw5O4=;
  b=FkZ83Z/2G2KgBRpUfVGIOdKmmfaTUXDjSsbjIqmuNGQKbdFfK82L2ojU
   PyTInO3Xqzl1NuXKO5GE0EPOCQ5hlZ0RvE2wfAASkj2R3xMidWMNz1OTu
   QrnH/ehkaUiDpkAPZ5CVMjdIop7JhNJnlDtKCGztTNNtLN0MBzTHuHJf/
   swEY9rOjB0U85RHOc7vPhsn+d+EV65GMZF+R0jQwdayfU8Nsi96xtzQjz
   NH6ckCa6k7APV88YdoykzoiH4oELGWSlYPnuIxdtZ6nVrvcganEvOSwdF
   JaLlUy6H8n5NTDuTauTILoO6cC9JbM0NMicNgFf18FvSB0v2Z0vsPWIF6
   Q==;
X-CSE-ConnectionGUID: u8n/uH5yQ9yVlogCQsE+JA==
X-CSE-MsgGUID: ex+QiKTEQKSaIR5XgHJD7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="72943937"
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="72943937"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 11:13:47 -0800
X-CSE-ConnectionGUID: 3yGbKedyTU+XKMMrsB8kiQ==
X-CSE-MsgGUID: HrqLGVAWTlKOOIoNrnHacQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="246244226"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.141])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 11:13:47 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v2 2/2] cxl/region: Test CXL_DECODER_F_NORMALIZED_ADDRESSING as a bitmask
Date: Mon, 23 Feb 2026 11:13:40 -0800
Message-ID: <63fe4a6203e40e404347f1cdc7a1c55cb4959b86.1771873256.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <98851c4770e4631753cf9f75b58a3a6daeca2ea2.1771873256.git.alison.schofield@intel.com>
References: <98851c4770e4631753cf9f75b58a3a6daeca2ea2.1771873256.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CXL decoder flags are defined as bitmasks, not bit indices.
Using test_bit() to check them interprets the mask value as a bit
index, which is the wrong test.

For CXL_DECODER_F_NORMALIZED_ADDRESSING the test reads beyond the
flags word, making the flag sometimes appear set and blocking creation
of CXL region debugfs attributes that support poison operations.

Replace test_bit() with a bitmask check.

Found with cxl-test.

Fixes: 208f432406b7 ("cxl: Disable HPA/SPA translation handlers for Normalized Addressing")
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---

Changes in v2:
Split patches to align w Fixes Tags for backport ease
Rebased on 7.0-rc1

 drivers/cxl/core/region.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 780ec947ecf2..42874948b589 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1105,7 +1105,7 @@ static void cxl_region_setup_flags(struct cxl_region *cxlr,
 		clear_bit(CXL_REGION_F_NEEDS_RESET, &cxlr->flags);
 	}
 
-	if (test_bit(CXL_DECODER_F_NORMALIZED_ADDRESSING, &cxld->flags))
+	if (cxld->flags & CXL_DECODER_F_NORMALIZED_ADDRESSING)
 		set_bit(CXL_REGION_F_NORMALIZED_ADDRESSING, &cxlr->flags);
 }
 
-- 
2.37.3

