Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04AC8C433EF
	for <linux-cxl@archiver.kernel.org>; Fri,  4 Feb 2022 14:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359186AbiBDOBj (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 4 Feb 2022 09:01:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:50281 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1359197AbiBDOBj (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 4 Feb 2022 09:01:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643983298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wr44KBhJZAlMzB2mYfUkvIx625L/JEnm/ilbcFSSFJ0=;
        b=gEml7aQQIX0Kuy/Uh7tziGzk24UIfYgeTTMG+uSIxmNhVlooLzlbZrbosscV2eC+KXHbro
        T9LDhTMaYKE0gfF6zxLdsDLny1zzDtoq1NMP51aZOJw51zPx3qBda7bSiOPUV8vbj9lCjQ
        XH4IWa4t+Eg9Lg+ucrnZe3KG5AAdB5w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-205--IOgHjM7P9OWt9IQofVX0w-1; Fri, 04 Feb 2022 09:01:37 -0500
X-MC-Unique: -IOgHjM7P9OWt9IQofVX0w-1
Received: by mail-wr1-f71.google.com with SMTP id r2-20020adfa142000000b001e176ac1ec3so2067579wrr.3
        for <linux-cxl@vger.kernel.org>; Fri, 04 Feb 2022 06:01:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wr44KBhJZAlMzB2mYfUkvIx625L/JEnm/ilbcFSSFJ0=;
        b=1I+Q091/4QlDsoVz06SJ2Pl0F4CpREi4aWdeiF5OMZyeNJuhDsCI7aJeRi5en4YZ6S
         ji+yZN6F539LPzgbvaK3bMJ/bWR6NgOl8j7FEykyTyM3QpeKviSb3ttbLoWEBoYIruw6
         we1r32LJYewsuWNETuN0bl3r+yJ8GJ1/OJLf/HY+bPqn4jw7/JUFOOk390wnW7qDQe2S
         wwbUBGVffUFJhoRFOX1T8xTfOKYL7OYQGKk3vPGfPaTdBM+6hgMTp5vsIMSLTzGL3zjY
         bI24sxus1VRThlm0MPLtSQw3bipy7V64/ho60XEbqE41+wVRKcgoCuBkO+beGAkOrSyB
         GPQw==
X-Gm-Message-State: AOAM533cE+gg1NGbMBOeZ2lw5hCVS2sng1wh2SH/o3NJShmflUy6m+jx
        CoTAi6KNqVS7bHEOn8SKYaA0p3saGyGo0fK665rSEiV6p+tep4MJI1mqSDSSyYQrnmJjo6zQYzp
        GVbr8O1HhM3ctsPP3tPB/
X-Received: by 2002:a1c:4484:: with SMTP id r126mr1703968wma.26.1643983296342;
        Fri, 04 Feb 2022 06:01:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw4vxcDLw2avmIa/GSkgZ57y5FAFHMlJBeXuR9GY6/I+tq4UNNIvqt0ly336LScz55EktdR2w==
X-Received: by 2002:a1c:4484:: with SMTP id r126mr1703946wma.26.1643983296028;
        Fri, 04 Feb 2022 06:01:36 -0800 (PST)
Received: from redhat.com ([2a10:8005:331d:0:5c51:c095:613e:277c])
        by smtp.gmail.com with ESMTPSA id o12sm2371993wry.115.2022.02.04.06.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 06:01:35 -0800 (PST)
Date:   Fri, 4 Feb 2022 09:01:31 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     qemu-devel@nongnu.org,
        Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
        Marcel Apfelbaum <marcel@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>, linux-cxl@vger.kernel.org,
        Ben Widawsky <ben.widawsky@intel.com>,
        Peter Maydell <peter.maydell@linaro.org>, linuxarm@huawei.com,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        Samarth Saxena <samarths@cadence.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v5 16/43] tests/acpi: Add update DSDT.viot
Message-ID: <20220204085953-mutt-send-email-mst@kernel.org>
References: <20220202141037.17352-1-Jonathan.Cameron@huawei.com>
 <20220202141037.17352-17-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20220202141037.17352-17-Jonathan.Cameron@huawei.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Feb 02, 2022 at 02:10:10PM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <jonathan.cameron@huawei.com>
> 
> The consolidation of DSDT AML generation for PCI host bridges
> lead to some minor ordering changes and the addition of _ADR
> with a default of 0 for those case that didn't already have it.
> Only DSDT.viot test is affected.
> 
> Changes all similar to:
> 
> Scope (\_SB)
>      {
>        Device (PC30)
>        {
> -        Name (_UID, 0x30)  // _UID: Unique ID
>          Name (_BBN, 0x30)  // _BBN: BIOS Bus Number
>          Name (_HID, EisaId ("PNP0A08") /* PCI Express Bus */)  // _HID: Hardware ID
>          Name (_CID, EisaId ("PNP0A03") /* PCI Bus */)  // _CID: Compatible ID
> +        Name (_ADR, Zero)  // _ADR: Address
> +        Name (_UID, 0x30)  // _UID: Unique ID
>          Method (_OSC, 4, NotSerialized)  // _OSC: Operating System Capabilities
> 
> Signed-off-by: Jonathan Cameron <jonathan.cameron@huawei.com>

A bit worried about _ADR here.  It's probably fine as it should be
unused but in the past some changes like that confused windows guests
where they would lose e.g. a static ip config since from their
POV device address changed.

Igor, what do you think?

> ---
>  tests/data/acpi/q35/DSDT.viot               | Bin 9398 -> 9416 bytes
>  tests/qtest/bios-tables-test-allowed-diff.h |   1 -
>  2 files changed, 1 deletion(-)
> 
> diff --git a/tests/data/acpi/q35/DSDT.viot b/tests/data/acpi/q35/DSDT.viot
> index 1c3b4da5cbe81ecab5e1ef50d383b561c5e0f55f..207ac5b9ae4c3a4bc0094c2242d1a1b08771b784 100644
> GIT binary patch
> delta 139
> zcmdnydBT&+CD<k8gbD)#<CBeCu5zLdVlnZ-PVv!A?xF$C#s(bmPELMY6KfQhxC}No
> z$Z0Y1qbM*kn0!E9nwKNq(Itq1BR<sAg-ZdbOrCM_F9mK?rG^HRr4><?3V@Yv4pmBI
> F0sxp4B{u*7
> 
> delta 143
> zcmX@%xy_TyCD<ion+gL1<MNGMu5zMYqA~HoPVv!Aj-mn1#s(bmp`I>WlVjy%CeC%7
> z+^Kj^(SX5#0jQdxl0g7Ptr1kM!sPw((lEse3<_8k8$uNeOjb|?Dc;<vXwM7)8)+to
> 
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index 08a8095432..dfb8523c8b 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1,2 +1 @@
>  /* List of comma-separated changed AML files to ignore */
> -"tests/data/acpi/q35/DSDT.viot",
> -- 
> 2.32.0

