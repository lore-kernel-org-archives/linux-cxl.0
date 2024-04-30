Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF094199AD
	for <linux-cxl@vger.kernel.org>; Tue, 30 Apr 2024 06:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714460123; cv=none; b=Z1JW0FdaHirkna9SoN+/corYOQArsnsNklJS2rUN30mJzsszJc3jdpRjhnd7lKFM0LCA8jd1WdHN7Nt4dgzJz0L40ukdi1dxhDEai2UFoD11ZMCTdg1j9IAdTEUJbU9+Zi9XtOjG6Oz52HC5m19Iq9qDqlX/3jghs0G3S14FIw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714460123; c=relaxed/simple;
	bh=ziRQrdBmN1fA8a1NWrD+P7gdayvrZUEpYEYLcVJN7RI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bfoW3PARp5EO4NY3o61ntUKVelfZCMqCnmZWDW33eYvJf+VJ5Z0yDXLAZt7eT9C33T82EXWZaqJTkUkEYd5aenOnswdF/oHzKiPmRaGjBkqD/Bjq0mEl9y4iQKtkWRUS0oCYkZAT5k9mtrKpJQ6gq5bnha326hc+t+cDVKcftB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d1gIZ+3D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d1gIZ+3D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714460120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bubZGyS4WO89HecUmrs6HvGAjmtFDOhiVexXEzIIK8o=;
	b=d1gIZ+3DM4lGN4P9dBpGNd26RNCfOn8addmuM//a5DSwHKEo6QvT4XzSOsKrVQvHV6C4H0
	MKS4njBPIZWFBQ2v5ULpVPx/rHwg+p98LFUXqfmd8QDjTo1K9Y4i2H7B8fOHdcRMVvwimE
	UdLj6JPLcplPEpU9MslXH/o6vq3XYiA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-UzxNebrdOAKNkPJ4RPikDg-1; Tue, 30 Apr 2024 02:55:14 -0400
X-MC-Unique: UzxNebrdOAKNkPJ4RPikDg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4F6B818065B1;
	Tue, 30 Apr 2024 06:55:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D51041121306;
	Tue, 30 Apr 2024 06:55:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id F3AA721E66E5; Tue, 30 Apr 2024 08:55:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: <ankita@nvidia.com>,  <marcel.apfelbaum@gmail.com>,
  <philmd@linaro.org>,  <mst@redhat.com>,  <qemu-devel@nongnu.org>,  Dave
 Jiang <dave.jiang@intel.com>,  Huang Ying <ying.huang@intel.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  <eduardo@habkost.net>,
  <imammedo@redhat.com>,  <linux-cxl@vger.kernel.org>,
  <linuxarm@huawei.com>,  Michael Roth <michael.roth@amd.com>,  Ani Sinha
 <anisinha@redhat.com>
Subject: Re: [PATCH 3/6] hw/acpi: Generic Port Affinity Structure support
In-Reply-To: <20240429185046.00002a7c@Huawei.com> (Jonathan Cameron's message
	of "Mon, 29 Apr 2024 18:50:46 +0100")
References: <20240403102927.31263-1-Jonathan.Cameron@huawei.com>
	<20240403102927.31263-4-Jonathan.Cameron@huawei.com>
	<87r0ewcppm.fsf@pond.sub.org> <20240429185046.00002a7c@Huawei.com>
Date: Tue, 30 Apr 2024 08:55:12 +0200
Message-ID: <87frv3e3vz.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Jonathan Cameron <Jonathan.Cameron@Huawei.com> writes:

> On Tue, 23 Apr 2024 12:56:21 +0200
> Markus Armbruster <armbru@redhat.com> wrote:
>
>> Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:
>> 
>> > These are very similar to the recently added Generic Initiators
>> > but instead of representing an initiator of memory traffic they
>> > represent an edge point beyond which may lie either targets or
>> > initiators.  Here we add these ports such that they may
>> > be targets of hmat_lb records to describe the latency and
>> > bandwidth from host side initiators to the port.  A descoverable
>> > mechanism such as UEFI CDAT read from CXL devices and switches
>> > is used to discover the remainder fo the path and the OS can build
>> > up full latency and bandwidth numbers as need for work and data
>> > placement decisions.
>> >
>> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Hi Markus,
>
> I've again managed a bad job of defining an interface - thanks for
> your help!

Good interfaces are hard!

