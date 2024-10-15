Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08930189BA7;
	Tue, 15 Oct 2024 06:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728975498; cv=none; b=Nkbo6t8HRLmH/PpetwsuPySknD3Cp5aIY1im6gcCrxlVt0X/Ym2aZb+QbdY8fp7Bv8qBgZcVdWZjTgE9Uo9hWRbiQlbiStgiC2BFqfLccC/ofIeSbb32EdViub1TSz2JSpjt9QT2qxZJXIY8In1eehWZ6ys60VCLfafER6XaP/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728975498; c=relaxed/simple;
	bh=8lQqbWw6Enw+eklZHJGZTOhSRk4GGcFepVWdCPy9COg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sd4tA32xSqLaEtdeMLx/M2c96ilYjomE1fFVpUK2I2rFpB49SQBDEQ1xS86JUJoF2k3XIwW7M49d/xGHqZ5l+5J/T5NUE7I1gDHjElI1BDDnQYK3Fox3zMD+reNB0UOWq5//OQIBEfV6hNJ3/Emns9zgEdIWTzIVAbMLFk/MChI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UBkKvWzg; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UBkKvWzg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728975497; x=1760511497;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8lQqbWw6Enw+eklZHJGZTOhSRk4GGcFepVWdCPy9COg=;
  b=UBkKvWzgZA1GKCBc/TAJayFCWa7CVjCUu14foEaR9Jh1M2LF+1xuMeOP
   3gJpAOZvqD9FnhktFpdSyAYdB7OJJ90zJc4yW3JiNN1z3OiBeCLaMC5n/
   8kYiorgWV6ohnYprHmfK1MuonxL8hNMqNDqfR/bLX4SgoVFXp4AiBm1aY
   HHm+fXE4MBhYDPoC03IH2NeFUQX1sy9ahukO8B2+ZSPI+f7+vaaEzro+6
   /RQEJXbLROFipyW4LcSygdBi15hD0meLkTswhXV2BaXGCdm1RVlwqBe8R
   ezCnYVLuP7W889U6mb4hyXtVN9rMYUGpcceQ1KG5vFS84QoapfLMQpxm8
   g==;
X-CSE-ConnectionGUID: Im+4/uG1Rjm9OKnAcmJKTA==
X-CSE-MsgGUID: qWzjr9zURMyj44SVPBrrog==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="28447791"
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="28447791"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 23:58:17 -0700
X-CSE-ConnectionGUID: jVCCtqDzRNCa4x9ieWRARw==
X-CSE-MsgGUID: k4+QcVj7RhSnzOgGlG/Thg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="81776905"
Received: from yhuang6-mobl2.sh.intel.com ([10.238.3.32])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 23:58:13 -0700
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
	Alejandro Lucero <alucerop@amd.com>,
	Gregory Price <gourry@gourry.net>,
	Ben Cheatham <benjamin.cheatham@amd.com>
Subject: [PATCH 0/5] cxl: Some preparation work for type2 accelerators support
Date: Tue, 15 Oct 2024 14:57:08 +0800
Message-Id: <20241015065713.308671-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series implement some preparation work for the type2 accelerators
support.

We have tested the series with cxl_test via mocking a type2
accelerator as in [1].  Because we need more type2 accelerators
support to simulate a type2 device, we don't include the cxl_test
patch in the series.

[1] https://lore.kernel.org/linux-cxl/168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com/

Changes:

RFC->v1:

- Collected Reviewed-by, Thanks Davidlohr and Gregory.

- Some minor fixes, Thanks Ben and others

- Thanks Jonathan to suggest to revise type2/type3 and coherence naming.

- Rebased to latest upstream

- Link to RFC: https://lore.kernel.org/linux-cxl/20240925024647.46735-1-ying.huang@intel.com/

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
 drivers/cxl/cxl.h            | 29 ++++++++++++------
 drivers/cxl/cxlmem.h         | 12 ++++++++
 include/acpi/actbl1.h        | 10 +++----
 tools/testing/cxl/test/cxl.c | 24 +++++++--------
 9 files changed, 135 insertions(+), 63 deletions(-)

Best Regards,
Huang, Ying
