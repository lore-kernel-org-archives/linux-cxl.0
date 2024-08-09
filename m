Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A911BA41
	for <linux-cxl@vger.kernel.org>; Fri,  9 Aug 2024 09:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723196576; cv=none; b=p9+5hjnJSeQ88Dh9LoUBoVH4K06Rg4HNXhLZZH0u2FTQoqW2ttP7KS1SN+pxdpn9wRMBUWv82SoVoXuFk5iXvotqdFM+ZDTLO+9CDd1pwEA+eIgjd5g9zxMN7ofberpEhk16hihbgIhMRWjMmG1d4lte7DWGXhv+YX5WbWvTKsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723196576; c=relaxed/simple;
	bh=XIT10lBBZMoOp8YK2o8IJreaD717nthMLeQ+8tkbZI8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OKlUdwQRBL1mNy3LnBktjtWislTrnnqFyFgtkmI3wmhhMm6aE1hwTe8l2UFYCUsn/jqlCHwxHMh4QU9tglbc6AFEqXpCB1j2QRnt0SH4A+1bLvAB+BbWteTRrbdM5CiyvchA6Wf5+91BqhBpfE5CoOSXPaoUmlh8FWIpb/zNYIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gqSzu2bt; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gqSzu2bt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723196574; x=1754732574;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XIT10lBBZMoOp8YK2o8IJreaD717nthMLeQ+8tkbZI8=;
  b=gqSzu2bt3IIbvQ1FA3OQDp5/USGdb3bO8EYg40J3GqvAdKrxiKD/SvJH
   u5kNHstQHdSmlAHwynX9a4jligJ+oVdrrYuPPvP2aITZOlqs5/Il+3JBB
   zxv7fvQtyDUqTBmoymZ181KrGWbNYC2MfGVoMWm2abYdpTOnpXEjKIVXK
   xXuEqyW/WBVCtRsNlWWNR7KfVhvbIEG635A9/HC9BxKtkZ3qwUXE+qDNu
   c0VgxealY6XwOyizYwPCd2qOHvGizQLgMtjIS50qkW+cUAtZ7pu7yUnyO
   i4/gKMEkyXduJKdkzhWZCNsVDNFON+StLc+ok8jIvJt2BIWuTV+AIt8TE
   A==;
X-CSE-ConnectionGUID: pP7nO3X5STeBsTo6EdxGbA==
X-CSE-MsgGUID: Y3l6qIyXREqXRinicdQrbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="38869624"
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="38869624"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 02:42:53 -0700
X-CSE-ConnectionGUID: ZMwCDAg8RfSNp8nrgRJ4wA==
X-CSE-MsgGUID: GOhyN+GVT8KdAWDDzPqDLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="62352823"
Received: from tower.bj.intel.com ([10.238.157.70])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 02:42:50 -0700
From: Yanfei Xu <yanfei.xu@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	ming4.li@intel.com,
	yanfei.xu@intel.com
Subject: [v2 0/4] Fixes for hdm docoder initialization from DVSEC ranges
Date: Fri,  9 Aug 2024 17:34:38 +0800
Message-Id: <20240809093442.646545-1-yanfei.xu@intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first three patches are functional fixes, the fourth one is for adjustment
of code format.

v1:https://lore.kernel.org/linux-cxl/66b4db4ff3730_c144829418@dwillia2-xfh.jf.intel.com.notmuch/T/#t

v1->v2:
  separate one big patch into four.


Yanfei Xu (4):
  cxl/pci: Fix to record only non-zero ranges
  cxl/pci: Don't set up decoders for disallowed DVSEC ranges
  cxl/pci: Check Mem_info_valid bit for each applicable DVSEC range
  cxl/pci: Simplify the code logic of cxl_hdm_decode_init

 drivers/cxl/core/pci.c        | 114 ++++++++++++----------------------
 drivers/cxl/cxl.h             |   2 +-
 drivers/cxl/port.c            |   2 +-
 tools/testing/cxl/test/mock.c |   4 +-
 4 files changed, 42 insertions(+), 80 deletions(-)

-- 
2.39.2

