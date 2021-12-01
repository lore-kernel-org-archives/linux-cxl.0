Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556DEC433FE
	for <linux-cxl@archiver.kernel.org>; Wed,  1 Dec 2021 09:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348329AbhLAJ7D convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 1 Dec 2021 04:59:03 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4185 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242520AbhLAJ7A (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 1 Dec 2021 04:59:00 -0500
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4J3vZZ1rcZz67gvx;
        Wed,  1 Dec 2021 17:54:46 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Wed, 1 Dec 2021 10:55:35 +0100
Received: from localhost (10.52.125.180) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Wed, 1 Dec
 2021 09:55:34 +0000
Date:   Wed, 1 Dec 2021 09:55:32 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     Peter Maydell <peter.maydell@linaro.org>, <qemu-devel@nongnu.org>,
        "Saransh Gupta1" <saransh@ibm.com>,
        Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
        <shameerali.kolothum.thodi@huawei.com>
Subject: Re: Follow-up on the CXL discussion at OFTC
Message-ID: <20211201095532.000035d8@Huawei.com>
In-Reply-To: <20211130172158.kzuptl2pxlcgvzft@intel.com>
References: <20211117173201.00002513@Huawei.com>
        <OF164E5BA6.E927FE73-ON00258791.0078E206-88258791.007ABBAD@ibm.com>
        <BY5PR12MB4179A47F68A9A15E5888D074E89B9@BY5PR12MB4179.namprd12.prod.outlook.com>
        <20211119014822.j247ayrsdve4yxyu@intel.com>
        <BY5PR12MB4179AA1B062AEA75098E15D8E89C9@BY5PR12MB4179.namprd12.prod.outlook.com>
        <20211119032541.gr6berwu2ve4tkax@intel.com>
        <8735njf6f7.fsf@linaro.org>
        <20211129171631.ytixckw2gz3rya25@intel.com>
        <87mtlmzu3w.fsf@linaro.org>
        <20211130130956.00000ccd@Huawei.com>
        <20211130172158.kzuptl2pxlcgvzft@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.52.125.180]
X-ClientProxiedBy: lhreml738-chm.china.huawei.com (10.201.108.188) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 30 Nov 2021 09:21:58 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> On 21-11-30 13:09:56, Jonathan Cameron wrote:
> > On Mon, 29 Nov 2021 18:28:43 +0000
> > Alex Bennée <alex.bennee@linaro.org> wrote:
> >   
> > > Ben Widawsky <ben.widawsky@intel.com> writes:
> > >   
> > > > On 21-11-26 12:08:08, Alex Bennée wrote:    
> > > >> 
> > > >> Ben Widawsky <ben.widawsky@intel.com> writes:
> > > >>     
> > > >> > On 21-11-19 02:29:51, Shreyas Shah wrote:    
> > > >> >> Hi Ben
> > > >> >> 
> > > >> >> Are you planning to add the CXL2.0 switch inside QEMU or already added in one of the version? 
> > > >> >>      
> > > >> >
> > > >> > From me, there are no plans for QEMU anything until/unless upstream thinks it
> > > >> > will merge the existing patches, or provide feedback as to what it would take to
> > > >> > get them merged. If upstream doesn't see a point in these patches, then I really
> > > >> > don't see much value in continuing to further them. Once hardware comes out, the
> > > >> > value proposition is certainly less.    
> > > >> 
> > > >> I take it:
> > > >> 
> > > >>   Subject: [RFC PATCH v3 00/31] CXL 2.0 Support
> > > >>   Date: Mon,  1 Feb 2021 16:59:17 -0800
> > > >>   Message-Id: <20210202005948.241655-1-ben.widawsky@intel.com>
> > > >> 
> > > >> is the current state of the support? I saw there was a fair amount of
> > > >> discussion on the thread so assumed there would be a v4 forthcoming at
> > > >> some point.    
> > > >
> > > > Hi Alex,
> > > >
> > > > There is a v4, however, we never really had a solid plan for the primary issue
> > > > which was around handling CXL memory expander devices properly (both from an
> > > > interleaving standpoint as well as having a device which hosts multiple memory
> > > > capacities, persistent and volatile). I didn't feel it was worth sending a v4
> > > > unless someone could say
> > > >
> > > > 1. we will merge what's there and fix later, or
> > > > 2. you must have a more perfect emulation in place, or
> > > > 3. we want to see usages for a real guest    
> > > 
> > > I think 1. is acceptable if the community is happy there will be ongoing
> > > development and it's not just a code dump. Given it will have a
> > > MAINTAINERS entry I think that is demonstrated.  
> > 
> > My thought is also 1.  There are a few hacks we need to clean out but
> > nothing that should take too long.  I'm sure it'll take a rev or two more.
> > Right now for example, I've added support to arm-virt and maybe need to
> > move that over to a different machine model...
> >   
> 
> The most annoying thing about rebasing it is passing the ACPI tests. They keep
> changing upstream. Being able to at least merge up to there would be huge.

Guess I really need to take a look at the tests :)  It went in clean so
I didn't poke them. Maybe we were just lucky!  A bunch of ACPI infrastructure
had changed which was the biggest update needed + amusingly x86 kernel code now
triggers the issue around smaller writes than the implementation supports for
the mailbox.  For now I've just added the implementations as that removes
a blocker on this going upstream.

> 
> > > 
> > > What's the current use case? Testing drivers before real HW comes out?
> > > Will it still be useful after real HW comes out for people wanting to
> > > debug things without HW?  
> > 
> > CXL is continuing to expand in scope and capabilities and I don't see that
> > reducing any time soon (My guess is 3 years+ to just catch up with what is
> > under discussion today).  So I see two long term use cases:
> > 
> > 1) Automated verification that we haven't broken things.  I suspect no
> > one person is going to have a test farm covering all the corner cases.
> > So we'll need emulation + firmware + kernel based testing.
> >   
> 
> Does this exist in other forms? AFAICT for x86, there isn't much example of
> this.

