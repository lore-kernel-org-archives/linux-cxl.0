Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757C4C4167D
	for <linux-cxl@archiver.kernel.org>; Mon, 29 Nov 2021 22:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236683AbhK2XBQ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 29 Nov 2021 18:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237103AbhK2XAn (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 29 Nov 2021 18:00:43 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E68DC1A1956
        for <linux-cxl@vger.kernel.org>; Mon, 29 Nov 2021 10:37:10 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id i8-20020a7bc948000000b0030db7b70b6bso17607503wml.1
        for <linux-cxl@vger.kernel.org>; Mon, 29 Nov 2021 10:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=/mph0GEPDLeh915zdMYHYXWQVTPRIe6JV1CzcmKwPC4=;
        b=aSH66nUsDTgB58N4loeGVT9OQ7A4ajG7WVnLUi4qPpPiD1aJdsucoWdeIInM7ALY6K
         6Jt1lHZ6YCSuy/SL0K+GVY6e5plLhfRSm+urWa3kOhU3r8WjAOxb+t4zA9z48xkS95b8
         5SHpsJFTiOqx4QcLk33OuJMFE/iYJRHE7eC9A05BPn8e8cAHuTZJrIxlcJXb68+bnHwr
         X/sW7zvINoJBBqoW5QBG16q213VMXb9l77UIK/GZf6GiVYHFy0LTTAvVTK3aTX359hYo
         FWfrw8si+SfR+srcD7hP0PhJ54J2fJh7jk9SB0VfuicGyqB+jBZsHhxI9Tk2INpQrrQQ
         cqFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=/mph0GEPDLeh915zdMYHYXWQVTPRIe6JV1CzcmKwPC4=;
        b=E70qEdM4HjwNAVSQSAWtLpW3KhYMREQ97hNR5Ekmdt4HObQg0KJMAb0BcseJirBJWM
         BvO6Vp6Sn5NIYn2cAYOXqoHXQlYPev9D1wgmaVabPUGJbTHQFADY2MTa9viz9tDAmP4j
         x66bnga2XedcGH1yKTsDEi4iUNp7yk+Vj4JtLmXIcQs8F1OjKCdFPs78E6Ezrdew3FGJ
         XA8UdIfvMYA2CJjLFNEAkjlq1Eqk3KyU505/sIuHXIMQGuvxrKPftDubHzDTXW3gFt6V
         +QjZk34Bzlx7VlF0lH4LZnJzNe9bppVGkUTp3SXYFo9N62of4JPoS5PvCx2GCXwJ8ILr
         tozQ==
X-Gm-Message-State: AOAM530GveGrG2LgfrxNysEWr92fRjZlcDL2WjkWdCz+tvMZ8PzulJrj
        Le6N5x9JUMAf+geFGvnTqVfkig==
X-Google-Smtp-Source: ABdhPJzyXYNnXHoieMjBrLtgGmAI44YNAgQiLDiW6tNLOWScg7g1vvQ1py2SmfnvDBAw3bbxAtf6vw==
X-Received: by 2002:a05:600c:1c8d:: with SMTP id k13mr44687wms.177.1638211028818;
        Mon, 29 Nov 2021 10:37:08 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id g5sm19180690wri.45.2021.11.29.10.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 10:37:08 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id 543041FF96;
        Mon, 29 Nov 2021 18:37:07 +0000 (GMT)
References: <OF255704A1.78FEF164-ON0025878E.00821084-0025878F.00015560@ibm.com>
 <20211117165719.pqig62t5z2grgjvv@intel.com>
 <20211117173201.00002513@Huawei.com>
 <OF164E5BA6.E927FE73-ON00258791.0078E206-88258791.007ABBAD@ibm.com>
 <BY5PR12MB4179A47F68A9A15E5888D074E89B9@BY5PR12MB4179.namprd12.prod.outlook.com>
 <20211119014822.j247ayrsdve4yxyu@intel.com>
 <BY5PR12MB4179AA1B062AEA75098E15D8E89C9@BY5PR12MB4179.namprd12.prod.outlook.com>
 <20211119032541.gr6berwu2ve4tkax@intel.com> <8735njf6f7.fsf@linaro.org>
 <20211129171631.ytixckw2gz3rya25@intel.com>
User-agent: mu4e 1.7.5; emacs 28.0.60
From:   Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     Shreyas Shah <shreyas.shah@elastics.cloud>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Saransh Gupta1 <saransh@ibm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: Follow-up on the CXL discussion at OFTC
Date:   Mon, 29 Nov 2021 18:28:43 +0000
In-reply-to: <20211129171631.ytixckw2gz3rya25@intel.com>
Message-ID: <87mtlmzu3w.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


Ben Widawsky <ben.widawsky@intel.com> writes:

> On 21-11-26 12:08:08, Alex Benn=C3=A9e wrote:
>>=20
>> Ben Widawsky <ben.widawsky@intel.com> writes:
>>=20
>> > On 21-11-19 02:29:51, Shreyas Shah wrote:
>> >> Hi Ben
>> >>=20
>> >> Are you planning to add the CXL2.0 switch inside QEMU or already adde=
d in one of the version?=20
>> >>=20=20
>> >
>> > From me, there are no plans for QEMU anything until/unless upstream th=
inks it
>> > will merge the existing patches, or provide feedback as to what it wou=
ld take to
>> > get them merged. If upstream doesn't see a point in these patches, the=
n I really
>> > don't see much value in continuing to further them. Once hardware come=
s out, the
>> > value proposition is certainly less.
>>=20
>> I take it:
>>=20
>>   Subject: [RFC PATCH v3 00/31] CXL 2.0 Support
>>   Date: Mon,  1 Feb 2021 16:59:17 -0800
>>   Message-Id: <20210202005948.241655-1-ben.widawsky@intel.com>
>>=20
>> is the current state of the support? I saw there was a fair amount of
>> discussion on the thread so assumed there would be a v4 forthcoming at
>> some point.
>
> Hi Alex,
>
> There is a v4, however, we never really had a solid plan for the primary =
issue
> which was around handling CXL memory expander devices properly (both from=
 an
> interleaving standpoint as well as having a device which hosts multiple m=
emory
> capacities, persistent and volatile). I didn't feel it was worth sending =
a v4
> unless someone could say
>
> 1. we will merge what's there and fix later, or
> 2. you must have a more perfect emulation in place, or
> 3. we want to see usages for a real guest

I think 1. is acceptable if the community is happy there will be ongoing
development and it's not just a code dump. Given it will have a
MAINTAINERS entry I think that is demonstrated.

What's the current use case? Testing drivers before real HW comes out?
Will it still be useful after real HW comes out for people wanting to
debug things without HW?

>
> I had hoped we could merge what was there mostly as is and fix it up as w=
e go.
> It's useful in the state it is now, and as time goes on, we find more use=
cases
> for it in a VMM, and not just driver development.
>
>>=20
>> Adding new subsystems to QEMU does seem to be a pain point for new
>> contributors. Patches tend to fall through the cracks of existing
>> maintainers who spend most of their time looking at stuff that directly
>> touches their files. There is also a reluctance to merge large chunks of
>> functionality without an identified maintainer (and maybe reviewers) who
>> can be the contact point for new patches. So in short you need:
>>=20
>>  - Maintainer Reviewed-by/Acked-by on patches that touch other sub-syste=
ms
>
> This is the challenging one. I have Cc'd the relevant maintainers (hw/pci=
 and
> hw/mem are the two) in the past, but I think there interest is lacking (a=
nd
> reasonably so, it is an entirely different subsystem).

