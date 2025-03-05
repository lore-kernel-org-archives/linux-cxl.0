Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB98202969
	for <linux-cxl@vger.kernel.org>; Wed,  5 Mar 2025 09:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741166582; cv=none; b=qo+cNZCYbIehjyt9OEIyrUKGJiXuLUI5Kq3r52RsQ+oJArsq58atzs6Fq7ddzb6L91fsJzxDQUnKv5SC7vo2wA7PN+T3c2/3OVMJop+naSLCz3DZ1oBogZhkgS7axnUcmvb3ELjQJJfa6Zv+W7Cd2g4UTE3zcsGDY0gQPrJLpmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741166582; c=relaxed/simple;
	bh=VB/7jYHzTJ8TjChC1j5/1Y3OpjVcrL82Pbf1TZpCp6I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dStcA2D73Ppv0bsuVvrKL7zUFatTHpXFiZ6r6MLbiiyXV/NJzi1+wOZLHHL/PhfAhZJkHUTLp9cnzG3QSKOw1uioGwWfV2s+z1xmxOIcX8bNLQEbw62S6L3zb54JqDEZAk0rUkqXqFvHHB55IysbK+JDC97RCWy9JxosIVWcbws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z76T60Ymtz6M4nS;
	Wed,  5 Mar 2025 17:19:54 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 144A71400D7;
	Wed,  5 Mar 2025 17:22:51 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Mar 2025 10:22:50 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>
CC: <linuxarm@huawei.com>, <fan.ni@samsung.com>, Yuquan Wang
	<wangyuquan1236@phytium.com.cn>, Arpit Kumar <arpit1.kumar@samsung.com>,
	Sweta Kumari <s5.kumari@samsung.com>, Vinayak Holikatti
	<vinayak.kh@samsung.com>, Davidlohr Bueso <dave@stgolabs.net>, Ajay Joshi
	<ajay.opensrc@micron.com>
Subject: [PATCH qemu 0/8] hw/cxl: new features for 10.0 (possibly)
Date: Wed, 5 Mar 2025 09:22:40 +0000
Message-ID: <20250305092249.191812-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

Hi Michael / All,

This is a bit late in the cycle due to some travel and alignment with the
end of a kernel cycle which has made me very busy. If needed I'll send a
rebased version of these right at the start of the 10.1 cycle.

As in previous cycles I have been gathering up reviewed patches so as to
resolve merge conflicts etc before proposing a set to merge to Michael
Tsirkin (and for additional review). The focus of the CXL support continues
to be on emulating a subset of features useful to Linux kernel testing +
more limited support for out of band management over mctp
(one patch in here)

Note that I've only picked up the first of Arpit's series for log
manipulation as the clear and populate log functions are only useful if
any of the supported logs actually allow those functions otherwise they
will always return an error (which will occur for all logs we currently
emulate) The capabilities query is applicable for the Command Effects Log
and indeed indicates that we can't clear or populate it. So that is fine
on it's own.

Otherwise this is a mixed bag of features. The media operations are
particularly interesting as they enable offloading of memory zeroing
/ wiping.  Support for aborting background operations is needed to
enable testing of a feature that allows us to enable userspace access
to background commands without risking lockout of urgent kernel commands

Thanks,

Jonathan

Arpit Kumar (1):
  hw/cxl/cxl-mailbox-utils: Added support for Get Log Capabilities
    (Opcode 0402h)

Davidlohr Bueso (2):
  hw/cxl: Support aborting background commands
  hw/cxl: Support get/set mctp response payload size

Sweta Kumari (1):
  hw/cxl/cxl-mailbox-utils: CXL CCI Get/Set alert config commands

Vinayak Holikatti (3):
  hw/cxl/cxl-mailbox-utils: Add support for Media operations discovery
    commands cxl r3.2 (8.2.10.9.5.3)
  hw/cxl: factor out calculation of sanitize duration from
    cmd_santize_overwrite
  hw/cxl/cxl-mailbox-utils: Media operations Sanitize and Write Zeros
    commands CXL r3.2(8.2.10.9.5.3)

Yuquan Wang (1):
  docs/cxl: Add serial number for persistent-memdev

 docs/system/devices/cxl.rst  |  18 +-
 include/hw/cxl/cxl_device.h  |  43 +++
 include/hw/cxl/cxl_mailbox.h |   6 +
 hw/cxl/cxl-device-utils.c    |  14 +-
 hw/cxl/cxl-mailbox-utils.c   | 668 +++++++++++++++++++++++++++++++++--
 hw/mem/cxl_type3.c           |  22 +-
 6 files changed, 722 insertions(+), 49 deletions(-)

-- 
2.43.0

