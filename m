Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C3612C46F;
	Mon, 29 Jul 2024 08:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722242791; cv=none; b=Ev94O3kERTOX9fqBpvWGNFRKl3hGemjyNU5G7tUFQEA7B6YcAjHqpZoupC+eCJk8dPCMwshXKb+8OnI8mE9ST0P4exH5dZ+wn6KOYrAEXGfU0AN6iAMlRNLSrziy94srB/UhjMHFsrBi8/ycYz4qMlwLAonhOMkZYH7tX7gVht0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722242791; c=relaxed/simple;
	bh=a6B+dCRi2PAONa4H8S+XgrCIRQhl0Ec9gLy7s9X1va4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LKpn727phvB1qdRItyF1hnqhC3OHIcxXoEIofmyFNQZmgQTrndxiW2fXvy85L7/A86BJ8LtNtBr8AZovIcWBfgy6JENxS4HhxBjv0vbhqvEYPmjCF9tdg/dRRqSrHLhpZKdSKExGAkML2uf3fV+D8ROin/Wr3h3C5J9uMyw442A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BJgdD0jV; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BJgdD0jV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722242789; x=1753778789;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=a6B+dCRi2PAONa4H8S+XgrCIRQhl0Ec9gLy7s9X1va4=;
  b=BJgdD0jV4Lk3+1oJA2x5qaXzgKCpZT1nHr20lybJKUoEED+iOjI12VDJ
   WxInrrqBrvc9FPqCwHSe6uwLUL3ju2UNOGWcODRL7DC3ajxDVMpsvV6QN
   Ty5CE0LN6GRxPRhXjk3Vj9KEgeAIUzwlFGT42OX5dQ6pWBlCtQKO/2VWt
   hx7k53TDycy7AWde+3MxTjFSbmb+G/Wg4GHUPtne8f7+ohU31dlOSy3Fj
   mCi0frJQ6LPsggYVrHCb1sZ5kBw3b4fNLfXuTGofmf10h6KJ69E7zhfBn
   2KHyzpTxKwYBHJK8jCop2/niwdgndzZrupzAyAku3sZonVz+ei2GMW1md
   A==;
X-CSE-ConnectionGUID: zirG0IIxSomVC03MNnO89g==
X-CSE-MsgGUID: wPujGb7JTHSOmNI3djJQqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11147"; a="30647111"
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="30647111"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 01:46:29 -0700
X-CSE-ConnectionGUID: Bn5LF74zRXqxiQOz+KA1wg==
X-CSE-MsgGUID: ZR6lCvJBQo+i8zR52hgixQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="84856207"
Received: from yhuang6-mobl2.sh.intel.com ([10.238.6.133])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 01:46:26 -0700
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
	Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH 0/3] cxl: Preparation of type2 accelerators support
Date: Mon, 29 Jul 2024 16:46:08 +0800
Message-Id: <20240729084611.502889-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There have been 2 series to add type 2 accelerators support in [1] and [2].

[1] https://lore.kernel.org/linux-cxl/168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com/
[2] https://lore.kernel.org/linux-cxl/20240516081202.27023-1-alucerop@amd.com/

Both provide relative complete support, but both are long too.  To
make it easier to review, some preparation of type2 accelerators
support is implemented in this series.  More complete support can be
implemented based on it.

This series has been tested with cxl_test via mocking a type2
accelerator as in [1] above.  Because more type2 accelerators support
than that provided by this series is needed to simulate the device,
the cxl_test patch isn't included in the series.

Huang Ying (3):
  cxl: Set target type of root decoder based on CFMWS restrictions
  cxl: Set target type of region with that of root decoder
  cxl: Avoid to create dax regions for type2 accelerators

 drivers/cxl/acpi.c        |  5 ++++-
 drivers/cxl/core/region.c | 11 ++++++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

Best Regards,
Huang, Ying
