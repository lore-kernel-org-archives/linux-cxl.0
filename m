Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BF1632
	for <linux-cxl@vger.kernel.org>; Tue, 29 Sep 2026 00:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790643391; cv=none; b=KlfK8Lj9zSY0sK/onYY6UkluYdoVQ7E5D4xGONg3M++NVahXuUEXuwYfnyE30H8NEWeNGGHK2w3PzPT6H4GW9kKeufge2jbTuCXOEKVeIwVPowf+Ylie8Kl+tB2GX4lG49E9BWUEPonhQFupRr6o2hWbqhPRIm0pMt2Tkmb72Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790643391; c=relaxed/simple;
	bh=yOhOW81U/NYe8pXCublZkGc3QSHJ1qBOCWBlTDvRrCs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nCFO/8wGdP31lu5gljIi3UU8YLxZoDTGHOSjykJtMxymSwPDk6xC3SndI1s2ZAfr1TB29hw5gRdu7Ag5Xyw+qn6JNa8CBCMPB1jtF/is0Nv0muCc6HI3kSM5QAiOXTGK6D7UpDZq8tg0Hhdesd6BQ+RtByvDsR07weZMFfiK14A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X6ln8Vun; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X6ln8Vun"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790643389; x=1822179389;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yOhOW81U/NYe8pXCublZkGc3QSHJ1qBOCWBlTDvRrCs=;
  b=X6ln8VunFpaFrKe/zeH18UXDKKSrr+sYRRr5Eqm9ybe+GBPvVptvE6et
   KMYQq9MT/N62d5yh7/aCIYPqIMOspv5lmAcpftTTBBzev7OEwD6KE+qpr
   Eqw6VMc6WH4RlgbkQF8QpyUTj0Gs4T17G4Xi6Wg5YLRTy17I9JdXw+P/4
   8wWgeXOkDLESGABEti9ZBjKRK7E04R/Sn6nIKlIBe1Iy0aHXB1JceLfit
   e8rSNS1HPORuOgWi3lUJCl6BF+A5IvNiXNX/z9ExI+qGcW8crHoTnPGzI
   kJzC9JX3pCT0fsxEPfYwsfZwxwnIURk6iIXk7tuj3aHGKYLnzIaNrEjhc
   Q==;
X-CSE-ConnectionGUID: V2vSbaI2SDiFu4i7dJSD4w==
X-CSE-MsgGUID: me9ExEWhRDeYPtJTbAqDdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="101923922"
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="101923922"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 17:56:26 -0700
X-CSE-ConnectionGUID: ZDFusgdeSC2rshhAqFKiWA==
X-CSE-MsgGUID: 2dv1X35fRy6VgKAh9K7jNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="273012206"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.149])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 17:56:23 -0700
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
Subject: [PATCH 0/3] cxl/test: mock fixups and new topology support
Date: Mon, 28 Sep 2026 17:56:15 -0700
Message-ID: <cover.1790641236.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While working to enhance the cxl-cli cxl-create-region command to handle
out-of-order target lists or no user-supplied target list, I ran into some
basic issues in the existing command that need to be addressed first.
Developing tests for those fixes exposed two bugs and a topology gap in
the cxl_test mock module.

This cxl_test series addresses those issues:

1/3 fixes a DPA skip leak across mock decoder reset.
2/3 skips auto-region setup when no volatile window is active.
3/3 adds two x1 CFMWS windows needed to exercise root decoder selection.

A companion ndctl series will fix the existing cxl-create-region issues
in cxl-cli, clearing the way for out-of-order or automatically generated
target lists.

These changes preserve the existing cxl_test unit test behavior while
enabling new create-region test cases.


Alison Schofield (3):
  tools/testing/cxl: Preserve DPA skip across mock decoder reset
  tools/testing/cxl: Skip the auto region when no volatile window is active
  tools/testing/cxl: Add CFMWS windows for region selection tests

 tools/testing/cxl/test/cxl.c | 100 +++++++++++++++++++++++++++--------
 1 file changed, 77 insertions(+), 23 deletions(-)


base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.37.3

