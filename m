Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8C016426
	for <linux-cxl@vger.kernel.org>; Fri, 12 Jan 2024 20:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="feC9YjfD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705090200; x=1736626200;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HwtN7teoVx60sfsw3JD29R2XHjua/K3/+Hv+RYHYTNM=;
  b=feC9YjfD5HcJ/3WmUl/UDhfpCJJG8wDO+jWwsoaeT3GOBfx5tiBVDs1n
   h44npV3GJKHfC261JQVKx/QgYSY1VxcsYbK/Dj2THmywzS+fAvC8/JEt3
   HnUFpTJfk9zp4AGRO2wBPNpx+YjSyd1YLg86l+RGpEJ8Wsm3iQineBXaD
   GZp9pYY6DunglAHijm5SjXYJ1u9nZ0XnE5/W8r49GQMiUB44EvbBaLzhY
   0ELgDlP0ECIA3WkVtblPIXG50+82Tv2quEPQQurh2PFffrhY6yGLnRX2/
   f6P4AuIbiYpGUt9LZFf4ecpZDWUkffqj+nG121JruSiZhjxFyVrcG2dKR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="6634102"
X-IronPort-AV: E=Sophos;i="6.04,190,1695711600"; 
   d="scan'208";a="6634102"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 12:09:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="1030030284"
X-IronPort-AV: E=Sophos;i="6.04,190,1695711600"; 
   d="scan'208";a="1030030284"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.105.99])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 12:09:58 -0800
From: alison.schofield@intel.com
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Mike Rapoport <rppt@kernel.org>
Cc: Alison Schofield <alison.schofield@intel.com>,
	x86@kernel.org,
	linux-cxl@vger.kernel.org
Subject: [PATCH 0/2] x86/numa: Fix NUMA node overlap & init failure
Date: Fri, 12 Jan 2024 12:09:49 -0800
Message-Id: <cover.1705085543.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

A previously posted single patch [1] is obsoleted by this set. The
feedback from that review is applied and noted in Patch 1.

While trying to attribute a CXL user report to the bad selection of
overlapping memblks, as fixed in Patch 1, I found that two issues,
in sequence, lead to NUMA Node overlap and NUMA init failure.

An overlapping NUMA node occurs when a non-overlapping memblk is
selected to fill (Patch 1), and then a bad sort (Patch 2) puts the
memblk with the greater address ahead of the lesser address memblk
in the fill list.

It looked like this:

Existing memblks:
	node 6 [mem 0xb90000000-0xc90000000]
	node 7 [mem 0xc90000000-0xd90000000]

Call to numa_fill_memblks(b90000000,c90000000)

Error (Patch 1): collects 2 blks  
	blk[0] node 6 [0xb90000000-0xc90000000]
	blk[1] node 7 [0xc90000000-0xd90000000]

Error (Patch 2): bad sort of the 2 blks
	blk[0] node 7 [0xc90000000-0xd90000000]
	blk[1] node 6 [0xb90000000-0xc90000000]

Seals the deal with a bad fill:
	blk[0] node 7 [0xb90000000-0xd90000000]

Boom: numa_clean_meminfo() discovers the overlap in Nodes 6 & 7
and NUMA init fails.

Since the scenario above is not solely attributed to either patch,
the story is explicity shared here.

[1] https://lore.kernel.org/linux-cxl/20240102213206.1493733-1-alison.schofield@intel.com/

Alison Schofield (2):
  x86/numa: Fix the address overlap check in numa_fill_memblks()
  x86/numa: Fix the sort compare func used in numa_fill_memblks()

 arch/x86/mm/numa.c       | 21 ++++++++-------------
 include/linux/memblock.h |  2 ++
 mm/memblock.c            |  5 +++--
 3 files changed, 13 insertions(+), 15 deletions(-)


base-commit: bd009225e8cbb6e18ad3389328fa640e4887dd9e
-- 
2.37.3

