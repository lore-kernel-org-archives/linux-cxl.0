Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7DC1A38CD
	for <linux-cxl@vger.kernel.org>; Wed, 28 Aug 2024 16:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724864053; cv=none; b=LOEHX7b7jH3IK3d5jH4vdIUnMc5exJeiw1VfN/e4TFfNYDim1e5kO92iz0rvA64D2XfRpN0o8sHqapVifbQv/hByVAOIky4Y+jfAPd1rXp6AmfiAi7NiLfCHUvB2ma6ahH4hnAfoMONGMx9kT7LcpllIS6Z6SLWLUinz5qMqgF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724864053; c=relaxed/simple;
	bh=Z1TyjheiKGAQDEGbzg4FLl0GHIasqFhBabAG5E+1QMM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tjCaAKOe9lrOLkEKVgKclZv9fttDSww+JdTMjwbG7ZppCWxXOZaZjoDBtz/g3UQF3qmGmROdq6AXo/a7Bj+EGGfo/NQiM1DwQLeX80cSRuHMK1nkWnzbd6/a9BwgxPihz8et6GESrvO27IXkPpGB4dW0NFB1zQBxs/wd0tsE0N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wv9Pn1xZhz6K6Q2;
	Thu, 29 Aug 2024 00:50:05 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 2E4791400D4;
	Thu, 29 Aug 2024 00:54:07 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 28 Aug
 2024 17:54:06 +0100
Date: Wed, 28 Aug 2024 17:54:05 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
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
Message-ID: <20240828175405.00004b4b@Huawei.com>
In-Reply-To: <20240715164841.1979fdea@imammedo.users.ipa.redhat.com>
References: <20240712110837.1439736-1-Jonathan.Cameron@huawei.com>
	<20240712110837.1439736-11-Jonathan.Cameron@huawei.com>
	<20240715164841.1979fdea@imammedo.users.ipa.redhat.com>
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
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
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
Hi Igor,

Given I guess we will soon be in the 9.2 cycle, revisiting this
to prepare a v6.

Added missing parameter descriptions for properties in here
and an additional patch for the ones missing for
generic initiators.  Another patch fixes the uint32_t fragilty
you pointed out for generic initiators (fixed here as well)

2 things remain, the docs and the question you are asked Markus.

See inline.

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

I've had a few passes and clearly still failing :(

Maybe an example is the way to go?  Does the following help?
(replacing the 'An example sentence' above).

#       For example, a CXL Memory device M is directly
#       plugged into a CXL root port P which is part of a
#       CXL root bridge B. To calculate latency from a CPU in
#       the host to the memory on M, the latency from that CPU
#       to the bridge B (and hence port P)* must be added
#       to the latency due to the CXL Link between P and M
#       (calculated from link status registers) and that from
#       the CXL port on device M to the actual memory (read from
#       CDAT via a mailbox on the device).
#       The CPU to root bridge latency (*) is provided by ACPI HMAT.
#       HMAT latency data is indexed with the combination of the
#       proximity domain for the CPU and that for the root bridge.
#       This node value is the root bridge part of that index pair.     	



...


> > +static int build_acpi_generic_port(Object *obj, void *opaque)
> > +{
> > +    MachineState *ms = MACHINE(qdev_get_machine());
> > +    const char *hid = "ACPI0016";
> > +    GArray *table_data = opaque;
> > +    AcpiGenericPort *gp;
> > +    uint32_t uid;
> > +    Object *o;
> > +
> > +    if (!object_dynamic_cast(obj, TYPE_ACPI_GENERIC_PORT)) {
> > +        return 0;
> > +    }
> > +
> > +    gp = ACPI_GENERIC_PORT(obj);
> > +
> > +    if (gp->node >= ms->numa_state->num_nodes) {  
> 
> > +        error_printf("%s: node %d is invalid.\n",
> > +                     TYPE_ACPI_GENERIC_PORT, gp->node);
> > +        exit(1);  
> 
> not sure, 
> maybe use error_fatal instead of using exit(1)?
> 
> CCing Markus to check if it's ok.

Markus?

> 
> 
> > +    }
> > +
> > +    o = object_resolve_path_type(gp->pci_bus, TYPE_PXB_CXL_BUS, NULL);
> > +    if (!o) {
> > +        error_printf("%s: device must be a CXL host bridge.\n",
> > +                     TYPE_ACPI_GENERIC_PORT);
> > +       exit(1);
> > +    }  
> ditto
> 


