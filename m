Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16690266A7
	for <linux-cxl@vger.kernel.org>; Tue,  4 Jun 2024 13:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717508635; cv=none; b=QE3P7mgmD6dHwTXyf5nNJHegG99wfhznKxcTVhIuLQUYgizx3ZxC4+NvKl10V9hucaJhYur25dyMzXGq+lMD1GnrjEYP6hgAUZ1uUJsRPhtLw4msa1FjQp6EaCNWW9z3UV92vBH+JlRj3DUlj0SH1sUusgpGlkUMllc+pTyTSzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717508635; c=relaxed/simple;
	bh=EzqCNuHCHnLgrwL7+hqEnas9q2TZeLqU6p3VVjb9gFU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qawtyjO0Y20bB+tTN/LS6v4nGK4x2wHKkC68H5ibAwf3746oB/aKTOXfRxNLJ0aHNDMZfTrT1uhMA/ymrYG+AePpUvjLCJ4JBC3YbzLO+9YwzHECktK0PVdJXkKdQL7sLXvEUn1IPNwjol3uAX+zwwyquvCIMQxM4WlAas/tDRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VtsC86BwHz67HtH;
	Tue,  4 Jun 2024 21:39:32 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 7EB37140736;
	Tue,  4 Jun 2024 21:43:48 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 4 Jun
 2024 14:43:46 +0100
Date: Tue, 4 Jun 2024 14:42:02 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Markus Armbruster <armbru@redhat.com>
CC: <ankita@nvidia.com>, <marcel.apfelbaum@gmail.com>, <philmd@linaro.org>,
	<mst@redhat.com>, <qemu-devel@nongnu.org>, Dave Jiang <dave.jiang@intel.com>,
	Huang Ying <ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
	<eduardo@habkost.net>, <imammedo@redhat.com>, <linux-cxl@vger.kernel.org>,
	<linuxarm@huawei.com>, Michael Roth <michael.roth@amd.com>, Ani Sinha
	<anisinha@redhat.com>
Subject: Re: [PATCH 3/6] hw/acpi: Generic Port Affinity Structure support
Message-ID: <20240604144038.000020bd@huawei.com>
In-Reply-To: <87r0dc7vz6.fsf@pond.sub.org>
References: <20240403102927.31263-1-Jonathan.Cameron@huawei.com>
	<20240403102927.31263-4-Jonathan.Cameron@huawei.com>
	<87r0ewcppm.fsf@pond.sub.org>
	<20240429185046.00002a7c@Huawei.com>
	<87frv3e3vz.fsf@pond.sub.org>
	<20240430114353.00002ae5@huawei.com>
	<87r0dc7vz6.fsf@pond.sub.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 04 Jun 2024 14:06:53 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> Sorry for the late reply.  I had to put this aside, and I'm coming back
> to it only now.

No problem. Thanks for looking again!

