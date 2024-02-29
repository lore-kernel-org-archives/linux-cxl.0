Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9910A160633
	for <linux-cxl@vger.kernel.org>; Thu, 29 Feb 2024 16:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709223957; cv=none; b=VVZqR6EE3GjN6GYWraFVcIX234mP2oMzS5fkGyuipvrmJItMAEaRU9mgA8Rb/yiF49N+tUnQWv1KDpVd2JYME4opY7RCC+tu2SZd93n/y2mfoGWWJPQGCHFWui6zETyH3Ondq7L//ME3om/lBg6fS1eryBBC1Hor+vBXvkL55p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709223957; c=relaxed/simple;
	bh=FQ0V7dtdAJ+t46jszuZuiMfOMl9BzJNgr1NYGVGt9ug=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OgTbUTLfg5uweopOw4kUE08Y6Pl6BNfwKnhJsvIRLz/42+kuc960O49b48hiKH61k0p6jSaPB2RUHHCYmEv1jzqhaFp1X5ZIX5fJjn/6mS2x1fVvXGgQdR+CNXBTfpkgD1xInVMRQADe5XU/fUj/kOgRCSgyuW5h8gQxHdpQ2l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TlxKq0Cccz6JBQg;
	Fri,  1 Mar 2024 00:21:03 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 14536141870;
	Fri,  1 Mar 2024 00:25:46 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 29 Feb 2024 16:25:45 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Liu Jingqi <jingqi.liu@intel.com>, <qemu-devel@nongnu.org>,
	<ankita@nvidia.com>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov
	<imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
CC: <linuxarm@huawei.com>, Markus Armbruster <armbru@redhat.com>, Daniel Black
	<daniel@linux.ibm.com>, <linux-cxl@vger.kernel.org>
Subject: [PATCH 0/2 qemu] hw/acpi/hmat: Misc fixes
Date: Thu, 29 Feb 2024 16:25:43 +0000
Message-ID: <20240229162545.7887-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

Two unrelated fixes here:
1) Linux really doesn't like it when you claim non existent memory
   is directly connected to an initiator (here a CPU).
   It is a nonsense entry, though I also plan to try and get
   a relaxation of the condition into the kernel.
   Maybe we need to care about migration, but I suspect no one
   cares about this corner case (hence no one noticed the
   problem!)

2) An access outside of the allocated array when building the
   the latency and bandwidth tables.  Given this crashes QEMU
   for me, I think we are fine with the potential table change.

Some notes on 1:
- This structure is almost entirely pointless in general - most
  of the fields were removed in HMAT v2.
  What remains, is meant to convey memory controller location
  when the memory is in a different Proximity Domain from the
  memory controller (e.g. a SoC with both HBM and DDR will present
  2 NUMA domains but memory controllers will be wherever we describe
  the CPUs as being - typically with the DDR)
  Currently QEMU creates these to indicate direct connection between
  a CPU domain and memory in the same domain. Using the Proximity
  domain in SRAT conveys the same. This adds no information.

Notes on 2:
- I debated a follow up patch removing the entires in the table
  for initiators on nodes that don't have any initiators.
  QEMU won't let you use them as initiators in the LB entries
  anyway so there is no way to set those entries and they
  end up reported as 0. OK for Bandwidth as no one is going to use
  the zero bandwidth channel, but that's a very attractive latency,
  but that's fine as no one will read the number as there are
  no initiators? (right?)

  There is a corner case in ACPI that bites us here.
  ACPI Proximity domains are only defined in SRAT, but nothing says
  they need to be fully defined.  Generic Initiators are optional
  afterall (newish feature) so it was common to use _PXM in DSDT
  to define where various platform devices were (and PCI but that's
  still not read by Linux - a story of pain and broken systems for
  another day). That's fine if they are in a node with CPUs
  (initiators) but not so much if they   happen to be in a memory
  only node. Today I think the only thing we can make hit this
  condition in QEMU is a PCI Expander Bridge which doesn't initiate
  transactions. But things behind it do and there are drivers out
  there that do buffer placement based on SLIT distances. I'd
  expect HMAT users to follow soon.

  It would be nice to think all such systems will use Generic Port
  Affinity Structures (and I have patches for those to follow shortly)
  but that's overly optimistic beyond CXL where the kernel will use
  them and which drove their introduction.

Jonathan Cameron (2):
  hmat acpi: Do not add Memory Proximity Domain Attributes Structure
    targetting non existent memory.
  hmat acpi: Fix out of bounds access due to missing use of indirection

 hw/acpi/hmat.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

-- 
2.39.2

