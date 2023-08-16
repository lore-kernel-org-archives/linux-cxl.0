Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B28EC04E69
	for <linux-cxl@archiver.kernel.org>; Wed, 16 Aug 2023 11:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244563AbjHPLmA (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 16 Aug 2023 07:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244706AbjHPLlc (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 16 Aug 2023 07:41:32 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D680198E
        for <linux-cxl@vger.kernel.org>; Wed, 16 Aug 2023 04:41:31 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fe0e34f498so10340691e87.2
        for <linux-cxl@vger.kernel.org>; Wed, 16 Aug 2023 04:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692186089; x=1692790889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bdi+ghzyy4udEwPK+eRedBCVEBcylL/VcDJUMxw/tjc=;
        b=AiOlWucuD57ys6Uk5lFzC3DwGiF9x380jg5Dv/O4fOyy0muzEc5/CwibWdM46wNjuM
         OVgY0drnK3kYrOHEGrRN/rsBQAUvca+dUUloOb89GoSUgo74tarF/mx8Up3Cu9rXIQlB
         OMxIXkwASg6IyMeO5geXTuQ9yMBJ8MrDinrzYE0B9WYf6T9dwqA/5zX8toXqHtzgyGyp
         qtC2aOJzeCS6w/BchcQULNgQc4z7Da11ySu1FZmqIePD/+Qbv4RFmqizclyp15SpmIhg
         TevB4+ne8ZNTWmtCu1SXR2IIOoTg8/K9wLstB3puXH+vy3kmxH66r/fdZs3NSXisAU8P
         pN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692186089; x=1692790889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bdi+ghzyy4udEwPK+eRedBCVEBcylL/VcDJUMxw/tjc=;
        b=CwD69e+7GqwtS5Jz4cMB95bQ33CYBLNI6Om2ecZQWxQRqOEyFkXt6y/0PJ7zPqbKkL
         d1PFavzfFguJWfAwcTOQsRY4RWs2lvfKJIS93faK/ErH3+RNRFc9u5cMOUs4t7HDD8O6
         m580jYIpfeA9lnV8wJ0Dqh9Z18smca1tejhuduXLmuLQhg5CafbG3zbkRERlvQln1c/y
         As2HuBwkXd8pMTZFiYRTTZXsAFTJGI1oLM3wZjFfaGNXriHq/U8lLq4zbZYR/UTFhItg
         EaERgV4ieGprMSerG29gCvpeSEeJDWoE8y8If+jqrdc1v4HzDQsYwijDf65922LHxTD7
         QqXQ==
X-Gm-Message-State: AOJu0YxMWtbL26eRk5LbtTfUurw5arKcecHhIOAEMiYM47uN03Jt8gBV
        QgFlqmaYRSty4VLriI9m3dFNB3d59uhuz/8oUuM=
X-Google-Smtp-Source: AGHT+IH4eO1aGD/7k2ut/fAUNF0iT6AEj0EcAmVcDKFOnhzSZf+5OTEnQSOIaBgEUnsWeMYhTTE48okt1Bk5vUyiJoQ=
X-Received: by 2002:a19:520b:0:b0:4fe:7ddd:d91 with SMTP id
 m11-20020a19520b000000b004fe7ddd0d91mr1142868lfb.39.1692186089287; Wed, 16
 Aug 2023 04:41:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAEvOrRz9s8CumbuMbkCU+eCHgAp20X6q0i1D6fi5vfa5_F6JnA@mail.gmail.com>
 <20230810173322.0000543c@Huawei.com> <CAEvOrRyvaFBzhzP7kxWeCpYY-u5wjwAo6076FGhN_k-+NadUDA@mail.gmail.com>
 <CAEvOrRzPNwNFrg4Brw7axzgxv6WFeYr0rnsDGmSSNpn9hca-3Q@mail.gmail.com> <20230811145223.000040de@Huawei.com>
In-Reply-To: <20230811145223.000040de@Huawei.com>
From:   Ravi Kanth <mvrravikanth@gmail.com>
Date:   Wed, 16 Aug 2023 17:11:17 +0530
Message-ID: <CAEvOrRzE76U2g_8=V3F-4fqwosRz3n9kO+40E_iG74EcbQBxtw@mail.gmail.com>
Subject: Re: Support for CXL v3.0 spec with QEMU
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Sajjan Rao <sajjanr@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Thanks, Jonathan. We were able to now see the CCI endpoint in the lspci out=
put.

However, we are not able to see the /dev/cxl/switch0 node. Should we
be loading the cxl driver with the changes suggested by you in the
link below? If yes, We are not able to download the source code as we
do not see the git repository for the same. Is this part of the
mainline?

https://lore.kernel.org/linux-cxl/20230804115414.14391-1-Jonathan.Cameron@h=
uawei.com/T/#t

Ravi

On Fri, Aug 11, 2023 at 7:22=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Fri, 11 Aug 2023 17:34:33 +0530
> Ravi Kanth <mvrravikanth@gmail.com> wrote:
>
> > Hi Jonathan,
> > We build qemu with your repository code but we do not see any changes
> > in the output of lspci. Do we have any prerequisites / command
> > parameters w.r.t on how we boot the qemu for your changes to take
> > effect? Please let us know.
>
> As the switch cci is a separate PCI function it needs to be explicitly
> added. See the cover letter of kernel switch-cci RFC:
>
> https://lore.kernel.org/linux-cxl/20230804115414.14391-1-Jonathan.Cameron=
@huawei.com
>
>  -device cxl-upstream,bus=3Dcxl_rp_port0,id=3Dus0,addr=3D0.0,multifunctio=
n=3Don, \
>  -device cxl-switch-mailbox-cci,bus=3Dcxl_rp_port0,addr=3D0.1,target=3Dus=
0 \
>  -device cxl-downstream,port=3D0,bus=3Dus0,id=3Dswport0,chassis=3D0,slot=
=3D4 \
>  -device cxl-downstream,port=3D1,bus=3Dus0,id=3Dswport1,chassis=3D0,slot=
=3D5 \
>
> Is the switch part of it.
>
> We don't yet have the additions for MHDs though some discussion on how to
> do it has happened.  Those will support some FMAPI command via tunnelling=
 throuhg
> the main mailbox.
>
> I'm on vacation from tonight until the 22nd, so good luck. Feel free
> to post questions in meantime but my reply will take a while!
>
> Jonathan
>
> >
> > Thanks for your help.
> >
> > Thanks
> > Ravi
> >
> > On Thu, Aug 10, 2023 at 10:10=E2=80=AFPM Ravi Kanth <mvrravikanth@gmail=
.com> wrote:
> > >
> > > Thanks Jonathan for pointing this out. I will definitely take a look
> > > at this. Current support for the simulation of CCI mailbox is only vi=
a
> > > MCTP messages or even via CXL driver IOCTLs?
> > >
> > > Ravi
> > >
> > > On Thu, Aug 10, 2023 at 10:03=E2=80=AFPM Jonathan Cameron
> > > <Jonathan.Cameron@huawei.com> wrote:
> > > >
> > > > On Thu, 10 Aug 2023 21:42:12 +0530
> > > > Ravi Kanth <mvrravikanth@gmail.com> wrote:
> > > >
> > > > > Hello,
> > > >
> > > > Hi Ravi,
> > > >
> > > > >
> > > > > I am writing this mail to know if the latest QEMU has support for=
 CXL
> > > > > spec v3.0? I understand from the older tutorials that QEMU has su=
pport
> > > > > for CXL v2.0. Is there any update to QEMU to support the CXL v3.0=
? I
> > > > > would like to specifically test the CCI mailbox functionality whi=
ch
> > > > > has been added to CXL v3.0 spec.
> > > >
> > > > The nature of the CXL specification and the QEMU support is that fo=
r
> > > > devices there isn't a clear divide between different generations of
> > > > the specification. By that I mean, that a device based on the CXL 2=
.0
> > > > specification is compatible with the CXL 3.0 specification. As such=
,
> > > > the QEMU emulation has focused on features of interest - it is a fa=
r
> > > > from complete implementation of all the options in the CXL 2.0
> > > > specification but conversely there are some parts of CXL 3.0 are su=
pported.
> > > >
> > > > Note that the particular CCI functionality is not yet ready for CXL=
 upstream,
> > > > but we do have some support in the staging tree I maintain.
> > > >
> > > > https://gitlab.com/jic23/qemu/-/commits/cxl-2023-08-07/
> > > > specifically
> > > > https://gitlab.com/jic23/qemu/-/commit/2eb7e6402a45b359c304cea894a1=
d27625a4b80c
> > > >
> > > > Note at this stage we only support subset of commands.
> > > > Contributions of more support welcomed!
> > > >
> > > > Intent of the current support and related MCTP CCI access (over I2C=
) is
> > > > to enable ecosystem development, particularly of fabric managers.
> > > > For that a tiny subset of commands was sufficient to be sure the ar=
chitecture
> > > > inside QEMU worked and that the proposed kernel code functions corr=
ectly.
> > > >
> > > > Jonathan
> > > >
> > > > >
> > > > > Thank you in advance for your assistance.
> > > > >
> > > > > Ravi
> > > >
> > >
> > >
> > > --
> > > Regards
> > > M.V.R.Ravi Kanth
> >
> >
> >
>


--=20
Ravi