> 
> Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:
> 
> > On Tue, 30 Apr 2024 08:55:12 +0200
> > Markus Armbruster <armbru@redhat.com> wrote:
> >  
> >> Jonathan Cameron <Jonathan.Cameron@Huawei.com> writes:
> >>   
> >> > On Tue, 23 Apr 2024 12:56:21 +0200
> >> > Markus Armbruster <armbru@redhat.com> wrote:
> >> >    
> >> >> Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:
> >> >>     
> >> >> > These are very similar to the recently added Generic Initiators
> >> >> > but instead of representing an initiator of memory traffic they
> >> >> > represent an edge point beyond which may lie either targets or
> >> >> > initiators.  Here we add these ports such that they may
> >> >> > be targets of hmat_lb records to describe the latency and
> >> >> > bandwidth from host side initiators to the port.  A descoverable
> >> >> > mechanism such as UEFI CDAT read from CXL devices and switches
> >> >> > is used to discover the remainder fo the path and the OS can build
> >> >> > up full latency and bandwidth numbers as need for work and data
> >> >> > placement decisions.
> >> >> >
> >> >> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>    
> >> >
> >> > Hi Markus,
> >> >
> >> > I've again managed a bad job of defining an interface - thanks for
> >> > your help!    
> >> 
> >> Good interfaces are hard!
> >>   
> >> >> > ---
> >> >> >  qapi/qom.json                            |  18 +++
> >> >> >  include/hw/acpi/acpi_generic_initiator.h |  18 ++-
> >> >> >  include/hw/pci/pci_bridge.h              |   1 +
> >> >> >  hw/acpi/acpi_generic_initiator.c         | 141 +++++++++++++++++------
> >> >> >  hw/pci-bridge/pci_expander_bridge.c      |   1 -
> >> >> >  5 files changed, 141 insertions(+), 38 deletions(-)
> >> >> >
> >> >> > diff --git a/qapi/qom.json b/qapi/qom.json
> >> >> > index 85e6b4f84a..5480d9ca24 100644
> >> >> > --- a/qapi/qom.json
> >> >> > +++ b/qapi/qom.json
> >> >> > @@ -826,6 +826,22 @@
> >> >> >    'data': { 'pci-dev': 'str',
> >> >> >              'node': 'uint32' } }
> >> >> >  
> >> >> > +
> >> >> > +##
> >> >> > +# @AcpiGenericPortProperties:
> >> >> > +#
> >> >> > +# Properties for acpi-generic-port objects.
> >> >> > +#
> >> >> > +# @pci-bus: PCI bus of the hostbridge associated with this SRAT entry      
> >> >> 
> >> >> What's this exactly?  A QOM path?  A qdev ID?  Something else?    
> >> >
> >> > QOM path I believe as going to call object_resolve_path_type() on it.    
> >> 
> >> QOM path then.
> >>   
> >> > Oddity is it's defined for the bus, not the host bridge that
> >> > we care about as the host bridge doesn't have a convenient id to let
> >> > us identify it.  
> 
> Copied from the example below:
> 
>     -object acpi-generic-port,id=bob11,pci-bus=cxl.1,node=2
> 
> where pci-bus=cxl.1 refers to
> 
>     -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true
> 
> What is "the host bridge that we care about" in that example?
> 
> Is pci-bus=cxl.1 a surrogate for a reference to "the host bridge that we
> care about"?  I.e. something that enables the C code to find the host
> bridge?
> 

Yes, That pci-bridge line results in the creation of two objects.
A host bridge and a bus below it (to which root ports etc are attached).
ID is associated with the bus.

As you say we are using it as a surrogate to get to the host bridge as
they always have a 1:1 relationship.

Why the ACPI spec defines the generic port as not refering to a port
but to a host bridge is beyond me, but unfortunately it does have
an explicit reference to that being the right thing to do in this case.


