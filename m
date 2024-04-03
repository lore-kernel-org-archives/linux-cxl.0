Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD1C1BDCE
	for <linux-cxl@vger.kernel.org>; Wed,  3 Apr 2024 02:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712110741; cv=none; b=OSdYWkuVsWlUAo+WkwQjE81CK294uP5RxBGGV6X8xwxEEeBaFX3iH0hJXWRk+lGxVoOpTK5mJQ5w1EtdjzosyqI024EfTIWSr4s9tH7qYi26s21pI9g6pogYm5GT2IDABmeIKpTusoQTgkzz0d5SyXaItHGMcUDZpnJsTJblNEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712110741; c=relaxed/simple;
	bh=4JJqb+8Ikmh1nigsAZWFnXewCUcfK0EzjY5Vs/pEJQY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VDqatIu0/eh+px0gjyb7xb6V7E5zahrUO8z+vDOCt7ushWThdJn7GnR7OLgy882S2Uh+fI0hBYm0hVrYt25tTZ/5I00kmcXBBzsHSqx1UoPd8W2Fdue7pWuJgtAsA1Y6dzTCEREgl1EAwjIKpvTSVcPow6B2EoTW4j8my1NgnLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=FM/Lm6Gv; arc=none smtp.client-ip=207.54.90.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="FM/Lm6Gv"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1712110737; x=1743646737;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4JJqb+8Ikmh1nigsAZWFnXewCUcfK0EzjY5Vs/pEJQY=;
  b=FM/Lm6GvHDlsh1fXJIdpiWBqz4Eh684cXtdq8rPcG4nMuJNCsAsuLdvs
   J6dDNrXosFwBMAqD1Qp9vtoiA7k5GcUSEsyn0A1aS1fqEE0CEAuAn5foz
   eDbRQPRGXBQdBFFULwQqgkVmnGP1V0Adkc/R267RY4GetaIiOQ8xYPd+A
   QTatTvBf9P0fAKUKlUCnGjavruS8/4h3NQv3ULu5sQm9ZeU5oLmaX5z/y
   818SpN1t/ZwfG7AkzaKUcp623tH5AfddgzWR5qpzfEoAPJAhchDhKsYl6
   lN4zQyXtoUDK9/DYme7iXJSMYc4FGK7vi7TFf95VLPX7h05WWeWLI7Tet
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="133804158"
X-IronPort-AV: E=Sophos;i="6.07,176,1708354800"; 
   d="scan'208";a="133804158"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 11:18:49 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
	by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 0170BE9648
	for <linux-cxl@vger.kernel.org>; Wed,  3 Apr 2024 11:18:48 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 26C6DD5A18
	for <linux-cxl@vger.kernel.org>; Wed,  3 Apr 2024 11:18:47 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id A6A082030C7D7
	for <linux-cxl@vger.kernel.org>; Wed,  3 Apr 2024 11:18:46 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.225.88])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id AED321A0002;
	Wed,  3 Apr 2024 10:18:45 +0800 (CST)
From: Yao Xingtao <yaoxt.fnst@fujitsu.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	jim.harris@samsung.com
Cc: linux-cxl@vger.kernel.org,
	Yao Xingtao <yaoxt.fnst@fujitsu.com>
Subject: [PATCH v2 0/2] cxl: add interleave capability check
Date: Tue,  2 Apr 2024 22:17:45 -0400
Message-Id: <20240403021747.17260-1-yaoxt.fnst@fujitsu.com>
X-Mailer: git-send-email 2.37.3
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28294.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28294.004
X-TMASE-Result: 10--3.304200-10.000000
X-TMASE-MatchedRID: RtHHqK+8YWOiRKum/M+GqaoXHZz/dXlxBGvINcfHqheiC7BD4niBmFN2
	Sv4BrfuifwWnQgO080LsIGXDDl4WhkvjnvMoJy6PmOexU8E0y9GYr/uwHXF3UiXgPASDnPcffr0
	mqpu8k1/i8zVgXoAltsYlDcGKIsCCC24oEZ6SpSmcfuxsiY4QFH6G2XgTG5LqaBa6TjNDTIiSpp
	j7/ABe21HD1gpfLecxpXOfrZQBGTEe1YaDpydzJYnGswXh6WSytMj5Ebu+am2WDhrT2y96q5sNE
	GpLafrrLM/nEDLP056e+TDiyH/49wxfkLAfkNNSaAZk0sEcY14=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Changes:
v1 -> v2:
1. rename interleave_mask to ig_cap_mask
2. add a check for interleave granularity
3. update commit message of PATCH 2

Currently driver does not check the interleave capability of target, it can
attach target to region even if target does not support the interleave
granularity or interleave ways. Thus, applications access the memory
will occur unexpected behavior, such as segmentation fault.

Therefore, it is necessary to check the interleave capability of target
before attaching it to region. If the check fails, the attachment
operation should be stopped.

Yao Xingtao (2):
  cxl/core/hdm: rename interleave_mask to ig_cap_mask
  cxl/core/region: check interleave capability

 drivers/cxl/core/hdm.c    |  8 ++++++--
 drivers/cxl/core/region.c | 37 +++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h         |  2 ++
 drivers/cxl/cxlmem.h      |  3 ++-
 4 files changed, 47 insertions(+), 3 deletions(-)

-- 
2.37.3

