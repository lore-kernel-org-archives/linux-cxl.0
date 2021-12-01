Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B44C433F5
	for <linux-cxl@archiver.kernel.org>; Wed,  1 Dec 2021 11:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbhLALaY (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 1 Dec 2021 06:30:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbhLALaX (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 1 Dec 2021 06:30:23 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE70DC061574
        for <linux-cxl@vger.kernel.org>; Wed,  1 Dec 2021 03:27:02 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id v11so51474934wrw.10
        for <linux-cxl@vger.kernel.org>; Wed, 01 Dec 2021 03:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=VDjeZsKOVUB3xge3INCQLsi9iErTS1JXT7n9v53fHw4=;
        b=W7EkV/Q5r2OdftJlrvvdSTlJfeq9rg/D8OacR6xHzQKojU1h9lhHlQBgDcQXXH2Sxo
         R/tVVIlEvIn2H/FLPzoEeRf0DixUOqMlg1s8sjySRYjKxdhw7qXM2dXy0Kn/I7oh8k+C
         prMwS/EB7my0DK+QItBrYA7EV/VKJUL2M8Vwm7Yn1/KJ1qsvIOVLM7nrYQBaOVR7MFTq
         Q0AroHJ/Oa/htY4mZdW+efcLVEo1p3vq0D5AZfq+8BGXK7evCipYQOKQ0763SWMMjndt
         LXRSbIUgwmBeDWuhwkfwPWKIHiTZ0F90aJOWQX1jyM09qWiTJhmz4lwbB1iWYvlA0bx6
         9Y1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=VDjeZsKOVUB3xge3INCQLsi9iErTS1JXT7n9v53fHw4=;
        b=Zz/v8qBTy12ZT/CNTtdl2qd4PpYtPL5fl0131qhm4Ha6KBPHF10jq84cjkNSdT4Byh
         oteOn6S92sFtQWVApktRbkcR3vPeuJ0Vhx3KdenDGJl/WibdL6v5PRknC5VlimdoISL2
         Lx0vcEMNRvnRjVaKfRAgzeBLzZMgbeZOBlkcUY2wmwlFQMjnWhc4kV0Sva2+ILUrPiX3
         uGRVP9nkjr/0g2d+BVSf3Q2SE3T58SZMtosHd/k5oZTEKxrnso4cyqD113oGoSC0OEnz
         zUsgXg4Ydo2PCfj6Vr4x9C8taQlpMkvISSEMcsv/g8ssSfrOc03CUX6szznvJyGVG668
         1UpQ==
X-Gm-Message-State: AOAM530/bc0gxn3IzgWMkvOzw7dJLJgYPEZ6ThB+b/nmluQgd6gDnB4b
        kqUxEg0D93sEWvOIdUgzgLvIMl9gchLbxw==
X-Google-Smtp-Source: ABdhPJyzxK6YO+Orbz6WZdY4/IM04Ylu/9HPOioDab7szc8Ti2Hq0TWucMBXti7TVJpcuufQzUllbA==
X-Received: by 2002:a5d:4523:: with SMTP id j3mr5960330wra.185.1638358021478;
        Wed, 01 Dec 2021 03:27:01 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id t4sm693414wmi.48.2021.12.01.03.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 03:27:00 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id 91EFD1FF96;
        Wed,  1 Dec 2021 11:26:59 +0000 (GMT)
References: <20211117173201.00002513@Huawei.com>
 <OF164E5BA6.E927FE73-ON00258791.0078E206-88258791.007ABBAD@ibm.com>
 <BY5PR12MB4179A47F68A9A15E5888D074E89B9@BY5PR12MB4179.namprd12.prod.outlook.com>
 <20211119014822.j247ayrsdve4yxyu@intel.com>
 <BY5PR12MB4179AA1B062AEA75098E15D8E89C9@BY5PR12MB4179.namprd12.prod.outlook.com>
 <20211119032541.gr6berwu2ve4tkax@intel.com> <8735njf6f7.fsf@linaro.org>
 <20211129171631.ytixckw2gz3rya25@intel.com> <87mtlmzu3w.fsf@linaro.org>
 <20211130130956.00000ccd@Huawei.com>
 <20211130172158.kzuptl2pxlcgvzft@intel.com>
 <20211201095532.000035d8@Huawei.com>
User-agent: mu4e 1.7.5; emacs 28.0.60
From:   Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        qemu-devel@nongnu.org, Saransh Gupta1 <saransh@ibm.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        shameerali.kolothum.thodi@huawei.com
Subject: Re: Follow-up on the CXL discussion at OFTC
Date:   Wed, 01 Dec 2021 10:29:53 +0000
In-reply-to: <20211201095532.000035d8@Huawei.com>
Message-ID: <871r2wzhto.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


Jonathan Cameron <Jonathan.Cameron@Huawei.com> writes:

> On Tue, 30 Nov 2021 09:21:58 -0800
> Ben Widawsky <ben.widawsky@intel.com> wrote:
>
>> On 21-11-30 13:09:56, Jonathan Cameron wrote:
>> > On Mon, 29 Nov 2021 18:28:43 +0000
>> > Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>> >=20=20=20
>> > > Ben Widawsky <ben.widawsky@intel.com> writes:
>> > >=20=20=20
>> > > > On 21-11-26 12:08:08, Alex Benn=C3=A9e wrote:=20=20=20=20
>> > > >>=20
>> > > >> Ben Widawsky <ben.widawsky@intel.com> writes:
>> > > >>=20=20=20=20=20
<snip>
>> > >=20=20=20
>> > > >> * Some means at least ensuring qtest can instantiate the device a=
nd not
>> > > >>   fall over. Obviously more testing is better but it can always be
>> > > >>   expanded on in later series.=20=20=20=20
>> > > >
>> > > > This was in the patch series. It could use more testing for sure, =
but I had
>> > > > basic functional testing in place via qtest.=20=20=20=20
>> > >=20
>> > > More is always better but the basic qtest does ensure a device doesn=
't
>> > > segfault if it's instantiated.=20=20
>> >=20
>> > I'll confess this is a bit I haven't looked at yet. Will get Shameer t=
o give
>> > me a hand.
>> >=20
>> > Thanks=20=20
>>=20
>> I'd certainly feel better if we had more tests. I also suspect the qtest=
 I wrote
>> originally no longer works. The biggest challenge I had was getting gitl=
ab CI
>> working for me.
>
> Looks like it'll be tests that slow things down. *sigh*.

Hopefully the GitLab stuff has stabilised over the last year as we've
aggressively pushed out stuff that times out and also limited some test
to only run on upstream staging branches.

The biggest hole is properly exercising KVM stuff (due to the
limitations of GitLab runners). As a result you fall back to TCG which
can get slow if your booting full distros with it.

> Why are there not enough days in the week?

"oh it's softfreeze already?" - a regular occurrence for me ;-)

>
> Jonathan

--=20
Alex Benn=C3=A9e
