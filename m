Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F305E3A27B
	for <linux-cxl@vger.kernel.org>; Wed, 17 Jul 2024 15:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721228587; cv=none; b=sXi+IA4aWiqvXer+5yPSHIb0nzaM+J7FnOlZaewzUDoQ7WKeuvOIrMuDfa/BrpW2j7qcp5kfqEPDJMh7XiDgVhWv+7HhNBnSiS7G6UkDDtcHvBJ2vMnFTV0WFKAzAP8+aeTgOUGe8O5aBPig4aPTmgYELiYQ7dnTBnVkWRUdWik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721228587; c=relaxed/simple;
	bh=reVv+HM0EV+jyS8TOGif5Xm2WZwGFj3tfACS4wjvoV8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GRhfXA8TgUrIYa/Fs3htZTUVb8p2W+/4dLPjtd4xL/H0dNEO8rKzLkikNmJnTLjykmh9jrJKZX+Fq23hW5P5kxPY+/lF8yRrb6CuQYK+yCXv3bfwEnU403JlTZm17qJyRPvlUu1W9Eg+h2Cpc+sIenO/hVYLJ7bm2CIPW2K6mxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WPJz16KBtz6DB74;
	Wed, 17 Jul 2024 23:00:45 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 495BC140B2F;
	Wed, 17 Jul 2024 23:03:00 +0800 (CST)
Received: from localhost (10.122.19.247) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 17 Jul
 2024 16:02:59 +0100
Date: Wed, 17 Jul 2024 16:02:58 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Igor Mammedov <imammedo@redhat.com>
CC: Markus Armbruster <armbru@redhat.com>, <mst@redhat.com>,
	<qemu-devel@nongnu.org>, <ankita@nvidia.com>, <linuxarm@huawei.com>,
	<linux-cxl@vger.kernel.org>, <marcel.apfelbaum@gmail.com>,
	<philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Dave
 Jiang <dave.jiang@intel.com>, Huang Ying <ying.huang@intel.com>, Paolo
 Bonzini <pbonzini@redhat.com>, <eduardo@habkost.net>, Michael Roth
	<michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v5 10/13] hw/acpi: Generic Port Affinity Structure
 support
Message-ID: <20240717160258.00006893@huawei.com>
In-Reply-To: <20240715164841.1979fdea@imammedo.users.ipa.redhat.com>
References: <20240712110837.1439736-1-Jonathan.Cameron@huawei.com>
	<20240712110837.1439736-11-Jonathan.Cameron@huawei.com>
	<20240715164841.1979fdea@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 15 Jul 2024 16:48:41 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> On Fri, 12 Jul 2024 12:08:14 +0100
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> 
> > These are very similar to the recently added Generic Initiators
> > but instead of representing an initiator of memory traffic they
> > represent an edge point beyond which may lie either targets or
> > initiators.  Here we add these ports such that they may
> > be targets of hmat_lb records to describe the latency and
> > bandwidth from host side initiators to the port.  A discoverable
> > mechanism such as UEFI CDAT read from CXL devices and switches
> > is used to discover the remainder of the path, and the OS can build
> > up full latency and bandwidth numbers as need for work and data
> > placement decisions.
> > 
> > Acked-by: Markus Armbruster <armbru@redhat.com>
> > Tested-by: "Huang, Ying" <ying.huang@intel.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> 
> ACPI tables generation LGTM
> As for the rest my review is perfunctory mostly.

The node type points and missing descriptor applying equally to generic
initiators. I'll add a couple of patches cleaning that up as well as 
fixing them up for generic ports.

For the exit(1) that was copying other similar locations. I don't
mind changing it though if something else is preferred.

Given tight timescales (and I was away for a few days which didn't
help), I'll send out a v6 with changes as below.

Jonathan


> 
> > ---
> > v5: Push the definition of TYPE_ACPI_GENERIC_PORT down into the
> >     c file (similar to TYPE_ACPI_GENERIC_INITIATOR in earlier patch)
> > ---
> >  qapi/qom.json                       |  34 +++++++++
> >  include/hw/acpi/aml-build.h         |   4 +
> >  include/hw/acpi/pci.h               |   2 +-
> >  include/hw/pci/pci_bridge.h         |   1 +
> >  hw/acpi/aml-build.c                 |  40 ++++++++++
> >  hw/acpi/pci.c                       | 112 +++++++++++++++++++++++++++-
> >  hw/arm/virt-acpi-build.c            |   2 +-
> >  hw/i386/acpi-build.c                |   2 +-
> >  hw/pci-bridge/pci_expander_bridge.c |   1 -
> >  9 files changed, 193 insertions(+), 5 deletions(-)
> > 
> > diff --git a/qapi/qom.json b/qapi/qom.json
> > index 8e75a419c3..b97c031b73 100644
> > --- a/qapi/qom.json
> > +++ b/qapi/qom.json
> > @@ -838,6 +838,38 @@
> >    'data': { 'pci-dev': 'str',
> >              'node': 'uint32' } }
> >  
> > +##
> > +# @AcpiGenericPortProperties:
> > +#
> > +# Properties for acpi-generic-port objects.
> > +#
> > +# @pci-bus: QOM path of the PCI bus of the hostbridge associated with
> > +#     this SRAT Generic Port Affinity Structure.  This is the same as
> > +#     the bus parameter for the root ports attached to this host
> > +#     bridge.  The resulting SRAT Generic Port Affinity Structure will
> > +#     refer to the ACPI object in DSDT that represents the host bridge
> > +#     (e.g.  ACPI0016 for CXL host bridges).  See ACPI 6.5 Section
> > +#     5.2.16.7 for more information.
> > +#  
> 
> > +# @node: Similar to a NUMA node ID, but instead of providing a
> > +#     reference point used for defining NUMA distances and access
> > +#     characteristics to memory or from an initiator (e.g. CPU), this
> > +#     node defines the boundary point between non-discoverable system
> > +#     buses which must be described by firmware, and a discoverable
> > +#     bus.  NUMA distances and access characteristics are defined to
> > +#     and from that point.  For system software to establish full
> > +#     initiator to target characteristics this information must be
> > +#     combined with information retrieved from the discoverable part
> > +#     of the path.  An example would use CDAT (see UEFI.org)
> > +#     information read from devices and switches in conjunction with
> > +#     link characteristics read from PCIe Configuration space.  
> 
> you lost me here (even reading this several time doesn't help).
> Perhaps I lack specific domain knowledge, but is there a way to make it
> more comprehensible for layman?

This is far from the first version (which Markus really didn't like ;)
It is really easy to draw as a sequence of diagrams and really tricky
to put in text!  Not so easy to get the kernel code right either
as it turns out but that's another story.

Perhaps if I add something to the end to say what you do with it
that might help?

"To get the full path latency, from CPU to CXL attached DRAM on a type 3
 CXL device:  Add the latency from CPU to Generic Port (from HMAT indexed
 via the the node ID in this SRAT structure) to that for CXL bus links, the
 latency across intermediate switches and from the EP port to the
 actual memory.  Bandwidth is more complex as there may be interleaving
 across multiple devices and shared links in the path."

> 
> > +#
> > +# Since: 9.1
> > +##
> > +{ 'struct': 'AcpiGenericPortProperties',
> > +  'data': { 'pci-bus': 'str',
> > +            'node': 'uint32' } }
> > +


