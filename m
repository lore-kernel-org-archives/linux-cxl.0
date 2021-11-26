Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020E6C4332F
	for <linux-cxl@archiver.kernel.org>; Fri, 26 Nov 2021 13:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243734AbhKZNNb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 26 Nov 2021 08:13:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239867AbhKZNLa (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 26 Nov 2021 08:11:30 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB76C0613A5
        for <linux-cxl@vger.kernel.org>; Fri, 26 Nov 2021 04:27:44 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id l25so38033220eda.11
        for <linux-cxl@vger.kernel.org>; Fri, 26 Nov 2021 04:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=yZIiYiZCO3wIosKvYOOmg8DDP8r7/tr3b1n38/cwsQU=;
        b=dXE2u550Hd+0HWLBkkqcWZQwrCzFUloMuLLhcATSkDN9JfZxp3aCnOzFYv2AzYgRhe
         kWj8TJCWYTQ4weuE/+0LztedY4+UUK9JYD6pUUDIfPhQ2XrmAioabfXuaPuWJtkw3+/S
         TaIxPsolRjFS8C/pnX1bkeFfjtFtTeSUoXr/BBZazKYHCpC8Uwg492wLkbGAXd4wbyoM
         J73j+jKvNuASXpnVwcDmqJJH4arP1N+N5nP+DDtAMfJLGAF5z8cMhypwXYtIRFs6FUj5
         9NWBZ2ZNyawIk5A4tm09N8Xt2Rg1LWaCTH1wuTic/ITbZDuPdczNeE//0mOW9gHg7wMH
         7ofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=yZIiYiZCO3wIosKvYOOmg8DDP8r7/tr3b1n38/cwsQU=;
        b=rZUlyG6pTa2ZEL72wassHcrZhSwhoC7swPm3b5EBieEonBTl4aUZrDbE1H2xQd/6Lg
         PrMIOfRkEzVfk62FGPQyjgu7w70yt+ZFG8nJLuXmGfT6fV2+zWqHR4JSvfomH1rmotbM
         rbLKqm+R7YmhJiWoVHQRo5w0T/vqbNOJnSeUPhNV+gn0VeXepeY6PCBL6iRVJnsDGpjV
         fLHFY+tNF+o408YfF6GX0U+rb1LRzDAZo0SGi7XaLfdF1LfjH/0tKMYkmiTxH5z871Dx
         MOAlseHEFGv/bkykIPLcFV9R1sR3I0rxz0sJeBSEcCYaw/VtZq5GTEbZEhDjlOGkb/Gr
         ugQQ==
X-Gm-Message-State: AOAM531PMyLms592cVK4mQoNXlxPhG6GEoBM2s3/bpYD3K0aFwSVBxmA
        AYHkvCgYjjemwz3YIRGL+aI3aw==
X-Google-Smtp-Source: ABdhPJzMmuZ5eoVkwytFhknRMndiZD9VjMfWT/DJwe3V1gCZDkzWmBgL5Kx1+qMSB1JspcScr74Bgg==
X-Received: by 2002:a17:907:e86:: with SMTP id ho6mr37371388ejc.197.1637929662602;
        Fri, 26 Nov 2021 04:27:42 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id r13sm3695407edo.71.2021.11.26.04.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 04:27:41 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id 455361FF96;
        Fri, 26 Nov 2021 12:27:40 +0000 (GMT)
References: <OF255704A1.78FEF164-ON0025878E.00821084-0025878F.00015560@ibm.com>
 <20211117165719.pqig62t5z2grgjvv@intel.com>
 <20211117173201.00002513@Huawei.com>
 <OF164E5BA6.E927FE73-ON00258791.0078E206-88258791.007ABBAD@ibm.com>
 <BY5PR12MB4179A47F68A9A15E5888D074E89B9@BY5PR12MB4179.namprd12.prod.outlook.com>
 <20211119014822.j247ayrsdve4yxyu@intel.com>
 <BY5PR12MB4179AA1B062AEA75098E15D8E89C9@BY5PR12MB4179.namprd12.prod.outlook.com>
 <20211119032541.gr6berwu2ve4tkax@intel.com>
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
Date:   Fri, 26 Nov 2021 12:08:08 +0000
In-reply-to: <20211119032541.gr6berwu2ve4tkax@intel.com>
Message-ID: <8735njf6f7.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


Ben Widawsky <ben.widawsky@intel.com> writes:

> On 21-11-19 02:29:51, Shreyas Shah wrote:
>> Hi Ben
>>=20
>> Are you planning to add the CXL2.0 switch inside QEMU or already added i=
n one of the version?=20
>>=20=20
>
> From me, there are no plans for QEMU anything until/unless upstream think=
s it
> will merge the existing patches, or provide feedback as to what it would =
take to
> get them merged. If upstream doesn't see a point in these patches, then I=
 really
> don't see much value in continuing to further them. Once hardware comes o=
ut, the
> value proposition is certainly less.

I take it:

  Subject: [RFC PATCH v3 00/31] CXL 2.0 Support
  Date: Mon,  1 Feb 2021 16:59:17 -0800
  Message-Id: <20210202005948.241655-1-ben.widawsky@intel.com>

is the current state of the support? I saw there was a fair amount of
discussion on the thread so assumed there would be a v4 forthcoming at
some point.

Adding new subsystems to QEMU does seem to be a pain point for new
contributors. Patches tend to fall through the cracks of existing
maintainers who spend most of their time looking at stuff that directly
touches their files. There is also a reluctance to merge large chunks of
functionality without an identified maintainer (and maybe reviewers) who
can be the contact point for new patches. So in short you need:

 - Maintainer Reviewed-by/Acked-by on patches that touch other sub-systems
 - Reviewed-by tags on the new sub-system patches from anyone who understan=
ds CXL
 - Some* in-tree testing (so it doesn't quietly bitrot)
 - A patch adding the sub-system to MAINTAINERS with identified people

* Some means at least ensuring qtest can instantiate the device and not
  fall over. Obviously more testing is better but it can always be
  expanded on in later series.

Is that the feedback you were looking for?

--=20
Alex Benn=C3=A9e
