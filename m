Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5C934BA24
	for <linux-cxl@vger.kernel.org>; Mon, 13 Jul 2026 20:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783975465; cv=none; b=pC7D/9qa3p7cRXZstZTXjOwZewC997ji3mpTIGxYd9aCbJ/pJhuB1uwg5c9LmLr4C6u2iLlzl8UZYh+BOsOsMlivMlfzu8JB34Ed+7rfmPFQ5eQ8FL5q0tWmCgylC5V9bDQ5YlQQtvu2JEjKxSn2byIKINd62bgZg4gc5H1o4No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783975465; c=relaxed/simple;
	bh=PfHWtTKvKLYgIVSlV1Xri8/XThVJzdBGr9PW2UcysJM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rd1WS55KhB99hlcqYWvtl/qJVclpPil5XUDtNpqrrkN9l/TSB0G8fUvXYL3LT2NnpINRd+aeNz7qQB9zRgSoljSTENH0OU34ocWF6c2mGFohnSMRhaGWkeQHdQ7VCiEMUIkbNTghPdDraMuud2GmepR2J9EgwuqbTqSz5JHkoM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j505zsrx; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j505zsrx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783975462; x=1815511462;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PfHWtTKvKLYgIVSlV1Xri8/XThVJzdBGr9PW2UcysJM=;
  b=j505zsrxXe4uCMZp4JV0UIpd/5K7Qb5TCIYke3GozIEw6ZLwU+wHJzKC
   +0BM8rw4winiht7EzsRgdmDLFpu9BDmnZSXdkDkr2uQSqRdSAUnwYrhjv
   A6dEaqnTu3Ks+NekkBtrAfbZxoVwTHVJ27Hn6Lj30xjV15xqj9P9VrCoc
   wapYSKphcfWmGdvrckiIXbn4rBXN2nEx8VGG5ATkKsmBLvip2OOKa/FHe
   p9ZJZeW2WdYbTuvBUJM7hrok703Qjw1nP0PcdFh2FrRxxubnggdMe4/q8
   nxTdBXZEWU49d/bjF3N1kAPi3P6Q0OfBRcPioCcRFEDorMnPkrQgfiH4l
   w==;
X-CSE-ConnectionGUID: 2oRHWBn2RVeGakv4QMs76g==
X-CSE-MsgGUID: JdWigTFVQuC233rG0U0d0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84555377"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84555377"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 13:44:21 -0700
X-CSE-ConnectionGUID: F1FlhjDkS/yQJXUHBcYBLA==
X-CSE-MsgGUID: a5q9uZbrRHeICI5ha6YRQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="252270371"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.220.12])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 13:44:20 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Dan Williams <djbw@kernel.org>,
	Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH 0/3] Harden HDM decoder enumeration
Date: Mon, 13 Jul 2026 13:44:10 -0700
Message-ID: <cover.1783974681.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here are 3 Sashiko reported cleanups.
Only the first includes a link to the complaint, since the others did
not originally appear on Lore for me to add public links. 

Srirangan: I believe the first 2 of these also address pre-existing
issues Sashiko posted in reply to your reset series, Patch 02/11.


Alison Schofield (3):
  cxl/hdm: Reject switch decoder interleave ways that overflow targets
  cxl/hdm: Make switch decoder target parsing endian-safe
  cxl/hdm: Restore commit_end when decoder enumeration fails

 drivers/cxl/core/hdm.c | 31 +++++++++++++++++++++++++------
 drivers/cxl/cxl.h      |  2 ++
 2 files changed, 27 insertions(+), 6 deletions(-)


base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
-- 
2.37.3

