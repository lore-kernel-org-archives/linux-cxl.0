Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302E177F10
	for <linux-cxl@vger.kernel.org>; Wed, 24 Jan 2024 13:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706104101; cv=none; b=nHdjKnOb/KSpqme8+SARTzl0WJstJTCgUPxuWbqbvNI5P67w9qpWDe3/VDQ1/DGDidjdVKaRkchBwshrlDbAE+r/j825ZjtFVIcPvoaXa0BbJ+xVvQl/XNAcYgWYKsqE132gXUA4vo1X/Ro3FfV5e1y3PkuN1MOf+yiuGWGQpA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706104101; c=relaxed/simple;
	bh=llsFxI5tviKRnfkiei4njVTKMjy4nqM09uHUO/kxbmw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MKQD/NEcIaGLXuxrYOfTrkVwICLSifj5UFYlRxH9OCEW1lDhCDSsk4cd0UYjApbJR/VMfuBefMvKa5BGKf8E8rvDzblplU6LDfFHf8TRfnUTc8TYf5cdnWVAWqT8554S56NohGy2/CxgY+2fPzan3kCegLC73BLqBeeTJLR9roU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TKlZh1Z4Vz6K7GB;
	Wed, 24 Jan 2024 21:45:16 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id E1FC0140684;
	Wed, 24 Jan 2024 21:48:12 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 13:48:12 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, Fan Ni
	<fan.ni@samsung.com>, Michael Tsirkin <mst@redhat.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, <linuxarm@huawei.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/5 qemu] hw/cxl: Update CXL emulation to reflect and reference r3.1
Date: Wed, 24 Jan 2024 13:48:09 +0000
Message-ID: <20240124134814.8717-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
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

Last year a reviewer requested that the versioning and references in the CXL
code pointed out at a specific available specification revision (Sorry I can't
remember who!)  That drew my attention to the complete mess of versioning
with many comments not calling out which version of CXL they were refering
to (these date back to when we only cared about CXL r2.0)

Unfortunately without being a CXL consortium member only one version of
the specification is easily obtained (via a click through for 'evaluation'
purposes) from https://www.computeexpresslink.org/download-the-specification .
Whilst I hope that will change, given we need to clean this up anyway
it make sense to standardize on CXL r3.1 which is the currently available
version.  Note that I have no intentioning of doing this again for
CXL rNext when it appears - this is intended to be a onetime thing.

Some structures have been updated between when we introduced the emulation
of a particular feature and today, but this has been done in a backwards
compatible way. So to bring everything up to CXL revision 3.1, I've added
definitions etc for new fields and registers, but set the capability bits
to say we don't support anything they tell us about and write masks should
leave the control bits reserved (e.g. not writeable)

This will result in a small amount of register placement changing but
it's all discoverable and the CXL emulation doesn't currently allow
sensible migration anyway, we shouldn't have any backwards compatibility
problems.

For those kind enough to review, given this involves some tedious spec
diving, feel free to do a subset and state what you covered so that
others can avoid duplication.

Based-on: [PATCH 00/12 qemu] CXL emulation fixes and minor cleanup.

Based-on: Message-ID: 20240124124100.8218-1-Jonathan.Cameron@huawei.com

Jonathan Cameron (5):
  hw/cxl: Update HDM Decoder capability to version 3
  hw/cxl: Update link register definitions.
  hw/cxl: Update RAS Capability Definitions for version 3.
  hw/cxl: Update mailbox status registers.
  hw/cxl: Standardize all references on CXL r3.1 and minor updates

 docs/system/devices/cxl.rst    |  3 +-
 include/hw/cxl/cxl_cdat.h      | 10 ++---
 include/hw/cxl/cxl_component.h | 51 +++++++++++++++-------
 include/hw/cxl/cxl_device.h    | 77 +++++++++++++++++++++++-----------
 include/hw/cxl/cxl_events.h    | 18 ++++----
 include/hw/cxl/cxl_pci.h       | 67 ++++++++++++++++++++---------
 hw/cxl/cxl-component-utils.c   | 29 ++++++++-----
 hw/cxl/cxl-device-utils.c      | 14 +++++--
 hw/cxl/cxl-events.c            |  2 +-
 hw/cxl/cxl-mailbox-utils.c     | 49 ++++++++++++----------
 hw/mem/cxl_type3.c             |  6 +--
 hw/pci-bridge/cxl_downstream.c |  4 +-
 hw/pci-bridge/cxl_root_port.c  |  4 +-
 hw/pci-bridge/cxl_upstream.c   |  4 +-
 14 files changed, 219 insertions(+), 119 deletions(-)

-- 
2.39.2

