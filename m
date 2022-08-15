Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A9CC00140
	for <linux-cxl@archiver.kernel.org>; Mon, 15 Aug 2022 14:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbiHOOzZ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 15 Aug 2022 10:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233272AbiHOOzX (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 15 Aug 2022 10:55:23 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78292B9B
        for <linux-cxl@vger.kernel.org>; Mon, 15 Aug 2022 07:55:20 -0700 (PDT)
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M5y1G4Yjjz67tG2;
        Mon, 15 Aug 2022 22:52:18 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 15 Aug 2022 16:55:17 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 15 Aug
 2022 15:55:17 +0100
Date:   Mon, 15 Aug 2022 15:55:16 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Jonathan Cameron via <qemu-devel@nongnu.org>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Bobo WL <lmw.bobo@gmail.com>, <linux-cxl@vger.kernel.org>,
        <qemu-arm@nongnu.org>
Subject: Re: [BUG] cxl can not create region
Message-ID: <20220815155516.00007ebf@huawei.com>
In-Reply-To: <20220815151809.0000294c@huawei.com>
References: <CAGr_yG0UrfJAMWta3EkR1F0JZ4j--sig74p6vKL3K6TZDx9YGA@mail.gmail.com>
        <20220808133727.00001171@huawei.com>
        <CAGr_yG36GSO8esyO9nn6OeOEN5zPSosEmBHbfYGwqNGiYOh9vw@mail.gmail.com>
        <20220809170825.00001b61@huawei.com>
        <20220811180857.00005e67@huawei.com>
        <20220812164403.00001654@huawei.com>
        <62f679b67828f_992102942@dwillia2-xfh.jf.intel.com.notmuch>
        <20220812171509.00006034@huawei.com>
        <20220815151809.0000294c@huawei.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 15 Aug 2022 15:18:09 +0100
Jonathan Cameron via <qemu-devel@nongnu.org> wrote:

> On Fri, 12 Aug 2022 17:15:09 +0100
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> 
> > On Fri, 12 Aug 2022 09:03:02 -0700
> > Dan Williams <dan.j.williams@intel.com> wrote:
> >   
> > > Jonathan Cameron wrote:    
> > > > On Thu, 11 Aug 2022 18:08:57 +0100
> > > > Jonathan Cameron via <qemu-devel@nongnu.org> wrote:
> > > >       
> > > > > On Tue, 9 Aug 2022 17:08:25 +0100
> > > > > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> > > > >       
> > > > > > On Tue, 9 Aug 2022 21:07:06 +0800
> > > > > > Bobo WL <lmw.bobo@gmail.com> wrote:
> > > > > >         
> > > > > > > Hi Jonathan
> > > > > > > 
> > > > > > > Thanks for your reply!
> > > > > > > 
> > > > > > > On Mon, Aug 8, 2022 at 8:37 PM Jonathan Cameron
> > > > > > > <Jonathan.Cameron@huawei.com> wrote:          
> > > > > > > >
> > > > > > > > Probably not related to your problem, but there is a disconnect in QEMU /
> > > > > > > > kernel assumptionsaround the presence of an HDM decoder when a HB only
> > > > > > > > has a single root port. Spec allows it to be provided or not as an implementation choice.
> > > > > > > > Kernel assumes it isn't provide. Qemu assumes it is.
> > > > > > > >
> > > > > > > > The temporary solution is to throw in a second root port on the HB and not
> > > > > > > > connect anything to it.  Longer term I may special case this so that the particular
> > > > > > > > decoder defaults to pass through settings in QEMU if there is only one root port.
> > > > > > > >            
> > > > > > > 
> > > > > > > You are right! After adding an extra HB in qemu, I can create a x1
> > > > > > > region successfully.
> > > > > > > But have some errors in Nvdimm:
> > > > > > > 
> > > > > > > [   74.925838] Unknown online node for memory at 0x10000000000, assuming node 0
> > > > > > > [   74.925846] Unknown target node for memory at 0x10000000000, assuming node 0
> > > > > > > [   74.927470] nd_region region0: nmem0: is disabled, failing probe          
> > > > > > 
> > > > > > Ah. I've seen this one, but not chased it down yet.  Was on my todo list to chase
> > > > > > down. Once I reach this state I can verify the HDM Decode is correct which is what
> > > > > > I've been using to test (Which wasn't true until earlier this week). 
> > > > > > I'm currently testing via devmem, more for historical reasons than because it makes
> > > > > > that much sense anymore.          
> > > > > 
> > > > > *embarassed cough*.  We haven't fully hooked the LSA up in qemu yet.
> > > > > I'd forgotten that was still on the todo list. I don't think it will
> > > > > be particularly hard to do and will take a look in next few days.
> > > > > 
> > > > > Very very indirectly this error is causing a driver probe fail that means that
> > > > > we hit a code path that has a rather odd looking check on NDD_LABELING.
> > > > > Should not have gotten near that path though - hence the problem is actually
> > > > > when we call cxl_pmem_get_config_data() and it returns an error because
> > > > > we haven't fully connected up the command in QEMU.      
> > > > 
> > > > So a least one bug in QEMU. We were not supporting variable length payloads on mailbox
> > > > inputs (but were on outputs).  That hasn't mattered until we get to LSA writes.
> > > > We just need to relax condition on the supplied length.
> > > > 
> > > > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > > > index c352a935c4..fdda9529fe 100644
> > > > --- a/hw/cxl/cxl-mailbox-utils.c
> > > > +++ b/hw/cxl/cxl-mailbox-utils.c
> > > > @@ -510,7 +510,7 @@ void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
> > > >      cxl_cmd = &cxl_cmd_set[set][cmd];
> > > >      h = cxl_cmd->handler;
> > > >      if (h) {
> > > > -        if (len == cxl_cmd->in) {
> > > > +        if (len == cxl_cmd->in || !cxl_cmd->in) {
> > > >              cxl_cmd->payload = cxl_dstate->mbox_reg_state +
> > > >                  A_CXL_DEV_CMD_PAYLOAD;
> > > >              ret = (*h)(cxl_cmd, cxl_dstate, &len);
> > > > 
> > > > 
> > > > This lets the nvdimm/region probe fine, but I'm getting some issues with
> > > > namespace capacity so I'll look at what is causing that next.
> > > > Unfortunately I'm not that familiar with the driver/nvdimm side of things
> > > > so it's take a while to figure out what kicks off what!      
> > > 
> > > The whirlwind tour is that 'struct nd_region' instances that represent a
> > > persitent memory address range are composed of one more mappings of
> > > 'struct nvdimm' objects. The nvdimm object is driven by the dimm driver
> > > in drivers/nvdimm/dimm.c. That driver is mainly charged with unlocking
> > > the dimm (if locked) and interrogating the label area to look for
> > > namespace labels.
> > > 
> > > The label command calls are routed to the '->ndctl()' callback that was
> > > registered when the CXL nvdimm_bus_descriptor was created. That callback
> > > handles both 'bus' scope calls, currently none for CXL, and per nvdimm
> > > calls. cxl_pmem_nvdimm_ctl() translates those generic LIBNVDIMM commands
> > > to CXL commands.
> > > 
> > > The 'struct nvdimm' objects that the CXL side registers have the
> > > NDD_LABELING flag set which means that namespaces need to be explicitly
> > > created / provisioned from region capacity. Otherwise, if
> > > drivers/nvdimm/dimm.c does not find a namespace-label-index block then
> > > the region reverts to label-less mode and a default namespace equal to
> > > the size of the region is instantiated.
> > > 
> > > If you are seeing small mismatches in namespace capacity then it may
> > > just be the fact that by default 'ndctl create-namespace' results in an
> > > 'fsdax' mode namespace which just means that it is a block device where
> > > 1.5% of the capacity is reserved for 'struct page' metadata. You should
> > > be able to see namespace capacity == region capacity by doing "ndctl
> > > create-namespace -m raw", and disable DAX operation.    
> > 
> > Currently ndctl create-namespace crashes qemu ;)
> > Which isn't ideal!
> >   
> 
> Found a cause for this one.  Mailbox payload may be as small as 256 bytes.
> We have code in kernel sanity checking that output payload fits in the
> mailbox, but nothing on the input payload.  Symptom is that we write just
> off the end whatever size the payload is.  Note doing this shouldn't crash
> qemu - so I need to fix a range check somewhere.
> 
> I think this is because cxl_pmem_get_config_size() returns the mailbox
> payload size as being the available LSA size, forgetting to remove the
> size of the headers on the set_lsa side of things.
> https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/tree/drivers/cxl/pmem.c?h=next#n110
> 
> I've hacked the max_payload to be -8
> 
> Now we still don't succeed in creating the namespace, but bonus is it doesn't crash any more.

In the interests of defensive / correct handling from QEMU I took a
look into why it was crashing.  Turns out that providing a NULL write callback for
the memory device region (that the above overlarge write was spilling into) isn't
a safe thing to do.  Needs a stub. Oops.

On plus side we might never have noticed this was going wrong without the crash
*silver lining in every cloud*

Fix to follow...

Jonathan


> 
> 
> Jonathan
> 
> 
> 
> > > 
> > > Hope that helps.    
> > Got me looking at the right code. Thanks!
> > 
> > Jonathan
> > 
> >   
> 
> 

