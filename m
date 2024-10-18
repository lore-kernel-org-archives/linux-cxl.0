Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0BD383B1
	for <linux-cxl@vger.kernel.org>; Fri, 18 Oct 2024 01:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729213849; cv=none; b=siqs/wwbMvtjpEgWJWZqnF2QJJNeUnF+mGVwyBwcUHV7J6E7OkBqNkyHReSnSngYZsc51n1VOHwHVxI6dzGaDPPaZ/YBTJESWrKnsPEAEx5NPJYpT/K5gh7jeuYT5B9f5dWFPhIZwSumy06nEaJygPlYGmR+3i/fCu9yLUkO4M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729213849; c=relaxed/simple;
	bh=ot67kOIhc+gksHSjDUb5uOTDbkKtQpC9xBVjiSwocu4=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=N1DZo2dmZjsmV24fRVBps8EQTWyIaizkLYMtg5cLC3OZfH3xzGi/Q7yvYuWd9+kmPCm+LUD/+d0uVVvl2DqfFhjJNNQGRdMjEd9HsUmNQQruzeNnEFOQj1XOheQwH/l6gx7oKx36Vsws/uYQH5MELgG0/MtR/nPRjFcPpM6kudA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FKY1gE+T; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FKY1gE+T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729213848; x=1760749848;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ot67kOIhc+gksHSjDUb5uOTDbkKtQpC9xBVjiSwocu4=;
  b=FKY1gE+TwHVja9s64PTVGKkk4kqU/8+sKAFtDJtpPmgK5PXl9jGQVZNw
   0IJVaFkBazZiDYHaFRn1Oi8hJ8T1X8FKGDbWjvyRCm+gbGXDPSaGeB66W
   vT7vOcKzbhNLFp/veLFk9jZIgKBHHYJ9tPPdLtk3z3GUMh01qf4baLm8r
   2X9zlLywcrIvsoBfb/bmueoh6GngcJvUO1JiZgErhgwUUSM1uiNDDFHXj
   N/pcfL+swhoDqE+cdx326RhwU06iL6p8Eq+STIiDdZzguGlppXURKDyVG
   GFbhpHgdwcLvxmEfYw75djAwsNS0J/tSdxsCIaJDyQKQG6mGp5qYPMLA0
   Q==;
X-CSE-ConnectionGUID: e57HLVzESOOYR8gCWQiI7A==
X-CSE-MsgGUID: Ao+YeQZsSl2Mg4F0GnLJNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="28168552"
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="28168552"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 18:10:46 -0700
X-CSE-ConnectionGUID: R5Y4a2AXQL2xwR/0ZhGeBg==
X-CSE-MsgGUID: xK133gQ6S3Csuz6oFf55EA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="102023982"
Received: from rfrazer-mobl3.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.125.109.118])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 18:10:10 -0700
Subject: [PATCH v2 0/3] cxl/port: Cleanup add_port_attach_ep() "cleanup"
 confusion
From: Dan Williams <dan.j.williams@intel.com>
To: ira.weiny@intel.com, dave.jiang@intel.com
Cc: Li Ming <ming4.li@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, linux-cxl@vger.kernel.org
Date: Thu, 17 Oct 2024 18:10:08 -0700
Message-ID: <172921380683.2133624.1708770961640157143.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Changes since v1 [1]:
- there is no bug fixed by these changes (Jonathan)
- lets take the time to improve the subtlety (Jonathan)

Dan's recent smatch report [2] highlighted that add_port_attach_ep() is
unreasonably subtle, aka ugly. The recent cleanup conversions did not
improve the situation and instead actively contributed to the poor
readability.

Given that this routine is core to CXL port enumeration it is worth
investing readability improvements. So, first, back out the
scope-based-cleanup helper conversions that were built on an ugly
foundation. Then, refactor add_port_attach_ep() with a new
find_add_dport() helper that clarifies the flow.

This is cxl-next material, not cxl-fixes.

[1]: http://lore.kernel.org/172912104335.1414627.1377616790909088415.stgit@dwillia2-xfh.jf.intel.com
[2]: http://lore.kernel.org/2a19289b-0bcf-42c4-82a9-268a922535f2@stanley.mountain

---

Dan Williams (3):
      cxl/port: Revert usage of scoped_guard()
      cxl/port: Revert __free() conversion of add_port_attach_ep()
      cxl/port: Clarify add_port_attach_ep()


 drivers/cxl/core/port.c   |  121 ++++++++++++++++++++++++++-------------------
 drivers/cxl/core/region.c |   25 ++++-----
 drivers/cxl/cxl.h         |    1 
 drivers/cxl/mem.c         |   22 ++++----
 drivers/cxl/pmem.c        |   16 +++---
 5 files changed, 105 insertions(+), 80 deletions(-)
