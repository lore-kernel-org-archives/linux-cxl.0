Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A90CEB64D7
	for <linux-cxl@archiver.kernel.org>; Fri, 23 Jun 2023 12:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjFWMOA (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 23 Jun 2023 08:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjFWMN7 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 23 Jun 2023 08:13:59 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A623510C1
        for <linux-cxl@vger.kernel.org>; Fri, 23 Jun 2023 05:13:58 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f85966b0f2so660168e87.3
        for <linux-cxl@vger.kernel.org>; Fri, 23 Jun 2023 05:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687522437; x=1690114437;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ku2DJUXAZ0KHZBqBXn9ArIju334XbbveUJQ30cnzqd0=;
        b=KmgyfP0cX9f0WYNxU/LvXAkWEkEuFQzK5bck7lr+hwfOTQtUiwf+fdArfhi5/7Z0yl
         VqnYy2fI5Z3VUVQry8yOkT2ntnjy5IK97uG455gO2agdHC0BDpHMuBg73QwWAU6Z2UYL
         O//aCHZxx/juhqH/gowH160is054TpLm5M6p0rzk5YVOE26u01Jh1ZaH0MhLF1vCFB4a
         fvVDlhrLi6Er5bKO6wHgq7QaZRhfbC6uPVbj6hnCFLDcp3bKJvPHJ3LuaDFa5yVlDw68
         T6cKBB4p1Z/qYTmo5OmfBIfBsMgAEPDkPv9gFiKR1G1NTFhWXpdvOZhufFWqxk2t9/3e
         UfLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687522437; x=1690114437;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ku2DJUXAZ0KHZBqBXn9ArIju334XbbveUJQ30cnzqd0=;
        b=XeyBjLMajIucoh7/xSnY5GTm6VP9jZuF0snOKtTWdBE945Ibw+zM336JMUL6seCc5P
         EwF9bZn5CsmSfWD9G1MzkdBI7eYodbECQvYNxQ2yIfZZsK6XTDyDMcVNVstK70NiALuz
         Sw2SbeECZlCKO7pzd4LdN1kU8wRpg7okSfnAl5M7M5Qm66j/j6O4SUb87jefEkFR/02k
         V32rGtDTQ7yZmm94uNRijY8dmcxx1e1rJ4hD+TrS8oqrijheOf4ezEb5gSNmxTSX7IcV
         KEHZd55RCNKYizj9Cghn9gd4wP/p0hn8boyYQnE5R6MSr5LFOs/IqM3TG6DQ/ltId2Xy
         35Rg==
X-Gm-Message-State: AC+VfDyfIx0oQClcyMtu0pnVXpkfG+uyPO1N0cXTYKAzXPDHk3K/kIYK
        2s6z7sdwrb06mkmZ2qvom+FVFkCUjSHuMcLte0eT6Q==
X-Google-Smtp-Source: ACHHUZ64KL813CBG1U9F8bSbmSK74gQmhqkAXCBRrrUianzNsqJQRF2RnKk4oQk7UpHDoQ272pP0ITNXzn0Eg+uPepQ=
X-Received: by 2002:a19:3813:0:b0:4f8:7697:5207 with SMTP id
 f19-20020a193813000000b004f876975207mr7991648lfa.23.1687522436880; Fri, 23
 Jun 2023 05:13:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230526170010.574-1-Jonathan.Cameron@huawei.com>
 <20230623025836-mutt-send-email-mst@kernel.org> <20230623130622.00004d02@Huawei.com>
In-Reply-To: <20230623130622.00004d02@Huawei.com>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Fri, 23 Jun 2023 13:13:45 +0100
Message-ID: <CAFEAcA-c9qmn0S87Am6a=XBjJ2peBVyBYfqdFBgC3RPw8rGmrg@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] hw/cxl: Poison get, inject, clear
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
        Fan Ni <fan.ni@samsung.com>, linux-cxl@vger.kernel.org,
        linuxarm@huawei.com, Ira Weiny <ira.weiny@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>,
        =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        Eric Blake <eblake@redhat.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
        Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 23 Jun 2023 at 13:07, Jonathan Cameron via
<qemu-devel@nongnu.org> wrote:
>
> On Fri, 23 Jun 2023 02:59:44 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>
> > On Fri, May 26, 2023 at 06:00:06PM +0100, Jonathan Cameron wrote:
> > > v8: Formatting fixes for QMP docs from Markus Armbruster (thanks!)
> >
> > This and other patches add a bunch of over-80 chars lines.  I'm not
> > going to intervene here as cxl has lots of them but maybe scan over cxl
> > codebase and shorten where appropriate.
> > Thanks!
>
> Will add it to the todo list and will pay more attention to this for
> future series.
>
> Some annoyingly complex register names make it tricky but I'm sure we
> can do better if not necessarily perfectly!

The coding style says:

# Lines should be 80 characters; try not to make them longer.
#
# Sometimes it is hard to do, especially when dealing with QEMU subsystems
# that use long function or symbol names. If wrapping the line at 80 columns
# is obviously less readable and more awkward, prefer not to wrap it; better
# to have an 85 character line than one which is awkwardly wrapped.
#
# Even in that case, try not to make lines much longer than 80 characters.

so if it would be obviously worse to wrap the line you can
make it longer than 80 chars.

-- PMM
