Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A9F22334;
	Fri,  6 Sep 2024 03:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725592159; cv=none; b=sq8htZH0F1PCF4k9rk37EMHdhcGQ35uQf+3ohlhDbV5sUC0X+cg0Y/Q6NAJmA++7QoR7wLC3uZ/2DyZiFkBIh0qaXbXUTfvxl2Y6IgqPjHEmikYA9agIXe33T9xRebS6gnhggALnxAlJEqv9IygCyw1hB+ORmuw080xKNkU+SzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725592159; c=relaxed/simple;
	bh=o18ZWAutwQsr0SHaXGrMBCAo0m0ovYiksuGFL+bbRs0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QfhuyhrelFHkeqiJonfj/1HtqFckyT6cSgyE4SJZipNmBolOa9RLUBt3J6NgLNE0Yo8ek8FVUZiMiN+hIPqpLIxED6ze96l+I4nzhqLF0tMOO36DVglfKRPkz2DD5CpyOB69rcoWuha5Rn5koJBUTiMqade6lo1Cs5+OkXDbTPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TcGmALFf; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TcGmALFf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725592157; x=1757128157;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=o18ZWAutwQsr0SHaXGrMBCAo0m0ovYiksuGFL+bbRs0=;
  b=TcGmALFfxaEYngfJeik2Cd6jCAIXrCLcShFOhazHmmeFPkd1C261swmx
   D21nhR0bMNjevrL6C8hsZYcZ9f0Lm7A2rNn4jnC0o0Owx3CJ75eSx2J+v
   swLcAhqhy2Cl0IoFUm7NQh+9vA0kYwPtPhCGfvWG7PphlemJjYvpr3cmH
   v4y0rfQCWgkFHRvvCQEOBE1mvjY7VAbKsPxp4rkHQgC32rVvmQytDfULA
   2hsv7uAeQ32RUm/aPj13e53lJ52fNurU22x7cKuN05GrCerBdmQuiQARb
   OdHEf41TNejmFT20XtD2V5ARmxLm51LbdGObbHF1dtTl1sF9EbkCE5bBX
   A==;
X-CSE-ConnectionGUID: Tp1hhJurQzqe5xWN8LOzNw==
X-CSE-MsgGUID: BayWsm/aSFGjUeXSRjiAiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="28089447"
X-IronPort-AV: E=Sophos;i="6.10,206,1719903600"; 
   d="scan'208";a="28089447"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 20:09:16 -0700
X-CSE-ConnectionGUID: qxUN/gzqTU+WWFJtixe5Fg==
X-CSE-MsgGUID: A2kE5qfbQpmswl9Cyd+CrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,206,1719903600"; 
   d="scan'208";a="66364336"
Received: from unknown (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.245.242.189])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 20:09:13 -0700
From: Huang Ying <ying.huang@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	"Huang, Ying" <ying.huang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH -v3 0/3] resource: Fix region_intersects() vs add_memory_driver_managed()
Date: Fri,  6 Sep 2024 11:07:10 +0800
Message-Id: <20240906030713.204292-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patchset fixes a bug of region_intersects() for systems with CXL
memory.  The details of the bug can be found in [1/3].  To avoid
similar bugs in the future.  A kunit test case for region_intersects()
is added in [3/3].  [2/3] is a preparation patch for [3/3].

Changelogs:

v3:

- Revise the patch subject, description and comments, Thanks Bjorn,
  Andy, David, and Dan!

- Added a kunit test case.

- Fixed several coding style issues, Thanks Andy!

- Link to v2: https://lore.kernel.org/linux-mm/20240819023413.1109779-1-ying.huang@intel.com/

v2:

- Fix a bug which occurs when descendant of a matched resource matches.

- Revise the patch description and comments to make the algorithm clearer.
  Thanks Dan and David's comments!

- Link to v1: https://lore.kernel.org/linux-mm/20240816020723.771196-1-ying.huang@intel.com/

Best Regards,
Huang, Ying
