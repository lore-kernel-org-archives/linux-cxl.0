Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B0A5101A
	for <linux-cxl@vger.kernel.org>; Mon, 22 Apr 2024 09:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.37.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713777334; cv=none; b=UQq0xP+i1cE8TNs60Y7HhjGT9ppS3aKIruV9HCiEmHEP1qEtKBhl/4HzNKUEkiNPJGDiwCeCbqIrh7EMpdpw/A+DXAehB52E9mAQfh7jmkE/EDDru5FixP85nHJtf4hGCP2KfF5DrIG4sbpKS3ZiTTDTpXnrbuJ8vlVnZFcV+RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713777334; c=relaxed/simple;
	bh=YS1u3SC+IXUxuoEYVWKfAoJT7wgtJulHWZ08XOHXtnM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DIpvCUVgd2rIsxGPqzL1HvqQYVuqy7mi5HNyxNR3m3v57939nGsIRcPVnSuOoMeBMuTbA3+U9ew1dQu8+SpO/uXg+XTkpryPdF7gUlyj2Tn1HVn1cJaayx1j6pNY5Fb0qOkuDYCISBJGf7HgkmOOJ7+Zs11j5BHJDQ3kxtx0E4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=QvAGDVTI; arc=none smtp.client-ip=139.138.37.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="QvAGDVTI"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1713777332; x=1745313332;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YS1u3SC+IXUxuoEYVWKfAoJT7wgtJulHWZ08XOHXtnM=;
  b=QvAGDVTIbDIp/18nnNQG02WMeiWaXUw3fTScqY9AKt57KPwRzGuzs4hh
   mBuz9Cm2Uj5lV7pn+zNQFhyJ+AvQEodrV4F1uOaLWcJvct38fYbdOGxUr
   63BO7MkU6D5qmVvZTwwe/kQw5ZDdWe7whw2GZF3Lr+KJypbBSGc60Mgva
   0zDkt89XvFBsyvYTLsLnVq8SNLFhuSQZNy/j6qGtC5iXtZra8wig41prL
   /xcSut2gh56gRAjfXFsrSpYc+V9aFnwvFqgwNECNRGQ9sFrXURkZQiQAk
   BR5Ny+PzyFlAwEWRqOB9Dnh7wN8Gl4EmdMNRGDG85ppEXsRS9iVNxgH2n
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11051"; a="135592050"
X-IronPort-AV: E=Sophos;i="6.07,220,1708354800"; 
   d="scan'208";a="135592050"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 18:14:18 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
	by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 6786BD6F62
	for <linux-cxl@vger.kernel.org>; Mon, 22 Apr 2024 18:14:16 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id A0EB6D7B66
	for <linux-cxl@vger.kernel.org>; Mon, 22 Apr 2024 18:14:15 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 17F56200932C5
	for <linux-cxl@vger.kernel.org>; Mon, 22 Apr 2024 18:14:15 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.225.88])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 493CB1A000B;
	Mon, 22 Apr 2024 17:14:14 +0800 (CST)
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
Subject: [PATCH v4 0/2] cxl/region: add interleave capability check
Date: Mon, 22 Apr 2024 05:13:48 -0400
Message-Id: <20240422091350.4701-1-yaoxt.fnst@fujitsu.com>
X-Mailer: git-send-email 2.37.3
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28336.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28336.006
X-TMASE-Result: 10--4.981700-10.000000
X-TMASE-MatchedRID: /+von0vPuFEXiUW3XCfCU6oXHZz/dXlxaXmdXF2Ym8fIgofMgahPrV6D
	OJod5Hsn25/Lj7SAUUvsIGXDDl4WhkvjnvMoJy6PmOexU8E0y9GYr/uwHXF3UvbhG6a40eebuua
	+F17fpzj+iCi8jW6gsjFHUk/VAfV/4EtSNBzFpGC5x7uAXGEprX0tCKdnhB58I/9UW5M5dRNp7q
	EhmmPgy46HM5rqDwqtKGJcv/vDbcxL0YVLrobqcmsrpsCIInieH5Frr/VoseB/1Ybau4Fmzvq0I
	FfWWlxQjU7ga/NphnZdUEdzSRrlUkIVaaEvw0a7FcG3+ZRETICP9kUX1Z+buE3LumkbQiNwVCqT
	SPu8tVR7AxIEOt4h2Q==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Changes:
v3 -> v4:
1. modify variable naming. (Jonathan)
2. add a comment with a specification reference for the interleave bits
   mathematical calculation formula. (Jonathan)
3. add some descriptions about the changes in comment. (Fan)
4. add passthrough flag to struct cxl_switch_decoder. (newly added)

Currently driver does not check the interleave capability of target, it
can attach target to region even if target does not support the interleave
capability. Thus, applications access the memory will occur unexpected
behavior, such as segmentation fault.

Therefore, it is necessary to check the interleave capability of target
before attaching it to region. If the check fails, the attachment
operation should be stopped.

Since the host-bridges with single port and switches with single dport
do not contain one instance of the CXL HDM Decoder Capability Structure,
the above check does not apply to them, driver should skip this pattern.
So when implementing the patch 2, the patch 1 is needed.

Yao Xingtao (2):
  cxl/core: add passthrough flag to struct cxl_switch_decoder
  cxl/region: check interleave capability

 drivers/cxl/core/hdm.c    |  6 ++++
 drivers/cxl/core/region.c | 70 +++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h         |  4 +++
 drivers/cxl/cxlmem.h      |  1 +
 4 files changed, 81 insertions(+)

-- 
2.37.3

