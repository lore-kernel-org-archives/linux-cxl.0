Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7653CC433FE
	for <linux-cxl@archiver.kernel.org>; Thu,  3 Nov 2022 12:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiKCM67 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 3 Nov 2022 08:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiKCM65 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 3 Nov 2022 08:58:57 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF12911C27
        for <linux-cxl@vger.kernel.org>; Thu,  3 Nov 2022 05:58:55 -0700 (PDT)
Received: from frapeml100008.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4N33g335QZz6H7HT;
        Thu,  3 Nov 2022 20:56:47 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 frapeml100008.china.huawei.com (7.182.85.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 13:58:53 +0100
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 3 Nov
 2022 12:58:52 +0000
Date:   Thu, 3 Nov 2022 12:58:51 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <shiju.jose@huawei.com>,
        <rrichter@amd.com>
Subject: Re: [PATCH RFC v2 0/9] cxl/pci: Add fundamental error handling
Message-ID: <20221103125851.00000ce9@huawei.com>
In-Reply-To: <20221024170102.00000c4b@huawei.com>
References: <166336972295.3803215.1047199449525031921.stgit@djiang5-desk3.ch.intel.com>
        <20221011151744.00005278@huawei.com>
        <1e4de3fa-4e80-cc99-7fbf-3f6669766648@intel.com>
        <20221011181915.000031a1@huawei.com>
        <20221019183012.00007201@huawei.com>
        <ae8330db-ab77-7952-e846-de7dc527890c@intel.com>
        <20221024170102.00000c4b@huawei.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 24 Oct 2022 17:01:02 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Wed, 19 Oct 2022 10:38:13 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
> > On 10/19/2022 10:30 AM, Jonathan Cameron wrote:  
> > > On Tue, 11 Oct 2022 18:19:15 +0100
> > > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> > >    
> > >> On Tue, 11 Oct 2022 08:18:34 -0700
> > >> Dave Jiang <dave.jiang@intel.com> wrote:
> > >>    
> > >>> On 10/11/2022 7:17 AM, Jonathan Cameron wrote:    
> > >>>> On Fri, 16 Sep 2022 16:10:53 -0700
> > >>>> Dave Jiang <dave.jiang@intel.com> wrote:
> > >>>>         
> > >>>>> Series set to RFC since there's no means to test. Would like to get opinion
> > >>>>> on whether going with using trace events as reporting mechanism is ok.
> > >>>>>
> > >>>>> Jonathan,
> > >>>>> We currently don't have any ways to test AER events. Do you have any plans
> > >>>>> to support AER events via QEMU emulation?    
> > >>>> Sorry - missed this entirely as gotten a bit behind reading CXL emails.    
> > > Hi Dave,
> > >
> > > Quick update.
> > >
> > > Working QEMU emulation - but needs some/lots of cleanup. Particularly fun was
> > > figuring out why I wasn't getting messages past the upstream switch port.
> > > Turned out the serial number ECAP was on top of the AER ECAP. Oops - thankfully
> > > that patch isn't upstream yet.
> > > Also QEMU AER rooting seems to be based on some older PCIE spec
> > > so needed some tweaks to get the device to actually issue ERR_FATAL etc.
> > >
> > > Anyhow, should have something you can play with in a day or two.    
> > 
> > Awesome! Thanks! :)  
> 
> Took a little longer than expected..
> 
> Anyhow, now at
> https://gitlab.com/jic23/qemu/-/commits/cxl-2022-10-24
> 
> That tree is carrying far too many things right now for it make much sense
> to me to email this to qemu-devel - though I may pull
> hw/pci/aer: Add missing routing for AER errors
> out in advance as that's closing a spec different between QEMU emulation of AER
> and what the PCI spec says.
> 
> Hopefully set of out of tree patches will start to shrink soon - v9 of the DOE
> patches have been on list for a week or so.
> 
> Top patch includes a very short 'how to' in patch description.  Basically fire
> up QMP: Add something like -qmp tcp:localhost:444,server=on,wait=off to your
> qemu commandline and use commands like:
> 
> { "execute": "qmp_capabilities" }
> ...
> { "execute": "cxl-inject-uncorrectable-error",
>     "arguments": {
>         "path": "/machine/peripheral/cxl-pmem0",
>         "type": "cache-address-parity",
>         "header": [ 3, 4]
>     } }
> ...
> { "execute": "cxl-inject-correctable-error",
>     "arguments": {
>         "path": "/machine/peripheral/cxl-pmem0",
>         "type": "physical",
>         "header": [ 3, 4]
>     } }
> 

So Dave reported that this wasn't working on x86 qemu machines.

A fun bit of debugging later (I hate AML) and I think I have find the issue +
have a hack to workaround it for now.

