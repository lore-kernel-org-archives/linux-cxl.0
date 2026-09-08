Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A329C1D54FA
	for <linux-cxl@vger.kernel.org>; Tue,  8 Sep 2026 04:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788841402; cv=none; b=N+bNQPgy8/dajFJLcLDce65uJWzeAV1mP5HerPi7CHChCB0yoDCB97VMmkfP1UI0GQTLNBD/msulR/qj0/edi+sD6IkbXkkc07xF29z9H883sQlwEsN3hyP86jowzdUEEPy13GSxU9eEuj6g3ijznACW3DH62XMN/19+1ciE6Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788841402; c=relaxed/simple;
	bh=HmRmQD9YKX84eLU/ZgkTm9R8wxWqW7AlQcjViEJchMw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DgwIk71wuyMCU9xmI/9FHAakh5Ug4H5Zd0ioNbJMMLwpTXtIUb21I/Bl0hhCqlLMbMV+3p1Av9IQ+Ilc1582rV9a4G1fDs7D0nPblDfnWCKkzRJEMlDA814LiNND5AWe3Fx3B1rlUboHuE/xxhfQYO5UV9ZOw3P1ZEA/6enwFjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JIciBXlY; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JIciBXlY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788841400; x=1820377400;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HmRmQD9YKX84eLU/ZgkTm9R8wxWqW7AlQcjViEJchMw=;
  b=JIciBXlYooir2bgSIVB0gLXRnH5p3Cv34rX6+4HkyecPG/8Ecf6I2ZtG
   wXVeVpqgejN0LQTftQtZL7BhtYLClXYSXCWqKT9m06Ikx5AoalC0L2pIi
   O6JgrDE7ZxMvpYab4FO14WG8/vKzvS8k7g6ac5Yz41uw/bvd+ImMgK6/H
   +PvocnsPnozxv7JtlUrR7Q1WGjwCVPHsdrwwTVdbjulfRY4qPdjVggCZj
   mff1SHaY69TbuZE4ofbRO0raTxZ/NQbS6CRRXnMdElLRqvlpz4/sDyGgf
   08TP7fatt64QULVLbuoRZIOwsGyrpXE66t9BtOUv/ezrDwPYXkcZwLUrB
   Q==;
X-CSE-ConnectionGUID: dRRSllzkSx64aJB2CeCNkw==
X-CSE-MsgGUID: b53wjYfaQfqK9N/61Hxkyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="76794269"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="76794269"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2026 21:23:20 -0700
X-CSE-ConnectionGUID: mbnxLrnsQpuZhA5F3lDsOg==
X-CSE-MsgGUID: R9qyuIZfQ6+jx10zMA4hlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="272808648"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2026 21:23:18 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org,
	mst@redhat.com,
	jic23@kernel.org,
	jonathan.cameron@oss.qualcomm.com
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH] MAINTAINERS: add Junjie Cao as CXL reviewer
Date: Tue,  8 Sep 2026 12:23:10 +0800
Message-ID: <20260908042310.493882-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I have been reviewing, testing and contributing to hw/cxl for the past
few months, and would like to be Cc'd on incoming CXL changes to help
with review.

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7183babd6a..bbabcf8cca 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3328,6 +3328,7 @@ F: docs/devel/migration/CPR.rst
 
 Compute Express Link
 M: Jonathan Cameron <jic23@kernel.org>
+R: Junjie Cao <junjie.cao@intel.com>
 L: linux-cxl@vger.kernel.org
 S: Supported
 F: hw/cxl/
-- 
2.43.0

