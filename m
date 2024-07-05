Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5605145B0F
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jul 2024 12:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720181209; cv=none; b=pkJwRNL9obCsPeO41d07STJ9ODOXpaBO0SIec3HGxH9szp27MsyqZUbIdWdrr6cuybvuthkXIvgCmzmH7FJqvfRb5uKUJr3bPlxVuZ1TgpY7bF6uM9huxPYGpgmdZTBVM9OfufR8wD/DCHGWPyaqs59qYoXQaIUNpShaC5jqrag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720181209; c=relaxed/simple;
	bh=p2xdUol3CszxVrs6oRMXa5JNKYr32CqQw8atPSSYvZo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=REg8r3bzX6KObJGNfZXpAzZ2BCxrnbcIxCO9VsW++pkE6VVe8j04/q+HWamciVCnTsXSei+Evu+Axvad5N8PuLypBQE/TxeWFI795oOVKnesrDcy+3yuN5hGgcYOMaBMSWk8yh39wjxrKlYnMY6Lqh45/Q+i39GPhI6UyAUwZt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WFsfP6M56z6K6f3;
	Fri,  5 Jul 2024 20:05:33 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id E0A26140A30;
	Fri,  5 Jul 2024 20:06:43 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 5 Jul 2024 13:06:43 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <linux-cxl@vger.kernel.org>, <mst@redhat.com>, <qemu-devel@nongnu.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Fan Ni <fan.ni@samsung.com>
Subject: [PATCH qemu 0/4] hw/cxl: Add support for scan media.
Date: Fri, 5 Jul 2024 13:06:39 +0100
Message-ID: <20240705120643.959422-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

Now DCD is upstream, a number of sets that were dependent on it, that have
otherwise been in a good state for a long time, are (hopefully) ready to
upstream.  I was also holding back series that were less critical for
kernel testing to make sure they didn't distract from the progress of
Dynamic Capacity.

This 1st series includes a couple of more general improvements that interact
closely with the scan media changes.  This series applies directly on master
and can go in parallel to

[PATCH qemu v2 0/3]  hw/cxl: Misc minor improvements

The Scan Media commands enable recovery from the situation where a poison
list has overflowed and the OS has no other way to find out which
memory is bad, or because the user wants force a recheck for uncorrectable
ECC errors. This functionality is emulated by keeping an additional list
of injected poison that is not exposed via the existing get poison list
command.  This list is 'discovered' during processing of Scan Media as
if the hardware had detected these errors in real memory.

Davidlohr Bueso (2):
  hw/cxl: Add get scan media capabilities cmd support
  hw/cxl: Add get scan media results cmd support

Hyeonggon Yoo (2):
  hw/cxl/mbox: replace sanitize_running() with cxl_dev_media_disabled()
  hw/cxl/events: discard all event records during sanitation

 include/hw/cxl/cxl_device.h |  15 +-
 hw/cxl/cxl-events.c         |  13 ++
 hw/cxl/cxl-mailbox-utils.c  | 326 ++++++++++++++++++++++++++++++++++--
 hw/mem/cxl_type3.c          |  26 ++-
 4 files changed, 355 insertions(+), 25 deletions(-)

-- 
2.43.0