So need some background.
1) CXL code is based on QEMU's pci expander bridge root bridge - there is a complex
   bit of handling to create appropriate ACPI DSDT magic.
2) The CXL root port is based on pcie_root_port.c 
3) Both CXL root port and pcie root port use traditional PCI interrupts, not MSI/MSIX
   for their signaling.
4) Q35 machine uses an IOAPIC and the resulting PCI bus interrupt routing lands the
   actual interrupt on line 23 for my particular configuration
5) The ACPI table says it's on line 11.
6) x86 code for creating the PRT has an informative comment...
https://elixir.bootlin.com/qemu/latest/source/hw/i386/acpi-build.c#L697
 * The main goal is to equaly distribute the interrupts
 * over the 4 existing ACPI links (works only for i440fx).

So the hack I'm running is below (note the UID thing is a separate bug that stops
iasl from disassembling the DSDT due to a duplicate entry - I'll send out a fix
for that shortly).

There are a bunch of possible approaches to fix this if my identification of
the issue is correct.

1) Clean equivalent of this hack that runs on appropriate machines only.
2) Use MSI instead. (ioh3420 root port takes this approach I think).

From 286c8f9b6d229d9e71f64657b6b3ccb70cb98306 Mon Sep 17 00:00:00 2001
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Thu, 3 Nov 2022 12:20:25 +0000
Subject: [PATCH] HACK: Fix-up interrupt routing for CXL on q35.

I need to do some more thinking to figure out correct approach
to solve this problem.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/i386/acpi-build.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 4f54b61904..8055253e68 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -746,7 +746,7 @@ static Aml *build_prt(bool is_pci0_prt)
                       lnk_idx));
 
         /* route[2] = "LNK[D|A|B|C]", selection based on pin % 3  */
-        aml_append(while_ctx, initialize_route(route, "LNKD", lnk_idx, 0));
+        aml_append(while_ctx, initialize_route(route, "GSIH", lnk_idx, 0));
         if (is_pci0_prt) {
             Aml *if_device_1, *if_pin_4, *else_pin_4;
 
@@ -762,16 +762,16 @@ static Aml *build_prt(bool is_pci0_prt)
                 else_pin_4 = aml_else();
                 {
                     aml_append(else_pin_4,
-                        aml_store(build_prt_entry("LNKA"), route));
+                        aml_store(build_prt_entry("GSIE"), route));
                 }
                 aml_append(if_device_1, else_pin_4);
             }
             aml_append(while_ctx, if_device_1);
         } else {
-            aml_append(while_ctx, initialize_route(route, "LNKA", lnk_idx, 1));
+            aml_append(while_ctx, initialize_route(route, "GSIE", lnk_idx, 1));
         }
-        aml_append(while_ctx, initialize_route(route, "LNKB", lnk_idx, 2));
-        aml_append(while_ctx, initialize_route(route, "LNKC", lnk_idx, 3));
+        aml_append(while_ctx, initialize_route(route, "GSIF", lnk_idx, 2));
+        aml_append(while_ctx, initialize_route(route, "GSIG", lnk_idx, 3));
 
         /* route[0] = 0x[slot]FFFF */
         aml_append(while_ctx,
@@ -1627,7 +1627,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
                 aml_append(pkg, aml_eisaid("PNP0A03"));
                 aml_append(dev, aml_name_decl("_CID", pkg));
                 aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
-                aml_append(dev, aml_name_decl("_UID", aml_int(bus_num)));
+//                aml_append(dev, aml_name_decl("_UID", aml_int(bus_num)));
                 build_cxl_osc_method(dev);
             } else if (pci_bus_is_express(bus)) {
                 aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A08")));
-- 
2.37.2
> 
> > 
> >   
> > > In meantime an example dump (not writing the header log yet!)
> > >
> > > pcieport 0000:0c:00.0: AER: Uncorrected (Non-Fatal) error received: 0000:0f:00.0
> > > cxl_pci 0000:0f:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Requester ID)
> > > cxl_pci 0000:0f:00.0:   device [8086:0d93] error status/mask=00004000/00000000
> > > cxl_pci 0000:0f:00.0:    [14] CmpltTO                (First)
> > > cxl_ras_uc: mem3: status: 'Cache Data Parity Error' first_error: 'Cache Data Parity Error' header log: {0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0}
> > > cxl_pci 0000:0f:00.0: mem3: restart CXL.mem after slot reset
> > > cxl_port endpoint6: No CMA mailbox
> > > cxl_pci 0000:0f:00.0: mem3: error resume successful
> > > pcieport 0000:0e:00.0: AER: device recovery successful
> > >
> > > Jonathan    
> >   
> 
> 

