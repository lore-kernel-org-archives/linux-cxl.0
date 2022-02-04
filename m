Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D0EC433F5
	for <linux-cxl@archiver.kernel.org>; Fri,  4 Feb 2022 18:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351557AbiBDSXV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 4 Feb 2022 13:23:21 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4680 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237893AbiBDSXU (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 4 Feb 2022 13:23:20 -0500
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Jr3mc6q4jz67Zjl;
        Sat,  5 Feb 2022 02:22:40 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 4 Feb 2022 19:23:17 +0100
Received: from localhost (10.47.31.86) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 4 Feb
 2022 18:23:16 +0000
Date:   Fri, 4 Feb 2022 18:23:11 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     <qemu-devel@nongnu.org>,
        Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
        Marcel Apfelbaum <marcel@redhat.com>,
        "Igor Mammedov" <imammedo@redhat.com>, <linux-cxl@vger.kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        <linuxarm@huawei.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Philippe =?ISO-8859-1?Q?Mathieu-D?= =?ISO-8859-1?Q?aud=E9?= 
        <f4bug@amsat.org>, Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        Samarth Saxena <samarths@cadence.com>,
        "Dan Williams" <dan.j.williams@intel.com>
Subject: Re: [PATCH v5 00/43] CXl 2.0 emulation Support
Message-ID: <20220204182311.00005fca@Huawei.com>
In-Reply-To: <20220204092633-mutt-send-email-mst@kernel.org>
References: <20220202141037.17352-1-Jonathan.Cameron@huawei.com>
        <20220204090141-mutt-send-email-mst@kernel.org>
        <20220204092633-mutt-send-email-mst@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.47.31.86]
X-ClientProxiedBy: lhreml724-chm.china.huawei.com (10.201.108.75) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 4 Feb 2022 09:27:08 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Fri, Feb 04, 2022 at 09:03:27AM -0500, Michael S. Tsirkin wrote:
> > On Wed, Feb 02, 2022 at 02:09:54PM +0000, Jonathan Cameron wrote:  
> > > Changes since v4:
> > > https://lore.kernel.org/linux-cxl/20220124171705.10432-1-Jonathan.Cameron@huawei.com/
> > > 
> > > Note documentation patch that Alex requested to follow.
> > > I don't want to delay getting this out as Alex mentioned possibly
> > > having time to continue reviewing in latter part of this week.
> > > 
> > > Issues identified by CI / Alex Bennée
> > > - Stubs added for hw/cxl/cxl-host and hw/acpi/cxl plus related meson
> > >   changes to use them as necessary.
> > > - Drop uid from cxl-test (result of last minute change in v4 that was not
> > >   carried through to the test)
> > > - Fix naming clash with field name ERROR which on some arches is defined
> > >   and results in the string being replaced with 0 in some of the
> > >   register field related defines.  Call it ERR instead.
> > > - Fix type issue around mr->size by using 64 bit acessor functions.
> > > - Add a new patch to exclude pxb-cxl from device-crash-test in similar
> > >   fashion to pxb.
> > > 
> > > CI tests now passing with exception of checkpatch which has what
> > > I think is a false positive and build-oss-fuzz which keeps timing out.
> > > https://gitlab.com/jic23/qemu/-/pipelines/460109208
> > > There were a few tweaks to patch descriptions after I pushed that
> > > out (I missed a few RB from Alex).  
> > 
> > There's an RFC patch that needs review from core memory maintainers,
> > so I guess not all of it is for merge just yet?

Yes, that patch definitely needs some input.  It 'works' but feels
like a bit of a hack and raises questions around that is what else
I might be breaking or whether the approach is maintainable long
term.

> > Is there any way we can start applying this patchset gradually?  
> 
> For example, pick up patches 1-13 for now? They seem to be ready ...

That would be great! but...

*embarased cough* It doesn't boot at patch 13 (with a pxb-cxl device),
I missed that fixing the reset problem that Alex pointed out in v4
would result in calling into some infrastructure that isn't hooked up
until we implement the host bridge MMIO in patch 18.  Fix is to
just move the reset implementation forwards to patch 18. In meantime, up to
patch 12 are fine.

