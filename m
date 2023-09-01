Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E95CA0FE4
	for <linux-cxl@archiver.kernel.org>; Fri,  1 Sep 2023 14:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239548AbjIAOh3 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 1 Sep 2023 10:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236217AbjIAOh2 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 1 Sep 2023 10:37:28 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF79A4
        for <linux-cxl@vger.kernel.org>; Fri,  1 Sep 2023 07:37:24 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-5007f3d3235so3706486e87.2
        for <linux-cxl@vger.kernel.org>; Fri, 01 Sep 2023 07:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693579042; x=1694183842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ASFCRQ5RHovpgaZ7sBgZE2F1Bk78dMgCyxobfGXPzN0=;
        b=T6AEN9YAbuZJo/SV+ksqadxsvq+XJFX3iRqwnDoFVXbD2WsMgefLaLBo+kKlF7aoF8
         LuPLfPoq7jagcaVF9z/KNnxLJ6+/utQigHERVJAq+QDK33Jxxb5XCkDAaIAVcdAWBNKE
         WBQ+bHy6MFXWFLvLeuBBRd4tH4SsYVMB7Y2vocbmqukTXO6xg9DYuxPdsEJOSxTuDYO8
         wC4SR3kbrJVBY04+2uldvBe+/ITy4WXd6YQrDdDtJtbUu9XgRrGCVlhZyCzLkBM2MBiT
         +L7XessLMKS2IxgbIl+z4Q1i+OSDC/QqwFTpZcANLxZHoc1ZYaHYe6ug1bjYPg79ucWs
         Kp3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693579042; x=1694183842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ASFCRQ5RHovpgaZ7sBgZE2F1Bk78dMgCyxobfGXPzN0=;
        b=IegI8k1EFqUrnYRp5yGcUw7viEnmRJ1jf+DIsMPowUPxDKC1PADo3686W+AtdNZ9or
         rDlVV2yiqEaqSDdlj68ck8Z/M6aB8iKEzGpoNSLX1d7brSSmXu7wxIPkoHVDX6Hw0Yub
         /4Svw93zGhWxjPAVkffZtfu+XXTTnDX57oYrH+JEpB9C0jqhFjeQ+weEh868VNYglTUN
         yj4InyUIz9ShRMXoJmmx2JQXmjWF75qx5qyXAPgX6dLTBdLoLCTUqXJFsmPm4R1pWQbl
         xzEfklquk/2Nd6Ao6rhZYp1YSER0BjB9vXBxY8gPnWLL2BQPsn6JvXY4xqykq03qty7y
         crPQ==
X-Gm-Message-State: AOJu0YxQzSDw2xG2JHpMKUQjBg5pEm9tbG1X1FA0/D9bca5xBkQWSRtd
        aQhZb/Y7OlP5DKpjFK5d4beAHY3MY6XkaMtyOYU=
X-Google-Smtp-Source: AGHT+IGuYTzum1WkpeSlVuRIlWpT2YinJFlUNWbvmdq/nA/Lr8xYw0diMU9ZZaWx5FYxNI7nlyoZqe2KwYqKcIa/wmE=
X-Received: by 2002:a05:6512:3249:b0:4fe:1681:9378 with SMTP id
 c9-20020a056512324900b004fe16819378mr1424241lfr.66.1693579042295; Fri, 01 Sep
 2023 07:37:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAEvOrRz9s8CumbuMbkCU+eCHgAp20X6q0i1D6fi5vfa5_F6JnA@mail.gmail.com>
 <20230810173322.0000543c@Huawei.com> <CAEvOrRyvaFBzhzP7kxWeCpYY-u5wjwAo6076FGhN_k-+NadUDA@mail.gmail.com>
 <CAEvOrRzPNwNFrg4Brw7axzgxv6WFeYr0rnsDGmSSNpn9hca-3Q@mail.gmail.com>
 <20230811145223.000040de@Huawei.com> <CAEvOrRzE76U2g_8=V3F-4fqwosRz3n9kO+40E_iG74EcbQBxtw@mail.gmail.com>
 <20230823180323.000052d5@Huawei.com> <CAEvOrRyquLL6-d=vOyB9NNOPVE370qjV0zu8XBsTJmpOBx2UNw@mail.gmail.com>
 <ZPHyoJsZDnzpU7C4@memverge.com>
In-Reply-To: <ZPHyoJsZDnzpU7C4@memverge.com>
From:   Ravi Kanth <mvrravikanth@gmail.com>
Date:   Fri, 1 Sep 2023 20:07:11 +0530
Message-ID: <CAEvOrRw2e3cn=2fNXO8_iX0kg09an-OSx1fnjx7ciGGhZo9f9A@mail.gmail.com>
Subject: Re: Support for CXL v3.0 spec with QEMU
To:     Gregory Price <gregory.price@memverge.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org, Sajjan Rao <sajjanr@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Thanks Gregory. I will try enabling the CONFIG_CXL_MEM_RAW_COMMANDS and che=
ck.

The reason we want to use the raw command interface is to send
necessary opcodes that are of interest to the application as defined
in the CXL spec. cxl_mem_commands has a very limited opcode set.

Ravi

On Fri, Sep 1, 2023 at 7:48=E2=80=AFPM Gregory Price <gregory.price@memverg=
e.com> wrote:
>
> On Fri, Sep 01, 2023 at 07:33:57PM +0530, Ravi Kanth wrote:
> > Thanks Jonathan. We built the custom kernel and were able to run the
> > test tool successfully and get the data.
> >
> > However when we modify the code to send raw commands, we are not able
> > to send raw commands to the driver. We always see ENOPERM from the
> > driver. Below is the code snippet. Should we enable some settings or
> > from a code perspective should changes be made?
> >
> > From CXL driver code perspective, we see that ENOPERM can only be
> > returned by cxl_mem_raw_command_allowed(). Not really sure why the raw
> > command is not able to go through but the MEM
> > command(CXL_MEM_COMMAND_ID_INFO_STAT_IDENTIFY) is able to run
> > successfully.
> >
> > Can you please help us here?
> >
> > Code snippet:
> >   cmd.id =3D CXL_MEM_COMMAND_ID_RAW;
> >   cmd.raw.opcode=3D 0x0001; /*This is a Identify (Opcode 0001h) per CXL=
 spec */
> >   cmd.out.size =3D sizeof(is_identify);
> >   cmd.out.payload =3D (__u64)&is_identify;
> >
> >   printf("sending identify command...\n");
> >   printf("cmd.id:%x cmd.raw.opcode:%x\n",cmd.id,cmd.raw.opcode);
> >   printf("cmd.raw.rsvd:%d\n",cmd.raw.rsvd);
> >   rc =3D ioctl(fd, CXL_MEM_SEND_COMMAND, &cmd);
> >
> > Appreciate your help all along.
> >
> > Ravi
> >
>
> raw commands are not allowed by default, you must turn on
> CONFIG_CXL_MEM_RAW_COMMANDS in the kernel build config.
>
> ~Gregory



--=20
Ravi
