Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0127C25B08
	for <linux-cxl@archiver.kernel.org>; Wed, 17 Aug 2022 11:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234503AbiHQLZn (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 17 Aug 2022 07:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235755AbiHQLZn (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 17 Aug 2022 07:25:43 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D8F754B8
        for <linux-cxl@vger.kernel.org>; Wed, 17 Aug 2022 04:25:41 -0700 (PDT)
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M75GL0DDtz67Lmq;
        Wed, 17 Aug 2022 19:22:34 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Wed, 17 Aug 2022 13:25:38 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 17 Aug
 2022 12:25:38 +0100
Date:   Wed, 17 Aug 2022 12:25:37 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Jonathan Cameron via <qemu-devel@nongnu.org>,
        Bobo WL <lmw.bobo@gmail.com>, <linux-cxl@vger.kernel.org>,
        <qemu-arm@nongnu.org>
Subject: Re: [BUG] cxl can not create region
Message-ID: <20220817122537.00007b24@huawei.com>
In-Reply-To: <62faced380b00_dfbc129494@dwillia2-xfh.jf.intel.com.notmuch>
References: <CAGr_yG0UrfJAMWta3EkR1F0JZ4j--sig74p6vKL3K6TZDx9YGA@mail.gmail.com>
 <20220808133727.00001171@huawei.com>
 <CAGr_yG36GSO8esyO9nn6OeOEN5zPSosEmBHbfYGwqNGiYOh9vw@mail.gmail.com>
 <20220809170825.00001b61@huawei.com>
 <20220811180857.00005e67@huawei.com>
 <20220812164403.00001654@huawei.com>
 <20220815180444.00006bdf@huawei.com>
 <62faced380b00_dfbc129494@dwillia2-xfh.jf.intel.com.notmuch>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 15 Aug 2022 15:55:15 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Jonathan Cameron wrote:
> > On Fri, 12 Aug 2022 16:44:03 +0100
> > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> >   
> > > On Thu, 11 Aug 2022 18:08:57 +0100
> > > Jonathan Cameron via <qemu-devel@nongnu.org> wrote:
> > >   
> > > > On Tue, 9 Aug 2022 17:08:25 +0100
> > > > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> > > >     
> > > > > On Tue, 9 Aug 2022 21:07:06 +0800
> > > > > Bobo WL <lmw.bobo@gmail.com> wrote:
> > > > >       
> > > > > > Hi Jonathan
> > > > > > 
> > > > > > Thanks for your reply!
> > > > > > 
> > > > > > On Mon, Aug 8, 2022 at 8:37 PM Jonathan Cameron
> > > > > > <Jonathan.Cameron@huawei.com> wrote:        
> > > > > > >
> > > > > > > Probably not related to your problem, but there is a disconnect in QEMU /
> > > > > > > kernel assumptionsaround the presence of an HDM decoder when a HB only
> > > > > > > has a single root port. Spec allows it to be provided or not as an implementation choice.
> > > > > > > Kernel assumes it isn't provide. Qemu assumes it is.
> > > > > > >
> > > > > > > The temporary solution is to throw in a second root port on the HB and not
> > > > > > > connect anything to it.  Longer term I may special case this so that the particular
> > > > > > > decoder defaults to pass through settings in QEMU if there is only one root port.
> > > > > > >          
> > > > > > 
> > > > > > You are right! After adding an extra HB in qemu, I can create a x1
> > > > > > region successfully.
> > > > > > But have some errors in Nvdimm:
> > > > > > 
> > > > > > [   74.925838] Unknown online node for memory at 0x10000000000, assuming node 0
> > > > > > [   74.925846] Unknown target node for memory at 0x10000000000, assuming node 0
> > > > > > [   74.927470] nd_region region0: nmem0: is disabled, failing probe        
> > > > > 
> > > > > Ah. I've seen this one, but not chased it down yet.  Was on my todo list to chase
> > > > > down. Once I reach this state I can verify the HDM Decode is correct which is what
> > > > > I've been using to test (Which wasn't true until earlier this week). 
> > > > > I'm currently testing via devmem, more for historical reasons than because it makes
> > > > > that much sense anymore.        
> > > > 
> > > > *embarassed cough*.  We haven't fully hooked the LSA up in qemu yet.
> > > > I'd forgotten that was still on the todo list. I don't think it will
> > > > be particularly hard to do and will take a look in next few days.
> > > > 
> > > > Very very indirectly this error is causing a driver probe fail that means that
> > > > we hit a code path that has a rather odd looking check on NDD_LABELING.
> > > > Should not have gotten near that path though - hence the problem is actually
> > > > when we call cxl_pmem_get_config_data() and it returns an error because
> > > > we haven't fully connected up the command in QEMU.    
> > > 
> > > So a least one bug in QEMU. We were not supporting variable length payloads on mailbox
> > > inputs (but were on outputs).  That hasn't mattered until we get to LSA writes.
> > > We just need to relax condition on the supplied length.
> > > 
> > > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > > index c352a935c4..fdda9529fe 100644
> > > --- a/hw/cxl/cxl-mailbox-utils.c
> > > +++ b/hw/cxl/cxl-mailbox-utils.c
> > > @@ -510,7 +510,7 @@ void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
> > >      cxl_cmd = &cxl_cmd_set[set][cmd];
> > >      h = cxl_cmd->handler;
> > >      if (h) {
> > > -        if (len == cxl_cmd->in) {
> > > +        if (len == cxl_cmd->in || !cxl_cmd->in) {  
> > Fix is wrong as we use ~0 as the placeholder for variable payload, not 0.
> > 
> > With that fixed we hit new fun paths - after some errors we get the
> > worrying - not totally sure but looks like a failure on an error cleanup.
> > I'll chase down the error source, but even then this is probably triggerable by
> > hardware problem or similar.  Some bonus prints in here from me chasing
> > error paths, but it's otherwise just cxl/next + the fix I posted earlier today.  
> 
> One of the scenarios that I cannot rule out is nvdimm_probe() racing
> nd_region_probe(), but given all the work it takes to create a region I
> suspect all the nvdimm_probe() work to have completed...
> 
> It is at least one potentially wrong hypothesis that needs to be chased
> down.

Maybe there should be a special award for the non-intuitive 
ndctl create-namespace command (modifies existing namespace and might create
a different empty one...) I'm sure there is some interesting history behind that one :)

Upshot is I just threw a filesystem on fsdax and wrote some text files on it
to allow easy grepping. The right data ends up in the memory and a plausible
namespace description is stored in the LSA.

So to some degree at least it's 'working' on an 8 way direct connected
set of emulated devices.

One snag is that serial number support isn't yet upstream in QEMU.
(I have had it in my tree for a while but not posted it yet because of
 QEMU feature freeze)
https://gitlab.com/jic23/qemu/-/commit/144c783ea8a5fbe169f46ea1ba92940157f42733
That's needed for meaningful cookie generation.  Otherwise you can build the
namespace once, but it won't work on next probe as the cookie is 0 and you
hit some error paths.

Maybe sensible to add a sanity check and fail namespace creation if
cookie is 0?  (Silly side question, but is there a theoretical risk of
a serial number / other data combination leading to a fletcher64()
checksum that happens to be 0 - that would give a very odd bug report!)

So to make it work the following is needed:

1) The kernel fix for mailbox buffer overflow.
2) Qemu fix for size of arguements for get_lsa
3) Qemu fix to allow variable size input arguements (for set_lsa)
4) Serial number patch above + command lines to qemu to set appropriate
   serial numbers.

