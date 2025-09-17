Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14A62D7393
	for <linux-cxl@vger.kernel.org>; Wed, 17 Sep 2025 14:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758118447; cv=none; b=l/nIPyzfUB/WgZXJL27VJIsriqFoMSaHxDby0f8o9RgNzmmUp7KHBUNGv2oKnosnL32EZDyFwEUNiOazm+/fHwwYOgISlYgdiszbrG0+/0/DZf5Mx3Rvr1aGr0PR/kENcu017rOK5DEjnGPOcw+2800JJg2HwBVC7/pimqipt6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758118447; c=relaxed/simple;
	bh=LHrupPFVW9s8d5n4b2BXIzWYfkAD7wQ582fJ7yvyHeY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eF1bUnRomVAdDsV88J5CbL86BXaXF+/Sv7h+Bv10isDuMHHBxNVXMaqmb0F56BOmfF4Yec8139EvjshiHm9w2uVemIcKt1frkVp25heR8cXJCCGROZfwSZE3c6n+nva75pSpQyeNWzMom/W1fsvI7BPxtaLrfEmUxIJ0eKbkmiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cRgh80vw7z6GDLx;
	Wed, 17 Sep 2025 22:12:24 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 3295B140371;
	Wed, 17 Sep 2025 22:13:57 +0800 (CST)
Received: from SecurePC-101-06.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 17 Sep 2025 16:13:56 +0200
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Michael Tsirkin <mst@redhat.com>, <qemu-devel@nongnu.org>,
	<shiju.jose@huawei.com>
CC: <armbru@redhat.com>, Fan Ni <fan.ni@samsung.com>,
	<linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>, Ravi Shankar
	<venkataravis@micron.com>
Subject: [PATCH qemu for 10.2 0/5] cxl: r3.2 specification events updates.
Date: Wed, 17 Sep 2025 15:13:50 +0100
Message-ID: <20250917141355.293217-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 frapeml500008.china.huawei.com (7.182.85.71)

Hi Michael,

This is the 1st CXL set that I think is ready for upstream.
They are lightly tweaked and rebased from the first part of:
https://lore.kernel.org/qemu-devel/20250811085530.2263-1-shiju.jose@huawei.com/
[PATCH v6 0/8] hw/cxl: Update CXL events to rev3.2 and add maintenance support for memory repair features

I've split that series up as the two parts were only slightly connected.

The initial rework was a request from Markus from an earlier version.

Shiju Jose (5):
  qapi: cxl: Refactor CXL event injection for common commands arguments
  hw/cxl/events: Update for rev3.2 common event record format
  hw/cxl/events: Updates for rev3.2 general media event record
  hw/cxl/events: Updates for rev3.2 DRAM event record
  hw/cxl/events: Updates for rev3.2 memory module event record

 qapi/cxl.json               | 151 +++++++++++++++++++++++++--------
 include/hw/cxl/cxl_device.h |   7 +-
 include/hw/cxl/cxl_events.h |  38 +++++++--
 hw/cxl/cxl-events.c         |   3 +-
 hw/cxl/cxl-mailbox-utils.c  |   3 +-
 hw/mem/cxl_type3.c          | 163 ++++++++++++++++++++++++++++++++++--
 hw/mem/cxl_type3_stubs.c    |  41 ++++++++-
 7 files changed, 347 insertions(+), 59 deletions(-)

-- 
2.48.1

