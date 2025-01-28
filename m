Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8DC192B85;
	Tue, 28 Jan 2025 18:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738090273; cv=none; b=YYgSPR/1/RbPf770FgXuP9LiZ9Ur4BAOFtkpy/KnL1r7fn4r7GhiGR83KbLHdpPXMTVaHwDCsJFmsWGLPZ0XogsNw1CYEkJ1cK3Lfr0eKqYP61ZgFdYVYrhCjcMRCnmmllrUkBdNYHT4bObUO9+sjaTJaO9lKAKL+0p1vAqMyxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738090273; c=relaxed/simple;
	bh=0jDCoCi7sLNG57pvNNppomUhK990HzbHjgYk6OU/Ehk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lMBvE++YZAEEQwETPQMQso8cWVvzIyba/I6nXI9/L0LduePjZoFXNeJMCyVjkMKowcBHu5VzZOufK5v+VIrRRDVGxOYMIPxjXf2/phOsLzAzidk4h1QYZuPVrwSTIAavLOAg3iOw9t5yzCq5N/V7Eoh2bGTzK1Lv8DD/kjF28Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KffFnouM; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KffFnouM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738090271; x=1769626271;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=0jDCoCi7sLNG57pvNNppomUhK990HzbHjgYk6OU/Ehk=;
  b=KffFnouMMFuQADKrfk0BJlqSs7ssjTWbYUrBpcXAkv4dAP9lvr+3Hd2y
   WLVL1MdgcngkYkXVgU2Vuicay+V9tz3i54DEb1V2B+5LqKu7nqUJ0m5ok
   ECt19jrAXoOyYvUeoUHkytlCvi0fj//+ICBK8i4cFoIoGR9xzU1kXez3p
   OR1UwF/aSBkfsOgOuLBOBAAftJse6Z0dreHkCXwrZkPcy49LXiCUn6ODy
   gUtkrcEW10fCDEqOFH12Eo9VhTQsTyujR5uM5ujtnnoHfwH7XMzxeF5MV
   DoaJOeOMibLBBjsFuqqoz4YMtTgs+eOI9dd4Zo/VbDqCYnAzRNlSnoAJx
   A==;
X-CSE-ConnectionGUID: jCI8pVItRM+gECd1sxFk3g==
X-CSE-MsgGUID: dsn6rHqFTEqKtNBRuOdXmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11329"; a="49177329"
X-IronPort-AV: E=Sophos;i="6.13,242,1732608000"; 
   d="scan'208";a="49177329"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2025 10:51:11 -0800
X-CSE-ConnectionGUID: PGAwLF15Sea1E/W0w3+yXw==
X-CSE-MsgGUID: GqWTW2hERMC52Z9rMi84hA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="108676675"
Received: from puneetse-mobl.amr.corp.intel.com (HELO localhost) ([10.125.108.40])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2025 10:51:10 -0800
From: Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH RFC 0/2] cxl: Further clean up of memdev state
Date: Tue, 28 Jan 2025 12:51:06 -0600
Message-Id: <20250128-rfc-rearch-mem-res-v1-0-26d1ca151376@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABonmWcC/x2MuwqAMAwAf0UyG7BFRV0FP8BVHGKNmsEHKYgg/
 XeL291w94JnFfbQJC8o3+LlPKKYNAG30bEyyhwdbGaLzJgSdXGoTOo23HmP6DF3U001VdaWBDG
 8lBd5/ukAfdfCGMIHp9mibmkAAAA=
X-Change-ID: 20250116-rfc-rearch-mem-res-4cb9a9a8226a
To: Dave Jiang <dave.jiang@intel.com>, 
 Dan Williams <dan.j.williams@intel.com>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738090268; l=1229;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=0jDCoCi7sLNG57pvNNppomUhK990HzbHjgYk6OU/Ehk=;
 b=D69SYslPpOTOjGBeCD0c7NFeFHME2li6p5jNwXD4HQdPtMhFIGvj2my/1PyT/Wm4+uiWg7ckP
 EIvv+qaJkCNCbX2YdHJfF9DVU8DIhrZfHNNQ63ef+0t1FfYVpFl/lY+
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

Dan has identified issues with the way the CXL core manages data within
the cxl_memdev_state object.[1]  Rather than just change DCD, clean up
cxl_memdev_state prior to DCD so the addition of DCD is consistent.

These clean ups are based on top of Dan's re-architect of the handling
of DPA partitions. [2]  They are intended to land after his v3 of that
set which is due out.

Link: https://lore.kernel.org/all/67871f05cd767_20f32947f@dwillia2-xfh.jf.intel.com.notmuch/ [1]
Link: https://lore.kernel.org/all/173753635014.3849855.17902348420186052714.stgit@dwillia2-xfh.jf.intel.com/ [2]
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
Ira Weiny (2):
      cxl/memdev: Remove unused partition values
      cxl/memdev: Remove temporary variables from cxl_memdev_state

 drivers/cxl/core/mbox.c      | 81 ++++++++++++++++----------------------------
 drivers/cxl/cxlmem.h         | 29 ++++++----------
 drivers/cxl/pci.c            | 13 ++++---
 tools/testing/cxl/test/mem.c | 13 ++++---
 4 files changed, 59 insertions(+), 77 deletions(-)
---
base-commit: 17f710b7327024d16b9c98672462d603aa821920
change-id: 20250116-rfc-rearch-mem-res-4cb9a9a8226a

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>

