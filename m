Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B1E81E
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jul 2024 12:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720184362; cv=none; b=NXa8hBGvcBY5DyCC1J/rv6iSA0Ft/IDXXWHeqxK9iDaGL/sIO3G9jEyPjBGkMbdujlCfSRuJpD59bJUsdjc1notMpsODyZzxM2haYcQaaI59sgY8vjavQBvi15JsWlI7onley+GiwASfmyuJwcT0wM+XvBJkq5/Nu6Gq7XEBSEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720184362; c=relaxed/simple;
	bh=Yh7anUgVKA0ccKBRMMAWKFq9HyaQhnLi720VJjRJAfI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Gr7Sq3DFbXpbU/twxarCxBJ9CRlTesHM0EK0Yuy4vRrFm9JJ1+rXb7xYrtF0IBlohwHbPecBB5lWiz2Ancrftsc9X95W0boPcvWP+29T+Ld88fdUVMPtbiqqZW0MWf8jlVfz512ZjnRGB3uthJuWwc9mTBgLURyKIFSG04r7akA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WFtq21P9Vz6K6mb;
	Fri,  5 Jul 2024 20:58:06 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 56AF1140A30;
	Fri,  5 Jul 2024 20:59:16 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 5 Jul 2024 13:59:15 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <linux-cxl@vger.kernel.org>, <mst@redhat.com>, <qemu-devel@nongnu.org>
CC: <fan.ni@samsung.com>, Davidlohr Bueso <dave@stgolabs.net>, Fan Ni
	<nifan.cxl@gmail.com>, <linuxarm@huawei.com>
Subject: [PATCH qemu v4 0/1] hw/cxl: Support firmware updates
Date: Fri, 5 Jul 2024 13:59:14 +0100
Message-ID: <20240705125915.991672-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

v4: Trivial rebase due to reordering of patch queue for upstreaming.
    A couple of white space fixes (checkpatch)

This one was waiting on a v3 revision from Davildlohr (which he posted
last week) rather than DCD as such, but the various series before this
one cause a lot of churn so it's easier to merge in this order.

Details in patch 1, but in short this fakes firmware updates, allowing
testing of the OS support.

Based-on: [PATCH qemu v6 0/4] hw/cxl/cxl-mailbox-utils: Add feature commands, device patrol scrub control and DDR5 ECS control feature
Based-on: [PATCH qemu 0/4] hw/cxl: Add support for scan media.

Based-on: Message-id: 20240705123039.963781-1-Jonathan.Cameron@huawei.com
Based-on: Message-id: 20240705120643.959422-1-Jonathan.Cameron@huawei.com

Davidlohr Bueso (1):
  hw/cxl: Support firmware updates

 include/hw/cxl/cxl_device.h |  15 +++
 hw/cxl/cxl-mailbox-utils.c  | 205 +++++++++++++++++++++++++++++++++++-
 2 files changed, 215 insertions(+), 5 deletions(-)

-- 
2.43.0

