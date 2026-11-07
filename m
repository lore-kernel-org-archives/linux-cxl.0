Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794011709;
	b=FE9wDjuN0Y/B08Y3I/KrVk404GnxuICa40Ufk8HcOZGCwEqRSJjLh1b3ZGlXYniW0k9b
	 Z+D6A+SUDz+zq54v2CTG1CdCkXc4qxnUitEVTXmdWxcxUTp+r+uqFlh+Czuxtm+KYmF5a
	 nrDEfeLRb9FaMD+iXCiOGKPjXyCTJaDC0uInOBZWRs06QJH8+TEro+0wf2TK77toyCUN4
	 JuAg6Mq/dm1znFI88ZJEC6IyMindS2pPbRscMPtaeF5E4rX7ap2cLLWBaMfy8chdLMl8K
	 YqhBn/ihG6Mxq6yRNlmH6Sc0uw+4E86Sw/BlLnugbBTfrNauYODa6jCz1GjqGbFmOGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011709;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=DAn19e2IDa9wibxdKQ6U5QOgXyWTBQrGU00hLIqhkT0=;
	b=4LL7FFfNAGy2B1DkHy9UoCM798x14w5JrKz9EV9f4OAf6HyXkg8IdbfMQFVAni29DYXY
	 J4P1QGwrOUtEpNoL2MvabqeIZIwd1nrpdR88iyBECV3E47CqrJ2e0OqhJRRRzZdQD+l0B
	 uU3+X3woc7ymOdDGs5Y3iZ9zwkHWpe19iHyNwkjDp+BAAUv3phd2F+6wr8i7cO4+YhM1I
	 a6C3wbPlMk9rm8KLKlwqPoXtdKxgPYfSQfbr1SIUW7KRvY7z/DOOnWyUHi33lNGHM8zNx
	 zcmkNZjCIC9740T3nuN293PsTsmMFWmh2G+7VhFHzZJwN/3NkxkNCeDG6iemFKiJb4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GMkpB58R;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77465606A326
	for <linux-cxl@vger.kernel.org>; Sat,  7 Nov 2026 00:35:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77465606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GMkpB58R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794011707; x=1825547707;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Kpkm0Tv2osOQ5wK8OpkK4Hr+4aAORy7yW1esOmFsAn0=;
  b=GMkpB58RzYbz1AxY69ftlSGKY/I1UhdlLgz87lFRqNtcaCvNE00ayQZa
   dFs/w7LY+FKscpRFuLBf6J5XdtTb7+EI5pWkG+7Z+njl8BxFO5kaBoWys
   NSfL5AFd6L2ce+APNHOfeMHgBCKHyFh4jrDgfAyRqPFqmSxo4N9hYURRW
   rTd8AhLOOZu24+HVxIipEWdh9+8G727B4cDpNvHkcmpmc5k0HjgIwNH+0
   YYX0c29AkK7JWtqBwq39P5yrudjDC1n4Fc91AqhgaeSl/RFAKkUdi+dpf
   ggSTNkbFKB9fZHzZiOwZWdCDnTudOY4z2FP2uc+8a7Bjm0i+vLUiIl3ix
   Q==;
X-CSE-ConnectionGUID: +YZIHoITQFG44OImKUzKmg==
X-CSE-MsgGUID: Vmh8EeKWQOOIzDFibSJBBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2710305"
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="2710305"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 16:35:06 -0800
X-CSE-ConnectionGUID: 7FbYSqJXSTWGSBa/N/+SBw==
X-CSE-MsgGUID: tcg4j1xLTBmOiuUTvPr/7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="9176220"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.110.188])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 16:35:06 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Richard Cheng <icheng@nvidia.com>,
	Ben Cheatham <benjamin.cheatham@amd.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH 0/3] cxl/region: Carry the effective interleave state through target setup
Date: Fri,  6 Nov 2026 16:34:59 -0800
Message-ID: <cover.1794010889.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This replaces "cxl: Allow passthrough decoders with >16K granularity"[1]

Review of that series showed the >16K failure was actually a symptom of a
pre-existing problem. The switch decoder setup used the parent decoder
object to carry the interleave state down the hierarchy, and a passthrough
decoder's granularity is a hardware don't-care.

Patch 1 carries the effective interleave ways and granularity in each
port's region reference. The approach was discussed here [2].

Patches 2 and 3 add support for cxl_test coverage.

Based on cxl/for-7.5/cxl-port-refactor

[1] https://lore.kernel.org/linux-cxl/cover.1788487020.git.alison.schofield@intel.com/
[2] https://lore.kernel.org/linux-cxl/aqnWLH-nrXk6BYqM@aschofie-mobl2.lan/


Alison Schofield (3):
  cxl/region: Carry the effective interleave state through target setup
  cxl/test: Add a 2-way 16K root decoder for passthrough testing
  cxl/test: Program a don't-care granularity into the passthrough host
    bridge

 drivers/cxl/core/region.c    | 28 +++++++++++++----
 drivers/cxl/cxl.h            |  5 +++
 tools/testing/cxl/test/cxl.c | 61 +++++++++++++++++++++++++++++++-----
 3 files changed, 81 insertions(+), 13 deletions(-)


base-commit: 0e3e8b653ca3ab145aced729861cf0d1a06da69e
-- 
2.37.3

