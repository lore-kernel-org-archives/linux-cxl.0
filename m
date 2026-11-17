Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794942888;
	b=FGJC5E4QP1TGw/2uwtghP6ZCp+FbravDIbhtF0IoMp+v6Mp1+cVZdQJV7RF2ZXtRK/GA
	 sSXAhdufGJmIQSbBLuTbnYsQmKnmKsZiv30Rmp/aZ+l4DgZRaf6Jk3CMc1T2/CNfSG5tX
	 cO8DNmie6qJ+HtkmzbJdW2gu5shzD2UfaGMuxgxjR/XbPRppdNqFTAMnwIHjntT1dJBS4
	 UydHNQBltfJIVFJ3FXOfEfYFeA+NpQ2N4z5iAOP0+GncL3Ud8g99G0F06kzb2WI8d660+
	 Bl4E5NasV0vq3/uMltN46IKv0heYb4gTT6M3bnkp3r/D5lkG9Isf/KIyvmyFLAaBooA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794942888;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=BkrUaH7VcKopYfDPT66jqLu0vjT9QeNziuPPYR56akA=;
	b=eeQyvcoq3Qf4oQyWvRu1RqrtRb4Gc5C6pgSNdWo6eJkEE2mOgxnnPLxeEhrrySSCt7+D
	 4YjBKWTo5Do5kMT5DmSPNBZruEnOW4dVQBX0N9rG5t+/gaiRhzI7FKN6+oxH6sZ2LgsA8
	 ftAiqw6GRX8KhjcsyPhSwq6n+gVgDshjSj52eSxo+6yNYK8LyfFV/mwGf+Aym6jP6zrqX
	 w5Gu+22nN/UyogGeFIxJpUZrESgJeSPbqu7xgJ/C1o0+vinR96X5Vt71brd6t+mHBMa3f
	 MYMoo3zJd25XMJ2zbDO9DpXsrtM31rXv2sPiF9PwlH6aSJekODUTwXWQuehBKXpcnKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NCX2eg4J;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3A9606A31C
	for <linux-cxl@vger.kernel.org>; Tue, 17 Nov 2026 19:14:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B3A9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NCX2eg4J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794942888; x=1826478888;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fIQHMDnFDF0jYkws6URCJkKHFn3d90t5sQfVMYaOfSM=;
  b=NCX2eg4JOgCPEKb7cXpmv7eaBkwgJ2SW/og17Qvg+Xk5vUPTChoI5aha
   XMM4iOEY45eVqAkgDcn0L1NbCbjoPzp0kpKfgyvdgiOMOOxC691ZkA1mY
   uGBwyfk6yolmbnrxHaGqSVlIaUbUxKEJhZouB/s8+ggQrTReSUxNlcEfg
   7MKSKy+v2J76k3M5/CWcq0X8iU8tpC22RexR8VRb3nr3enjilzUn0dCk0
   x4REPRmB1DqSI/yNr8Nj/F/zfEcCmvpvhK+eRnLDyEWS0CEuguNSQS+dK
   d+J+1M08iqjHX+Xe2UCSHm6tb29jfcRasYRmN/z2bnZkWTOC7+yOEqXCY
   A==;
X-CSE-ConnectionGUID: HJ+0pAUqS+ChZvnvWKxIZA==
X-CSE-MsgGUID: /dN412AHT/yzU6KpQiHC1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3612788"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3612788"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 11:14:46 -0800
X-CSE-ConnectionGUID: 335cT+47Rc6e9twVf/+YSA==
X-CSE-MsgGUID: 2avK9rLLSDqS9Q67f/OKdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9764356"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.108.205])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 11:14:47 -0800
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
Subject: [PATCH v2 0/3] cxl/region: Carry the effective interleave state through target setup
Date: Tue, 17 Nov 2026 11:14:39 -0800
Message-ID: <cover.1794942093.git.alison.schofield@intel.com>
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

Changes in v2:
- Update comment to note a read from register, not firmware (Jonathan)
v1: https://lore.kernel.org/linux-cxl/cover.1794010889.git.alison.schofield@intel.com/


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

