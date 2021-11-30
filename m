Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC4BC433EF
	for <linux-cxl@archiver.kernel.org>; Tue, 30 Nov 2021 13:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhK3NNT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 30 Nov 2021 08:13:19 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4181 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbhK3NNT (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 30 Nov 2021 08:13:19 -0500
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4J3Msb52l7z67t3s;
        Tue, 30 Nov 2021 21:05:55 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Tue, 30 Nov 2021 14:09:57 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Tue, 30 Nov
 2021 13:09:57 +0000
Date:   Tue, 30 Nov 2021 13:09:56 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
CC:     Ben Widawsky <ben.widawsky@intel.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Saransh Gupta1 <saransh@ibm.com>, <qemu-devel@nongnu.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
        <shameerali.kolothum.thodi@huawei.com>
Subject: Re: Follow-up on the CXL discussion at OFTC
Message-ID: <20211130130956.00000ccd@Huawei.com>
In-Reply-To: <87mtlmzu3w.fsf@linaro.org>
References: <OF255704A1.78FEF164-ON0025878E.00821084-0025878F.00015560@ibm.com>
        <20211117165719.pqig62t5z2grgjvv@intel.com>
        <20211117173201.00002513@Huawei.com>
        <OF164E5BA6.E927FE73-ON00258791.0078E206-88258791.007ABBAD@ibm.com>
        <BY5PR12MB4179A47F68A9A15E5888D074E89B9@BY5PR12MB4179.namprd12.prod.outlook.com>
        <20211119014822.j247ayrsdve4yxyu@intel.com>
        <BY5PR12MB4179AA1B062AEA75098E15D8E89C9@BY5PR12MB4179.namprd12.prod.outlook.com>
        <20211119032541.gr6berwu2ve4tkax@intel.com>
        <8735njf6f7.fsf@linaro.org>
        <20211129171631.ytixckw2gz3rya25@intel.com>
        <87mtlmzu3w.fsf@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml733-chm.china.huawei.com (10.201.108.84) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 29 Nov 2021 18:28:43 +0000
Alex Bennée <alex.bennee@linaro.org> wrote:

> Ben Widawsky <ben.widawsky@intel.com> writes:
> 
> > On 21-11-26 12:08:08, Alex Bennée wrote:  
> >> 
> >> Ben Widawsky <ben.widawsky@intel.com> writes:
> >>   
> >> > On 21-11-19 02:29:51, Shreyas Shah wrote:  
> >> >> Hi Ben
> >> >> 
> >> >> Are you planning to add the CXL2.0 switch inside QEMU or already added in one of the version? 
> >> >>    
> >> >
> >> > From me, there are no plans for QEMU anything until/unless upstream thinks it
> >> > will merge the existing patches, or provide feedback as to what it would take to
> >> > get them merged. If upstream doesn't see a point in these patches, then I really
> >> > don't see much value in continuing to further them. Once hardware comes out, the
> >> > value proposition is certainly less.  
> >> 
> >> I take it:
> >> 
> >>   Subject: [RFC PATCH v3 00/31] CXL 2.0 Support
> >>   Date: Mon,  1 Feb 2021 16:59:17 -0800
> >>   Message-Id: <20210202005948.241655-1-ben.widawsky@intel.com>
> >> 
> >> is the current state of the support? I saw there was a fair amount of
> >> discussion on the thread so assumed there would be a v4 forthcoming at
> >> some point.  
> >
> > Hi Alex,
> >
> > There is a v4, however, we never really had a solid plan for the primary issue
> > which was around handling CXL memory expander devices properly (both from an
> > interleaving standpoint as well as having a device which hosts multiple memory
> > capacities, persistent and volatile). I didn't feel it was worth sending a v4
> > unless someone could say
> >
> > 1. we will merge what's there and fix later, or
> > 2. you must have a more perfect emulation in place, or
> > 3. we want to see usages for a real guest  
> 
> I think 1. is acceptable if the community is happy there will be ongoing
> development and it's not just a code dump. Given it will have a
> MAINTAINERS entry I think that is demonstrated.

My thought is also 1.  There are a few hacks we need to clean out but
nothing that should take too long.  I'm sure it'll take a rev or two more.
Right now for example, I've added support to arm-virt and maybe need to
move that over to a different machine model...

> 
> What's the current use case? Testing drivers before real HW comes out?
> Will it still be useful after real HW comes out for people wanting to
> debug things without HW?

CXL is continuing to expand in scope and capabilities and I don't see that
reducing any time soon (My guess is 3 years+ to just catch up with what is
under discussion today).  So I see two long term use cases:

1) Automated verification that we haven't broken things.  I suspect no
one person is going to have a test farm covering all the corner cases.
So we'll need emulation + firmware + kernel based testing.

