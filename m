Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E903EC433F5
	for <linux-cxl@archiver.kernel.org>; Tue, 25 Jan 2022 15:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241786AbiAYPxi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 25 Jan 2022 10:53:38 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4513 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1582372AbiAYPtZ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 25 Jan 2022 10:49:25 -0500
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JjrlM0Qctz689JV;
        Tue, 25 Jan 2022 23:45:03 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 25 Jan 2022 16:49:19 +0100
Received: from localhost (10.47.76.154) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 25 Jan
 2022 15:49:18 +0000
Date:   Tue, 25 Jan 2022 15:49:13 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
CC:     <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        "Peter Maydell" <peter.maydell@linaro.org>, <linuxarm@huawei.com>,
        "Shameerali Kolothum Thodi" <shameerali.kolothum.thodi@huawei.com>,
        Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        Samarth Saxena <samarths@cadence.com>,
        "Dan Williams" <dan.j.williams@intel.com>
Subject: Re: [PATCH v4 00/42] CXl 2.0 emulation Support
Message-ID: <20220125154912.00005a81@Huawei.com>
In-Reply-To: <871r0vewkw.fsf@linaro.org>
References: <20220124171705.10432-1-Jonathan.Cameron@huawei.com>
 <871r0vewkw.fsf@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.47.76.154]
X-ClientProxiedBy: lhreml748-chm.china.huawei.com (10.201.108.198) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 25 Jan 2022 13:55:29 +0000
Alex Bennée <alex.bennee@linaro.org> wrote:

Hi Alex,

Thanks for taking a look so quickly!

> Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:
> 
> > Previous version was RFC v3: CXL 2.0 Support.
> > No longer an RFC as I would consider the vast majority of this
> > to be ready for detailed review. There are still questions called
> > out in some patches however.
> >
> > Looking in particular for:
> > * Review of the PCI interactions
> > * x86 and ARM machine interactions (particularly the memory maps)
> > * Review of the interleaving approach - is the basic idea
> >   acceptable?
> > * Review of the command line interface.
> > * CXL related review welcome but much of that got reviewed
> >   in earlier versions and hasn't changed substantially.
> >  
> <snip>
> >
> > Why do we want QEMU emulation of CXL?
> >
> > As Ben stated in V3, QEMU support has been critical to getting OS
> > software written given lack of availability of hardware supporting the
> > latest CXL features (coupled with very high demand for support being
> > ready in a timely fashion). What has become clear since Ben's v3
> > is that situation is a continuous one.  Whilst we can't talk about
> > them yet, CXL 3.0 features and OS support have been prototyped on
> > top of this support and a lot of the ongoing kernel work is being
> > tested against these patches.  
> 
> Is the core CXL support already in the upstream kernel or do you need a
> patched one?

Most of support is upstream for those features we are emulating so far,
but a few elements are still work in progress.

The interleave feature has had a couple of revisions on list and
Dan Williams posted a new version of that yesterday.

https://lore.kernel.org/linux-cxl/164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com/T/#t

I haven't tested that version yet but will get to that shortly,
this was done against the previous version on list.
I would expect this feature to go in this kernel cycle.
 
