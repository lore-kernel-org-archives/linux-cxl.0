Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A028C7EE29
	for <linux-cxl@archiver.kernel.org>; Thu,  8 Jun 2023 09:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbjFHJnc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 8 Jun 2023 05:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235189AbjFHJna (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 8 Jun 2023 05:43:30 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8296926B6
        for <linux-cxl@vger.kernel.org>; Thu,  8 Jun 2023 02:43:26 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QcK3M64cSz6GCpY;
        Thu,  8 Jun 2023 17:41:19 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 8 Jun
 2023 10:43:23 +0100
Date:   Thu, 8 Jun 2023 10:43:22 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>
CC:     Fan Ni <fan.ni@samsung.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "gregory.price@memverge.com" <gregory.price@memverge.com>,
        "hchkuo@avery-design.com.tw" <hchkuo@avery-design.com.tw>,
        "cbrowy@avery-design.com" <cbrowy@avery-design.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>,
        "nifan@outlook.com" <nifan@outlook.com>,
        "Ira Weiny" <ira.weiny@intel.com>
Subject: Re: [Qemu RFC 0/7] Early enabling of DCD emulation in Qemu
Message-ID: <20230608104322.0000632f@Huawei.com>
In-Reply-To: <DM6PR18MB284486E36310719093C8A6D6AF53A@DM6PR18MB2844.namprd18.prod.outlook.com>
References: <CGME20230511175641uscas1p2b1877f9179709b69e293acdd7e57104c@uscas1p2.samsung.com>
        <20230511175609.2091136-1-fan.ni@samsung.com>
        <647e1cf4e7e5e_7471a2948f@iweiny-mobl.notmuch>
        <20230605175112.GA2290821@bgt-140510-bm03>
        <DM6PR18MB2844A78EB692A69CE10031E2AF53A@DM6PR18MB2844.namprd18.prod.outlook.com>
        <20230607183059.GA2354376@bgt-140510-bm03>
        <DM6PR18MB284486E36310719093C8A6D6AF53A@DM6PR18MB2844.namprd18.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 7 Jun 2023 18:52:14 +0000
Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com> wrote:

> From: Fan Ni <fan.ni@samsung.com>
> Sent: Wednesday, June 7, 2023 11:31 AM
> To: Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>; qemu-devel@nongnu.org <qemu-devel@nongnu.org>; linux-cxl@vger.kernel.org <linux-cxl@vger.kernel.org>; gregory.price@memverge.com <gregory.price@memverge.com>; hchkuo@avery-design.com.tw <hchkuo@avery-design.com.tw>; cbrowy@avery-design.com <cbrowy@avery-design.com>; dan.j.williams@intel.com <dan.j.williams@intel.com>; Adam Manzanares <a.manzanares@samsung.com>; dave@stgolabs.net <dave@stgolabs.net>; nmtadam.samsung@gmail.com <nmtadam.samsung@gmail.com>; nifan@outlook.com <nifan@outlook.com>; Ira Weiny <ira.weiny@intel.com>
> Subject: [EXT] Re: [Qemu RFC 0/7] Early enabling of DCD emulation in Qemu 
>  
> External Email
> 
> ----------------------------------------------------------------------
> On Wed, Jun 07, 2023 at 06:13:01PM +0000, Shesha Bhushan Sreenivasamurthy wrote:
> > Hi Fan,
> >    I am implementing DCD FMAPI commands and planning to start pushing changes to the below branch. That requires the contributions you have made. Can your changes be pushed to the below branch ?
> > 
> > https://urldefense.com/v3/__https://gitlab.com/jic23/qemu/-/tree/cxl-2023-05-25__;!!EwVzqGoTKBqv-0DWAJBm!Vt5uIqwW-L4c4gh02ulI4M762JNQ3_aE9k9lb6QlwE2xm6T23ic7ig7Y77i1VN7l_RX_ySIQhre_z7Q0JA$   
> 
> Can you push changes to the branch directly? I think it is Jonathan's private
> branch. However, I can fork the branch and rebase my patch series atop and
> share with you the new repo if that helps you move forward your
> work.
> Let me know your thought.
> 
> ss - I saw commits from others, so assumed you can. Since it is Jonathan's private repo, I will step back and let him answer.

I tend to apply stuff in manually rather than given more people commit access
to that particular gitlab tree. 

Easiest option is to fork on gitlab and share the path of your own fork.

I normally queue reasonably mature stuff up on my tree, but that's about managing
the series sent with intent of being applied upstream + providing a fairly stable test
branch.  It's not intended as a general place for stuff in development (though I might
sneak out an extra branch myself from time to time if I want to talk about it :)