We run a bunch of stuff internally on a CI farm, targetting various trees,
though this is a complex case because of more elements than most hardware tests
etc.  Our friends in openEuler run a bunch more stuff as well on a mixture of
physical and emulated machines on various architectures.  The other distros have
similar setups though perhaps don't provide as much public info as our folks do.
We are a bit early for CXL support so far so I don't think we have
yet moved beyond manual testing.  It'll come though as it's vital once customers
start caring about the hardware they bought.

Otherwise, if we contribute the resources there are various other orgs who
run tests on stable / mainline and next + various vendor trees. That stuff is
a mixture of real and virtual hardware and is used to verify stable releases
very quickly before Greg pushes them out.

Emulation based testing is easier obviously and we do some of that + I know others
do. Once the CXL support is upstream, adding all the tuning parameters to QEMU to
start exercising corner cases will be needed to support this. 

> 
> > 2) New feature prove out.  We have already used it for some features that
> > will appear in the next spec version. Obviously I can't say what or
> > send that code out yet.  Its very useful and the spec draft has changed
> > in various ways a result.  I can't commit others, but Huawei will be
> > doing more of this going forwards.  For that we need a stable base to
> > which we add the new stuff once spec publication allows it.
> >   
> 
> I can't commit for Intel but I will say there's more latitude now to work on
> projects like this compared to when I first wrote the patches. I have
> interesting in continuing to develop this as well. I'm very interested in
> supporting interleave and hotplug specifically.

Great. 

> 
> > >   
> > > >
> > > > I had hoped we could merge what was there mostly as is and fix it up as we go.
> > > > It's useful in the state it is now, and as time goes on, we find more usecases
> > > > for it in a VMM, and not just driver development.
> > > >    
> > > >> 
> > > >> Adding new subsystems to QEMU does seem to be a pain point for new
> > > >> contributors. Patches tend to fall through the cracks of existing
> > > >> maintainers who spend most of their time looking at stuff that directly
> > > >> touches their files. There is also a reluctance to merge large chunks of
> > > >> functionality without an identified maintainer (and maybe reviewers) who
> > > >> can be the contact point for new patches. So in short you need:
> > > >> 
> > > >>  - Maintainer Reviewed-by/Acked-by on patches that touch other sub-systems    
> > > >
> > > > This is the challenging one. I have Cc'd the relevant maintainers (hw/pci and
> > > > hw/mem are the two) in the past, but I think there interest is lacking (and
> > > > reasonably so, it is an entirely different subsystem).    
> > > 
> > > So the best approach to that is to leave a Cc: tag in the patch itself
> > > on your next posting so we can see the maintainer did see it but didn't
> > > contribute a review tag. This is also a good reason to keep Message-Id
> > > tags in patches so we can go back to the original threads.
> > > 
> > > So in my latest PR you'll see:
> > > 
> > >   Signed-off-by: Willian Rampazzo <willianr@redhat.com>
> > >   Reviewed-by: Beraldo Leal <bleal@redhat.com>
> > >   Message-Id: <20211122191124.31620-1-willianr@redhat.com>
> > >   Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> > >   Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> > >   Message-Id: <20211129140932.4115115-7-alex.bennee@linaro.org>
> > > 
> > > which shows the Message-Id from Willian's original posting and the
> > > latest Message-Id from my posting of the maintainer tree (I trim off my
> > > old ones).
> > >   
> > > >>  - Reviewed-by tags on the new sub-system patches from anyone who understands CXL    
> > > >
> > > > I have/had those from Jonathan.
> > > >    
> > > >>  - Some* in-tree testing (so it doesn't quietly bitrot)    
> > > >
> > > > We had this, but it's stale now. We can bring this back up.
> > > >    
> > > >>  - A patch adding the sub-system to MAINTAINERS with identified people    
> > > >
> > > > That was there too. Since the original posting, I'd be happy to sign Jonathan up
> > > > to this if he's willing.    
> > > 
> > > Sounds good to me.  
> > 
> > Sure that's fine with me.  Ben, I'm assuming you are fine with being joint maintainer?
> >   
> 
> Yes, I brought it up :D. Once I land the region creation patches I should have
> more time for a bit to circle back to this, which I'd like to do. FOSDEM CFP is
> out again, perhaps I should advertise there.

Great!

> 
> > >   
> > > >> * Some means at least ensuring qtest can instantiate the device and not
> > > >>   fall over. Obviously more testing is better but it can always be
> > > >>   expanded on in later series.    
> > > >
> > > > This was in the patch series. It could use more testing for sure, but I had
> > > > basic functional testing in place via qtest.    
> > > 
> > > More is always better but the basic qtest does ensure a device doesn't
> > > segfault if it's instantiated.  
> > 
> > I'll confess this is a bit I haven't looked at yet. Will get Shameer to give
> > me a hand.
> > 
> > Thanks  
> 
> I'd certainly feel better if we had more tests. I also suspect the qtest I wrote
> originally no longer works. The biggest challenge I had was getting gitlab CI
> working for me.

Looks like it'll be tests that slow things down. *sigh*.

Why are there not enough days in the week?

Jonathan

> 
> > 
> > Jonathan
> > 
> >   
> > >   
> > > >    
> > > >> 
> > > >> Is that the feedback you were looking for?    
> > > >
> > > > You validated my assumptions as to what's needed, but your first bullet is the
> > > > one I can't seem to pin down.
> > > >
> > > > Thanks.
> > > > Ben    
> > > 
> > >   
> >   
> 

