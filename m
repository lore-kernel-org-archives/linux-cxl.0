Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A33F3A1B6
	for <linux-cxl@vger.kernel.org>; Mon,  9 Jun 2025 16:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749486821; cv=none; b=Hw8rBhr4GCFyrfkSSAVQpQ6rKReJkbCgP6xTSgz9VR9W82DOBHaZ/fDbDTojXYD5qtVFAVzGa7HuPSuhLazln6RnZn4mt+WFMvSf5+nPvWHq86znhXZq54zyPnHesbZi3xYGPBgFSyiDGPs8sJZI1E/ibr9P12hBBGNEtPK+5Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749486821; c=relaxed/simple;
	bh=jBPfT+z0nIpBHsUkSs0pIas/cCvYIiYUQymaXCMSdlY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NsX4LvtIZ0fONtnMqg/C4UCl9HTu1vvt+DxGkEQTQOz8yXCobLp5aynjGgRUY+McbYB1DyqcXq2TI0sR/kpeT7QcyPA3QcUhO6k++sfWeW2pABwLT5/bVZSIRWl/565Vez3tffTGz26IzMxeFAYy5fgZbYUyqckOBqQnzB2YWac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bGHXp1m30z6M53D;
	Tue, 10 Jun 2025 00:33:14 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id C6BDF140276;
	Tue, 10 Jun 2025 00:33:35 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Jun 2025 18:33:35 +0200
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Klaus Jensen <k.jensen@samsung.com>, <cminyard@mvista.com>, Fan Ni
	<fan.ni@samsung.com>, Anisa Su <anisa.su@samsung.com>,
	<qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, <mst@redhat.com>
CC: <linuxarm@huawei.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
	<philmd@linaro.org>
Subject: [RFC PATCH qemu 0/5] hw/cxl/mctp/i2c/usb: MCTP for OoB control of CXL devices.
Date: Mon, 9 Jun 2025 17:33:28 +0100
Message-ID: <20250609163334.922346-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)

This posting is primarily about sharing the USB device emulation to get some
early feedback.

RFC reasons:
- Known 'inaccuracies' in emulation (not obeying MTU in the to host direction for
  example)./
- Not sure what to do wrt to Klaus' I2C MCTP support given that has been stalled
  for some time. For now only the headers are really shared between the
  two implementations.
- This is more of an FYI / request for testing than a formal suggestion that this
  might be ready for upstream.

Why add a CXL FM-API over MCTP over USB device?
- Can be emulated on pretty much any host system as USB is discoverable and
  expandable. If you want a giggle, see the hacks on i386/pc and arm/virt on
  we've been using until now given only I2C controller that works is the aspeed
  one. e.g. https://gitlab.com/jic23/qemu/-/commit/134c2e3952b
- Being able to talk to both the fabric management out of band interfaces
  and the in band devices on the same host makes testing much simpler.

Background:

Back in 2022 I posted some support for controlling the CXL fabric via the
spec defined out of band interfaces (CXL Fabric Management API - FM-API)
over MCTP on I2C

https://lore.kernel.org/qemu-devel/20220520170128.4436-1-Jonathan.Cameron@huawei.com/
I reworked that on top of the NVME-MI work from Klauss.

To that end I hacked the aspeed-i2c controller onto both i386/pc and arm/virt
and posted kernel patches to enabled ACPI support for that device (more or less).
It worked and has been useful in the meantime, but adding that i2c controller
to those boards was obviously not going to be upstreamable - and to build
reliable tests against it I don't want to carry this out of tree for ever.
I messed around with a PCI hosted aspeed controller and might come back to
that at some point.

In the meantime, DMTF published a transport binding for MCTP over USB
https://www.dmtf.org/sites/default/files/standards/documents/DSP0283_1.0.1.pdf

Kernel support duly followed early this year: drivers/net/mctp/mctp-usb.c
https://codeconstruct.com.au/docs/mctp-over-usb/

Given the ease of adding a suitable USB controller on a PCI bus, emulating a
suitable endpoint provides what I think is an upstreamable solution.

To use this:
 -device usb-ehci,id=ehci
 -device usb-cxl-mctp,bus=ehci.0,id=fred,target=us0

where target is either a CXL switch upstream port, or a type 3 device.

Then install the mctp userspace tools in your guest and configure it with

  mctp addr add 8 dev mctpusb0
  mctp link set mctpusb0 net 11
  mctp link set mctpusb0 up

  systemctl start mctpd.service
  busctl call au.com.codeconstruct.MCTP1 /au/com/codeconstruct/mctp1/interfaces/mctpusb0 au.com.codeconstruct.MCTP.BusOwner1 SetupEndpoint ay 0

I've been testing the CXL commands with

https://gitlab.com/jic23/cxl-fmapi-tests
(mostly because I still had them in my image from the i2c work)
but libcxlmi is probably a better bet

https://github.com/computexpresslink/libcxlmi

I'll post a tree with this on at gitlab.com/jic23/qemu shortly
(cxl-<latest date>).

Jonathan Cameron (3):
  hw/cxl/i2c_mctp_cxl: Initial device emulation
  docs: cxl: Add example commandline for MCTP CXL CCIs
  usb/mctp/cxl: CXL FMAPI interface via MCTP over usb.

Klaus Jensen (2):
  hw/i2c: add smbus pec utility function
  hw/i2c: add mctp core

 MAINTAINERS                               |   7 +
 docs/system/devices/cxl.rst               |  27 +
 include/hw/cxl/cxl_device.h               |   8 +
 include/hw/i2c/mctp.h                     | 125 +++++
 include/hw/i2c/smbus_master.h             |   2 +
 include/hw/pci-bridge/cxl_upstream_port.h |   1 +
 include/hw/usb.h                          |   1 +
 include/net/mctp.h                        | 100 ++++
 hw/cxl/cxl-mailbox-utils.c                |  49 ++
 hw/cxl/i2c_mctp_cxl.c                     | 289 ++++++++++
 hw/i2c/mctp.c                             | 414 ++++++++++++++
 hw/i2c/smbus_master.c                     |  26 +
 hw/usb/dev-mctp.c                         | 639 ++++++++++++++++++++++
 hw/arm/Kconfig                            |   1 +
 hw/cxl/Kconfig                            |   4 +
 hw/cxl/meson.build                        |   4 +
 hw/i2c/Kconfig                            |   4 +
 hw/i2c/meson.build                        |   1 +
 hw/i2c/trace-events                       |  14 +
 hw/usb/Kconfig                            |   5 +
 hw/usb/meson.build                        |   1 +
 21 files changed, 1722 insertions(+)
 create mode 100644 include/hw/i2c/mctp.h
 create mode 100644 include/net/mctp.h
 create mode 100644 hw/cxl/i2c_mctp_cxl.c
 create mode 100644 hw/i2c/mctp.c
 create mode 100644 hw/usb/dev-mctp.c

-- 
2.48.1

