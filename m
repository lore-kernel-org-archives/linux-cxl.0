Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8301B7E9
	for <linux-cxl@vger.kernel.org>; Mon, 16 Sep 2024 17:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726508131; cv=none; b=tf41S/pKCB1i8mZCdHhC8WzYHbMxzPYcms5ogGWS1g7pZUJdIyNIujqJuH0MLKIIyBE/U94QQCYR5Vp3ehI7r1dtlnHNXSSbib3+EkNqlh0VIJSZGIP4CILqR/u69yaA8U/GB1hlM1SjMOrX4b2FRrCVmwe/y1f4DuFwaosIRsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726508131; c=relaxed/simple;
	bh=FeC86l494AUBA9CAs9EZAN+WwOpbrrKcJqfAS4EB2x8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fGQ2FASgFUemtXZYDTo9jMGQN298eK+j0AQUEzXKwmFGIi2P1amRYqMJQW1nRJn2pQQcaB2whaufuYdKs7/0fca2lAC6Yg/aeCWkvZCIBD+2dIzLoT7l3FUhChW2wNL29asemDcZzf33FBPHr4g5nWwJAmd4bSuZGS7qwE837bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4X6sQQ14Ktz6K9FF;
	Tue, 17 Sep 2024 01:31:10 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 51BF2140D1A;
	Tue, 17 Sep 2024 01:35:22 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Sep 2024 19:35:19 +0200
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
	<qemu-devel@nongnu.org>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>,
	<marcel.apfelbaum@gmail.com>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
	<ying.huang@intel.com>, Michael Roth <michael.roth@amd.com>,
	<fan.ni@samsung.com>
Subject: [PATCH qemu 0/6] hw/cxl: Link speed and width control
Date: Mon, 16 Sep 2024 18:35:12 +0100
Message-ID: <20240916173518.1843023-1-Jonathan.Cameron@huawei.com>
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

Changes since RFC:
- rebase

Question:
- I could enable this for all PCIe device (including ports).
  Does that makes sense, or is it better to limit this to my cases?
  It is quite easy to build broken setups (downstream device reports
  faster link than the port etc) because QEMU 'link' training' is
  simplistic.  I'm not sure it is worth making it more clever.

The Generic Ports support added the ability to describe the bandwidth and
Latency within a host to a CXL host bridge.  To be able to test the of the
discovery path used by Linux [1] we also need to be able to create
bottlenecks at difference places in the topology. There are two parts to
this
* CXL link characteristics as described by PCI Express Capability Link
  status etc.
* Bandwidth and latency across CXL Switches (via CDAT data from the switch
  USP)
* Bandwidth and latency from the CXL type 3 device port to the actual
  memory (Via CDAT data from the EP).

Currently we have fixed values for the CXL CDAT tables, and to test this
I recommend changing those as per the patch at the end of this cover letter
(so they aren't always the bottleneck). Making those configurable will be
handled in a future patch set.

RFC has a set of examples but those were to help testing the kernel code
rather than providing much info for QEMU review so I haven't repeated
them ehre.

https://lore.kernel.org/qemu-devel/20240712122414.1448284-1-Jonathan.Cameron@huawei.com/

Jonathan Cameron (6):
  hw/pci-bridge/cxl_root_port: Provide x-speed and x-width properties.
  hw/pci-bridge/cxl_upstream: Provide x-speed and x-width properties.
  hw/pcie: Factor out PCI Express link register filling common to EP.
  hw/pcie: Provide a utility function for control of EP / SW USP link
  hw/mem/cxl-type3: Add properties to control link speed and width
  hw/pci-bridge/cxl-upstream: Add properties to control link speed and
    width

 include/hw/cxl/cxl_device.h               |   4 +
 include/hw/pci-bridge/cxl_upstream_port.h |   4 +
 include/hw/pci/pcie.h                     |   2 +
 hw/mem/cxl_type3.c                        |   6 ++
 hw/pci-bridge/cxl_downstream.c            |  23 +++--
 hw/pci-bridge/cxl_root_port.c             |   5 ++
 hw/pci-bridge/cxl_upstream.c              |   6 ++
 hw/pci/pcie.c                             | 105 ++++++++++++++--------
 8 files changed, 103 insertions(+), 52 deletions(-)

-- 
2.43.0

