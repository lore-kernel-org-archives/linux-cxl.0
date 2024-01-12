Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F761641B
	for <linux-cxl@vger.kernel.org>; Fri, 12 Jan 2024 20:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fepPl2pu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705090202; x=1736626202;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aMscEsh2ij9bWirfWau0H+lsiZ2rnBEoqeVXzB1Bwlw=;
  b=fepPl2puz/FGdZkkHQR3doHWpJ75G5hteU+YCTdehrwKF7g7XyUP9JZ5
   dvISSQgMwkw56VztCLoygkmF04vZveOrlOX9HsuaVRb1Xsk9NXOZBPqW2
   9Jkdi94MqzwmebquFyvrwX+1qohvXDxLkc2Civ/K8R/78H6bZuexuNVAm
   lHENN0+iZmomdCixcql8jI95boY0coX8lE8TncrxfJy7KHE36z0Qb+US0
   gM0oo4M1XatCfrMcSIheoKm/tQitx4u/FEb+VPR4IXHDuse0oM807KtEa
   ZccKFjK7GjVVPEj2vv9ZjZeUgY1/t88aGRfTV6LDRjzDV8itG8NL8tQox
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="6634133"
X-IronPort-AV: E=Sophos;i="6.04,190,1695711600"; 
   d="scan'208";a="6634133"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 12:10:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="1030030298"
X-IronPort-AV: E=Sophos;i="6.04,190,1695711600"; 
   d="scan'208";a="1030030298"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.105.99])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 12:10:01 -0800
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
Subject: [PATCH 2/2] x86/numa: Fix the sort compare func used in numa_fill_memblks()
Date: Fri, 12 Jan 2024 12:09:51 -0800
Message-Id: <99dcb3ae87e04995e9f293f6158dc8fa0749a487.1705085543.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1705085543.git.alison.schofield@intel.com>
References: <cover.1705085543.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

The compare function used to sort memblks into starting address
order fails when the result of its u64 address subtraction gets
truncated to an int upon return.

The impact of the bad sort is that memblks will be filled out
incorrectly. Depending on the set of memblks, a user may see no
errors at all but still have a bad fill, or see messages reporting
a node overlap that leads to numa init failure:

[] node 0 [mem: ] overlaps with node 1 [mem: ]
[] No NUMA configuration found

Replace with a comparison that can only result in: 1, 0, -1.

Fixes: 8f012db27c95 ("x86/numa: Introduce numa_fill_memblks()")
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 arch/x86/mm/numa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 8ada9bbfad58..65e9a6e391c0 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -934,7 +934,7 @@ static int __init cmp_memblk(const void *a, const void *b)
 	const struct numa_memblk *ma = *(const struct numa_memblk **)a;
 	const struct numa_memblk *mb = *(const struct numa_memblk **)b;
 
-	return ma->start - mb->start;
+	return (ma->start > mb->start) - (ma->start < mb->start);
 }
 
 static struct numa_memblk *numa_memblk_list[NR_NODE_MEMBLKS] __initdata;
-- 
2.37.3

