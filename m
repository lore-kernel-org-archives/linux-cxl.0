Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3916CC64EC7
	for <linux-cxl@archiver.kernel.org>; Tue, 28 Feb 2023 11:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjB1LNX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 28 Feb 2023 06:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjB1LNW (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 28 Feb 2023 06:13:22 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61835193F1
        for <linux-cxl@vger.kernel.org>; Tue, 28 Feb 2023 03:13:21 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PQvBG6Y5pz688J2;
        Tue, 28 Feb 2023 18:44:22 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 28 Feb
 2023 10:49:17 +0000
Date:   Tue, 28 Feb 2023 10:49:16 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     =?ISO-8859-1?Q?J=F8rgen?= Hansen <Jorgen.Hansen@wdc.com>
CC:     Gregory Price <gregory.price@memverge.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [RFC] CXL: TCG/KVM instruction alignment issue discussion
 default
Message-ID: <20230228104916.00003d9a@Huawei.com>
In-Reply-To: <b066510e-8420-26ba-019b-fef2b255634e@wdc.com>
References: <Y/Cm5nuJl3G2CG2p@memverge.com>
        <b066510e-8420-26ba-019b-fef2b255634e@wdc.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 27 Feb 2023 11:06:47 +0000
Jørgen Hansen <Jorgen.Hansen@wdc.com> wrote:

> On 2/18/23 11:22, Gregory Price wrote:
> > Breaking this off into a separate thread for archival sake.
> > 
> > There's a bug with handling execution of instructions held in CXL
> > memory - specifically when an instruction crosses a page boundary.
> > 
> > The result of this is that type-3 devices cannot use KVM at all at the
> > moment, and require the attached patch to run in TCG-only mode.
> > 
> > 
> > CXL memory devices are presently emulated as MMIO, and MMIO has no
> > coherency guarantees, so TCG doesn't cache the results of translating
> > an instruction, meaning execution is incredibly slow (orders of
> > magnitude slower than KVM).
> > 
> > 
> > Request for comments:
> > 
> > 
> > First there's the stability issue:
> > 
> > 0) TCG cannot handle instructions across a page boundary spanning ram and
> >     MMIO. See attached patch for hotfix.  This basically solves the page
> >     boundary issue by reverting the entire block to MMIO-mode if the
> >     problem is detected.
> > 
> > 1) KVM needs to be investigated.  It's likely the same/similar issue,
> >     but it's not confirmed.  
> 
> I ran into an issue with KVM as well. However, it wasn't a page boundary 
> spanning issue, since I could hit it when using pure CXL backed memory 
> for a given application. It turned out that (at least) certain AVX 
> instructions didn't handle execution from MMIO when using qemu. This 
> generated an illegal instruction exception for the application. At that 
> point, I switched to tcg, so I didn't investigate if running a non-AVX 
> system would work with KVM.

Short term I'm wondering if we should attempt to error out on KVM
unless some override parameter is used alongside the main cxl=on

> 
> > Second there's the performance issue:
> > 
> > 0) Do we actually care about performance? How likely are users to
> >     attempt to run software out of CXL memory?
> > 
> > 1) If we do care, is there a potential for converting CXL away from the
> >     MMIO design?  The issue is coherency for shared memory. Emulating
> >     coherency is a) hard, and b) a ton of work for little gain.
> > 
> >     Presently marking CXL memory as MMIO basically enforces coherency by
> >     preventing caching, though it's unclear how this is enforced
> >     by KVM (or if it is, i have to imagine it is).   
> 
> Having the option of doing device specific processing of accesses to a 
> CXL type 3 device (that the MMIO based access allows) is useful for 
> experimentation with device functionality, so I would be sad to see that 
> option go away. Emulating cache line access to a type 3 device would be 
> interesting, and could potentially be implemented in a way that would 
> allow caching of device memory in a shadow page in RAM, but that it a 
> rather large project.

Absolutely agree.  Can sketch a solution that is entirely in QEMU and
works with KVM on a white board, but it doesn't feel like a small job
to actually implement it and I'm sure there are nasty corners
(persistency is going to be tricky) 

If anyone sees this as a 'fun challenge' and wants to take it on though
that would be great!

Jonathan

> 
> > It might be nice to solve this for non-shared memory regions, but
> > testing functionality >>> performance at this point so it might not
> > worth the investment.  
> 
> Thanks,
> Jorgen