Jonathan

> 
> Fan
> 
> > 
> > 
> > From: Fan Ni <fan.ni@samsung.com>
> > Sent: Monday, June 5, 2023 10:51 AM
> > To: Ira Weiny <ira.weiny@intel.com>
> > Cc: qemu-devel@nongnu.org <qemu-devel@nongnu.org>; jonathan.cameron@huawei.com <jonathan.cameron@huawei.com>; linux-cxl@vger.kernel.org <linux-cxl@vger.kernel.org>; gregory.price@memverge.com <gregory.price@memverge.com>; hchkuo@avery-design.com.tw <hchkuo@avery-design.com.tw>; cbrowy@avery-design.com <cbrowy@avery-design.com>; dan.j.williams@intel.com <dan.j.williams@intel.com>; Adam Manzanares <a.manzanares@samsung.com>; dave@stgolabs.net <dave@stgolabs.net>; nmtadam.samsung@gmail.com <nmtadam.samsung@gmail.com>; nifan@outlook.com <nifan@outlook.com>
> > Subject: Re: [Qemu RFC 0/7] Early enabling of DCD emulation in Qemu 
> >  
> > On Mon, Jun 05, 2023 at 10:35:48AM -0700, Ira Weiny wrote:  
> > > Fan Ni wrote:  
> > > > Since the early draft of DCD support in kernel is out
> > > > (https://urldefense.com/v3/__https://lore.kernel.org/linux-cxl/20230417164126.GA1904906@bgt-140510-bm03/T/*t__;Iw!!EwVzqGoTKBqv-0DWAJBm!RHzXPIcSiGsqUciUIH6HnlG_W--4L5CHfvcOIeUFdwKFhAujXuFDxjymmpCdOu7SLr61rww7lr21LzAGNOk$ ),
> > > > this patch series provide dcd emulation in qemu so people who are interested
> > > > can have an early try. It is noted that the patch series may need to be updated
> > > > accordingly if the kernel side implementation changes.  
> > > 
> > > Fan,
> > > 
> > > Do you have a git tree we can pull this from which is updated to a more
> > > recent CXL branch from Jonathan?
> > > 
> > > Thanks,
> > > Ira  
> > 
> > Hi Ira,
> > 
> > I have a git tree of the patch series based on Jonathan's branch
> > cxl-2023-02-28: https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_moking_qemu-2Ddev_tree_dcd-2Drfe&d=DwIFAg&c=nKjWec2b6R0mOyPaz7xtfQ&r=Zta64bwn4nurTRpD4LY2OGr8KklkMRPn7Z_Qy0o4unU&m=w6dicn5kXEG4Imk6TpICIjdA6KJ-xt84dtHui-Y0fv5H13bijtzEvjxECKE5MHYf&s=3yeO9RN5FY3gPfO2y19X057YeqRTTQTQNfNA-Gfir_Q&e= .
> > 
> > That may be not new enough to include some of the recent patches, but I can
> > rebase it to a newer branch if you can tell me which branch you want to use.
> > 
> > Thanks,
> > Fan
> >   
> > >   
> > > > 
> > > > To support DCD emulation, the patch series add DCD related mailbox command
> > > > support (CXL Spec 3.0: 8.2.9.8.9), and extend the cxl type3 memory device
> > > > with dynamic capacity extent and region representative.
> > > > To support read/write to the dynamic capacity of the device, a host backend
> > > > is provided and necessary check mechnism is added to ensure the dynamic
> > > > capacity accessed is backed with active dc extents.
> > > > Currently FM related mailbox commands (cxl spec 3.0: 7.6.7.6) is not supported
> > > > , but we add two qmp interfaces for adding/releasing dynamic capacity extents.
> > > > Also, the support for multiple hosts sharing the same DCD case is missing.
> > > > 
> > > > Things we can try with the patch series together with kernel dcd code:
> > > > 1. Create DC regions to cover the address range of the dynamic capacity
> > > > regions.
> > > > 2. Add/release dynamic capacity extents to the device and notify the
> > > > kernel.
> > > > 3. Test kernel side code to accept added dc extents and create dax devices,
> > > > and release dc extents and notify the device
> > > > 4. Online the memory range backed with dc extents and let application use
> > > > them.
> > > > 
> > > > The patch series is based on Jonathan's local qemu branch:
> > > > https://urldefense.com/v3/__https://gitlab.com/jic23/qemu/-/tree/cxl-2023-02-28__;!!EwVzqGoTKBqv-0DWAJBm!RHzXPIcSiGsqUciUIH6HnlG_W--4L5CHfvcOIeUFdwKFhAujXuFDxjymmpCdOu7SLr61rww7lr21OO3UHEM$ 
> > > > 
> > > > Simple tests peformed with the patch series:
> > > > 1 Install cxl modules:
> > > > 
> > > > modprobe -a cxl_acpi cxl_core cxl_pci cxl_port cxl_mem
> > > > 
> > > > 2 Create dc regions:
> > > > 
> > > > region=$(cat /sys/bus/cxl/devices/decoder0.0/create_dc_region)
> > > > echo $region> /sys/bus/cxl/devices/decoder0.0/create_dc_region
> > > > echo 256 > /sys/bus/cxl/devices/$region/interleave_granularity
> > > > echo 1 > /sys/bus/cxl/devices/$region/interleave_ways
> > > > echo "dc" >/sys/bus/cxl/devices/decoder2.0/mode
> > > > echo 0x10000000 >/sys/bus/cxl/devices/decoder2.0/dpa_size
> > > > echo 0x10000000 > /sys/bus/cxl/devices/$region/size
> > > > echo  "decoder2.0" > /sys/bus/cxl/devices/$region/target0
> > > > echo 1 > /sys/bus/cxl/devices/$region/commit
> > > > echo $region > /sys/bus/cxl/drivers/cxl_region/bind
> > > > 
> > > > /home/fan/cxl/tools-and-scripts# cxl list
> > > > [
> > > >   {
> > > >     "memdevs":[
> > > >       {
> > > >         "memdev":"mem0",
> > > >         "pmem_size":536870912,
> > > >         "ram_size":0,
> > > >         "serial":0,
> > > >         "host":"0000:0d:00.0"
> > > >       }
> > > >     ]
> > > >   },
> > > >   {
> > > >     "regions":[
> > > >       {
> > > >         "region":"region0",
> > > >         "resource":45365592064,
> > > >         "size":268435456,
> > > >         "interleave_ways":1,
> > > >         "interleave_granularity":256,
> > > >         "decode_state":"commit"
> > > >       }
> > > >     ]
> > > >   }
> > > > ]
> > > > 
> > > > 3 Add two dc extents (128MB each) through qmp interface
> > > > 
> > > > { "execute": "qmp_capabilities" }
> > > > 
> > > > { "execute": "cxl-add-dynamic-capacity-event",
> > > >      "arguments": {
> > > >               "path": "/machine/peripheral/cxl-pmem0",
> > > >              "region-id" : 0,
> > > >               "num-extent": 2,
> > > >              "dpa":0,
> > > >              "extent-len": 128
> > > >      }
> > > > }
> > > > 
> > > > /home/fan/cxl/tools-and-scripts# lsmem
> > > > RANGE                                  SIZE   STATE REMOVABLE   BLOCK
> > > > 0x0000000000000000-0x000000007fffffff    2G  online       yes    0-15
> > > > 0x0000000100000000-0x000000027fffffff    6G  online       yes   32-79
> > > > 0x0000000a90000000-0x0000000a9fffffff  256M offline           338-339
> > > > 
> > > > Memory block size:       128M
> > > > Total online memory:       8G
> > > > Total offline memory:    256M
> > > > 
> > > > 
> > > > 4.Online the momory with 'daxctl online-memory dax0.0' to online the memory
> > > > 
> > > > /home/fan/cxl/ndctl# ./build/daxctl/daxctl online-memory dax0.0
> > > > [  230.730553] Fallback order for Node 0: 0 1
> > > > [  230.730825] Fallback order for Node 1: 1 0
> > > > [  230.730953] Built 2 zonelists, mobility grouping on.  Total pages: 2042541
> > > > [  230.731110] Policy zone: Normal
> > > > onlined memory for 1 device
> > > > 
> > > > root@bgt-140510-bm03:/home/fan/cxl/ndctl# lsmem
> > > > RANGE                                  SIZE   STATE REMOVABLE BLOCK
> > > > 0x0000000000000000-0x000000007fffffff    2G  online       yes  0-15
> > > > 0x0000000100000000-0x000000027fffffff    6G  online       yes 32-79
> > > > 0x0000000a90000000-0x0000000a97ffffff  128M  online       yes   338
> > > > 0x0000000a98000000-0x0000000a9fffffff  128M offline             339
> > > > 
> > > > Memory block size:       128M
> > > > Total online memory:     8.1G
> > > > Total offline memory:    128M
> > > > 
> > > > 5 using dc extents as regular memory
> > > > 
> > > > /home/fan/cxl/ndctl# numactl --membind=1 ls
> > > > CONTRIBUTING.md  README.md  clean_config.sh  cscope.out   git-version-gen
> > > > ndctl              scripts   test.h      version.h.in COPYING                 acpi.h
> > > > config.h.meson   cxl          make-git-snapshot.sh   ndctl.spec.in  sles     tools
> > > > Documentation        build       contrib           daxctl        meson.build            rhel
> > > > tags        topology.png LICENSES    ccan        cscope.files
> > > > git-version  meson_options.txt      rpmbuild.sh    test     util
> > > > 
> > > > 
> > > > QEMU command line cxl configuration:
> > > > 
> > > > RP1="-object memory-backend-file,id=cxl-mem1,share=on,mem-path=/tmp/cxltest.raw,size=512M \
> > > > -object memory-backend-file,id=cxl-mem2,share=on,mem-path=/tmp/cxltest2.raw,size=512M \
> > > > -object memory-backend-file,id=cxl-lsa1,share=on,mem-path=/tmp/lsa.raw,size=512M \
> > > > -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
> > > > -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
> > > > -device cxl-type3,bus=root_port13,memdev=cxl-mem1,lsa=cxl-lsa1,dc-memdev=cxl-mem2,id=cxl-pmem0,num-dc-regions=1\
> > > > -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=8k"
> > > > 
> > > > 
> > > > Kernel DCD support used to test the changes
> > > > 
> > > > The code is tested with the posted kernel dcd support:
> > > > https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=for-6.5*dcd-preview__;Lw!!EwVzqGoTKBqv-0DWAJBm!RHzXPIcSiGsqUciUIH6HnlG_W--4L5CHfvcOIeUFdwKFhAujXuFDxjymmpCdOu7SLr61rww7lr21q5Iza3M$ 
> > > > 
> > > > commit: f425bc34c600e2a3721d6560202962ec41622815
> > > > 
> > > > To make the test work, we have made the following changes to the above kernel commit:
> > > > 
> > > > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > > > index 5f04bbc18af5..5f421d3c5cef 100644
> > > > --- a/drivers/cxl/core/mbox.c
> > > > +++ b/drivers/cxl/core/mbox.c
> > > > @@ -68,6 +68,7 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
> > > >      CXL_CMD(SCAN_MEDIA, 0x11, 0, 0),
> > > >      CXL_CMD(GET_SCAN_MEDIA, 0, CXL_VARIABLE_PAYLOAD, 0),
> > > >      CXL_CMD(GET_DC_EXTENT_LIST, 0x8, CXL_VARIABLE_PAYLOAD, 0),
> > > > +   CXL_CMD(GET_DC_CONFIG, 0x2, CXL_VARIABLE_PAYLOAD, 0),
> > > >  };
> > > >  
> > > >  /*
> > > > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > > > index 291c716abd49..ae10e3cf43a1 100644
> > > > --- a/drivers/cxl/core/region.c
> > > > +++ b/drivers/cxl/core/region.c
> > > > @@ -194,7 +194,7 @@ static int cxl_region_manage_dc(struct cxl_region *cxlr)
> > > >              }
> > > >              cxlds->dc_list_gen_num = extent_gen_num;
> > > >              dev_dbg(cxlds->dev, "No of preallocated extents :%d\n", rc);
> > > > -           enable_irq(cxlds->cxl_irq[CXL_EVENT_TYPE_DCD]);
> > > > +           /*enable_irq(cxlds->cxl_irq[CXL_EVENT_TYPE_DCD]);*/
> > > >      }
> > > >      return 0;
> > > >  err:
> > > > @@ -2810,7 +2810,8 @@ int cxl_add_dc_extent(struct cxl_dev_state *cxlds, struct resource *alloc_dpa_re
> > > >                              dev_dax->align, memremap_compat_align()))) {
> > > >              rc = alloc_dev_dax_range(dev_dax, hpa,
> > > >                                      resource_size(alloc_dpa_res));
> > > > -           return rc;
> > > > +           if (rc)
> > > > +                   return rc;
> > > >      }
> > > >  
> > > >      rc = xa_insert(&cxlr_dc->dax_dev_list, hpa, dev_dax, GFP_KERNEL);
> > > > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > > > index 9e45b1056022..653bec203838 100644
> > > > --- a/drivers/cxl/pci.c
> > > > +++ b/drivers/cxl/pci.c
> > > > @@ -659,7 +659,7 @@ static int cxl_event_irqsetup(struct cxl_dev_state *cxlds)
> > > >  
> > > >      /* Driver enables DCD interrupt after creating the dc cxl_region */
> > > >      rc = cxl_event_req_irq(cxlds, policy.dyncap_settings, CXL_EVENT_TYPE_DCD,
> > > > -                                   IRQF_SHARED | IRQF_ONESHOT | IRQF_NO_AUTOEN);
> > > > +                                   IRQF_SHARED | IRQF_ONESHOT);
> > > >      if (rc) {
> > > >              dev_err(cxlds->dev, "Failed to get interrupt for event dc log\n");
> > > >              return rc;
> > > > diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> > > > index 6ca85861750c..910a48259239 100644
> > > > --- a/include/uapi/linux/cxl_mem.h
> > > > +++ b/include/uapi/linux/cxl_mem.h
> > > > @@ -47,6 +47,7 @@
> > > >      ___C(SCAN_MEDIA, "Scan Media"),                                   \
> > > >      ___C(GET_SCAN_MEDIA, "Get Scan Media Results"),                   \
> > > >      ___C(GET_DC_EXTENT_LIST, "Get dynamic capacity extents"),         \
> > > > +   ___C(GET_DC_CONFIG, "Get dynamic capacity configuration"),         \
> > > >      ___C(MAX, "invalid / last command")
> > > >  
> > > >  #define ___C(a, b) CXL_MEM_COMMAND_ID_##a
> > > > 
> > > > 
> > > > 
> > > > Fan Ni (7):
> > > >   hw/cxl/cxl-mailbox-utils: Add dc_event_log_size field to output
> > > >     payload of identify memory device command
> > > >   hw/cxl/cxl-mailbox-utils: Add dynamic capacity region representative
> > > >     and mailbox command support
> > > >   hw/mem/cxl_type3: Add a parameter to pass number of DC regions the
> > > >     device supports in qemu command line
> > > >   hw/mem/cxl_type3: Add DC extent representative to cxl type3 device
> > > >   hw/cxl/cxl-mailbox-utils: Add mailbox commands to support add/release
> > > >     dynamic capacity response
> > > >   Add qmp interfaces to add/release dynamic capacity extents
> > > >   hw/mem/cxl_type3: add read/write support to dynamic capacity
> > > > 
> > > >  hw/cxl/cxl-mailbox-utils.c  | 389 +++++++++++++++++++++++++++-
> > > >  hw/mem/cxl_type3.c          | 492 +++++++++++++++++++++++++++++++-----
> > > >  include/hw/cxl/cxl_device.h |  50 +++-
> > > >  include/hw/cxl/cxl_events.h |  16 ++
> > > >  qapi/cxl.json               |  44 ++++
> > > >  5 files changed, 924 insertions(+), 67 deletions(-)
> > > > 
> > > > -- 
> > > > 2.25.1  
> > > 
> > >  

