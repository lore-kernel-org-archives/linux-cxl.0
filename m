Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3611EF0B7
	for <linux-cxl@vger.kernel.org>; Fri,  6 Dec 2024 09:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733478655; cv=none; b=dx8q7H7Aknb+zfC4tTELMD2p0lyaWTu6Bxh6r7szSOO2SgyJQkXzfTmtFatrNOIfGcpzMDHXChOYJuf9Jh4C26KLGPsOq42ABqs2LUxUM9CAqqLMEqQzMSC4sfNm/Dya4NPTpHrwmEIfiotSaOJfSfFspedKWurApyTJqXBlzgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733478655; c=relaxed/simple;
	bh=ZizzLeWUM8jDW36W355hDb72lRZ8mvCIUM18tGM4OQI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Rj3vOrqW3AGwHhRLbGpCYQ/EBchSH5AttClgmAOaPh/ZBJ8FbsTQTPVKbdpTXCd3X91sfCCh0EUbp5DxwouxE0C64viUziDrvZQZG5KPJlAOv4kJKeLwVz34NkySoeg488u5yAFzb1MUQObrO9DhOPxRxgZGOXhaocd16Up1+YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwBXYHrbyFJnXnSGBw--.17063S2;
	Fri, 06 Dec 2024 17:50:19 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
	by mail (Coremail) with SMTP id AQAAfwAHWHTUyFJnPuhjAA--.7499S3;
	Fri, 06 Dec 2024 17:50:13 +0800 (CST)
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: jonathan.cameron@huawei.com,
	fan.ni@samsung.com,
	mst@redhat.com,
	marcel.apfelbaum@gmail.com
Cc: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org,
	chenbaozi@phytium.com.cn,
	Yuquan Wang <wangyuquan1236@phytium.com.cn>
Subject: [PATCH 0/1] cxl/cxl-host: Support creation of a new CXL Host Bridge
Date: Fri,  6 Dec 2024 17:49:38 +0800
Message-Id: <20241206094939.921781-1-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwAHWHTUyFJnPuhjAA--.7499S3
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQALAWdSBAwFUQACsg
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7uFWxtry8GF4fJF1fZF13urg_yoW8CF15p3
	WDGrWfGr1DCry3Jws3A3yUJa1rWrs5WFW5Zr1I9w18AF15tF4DJr1kKa1ava4DC345uw1f
	tFnFqrn5K3WUZ37anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

Background
==========
Currently the base CXL support for arm platforms is only on Jonathan's
patches[1] which have not yet merged into upstream. Some platform like
SBSA-REF can be more like a real machine, thus the support of cxl could
be meaningful. However, the pxb-cxl-host realization on this platform
seems not satisfying their requirements[2].

New CXL HOST design
===================
This work defines a new cxl host bridge type (TYPE_CXL_HOST). This
could be considered as a prototype of an independent cxl host bridge
which combines gpex features (ecam, mmio windows & irq) and pxb-cxl
features(CHBCR) at meanwhile.

The root bus path of CXL_HOST is "0001:00", that would not affect the
original pcie host topology. In the previous, the pxb-cxl-host with
any cxl root ports and cxl endpoint devices would occupy the BDF
number of the original pcie domain. This new type provide a solution
to resolve the problem.

Also the CXLFixedWindow struct adds a new member 'target_chb' to
record the target list of CXLHostBridge. And necessary is to adjust
the logic of 'cxl_cfmws_find_device' and 'cxl_fmws_link_targets' to
allow different types of cxl host bridge.

Move 'cxl_get_hb_cstate' & 'cxl_get_hb_passthrough' from pxb code
into cxl-host code.

Link:
[1]: https://lore.kernel.org/linux-cxl/20220616141950.23374-1-Jonathan.Cameron@huawei.com/
[2]: https://lists.nongnu.org/archive/html/qemu-arm/2024-11/msg00522.html

Yuquan Wang (1):
  cxl/cxl-host: Support creation of a new CXL Host Bridge

 hw/cxl/cxl-host-stubs.c             |   2 +
 hw/cxl/cxl-host.c                   | 220 ++++++++++++++++++++++++++--
 hw/pci-bridge/pci_expander_bridge.c |  20 +--
 include/hw/cxl/cxl.h                |  23 +++
 include/hw/cxl/cxl_component.h      |   4 +-
 include/hw/cxl/cxl_host.h           |   6 +
 6 files changed, 242 insertions(+), 33 deletions(-)

-- 
2.34.1