> >> > e.g. It is specified via --device pxb-cxl,id=XXXX
> >> > of TYPE_PXB_CXL_HOST in the command line but ends up on the
> >> > TYPE_PCI_BUS with parent set to the PXB_CXL_HOST.
> >> > Normally we just want this bus for hanging root ports of it.
> >> >
> >> > I can clarify it's the QOM path but I'm struggling a bit to explain
> >> > the relationship without resorting to an example.
> >> > This should also not mention SRAT as at some stage I'd expect DT
> >> > bindings to provide similar functionality.    
> >> 
> >> Let's start with an example.  Not to put it into the doc comment, only
> >> to help me understand what you need.  Hopefully I can then assist with
> >> improving the interface and/or its documentation.  
> >
> > Stripping out some relevant bits from a test setup and editing it down
> > - most of this is about creating relevant SLIT/HMAT tables.
> >
> > # First a CXL root bridge, root port and direct attached device plus fixed
> > # memory window.  Linux currently builds a NUMA node per fixed memory window
> > # but that's a simplification that may change over time.
> >  -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true \
> >  -device cxl-rp,port=0,bus=cxl.1,id=cxl_rp_port0,chassis=0,slot=2 \
> >  -device cxl-type3,bus=cxl_rp_port0,volatile-memdev=cxl-mem1,persistent-memdev=cxl-mem2,id=cxl-pmem1,lsa=cxl-lsa1,sn=3 \
> >  -machine cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=1k \
> >
> > # Next line is the port defintion - see that the pci-bus refers to the one in the id parameter for
> > # the PXB CXL, but the ACPI table that is generated refers to the DSDT entry via a ACPI0016 entry.
> > # So to get to that we use the PCI bus ID of the root bus that forms part of the root bridge (but
> > # is a child object in qemu.
> >  -numa node,nodeid=2 \
> >  -object acpi-generic-port,id=bob11,pci-bus=cxl.1,node=2 \
> >
> > # The rest is a the setup for the hmat and slit tables.  I hid most of the config, but
> > # left this here as key is that we specify values to and from the generic port 'node'
> > # but it's not really a node as such, but just a point along the path to one.
> >
> >  -numa dist,src=0,dst=0,val=10 -numa dist,src=0,dst=1,val=21 -numa dist,src=0,dst=2,val=21 -numa dist,src=0,dst=3,val=21 -numa dist,src=0,dst=4,val=21 -numa dist,src=0,dst=5,val=21 \
> >  -numa dist,src=1,dst=0,val=21 -numa dist,src=1,dst=1,val=10 -numa dist,src=1,dst=2,val=21 -numa dist,src=1,dst=3,val=21 -numa dist,src=1,dst=4,val=21 -numa dist,src=1,dst=5,val=21 \
> >  -numa dist,src=2,dst=0,val=21 -numa dist,src=2,dst=1,val=21 -numa dist,src=2,dst=2,val=10 -numa dist,src=2,dst=3,val=21 -numa dist,src=2,dst=4,val=21 -numa dist,src=2,dst=5,val=21 \
> >  -numa dist,src=3,dst=0,val=21 -numa dist,src=3,dst=1,val=21 -numa dist,src=3,dst=2,val=21 -numa dist,src=3,dst=3,val=10 -numa dist,src=3,dst=4,val=21 -numa dist,src=3,dst=5,val=21 \
> >  -numa dist,src=4,dst=0,val=21 -numa dist,src=4,dst=1,val=21 -numa dist,src=4,dst=2,val=21 -numa dist,src=4,dst=3,val=21 -numa dist,src=4,dst=4,val=10 -numa dist,src=4,dst=5,val=21 \
> >  -numa dist,src=5,dst=0,val=21 -numa dist,src=5,dst=1,val=21 -numa dist,src=5,dst=2,val=21 -numa dist,src=5,dst=3,val=21 -numa dist,src=5,dst=4,val=21 -numa dist,src=5,dst=5,val=10 \
> >  -numa hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-latency,latency=10 \
> >  -numa hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-bandwidth,bandwidth=800M \
> >  -numa hmat-lb,initiator=0,target=2,hierarchy=memory,data-type=access-latency,latency=100 \
> >  -numa hmat-lb,initiator=0,target=2,hierarchy=memory,data-type=access-bandwidth,bandwidth=200M \
> >  -numa hmat-lb,initiator=0,target=4,hierarchy=memory,data-type=access-latency,latency=100 \
> >  -numa hmat-lb,initiator=0,target=4,hierarchy=memory,data-type=access-bandwidth,bandwidth=200M \
> >  -numa hmat-lb,initiator=0,target=5,hierarchy=memory,data-type=access-latency,latency=200 \
> >  -numa hmat-lb,initiator=0,target=5,hierarchy=memory,data-type=access-bandwidth,bandwidth=400M \
> >  -numa hmat-lb,initiator=1,target=0,hierarchy=memory,data-type=access-latency,latency=500 \
> >  -numa hmat-lb,initiator=1,target=0,hierarchy=memory,data-type=access-bandwidth,bandwidth=100M \
> >  -numa hmat-lb,initiator=1,target=2,hierarchy=memory,data-type=access-latency,latency=50 \
> >  -numa hmat-lb,initiator=1,target=2,hierarchy=memory,data-type=access-bandwidth,bandwidth=400M \
> >  -numa hmat-lb,initiator=1,target=4,hierarchy=memory,data-type=access-latency,latency=50 \
> >  -numa hmat-lb,initiator=1,target=4,hierarchy=memory,data-type=access-bandwidth,bandwidth=800M \
> >  -numa hmat-lb,initiator=1,target=5,hierarchy=memory,data-type=access-latency,latency=500 \
> >  -numa hmat-lb,initiator=1,target=5,hierarchy=memory,data-type=access-bandwidth,bandwidth=100M \
> >   -numa hmat-lb,initiator=3,target=0,hierarchy=memory,data-type=access-latency,latency=20 \
> >  -numa hmat-lb,initiator=3,target=0,hierarchy=memory,data-type=access-bandwidth,bandwidth=400M \
> >  -numa hmat-lb,initiator=3,target=2,hierarchy=memory,data-type=access-latency,latency=80 \
> >  -numa hmat-lb,initiator=3,target=2,hierarchy=memory,data-type=access-bandwidth,bandwidth=200M \
> >  -numa hmat-lb,initiator=3,target=4,hierarchy=memory,data-type=access-latency,latency=80 \
> >  -numa hmat-lb,initiator=3,target=4,hierarchy=memory,data-type=access-bandwidth,bandwidth=200M \
> >  -numa hmat-lb,initiator=3,target=5,hierarchy=memory,data-type=access-latency,latency=20 \
> >  -numa hmat-lb,initiator=3,target=5,hierarchy=memory,data-type=access-bandwidth,bandwidth=400M \
> >  -numa hmat-lb,initiator=5,target=0,hierarchy=memory,data-type=access-latency,latency=20 \
> >  -numa hmat-lb,initiator=5,target=0,hierarchy=memory,data-type=access-bandwidth,bandwidth=400M \
> >  -numa hmat-lb,initiator=5,target=2,hierarchy=memory,data-type=access-latency,latency=80 \
> >  -numa hmat-lb,initiator=5,target=4,hierarchy=memory,data-type=access-bandwidth,bandwidth=200M \
> >  -numa hmat-lb,initiator=5,target=4,hierarchy=memory,data-type=access-latency,latency=80 \
> >  -numa hmat-lb,initiator=5,target=2,hierarchy=memory,data-type=access-bandwidth,bandwidth=200M \
> >  -numa hmat-lb,initiator=5,target=5,hierarchy=memory,data-type=access-latency,latency=10 \
> >  -numa hmat-lb,initiator=5,target=5,hierarchy=memory,data-type=access-bandwidth,bandwidth=800M  
> 
> Uff!
> 
> Could you throw in output of "info qom-tree /"?
> 

