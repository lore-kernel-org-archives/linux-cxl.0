Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C27374748;
	Thu, 19 Mar 2026 16:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773936400; cv=none; b=RP22JMs1NkBWDNBI0pXnFTUghqDwPflmkMc0RVuVvwsUJre0tYXG8z5432nLEFmRtDM9oU2tjObUk0mNO5qyDdzyXNarn3dTwMc9HqRvBZMzAEtJqjTktz84Ztt35yWf6DyqFPOSiyrT6LVJLJA25Y/ZTDxqjXe38mH5aJJ38wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773936400; c=relaxed/simple;
	bh=4MadkHBOiLfC8UfYRv0SGZ0RL3HEiB6Ui1CatO7GVvM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ky6eCzo+Ll2t+FBqdvaW5pqGfgLKDl4JGEhryCtywZ3H+9ibUu6V4MKit4fym1A/JNA+9c2NT17RlXxMq+2ZTuYyCfSNmd90+nfA0SV5BDc5iSB9X3eXKeu81Q2Ykb3IyYycVFTKxXW89FVg6lbKMUIGFRUPrEs5IjhSEdHjesE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fc9Xx3YDdzHnGdn;
	Fri, 20 Mar 2026 00:06:09 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 41EF040569;
	Fri, 20 Mar 2026 00:06:33 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 19 Mar
 2026 16:06:32 +0000
Date: Thu, 19 Mar 2026 16:06:30 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Alex Williamson <alex@shazbot.org>
CC: <mhonap@nvidia.com>, <aniketa@nvidia.com>, <ankita@nvidia.com>,
	<vsethi@nvidia.com>, <jgg@nvidia.com>, <mochs@nvidia.com>,
	<skolothumtho@nvidia.com>, <alejandro.lucero-palau@amd.com>,
	<dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <jgg@ziepe.ca>, <yishaih@nvidia.com>,
	<kevin.tian@intel.com>, <cjia@nvidia.com>, <targupta@nvidia.com>,
	<zhiw@nvidia.com>, <kjaju@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <kvm@vger.kernel.org>
Subject: Re: [PATCH 18/20] docs: vfio-pci: Document CXL Type-2 device
 passthrough
Message-ID: <20260319160630.00002c6d@huawei.com>
In-Reply-To: <20260317152445.67a93881@shazbot.org>
References: <20260311203440.752648-1-mhonap@nvidia.com>
	<20260311203440.752648-19-mhonap@nvidia.com>
	<20260313121341.00001bfa@huawei.com>
	<20260317152445.67a93881@shazbot.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Tue, 17 Mar 2026 15:24:45 -0600
Alex Williamson <alex@shazbot.org> wrote:

