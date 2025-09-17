Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7873618FDBD
	for <linux-cxl@vger.kernel.org>; Wed, 17 Sep 2025 14:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758119617; cv=none; b=OMme1FljK84B+7yNKU/Tr7fF+2emHaY/MmGP+K+G7t0Xzojgvb4UsdX4AcUkzirIk4jyq2AasaNd7LS4IhViT1MsbS1ohqaQ7CEA9nhmPoxU1zuwEjPOiHV7lGRWuKS1hI16v5nfx5WunbNTrDEePgb86Yc8tyNyn+Op5AKY/cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758119617; c=relaxed/simple;
	bh=bc4MAAJaKiYY7XQvOtUgO8y8FOqfRLa7JTDE/an0Hww=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Rfi4252m/DsJzs02lMZA2jy+5AlZWQ2DxavObdb5KW4Ku59knKWOe7KwjV7YmseKuhp38MQvYJPY6YYcpDQm4X6m4Nm4cAeoF7x/ZUI9EkgeGHusfpDlNySGGvpvh2LRIeT3Kak3pqfSMj0PMDyLT512p99uUV5L49SVWhBt+ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cRh5G6RyKz6M5G4;
	Wed, 17 Sep 2025 22:30:42 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 9D0361400F4;
	Wed, 17 Sep 2025 22:33:31 +0800 (CST)
Received: from SecurePC-101-06.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 17 Sep 2025 16:33:31 +0200
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Michael Tsirkin <mst@redhat.com>, <qemu-devel@nongnu.org>,
	<shiju.jose@huawei.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <armbru@redhat.com>, Fan Ni <fan.ni@samsung.com>,
	<linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>, Ravi Shankar
	<venkataravis@micron.com>
Subject: [PATCH qemu for 10.2 0/3] cxl: Additional RAS features support.
Date: Wed, 17 Sep 2025 15:33:27 +0100
Message-ID: <20250917143330.294698-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500008.china.huawei.com (7.182.85.71)

These two features have been used in testing the related EDAC RAS
features drivers in Linux which are now upstream. Only minor tweaks
from the second part of:
https://lore.kernel.org/qemu-devel/20250811085530.2263-1-shiju.jose@huawei.com/
[PATCH v6 0/8] hw/cxl: Update CXL events to rev3.2 and add maintenance support for memory repair features

I've split that series up as the two parts were only slightly connected.
However there is some churn if this is applied without the other part of Shiju's posted
series. That was sent a few minutes ago as:
https://lore.kernel.org/qemu-devel/20250917141355.293217-1-Jonathan.Cameron@huawei.com/

Based on: [PATCH qemu for 10.2 0/5] cxl: r3.2 specification events updates.
Based on: 20250917141355.293217-1-Jonathan.Cameron@huawei.com

Davidlohr Bueso (1):
  hw/cxl: Add support for Maintenance command and Post Package Repair
    (PPR)

Shiju Jose (2):
  hw/cxl/cxl-mailbox-utils: Move declaration of scrub and ECS feature
    attributes in cmd_features_set_feature()
  hw/cxl: Add emulation for memory sparing control feature

 include/hw/cxl/cxl_device.h | 145 +++++++++
 include/hw/cxl/cxl_events.h |  47 +++
 hw/cxl/cxl-mailbox-utils.c  | 566 +++++++++++++++++++++++++++++++++++-
 hw/mem/cxl_type3.c          | 169 +++++++++++
 4 files changed, 915 insertions(+), 12 deletions(-)

-- 
2.48.1