2) New feature prove out.  We have already used it for some features that
will appear in the next spec version. Obviously I can't say what or
send that code out yet.  Its very useful and the spec draft has changed
in various ways a result.  I can't commit others, but Huawei will be
doing more of this going forwards.  For that we need a stable base to
which we add the new stuff once spec publication allows it.

> 
> >
> > I had hoped we could merge what was there mostly as is and fix it up as we go.
> > It's useful in the state it is now, and as time goes on, we find more usecases
> > for it in a VMM, and not just driver development.
> >  
> >> 
> >> Adding new subsystems to QEMU does seem to be a pain point for new
> >> contributors. Patches tend to fall through the cracks of existing
> >> maintainers who spend most of their time looking at stuff that directly
> >> touches their files. There is also a reluctance to merge large chunks of
> >> functionality without an identified maintainer (and maybe reviewers) who
> >> can be the contact point for new patches. So in short you need:
> >> 
> >>  - Maintainer Reviewed-by/Acked-by on patches that touch other sub-systems  
> >
> > This is the challenging one. I have Cc'd the relevant maintainers (hw/pci and
> > hw/mem are the two) in the past, but I think there interest is lacking (and
> > reasonably so, it is an entirely different subsystem).  
> 
> So the best approach to that is to leave a Cc: tag in the patch itself
> on your next posting so we can see the maintainer did see it but didn't
> contribute a review tag. This is also a good reason to keep Message-Id
> tags in patches so we can go back to the original threads.
> 
> So in my latest PR you'll see:
> 
>   Signed-off-by: Willian Rampazzo <willianr@redhat.com>
>   Reviewed-by: Beraldo Leal <bleal@redhat.com>
>   Message-Id: <20211122191124.31620-1-willianr@redhat.com>
>   Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>   Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>   Message-Id: <20211129140932.4115115-7-alex.bennee@linaro.org>
> 
> which shows the Message-Id from Willian's original posting and the
> latest Message-Id from my posting of the maintainer tree (I trim off my
> old ones).
> 
> >>  - Reviewed-by tags on the new sub-system patches from anyone who understands CXL  
> >
> > I have/had those from Jonathan.
> >  
> >>  - Some* in-tree testing (so it doesn't quietly bitrot)  
> >
> > We had this, but it's stale now. We can bring this back up.
> >  
> >>  - A patch adding the sub-system to MAINTAINERS with identified people  
> >
> > That was there too. Since the original posting, I'd be happy to sign Jonathan up
> > to this if he's willing.  
> 
> Sounds good to me.

Sure that's fine with me.  Ben, I'm assuming you are fine with being joint maintainer?

> 
> >> * Some means at least ensuring qtest can instantiate the device and not
> >>   fall over. Obviously more testing is better but it can always be
> >>   expanded on in later series.  
> >
> > This was in the patch series. It could use more testing for sure, but I had
> > basic functional testing in place via qtest.  
> 
> More is always better but the basic qtest does ensure a device doesn't
> segfault if it's instantiated.

I'll confess this is a bit I haven't looked at yet. Will get Shameer to give
me a hand.

Thanks

Jonathan


> 
> >  
> >> 
> >> Is that the feedback you were looking for?  
> >
> > You validated my assumptions as to what's needed, but your first bullet is the
> > one I can't seem to pin down.
> >
> > Thanks.
> > Ben  
> 
> 

