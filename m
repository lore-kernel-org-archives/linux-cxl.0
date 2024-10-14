Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B46B15B554
	for <linux-cxl@vger.kernel.org>; Mon, 14 Oct 2024 12:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728908349; cv=none; b=PrT3pqzLYV0DgHPCkaE9zOBpfZV32LbkmPQatCTmxgSDOb7O0xv9J7dm915wfmm9ol2/VAi73nhYTYJGFqxNFoDVrXgfBbdoTvZ8qMw/nweKij4LYmnqHGroIpQgsr5q6c2VZPlolcyxtqJ49uPaGdZ8/l+GQ8oQ+7uZSvk1E7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728908349; c=relaxed/simple;
	bh=+59/JReDIKv8l9R22uxdOZC+iuNHkr0+qd+9FrcSs3w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MW2uRcfvb7C70sfnezcP+oWPwcBjdjUdC3TgF89zORCTs5D3owwFynCBzE/ULtfPJDUTu58m3pMRlpRf8SSDkguxafyJJrmvntFwjYoUpa+l2uWFV3iR3GuCd+ap8brkJRzI4ljchZBfx134n/XaevVY9Psc/3JFovRYGsY3eew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XRx4D3H6gz6LDTn;
	Mon, 14 Oct 2024 20:14:36 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id C1CA6140445;
	Mon, 14 Oct 2024 20:19:03 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Oct 2024 14:19:03 +0200
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <mst@redhat.com>, <qemu-devel@nongnu.org>
CC: Dmitry Frolov <frolov@swemel.ru>, Ajay Joshi <ajay.opensrc@micron.com>,
	Yao Xingtao <yaoxt.fnst@fujitsu.com>, Fan Ni <fan.ni@samsung.com>, Shiju Jose
	<shiju.jose@huawei.com>, <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH 0/7] hw/cxl: Round up of fixes.
Date: Mon, 14 Oct 2024 13:18:55 +0100
Message-ID: <20241014121902.2146424-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)

A mixed bag of fixes that have all been on the list already with the
exception of:
"hw/pci-bridge: Make pxb_dev_realize_common() return if it succeeded"
(so that's the one that needs more eyes).

I've tweaked the others to fix typos and correct Fixes tags (adding
them where missing and fixing formatting), but they are fundamentally
the same that has been reviewed on list.

Ajay Joshi (1):
  hw/cxl: Fix background completion percentage calculation

Dmitry Frolov (1):
  hw/cxl: Fix uint32 overflow cxl-mailbox-utils.c

Fan Ni (1):
  hw/mem/cxl_type3: Fix More flag setting for dynamic capacity event
    records

Jonathan Cameron (2):
  hw/cxl: Fix indent of structure member
  hw/pci-bridge: Make pxb_dev_realize_common() return if it succeeded

Shiju Jose (1):
  hw/cxl/cxl-mailbox-utils: Fix for device DDR5 ECS control feature
    tables

Yao Xingtao (1):
  mem/cxl_type3: Fix overlapping region validation error

 include/hw/cxl/cxl_device.h         | 36 ++++++++++++++++++-----------
 hw/cxl/cxl-mailbox-utils.c          | 31 +++++++++++--------------
 hw/mem/cxl_type3.c                  | 15 +++++-------
 hw/pci-bridge/pci_expander_bridge.c | 13 +++++++----
 4 files changed, 49 insertions(+), 46 deletions(-)

-- 
2.43.0