> On Fri, 13 Mar 2026 12:13:41 +0000
> Jonathan Cameron <jonathan.cameron@huawei.com> wrote:
> 
> > On Thu, 12 Mar 2026 02:04:38 +0530
> > mhonap@nvidia.com wrote:
> >   
> > > From: Manish Honap <mhonap@nvidia.com>
> > > ---
> > >  Documentation/driver-api/index.rst        |   1 +
> > >  Documentation/driver-api/vfio-pci-cxl.rst | 216 ++++++++++++++++++++++
> > >  2 files changed, 217 insertions(+)
> > >  create mode 100644 Documentation/driver-api/vfio-pci-cxl.rst
> > > 
> > > diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
> > > index 1833e6a0687e..7ec661846f6b 100644
> > > --- a/Documentation/driver-api/index.rst
> > > +++ b/Documentation/driver-api/index.rst    
> >   
> > >  
> > >  Bus-level documentation
> > >  =======================
> > > diff --git a/Documentation/driver-api/vfio-pci-cxl.rst b/Documentation/driver-api/vfio-pci-cxl.rst
> > > new file mode 100644
> > > index 000000000000..f2cbe2fdb036
> > > --- /dev/null
> > > +++ b/Documentation/driver-api/vfio-pci-cxl.rst    
> >   
> > > +Device Detection
> > > +----------------
> > > +
> > > +CXL Type-2 detection happens automatically when ``vfio-pci`` registers a
> > > +device that has:
> > > +
> > > +1. A CXL Device DVSEC capability (PCIe DVSEC Vendor ID 0x1E98, ID 0x0000).
> > > +2. Bit 2 (Mem_Capable) set in the CXL Capability register within that DVSEC.    
> > 
> > FWIW to be type 2 as opposed to a type 3 non class code device (e.g. the
> > compressed memory devices Gregory Price and others are using) you need
> > Cache_capable as well.  Might be worth making this all about
> > CXL Type-2 and non class code Type-3.
> >   
> > > +3. A PCI class code that is **not** ``0x050210`` (CXL Type-3 memory device).
> > > +4. An HDM Decoder block discoverable via the Register Locator DVSEC.
> > > +5. A pre-committed HDM decoder (BIOS/firmware programmed) with non-zero size.    
> > 
> > This is the bit that we need to make more general. Otherwise you'll have
> > to have a bios upgrade for every type 2 device (and no native hotplug).
> > Note native hotplug is quite likely if anyone is switch based device
> > pooling.
> > 
> > I assume that you are doing this today to get something upstream
> > and presume it works for the type 2 device you have on the host you
> > care about.  I'm not sure there are 'general' solutions but maybe
> > there are some heuristics or sufficient conditions for establishing the
> > size.
> > 
> > Type 2 might have any of:
> > - Conveniently preprogrammed HDM decoders (the case you use)
> > - Maximum of 2 HDM decoders + the same number of Range registers.
> >   In general the problem with range registers is they are a legacy feature
> >   and there are only 2 of them whereas a real device may have many more
> >   DPA ranges. In this corner case though, is it enough to give us the
> >   necessary sizes?  I think it might be but would like others familiar
> >   with the spec to confirm. (If needed I'll take this to the consortium
> >   for an 'official' view).
> > - A DOE and table access protocol.  CDAT should give us enough info to
> >   be fairly sure what is needed.
> > - A CXL mailbox (maybe the version in the PCI spec now) and the spec defined
> >   commands to query what is there.  Reading the intro to 8.2.10.9 Memory
> >   Device Command Sets, it's a little unclear on whether these are valid on
> >   non class code devices but I believe having the appropriate Mailbox
> >   type identifier is enough to say we expect to get them.
> > 
> > None of this is required though and the mailboxes are non trivial.
> > So personally I think we should propose a new DVSEC that provides any
> > info we need for generic passthrough.  Starting with what we need
> > to get the regions right.  Until something like that is in place we
> > will have to store this info somewhere.
> > 
> > There is (maybe) an alternative of doing the region allocation on demand.
> > That is emulate the HDM decoders in QEMU (on top of the emulation
> > here) and when settings corresponding to a region setup occur,
> > go request one from the CXL core. The problem is we can't guarantee
> > it will be available at that time. So we can 'guess' what to provide
> > to the VM in terms of CXL fixed memory windows, but short of heuristics
> > (either whole of the host offer, or divide it up based on devices present
> >  vs what is in the VM) that is going to be prone to it not being available
> > later.
> > 
> > Where do people think this should be?  We are going to end up with
> > a device list somewhere. Could be in kernel, or in QEMU or make it an
> > orchestrator problem (applying the 'someone else's problem' solution).  
> 
> That's the typical approach.  That's what we did with resizable BARs.
> If we cannot guarantee allocation on demand, we need to push the policy
> to the device, via something that indicates the size to use, or to the
> orchestration, via something that allows the size to be committed
> out-of-band.  As with REBAR, we then need to be able to restrict the
> guest behavior to select only the configured option.
> 
> I imagine this means for the non-pre-allocated case, we need to develop
> some sysfs attributes that allows that out-of-band sizing, which would
> then appear as a fixed, pre-allocated configuration to the guest.
> Thanks,

I did some reading as only vaguely familiar with how the resizeable bar stuff
was done. That approach should be fairly straight forward to adapt here.
Stash some config in struct pci_dev before binding vfio-pci/cxl via a sysfs
interface.  Given that the association with the CXL infrastructure only
happens later (unlike bar config) it would then be the job of the
vfio-pci/cxl driver to see what was requested and attempt to set up the
CXL topology to deliver it at bind time. 

Manesh, would you mind hack at small PoC on top of your existing code to see
if this approach shows up any problems?  I don't have anything to test against
right now, though could probably hack some emulation together fairly fast.
I'm thinking you'll get there faster!  I'm mostly focused on this cycle
stuff at the moment, and I suspect we'll be discussing this for a while
yet + it has dependencies on other series that aren't in yet.

I'm not sure the PCI folk will like us stashing random stuff in their
structures just because we haven't bound anything yet though so have no
CXL structures to use.  We should probably think about how VF CXL.mem
region/sub-region assignment might work as well.

Sticking to PF (well actually just function 0) passthrough for now...
For the guest, we can constrain things so there is only one right option
though it will limit what topologies we can build.  Basically each device
passed through has it's own CXL fixed memory window, it's own host bridge,
it's own root port + no switches.  The sizing it sees for the CFMWS
matches what we configured in the host.  We could program that topology up
and lock it down but that means VM BIOS nastiness so I'd leave it to the
native linux code to bring it up.  If anyone wants to do P2P it'll get
harder to do within the spec as we will have to prevent topologies that
contain foot guns like the ability to configure interleave.

This constrained approach is what we plan for the CXL class code type 3
device emulation used for DCD so we've been exploring it already.
It's still possible to do annoying things like zero size decoders +
skip. For now we can fail HDM decoder commits if they are particularly
non sensical and we haven't handled them yet - ultimately we'll probably
want to minimize what we refuse to handle as I'm sure 'other OS' may not
do things the same as Linux.

P2P and the fun of single device on multiple PCI heirarchies as to be solved
later. As an FYI, for bandwidth, people will be building devices that
interleave memory addresses over multiple root ports. Dan reminded
me of that challenge last night.  See bundled ports in CXL 4.0, though
this particular part related to CXL.mem is actually possible prior to
that stuff for CXL.cache.  Oh and don't get me started on TSP / coco challenges.
I take the view they are Dan's problem for now ;)

Jonathan


> 
> Alex

