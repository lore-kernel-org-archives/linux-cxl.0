Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74983C001DB
	for <linux-cxl@archiver.kernel.org>; Fri, 11 Aug 2023 12:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbjHKMEs (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 11 Aug 2023 08:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbjHKMEs (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 11 Aug 2023 08:04:48 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB3390
        for <linux-cxl@vger.kernel.org>; Fri, 11 Aug 2023 05:04:47 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fe7e1ef45dso3048480e87.1
        for <linux-cxl@vger.kernel.org>; Fri, 11 Aug 2023 05:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691755485; x=1692360285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nqmEEc4M2LAf4R+M40eOS2iP1bQtXeyk09PLxnu28xg=;
        b=cKB9cuMNQ/fTBqDf1xu3aW6C1NhiJZcNa2AeqRfdh/D6MnJGruXWSYDDO/DqZg7kBK
         uaDX4e5Qf9cmmfIEiEybpIkdIhg/SOM3DXlScaHErD9kDwjiiU8XacYDZjXfwjmW2W4r
         BQsmdO2Eg4rlRMGm+3qAo5uNUb8fsKQL5L4JHKiUDc6A21IM6M8G6fOrTrZgdx+fLaoJ
         i0rQZ1UrNagE3uVjg7g8BNk2io1cCQAjHDEaUg+RvjFvLCvxsh1lk1yYCrjcgDEDRbzV
         EfzKVOLP33ZpKTWb5oMjvQaElcDlMZAdaeCPzDodBMnDfFjAcIxOfR3JvraYdbNNEiHU
         MBMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691755485; x=1692360285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nqmEEc4M2LAf4R+M40eOS2iP1bQtXeyk09PLxnu28xg=;
        b=aLqoUcHfEEgo9T8JWw4Iyb4omCT/D0IGb/oTQhBDk5ydyFc3T2OXpaUdAprjwTekzk
         drg4VFE+3OjA0hbYsTgtobNwYoFpyY56XR9r8pGRwa9iLsZ1CauHlR6OAwwcu29/eGOb
         0qItF+t0ArHMybnNSuIpPQf3lCWOh9ExEF5YKmJsoP1ku0Zlcyp7TuBmG4/Ay5EasGq5
         /JpUO8gUz7djh1h6xo737crrL7iYasaClI2yFMJzjrsXIyxZhzaDlyQ20rP+YLP1L/rH
         0HD+FZVIDVbtJS3HCOP11HtgSAsbbyluWFQMXaOeJgoLK9oOUU/sZtNkdkXnG2DKKahw
         ClJA==
X-Gm-Message-State: AOJu0YzwXOdcyalnEb90k9RDzLS1E/KZ+wGY/UekPuS0WuqqM9YZ1Flx
        Gdghu3wzT1C8Cp62kNZN5uok3bslmWMu+PXvkl1cww28
X-Google-Smtp-Source: AGHT+IHVeFuG50IrMuoFo4InaXdj0SZ36nsKSTCs3ewWVi3rsKyuw+q5WPrUPx2TgowaP75QKQRFyGCckqN5jFXN0z8=
X-Received: by 2002:a05:6512:60a:b0:4fb:76a5:2325 with SMTP id
 b10-20020a056512060a00b004fb76a52325mr1104560lfe.24.1691755485063; Fri, 11
 Aug 2023 05:04:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAEvOrRz9s8CumbuMbkCU+eCHgAp20X6q0i1D6fi5vfa5_F6JnA@mail.gmail.com>
 <20230810173322.0000543c@Huawei.com> <CAEvOrRyvaFBzhzP7kxWeCpYY-u5wjwAo6076FGhN_k-+NadUDA@mail.gmail.com>
In-Reply-To: <CAEvOrRyvaFBzhzP7kxWeCpYY-u5wjwAo6076FGhN_k-+NadUDA@mail.gmail.com>
From:   Ravi Kanth <mvrravikanth@gmail.com>
Date:   Fri, 11 Aug 2023 17:34:33 +0530
Message-ID: <CAEvOrRzPNwNFrg4Brw7axzgxv6WFeYr0rnsDGmSSNpn9hca-3Q@mail.gmail.com>
Subject: Re: Support for CXL v3.0 spec with QEMU
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Sajjan Rao <sajjanr@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi Jonathan,
We build qemu with your repository code but we do not see any changes
in the output of lspci. Do we have any prerequisites / command
parameters w.r.t on how we boot the qemu for your changes to take
effect? Please let us know.

Thanks for your help.

Thanks
Ravi

On Thu, Aug 10, 2023 at 10:10=E2=80=AFPM Ravi Kanth <mvrravikanth@gmail.com=
> wrote:
>
> Thanks Jonathan for pointing this out. I will definitely take a look
> at this. Current support for the simulation of CCI mailbox is only via
> MCTP messages or even via CXL driver IOCTLs?
>
> Ravi
>
> On Thu, Aug 10, 2023 at 10:03=E2=80=AFPM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Thu, 10 Aug 2023 21:42:12 +0530
> > Ravi Kanth <mvrravikanth@gmail.com> wrote:
> >
> > > Hello,
> >
> > Hi Ravi,
> >
> > >
> > > I am writing this mail to know if the latest QEMU has support for CXL
> > > spec v3.0? I understand from the older tutorials that QEMU has suppor=
t
> > > for CXL v2.0. Is there any update to QEMU to support the CXL v3.0? I
> > > would like to specifically test the CCI mailbox functionality which
> > > has been added to CXL v3.0 spec.
> >
> > The nature of the CXL specification and the QEMU support is that for
> > devices there isn't a clear divide between different generations of
> > the specification. By that I mean, that a device based on the CXL 2.0
> > specification is compatible with the CXL 3.0 specification. As such,
> > the QEMU emulation has focused on features of interest - it is a far
> > from complete implementation of all the options in the CXL 2.0
> > specification but conversely there are some parts of CXL 3.0 are suppor=
ted.
> >
> > Note that the particular CCI functionality is not yet ready for CXL ups=
tream,
> > but we do have some support in the staging tree I maintain.
> >
> > https://gitlab.com/jic23/qemu/-/commits/cxl-2023-08-07/
> > specifically
> > https://gitlab.com/jic23/qemu/-/commit/2eb7e6402a45b359c304cea894a1d276=
25a4b80c
> >
> > Note at this stage we only support subset of commands.
> > Contributions of more support welcomed!
> >
> > Intent of the current support and related MCTP CCI access (over I2C) is
> > to enable ecosystem development, particularly of fabric managers.
> > For that a tiny subset of commands was sufficient to be sure the archit=
ecture
> > inside QEMU worked and that the proposed kernel code functions correctl=
y.
> >
> > Jonathan
> >
> > >
> > > Thank you in advance for your assistance.
> > >
> > > Ravi
> >
>
>
> --
> Regards
> M.V.R.Ravi Kanth



--=20
Regards
M.V.R.Ravi Kanth
