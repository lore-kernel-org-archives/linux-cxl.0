Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61DD17A58F
	for <linux-cxl@vger.kernel.org>; Tue, 29 Oct 2024 10:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730197863; cv=none; b=MCL0oi1nrGR7cXVreIzTMCFfxEEkYRouSmtYAFXZPeX5WuhOYqqSlEdRtf9RuUvCTQkN+m7EjowBt6J2AM5s/zZHCJyHVZwTvF5o1tSRhCb0mAQwTY4u82LdLqQd419p4jH1qAXNIVPt+vC13fRd3BZm63JOSlhkbFSJVT6X3Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730197863; c=relaxed/simple;
	bh=o3+/3/SvkhDdau+lGU4ZDtUZUBZLTccTZPRMS3uqPTI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F7HUWoNwyssCnEKJ3b7JsTmVPg24ru+lvrBOnJdGKn1qm/KBQVfrB1HkKXTGqP1odOy6WW2gU+pZ4kNdyoELT0u56j0si2uxTcbw6GdFazY6i09pP5lIz5GdygJk05wvLa+HL6xN9uW5ZHkj4+0Qiwz5SVFa43cGzfuCKSVmtPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xd6105SX7z6K6Wm;
	Tue, 29 Oct 2024 18:28:36 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 4C2561404F5;
	Tue, 29 Oct 2024 18:30:53 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 29 Oct
 2024 11:30:52 +0100
Date: Tue, 29 Oct 2024 10:30:50 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
	<qemu-devel@nongnu.org>
CC: <linux-cxl@vger.kernel.org>, <marcel.apfelbaum@gmail.com>, Dave Jiang
	<dave.jiang@intel.com>, Huang Ying <ying.huang@intel.com>, Michael Roth
	<michael.roth@amd.com>, <fan.ni@samsung.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH qemu 0/6] hw/cxl: Link speed and width control
Message-ID: <20241029102850.000052c5@huawei.com>
In-Reply-To: <20240916173518.1843023-1-Jonathan.Cameron@huawei.com>
References: <20240916173518.1843023-1-Jonathan.Cameron@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

Gentle ping.

I'm less worried about hitting this cycle for this than the Generic Port
work but this is the missing piece for ensuring we can test the kernel
code that builds NUMA description for CXL devices. I'd like to have
the full solution for that upstream.

The bulk of this is a refactor with functional changes limited to
the CXL components.

Jonathan


On Mon, 16 Sep 2024 18:35:12 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> Changes since RFC:
> - rebase
> 
> Question:
> - I could enable this for all PCIe device (including ports).
>   Does that makes sense, or is it better to limit this to my cases?
>   It is quite easy to build broken setups (downstream device reports
>   faster link than the port etc) because QEMU 'link' training' is
>   simplistic.  I'm not sure it is worth making it more clever.
> 
> The Generic Ports support added the ability to describe the bandwidth and
> Latency within a host to a CXL host bridge.  To be able to test the of the
> discovery path used by Linux [1] we also need to be able to create
> bottlenecks at difference places in the topology. There are two parts to
> this
> * CXL link characteristics as described by PCI Express Capability Link
>   status etc.
> * Bandwidth and latency across CXL Switches (via CDAT data from the switch
>   USP)
> * Bandwidth and latency from the CXL type 3 device port to the actual
>   memory (Via CDAT data from the EP).
> 
> Currently we have fixed values for the CXL CDAT tables, and to test this
> I recommend changing those as per the patch at the end of this cover letter
> (so they aren't always the bottleneck). Making those configurable will be
> handled in a future patch set.
> 
> RFC has a set of examples but those were to help testing the kernel code
> rather than providing much info for QEMU review so I haven't repeated
> them ehre.
> 
> https://lore.kernel.org/qemu-devel/20240712122414.1448284-1-Jonathan.Cameron@huawei.com/
> 
> Jonathan Cameron (6):
>   hw/pci-bridge/cxl_root_port: Provide x-speed and x-width properties.
>   hw/pci-bridge/cxl_upstream: Provide x-speed and x-width properties.
>   hw/pcie: Factor out PCI Express link register filling common to EP.
>   hw/pcie: Provide a utility function for control of EP / SW USP link
>   hw/mem/cxl-type3: Add properties to control link speed and width
>   hw/pci-bridge/cxl-upstream: Add properties to control link speed and
>     width
> 
>  include/hw/cxl/cxl_device.h               |   4 +
>  include/hw/pci-bridge/cxl_upstream_port.h |   4 +
>  include/hw/pci/pcie.h                     |   2 +
>  hw/mem/cxl_type3.c                        |   6 ++
>  hw/pci-bridge/cxl_downstream.c            |  23 +++--
>  hw/pci-bridge/cxl_root_port.c             |   5 ++
>  hw/pci-bridge/cxl_upstream.c              |   6 ++
>  hw/pci/pcie.c                             | 105 ++++++++++++++--------
>  8 files changed, 103 insertions(+), 52 deletions(-)
> 