This isn't exactly the setup above, but I happen to have it running and it's
hopefully close enough. I've tried to crop only the definitely irrelevant parts
out.  I'm having one of those days where for some reason my terminal is
messing up whitespace. Hopefully reconstructed correctly enough.

Deep in here you'll see

/device[64] (pxb-cxl-host)
  /.cache_mem[0] (memory-region)
  /.io[0] (memory-region)
  /cxl.1 (pxb-cxl-bus)
  /pxb-cxl-host[0] (memory-region)
which is what I want to get and
 /cxl.1 (pxb-cxl)
   /bus master container[0] (memory-region)
   /bus master[0] (memory-region)
which is what I can get.

Anyhow lots more follows.

/(container)

...

  /machine (virt-9.1-machine)
    /cxl-fixed-memory-region[0] (memory-region)
    /cxl-fixed-memory-region[1] (memory-region)
    /cxl_host_reg[0] (memory-region)
...
    /peripheral (container)
...
      /cxl-pmem1 (cxl-type3)
        /.cache_mem[0] (memory-region)
        /.io[0] (memory-region)
        /bus master container[0] (memory-region)
        /bus master[0] (memory-region)
        /cap-array[0] (memory-region)
        /cpmu0-registers[0] (memory-region)
        /cpmu1-registers[0] (memory-region)
        /cxl-type3-msix[0] (memory-region)
        /cxl-type3[0] (memory-region)
        /device-registers[0] (memory-region)
        /device-status[0] (memory-region)
        /mailbox[0] (memory-region)
        /memory device caps[0] (memory-region)
        /msix-pba[0] (memory-region)
        /msix-table[0] (memory-region)
      /cxl-pmem2 (cxl-type3)
        /.cache_mem[0] (memory-region)
        /.io[0] (memory-region)
        /bus master container[0] (memory-region)
        /bus master[0] (memory-region)
        /cap-array[0] (memory-region)
        /cpmu0-registers[0] (memory-region)
        /cpmu1-registers[0] (memory-region)
        /cxl-type3-msix[0] (memory-region)
        /cxl-type3[0] (memory-region)
        /device-registers[0] (memory-region)
        /device-status[0] (memory-region)
        /mailbox[0] (memory-region)
        /memory device caps[0] (memory-region)
        /msix-pba[0] (memory-region)
        /msix-table[0] (memory-region)
      /cxl.1 (pxb-cxl)
        /bus master container[0] (memory-region)
        /bus master[0] (memory-region)
      /cxl_rp_port0 (cxl-rp)
        /.cache_mem[0] (memory-region)
        /.io[0] (memory-region)
        /bus master container[0] (memory-region)
        /bus master[0] (memory-region)
        /cpmu0-registers[0] (memory-region)
        /cxl-rp[0] (memory-region)
        /cxl_rp_port0 (CXL) 
        /pci_bridge_io[0] (memory-region)
        /pci_bridge_io[1] (memory-region)
        /pci_bridge_mem[0] (memory-region)
        /pci_bridge_pci[0] (memory-region)
        /pci_bridge_pref_mem[0] (memory-region)
        /pci_bridge_vga_io_hi[0] (memory-region)
        /pci_bridge_vga_io_lo[0] (memory-region)
        /pci_bridge_vga_mem[0] (memory-region)
        /registers[0] (memory-region)
      /cxl_rp_port1 (cxl-rp)
        /.cache_mem[0] (memory-region)
        /.io[0] (memory-region)
        /bus master container[0] (memory-region)
        /bus master[0] (memory-region) 
        /cpmu0-registers[0] (memory-region) 
        /cxl-rp[0] (memory-region)
        /cxl_rp_port1 (CXL)    
        /pci_bridge_io[0] (memory-region)  
        /pci_bridge_io[1] (memory-region) 
        /pci_bridge_mem[0] (memory-region)  
        /pci_bridge_pci[0] (memory-region)
        /pci_bridge_pref_mem[0] (memory-region)
        /pci_bridge_vga_io_hi[0] (memory-region)
        /pci_bridge_vga_io_lo[0] (memory-region)
        /pci_bridge_vga_mem[0] (memory-region)
        /registers[0] (memory-region) 
