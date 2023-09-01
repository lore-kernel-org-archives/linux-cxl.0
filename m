Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5838FCA0FE1
	for <linux-cxl@archiver.kernel.org>; Fri,  1 Sep 2023 14:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349862AbjIAOEO (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 1 Sep 2023 10:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjIAOEO (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 1 Sep 2023 10:04:14 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D2210F0
        for <linux-cxl@vger.kernel.org>; Fri,  1 Sep 2023 07:04:10 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-500cfb168c6so3452070e87.2
        for <linux-cxl@vger.kernel.org>; Fri, 01 Sep 2023 07:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693577049; x=1694181849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JrLUf81bXZAnylUW9PQas5mHj+WNd9dID3JH4/kHO4M=;
        b=F79wAhqAttxLnZbt0ucDpogqpeYnStoaXbZa4NgtD6Uwr3BN/Qc1tcs9lmgHDCVdG3
         Zbsvah0x/kTQ9DPD1z3iQcaeY0qfwZP3iDG8I7qRF8c4l+VTDtpVPzpRxcaiorPvgo36
         PoAVxPWQ3OqX/bwU4dw3Ujb/9eAwy3ueMK+s2Zy8uXv8VisqxbTJrdUfnWTWNs3D3+ki
         y3TqWDODmoY0STKaZCQaubgIApajlHp71mqp5m4jzxwLUD1xFZow0uqW7ymzYeqvroPd
         1KW82Ymv+EamVWOBnxYS6bUVnTVlHD6dmdBEVnyn5QXWmHQcuhzeo8VubfModcu1me/v
         ODLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693577049; x=1694181849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JrLUf81bXZAnylUW9PQas5mHj+WNd9dID3JH4/kHO4M=;
        b=elYUguY4cwUy6+G6DpP0QCJzQnMt90azakVH2gzXpRAWWjTQ9nM7yV3LV8+fSXWN8S
         QyiO413okOZRqh6BVME1vjYn8aNFKsPWVHH/dpRGwF6nH/PTlJyMRR55EXkddrVErQE9
         MUGmslei4/HKgq8xFpCVBEbM9CoIk63fC43qdhVuxZVcHHb01wUFfAUNHR+KcI059Dj2
         XSxX2cndVe3+WdTDMfbzir9HVeDiZZ8oiuLDGxbwclw4lISSt2ruwkUiXy5crkw5WqmY
         BEVx3gmV3+y/M0bF4eeXtZriH0BqCmPcR7VIdUFhZPY9a7Yyj2lmcdhJU170Z74DE1hb
         9A4g==
X-Gm-Message-State: AOJu0Yxa0Md+pH5rVRln5F/nN5yioOsxKcGMeLsKW1UHGwZFmiSp6Zz1
        HwJwAq5o+Kcd8JWBx/VgNHsAdLtay58KQR3APcc=
X-Google-Smtp-Source: AGHT+IEC3wvNdfoINZ3EZrecUkyBGAKi73WqYbVZQiDr2MAadmxgI161sOgIvKgmfABsDRxii2xN23vmedRKaEikTqA=
X-Received: by 2002:a19:7b1b:0:b0:4f6:d7b:2f19 with SMTP id
 w27-20020a197b1b000000b004f60d7b2f19mr1565111lfc.24.1693577048616; Fri, 01
 Sep 2023 07:04:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAEvOrRz9s8CumbuMbkCU+eCHgAp20X6q0i1D6fi5vfa5_F6JnA@mail.gmail.com>
 <20230810173322.0000543c@Huawei.com> <CAEvOrRyvaFBzhzP7kxWeCpYY-u5wjwAo6076FGhN_k-+NadUDA@mail.gmail.com>
 <CAEvOrRzPNwNFrg4Brw7axzgxv6WFeYr0rnsDGmSSNpn9hca-3Q@mail.gmail.com>
 <20230811145223.000040de@Huawei.com> <CAEvOrRzE76U2g_8=V3F-4fqwosRz3n9kO+40E_iG74EcbQBxtw@mail.gmail.com>
 <20230823180323.000052d5@Huawei.com>
In-Reply-To: <20230823180323.000052d5@Huawei.com>
From:   Ravi Kanth <mvrravikanth@gmail.com>
Date:   Fri, 1 Sep 2023 19:33:57 +0530
Message-ID: <CAEvOrRyquLL6-d=vOyB9NNOPVE370qjV0zu8XBsTJmpOBx2UNw@mail.gmail.com>
Subject: Re: Support for CXL v3.0 spec with QEMU
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Sajjan Rao <sajjanr@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Thanks Jonathan. We built the custom kernel and were able to run the
test tool successfully and get the data.

However when we modify the code to send raw commands, we are not able
to send raw commands to the driver. We always see ENOPERM from the
driver. Below is the code snippet. Should we enable some settings or
from a code perspective should changes be made?

From CXL driver code perspective, we see that ENOPERM can only be
returned by cxl_mem_raw_command_allowed(). Not really sure why the raw
command is not able to go through but the MEM
command(CXL_MEM_COMMAND_ID_INFO_STAT_IDENTIFY) is able to run
successfully.

Can you please help us here?

Code snippet:
  cmd.id =3D CXL_MEM_COMMAND_ID_RAW;
  cmd.raw.opcode=3D 0x0001; /*This is a Identify (Opcode 0001h) per CXL spe=
c */
  cmd.out.size =3D sizeof(is_identify);
  cmd.out.payload =3D (__u64)&is_identify;

  printf("sending identify command...\n");
  printf("cmd.id:%x cmd.raw.opcode:%x\n",cmd.id,cmd.raw.opcode);
  printf("cmd.raw.rsvd:%d\n",cmd.raw.rsvd);
  rc =3D ioctl(fd, CXL_MEM_SEND_COMMAND, &cmd);

Appreciate your help all along.

Ravi

On Wed, Aug 23, 2023 at 10:33=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Wed, 16 Aug 2023 17:11:17 +0530
> Ravi Kanth <mvrravikanth@gmail.com> wrote:
>
> > Thanks, Jonathan. We were able to now see the CCI endpoint in the lspci=
 output.
> >
> > However, we are not able to see the /dev/cxl/switch0 node. Should we
> > be loading the cxl driver with the changes suggested by you in the
> > link below? If yes, We are not able to download the source code as we
> > do not see the git repository for the same. Is this part of the
> > mainline?
>
> Not yet part of mainline so you will have to apply the patches and build
> a custom kernel.
>
> Jonathan
>
> >
> > https://lore.kernel.org/linux-cxl/20230804115414.14391-1-Jonathan.Camer=
on@huawei.com/T/#t
> >
> > Ravi
> >
> > On Fri, Aug 11, 2023 at 7:22=E2=80=AFPM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> > >
> > > On Fri, 11 Aug 2023 17:34:33 +0530
> > > Ravi Kanth <mvrravikanth@gmail.com> wrote:
> > >
> > > > Hi Jonathan,
> > > > We build qemu with your repository code but we do not see any chang=
es
> > > > in the output of lspci. Do we have any prerequisites / command
> > > > parameters w.r.t on how we boot the qemu for your changes to take
> > > > effect? Please let us know.
> > >
> > > As the switch cci is a separate PCI function it needs to be explicitl=
y
> > > added. See the cover letter of kernel switch-cci RFC:
> > >
> > > https://lore.kernel.org/linux-cxl/20230804115414.14391-1-Jonathan.Cam=
eron@huawei.com
> > >
> > >  -device cxl-upstream,bus=3Dcxl_rp_port0,id=3Dus0,addr=3D0.0,multifun=
ction=3Don, \
> > >  -device cxl-switch-mailbox-cci,bus=3Dcxl_rp_port0,addr=3D0.1,target=
=3Dus0 \
> > >  -device cxl-downstream,port=3D0,bus=3Dus0,id=3Dswport0,chassis=3D0,s=
lot=3D4 \
> > >  -device cxl-downstream,port=3D1,bus=3Dus0,id=3Dswport1,chassis=3D0,s=
lot=3D5 \
> > >
> > > Is the switch part of it.
> > >
> > > We don't yet have the additions for MHDs though some discussion on ho=
w to
> > > do it has happened.  Those will support some FMAPI command via tunnel=
ling throuhg
> > > the main mailbox.
> > >
> > > I'm on vacation from tonight until the 22nd, so good luck. Feel free
> > > to post questions in meantime but my reply will take a while!
> > >
> > > Jonathan
> > >
> > > >
> > > > Thanks for your help.
> > > >
> > > > Thanks
> > > > Ravi
> > > >
> > > > On Thu, Aug 10, 2023 at 10:10=E2=80=AFPM Ravi Kanth <mvrravikanth@g=
mail.com> wrote:
> > > > >
> > > > > Thanks Jonathan for pointing this out. I will definitely take a l=
ook
> > > > > at this. Current support for the simulation of CCI mailbox is onl=
y via
> > > > > MCTP messages or even via CXL driver IOCTLs?
> > > > >
> > > > > Ravi
> > > > >
> > > > > On Thu, Aug 10, 2023 at 10:03=E2=80=AFPM Jonathan Cameron
> > > > > <Jonathan.Cameron@huawei.com> wrote:
> > > > > >
> > > > > > On Thu, 10 Aug 2023 21:42:12 +0530
> > > > > > Ravi Kanth <mvrravikanth@gmail.com> wrote:
> > > > > >
> > > > > > > Hello,
> > > > > >
> > > > > > Hi Ravi,
> > > > > >
> > > > > > >
> > > > > > > I am writing this mail to know if the latest QEMU has support=
 for CXL
> > > > > > > spec v3.0? I understand from the older tutorials that QEMU ha=
s support
> > > > > > > for CXL v2.0. Is there any update to QEMU to support the CXL =
v3.0? I
> > > > > > > would like to specifically test the CCI mailbox functionality=
 which
> > > > > > > has been added to CXL v3.0 spec.
> > > > > >
> > > > > > The nature of the CXL specification and the QEMU support is tha=
t for
> > > > > > devices there isn't a clear divide between different generation=
s of
> > > > > > the specification. By that I mean, that a device based on the C=
XL 2.0
> > > > > > specification is compatible with the CXL 3.0 specification. As =
such,
> > > > > > the QEMU emulation has focused on features of interest - it is =
a far
> > > > > > from complete implementation of all the options in the CXL 2.0
> > > > > > specification but conversely there are some parts of CXL 3.0 ar=
e supported.
> > > > > >
> > > > > > Note that the particular CCI functionality is not yet ready for=
 CXL upstream,
> > > > > > but we do have some support in the staging tree I maintain.
> > > > > >
> > > > > > https://gitlab.com/jic23/qemu/-/commits/cxl-2023-08-07/
> > > > > > specifically
> > > > > > https://gitlab.com/jic23/qemu/-/commit/2eb7e6402a45b359c304cea8=
94a1d27625a4b80c
> > > > > >
> > > > > > Note at this stage we only support subset of commands.
> > > > > > Contributions of more support welcomed!
> > > > > >
> > > > > > Intent of the current support and related MCTP CCI access (over=
 I2C) is
> > > > > > to enable ecosystem development, particularly of fabric manager=
s.
> > > > > > For that a tiny subset of commands was sufficient to be sure th=
e architecture
> > > > > > inside QEMU worked and that the proposed kernel code functions =
correctly.
> > > > > >
> > > > > > Jonathan
> > > > > >
> > > > > > >
> > > > > > > Thank you in advance for your assistance.
> > > > > > >
> > > > > > > Ravi
> > > > > >
> > > > >
> > > > >
> > > > > --
> > > > > Regards
> > > > > M.V.R.Ravi Kanth
> > > >
> > > >
> > > >
> > >
> >
> >
>


--=20
Ravi
