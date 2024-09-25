Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF59F647;
	Wed, 25 Sep 2024 02:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727232431; cv=none; b=Npg2f5wKOm25AiTGO0ii8FNLV7zgD8myHz2b2cFbNi2xf4M5AJ1GXgTyYWXiFSb1MC6M9y9OB5neFxv/a+FvhzXFBZXNXuIZdfjDYVgpDXFOrbJRqe1dCskhjwCxVkR2rWS0xh2Y1r1EbfQCOiPcypc4kxhLItJoET41xd5YDd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727232431; c=relaxed/simple;
	bh=oaQE6hd7RvtSy106D6ugYqDvaO565pG0/zqJCR9JgxU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hRhLWa491LqSvwOYSRlqAzr9trWC3zHqff+xrlwnWtHt1+drXXa5By6QHtHaIQJD6YC2B3o6W2tIioppKmYsZQRlVYxXuqptdX0m5+GH7ehjQ3JHsaRq0VrVshFoUKLEP0EMu4+Qc50d3oCaWceZcgArxrH+h2YBX2cHsU6FWfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mKVcmwBI; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mKVcmwBI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727232429; x=1758768429;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oaQE6hd7RvtSy106D6ugYqDvaO565pG0/zqJCR9JgxU=;
  b=mKVcmwBIMGDj2g0plex7crP/sVjcmtDi8IWk1jGHiWpwhuvEXv+zzZmP
   JwxwpuPLRKswly9hYFfoqlFkd6YbVwpH4LSz6YbdwJJsidWRQqthxRF9X
   qrFcohw80kbbvJGBwMhzKlwSmZU3WLedV1BK0v3MKLwgiNXXnHKzrp2sZ
   1zdOCZyIKyldUMxWjRQr/MSjUTdJ1CE+lGYBnZ9yrlV+R5e8dDuL75egC
   ygt6Z4l88YI0qYSi8ynl43346kUzRkw3ZU8waM4C5KTUu4a6NlaHEtCUa
   MGkxh+pQ8LPJZWw2ytB63hPNC6JtewK8weeDbHIjoCM77xM2AMiBOHYQf
   A==;
X-CSE-ConnectionGUID: TcS122HXTtmpllEJ2hwEGA==
X-CSE-MsgGUID: ieAUvdNnSkKHC4U4IYDYpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="26132016"
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="26132016"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 19:47:09 -0700
X-CSE-ConnectionGUID: WMimAwU5TRu3ZuQesnKPsg==
X-CSE-MsgGUID: /b13eS66TwiNOCQ35LVgbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="102388960"
Received: from yhuang6-mobl2.sh.intel.com ([10.238.3.32])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 19:47:06 -0700
From: Huang Ying <ying.huang@intel.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Huang Ying <ying.huang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Alejandro Lucero <alucerop@amd.com>
Subject: [RFC 0/5] cxl: Preparation of type2 accelerators support
Date: Wed, 25 Sep 2024 10:46:42 +0800
Message-Id: <20240925024647.46735-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There have been 2 series to add type 2 accelerators support in [1] and [2].

[1] https://lore.kernel.org/linux-cxl/168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com/
[2] https://lore.kernel.org/linux-cxl/20240516081202.27023-1-alucerop@amd.com/

Both provide relative complete support, but both are long too.  To
make it easier to review, some preparation of type2 accelerators
support is implemented in this series.  More complete support can be
implemented based on it.

This series has been tested with cxl_test via mocking a type2
accelerator as in [1] above.  Because more type2 accelerators support
than that provided by this series is needed to simulate the device,
the cxl_test patch isn't included in the series.

Huang Ying (5):
  cxl: Rename ACPI_CEDT_CFMWS_RESTRICT_TYPE2/TYPE3
  cxl: Rename CXL_DECODER_HOSTONLYMEM/DEVMEM
  cxl: Separate coherence from target type
  cxl: Set type of region to that of the first endpoint
  cxl: Avoid to create dax regions for type2 accelerators

 drivers/cxl/acpi.c           |  9 +++---
 drivers/cxl/core/hdm.c       | 38 +++++++++++++----------
 drivers/cxl/core/mbox.c      |  1 +
 drivers/cxl/core/port.c      | 17 ++++++-----
 drivers/cxl/core/region.c    | 58 ++++++++++++++++++++++++++++++------
 drivers/cxl/cxl.h            | 28 +++++++++++------
 drivers/cxl/cxlmem.h         | 11 +++++++
 include/acpi/actbl1.h        | 10 +++----
 tools/testing/cxl/test/cxl.c | 24 +++++++--------
 9 files changed, 133 insertions(+), 63 deletions(-)

Best Regards,
Huang, Ying