> 
> > Other features on the qemu-list that build on these include PCI-DOE
> > /CDAT support from the Avery Design team further showing how this
> > code is useful.  Whilst not directly related this is also the test
> > platform for work on PCI IDE/CMA + related DMTF SPDM as CXL both
> > utilizes and extends those technologies and is likely to be an early
> > adopter.
> > Refs:
> > CMA Kernel: https://lore.kernel.org/all/20210804161839.3492053-1-Jonathan.Cameron@huawei.com/
> > CMA Qemu: https://lore.kernel.org/qemu-devel/1624665723-5169-1-git-send-email-cbrowy@avery-design.com/
> > DOE Qemu: https://lore.kernel.org/qemu-devel/1623329999-15662-1-git-send-email-cbrowy@avery-design.com/
> >
> >
> > As can be seen there is non trivial interaction with other areas of
> > Qemu, particularly PCI and keeping this set up to date is proving
> > a burden we'd rather do without :)
> >
> > Ben mentioned a few other good reasons in v3:
> > https://lore.kernel.org/qemu-devel/20210202005948.241655-1-ben.widawsky@intel.com/
> >
> > The evolution of this series perhaps leave it in a less than
> > entirely obvious order and that may get tidied up in future postings.
> > I'm also open to this being considered in bite sized chunks.  What
> > we have here is about what you need for it to be useful for testing
> > currently kernel code.  
> 
> Ah right...
> 
> > All comments welcome.
> >
> > Ben - I lifted one patch from your git tree that didn't have a
> > Sign-off.   hw/cxl/component Add a dumb HDM decoder handler
> > Could you confirm you are happy for one to be added?
> >
> > Example of new command line (with virt ITS patches ;)  
> 
> One thing I think is missing in this series is some documentation. We've
> been historically bad at adding it for new devices but given the
> complexity of CXL I think we should certainly try to improve. I think a
> reasonable stab could be made from the commit messages in the series. I
> would suggest:
> 
>   docs/system/devices/cxl.rst
> 
> And include:
> 
>   - an brief overview of CXL
>   - kernel config options

Sure. Good idea, I'll write something up.

> 
> and an some example command lines, like bellow:
> 
> >
> > qemu-system-aarch64 -M virt,gic-version=3,cxl=on \
> >  -m 4g,maxmem=8G,slots=8 \
> >  ...
> >  -object memory-backend-file,id=cxl-mem1,share=on,mem-path=/tmp/cxltest.raw,size=256M,align=256M \
> >  -object memory-backend-file,id=cxl-mem2,share=on,mem-path=/tmp/cxltest2.raw,size=256M,align=256M \
> >  -object memory-backend-file,id=cxl-mem3,share=on,mem-path=/tmp/cxltest3.raw,size=256M,align=256M \
> >  -object memory-backend-file,id=cxl-mem4,share=on,mem-path=/tmp/cxltest4.raw,size=256M,align=256M \
> >  -object memory-backend-file,id=cxl-lsa1,share=on,mem-path=/tmp/lsa.raw,size=256M,align=256M \
> >  -object memory-backend-file,id=cxl-lsa2,share=on,mem-path=/tmp/lsa2.raw,size=256M,align=256M \
> >  -object memory-backend-file,id=cxl-lsa3,share=on,mem-path=/tmp/lsa3.raw,size=256M,align=256M \
> >  -object memory-backend-file,id=cxl-lsa4,share=on,mem-path=/tmp/lsa4.raw,size=256M,align=256M \
> >  -object memory-backend-file,id=tt,share=on,mem-path=/tmp/tt.raw,size=1g \
> >  -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
> >  -device pxb-cxl,bus_nr=222,bus=pcie.0,id=cxl.2 \
> >  -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
> >  -device cxl-type3,bus=root_port13,memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem0,size=256M \
> >  -device cxl-rp,port=1,bus=cxl.1,id=root_port14,chassis=0,slot=3 \
> >  -device cxl-type3,bus=root_port14,memdev=cxl-mem2,lsa=cxl-lsa2,id=cxl-pmem1,size=256M \
> >  -device cxl-rp,port=0,bus=cxl.2,id=root_port15,chassis=0,slot=5 \
> >  -device cxl-type3,bus=root_port15,memdev=cxl-mem3,lsa=cxl-lsa3,id=cxl-pmem2,size=256M \
> >  -device cxl-rp,port=1,bus=cxl.2,id=root_port16,chassis=0,slot=6 \
> >  -device cxl-type3,bus=root_port16,memdev=cxl-mem4,lsa=cxl-lsa4,id=cxl-pmem3,size=256M \
> >  -cxl-fixed-memory-window targets=cxl.1,size=4G,interleave-granularity=8k \
> >  -cxl-fixed-memory-window
> > targets=cxl.1,targets=cxl.2,size=4G,interleave-granularity=8k  
> 
> So AIUI the above creates some CXL pmem devices that are part of the CXL
> root bus which itself is on the PCIe bus? 

