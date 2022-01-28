Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1303FC433F5
	for <linux-cxl@archiver.kernel.org>; Fri, 28 Jan 2022 18:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbiA1SgC (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 28 Jan 2022 13:36:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343654AbiA1SgB (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 28 Jan 2022 13:36:01 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1AFC061714
        for <linux-cxl@vger.kernel.org>; Fri, 28 Jan 2022 10:36:01 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id i187-20020a1c3bc4000000b0034d2ed1be2aso8806772wma.1
        for <linux-cxl@vger.kernel.org>; Fri, 28 Jan 2022 10:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=DH9MJLfbsqAgkpSYjEYYm76W7i2dSAdVQ+Nt2JwiGEE=;
        b=orrTiYmwbS3sTTcXz2j5S9dfDKhb5R4MwvLOOObQzAIN9kxHO1ckoWNUFR69NXiCFh
         gTZX7TMvQeRG8RUV+qWVc1Ayu69nUnaERPdtH9tnVaZcjLgEbTtRJxx4y6uWp0sAtXsD
         2XfRGQl8SbxXMHm33tvCbFkdH7XRgMI86nzWKRfNw8tcVZbgEGhIWrWl0kS8qC3DYJw7
         fp9HZTfG7ZE9cUzu1z/SzZphsNywwq1gX3kvA+aF/xAiLy5g3wlqz91+lUFPYpY9rJEO
         wPhXLisd/tbcNVPIj/pBWm4Ji1dYvOTfQyPJo+ygOjVdAd5qqbcEayBeExyOzAzzfJys
         u75g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=DH9MJLfbsqAgkpSYjEYYm76W7i2dSAdVQ+Nt2JwiGEE=;
        b=Db4ASRxtxXhakDcoSVeEjOQPuZEftKG+3D8A6s++jQtN/CUBbS14nMBVicioEbG97T
         Q47GtpKVAJO+z/MlhByi6+TNzeYe/yBWNyWatnXQt+YDvpwrvqZfiL4e3J+nvWVkVit6
         yEscARJkaONU3e8bZPPal9vghw5TggcQj1Hzf2JXSvArSLNb4bB4s4Cy0eHfZ+OeAyEM
         cQfkIWd2HQW6dTg1nbaWBvfgUjeVYavZphJF5Olv1JJUnD+gRmqDD+XVPxRA+311Au8y
         uHtvndqxcuk5l6f1C0BY7mZGJUFlM6+JbrsrRXTatsyVGspq7M7HzRvQtaRel/nYFXry
         kFxQ==
X-Gm-Message-State: AOAM5300ouNToIXyEsLHLirrks/ES39/hnjuP03RngW3r5FCg/IYIQPc
        ujPSFBi/YFDKR3VWyBK4j8q9hQ==
X-Google-Smtp-Source: ABdhPJzcu/Ss/9RgwPPJg93YQ7JubBa0Zh0691y5Zmny6DTl8TfzhEyt4JKFN6lUZKmLaaMEQaKLjA==
X-Received: by 2002:a1c:5401:: with SMTP id i1mr11309608wmb.169.1643394959987;
        Fri, 28 Jan 2022 10:35:59 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id z1sm2463750wmk.32.2022.01.28.10.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 10:35:58 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id B8CD41FFB7;
        Fri, 28 Jan 2022 18:35:57 +0000 (GMT)
References: <20220124171705.10432-1-Jonathan.Cameron@huawei.com>
 <20220124171705.10432-15-Jonathan.Cameron@huawei.com>
 <87a6fh9sry.fsf@linaro.org> <20220128182637.0000188a@huawei.com>
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
Subject: Re: [PATCH v4 14/42] tests/acpi: allow DSDT.viot table changes.
Date:   Fri, 28 Jan 2022 18:34:59 +0000
In-reply-to: <20220128182637.0000188a@huawei.com>
Message-ID: <87zgnf7lo2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> On Thu, 27 Jan 2022 14:06:42 +0000
> Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>
>> Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:
>>=20
>> > From: Jonathan Cameron <jonathan.cameron@huawei.com>
>> >
>> > The next patch unifies some of the PCI host bridge DSDT
>> > generation code and results in some minor changes to this file.=20=20
>>=20
>> I'd just squash this in with the patch that makes the change...
>> otherwise you risk breaking bisectablility.
> Hi Alex,
>
> This sequence of 3 patches is as described in
> tests/qtest/bios-tables-test.c
>
> According to description there the point is to allow
> whoever picks these patches up to just change the 3rd patch
> if the tables need updating to reflect some other change.
>
> It would be a lot easier obviously to just squash it, but
> given the process is laid out in that file, I'd rather
> leave it like this.

Hmm I shall defer to the maintainer here. I assume this process is to
deal with complex changes over several commits. So ignore that comment
for now.

>
> Or am I missing a reason this particular one is better
> squashed?=20
>
> Thanks,
>
> Jonathan
>
>
>>=20
>> >
>> > Signed-off-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>> > ---
>> >  tests/qtest/bios-tables-test-allowed-diff.h | 1 +
>> >  1 file changed, 1 insertion(+)
>> >
>> > diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest=
/bios-tables-test-allowed-diff.h
>> > index dfb8523c8b..08a8095432 100644
>> > --- a/tests/qtest/bios-tables-test-allowed-diff.h
>> > +++ b/tests/qtest/bios-tables-test-allowed-diff.h
>> > @@ -1 +1,2 @@
>> >  /* List of comma-separated changed AML files to ignore */
>> > +"tests/data/acpi/q35/DSDT.viot",=20=20
>>=20
>>=20


--=20
Alex Benn=C3=A9e
