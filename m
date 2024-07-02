Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BCB1BA09D
	for <linux-cxl@vger.kernel.org>; Tue,  2 Jul 2024 14:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719930872; cv=none; b=j8ttzeb5V6RtFoArTM/M6wb3oWP6BMAKWKmGCzUNClt0TxepZ+YqPw1IxIbS3FeKvniX0BAlKZKgaVfBbsZpOQlMEhsggyO0bmREj/XOUKCQLIZpz6DkoDsLNwEl9yCFKFWb3Bnk8hv0mJA0ZDnlzyg4bULerLceAw4BYbe5n7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719930872; c=relaxed/simple;
	bh=ZNAn9QwuncAY36vxZzW7gwCR0HOERS27KHCoR/Y8lg4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tNC9zOMMU/ZGuaCs8eWqPjO7gkCQtbpGx5Pwk08CE7gkcE5opySP6jrK7xMdm3ySfgZAyHWsUEPZB55VzyBcI/YyUBSKtiGKVTnx3MvoOPJnA1uFUwOfXBdD6sm8KNy7AI3jaOGmxBTRabZ/NfNBOgUNtFtVIMX20z0APrFAUSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WD54P2jTPz6J6pG;
	Tue,  2 Jul 2024 22:33:25 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 22EA6140CB9;
	Tue,  2 Jul 2024 22:34:26 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 15:34:25 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <linux-cxl@vger.kernel.org>, <mst@redhat.com>, Markus Armbruster
	<armbru@redhat.com>, <qemu-devel@nongnu.org>, Li Zhijian
	<lizhijian@fujitsu.com>
CC: <linuxarm@huawei.com>
Subject: [PATCH qemu 0/3] hw/cxl: Misc minor improvements
Date: Tue, 2 Jul 2024 15:34:22 +0100
Message-ID: <20240702143425.717452-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

Before pushing on to more significant features a few unrelated patches
doing tidying up + one to avoid people setting the memory backend both
for a CXL type 3 device and as normal RAM in an attempt to get SRAT to
cover it correctly.  We've had multiple 'bug' reports from this and if
nothing else I'd like to stop getting those!

Based on master + the two DCD series Michael Tsirkin has queued.

Based-on: [PATCH v8 00/14] Enabling DCD emulation support in Qemu
Based-on: https://lore.kernel.org/qemu-devel/20240523174651.1089554-1-nifan.cxl@gmail.com/
Based-on: [PATCH qemu 0/2] hw/cxl: DCD tweaks and improvements.
Based-on: https://lore.kernel.org/qemu-devel/20240625170805.359278-1-Jonathan.Cameron@huawei.com/

Fan Ni (1):
  hw/cxl/cxl-mailbox-utils: remove unneeded mailbox output payload space
    zeroing

Jonathan Cameron (1):
  hw/cxl: Check for multiple mappings of memory backends.

Li Zhijian (1):
  hw/cxl: Get rid of unused cfmw_list

 include/hw/cxl/cxl.h       |  1 -
 hw/cxl/cxl-host.c          |  1 -
 hw/cxl/cxl-mailbox-utils.c |  7 -------
 hw/mem/cxl_type3.c         | 15 +++++++++++++++
 4 files changed, 15 insertions(+), 9 deletions(-)

-- 
2.43.0

