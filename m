Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A251C433F5
	for <linux-cxl@archiver.kernel.org>; Mon, 29 Nov 2021 17:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbhK2RXl (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 29 Nov 2021 12:23:41 -0500
Received: from mga02.intel.com ([134.134.136.20]:27472 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346182AbhK2RVl (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 29 Nov 2021 12:21:41 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="223244220"
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="223244220"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 09:16:35 -0800
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="600267741"
Received: from dsshah-mobl2.amr.corp.intel.com (HELO intel.com) ([10.252.141.244])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 09:16:33 -0800
Date:   Mon, 29 Nov 2021 09:16:31 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc:     Shreyas Shah <shreyas.shah@elastics.cloud>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Saransh Gupta1 <saransh@ibm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: Follow-up on the CXL discussion at OFTC
Message-ID: <20211129171631.ytixckw2gz3rya25@intel.com>
References: <OF255704A1.78FEF164-ON0025878E.00821084-0025878F.00015560@ibm.com>
 <20211117165719.pqig62t5z2grgjvv@intel.com>
 <20211117173201.00002513@Huawei.com>
 <OF164E5BA6.E927FE73-ON00258791.0078E206-88258791.007ABBAD@ibm.com>
 <BY5PR12MB4179A47F68A9A15E5888D074E89B9@BY5PR12MB4179.namprd12.prod.outlook.com>
 <20211119014822.j247ayrsdve4yxyu@intel.com>
 <BY5PR12MB4179AA1B062AEA75098E15D8E89C9@BY5PR12MB4179.namprd12.prod.outlook.com>
 <20211119032541.gr6berwu2ve4tkax@intel.com>
 <8735njf6f7.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8735njf6f7.fsf@linaro.org>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21-11-26 12:08:08, Alex Bennée wrote:
> 
> Ben Widawsky <ben.widawsky@intel.com> writes:
> 
> > On 21-11-19 02:29:51, Shreyas Shah wrote:
> >> Hi Ben
> >> 
> >> Are you planning to add the CXL2.0 switch inside QEMU or already added in one of the version? 
> >>  
> >
> > From me, there are no plans for QEMU anything until/unless upstream thinks it
> > will merge the existing patches, or provide feedback as to what it would take to
> > get them merged. If upstream doesn't see a point in these patches, then I really
> > don't see much value in continuing to further them. Once hardware comes out, the
> > value proposition is certainly less.
> 
> I take it:
> 
>   Subject: [RFC PATCH v3 00/31] CXL 2.0 Support
>   Date: Mon,  1 Feb 2021 16:59:17 -0800
>   Message-Id: <20210202005948.241655-1-ben.widawsky@intel.com>
> 
> is the current state of the support? I saw there was a fair amount of
> discussion on the thread so assumed there would be a v4 forthcoming at
> some point.

Hi Alex,

There is a v4, however, we never really had a solid plan for the primary issue
which was around handling CXL memory expander devices properly (both from an
interleaving standpoint as well as having a device which hosts multiple memory
capacities, persistent and volatile). I didn't feel it was worth sending a v4
unless someone could say
1. we will merge what's there and fix later, or
2. you must have a more perfect emulation in place, or
3. we want to see usages for a real guest

I had hoped we could merge what was there mostly as is and fix it up as we go.
It's useful in the state it is now, and as time goes on, we find more usecases
for it in a VMM, and not just driver development.

> 
> Adding new subsystems to QEMU does seem to be a pain point for new
> contributors. Patches tend to fall through the cracks of existing
> maintainers who spend most of their time looking at stuff that directly
> touches their files. There is also a reluctance to merge large chunks of
> functionality without an identified maintainer (and maybe reviewers) who
> can be the contact point for new patches. So in short you need:
> 
>  - Maintainer Reviewed-by/Acked-by on patches that touch other sub-systems

This is the challenging one. I have Cc'd the relevant maintainers (hw/pci and
hw/mem are the two) in the past, but I think there interest is lacking (and
reasonably so, it is an entirely different subsystem).

>  - Reviewed-by tags on the new sub-system patches from anyone who understands CXL

I have/had those from Jonathan.

>  - Some* in-tree testing (so it doesn't quietly bitrot)

We had this, but it's stale now. We can bring this back up.

>  - A patch adding the sub-system to MAINTAINERS with identified people

That was there too. Since the original posting, I'd be happy to sign Jonathan up
to this if he's willing.

> 
> * Some means at least ensuring qtest can instantiate the device and not
>   fall over. Obviously more testing is better but it can always be
>   expanded on in later series.

This was in the patch series. It could use more testing for sure, but I had
basic functional testing in place via qtest.

> 
> Is that the feedback you were looking for?

You validated my assumptions as to what's needed, but your first bullet is the
one I can't seem to pin down.

Thanks.
Ben
