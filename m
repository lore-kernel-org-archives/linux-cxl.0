Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796D981E
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jul 2024 12:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720182647; cv=none; b=C37ZUkdKtw11qxN9KSbI8q5ehZKOExFAHuED6ij5g5k2GoGDAz1zlsJcZ68jMb8zNyQxF/6JjCzGyyyBSKubcbc5YE8Zx1DETBncjNoJv84FLrLPsVpNy2u7KTXWO2Z82GuW8tqZcsFTKcsarzza8bGRd9iE1YHhpg7Ke1N8h3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720182647; c=relaxed/simple;
	bh=43QtEulZFjKeY+8mkD0yStlFQ1P9yoFSO/Nt9n72IlQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g84prsH9JUjg7IPtk9PJYzajJ3QT4P30+madyBhkRw3RP3RgrFHlwyN37qO0cplJs39tG975gjojcQligUVlIuSGlVtW8OhBLS0BdaAwA9dCKTFBrXV2AJSE9X01crrcLisstiU7pK6Ueztu4gXK//bNe+gBZSDeZgKvhzIjgCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WFtBY4FlTz6HJcl;
	Fri,  5 Jul 2024 20:29:57 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id C98DB140B38;
	Fri,  5 Jul 2024 20:30:41 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 5 Jul 2024 13:30:39 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <linux-cxl@vger.kernel.org>, <mst@redhat.com>, <qemu-devel@nongnu.org>
CC: <shiju.jose@huawei.com>, Gregory Price <gregory.price@memverge.com>,
	<linuxarm@huawei.com>
Subject: [PATCH qemu v6 0/4] hw/cxl/cxl-mailbox-utils: Add feature commands, device patrol scrub control and DDR5 ECS control feature
Date: Fri, 5 Jul 2024 13:30:34 +0100
Message-ID: <20240705123039.963781-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

I believe this is ready to merge (I was holding it until DCD was
in place and that is upstream now)

Changes since v5:
- Include Gregory's patch to bring forward the renames.  Not strictly
  needed here, but a sensible change and it makes reordring my
  CXL staging tree a lot simpler.

Based-on: [PATCH qemu 0/4] hw/cxl: Add support for scan media
Message-id: 20240705120643.959422-1-Jonathan.Cameron@huawei.com

Add support for the feature commands, device patrol scrub control and
DDR5 ECS control features.

CXL spec 3.1 section 8.2.9.6 describes optional device specific features.
CXL spec 3.1 section 8.2.9.9.11.1 describes the device patrol scrub control
feature.
CXL spec 3.1 section 8.2.9.9.11.2 describes the DDR5 Error Check Scrub (ECS)
control feature.

This series is one of the test vehicles for the support of RAS feature
control in Linux and having it upstream would be useful to support that work.
There are also a lot more 'features' using the feature infrastructure
that are dependent on the first 2 patches.

Gregory Price (1):
  cxl/mailbox: move mailbox effect definitions to a header

Shiju Jose (3):
  hw/cxl/cxl-mailbox-utils: Add support for feature commands (8.2.9.6)
  hw/cxl/cxl-mailbox-utils: Add device patrol scrub control feature
  hw/cxl/cxl-mailbox-utils: Add device DDR5 ECS control feature

 include/hw/cxl/cxl_device.h  |  58 +++++
 include/hw/cxl/cxl_mailbox.h |  18 ++
 hw/cxl/cxl-mailbox-utils.c   | 432 +++++++++++++++++++++++++++++++++--
 hw/mem/cxl_type3.c           |  23 ++
 4 files changed, 512 insertions(+), 19 deletions(-)
 create mode 100644 include/hw/cxl/cxl_mailbox.h

-- 
2.43.0