I'll send out the QEMU fixes shortly and post the Serial number patch,
though that almost certainly won't go in until next QEMU development
cycle starts in a few weeks.

Next up, run through same tests on some other topologies.

Jonathan

> 
> > 
> > [   69.919877] nd_bus ndbus0: START: nd_region.probe(region0)
> > [   69.920108] nd_region_probe
> > [   69.920623] ------------[ cut here ]------------
> > [   69.920675] refcount_t: addition on 0; use-after-free.
> > [   69.921314] WARNING: CPU: 3 PID: 710 at lib/refcount.c:25 refcount_warn_saturate+0xa0/0x144
> > [   69.926949] Modules linked in: cxl_pmem cxl_mem cxl_pci cxl_port cxl_acpi cxl_core
> > [   69.928830] CPU: 3 PID: 710 Comm: kworker/u8:9 Not tainted 5.19.0-rc3+ #399
> > [   69.930596] Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
> > [   69.931482] Workqueue: events_unbound async_run_entry_fn
> > [   69.932403] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > [   69.934023] pc : refcount_warn_saturate+0xa0/0x144
> > [   69.935161] lr : refcount_warn_saturate+0xa0/0x144
> > [   69.936541] sp : ffff80000890b960
> > [   69.937921] x29: ffff80000890b960 x28: 0000000000000000 x27: 0000000000000000
> > [   69.940917] x26: ffffa54a90d5cb10 x25: ffffa54a90809e98 x24: 0000000000000000
> > [   69.942537] x23: ffffa54a91a3d8d8 x22: ffff0000c5254800 x21: ffff0000c5254800
> > [   69.944013] x20: ffff0000ce924180 x19: ffff0000c5254800 x18: ffffffffffffffff
> > [   69.946100] x17: ffff5ab66e5ef000 x16: ffff80000801c000 x15: 0000000000000000
> > [   69.947585] x14: 0000000000000001 x13: 0a2e656572662d72 x12: 657466612d657375
> > [   69.948670] x11: 203b30206e6f206e x10: 6f69746964646120 x9 : ffffa54a8f63d288
> > [   69.950679] x8 : 206e6f206e6f6974 x7 : 69646461203a745f x6 : 00000000fffff31e
> > [   69.952113] x5 : ffff0000ff61ba08 x4 : 00000000fffff31e x3 : ffff5ab66e5ef000
> > root@debian:/sys/bus/cxl/devices/decoder0.0/region0# [   69.954752] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0000c512e740
> > [   69.957098] Call trace:
> > [   69.957959]  refcount_warn_saturate+0xa0/0x144
> > [   69.958773]  get_ndd+0x5c/0x80
> > [   69.959294]  nd_region_register_namespaces+0xe4/0xe90
> > [   69.960253]  nd_region_probe+0x100/0x290
> > [   69.960796]  nvdimm_bus_probe+0xf4/0x1c0
> > [   69.962087]  really_probe+0x19c/0x3f0
> > [   69.962620]  __driver_probe_device+0x11c/0x190
> > [   69.963258]  driver_probe_device+0x44/0xf4
> > [   69.963773]  __device_attach_driver+0xa4/0x140
> > [   69.964471]  bus_for_each_drv+0x84/0xe0
> > [   69.965068]  __device_attach+0xb0/0x1f0
> > [   69.966101]  device_initial_probe+0x20/0x30
> > [   69.967142]  bus_probe_device+0xa4/0xb0
> > [   69.968104]  device_add+0x3e8/0x910
> > [   69.969111]  nd_async_device_register+0x24/0x74
> > [   69.969928]  async_run_entry_fn+0x40/0x150
> > [   69.970725]  process_one_work+0x1dc/0x450
> > [   69.971796]  worker_thread+0x154/0x450
> > [   69.972700]  kthread+0x118/0x120
> > [   69.974141]  ret_from_fork+0x10/0x20
> > [   69.975141] ---[ end trace 0000000000000000 ]---
> > [   70.117887] Into nd_namespace_pmem_set_resource()  

