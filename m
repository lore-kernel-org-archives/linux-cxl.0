Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793851073;
	b=sfPtSezdPICHnjblExq0bOIZX6KYo3dSpjzA88HW8pFSbPeufWn7CQZB68l/SKyDjXpr
	 ziY8ByF/UHkYUN7g+E5GZYU19sDYKm4f3XWsqVhdyjtXiGfiP1cwXwB2uH11l0NBM8Ax0
	 hqLIIghBLIW4AcwX7vaZKpu9hRmM2lhQw3EVdEfIOWtSa6iBF/kBzzbCyutNLLaR8UzyK
	 dGNVHjwdnJt+6oiUrPLEc0oXF+tcGOgv7s2B9q9TtUCJ4EW2vVZWNDOXgkeHEY8a7l9Wr
	 59dhRhTr2HLk2RIXyIVCsEDOnNaYls3wtE/Gbu3snaTOeTyoJgwWnNqdh9VMihsqvBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793851073;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=dsCv6sCFv+pMGTWnm/v2szuTetKt3vGuFBfrjPnAYJY=;
	b=rEzrFqQR1GEAJ4hkkrumqzkhpfoF5UfutFgEt4Gb9dIu1nGO2AtO+ieveOoB3eI57jG2
	 mkbIEIXVu0jvjXJzsbDQxiIFcoyQJkO9J6Y/NlP/XcKQC5LWkIoOkPYCIf9TE35vHNpEG
	 2wcZYt2Cbdut+rrnzYKay8arkBmsA1KvcEXGMKNM6cX6x7Yxr69GCo+zv2A//Nvnk4BvO
	 0+T2CVhsYPxYAG3L53tBqJJ84k1bjNqJRZ4cF1k3BG4Oc99KP2R8wZYtsSes1q6weH+wp
	 UNAO8lPEcXltgcS/qUELNswcVsSoHuWv1gBAYbNt9TCF+ka7kPcQaKCVt1t6CPH5iFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BYirzKNy;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF06E606A326
	for <linux-cxl@vger.kernel.org>; Thu,  5 Nov 2026 03:57:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF06E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BYirzKNy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793851073; x=1825387073;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bjLcG2kHIjuerl2OmbrHYUWWKNWg9wzY69FIrtUuDCM=;
  b=BYirzKNyibWTyrGw1cxwydbVxWwccDhlxJA+7cnZoOQSULDbDAG3iSc+
   FplHQd0aQ7yaFL8wh+miSnFTEZtU72JrdM8SsEAR5QnHziksOpjC2s8nS
   Xmf3+oCaTLW0RHgiglssK4cdvKSfVQ0hv+Shokt1IcyzKRA8Yl51ZolXN
   TKfAG3K/4Xx6L3Mcmy+ayh3/vUkIy1MfUyGYJkRnB9B54zsqBLln1GSGo
   Cc1dBV3y74PVLYEKXrjCvW/as2UGy2w9WyIrcNn7zLJ0RBXOLZsonIP+t
   VJ7j9vhQ2HRgolBR1BJ0LynyI9HPcdkpfpEzlGwmpPj+Lg5eLe8isYr8f
   Q==;
X-CSE-ConnectionGUID: sUiOrtxMSTagDERFlgN5eQ==
X-CSE-MsgGUID: 0qY1BPyGRUuqPLDwfZJZAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2643968"
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="2643968"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 19:57:52 -0800
X-CSE-ConnectionGUID: Tz5j9PkURpyudjG0nhO+5A==
X-CSE-MsgGUID: zkxNh+JeRdKGDEssNIF/sQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="6741081"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.110.56])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 19:57:51 -0800
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
Subject: [PATCH v3 0/3] cxl/test: mock fixups and new topology support
Date: Wed,  4 Nov 2026 19:57:45 -0800
Message-ID: <cover.1793850480.git.alison.schofield@intel.com>
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


Changes in v3:
- Rebase onto 7.4-rc1

Changes in v2:
- Patch 2: Avoid duplicate look up of auto region window (RichardC)
- CoverLetter: Add link to the ndctl companion series

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
  tools/testing/cxl: Skip the auto region when no volatile window is active
  tools/testing/cxl: Add CFMWS windows for region selection tests

 tools/testing/cxl/test/cxl.c | 116 ++++++++++++++++++++++++++---------
 1 file changed, 87 insertions(+), 29 deletions(-)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.37.3

