Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466BC12F379
	for <linux-cxl@vger.kernel.org>; Mon, 29 Apr 2024 17:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714413054; cv=none; b=iFPwYpofrJH/xgX27NHBuNgBYA6t7V0XccBwBbyJcY43k5rUArsCAaiRoUTpCwzMdPAqOfFTt9HtAANgRpNHg71Ri+qF97GHVnNy0zC/pyO1pmsO1poFSQjVqYe5LUfxwp3ItNDUKy6uytOub3HukrxK6jSyC8BfTkLkc7SIwEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714413054; c=relaxed/simple;
	bh=/HHITjtneac9rJZBkCtOIxumKTtXa5laQjhalilDNjU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=otaRUJbRVNpHPHIt4Wgrdbx+Yhfx1yHHCMOaOHmEH6Uev0VG/BmtHCQOvHhl/fcJaY+eesfKbE42VR1MzjFz3DDI0jVEbBXTQ3xyBv3g+CX2ikpBhyCrF8cXJhhzj0T82Isge0ZFfJPsHrnVXrX3qCX9HQriopWG8XJUVuY67Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VSrQj3KF0z6J9gC;
	Tue, 30 Apr 2024 01:48:13 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 43F44140C98;
	Tue, 30 Apr 2024 01:50:48 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 29 Apr
 2024 18:50:47 +0100
Date: Mon, 29 Apr 2024 18:50:46 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Markus Armbruster <armbru@redhat.com>
CC: <ankita@nvidia.com>, <marcel.apfelbaum@gmail.com>, <philmd@linaro.org>,
	<mst@redhat.com>, <qemu-devel@nongnu.org>, Dave Jiang <dave.jiang@intel.com>,
	Huang Ying <ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
	<eduardo@habkost.net>, <imammedo@redhat.com>, <linux-cxl@vger.kernel.org>,
	<linuxarm@huawei.com>, Michael Roth <michael.roth@amd.com>, Ani Sinha
	<anisinha@redhat.com>
Subject: Re: [PATCH 3/6] hw/acpi: Generic Port Affinity Structure support
Message-ID: <20240429185046.00002a7c@Huawei.com>
In-Reply-To: <87r0ewcppm.fsf@pond.sub.org>
References: <20240403102927.31263-1-Jonathan.Cameron@huawei.com>
 <20240403102927.31263-4-Jonathan.Cameron@huawei.com>
 <87r0ewcppm.fsf@pond.sub.org>
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
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 23 Apr 2024 12:56:21 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:
> 
> > These are very similar to the recently added Generic Initiators
> > but instead of representing an initiator of memory traffic they
> > represent an edge point beyond which may lie either targets or
> > initiators.  Here we add these ports such that they may
> > be targets of hmat_lb records to describe the latency and
> > bandwidth from host side initiators to the port.  A descoverable
> > mechanism such as UEFI CDAT read from CXL devices and switches
> > is used to discover the remainder fo the path and the OS can build
> > up full latency and bandwidth numbers as need for work and data
> > placement decisions.
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Hi Markus,

I've again managed a bad job of defining an interface - thanks for
your help!

> > ---
> >  qapi/qom.json                            |  18 +++
> >  include/hw/acpi/acpi_generic_initiator.h |  18 ++-
> >  include/hw/pci/pci_bridge.h              |   1 +
> >  hw/acpi/acpi_generic_initiator.c         | 141 +++++++++++++++++------
> >  hw/pci-bridge/pci_expander_bridge.c      |   1 -
> >  5 files changed, 141 insertions(+), 38 deletions(-)
> >
> > diff --git a/qapi/qom.json b/qapi/qom.json
> > index 85e6b4f84a..5480d9ca24 100644
> > --- a/qapi/qom.json
> > +++ b/qapi/qom.json
> > @@ -826,6 +826,22 @@
> >    'data': { 'pci-dev': 'str',
> >              'node': 'uint32' } }
> >  
> > +
> > +##
> > +# @AcpiGenericPortProperties:
> > +#
> > +# Properties for acpi-generic-port objects.
> > +#
> > +# @pci-bus: PCI bus of the hostbridge associated with this SRAT entry  
> 
> What's this exactly?  A QOM path?  A qdev ID?  Something else?

QOM path I believe as going to call object_resolve_path_type() on it.
Oddity is it's defined for the bus, not the host bridge that
we care about as the host bridge doesn't have a convenient id to let
us identify it.

e.g. It is specified via --device pxb-cxl,id=XXXX
of TYPE_PXB_CXL_HOST in the command line but ends up on the
TYPE_PCI_BUS with parent set to the PXB_CXL_HOST.
Normally we just want this bus for hanging root ports of it.

I can clarify it's the QOM path but I'm struggling a bit to explain
the relationship without resorting to an example.
This should also not mention SRAT as at some stage I'd expect DT
bindings to provide similar functionality.


> 
> > +#
> > +# @node: numa node associated with the PCI device  
> 
> NUMA
> 
> Is this a NUMA node ID?

Fair question with a non obvious answer.  ACPI wise it's a proximity domain.
In every other SRAT entry (which define proximity domains) this does map
to a NUMA node in an operating system as they contain at least either some
form of memory access initiator (CPU, Generic Initiator etc) or a target (memory).

A Generic Port is subtly different in that it defines a proximity domain
that in of itself is not what we'd think of as a NUMA node but
rather an entity that exists to provide the info to the OS to stitch
together non discoverable and discoverable buses.

So I should have gone with something more specific. Could add this to
the parameter docs, or is it too much?

@node: Similar to a NUMA node ID, but instead of providing a reference
       point used for defining NUMA distances and access characteristics
       to memory or from an initiator (e.g. CPU), this node defines the
       boundary point between non discoverable system buses which must be
       discovered from firmware, and a discoverable bus.  NUMA distances
       and access characteristics are defined to and from that point,
       but for system software to establish full initiator to target
       characteristics this information must be combined with information
       retrieved form the discoverable part of the path.  An example would
       use CDAT information read from devices and switches in conjunction
       with link characteristics read from PCIe Configuration space.




> 
> > +#
> > +# Since: 9.1
> > +##
> > +{ 'struct': 'AcpiGenericPortProperties',
> > +  'data': { 'pci-bus': 'str',
> > +            'node': 'uint32' } }
> > +
> >  ##
> >  # @RngProperties:
> >  #
> > @@ -944,6 +960,7 @@
> >  { 'enum': 'ObjectType',
> >    'data': [
> >      'acpi-generic-initiator',
> > +    'acpi-generic-port',
> >      'authz-list',
> >      'authz-listfile',
> >      'authz-pam',
> > @@ -1016,6 +1033,7 @@
> >    'discriminator': 'qom-type',
> >    'data': {
> >        'acpi-generic-initiator':     'AcpiGenericInitiatorProperties',
> > +      'acpi-generic-port':          'AcpiGenericPortProperties',
> >        'authz-list':                 'AuthZListProperties',
> >        'authz-listfile':             'AuthZListFileProperties',
> >        'authz-pam':                  'AuthZPAMProperties',  
> 
> [...]
> 
> 