...
    /unattached (container)
....
      /device[64] (pxb-cxl-host)
        /.cache_mem[0] (memory-region)
        /.io[0] (memory-region)
        /cxl.1 (pxb-cxl-bus)
        /pxb-cxl-host[0] (memory-region)
...
      /device[8] (gpex-pcihost)
        /gpex_ioport[0] (memory-region)
        /gpex_ioport_window[0] (memory-region)
        /gpex_mmio[0] (memory-region)
        /gpex_mmio_window[0] (memory-region)
        /gpex_root (gpex-root)
          /bus master container[0] (memory-region)
          /bus master[0] (memory-region)
        /pcie-ecam[0] (memory-region)
        /pcie-mmcfg-mmio[0] (memory-region)
        /pcie-mmio-high[0] (memory-region)
        /pcie-mmio[0] (memory-region)
        /pcie.0 (PCIE)
...
  /objects (container)
    /bob11 (acpi-generic-port)
    /bob2 (acpi-generic-initiator
    /cxl-lsa1 (memory-backend-file)
      /cxl-lsa1[0] (memory-region)
    /cxl-lsa2 (memory-backend-file)
      /cxl-lsa2[0] (memory-region)
    /cxl-mem1 (memory-backend-file)
      /cxl-mem1[0] (memory-region)
    /cxl-mem2 (memory-backend-file)
      /cxl-mem2[0] (memory-region)
    /cxl-mem3 (memory-backend-file)
      /cxl-mem3[0] (memory-region)
    /cxl-mem4 (memory-backend-file)
      /cxl-mem4[0] (memory-region)
