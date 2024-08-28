Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7337115E5AB
	for <linux-cxl@vger.kernel.org>; Wed, 28 Aug 2024 08:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724835011; cv=none; b=Ml5FBBJpp2dIgEB4z97O97fCb94p+zSamb7LQZ8X588C3jNakzcqgs/b7hA4PRMpLx04E8JsDjzir1lRQWRgqAxUq4V7rwYvp2/bDFZTk+03qXvLQJLMk+rsfHq4HfkYZQPG87se39q8/NXd93WclegtfmBswds0LGotT7W0Hpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724835011; c=relaxed/simple;
	bh=GjHNpVGmG7nY/RqASQXyX65SbUak36TiDjvTQSyMpu8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pD9KfOHxPlMd4fioAE93QDgBdujHjOCVmlMr9Kl5y5MERNGjNxy0emMO53wd1GLgXZIxTHMqEzXhw74NEegU2mmGXVbu3Jm6epYw9eYJnmmghlTiAw9GXmmtYZHyuE19x5OZBmdtOMXuIf57GoPlpLe9EIv/X0vWwbeJMizgBe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mdx5AieU; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mdx5AieU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724835009; x=1756371009;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GjHNpVGmG7nY/RqASQXyX65SbUak36TiDjvTQSyMpu8=;
  b=mdx5AieUBHbNXFIx3aLuYBvE15TR+BLmcKxUKsD7FS5yE7qYEMWF1cfP
   M7ph69lAMYUtB6WlfaLSe3ZPhA4QMePuR+qflzRbDt2G6Gstu/gfY6LpI
   sHuvnf/LokvuXc4RsCCcATWxo/9sMxTlWIhY2vLxJK/BHUIcz+itVy1Ul
   aH+KIgEyZqTsynkeTfQWEKhaSt7Kbm0XFj12n6GDO/eXqh3zb6AGP2E/i
   AcnuFPJKlOHPHdtUhmfvSijVFgcXboqNvZDMJb8DOyrbW1r134wSSGN8q
   NNtjl1KcmehsmlPpmfQh3qEPcJEx1TYJWyD3wTVyWcB6HnJqO7SML3rF9
   A==;
X-CSE-ConnectionGUID: b37y+SSATD64MBX0P3pt0w==
X-CSE-MsgGUID: UMzso4zpTiGm39cRkcJvcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="22874605"
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="22874605"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 01:50:09 -0700
X-CSE-ConnectionGUID: EQuORdY+Q+i7rmx3jwFeOw==
X-CSE-MsgGUID: qxoUJ3saQFGoyOV84rwpqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="62998966"
Received: from tower.bj.intel.com ([10.238.157.70])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 01:50:05 -0700
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
Subject: [v4 0/4] cxl: Fixes for hdm decoder initialization from DVSEC ranges
Date: Wed, 28 Aug 2024 16:42:27 +0800
Message-Id: <20240828084231.1378789-1-yanfei.xu@intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first and third patch are intended to fix potential issues regarding to
retrieve and record DVSEC ranges. The second and fourth are cleanup.

v3->v4:
- improved the commit messages for patch2 and patch3 based on Jonathan's
  comments.
- collected "Reviewed-by" from Jonathan
v3:https://lore.kernel.org/all/20240813110532.870869-3-yanfei.xu@intel.com/T/

v2->v3:
- improved the commit message of patch1 to indicate potential impact of
  the change.  (Dan)
- Dropped un-appropriate "Fixes" tag. (Dan)
- Dropped the patch2 which is a code movement in original patchset.
- Separated the original patch3 into cleanup one and logic change one which
  are corresponding to patch2 and patch3 in current patchset. (Dan)
v2:https://lore.kernel.org/linux-cxl/20240809093442.646545-1-yanfei.xu@intel.com/T/#t

Yanfei Xu (4):
  cxl/pci: Fix to record only non-zero ranges
  cxl/pci: Remove duplicated implementation of waiting for
    memory_info_valid
  cxl/pci: Check Mem_info_valid bit for each applicable DVSEC
  cxl/pci: simplify the check of mem_enabled in cxl_hdm_decode_init()

 drivers/cxl/core/pci.c        | 74 +++++++++--------------------------
 drivers/cxl/cxl.h             |  2 +-
 drivers/cxl/port.c            |  2 +-
 tools/testing/cxl/test/mock.c |  4 +-
 4 files changed, 23 insertions(+), 59 deletions(-)

-- 
2.39.2

