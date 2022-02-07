Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55E1C433EF
	for <linux-cxl@archiver.kernel.org>; Mon,  7 Feb 2022 18:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235653AbiBGSWR (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 7 Feb 2022 13:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237004AbiBGSTW (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 7 Feb 2022 13:19:22 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274F3C0401D9
        for <linux-cxl@vger.kernel.org>; Mon,  7 Feb 2022 10:19:21 -0800 (PST)
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JsvXZ3P5jz67Lqc;
        Tue,  8 Feb 2022 02:18:38 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Mon, 7 Feb 2022 19:19:19 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 7 Feb
 2022 18:19:17 +0000
Date:   Mon, 7 Feb 2022 18:19:16 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Igor Mammedov <imammedo@redhat.com>
CC:     "Michael S. Tsirkin" <mst@redhat.com>, <qemu-devel@nongnu.org>,
        Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
        Marcel Apfelbaum <marcel@redhat.com>,
        <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        <linuxarm@huawei.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Philippe =?ISO-8859-1?Q?Mathieu-D?= =?ISO-8859-1?Q?aud=E9?= 
        <f4bug@amsat.org>, Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        Samarth Saxena <samarths@cadence.com>,
        "Dan Williams" <dan.j.williams@intel.com>
Subject: Re: [PATCH v5 16/43] tests/acpi: Add update DSDT.viot
Message-ID: <20220207181916.00004e7c@Huawei.com>
In-Reply-To: <20220207161014.0689ba4a@redhat.com>
References: <20220202141037.17352-1-Jonathan.Cameron@huawei.com>
        <20220202141037.17352-17-Jonathan.Cameron@huawei.com>
        <20220204085953-mutt-send-email-mst@kernel.org>
        <20220207161014.0689ba4a@redhat.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml733-chm.china.huawei.com (10.201.108.84) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 7 Feb 2022 16:10:14 +0100
Igor Mammedov <imammedo@redhat.com> wrote:

> On Fri, 4 Feb 2022 09:01:31 -0500
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Wed, Feb 02, 2022 at 02:10:10PM +0000, Jonathan Cameron wrote:  
> > > From: Jonathan Cameron <jonathan.cameron@huawei.com>
> > > 
> > > The consolidation of DSDT AML generation for PCI host bridges
> > > lead to some minor ordering changes and the addition of _ADR
> > > with a default of 0 for those case that didn't already have it.
> > > Only DSDT.viot test is affected.
> > > 
> > > Changes all similar to:
> > > 
> > > Scope (\_SB)
> > >      {
> > >        Device (PC30)
> > >        {
> > > -        Name (_UID, 0x30)  // _UID: Unique ID
> > >          Name (_BBN, 0x30)  // _BBN: BIOS Bus Number
> > >          Name (_HID, EisaId ("PNP0A08") /* PCI Express Bus */)  // _HID: Hardware ID
> > >          Name (_CID, EisaId ("PNP0A03") /* PCI Bus */)  // _CID: Compatible ID
> > > +        Name (_ADR, Zero)  // _ADR: Address
> > > +        Name (_UID, 0x30)  // _UID: Unique ID
> > >          Method (_OSC, 4, NotSerialized)  // _OSC: Operating System Capabilities
> > > 
> > > Signed-off-by: Jonathan Cameron <jonathan.cameron@huawei.com>    
> > 
> > A bit worried about _ADR here.  It's probably fine as it should be
> > unused but in the past some changes like that confused windows guests
> > where they would lose e.g. a static ip config since from their
> > POV device address changed.  
> 
> Spec[1] doesn't mention _ADR in context of host bridge(s) at all,
> for all I know it shouldn't be there. QEMU inherited it from
> SeaBIOS where it is dated to 2008 (as part of large blob adding ACPI for PCI).
> 
> Instead of spreading undefined field to other places,
> I'd prefer removing it from root host bridge.
> But as Michael said it should be very well tested with various guest
> OSes.
> 
> Jonathan,
> Can you compare nic naming (as guest sees it) with current master
> and without _ADR on root host bridge?
> One way to test it could be
>   1. start QEMU(master) configure static IP addr on an interface,
>      and shutdown guest
>   2. start QEMU(-_ARR) with guest image from step 1 and see if
>      interface is still there with IP address it was configured.
> 
> test matrix should be something like that:
>  PCI(pc machine),PCI-E (q35 machine)/
>    Windows 2012-whatever latest Windows, some contemporary linux,
>    ancient linux (pre 'stable' interface naming) (something like
>    RHEL6 or any other distro from that era)

Hi Igor,

Potentially long term I can run those tests, but short term I'd like
to separate this tidy up from introducing the CXL support.

The tidy up / deduplication is rather less useful than when
first introduced now we've decided to only implement CXL support
for PXBs for the short term. Earlier versions included
the main host bridge on x86 which made this change more helpful.

Thanks for the info on what it would require and
I will hopefully get to this once the CXL emulation is in
place (or someone else will beat me to it!)  Not going to be
terribly near the top of my todo list though I'm afraid.

Result for v6 will be that patches 14-16 are dropped and a few changes
to later patches as a result.

Thanks,

Jonathan



> 
> 1) PCI_Firmware_v3.2_01-26-2015_ts_clean_Firmware_Final
> 
> > Igor, what do you think?
> >  
> > > ---
> > >  tests/data/acpi/q35/DSDT.viot               | Bin 9398 -> 9416 bytes
> > >  tests/qtest/bios-tables-test-allowed-diff.h |   1 -
> > >  2 files changed, 1 deletion(-)
> > > 
> > > diff --git a/tests/data/acpi/q35/DSDT.viot b/tests/data/acpi/q35/DSDT.viot
> > > index 1c3b4da5cbe81ecab5e1ef50d383b561c5e0f55f..207ac5b9ae4c3a4bc0094c2242d1a1b08771b784 100644
> > > GIT binary patch
> > > delta 139
> > > zcmdnydBT&+CD<k8gbD)#<CBeCu5zLdVlnZ-PVv!A?xF$C#s(bmPELMY6KfQhxC}No
> > > z$Z0Y1qbM*kn0!E9nwKNq(Itq1BR<sAg-ZdbOrCM_F9mK?rG^HRr4><?3V@Yv4pmBI
> > > F0sxp4B{u*7
> > > 
> > > delta 143
> > > zcmX@%xy_TyCD<ion+gL1<MNGMu5zMYqA~HoPVv!Aj-mn1#s(bmp`I>WlVjy%CeC%7
> > > z+^Kj^(SX5#0jQdxl0g7Ptr1kM!sPw((lEse3<_8k8$uNeOjb|?Dc;<vXwM7)8)+to
> > > 
> > > diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> > > index 08a8095432..dfb8523c8b 100644
> > > --- a/tests/qtest/bios-tables-test-allowed-diff.h
> > > +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> > > @@ -1,2 +1 @@
> > >  /* List of comma-separated changed AML files to ignore */
> > > -"tests/data/acpi/q35/DSDT.viot",
> > > -- 
> > > 2.32.0    
> >   
> 

