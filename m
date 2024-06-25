Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B0F176AC3
	for <linux-cxl@vger.kernel.org>; Tue, 25 Jun 2024 17:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719335297; cv=none; b=WKSPvtqSIZUp28SzGIXk0OekjqDKD6ct1UjO5IdyJK8HVGRR9Oq03ksWp9F1yhDzhW2Ar5naUfH2CNL6slHr4BvsxGYNedjscuHD8rEHsZUDH2qCZAcIn42elXois+fnjm4w1xfCWUGFYdHdWXmiwq6sS+NGj0/hyczwitGi8z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719335297; c=relaxed/simple;
	bh=+s/k60Q9AeFSRtI2pxvrQkZB+TD8rE3kIzlUyYnGm9Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I9SlBTP3C0ryDqWAUcoIy4VLZSLcv1PVU1olMmc6zryH17antv4tlz8qFf5pkATh+PnF44waw2TRifCA7OJ/79WOWEPqpB64QpUgQM7/1JCoxBzuwYscS3u+GMBgb10c+Z/WvwVl4KbhbNtuvGPZiM6Kay0gXXxyDkkAC0F1kaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W7rp95xLSz6K8L5;
	Wed, 26 Jun 2024 01:06:25 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 957C8140A70;
	Wed, 26 Jun 2024 01:08:06 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 25 Jun 2024 18:08:06 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <qemu-devel@nongnu.org>, <nifan.cxl@gmail.com>,
	<linux-cxl@vger.kernel.org>, <mst@redhat.com>, <armbru@redhat.com>
CC: <linuxarm@huawei.com>
Subject: [PATCH qemu 0/2] hw/cxl: DCD tweaks and improvements.
Date: Tue, 25 Jun 2024 18:08:03 +0100
Message-ID: <20240625170805.359278-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

These came from review after Michael Tsirkin had queued the DCD stuff on
his QEMU tree.  For reasons unrelated to this series, the pull request
was rejected but I'm assuming Michael will send a fresh pull request soon.

Hence this is based on top of qemu/master with the DCD patches from
gitlab.com/mstredhat/qemu.

Markus suggested a number of cleanups for the QMP interface fixing
documentation, and capitalization along with making sure we have
consistent specification references.

He also made the suggestion that at least for now we mark the interfaces
as unstable, so I've done that as well.


Jonathan Cameron (2):
  hw/cxl/events: Improve QMP interfaces and documentation for
    add/release dynamic capacity.
  hw/cxl/events: Mark cxl-add-dynamic-capacity and
    cxl-release-dynamic-capcity unstable

 qapi/cxl.json            | 164 +++++++++++++++++++++++++--------------
 hw/mem/cxl_type3.c       |  18 ++---
 hw/mem/cxl_type3_stubs.c |   8 +-
 3 files changed, 118 insertions(+), 72 deletions(-)

-- 
2.43.0

