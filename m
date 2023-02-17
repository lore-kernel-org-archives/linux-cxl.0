Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDAE4C636D4
	for <linux-cxl@archiver.kernel.org>; Fri, 17 Feb 2023 11:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjBQLdb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 17 Feb 2023 06:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjBQLda (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 17 Feb 2023 06:33:30 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC76428D31
        for <linux-cxl@vger.kernel.org>; Fri, 17 Feb 2023 03:33:23 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PJ8hf41Mqz67MQj;
        Fri, 17 Feb 2023 19:28:50 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Fri, 17 Feb
 2023 11:33:21 +0000
Date:   Fri, 17 Feb 2023 11:33:20 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>
Subject: Re: Not enough CXL HDM decoders in pass through host bridges (sort
 of)
Message-ID: <20230217113320.000045fa@Huawei.com>
In-Reply-To: <63eeaa26a4ef1_32d61294cf@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230216183025.00000e39@huawei.com>
        <63eeaa26a4ef1_32d61294cf@dwillia2-xfh.jf.intel.com.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 16 Feb 2023 14:11:50 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Jonathan Cameron wrote:
> > Hi Dan,
> > 
> > I've finally been adding support for multiple HDM decoders in QEMU
> > (need to implement the address decode at EPs, but have it working at
> > HB and switch USP)
> > 
> > Whilst testing ran into a corner case on the kernel side of things.
> > 
> >            Host Bridge
> >                 |
> >             Root Port
> >                 |
> >            Switch USP
> >                 |   
> >         ________|_________       
> >        |                  |
> >      DSP0               DSP1
> >        |                  |
> >      Type3              Type3
> > 
> > 
> > Previously I'd been testing this with either an interleave across the two
> > Type3 devices or with just one in use (as I only had one HDM decoder in the SW USP
> > so couldn't handle anything else)
> > 
> > Now I have lots of decoders, I added a simple test with two regions. One on each of
> > the type 3 devices.
> > 
> > It fails on the second region (with a "no decoder available error") because...
> > 
> > It's trying to find an HDM decoder in the host bridge and the fake one used
> > for a pass through decoder is 'already in use' by the first region.
> > 
> > I'm not sure we can simply skip the check in this case because cxld->region
> > can only point at one region at a time and I haven't though through
> > the impacts of that for a pass through decoder.  The cynic in me says
> > that if this HB had more RPs, we'd have a maximum of 32 decoders, so
> > just fake 32 of them instead of 1 and not worry about it any more but
> > that feels like a hack and probably has side effects.
> > 
> > I thought I'd raise the issue first and think about a solution afterwards
> > (and secretly hope it is fixed before I get to it ;)).  
> 
> Hmm, in the case of no decoders in a host-bridge the root-decoders are
> effectively mirrored at that level. I.e. root-decoders already support
> the property of hosting multiple regions in a decoder so perhaps
> tunneling them in this case would be a better model then establishing a
> unique "passthrough decoder".

Agreed. Something along those lines would make sense.

> 
> > Obviously I can avoid the whole thing by adding an RP and hence have
> > actually decoders to use up on the host bridge which does fine for
> > testing my QEMU work, but we still need to fix this up - unless I'm missing
> > some subtlety.  
> 
> I just find it difficult to believe that someone will build decoder-less
> host bridges. The moment that you have multiple CFMWS windows to account
> for ram vs pmem, type-2 vs type-3, etc... then it mandates multiple
> distinct decoders at each level.

Not sure the spec does mandate them in the host bridge even with multiple CFMWS windows.

My reading is the assumption is that if the host is routing to the HB
(via a CFMWS) there is no need to decode at all. Everything just gets
forwarded through to the single RP. Interleave / type etc requires decoders
at the next level (either EP or switch USP)

> 
> At a minimum I think this problem can be solved at leisurely place
> unless someone can point to a non-QEMU example of such a platform to
> raise the urgency.

Sure - low priority for now (though I bet I get QEMU bug reports much
like we did before I made default to not have the decoders for this case
in the first place).
Could just make the kernel deal with a single RP HB that doesn't do pass
through.  Last time I checked that doesn't work yet (which is only reason
we have pass through decoders in QEMU).

> 
> > There is another question of whether we should make some effort to conserve
> > decoders - so if we can just expand an existing one to cover a wider range?
> > We can't do that after commit, but maybe there is a dance we could do to
> > soft commit a bunch of regions, then hard commit them as a set.
> > HDM decoders may be a precious resource on some systems even though CXL 3.0
> > let's host bridges have 32 of them.  One to tackle only when it's a real problem
> > though.  
> 
> How would that work a practice? A switch can only target multiple
> downstreams for a given address range if they are interleaved, and if
> they are interleaved it's a single region.
>

Simplest one is the topology above, but they've decided not to interleave
for whatever reason - perhaps different levels of resilience to errors.
OS decides to put the two devices next to each other in HPA space so only
one decoder is needed in the HB (two in the switch of course).  I haven't
checked if we support a BIOS having decided to do this.  I'm not that
worried about doing it in the OS as the HB probably has enough decoder to
avoid it.  Maybe we need t solve that long term, but let's wait for someone
to scream about it.

Jonathan


