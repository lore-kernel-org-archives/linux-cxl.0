Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD54152DE3;
	Tue, 18 Jun 2024 08:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718700417; cv=none; b=MfeWMyA3ETTWx89Qns9HrosugWmfKJw4iRvwR1N3MoMGX76nlP+q3hQnmhK0YVbh0LXE1lJ2Yyr0k3isS9A337JvgVZ58ie16rJa+h1btOz3tC9CvPq9+y9EXrh1/Z1orHrQ1IBo0yLW/VEC1YaGu7mb0fAcCpnKnrMny21+nuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718700417; c=relaxed/simple;
	bh=EXUG2xOLGZ/+vsyiFn2tp5Pl5eqGfsMh0GN8fxltb1A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I2ZkbvbJzOQ5+V+ZOknbNhWeEJsZTJIipHKtS99SYqSDnQXARU18/hBDcJGlXLpgaoUjsX2QFRwZn6sdFgP75zGok2UiVZWAeXf1hrU5ut/7OjjfGkUVU6SaghPWENCie2GPcPlcFttge4GwoTKuFGuA2bCFScCz/D3ubrjv1YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jlK790GH; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jlK790GH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718700416; x=1750236416;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EXUG2xOLGZ/+vsyiFn2tp5Pl5eqGfsMh0GN8fxltb1A=;
  b=jlK790GHHwq8aBkybRYV9i1agWAPnuQ8VsyBfi27wAW67SbWebNsOZPA
   RQgEXWyZ8yAe4DoxzWd5ERnKkjM/yAWF8sfsFrmO54lc3QYAYmQccbQsA
   soWht7eLYgHU6nDPFgkr4FhwliZAU/EvyxPqd6Cz/+k4CoepAoWAuOubk
   QA6w0xBP/R5G4ZAr3TbAN0HNQ3na2AblYREwgo+FePtUhSuJu7Lf0Mou3
   K3mDw0WleddYKz6eQ3QuN4gcXGgdbkegg8bi4Dg+p5q7uslYAF+pBk/ax
   MDg9GAJgpa6xvwXPju6wmmgS1oHiZaypIL+G5tDGzhKzDCMEX9qQDgyss
   g==;
X-CSE-ConnectionGUID: 2dueHN8FScGCayWIEmNo0A==
X-CSE-MsgGUID: ea/7cGzNRO2an851vimk4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="15431585"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="15431585"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 01:46:55 -0700
X-CSE-ConnectionGUID: JGj8NRShQV2f71LUFsZ3oA==
X-CSE-MsgGUID: Jian/yQZTaatjlmZV4WTFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="78933621"
Received: from shilinmu-mobl.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.255.28.204])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 01:46:52 -0700
From: Huang Ying <ying.huang@intel.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Bharata B Rao <bharata@amd.com>,
	Alistair Popple <apopple@nvidia.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v3 0/3] cxl/region: Support to calculate memory tier abstract distance
Date: Tue, 18 Jun 2024 16:46:36 +0800
Message-Id: <20240618084639.1419629-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series add support to calculate memory tier abstract distance for
the node backed by a cxl region.

[2/3] implements the feature.  [1/3] fixes a race condition of
dependency code.  [3/3] does some code simplification.

Changes:

v3:

- Collected acked-by from Dan, Thanks!

- Added a race fixing patch [1/3].

- Revised patch description of 2/3 (Thanks Alison!)

- Added missing unregister_mt_adistance_algorithm() call.

- Added a code simplification patch [3/3] (Thanks Alison!)

- Link to v2: https://lore.kernel.org/linux-cxl/20240611055423.470574-1-ying.huang@intel.com/

v2:

- Added comments to struct cxl_region and minor fixes (Thanks Jonathan!)

- Link to v1: https://lore.kernel.org/linux-cxl/20240531024852.282767-1-ying.huang@intel.com/


--
Best Regards,
Huang, Ying
