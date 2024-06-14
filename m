Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861B4191482
	for <linux-cxl@vger.kernel.org>; Fri, 14 Jun 2024 08:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718354900; cv=none; b=C6gvqnv+bSOPWTVAUof9P+YVFw8rk3UupRwOkIUZ1poGSqm+pW0I7xRQYv1v/4xtHpTiicNdGFFsx0jfevxHttkHt3/jVZJX8pGHNb3bwDL8z2GNf7mnrqpCLB0bHKyCB/xQsrdZMSKN7yFhgZTFCu5ak1jeoTuL3OcBLikYwjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718354900; c=relaxed/simple;
	bh=KTcBEdz44Xvoi8EKOGaKB2BZlNz3s5gHY07tMoNasQk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HdlV+GyU/ejpLIDjBXxtQ6BTGLRrHmLh+KkwgB87tJpDtouAQvvv7R9BkVj4iyihE2iNUEpV4LPkOi9Y4Hxe5aM8aMVovw+qIDK3ZCUThFOqCiTxIDGkxtvC/6j1lY995DNTQiQf3dHp4YcYnSbrdUCqCZlVerBDAllwiFPp5j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=BYF0nZPB; arc=none smtp.client-ip=207.54.90.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="BYF0nZPB"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1718354899; x=1749890899;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KTcBEdz44Xvoi8EKOGaKB2BZlNz3s5gHY07tMoNasQk=;
  b=BYF0nZPBRgevPF7NifxA/HtcSbX3Mcr+jk6a1uOUx9gOfPsusOicWKmx
   fAU2wLE46Q15YwYPK2fRXj8BvgvgAj4hm56J35F8WTmQgiEGtAIRhwmC/
   LrPgmu50LL6UWPgQerWra+3ousZvPUzhHDEmzddzi8E5AjP//HK/KPUcG
   1Y3mV/bMvv8YWfj+6VLkzUYMxdt+1zJDf+tsQ7pHn30MMLjTf2p1fijZn
   /FHSQym4Eo/oZL0WL4qhx9vr5KyCT8DqOjE1/C4xKsym2ElloWaLF6QQ9
   n6oi4CiGqIogZo+MilLwM8z0XilAM+9txHvh05z9XQ2dvbtR8FqXUxRaD
   w==;
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="142650028"
X-IronPort-AV: E=Sophos;i="6.08,237,1712588400"; 
   d="scan'208";a="142650028"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 17:48:11 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
	by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 78295C13F6
	for <linux-cxl@vger.kernel.org>; Fri, 14 Jun 2024 17:48:08 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id BCD9AD7723
	for <linux-cxl@vger.kernel.org>; Fri, 14 Jun 2024 17:48:02 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 473B12007CAB0
	for <linux-cxl@vger.kernel.org>; Fri, 14 Jun 2024 17:47:57 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.225.88])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 4533C1A000B;
	Fri, 14 Jun 2024 16:47:56 +0800 (CST)
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
Subject: [PATCH v9 0/2] check interleave capability
Date: Fri, 14 Jun 2024 04:47:53 -0400
Message-Id: <20240614084755.59503-1-yaoxt.fnst@fujitsu.com>
X-Mailer: git-send-email 2.37.3
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28452.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28452.006
X-TMASE-Result: 10--6.615100-10.000000
X-TMASE-MatchedRID: DLvyKzG1xC0c0dnT9XswpR1kSRHxj+Z5g8vk+C7vzx6a9Zo7TJaDsIr/
	BixjtpkT10Vp4KHcMAFiJsbEDHUAbTMH3wWOx57nUr3GVI65GhZr2qJoNIuCjTWTjVM/cNIvwCj
	pv4QGQuAXjQchKpIrqiUxwU27jiwbWcYSOWxqzbIwYApm54/SZk0s9CXRACW0HIWJ47daB08RUe
	D6U7HYe4V1qjMlHelRl9M++dGVdJcvCpzVHOWLFz9B1SHosSXQsat+wgYyTWz8cY+l4ZUj1gGfJ
	v4nSRr+oa8IWqgpLBOAMuqetGVetnyef22ep6XYOwBXM346/+woIuItuiaG6x+lJgAmnT2HiIxB
	15RX/vnHurUspR24rDIKludAcwdh
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Currently, the cxl driver does not check the interleave capability of
devices (such as host bridges, switches, cxl_mem, etc.) when creating
a region.

When the driver adds a device to the region and sets its decoder, if the
device does not support the specified interleave ways or interleave
granularity, the device may ignore unsupported bits, causing the
configured decoder to be inconsistent with expectations.

During memory access, the decoder may decode the HPA into an incorrect DPA,
ultimately leading to memory access failure.

Checking the interleave capability of a device early in the process of
adding it to a region can quickly prevent this issue from occurring.

Changes:
V8[8] -> V9:
-- merge cxl_test modification into patch1.
-- append other missing files to kernel-doc and fix the complie warning.
-- optimize the interleave capability check logical.

V7[7] -> V8:
-- drop the redundant check in check_interleave_cap().
-- add cxlmem.h to kernel-doc. (newly add)
-- fixup cxl_test. (newly add)

V6[6] -> V7:
-- update comment.

V5[5] -> V6:
-- fix some typo.
-- update comment.
-- set rc when check failed in cxl_port_attach_region().

V4[4] -> V5:
-- update comment.
-- add nr_targets check while attaching a port to switch.
-- delete passthrough flag and allow all the capabilities for passthrough
   decoders.

V3[3] -> V4:
-- update comment.
-- optimize the code.
-- add a passthrough flag to mark the passthrough decoder.

V2[2] -> V3:
-- revert ig_cap_mask to interleave_mask.
-- fix the interleave bits check logical.

V1[1] -> V2:
-- rename interleave_mask to ig_cap_mask.
-- add a check for interleave granularity.
-- update commit.
-- move hdm caps init to parse_hdm_decoder_caps().

[1]
https://lore.kernel.org/linux-cxl/20240401075635.9333-1-yaoxt.fnst@fujitsu.com

[2]
https://lore.kernel.org/linux-cxl/20240403021747.17260-1-yaoxt.fnst@fujitsu.com

[3]
https://lore.kernel.org/linux-cxl/20240409022621.29115-1-yaoxt.fnst@fujitsu.com

[4]
https://lore.kernel.org/linux-cxl/20240422091350.4701-1-yaoxt.fnst@fujitsu.com

[5]
https://lore.kernel.org/linux-cxl/20240524092740.4260-1-yaoxt.fnst@fujitsu.com

[6]
https://lore.kernel.org/linux-cxl/20240611021511.35315-1-yaoxt.fnst@fujitsu.com

[7]
https://lore.kernel.org/linux-cxl/20240612032544.39149-1-yaoxt.fnst@fujitsu.com

[8]
https://lore.kernel.org/linux-cxl/20240614032133.45365-1-yaoxt.fnst@fujitsu.com

Yao Xingtao (2):
  cxl/region: check interleave capability
  cxl: documentation: add missing files to cxl driver-api

 .../driver-api/cxl/memory-devices.rst         | 15 ++++
 drivers/cxl/core/hdm.c                        | 13 +++
 drivers/cxl/core/region.c                     | 82 +++++++++++++++++++
 drivers/cxl/cxl.h                             |  2 +
 drivers/cxl/cxlmem.h                          | 21 +++--
 tools/testing/cxl/test/cxl.c                  |  4 +
 6 files changed, 132 insertions(+), 5 deletions(-)

-- 
2.37.3

