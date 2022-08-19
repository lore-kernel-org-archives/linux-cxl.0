Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72EA1C32771
	for <linux-cxl@archiver.kernel.org>; Fri, 19 Aug 2022 08:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347626AbiHSIrD (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 19 Aug 2022 04:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347760AbiHSIrB (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 19 Aug 2022 04:47:01 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A434C2747
        for <linux-cxl@vger.kernel.org>; Fri, 19 Aug 2022 01:46:59 -0700 (PDT)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M8FfC0q2pz689lt;
        Fri, 19 Aug 2022 16:43:47 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 19 Aug 2022 10:46:57 +0200
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 19 Aug
 2022 09:46:56 +0100
Date:   Fri, 19 Aug 2022 09:46:55 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Jonathan Cameron via <qemu-devel@nongnu.org>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Bobo WL <lmw.bobo@gmail.com>, <linux-cxl@vger.kernel.org>,
        <qemu-arm@nongnu.org>
Subject: Re: [BUG] cxl can not create region
Message-ID: <20220819094655.000005ed@huawei.com>
In-Reply-To: <20220818173740.00007f02@huawei.com>
References: <CAGr_yG0UrfJAMWta3EkR1F0JZ4j--sig74p6vKL3K6TZDx9YGA@mail.gmail.com>
        <62f132aee401b_1b3c294c@dwillia2-xfh.jf.intel.com.notmuch>
        <CAGr_yG389Bm_NL8CLgo_ZkGd4staocNENbtb-ULVA5vh_ywmcw@mail.gmail.com>
        <62f27a8e9acb6_1f18b294e2@dwillia2-xfh.jf.intel.com.notmuch>
        <62f5a2ffe8be0_3ce68294a4@dwillia2-xfh.jf.intel.com.notmuch>
        <20220817171619.000021ca@huawei.com>
        <20220818173740.00007f02@huawei.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 18 Aug 2022 17:37:40 +0100
Jonathan Cameron via <qemu-devel@nongnu.org> wrote:

> On Wed, 17 Aug 2022 17:16:19 +0100
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> 
> > On Thu, 11 Aug 2022 17:46:55 -0700
> > Dan Williams <dan.j.williams@intel.com> wrote:
> >   
> > > Dan Williams wrote:    
> > > > Bobo WL wrote:      
> > > > > Hi Dan,
> > > > > 
> > > > > Thanks for your reply!
> > > > > 
> > > > > On Mon, Aug 8, 2022 at 11:58 PM Dan Williams <dan.j.williams@intel.com> wrote:      
> > > > > >
> > > > > > What is the output of:
> > > > > >
> > > > > >     cxl list -MDTu -d decoder0.0
> > > > > >
> > > > > > ...? It might be the case that mem1 cannot be mapped by decoder0.0, or
> > > > > > at least not in the specified order, or that validation check is broken.      
> > > > > 
> > > > > Command "cxl list -MDTu -d decoder0.0" output:      
> > > > 
> > > > Thanks for this, I think I know the problem, but will try some
> > > > experiments with cxl_test first.      
> > > 
> > > Hmm, so my cxl_test experiment unfortunately passed so I'm not
> > > reproducing the failure mode. This is the result of creating x4 region
> > > with devices directly attached to a single host-bridge:
> > > 
> > > # cxl create-region -d decoder3.5 -w 4 -m -g 256 mem{12,10,9,11} -s $((1<<30))
> > > {
> > >   "region":"region8",
> > >   "resource":"0xf1f0000000",
> > >   "size":"1024.00 MiB (1073.74 MB)",
> > >   "interleave_ways":4,
> > >   "interleave_granularity":256,
> > >   "decode_state":"commit",
> > >   "mappings":[
> > >     {
> > >       "position":3,
> > >       "memdev":"mem11",
> > >       "decoder":"decoder21.0"
> > >     },
> > >     {
> > >       "position":2,
> > >       "memdev":"mem9",
> > >       "decoder":"decoder19.0"
> > >     },
> > >     {
> > >       "position":1,
> > >       "memdev":"mem10",
> > >       "decoder":"decoder20.0"
> > >     },
> > >     {
> > >       "position":0,
> > >       "memdev":"mem12",
> > >       "decoder":"decoder22.0"
> > >     }
> > >   ]
> > > }
> > > cxl region: cmd_create_region: created 1 region
> > >     
> > > > Did the commit_store() crash stop reproducing with latest cxl/preview
> > > > branch?      
> > > 
> > > I missed the answer to this question.
> > > 
> > > All of these changes are now in Linus' tree perhaps give that a try and
> > > post the debug log again?    
> > 
> > Hi Dan,
> > 
> > I've moved onto looking at this one.
> > 1 HB, 2RP (to make it configure the HDM decoder in the QEMU HB, I'll tidy that up
> > at some stage), 1 switch, 4 downstream switch ports each with a type 3
> > 
> > I'm not getting a crash, but can't successfully setup a region.
> > Upon adding the final target
> > It's failing in check_last_peer() as pos < distance.
> > Seems distance is 4 which makes me think it's using the wrong level of the heirarchy for
> > some reason or that distance check is wrong.
> > Wasn't a good idea to just skip that step though as it goes boom - though
> > stack trace is not useful.  
> 
> Turns out really weird corruption happens if you accidentally back two type3 devices
> with the same memory device. Who would have thought it :)
> 
> That aside ignoring the check_last_peer() failure seems to make everything work for this
> topology.  I'm not seeing the crash, so my guess is we fixed it somewhere along the way.
> 
> Now for the fun one.  I've replicated the crash if we have
> 
> 1HB 1*RP 1SW, 4SW-DSP, 4Type3
> 
> Now, I'd expect to see it not 'work' because the QEMU HDM decoder won't be programmed
> but the null pointer dereference isn't related to that.
> 
> The bug is straight forward.  Not all decoders have commit callbacks... Will send out
> a possible fix shortly.
> 
For completeness I'm carrying this hack because I haven't gotten my head
around the right fix for check_last_peer() failing on this test topology.

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index c49d9a5f1091..275e143bd748 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -978,7 +978,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
                                rc = check_last_peer(cxled, ep, cxl_rr,
                                                     distance);
                                if (rc)
-                                       return rc;
+                                       //      return rc;
                                goto out_target_set;
                        }
                goto add_target;
--

I might find more bugs with more testing, but this is all the ones I've
seen so far + in Bobo's reports.  Qemu fixes are now in upstream so
will be there in the release. 

As a reminder, testing on QEMU has a few corners...

Need a patch to add serial number ECAP support. It is on list for revew,
but will have wait for after QEMU 7.1 release (which may be next week)

QEMU still assumes HDM decoder on the host bridge will be programmed.
So if you want anything to work there should be at least
2 RP below the HB (no need to plug anything in to one of them).

I don't want to add a commandline parameter to hide the decoder in QEMU
and detecting there is only one RP would require moving a bunch of static
stuff into runtime code (I think).

I still think we should make the kernel check to see if there is a decoder,
but if not I might see how bad a hack it is to have QEMU ignore that decoder
if not committed in this one special case (HB HDM decoder with only one place
it can send stuff). Obviously that would be a break from specification
so less than idea!

Thanks,

Jonathan

