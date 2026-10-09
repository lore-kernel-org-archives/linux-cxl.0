Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1642539934C
	for <linux-cxl@vger.kernel.org>; Fri,  9 Oct 2026 22:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791583936; cv=none; b=BhpkkR4ZarNPhfYag14DkX2AQOG88uesgmozWQf1R1/GUn1C1HdQaPwZkwL3wRRnzhtXhIJc001HNoqaNGct/nLUSoHrTb2uw3actgT7DogKwiqCxvcGQQcnPzTkp02CbFkx2HSPoxr4s2gWtlJpOPq3KU8yZDeeThn3WQ5m4Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791583936; c=relaxed/simple;
	bh=rrpIyVG1FLe46lEKpNlX3s/yn2lrlLN82D5sgHaMZJs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ogrfsSOkvD8ihEZXNapWvqo6sU4SonPIDyyk6+NKFZRvnn7qLJ2q2FjVNBzcbEweMey2yAr/9OBTVjoLTz2Gz9C/9GuOzIEEss8KyHc2bG9Ngj7B8g1giWm3hBV7NNW7DGQvTkn235VPR6u/TUaR/ivMeC9iAnmpJjSIxiRF/wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PtrV48G2; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PtrV48G2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791583933; x=1823119933;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rrpIyVG1FLe46lEKpNlX3s/yn2lrlLN82D5sgHaMZJs=;
  b=PtrV48G2HL9B7gPsyMF/bY4OZOWuQjC/Qk7nBdROThCaApFU+YNO1njk
   peLjOm/ccugngvACKB/wG7lNis19PSGVWiQWifWxcCHNKCJeJXyYSpGJL
   SYEnlZ5H0CpR+2qQK+8R61OCilOO+tA7K3RvtHGd31Js1+jRYDfaVWYWo
   Jl4ZzPZQtPboDVRzkrC7pNYXY/HwKU/zFMMYcyW6Wf6BUsX8BW3QTjoV6
   rG0y8nU5M534CFSC1j8Zbgn+5v/+tQ24Iq8rimD9NAQPINoHjx53/WGve
   ip0Orfw/b6S3sJrtRnr0J3olHhjgH9czH3unvfd9RJ4H9x8Q3+v3PSIkh
   w==;
X-CSE-ConnectionGUID: vvW+Dn89REqh4to599quzg==
X-CSE-MsgGUID: 03SpetztSdqQNKKiDNN69A==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="294819"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="294819"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 15:11:31 -0700
X-CSE-ConnectionGUID: dkTfGXNTR9upm/VkhBlvNw==
X-CSE-MsgGUID: Y+u42TdiRHOWPtbD4x21TA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="505701"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.221.202])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 15:11:31 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Richard Cheng <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v2 0/3] cxl/test: mockfixups and new topology support
Date: Fri,  9 Oct 2026 15:11:20 -0700
Message-ID: <cover.1791582353.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v2:
Patch 2: Avoid duplicate look up of auto region window (RichardC)
CoverLetter: Add link to the ndctl companion series

While working to enhance the cxl-cli cxl-create-region command to handle
out-of-order target lists or no user-supplied target list, I ran into some
basic issues in the existing command that need to be addressed first.
Developing tests for those fixes exposed two bugs and a topology gap in
the cxl_test mock module.

This cxl_test series addresses those issues:

1/3 fixes a DPA skip leak across mock decoder reset.
2/3 skips auto-region setup when no volatile window is active.
3/3 adds two x1 CFMWS windows needed to exercise root decoder selection.

A companion ndctl series[1] fixes the existing cxl-create-region issues
in cxl-cli, clearing the way for out-of-order or automatically generated
target lists.

These changes preserve the existing cxl_test unit test behavior while
enabling new create-region test cases.

[1] https://lore.kernel.org/nvdimm/cover.1790658549.git.alison.schofield@intel.com/


Alison Schofield (3):
  tools/testing/cxl: Preserve DPA skip across mock decoder reset
  tools/testing/cxl: Skip the auto region when no volatile window is
    active
  tools/testing/cxl: Add CFMWS windows for region selection tests

 tools/testing/cxl/test/cxl.c | 116 ++++++++++++++++++++++++++---------
 1 file changed, 87 insertions(+), 29 deletions(-)


base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.37.3

