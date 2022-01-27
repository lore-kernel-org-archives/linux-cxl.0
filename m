Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60E5C433EF
	for <linux-cxl@archiver.kernel.org>; Thu, 27 Jan 2022 14:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237306AbiA0OMn (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 27 Jan 2022 09:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242264AbiA0OMl (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 27 Jan 2022 09:12:41 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5D9C061714
        for <linux-cxl@vger.kernel.org>; Thu, 27 Jan 2022 06:12:40 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id ah7so6171036ejc.4
        for <linux-cxl@vger.kernel.org>; Thu, 27 Jan 2022 06:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=KLTW43m14STAUOT82UxdiR7lbPM9jRR2XlYTsv+pZb8=;
        b=LSKiQNQ/QDgcXDk80fCC+vPvJCCtK4mCR6QO+86xQG0j3STLd3VHVNLvfxMcaNfvfU
         8x0fZYewSKI0Lp2TAiU0Dbd2yexqmNKVJCeN9DZwLjF5Z4WH7b1UEh39MvxEDIa7Zz4/
         QyfVlYh1ORz8cE+cpW5+nHY/pgsuKor8o4aRwtiCjK3vOa21tx1hV3VmmnM2Vadmp4gI
         7HNAwOQBZnBPrEcsg+sw2hHZLCQEkQ1eFmg5xXa57TOYUl7n4l1YSs2NTM1PnEKO0NCZ
         ZU5JnYyHzmF7eMqsfqFpHf0jGSkMnfbMF8feZpqHQZEBdeIz8tkwwwVH7c5GtuwjZ3iC
         rvPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=KLTW43m14STAUOT82UxdiR7lbPM9jRR2XlYTsv+pZb8=;
        b=nNF066Me4Q3xhfjpGsyISyegpKZielnu868GJDGi6b5Hv3G+4MGzcBL1XLEPf0BRRT
         wEjwtfAr9YWmdlDBoAurh1UBvvvDpqQ1Jf18UywFIZ7/oiowGso282mDY7iK3R/yDc5t
         e6D6+g0vnaXQt0CgKeHVsu5iOQIFAXXdgzkEyuJMgBP2Wr/9KTQbNWHYUEIcuq0m/mXl
         7Rbn3vQxfXP9Fi6YT/ObIMpnWNXRxDH4jv4DW7zGgKmFQMnAf0LJ9fzRGaZJK7tJztOL
         ZhGeF9222AgSvCg71D9omNIX8MC+fLZZ5yL/J6JPwwwErKKXqfU/M/hKKJkT9VIvWiaO
         2F7g==
X-Gm-Message-State: AOAM531RV2UPyFw0rLQISS9pCe6LLOR4JHUbdIBISHDTMAtLlH+mc+Ap
        ZE3Otf2BKzNG5UgTqztm0ei5tQ==
X-Google-Smtp-Source: ABdhPJxRAYsYL5RpikAUlTxLEzPGj4fGnku4zZ0OeqxLswk+XuLJqQDV02jMOOSuyJl7sVPR1NMjRA==
X-Received: by 2002:a17:906:938f:: with SMTP id l15mr3028131ejx.99.1643292759195;
        Thu, 27 Jan 2022 06:12:39 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id by22sm8777166ejb.84.2022.01.27.06.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 06:12:38 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id 7A7F61FFB7;
        Thu, 27 Jan 2022 14:12:37 +0000 (GMT)
References: <20220124171705.10432-1-Jonathan.Cameron@huawei.com>
 <20220124171705.10432-17-Jonathan.Cameron@huawei.com>
User-agent: mu4e 1.7.6; emacs 28.0.91
From:   Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>, linux-cxl@vger.kernel.org,
        Ben Widawsky <ben.widawsky@intel.com>,
        Peter Maydell <peter.maydell@linaro.org>, linuxarm@huawei.com,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        Samarth Saxena <samarths@cadence.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v4 16/42] tests/acpi: Add update DSDT.viot
Date:   Thu, 27 Jan 2022 14:12:24 +0000
In-reply-to: <20220124171705.10432-17-Jonathan.Cameron@huawei.com>
Message-ID: <871r0t9siy.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

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
>          Name (_HID, EisaId ("PNP0A08") /* PCI Express Bus */)  // _HID: =
Hardware ID
>          Name (_CID, EisaId ("PNP0A03") /* PCI Bus */)  // _CID: Compatib=
le ID
> +        Name (_ADR, Zero)  // _ADR: Address
> +        Name (_UID, 0x30)  // _UID: Unique ID
>          Method (_OSC, 4, NotSerialized)  // _OSC: Operating System Capab=
ilities
>
> Signed-off-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> ---
>  tests/data/acpi/q35/DSDT.viot               | Bin 9398 -> 9416 bytes
>  tests/qtest/bios-tables-test-allowed-diff.h |   1 -
>  2 files changed, 1 deletion(-)
>
> diff --git a/tests/data/acpi/q35/DSDT.viot b/tests/data/acpi/q35/DSDT.viot
> index 1c3b4da5cbe81ecab5e1ef50d383b561c5e0f55f..207ac5b9ae4c3a4bc0094c224=
2d1a1b08771b784 100644
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
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bi=
os-tables-test-allowed-diff.h
> index 08a8095432..dfb8523c8b 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1,2 +1 @@
>  /* List of comma-separated changed AML files to ignore */
> -"tests/data/acpi/q35/DSDT.viot",

squash with the change please.

--=20
Alex Benn=C3=A9e