That is possibly because of the 'hack' that pxb (pci-expander-bridge)
does of pretending to be a root bus "on2 the pci bus (which I'm fairly
sure you can't actually do in real PCI).  Reality is that is just convenience for
QEMU rather than anything you'd see on a real system.  It's just easier
to use PXB for this as it works on various architectures.  From an OS point
of view there isn't a driver associated with the PXB device, instead its
just seen via ACPI description just like any other root bus.

The CXL root bus, in the sense of the one below which you can
conceive of CXL host bridges sitting is host specific and not visible on
the PCI bus.  It's effectively part of the system interconnect routing
the CXL memory read/write to the CXL root bridges.  That configuration is
considered static by the time any generic software sees it (early boot firmware
may do the actual setup in a similar fashion to a system address map
routing for multiple socket systems which is configured very early in boot and
isn't something we'd want to emulate).  The Fixed memory windows (CFMW) provide
a static description of a particularly region of Physical Address space
which will do interleaving across a predefined set of host bridges with
a particular interleave granularity.  They can also have QoS values, but
so far I've skipped that in the emulation so they are all in QOS group 0.
On real hardware you'd likely have quite a lot of CFMWs to cover combinations
the OS might want to use - spanning a huge part of the physical address space.

Those CXL root bridges have spec defined controls over some features (
such as the interleave across the root ports below a particular root bridge)
and an existence in ACPI that is an extension of what is done for PCI root
bridges.

