Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A63146A96
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jul 2024 11:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720179602; cv=none; b=chobWN//oiBRXrXZLBiijmpTOyhwhuknyH/KZ8LPzZVI7fLoF5Q/aQbtU2ecqucRROYZMDRYfQTVbmRCjkq6VKJYIUBPPIC25Nhgm31UqZViRn00582vH1RyHZT6nbHY6ulYn8dwD57RUj42VwREfV95IADHWQIVv4MGSmcrsIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720179602; c=relaxed/simple;
	bh=YMrvD8S92rr2I3yE8RJmvHAQWWi77ssbXtitAwigmzI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M/ROAEq2ba1PstwNQaRPtmIqvr0hW36fL8UdS9H71iyCYnfL51gvV0NG5EN4m9xVWQHeKTGrM/0la6zKBPu9rVvktN73y602UsqLkFXO3tFhDYv3IJ2xQ4JB/yLzuk5eHOSAXhEHDrdSGbEVyrYdz3ex0wnQlj5kUDufH/pIskM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WFs3W1GFLz6K6bx;
	Fri,  5 Jul 2024 19:38:47 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 285E9140A30;
	Fri,  5 Jul 2024 19:39:57 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 5 Jul 2024 12:39:56 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <mst@redhat.com>, <qemu-devel@nongnu.org>
CC: <linux-cxl@vger.kernel.org>, Markus Armbruster <armbru@redhat.com>, Li
 Zhijian <lizhijian@fujitsu.com>, <linuxarm@huawei.com>, Zhao Liu
	<zhao1.liu@linux.intel.com>, Xingtao Yao <yaoxt.fnst@fujitsu.com>
Subject: [PATCH qemu v2 0/3]  hw/cxl: Misc minor improvements
Date: Fri, 5 Jul 2024 12:39:53 +0100
Message-ID: <20240705113956.941732-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

v2: Switch patch 1 from a patch that removes the cfmws_list element
    of CXLState to a fix that makes use of it to fix a crash.
    Now based on master as precursors merged.

Before pushing on to more significant features a few unrelated patches
doing tidying up + one to avoid people setting the memory backend both
for a CXL type 3 device and as normal RAM in an attempt to get SRAT to
cover it correctly.  We've had multiple 'bug' reports from this and if
nothing else I'd like to stop getting those!

Fan Ni (1):
  hw/cxl/cxl-mailbox-utils: remove unneeded mailbox output payload space
    zeroing

Jonathan Cameron (1):
  hw/cxl: Check for multiple mappings of memory backends.

Zhao Liu (1):
  hw/cxl/cxl-host: Fix segmentation fault when getting cxl-fmw property

 hw/cxl/cxl-host.c          |  3 ++-
 hw/cxl/cxl-mailbox-utils.c |  7 -------
 hw/mem/cxl_type3.c         | 15 +++++++++++++++
 3 files changed, 17 insertions(+), 8 deletions(-)

-- 
2.43.0