>> > ---
>> >  qapi/qom.json                            |  18 +++
>> >  include/hw/acpi/acpi_generic_initiator.h |  18 ++-
>> >  include/hw/pci/pci_bridge.h              |   1 +
>> >  hw/acpi/acpi_generic_initiator.c         | 141 +++++++++++++++++------
>> >  hw/pci-bridge/pci_expander_bridge.c      |   1 -
>> >  5 files changed, 141 insertions(+), 38 deletions(-)
>> >
>> > diff --git a/qapi/qom.json b/qapi/qom.json
>> > index 85e6b4f84a..5480d9ca24 100644
>> > --- a/qapi/qom.json
>> > +++ b/qapi/qom.json
>> > @@ -826,6 +826,22 @@
>> >    'data': { 'pci-dev': 'str',
>> >              'node': 'uint32' } }
>> >  
>> > +
>> > +##
>> > +# @AcpiGenericPortProperties:
>> > +#
>> > +# Properties for acpi-generic-port objects.
>> > +#
>> > +# @pci-bus: PCI bus of the hostbridge associated with this SRAT entry  
>> 
>> What's this exactly?  A QOM path?  A qdev ID?  Something else?
>
> QOM path I believe as going to call object_resolve_path_type() on it.

QOM path then.

> Oddity is it's defined for the bus, not the host bridge that
> we care about as the host bridge doesn't have a convenient id to let
> us identify it.
>
> e.g. It is specified via --device pxb-cxl,id=XXXX
> of TYPE_PXB_CXL_HOST in the command line but ends up on the
> TYPE_PCI_BUS with parent set to the PXB_CXL_HOST.
> Normally we just want this bus for hanging root ports of it.
>
> I can clarify it's the QOM path but I'm struggling a bit to explain
> the relationship without resorting to an example.
> This should also not mention SRAT as at some stage I'd expect DT
> bindings to provide similar functionality.

Let's start with an example.  Not to put it into the doc comment, only
to help me understand what you need.  Hopefully I can then assist with
improving the interface and/or its documentation.

>> > +#
>> > +# @node: numa node associated with the PCI device  
>> 
>> NUMA
>> 
>> Is this a NUMA node ID?
>
> Fair question with a non obvious answer.  ACPI wise it's a proximity domain.
> In every other SRAT entry (which define proximity domains) this does map
> to a NUMA node in an operating system as they contain at least either some
> form of memory access initiator (CPU, Generic Initiator etc) or a target (memory).
>
> A Generic Port is subtly different in that it defines a proximity domain
> that in of itself is not what we'd think of as a NUMA node but
> rather an entity that exists to provide the info to the OS to stitch
> together non discoverable and discoverable buses.
>
> So I should have gone with something more specific. Could add this to
> the parameter docs, or is it too much?
>
> @node: Similar to a NUMA node ID, but instead of providing a reference
>        point used for defining NUMA distances and access characteristics
>        to memory or from an initiator (e.g. CPU), this node defines the
>        boundary point between non discoverable system buses which must be
>        discovered from firmware, and a discoverable bus.  NUMA distances
>        and access characteristics are defined to and from that point,
>        but for system software to establish full initiator to target
>        characteristics this information must be combined with information
>        retrieved form the discoverable part of the path.  An example would
>        use CDAT information read from devices and switches in conjunction
>        with link characteristics read from PCIe Configuration space.

This is mostly greek to me :)  Bit I don't think it's too much.

>> > +#
>> > +# Since: 9.1
>> > +##
>> > +{ 'struct': 'AcpiGenericPortProperties',
>> > +  'data': { 'pci-bus': 'str',
>> > +            'node': 'uint32' } }
>> > +
>> >  ##
>> >  # @RngProperties:
>> >  #
>> > @@ -944,6 +960,7 @@
>> >  { 'enum': 'ObjectType',
>> >    'data': [
>> >      'acpi-generic-initiator',
>> > +    'acpi-generic-port',
>> >      'authz-list',
>> >      'authz-listfile',
>> >      'authz-pam',
>> > @@ -1016,6 +1033,7 @@
>> >    'discriminator': 'qom-type',
>> >    'data': {
>> >        'acpi-generic-initiator':     'AcpiGenericInitiatorProperties',
>> > +      'acpi-generic-port':          'AcpiGenericPortProperties',
>> >        'authz-list':                 'AuthZListProperties',
>> >        'authz-listfile':             'AuthZListFileProperties',
>> >        'authz-pam':                  'AuthZPAMProperties',  
>> 
>> [...]
>> 
>> 