The CXL root ports are visible as PCI topology as are the CXL devices below
them, including switches (which this patch set doesn't currently support)

From a Linux point of view we end up with two parallel topologies for
CXL and PCI with cross points where the two line up (there end up being
quite a few elements in CXL that don't exist in the PCI topology
representation).

> Is the intention that
> reads/writes into the pmem by the guest end up visible in various forms
> in the memory backend files? 

Yes.  That's how I've been testing it so far. It's very nice to be
able to prefill the files and hence know you are reading the location
you expect.

> Are memory backends required or can the
> address space be treated as volatile RAM that doesn't persist beyond a
> reset/reboot?

We could potentially do that though it would limit testing somewhat, particularly
when we come to label storage area (LSA) based setup which will "describe" the
topology of a previous boot. It's hard to test something that is
pretending to be persistent memory without being able to have the contents
persist across boot.

> 
> Maybe a simple diagram will help make things clearer?

Sure - I'll give it a go though it won't be particularly simple!

Comments welcome as I would expect this will end up as part of
the documentation.

Memory Address Map for CXL elements.  Note where exactly these regions
appear is Arch and platform dependent.  

  Base somewhere far up in the Host PA map.
_______________________________
|                              |
| CXL Host Bridge 0 Registers  | 
| CXL Host Bridge 1 Registers  |
|       ...                    |  This bit is normal MMIO register space.
| CXL Host bridge N registers  |  including programmable interleave decoders 
|______________________________|  for interleave across root ports.
|                              |
              ....     
|                              |
|______________________________|
|                              |
|   CFMW 0,                    |  Note that there can be multiple regions
|   Interleave 2 way, targets  |  of memory within this 1TB which can be
|   Hostbridge 0, Hostbridge 1 |  interleaved differently: in the host bridges
|   Granularity 16KiB, 1TB     |  across root ports or in switches below the root.
|______________________________|  ports
|                              |
|   CFMW 1,                    |
|   Interleave 1 way, target   |
|   Hostbridge 0, 512GiB       | 
|______________________________|
etc for all interleave combinations
configured, or built in to the
system before any generic software
sees it.

System Topology considering CFMW 0 only to keep this simple.
x marks the match in each decoder level
Switches have more interleave decoders and other features
that we haven't implemented yet in QEMU.

                Address Read to CFMW0 base + N
              _________________|________________
             |                                  |
             |  Host interconnect               |  
             |  Configured to route CFM         |
             |  memory access to particular HB  |
             |_____x____________________________|
                   |                     |
             Interleave Decoder          |
             Matches this HB             |  
                   |                     |
            _______|__________      _____|____________
           |                  |    |                  |
           | CXL HB 0         |    | CXL HB 1         | Only exist in PCI (mostly)
           | HB IntLv Decoder |    | HB IntLv Decoder | via ACPI description
           |  PCI Root Bus 0c |    | PCI Root Bus 0d  |
           |x_________________|    |__________________| In CXL have MMIO
            |                |       |               |  at location given in CEDT
            |                |       |               |  CHBS entry (ACPI)
____________|___   __________|__   __|_________   ___|_________ 
|  Root Port 0  | | Root Port 1 | | Root Port 2| | Root Port 3 |
|  Appears in   | | Appears in  | | Appears in | | Appear in   |
|  PCI topology | | PCI Topology| | PCI Topo   | | PCI Topo    |
|  As 0c:00.0   | | as 0c:01.0  | | as de:00.0 | | as de:01.0   |
|_______________| |_____________| |____________| |_____________|
      |                  |               |              |
      |                  |               |              |
 _____|_________   ______|______   ______|_____   ______|_______
|     x         | |             | |            | |              |
| CXL Type3 0   | | CXL Type3 1 | | CXL type3 2| | CLX Type 3 3 |
|               | |             | |            | |              |
| PMEM0(Vol LSA)| | PMEM1 (...) | | PMEM2 (...)| | PMEM3 (...)  |
| Decoder to go | |             | |            | |              |
| from host PA  | | PCI 0e:00.0 | | PCI df:00.0| | PCI e0:00.0  |
| to device PA  | |             | |            | |              | 
| PCI as 0d:00.0| |             | |            | |              |
|_______________| |_____________| |____________| |______________|

   Backed by        Backed by       Backed by       Backed by
    file 0           file 1           file 2          file 3

LSA backed by additional files for each device (not yet supported)

So currently we have decoders as follows for each interleaved access.
1) CFMW decoder - fixed config so forms part of qemu command line.
2) Host bridge decoders - programmable decoders that the system
   software will program either based on user command or based
   on info from the Label Storage Area (not yet emulated)
3) Type 3 device decoders. Down to here the address used is the
   Host PA.  These decoders convert to the local device PA
   (in simple case - drop some bits in the middle of the address)

Future patches will add decoders in switch upstream ports making
the above diagram have another layer between root ports and
the memory devices.

Note, we've focused for now on Persistent Memory devices as they are seen
as an early and important usecase (and are the most complex one).
But it should be straight forward to add volatile memory
support and indeed that would be backed by RAM.

lspci -tv for above shows

-+-[0000:00]-+-00.0 Red Hat, Inc. QEMU PCIe Host Bridge (this is the cxl PXB)f
 |           \-OTHER STUFF
 +-[0000:0c]-+-00.0-[0d]----00.0  Intel Corporation Device 0d93
 |           \-01.0-[0e]----00.0  Intel Corporation Device 0d93
 \-[0000:de]-+-00.0-[df]----00.0  Intel Corporation Device 0d93
             \-01.0-[e0]----00.0  Intel Corporation Device 0d93

Where those Intel parts are the type 3 devices.

So everything should now be as clear as mud.

Thanks,

Jonathan


> 
> >
> > First CFMWS suitable for 2 way interleave, the second for 4 way (2 way
> > at host level and 2 way at the host bridge).
> > targets=<range of pxb-cxl uids> , multiple entries if range is disjoint.
> >  
> <snip>
> 

