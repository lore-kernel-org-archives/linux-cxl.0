Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D8129A1
	for <linux-cxl@vger.kernel.org>; Sat, 20 Dec 2025 00:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766188965; cv=none; b=QcKtLtWQwbUJSMnYLGB4j2mFnevNnLoAAOoYSAvRvg/KPehIVCP2y6FO05jYNHyRYwFPQuI+cV4t4C1JQIcH9VUEBK6wypANDoSE8xcXtY6t2561vPh8EcTGrjOiS4hhObCgPqU/xwEsqZCy+YQTrwEydx3ILAqL1m44ZCf11vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766188965; c=relaxed/simple;
	bh=vc+XxLwHeHijZjTHWLK3bfvxAqVVeHaAZAFFzRoBPHg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d1sNWG1q9TdfBU+xzn0MB+mwdsOaHZc3RjvXqwyFAjsLB29O1/51RMFIg+gyulBIkb+uc85bhviX+lOvrG8RNIHxyXRwaSPgEfXcESxmXw5SkvzuxZ8hA/9UTu6wMYdUhLfBLR5PcrgjGV1BQn3+wDhnOSnMc/pfmKe0evEGm+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VOgrW77Q; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VOgrW77Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766188964; x=1797724964;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vc+XxLwHeHijZjTHWLK3bfvxAqVVeHaAZAFFzRoBPHg=;
  b=VOgrW77QyOzfLIKng8o0fQZDA/noSg9+P0/bqpkle4p/f65Sj8Tsd9LC
   AJYqLOXzKEiQtva6wjzBAmIlK5sEQ8Xo07Xi35n6Nd0Zi0xSCskH4VKAV
   bjR6nn7VquKQya16zmYSvXQ1SHePdsgc3RTKqnW5M66BF7mWJSoWPxR+S
   rMeRlHkBz50Gh5qmk4B3wQyEtCohVgNU25xwHVcP6yhtEkkyYPuVRfjSO
   c7KfoQrxSLVL9NkCXmWOg5zOccm3/oiso+u7ZFh88W/M3bByTpK62+Xlf
   +ygMwY7Mi+XqSWwcBUhFg8VkfhpSrBKH1MV9HZV7lQ0zieIwRXryasOe0
   g==;
X-CSE-ConnectionGUID: fcuP+nm8RvCY2YAo/8WiTA==
X-CSE-MsgGUID: tmTQ6fAFSo6GQEaCywpTtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11647"; a="72011083"
X-IronPort-AV: E=Sophos;i="6.21,162,1763452800"; 
   d="scan'208";a="72011083"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 16:02:43 -0800
X-CSE-ConnectionGUID: t6+gLKB7S9SdlyizljaHAg==
X-CSE-MsgGUID: Z2883YGqTfKX0tfEpDL3tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,162,1763452800"; 
   d="scan'208";a="203518335"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by orviesa004.jf.intel.com with ESMTP; 19 Dec 2025 16:02:42 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-cxl@vger.kernel.org,
	David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	John Groves <John@Groves.net>
Subject: [PATCH] MAINTAINERS: Notify the "Device Memory" community of memory hotplug changes
Date: Fri, 19 Dec 2025 16:03:27 -0800
Message-ID: <20251220000327.3502994-1-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The recent episode of a warning regression in memremap_pages() [1]
highlights that relevant updates are being missed by folks that care about
core ZONE_DEVICE changes. Yes, CXL folks should pay more attention to
linux-mm@, but it also would not hurt to copy linux-cxl@, where most Device
Memory folks hang out, on memory hotplug changes by default.

Link: http://lore.kernel.org/20251219123717.39330-1-john@groves.net [1]
Cc: David Hildenbrand <david@kernel.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: John Groves <John@Groves.net>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5b11839cba9d..076322fe91de 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16426,6 +16426,7 @@ MEMORY HOT(UN)PLUG
 M:	David Hildenbrand <david@kernel.org>
 M:	Oscar Salvador <osalvador@suse.de>
 L:	linux-mm@kvack.org
+L:	linux-cxl@vger.kernel.org
 S:	Maintained
 F:	Documentation/admin-guide/mm/memory-hotplug.rst
 F:	Documentation/core-api/memory-hotplug.rst

base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
-- 
2.51.1