The latter patches (after 13) are ordered in a less than ideal fashion.
To make it easier to take the rest gradually, they could (I think) be
reordered to give us

1) The device enablement (1-13 plus some later patches) 
   - type 3 device, pxb, root ports.  Mostly this is about dragging
    feature enablement earlier in the series.
   Should be fine to pick this up in several smaller chunks.
2) Host enablement for the root bridges on x86 and ARM.
3) The RFC bit around how to enable memory interleave.
   Until we advertise a fixed memory window there will be a missing
   component anyway so the OS won't try to enable the interleaving.

Will result in a few additional patches because we'll update
the CEDT ACPI table tests in two steps rather than just once.

I'll have a go at the reorg next week and clearly highlight in the
cover letter which steps make sense in applying gradually.
+ hit those steps with proper testing and at least check
it boots after each patch :( 

Thanks for taking a look and your advice on moving this
forwards.

Jonathan


> 
> >   
> > > Other changes (mostly from Alex's review)
> > > - Change component register handling to now report UNIMP and return 0
> > >   for 8 byte registers as we currently don't implement any of them.
> > >   Note that this means we need a kernel fix:
> > >   https://lore.kernel.org/linux-cxl/20220201153437.2873-1-Jonathan.Cameron@huawei.com/
> > > - Drop majority of the macros used in defining mailbox handlers in
> > >   favour of written out code.
> > > - Use REG64 where appropriate. This was introduced whilst this set
> > >   has been underdevelopment so I missed it.
> > > - Clarify some register access options wrt to CXL 2.0 Errata F4.
> > > - Change timestamp to qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL)
> > > - Use typed enums to enforce types of function arguements.
> > > - Default to cxl being off in machine_class_init() removing
> > >   need to set it to off in machines where there is no support as yet.
> > > - Add Alex's RB where given.
> > > 
> > > Looking in particular for:
> > > * Review of the PCI interactions
> > > * x86 and ARM machine interactions (particularly the memory maps)
> > > * Review of the interleaving approach - is the basic idea
> > >   acceptable?
> > > * Review of the command line interface.
> > > * CXL related review welcome but much of that got reviewed
> > >   in earlier versions and hasn't changed substantially.
> > > 
> > > Big TODOs:
> > > 
> > > * Interleave boundary issues. I haven't yet solved this but didn't
> > >   want to futher delay the review of the rest of the series.
> > > 
> > > * Volatile memory devices (easy but it's more code so left for now).
> > > * Switch support. Linux kernel support is under review currently,
> > >   so there is now something to test against.
> > > * Hotplug?  May not need much but it's not tested yet!
> > > * More tests and tighter verification that values written to hardware
> > >   are actually valid - stuff that real hardware would check.
> > > * Testing, testing and more testing.  I have been running a basic
> > >   set of ARM and x86 tests on this, but there is always room for
> > >   more tests and greater automation.
> > > * CFMWS flags as requested by Ben.
> > > 
> > > Why do we want QEMU emulation of CXL?
> > > 
> > > As Ben stated in V3, QEMU support has been critical to getting OS
> > > software written given lack of availability of hardware supporting the
> > > latest CXL features (coupled with very high demand for support being
> > > ready in a timely fashion). What has become clear since Ben's v3
> > > is that situation is a continuous one. Whilst we can't talk about
> > > them yet, CXL 3.0 features and OS support have been prototyped on
> > > top of this support and a lot of the ongoing kernel work is being
> > > tested against these patches. The kernel CXL mocking code allows
> > > some forms of testing, but QEMU provides a more versatile and
> > > exensible platform.
> > > 
> > > Other features on the qemu-list that build on these include PCI-DOE
> > > /CDAT support from the Avery Design team further showing how this
> > > code is useful. Whilst not directly related this is also the test
> > > platform for work on PCI IDE/CMA + related DMTF SPDM as CXL both
> > > utilizes and extends those technologies and is likely to be an early
> > > adopter.
> > > Refs:
> > > CMA Kernel: https://lore.kernel.org/all/20210804161839.3492053-1-Jonathan.Cameron@huawei.com/
> > > CMA Qemu: https://lore.kernel.org/qemu-devel/1624665723-5169-1-git-send-email-cbrowy@avery-design.com/
> > > DOE Qemu: https://lore.kernel.org/qemu-devel/1623329999-15662-1-git-send-email-cbrowy@avery-design.com/
> > > 
> > > As can be seen there is non trivial interaction with other areas of
> > > Qemu, particularly PCI and keeping this set up to date is proving
> > > a burden we'd rather do without :)
> > > 
> > > Ben mentioned a few other good reasons in v3:
> > > https://lore.kernel.org/qemu-devel/20210202005948.241655-1-ben.widawsky@intel.com/
> > > 
> > > The evolution of this series perhaps leave it in a less than
> > > entirely obvious order and that may get tidied up in future postings.
> > > I'm also open to this being considered in bite sized chunks.  What
> > > we have here is about what you need for it to be useful for testing
> > > currently kernel code.  Note the kernel code is moving fast so
> > > since v4, some features have been introduced we don't yet support in
> > > QEMU (e.g. use of the PCIe serial number extended capability).
> > > 
> > > All comments welcome.
> > > 
> > > qemu-system-aarch64 -M virt,gic-version=3,cxl=on \
> > >  -m 4g,maxmem=8G,slots=8 \
> > >  ...
> > >  -object memory-backend-file,id=cxl-mem1,share=on,mem-path=/tmp/cxltest.raw,size=256M \
> > >  -object memory-backend-file,id=cxl-mem2,share=on,mem-path=/tmp/cxltest2.raw,size=256M \
> > >  -object memory-backend-file,id=cxl-mem3,share=on,mem-path=/tmp/cxltest3.raw,size=256M \
> > >  -object memory-backend-file,id=cxl-mem4,share=on,mem-path=/tmp/cxltest4.raw,size=256M \
> > >  -object memory-backend-file,id=cxl-lsa1,share=on,mem-path=/tmp/lsa.raw,size=256M \
> > >  -object memory-backend-file,id=cxl-lsa2,share=on,mem-path=/tmp/lsa2.raw,size=256M \
> > >  -object memory-backend-file,id=cxl-lsa3,share=on,mem-path=/tmp/lsa3.raw,size=256M \
> > >  -object memory-backend-file,id=cxl-lsa4,share=on,mem-path=/tmp/lsa4.raw,size=256M \
> > >  -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
> > >  -device pxb-cxl,bus_nr=222,bus=pcie.0,id=cxl.2 \
> > >  -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
> > >  -device cxl-type3,bus=root_port13,memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem0,size=256M \
> > >  -device cxl-rp,port=1,bus=cxl.1,id=root_port14,chassis=0,slot=3 \
> > >  -device cxl-type3,bus=root_port14,memdev=cxl-mem2,lsa=cxl-lsa2,id=cxl-pmem1,size=256M \
> > >  -device cxl-rp,port=0,bus=cxl.2,id=root_port15,chassis=0,slot=5 \
> > >  -device cxl-type3,bus=root_port15,memdev=cxl-mem3,lsa=cxl-lsa3,id=cxl-pmem2,size=256M \
> > >  -device cxl-rp,port=1,bus=cxl.2,id=root_port16,chassis=0,slot=6 \
> > >  -device cxl-type3,bus=root_port16,memdev=cxl-mem4,lsa=cxl-lsa4,id=cxl-pmem3,size=256M \
> > >  -cxl-fixed-memory-window targets=cxl.1,size=4G,interleave-granularity=8k \
> > >  -cxl-fixed-memory-window targets=cxl.1,targets=cxl.2,size=4G,interleave-granularity=8k
> > > 
> > > First CFMWS suitable for up to 2 way interleave, the second for 4 way (2 way
> > > at host level and 2 way at the host bridge).
> > > targets=<range of pxb-cxl uids> , multiple entries if range is disjoint.
> > > 
> > > With the v5.17-rc1 + patch series listed below.
> > > 
> > >  cd /sys/bus/cxl/devices/
> > >  region=$(cat decoder0.1/create_region)
> > >  echo $region  > decoder0.1/create_region
> > >  ls -lh
> > >  
> > >  //Note the order of devices and adjust the following to make sure they
> > >  //are in order across the 4 root ports.  Easy to do in a tool, but
> > >  //not easy to paste in a cover letter.
> > > 
> > >  cd region0.1\:0
> > >  echo 4 > interleave_ways
> > >  echo mem2 > target0
> > >  echo mem3 > target1
> > >  echo mem0 > target2
> > >  echo mem1 > target3
> > >  echo $((1024<<20)) > size
> > >  echo 4096 > interleave_granularity
> > >  echo region0.1:0 > /sys/bus/cxl/drivers/cxl_region/bind
> > > 
> > > Tested with devmem2 and files with known content.
> > > Kernel tree is mainline + (I based on 5.17-rc1)
> > > [PATCH] cxl/regs: Fix size of CXL Capabilty Header Register
> > > https://lore.kernel.org/linux-cxl/20220201182934.jjvavjsf4h7oqngv@intel.com/T/#t
> > > 
> > > [PATCH v3 00/40] CXL.mem Topology Discovery and Hotplug Support
> > > https://lore.kernel.org/linux-cxl/164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com/
> > > Note that series has a lot of v4/v5 patches are replies but b4 does
> > > a good job of pulling out the latest.
> > > 
> > > [PATCH 0/2] cxl/port: Robustness fixes for decoder enumeration
> > > https://lore.kernel.org/linux-cxl/164317463887.3438644.4087819721493502301.stgit@dwillia2-desk3.amr.corp.intel.com/
> > > 
> > > [PATCH 0/4] Unify meaning of interleave attributes
> > > https://lore.kernel.org/linux-cxl/20220127212911.127741-1-ben.widawsky@intel.com/
> > > 
> > > [PATCH v3 00/14] CXL Region driver
> > > https://lore.kernel.org/linux-cxl/20220128002707.391076-1-ben.widawsky@intel.com/
> > > 
> > > What follows is a first attempt at explaining how all these components
> > > fit together.  I'll write up some formal documentation shortly.
> > > 
> > > Memory Address Map for CXL elements.  Note where exactly these regions
> > > appear is Arch and platform dependent.  
> > > 
> > >   Base somewhere far up in the Host PA map.
> > > _______________________________
> > > |                              |
> > > | CXL Host Bridge 0 Registers  | 
> > > | CXL Host Bridge 1 Registers  |
> > > |       ...                    |  This bit is normal MMIO register space.
> > > | CXL Host bridge N registers  |  including programmable interleave decoders 
> > > |______________________________|  for interleave across root ports.
> > > |                              |
> > >               ....     
> > > |                              |
> > > |______________________________|
> > > |                              |
> > > |   CFMW 0,                    |  Note that there can be multiple regions
> > > |   Interleave 2 way, targets  |  of memory within this 1TB which can be
> > > |   Hostbridge 0, Hostbridge 1 |  interleaved differently: in the host bridges
> > > |   Granularity 16KiB, 1TB     |  across root ports or in switches below the root.
> > > |______________________________|  ports
> > > |                              |
> > > |   CFMW 1,                    |
> > > |   Interleave 1 way, target   |
> > > |   Hostbridge 0, 512GiB       | 
> > > |______________________________|
> > > etc for all interleave combinations
> > > configured, or built in to the
> > > system before any generic software
> > > sees it.
> > > 
> > > System Topology considering CFMW 0 only to keep this simple.
> > > x marks the match in each decoder level.
> > > Switches have more interleave decoders and other features
> > > that we haven't implemented yet in QEMU.
> > > 
> > >                 Address Read to CFMW0 base + N
> > >               _________________|________________
> > >              |                                  |
> > >              |  Host interconnect               |  
> > >              |  Configured to route CFM         |
> > >              |  memory access to particular HB  |
> > >              |_____x____________________________|
> > >                    |                     |
> > >              Interleave Decoder          |
> > >              Matches this HB             |  
> > >                    |                     |
> > >             _______|__________      _____|____________
> > >            |                  |    |                  |
> > >            | CXL HB 0         |    | CXL HB 1         | Only exist in PCI (mostly)
> > >            | HB IntLv Decoder |    | HB IntLv Decoder | via ACPI description
> > >            |  PCI Root Bus 0c |    | PCI Root Bus 0d  |
> > >            |x_________________|    |__________________| In CXL have MMIO
> > >             |                |       |               |  at location given in CEDT
> > >             |                |       |               |  CHBS entry (ACPI)
> > > ____________|___   __________|__   __|_________   ___|_________ 
> > > |  Root Port 0  | | Root Port 1 | | Root Port 2| | Root Port 3 |
> > > |  Appears in   | | Appears in  | | Appears in | | Appear in   |
> > > |  PCI topology | | PCI Topology| | PCI Topo   | | PCI Topo    |
> > > |  As 0c:00.0   | | as 0c:01.0  | | as de:00.0 | | as de:01.0  |
> > > |_______________| |_____________| |____________| |_____________|
> > >       |                  |               |              |
> > >       |                  |               |              |
> > >  _____|_________   ______|______   ______|_____   ______|_______
> > > |     x         | |             | |            | |              |
> > > | CXL Type3 0   | | CXL Type3 1 | | CXL type3 2| | CLX Type 3 3 |
> > > |               | |             | |            | |              |
> > > | PMEM0(Vol LSA)| | PMEM1 (...) | | PMEM2 (...)| | PMEM3 (...)  |
> > > | Decoder to go | |             | |            | |              |
> > > | from host PA  | | PCI 0e:00.0 | | PCI df:00.0| | PCI e0:00.0  |
> > > | to device PA  | |             | |            | |              | 
> > > | PCI as 0d:00.0| |             | |            | |              |
> > > |_______________| |_____________| |____________| |______________|
> > > 
> > >    Backed by        Backed by       Backed by       Backed by
> > >     file 0           file 1           file 2          file 3
> > > 
> > > LSA backed by additional files for each device (not yet supported)
> > > 
> > > So currently we have decoders as follows for each interleaved access.
> > > 1) CFMW decoder - fixed config so forms part of qemu command line.
> > > 2) Host bridge decoders - programmable decoders that the system
> > >    software will program either based on user command or based
> > >    on info from the Label Storage Area (not yet emulated)
> > > 3) Type 3 device decoders. Down to here the address used is the
> > >    Host PA.  These decoders convert to the local device PA
> > >    (in simple case - drop some bits in the middle of the address)
> > > 
> > > Future patches will add decoders in switch upstream ports making
> > > the above diagram have another layer between root ports and
> > > the memory devices.
> > > 
> > > Note, we've focused for now on Persistent Memory devices as they are seen
> > > as an early and important usecase (and are the most complex one).
> > > But it should be straight forward to add volatile memory
> > > support and indeed that would be backed by RAM.
> > > 
> > > lspci -tv for above shows
> > > 
> > > -+-[0000:00]-+-00.0 Red Hat, Inc. QEMU PCIe Host Bridge (this is the cxl PXB)f
> > >  |           \-OTHER STUFF
> > >  +-[0000:0c]-+-00.0-[0d]----00.0  Intel Corporation Device 0d93
> > >  |           \-01.0-[0e]----00.0  Intel Corporation Device 0d93
> > >  \-[0000:de]-+-00.0-[df]----00.0  Intel Corporation Device 0d93
> > >              \-01.0-[e0]----00.0  Intel Corporation Device 0d93
> > > 
> > > Where those Intel parts are the type 3 devices.
> > > 
> > > All comments welcome!
> > > 
> > > Particular thanks to Alex Bennée for his review of v4.
> > > 
> > > Thanks,
> > > 
> > > Jonathan
> > > 
> > > Ben Widawsky (26):
> > >   hw/pci/cxl: Add a CXL component type (interface)
> > >   hw/cxl/component: Introduce CXL components (8.1.x, 8.2.5)
> > >   hw/cxl/device: Introduce a CXL device (8.2.8)
> > >   hw/cxl/device: Implement the CAP array (8.2.8.1-2)
> > >   hw/cxl/device: Implement basic mailbox (8.2.8.4)
> > >   hw/cxl/device: Add memory device utilities
> > >   hw/cxl/device: Add cheap EVENTS implementation (8.2.9.1)
> > >   hw/cxl/device: Timestamp implementation (8.2.9.3)
> > >   hw/cxl/device: Add log commands (8.2.9.4) + CEL
> > >   hw/pxb: Use a type for realizing expanders
> > >   hw/pci/cxl: Create a CXL bus type
> > >   hw/pxb: Allow creation of a CXL PXB (host bridge)
> > >   acpi/pci: Consolidate host bridge setup
> > >   hw/cxl/component: Implement host bridge MMIO (8.2.5, table 142)
> > >   hw/cxl/rp: Add a root port
> > >   hw/cxl/device: Add a memory device (8.2.8.5)
> > >   hw/cxl/device: Implement MMIO HDM decoding (8.2.5.12)
> > >   acpi/cxl: Add _OSC implementation (9.14.2)
> > >   tests/acpi: allow CEDT table addition
> > >   acpi/cxl: Create the CEDT (9.14.1)
> > >   hw/cxl/device: Add some trivial commands
> > >   hw/cxl/device: Plumb real Label Storage Area (LSA) sizing
> > >   hw/cxl/device: Implement get/set Label Storage Area (LSA)
> > >   acpi/cxl: Introduce CFMWS structures in CEDT
> > >   hw/cxl/component Add a dumb HDM decoder handler
> > >   qtest/cxl: Add very basic sanity tests
> > > 
> > > Jonathan Cameron (17):
> > >   MAINTAINERS: Add entry for Compute Express Link Emulation
> > >   tests/acpi: allow DSDT.viot table changes.
> > >   tests/acpi: Add update DSDT.viot
> > >   cxl: Machine level control on whether CXL support is enabled
> > >   hw/cxl/component: Add utils for interleave parameter encoding/decoding
> > >   hw/cxl/host: Add support for CXL Fixed Memory Windows.
> > >   hw/pci-host/gpex-acpi: Add support for dsdt construction for pxb-cxl
> > >   pci/pcie_port: Add pci_find_port_by_pn()
> > >   CXL/cxl_component: Add cxl_get_hb_cstate()
> > >   mem/cxl_type3: Add read and write functions for associated hostmem.
> > >   cxl/cxl-host: Add memops for CFMWS region.
> > >   arm/virt: Allow virt/CEDT creation
> > >   hw/arm/virt: Basic CXL enablement on pci_expander_bridge instances
> > >     pxb-cxl
> > >   RFC: softmmu/memory: Add ops to memory_region_ram_init_from_file
> > >   i386/pc: Enable CXL fixed memory windows
> > >   qtest/acpi: Add reference CEDT tables.
> > >   scripts/device-crash-test: Add exception for pxb-cxl
> > > 
> > >  MAINTAINERS                         |   7 +
> > >  hw/Kconfig                          |   1 +
> > >  hw/acpi/Kconfig                     |   5 +
> > >  hw/acpi/cxl-stub.c                  |  12 +
> > >  hw/acpi/cxl.c                       | 231 +++++++++++++
> > >  hw/acpi/meson.build                 |   4 +-
> > >  hw/arm/Kconfig                      |   1 +
> > >  hw/arm/virt-acpi-build.c            |  30 ++
> > >  hw/arm/virt.c                       |  40 ++-
> > >  hw/core/machine.c                   |  28 ++
> > >  hw/cxl/Kconfig                      |   3 +
> > >  hw/cxl/cxl-component-utils.c        | 284 ++++++++++++++++
> > >  hw/cxl/cxl-device-utils.c           | 271 ++++++++++++++++
> > >  hw/cxl/cxl-host-stubs.c             |  22 ++
> > >  hw/cxl/cxl-host.c                   | 263 +++++++++++++++
> > >  hw/cxl/cxl-mailbox-utils.c          | 483 ++++++++++++++++++++++++++++
> > >  hw/cxl/meson.build                  |  12 +
> > >  hw/i386/acpi-build.c                |  98 ++++--
> > >  hw/i386/pc.c                        |  57 +++-
> > >  hw/mem/Kconfig                      |   5 +
> > >  hw/mem/cxl_type3.c                  | 353 ++++++++++++++++++++
> > >  hw/mem/meson.build                  |   1 +
> > >  hw/meson.build                      |   1 +
> > >  hw/pci-bridge/Kconfig               |   5 +
> > >  hw/pci-bridge/cxl_root_port.c       | 231 +++++++++++++
> > >  hw/pci-bridge/meson.build           |   1 +
> > >  hw/pci-bridge/pci_expander_bridge.c | 171 +++++++++-
> > >  hw/pci-bridge/pcie_root_port.c      |   6 +-
> > >  hw/pci-host/gpex-acpi.c             |  22 +-
> > >  hw/pci/pci.c                        |  21 +-
> > >  hw/pci/pcie_port.c                  |  25 ++
> > >  include/hw/acpi/cxl.h               |  28 ++
> > >  include/hw/arm/virt.h               |   1 +
> > >  include/hw/boards.h                 |   2 +
> > >  include/hw/cxl/cxl.h                |  51 +++
> > >  include/hw/cxl/cxl_component.h      | 206 ++++++++++++
> > >  include/hw/cxl/cxl_device.h         | 272 ++++++++++++++++
> > >  include/hw/cxl/cxl_pci.h            | 160 +++++++++
> > >  include/hw/pci/pci.h                |  14 +
> > >  include/hw/pci/pci_bridge.h         |  20 ++
> > >  include/hw/pci/pci_bus.h            |   7 +
> > >  include/hw/pci/pci_ids.h            |   1 +
> > >  include/hw/pci/pcie_port.h          |   2 +
> > >  qapi/machine.json                   |  15 +
> > >  qemu-options.hx                     |  37 +++
> > >  scripts/device-crash-test           |   1 +
> > >  softmmu/memory.c                    |   9 +
> > >  softmmu/vl.c                        |  11 +
> > >  tests/data/acpi/pc/CEDT             | Bin 0 -> 36 bytes
> > >  tests/data/acpi/q35/CEDT            | Bin 0 -> 36 bytes
> > >  tests/data/acpi/q35/DSDT.viot       | Bin 9398 -> 9416 bytes
> > >  tests/data/acpi/virt/CEDT           | Bin 0 -> 36 bytes
> > >  tests/qtest/cxl-test.c              | 151 +++++++++
> > >  tests/qtest/meson.build             |   4 +
> > >  54 files changed, 3645 insertions(+), 41 deletions(-)
> > >  create mode 100644 hw/acpi/cxl-stub.c
> > >  create mode 100644 hw/acpi/cxl.c
> > >  create mode 100644 hw/cxl/Kconfig
> > >  create mode 100644 hw/cxl/cxl-component-utils.c
> > >  create mode 100644 hw/cxl/cxl-device-utils.c
> > >  create mode 100644 hw/cxl/cxl-host-stubs.c
> > >  create mode 100644 hw/cxl/cxl-host.c
> > >  create mode 100644 hw/cxl/cxl-mailbox-utils.c
> > >  create mode 100644 hw/cxl/meson.build
> > >  create mode 100644 hw/mem/cxl_type3.c
> > >  create mode 100644 hw/pci-bridge/cxl_root_port.c
> > >  create mode 100644 include/hw/acpi/cxl.h
> > >  create mode 100644 include/hw/cxl/cxl.h
> > >  create mode 100644 include/hw/cxl/cxl_component.h
> > >  create mode 100644 include/hw/cxl/cxl_device.h
> > >  create mode 100644 include/hw/cxl/cxl_pci.h
> > >  create mode 100644 tests/data/acpi/pc/CEDT
> > >  create mode 100644 tests/data/acpi/q35/CEDT
> > >  create mode 100644 tests/data/acpi/virt/CEDT
> > >  create mode 100644 tests/qtest/cxl-test.c
> > > 
> > > -- 
> > > 2.32.0  
> 

