Received: from skyblue.cherry.relay.mailchannels.net (skyblue.cherry.relay.mailchannels.net [23.83.223.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F9D7082E
	for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 01:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740015433; cv=pass; b=sMfa5gYGFnNiXgSIXySJy19fAL4RXWES4m+BgHWMCmg8+vOw4yWPcX1oUXrLwdUOiYvwY20iD+k90ptN/pqy8fPVYPL+901pD/ocE/yLVJzAYLEFnn8SzoDE3G/yDVV+Q9q+UwGPtABLp38LIe4HsTVh6GtVrwa6XfdZZoTisac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740015433; c=relaxed/simple;
	bh=BGI77eKeaeFsMMl8cTHw3jIZ+XbtifyRkFPNJxDUNVY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hwK4byg8yIYUQmySut0auaqIvz362tLKwhgVPQD0pmKiZYRvR/B78r8JtqU4fJukspH/1BZ3FrbH8vF3lQe7krwb6kPMzWKLznI+nbbxwbtj0E9z4wvvWLgQuxG7YAbq39UUzgLU6p92qH76Jfr6CgK2ED3vu84XtaCty5l2FHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=WmCgpsDf; arc=pass smtp.client-ip=23.83.223.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="WmCgpsDf"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 7671D21A4D;
	Thu, 20 Feb 2025 01:37:05 +0000 (UTC)
Received: from pdx1-sub0-mail-a300.dreamhost.com (100-97-164-218.trex-nlb.outbound.svc.cluster.local [100.97.164.218])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id E991921674;
	Thu, 20 Feb 2025 01:37:04 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1740015425; a=rsa-sha256;
	cv=none;
	b=QHkE58AXrZb/GeZi5M1rbupkJecZXkSMlXYXlDSQLwNWDEiYELmctoEKjmmLaS1D+cJNWe
	s0AArpOZQz7TbAsABg2XgxkhkV1BfZtMD0mmYwArRlUqLYadlbqo3C/EirI7k6b2tRBXUw
	umFsKHcOZrsSTr6iEl0mSbAx76Y9usco0aXG1zozBW7FDie1d1toSRjAsN/QkqSXItNLg9
	ORw0m12c2hurBwsnibNJVmjfPw/e37pIvnMs0rteYHvm5yqPOuePgVem1zYmuXDeHXm1PN
	rS7XABR6FDDMvNMNyctNbi9E/27d5eF+vgbvMtkbbn1sRy7b0XnRKSnO97TLxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1740015425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=yua+vOvKX+n/KJq7D8gGNEaAcecckegDE8L9Zb8pFKo=;
	b=eMbVNE+qPXBfkh2ZlJ5owx0QsI3YwSTSwEPNJOmTykVXfCX245yTGLE1t76skISsO3JQjC
	6+sj8McllG0xcDWwMiHpsVg1d/fWmEoiZxrXcFT8tqHF0RB3tHm8MvvYkgnRNLFA0vBLfU
	p2kbylZFqfT7BX3gkq+Ke6pII7pXxPo2IGrTsERF4D6Le5LkOnanCBPaUgTwZxY1fuTa9K
	nhZanLgygpAITDNnPHoUEVRXY6QBCzb77oFItEDURzo4/WZ7mvgFtiovQZ7YrRoUtUGLcJ
	8Y+Xnl8Nb6243nAde0IjQcmn6GCpNvnxqRYFdeX931pJo0uVQ0uExTDT83IfEg==
ARC-Authentication-Results: i=1;
	rspamd-6d7cc6b78d-bd6dx;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Invention-Industry: 107ed3d7727f10b6_1740015425268_1646942895
X-MC-Loop-Signature: 1740015425268:277209885
X-MC-Ingress-Time: 1740015425268
Received: from pdx1-sub0-mail-a300.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.97.164.218 (trex/7.0.2);
	Thu, 20 Feb 2025 01:37:05 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a300.dreamhost.com (Postfix) with ESMTPSA id 4Yywq40mz1zY0;
	Wed, 19 Feb 2025 17:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1740015424;
	bh=yua+vOvKX+n/KJq7D8gGNEaAcecckegDE8L9Zb8pFKo=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=WmCgpsDfrj8KrSJAC9dPigN18xGhAMefMr5+0hdN4OsSk+egvjRAdoX8ZFNGzM4Kl
	 y+5m5qcwNBYqBqXO/a+AAV987oUT7d2P3Rfua3WC/dE8tvd0muG+yGfDDiFrj94J9q
	 V4ifOki/6QREiPfsi3AXCqkQrcejnZW4sXrchS+pkQvwDayojntUzsL350v64fvkCE
	 IaBkzYlGkDxgGOf1H3p6Ir1UNnmC5AG0LJSnoLOsLblyVesxnwNeV0VboEP8+5tZmH
	 5Ad1OFLrOxzbmYC8MRz9Rj2wbxvUfmOxN/5TAmHIyDYRgfeM/Ees/cu4c4Zv/dXgcq
	 Sx9XLIUdS/jpg==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com,
	dan.j.williams@intel.com
Cc: jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	seven.yi.lee@gmail.com,
	ming.li@zohomail.com,
	a.manzanares@samsung.com,
	fan.ni@samsung.com,
	anisa.su@samsung.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org
Subject: [PATCH v4 0/4] cxl: Dirty shutdown followups
Date: Wed, 19 Feb 2025 17:36:00 -0800
Message-Id: <20250220013604.263489-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes from v3 (https://lore.kernel.org/linux-cxl/20250219062832.237881-1-dave@stgolabs.net/):
  - pickup reviews
  - simplify patch 1 (DaveJ)
  - change -1 to ULLONG_MAX in patch 3 (Ira)
  - patch 4 replace int for u8 for shutdown state (DaveJ)

Hi,

Some followup patches to the GPF work. First two patches are from feedback
provided by DaveJ. The third patch adds a $platform/dirty_shutdown sysfs
attribute to expose the count to userspace. Fourth patch adds support
emulating the set shutdown state command for the mock device.

Applies against the -next branch of cxl.git.

Thanks!

Davidlohr Bueso (4):
  cxl/pci: Introduce cxl_gpf_get_dvsec()
  cxl/pmem: Rename cxl_dirty_shutdown_state()
  cxl/pmem: Export dirty shutdown count via sysfs
  tools/testing/cxl: Set Shutdown State support

 Documentation/ABI/testing/sysfs-bus-cxl       | 12 +++
 Documentation/driver-api/cxl/maturity-map.rst |  2 +-
 drivers/cxl/core/mbox.c                       | 25 +++++-
 drivers/cxl/core/pci.c                        | 30 ++++---
 drivers/cxl/cxl.h                             |  3 +
 drivers/cxl/cxlmem.h                          | 15 +++-
 drivers/cxl/pmem.c                            | 79 ++++++++++++++++---
 tools/testing/cxl/test/mem.c                  | 23 ++++++
 8 files changed, 166 insertions(+), 23 deletions(-)

-- 
2.39.5