So the best approach to that is to leave a Cc: tag in the patch itself
on your next posting so we can see the maintainer did see it but didn't
contribute a review tag. This is also a good reason to keep Message-Id
tags in patches so we can go back to the original threads.

So in my latest PR you'll see:

  Signed-off-by: Willian Rampazzo <willianr@redhat.com>
  Reviewed-by: Beraldo Leal <bleal@redhat.com>
  Message-Id: <20211122191124.31620-1-willianr@redhat.com>
  Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
  Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
  Message-Id: <20211129140932.4115115-7-alex.bennee@linaro.org>

which shows the Message-Id from Willian's original posting and the
latest Message-Id from my posting of the maintainer tree (I trim off my
old ones).

>>  - Reviewed-by tags on the new sub-system patches from anyone who unders=
tands CXL
>
> I have/had those from Jonathan.
>
>>  - Some* in-tree testing (so it doesn't quietly bitrot)
>
> We had this, but it's stale now. We can bring this back up.
>
>>  - A patch adding the sub-system to MAINTAINERS with identified people
>
> That was there too. Since the original posting, I'd be happy to sign Jona=
than up
> to this if he's willing.

Sounds good to me.

>> * Some means at least ensuring qtest can instantiate the device and not
>>   fall over. Obviously more testing is better but it can always be
>>   expanded on in later series.
>
> This was in the patch series. It could use more testing for sure, but I h=
ad
> basic functional testing in place via qtest.

More is always better but the basic qtest does ensure a device doesn't
segfault if it's instantiated.

>
>>=20
>> Is that the feedback you were looking for?
>
> You validated my assumptions as to what's needed, but your first bullet i=
s the
> one I can't seem to pin down.
>
> Thanks.
> Ben


--=20
Alex Benn=C3=A9e
