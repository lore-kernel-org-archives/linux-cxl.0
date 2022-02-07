Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124E1C43217
	for <linux-cxl@archiver.kernel.org>; Mon,  7 Feb 2022 15:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243804AbiBGP2s (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 7 Feb 2022 10:28:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443069AbiBGPKW (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 7 Feb 2022 10:10:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 75370C0401C5
        for <linux-cxl@vger.kernel.org>; Mon,  7 Feb 2022 07:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644246620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mtTdy4xIBlfAdZUmHlXSqagU/GHrBC6ynwM2vD77D9I=;
        b=g5OCkQiKE6bBPuM5yDqE8eQyFIyM0yoedxGcavS3vnpGJQinp33ja5NtqihKMwbjVw+UtS
        koeGRW7q2gWhix1yK5kwE0ETU6O6qpU7KGKKpmSagasBHTyc7vBEwtkz/yD26Hjul46TLP
        3aQNrf2GDssRbBMmsUXZu6HWvS3/mQs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-8-rUZZBS32OLuUfA8KInX5yQ-1; Mon, 07 Feb 2022 10:10:19 -0500
X-MC-Unique: rUZZBS32OLuUfA8KInX5yQ-1
Received: by mail-ej1-f71.google.com with SMTP id kw5-20020a170907770500b006ba314a753eso4411809ejc.21
        for <linux-cxl@vger.kernel.org>; Mon, 07 Feb 2022 07:10:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mtTdy4xIBlfAdZUmHlXSqagU/GHrBC6ynwM2vD77D9I=;
        b=y7KGAO5urwsVpuvUx+korUDf5rqI+KvyyNhOKlOuRsGvsOQh+aXGft5vaWf+8vfEZX
         lQpE/rpGhW6e0369zjjrj3i/9ewK8GLQh/bMFEFFnFY27Vy7L8Qh3aAgWyhgl3QAKZud
         Fd0M6woq0I7SWCISCJkIejHk/VNYo/1pXMkZGmdxdhIq7+sGKvtK432ecHg0THFk+/6s
         ZZ1TGqRC1qLYrrRYhO1VgdcXlGfNrMyUI5CFidhKG9kUSY+DeGpwy0ZtDW2Fk7gHxGAF
         VmeGsxjAqLxpLkCVYxHXQOP7bAS3wLtbpUfKUuEtlZSnGpCyNJT1D/4O1R+q6WfiddIB
         WyTQ==
X-Gm-Message-State: AOAM531EFMdnPJhPmhu9C2AJGreodfPbreqmimdvJthGYmwPMpUeGaoJ
        A+pxvida99Xyubuf+eDnStEJ5oVzX11RPfKCy1Zpq0lVQGeasXCNrVb8ht6KOSIdN73O3f2Fd5j
        e2qxzbSEDkilk2lM5VhAg
X-Received: by 2002:a05:6402:c15:: with SMTP id co21mr14146496edb.185.1644246617857;
        Mon, 07 Feb 2022 07:10:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxq68DJmXQSYmZBFMGcL5pn8BU9ocDTrTyR50VUoi9siZ2+t8YNDjUoTVXEd82GgTyFaIfspw==
X-Received: by 2002:a05:6402:c15:: with SMTP id co21mr14146478edb.185.1644246617620;
        Mon, 07 Feb 2022 07:10:17 -0800 (PST)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id h21sm1677209edt.26.2022.02.07.07.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 07:10:16 -0800 (PST)
Date:   Mon, 7 Feb 2022 16:10:14 +0100
From:   Igor Mammedov <imammedo@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        qemu-devel@nongnu.org,
        Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>,
        Marcel Apfelbaum <marcel@redhat.com>,
        linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Peter Maydell <peter.maydell@linaro.org>, linuxarm@huawei.com,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Philippe =?UTF-8?B?TWF0aGlldS1E?= =?UTF-8?B?YXVkw6k=?= 
        <f4bug@amsat.org>, Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        Samarth Saxena <samarths@cadence.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v5 16/43] tests/acpi: Add update DSDT.viot
Message-ID: <20220207161014.0689ba4a@redhat.com>
In-Reply-To: <20220204085953-mutt-send-email-mst@kernel.org>
References: <20220202141037.17352-1-Jonathan.Cameron@huawei.com>
        <20220202141037.17352-17-Jonathan.Cameron@huawei.com>
        <20220204085953-mutt-send-email-mst@kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 4 Feb 2022 09:01:31 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Feb 02, 2022 at 02:10:10PM +0000, Jonathan Cameron wrote:
> > From: Jonathan Cameron <jonathan.cameron@huawei.com>
> > 
> > The consolidation of DSDT AML generation for PCI host bridges
> > lead to some minor ordering changes and the addition of _ADR
> > with a default of 0 for those case that didn't already have it.
> > Only DSDT.viot test is affected.
> > 
> > Changes all similar to:
> > 
> > Scope (\_SB)
> >      {
> >        Device (PC30)
> >        {
> > -        Name (_UID, 0x30)  // _UID: Unique ID
> >          Name (_BBN, 0x30)  // _BBN: BIOS Bus Number
> >          Name (_HID, EisaId ("PNP0A08") /* PCI Express Bus */)  // _HID: Hardware ID
> >          Name (_CID, EisaId ("PNP0A03") /* PCI Bus */)  // _CID: Compatible ID
> > +        Name (_ADR, Zero)  // _ADR: Address
> > +        Name (_UID, 0x30)  // _UID: Unique ID
> >          Method (_OSC, 4, NotSerialized)  // _OSC: Operating System Capabilities
> > 
> > Signed-off-by: Jonathan Cameron <jonathan.cameron@huawei.com>  
> 
> A bit worried about _ADR here.  It's probably fine as it should be
> unused but in the past some changes like that confused windows guests
> where they would lose e.g. a static ip config since from their
> POV device address changed.

Spec[1] doesn't mention _ADR in context of host bridge(s) at all,
for all I know it shouldn't be there. QEMU inherited it from
SeaBIOS where it is dated to 2008 (as part of large blob adding ACPI for PCI).

Instead of spreading undefined field to other places,
I'd prefer removing it from root host bridge.
But as Michael said it should be very well tested with various guest
OSes.

Jonathan,
Can you compare nic naming (as guest sees it) with current master
and without _ADR on root host bridge?
One way to test it could be
  1. start QEMU(master) configure static IP addr on an interface,
     and shutdown guest
  2. start QEMU(-_ARR) with guest image from step 1 and see if
     interface is still there with IP address it was configured.

test matrix should be something like that:
 PCI(pc machine),PCI-E (q35 machine)/
   Windows 2012-whatever latest Windows, some contemporary linux,
   ancient linux (pre 'stable' interface naming) (something like
   RHEL6 or any other distro from that era)

1) PCI_Firmware_v3.2_01-26-2015_ts_clean_Firmware_Final

> Igor, what do you think?
>
> > ---
> >  tests/data/acpi/q35/DSDT.viot               | Bin 9398 -> 9416 bytes
> >  tests/qtest/bios-tables-test-allowed-diff.h |   1 -
> >  2 files changed, 1 deletion(-)
> > 
> > diff --git a/tests/data/acpi/q35/DSDT.viot b/tests/data/acpi/q35/DSDT.viot
> > index 1c3b4da5cbe81ecab5e1ef50d383b561c5e0f55f..207ac5b9ae4c3a4bc0094c2242d1a1b08771b784 100644
> > GIT binary patch
> > delta 139
> > zcmdnydBT&+CD<k8gbD)#<CBeCu5zLdVlnZ-PVv!A?xF$C#s(bmPELMY6KfQhxC}No
> > z$Z0Y1qbM*kn0!E9nwKNq(Itq1BR<sAg-ZdbOrCM_F9mK?rG^HRr4><?3V@Yv4pmBI
> > F0sxp4B{u*7
> > 
> > delta 143
> > zcmX@%xy_TyCD<ion+gL1<MNGMu5zMYqA~HoPVv!Aj-mn1#s(bmp`I>WlVjy%CeC%7
> > z+^Kj^(SX5#0jQdxl0g7Ptr1kM!sPw((lEse3<_8k8$uNeOjb|?Dc;<vXwM7)8)+to
> > 
> > diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> > index 08a8095432..dfb8523c8b 100644
> > --- a/tests/qtest/bios-tables-test-allowed-diff.h
> > +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> > @@ -1,2 +1 @@
> >  /* List of comma-separated changed AML files to ignore */
> > -"tests/data/acpi/q35/DSDT.viot",
> > -- 
> > 2.32.0  
> 

