Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A4ACA0FE5
	for <linux-cxl@archiver.kernel.org>; Fri,  1 Sep 2023 16:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242856AbjIAQTg (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 1 Sep 2023 12:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbjIAQTf (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 1 Sep 2023 12:19:35 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B449E66
        for <linux-cxl@vger.kernel.org>; Fri,  1 Sep 2023 09:19:32 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-5008faf4456so3887258e87.3
        for <linux-cxl@vger.kernel.org>; Fri, 01 Sep 2023 09:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693585170; x=1694189970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DvHOJSMrHU0kPMDgxpvfFnMslMv5x0NzBoGq341W42E=;
        b=VwBSCyU9fiN7QhR4nho6bF0m4d1aJopIkU936UzAvkzL/IiRPHSIcQ1kuNmk3Pes+O
         97R+c2m2JejPxClv66geaIWnaJAufrMqOSawLpglm4yETVUKuWqK/qFEhoczplafSG82
         EZzXlt3E/9IR1wzf/bxnNij2fHvF0o+44Hu1M/Ev+O7mhcbR/9Gx7OeKHihdOXnLCbKx
         p72ygMbIow7qBPy50hUxDfxa3FB5HLxh5yB87bjRevNXAzNLnXKgKlQG46repTHcTQBg
         yN35MoL79m55w5JJO/jimTLbqQPddnIABDqQAsM6x02gRwgqVqJ/ZLbw0xzB2UBq2d6z
         TTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693585170; x=1694189970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DvHOJSMrHU0kPMDgxpvfFnMslMv5x0NzBoGq341W42E=;
        b=cdxgz4CowIdXoMMojQ9Jl3xsoxHV+yDC/bifrsrPMbgRe+xMCPAd3BGUddXWUS49bb
         PzjDxxnkCwTw142b8Q3dpn5S6jGqlbOAfw4i9/Mef2SV09+mru91SwpVVOlzDGBqQed0
         SqBSHv7HeKz9Uut4e7AYdQjMOH96zVPSqZGt1npNP3lCX1SlONi8WpQvMpZwgJxDWURM
         U45j/9IddDkorY3cWf3dJ9hw4r1ETrQOYZOSlVT2UiTs1ug/DyTesgqbywK6aeO4rkSy
         b83Jk9TJZUdDNwNAZJNy7i56wVSkvHt9rsEjQOM5xwj0Ubu+k+aHBcb5KDD+oB+cXOhV
         H3PA==
X-Gm-Message-State: AOJu0YyNK/TrbLMObyo8OBjUEGwDGox1sIyP3jY7yf33NOCP0J9ivx8y
        GZr/DLAoywDSeHI83eCZjloC5MfVPXf0+3YcD+w=
X-Google-Smtp-Source: AGHT+IGd6UQLIGbU7wDj6k58wztyai/TMtWxSDiFOXXZW/8H4Z61o31zqmmU+cgbtRv9laoi5pwCO7bkaVlbKR4qAkM=
X-Received: by 2002:a05:6512:3d90:b0:500:9dd4:2969 with SMTP id
 k16-20020a0565123d9000b005009dd42969mr2414834lfv.59.1693585170138; Fri, 01
 Sep 2023 09:19:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAEvOrRz9s8CumbuMbkCU+eCHgAp20X6q0i1D6fi5vfa5_F6JnA@mail.gmail.com>
 <20230810173322.0000543c@Huawei.com> <CAEvOrRyvaFBzhzP7kxWeCpYY-u5wjwAo6076FGhN_k-+NadUDA@mail.gmail.com>
 <CAEvOrRzPNwNFrg4Brw7axzgxv6WFeYr0rnsDGmSSNpn9hca-3Q@mail.gmail.com>
 <20230811145223.000040de@Huawei.com> <CAEvOrRzE76U2g_8=V3F-4fqwosRz3n9kO+40E_iG74EcbQBxtw@mail.gmail.com>
 <20230823180323.000052d5@Huawei.com> <CAEvOrRyquLL6-d=vOyB9NNOPVE370qjV0zu8XBsTJmpOBx2UNw@mail.gmail.com>
 <ZPHyoJsZDnzpU7C4@memverge.com> <CAEvOrRw2e3cn=2fNXO8_iX0kg09an-OSx1fnjx7ciGGhZo9f9A@mail.gmail.com>
In-Reply-To: <CAEvOrRw2e3cn=2fNXO8_iX0kg09an-OSx1fnjx7ciGGhZo9f9A@mail.gmail.com>
From:   Ravi Kanth <mvrravikanth@gmail.com>
Date:   Fri, 1 Sep 2023 21:49:18 +0530
Message-ID: <CAEvOrRy9qoydCqxq7xv1QNM+z+YQZyQORtqdDU2VcVKP42CJhA@mail.gmail.com>
Subject: Re: Support for CXL v3.0 spec with QEMU
To:     Gregory Price <gregory.price@memverge.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org, Sajjan Rao <sajjanr@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

We enabled the CONFIG_CXL_MEM_RAW_COMMANDS in the kernel. Now the raw
commands are going through and we are getting the responses. However
we saw the below crash when we sent the command for the first time.
Not able to recreate this now.

Stack trace -
[  257.746414] ------------[ cut here ]------------
[  257.746918] cxl_switchdev 0000:0d:00.1: raw command path used
[  257.747572] WARNING: CPU: 3 PID: 1013 at
drivers/cxl/core/mbox.c:673 cxl_send_cmd+0x43f/0x550 [cxl_core]
[  257.748589] Modules linked in: nft_fib_inet nft_fib_ipv4
nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6
nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6
nf_defrag_ig
[  257.755464] CPU: 3 PID: 1013 Comm: a.out Not tainted 6.4.11 #4
[  257.756080] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
[  257.757264] RIP: 0010:cxl_send_cmd+0x43f/0x550 [cxl_core]
[  257.757857] Code: c6 05 4e 63 01 00 01 4c 8b 77 50 4d 85 f6 75 03
4c 8b 37 e8 43 b6 2a ce 4c 89 f2 48 c7 c7 39 12 84 c0 48 89 c6 e8 31
f5 8f cd <0f> 0b e9 a9 fe ff ff 41 bf ff ff ff ff e9 db fd ff ff 0fb
[  257.759817] RSP: 0018:ff3ad3ba01e23dd8 EFLAGS: 00010292
[  257.760374] RAX: 0000000000000000 RBX: ff2df715038ed758 RCX: 00000000000=
00000
[  257.761150] RDX: ff2df7153bbae580 RSI: ff2df7153bba1540 RDI: ff2df7153bb=
a1540
[  257.761932] RBP: ff3ad3ba01e23e10 R08: 0000000000000000 R09: ff3ad3ba01e=
23c68
[  257.762702] R10: 0000000000000003 R11: ffffffff90146508 R12: 00007ffeaad=
a2cf0
[  257.763478] R13: ff3ad3ba01e23de0 R14: ff2df714c106f3c0 R15: 00000000fff=
fffff
[  257.764232] FS:  00007f88913e3640(0000) GS:ff2df7153bb80000(0000)
knlGS:0000000000000000
[  257.765085] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  257.765704] CR2: 00007f889139afd8 CR3: 000000013e69a006 CR4: 00000000007=
71ee0
[  257.766468] PKRU: 55555554
[  257.766762] Call Trace:
[  257.767029]  <TASK>
[  257.767263]  ? cxl_send_cmd+0x43f/0x550 [cxl_core]
[  257.767785]  ? __warn+0x81/0x130
[  257.768140]  ? cxl_send_cmd+0x43f/0x550 [cxl_core]
[  257.768681]  ? report_bug+0x171/0x1a0
[  257.769080]  ? __x86_return_thunk+0x9/0x10
[  257.769543]  ? prb_read_valid+0x1b/0x30
[  257.769962]  ? handle_bug+0x3c/0x80
[  257.770349]  ? exc_invalid_op+0x17/0x70
[  257.770771]  ? asm_exc_invalid_op+0x1a/0x20
[  257.771228]  ? cxl_send_cmd+0x43f/0x550 [cxl_core]
[  257.771760]  ? cxl_send_cmd+0x43f/0x550 [cxl_core]
[  257.772289]  cxl_swdev_ioctl+0x4f/0x80 [cxl_core]
[  257.772809]  __x64_sys_ioctl+0x91/0xd0
[  257.773222]  do_syscall_64+0x5d/0x90
[  257.773620]  ? do_syscall_64+0x6c/0x90
[  257.774017]  ? do_syscall_64+0x6c/0x90
[  257.774438]  ? __x86_return_thunk+0x9/0x10
[  257.774873]  ? exc_page_fault+0x7f/0x180
[  257.775586]  entry_SYSCALL_64_after_hwframe+0x77/0xe1
[  257.776373] RIP: 0033:0x7f889130aedd
[  257.777025] Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10
c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00
00 0f 05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 280
[  257.779555] RSP: 002b:00007ffeaada2c10 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[  257.780632] RAX: ffffffffffffffda RBX: 00007ffeaada2e88 RCX: 00007f88913=
0aedd
[  257.781656] RDX: 00007ffeaada2cf0 RSI: 00000000c030ce02 RDI: 00000000000=
00003
[  257.782692] RBP: 00007ffeaada2c60 R08: 0000000000000064 R09: 00000000000=
00000
[  257.783714] R10: 00007f889121b2e0 R11: 0000000000000246 R12: 00000000000=
00001
[  257.784741] R13: 0000000000000000 R14: 00007f889141e000 R15: 00000000004=
03e00
[  257.785753]  </TASK>
[  257.786243] ---[ end trace 0000000000000000 ]---

On Fri, Sep 1, 2023 at 8:07=E2=80=AFPM Ravi Kanth <mvrravikanth@gmail.com> =
wrote:
>
> Thanks Gregory. I will try enabling the CONFIG_CXL_MEM_RAW_COMMANDS and c=
heck.
>
> The reason we want to use the raw command interface is to send
> necessary opcodes that are of interest to the application as defined
> in the CXL spec. cxl_mem_commands has a very limited opcode set.
>
> Ravi
>
> On Fri, Sep 1, 2023 at 7:48=E2=80=AFPM Gregory Price <gregory.price@memve=
rge.com> wrote:
> >
> > On Fri, Sep 01, 2023 at 07:33:57PM +0530, Ravi Kanth wrote:
> > > Thanks Jonathan. We built the custom kernel and were able to run the
> > > test tool successfully and get the data.
> > >
> > > However when we modify the code to send raw commands, we are not able
> > > to send raw commands to the driver. We always see ENOPERM from the
> > > driver. Below is the code snippet. Should we enable some settings or
> > > from a code perspective should changes be made?
> > >
> > > From CXL driver code perspective, we see that ENOPERM can only be
> > > returned by cxl_mem_raw_command_allowed(). Not really sure why the ra=
w
> > > command is not able to go through but the MEM
> > > command(CXL_MEM_COMMAND_ID_INFO_STAT_IDENTIFY) is able to run
> > > successfully.
> > >
> > > Can you please help us here?
> > >
> > > Code snippet:
> > >   cmd.id =3D CXL_MEM_COMMAND_ID_RAW;
> > >   cmd.raw.opcode=3D 0x0001; /*This is a Identify (Opcode 0001h) per C=
XL spec */
> > >   cmd.out.size =3D sizeof(is_identify);
> > >   cmd.out.payload =3D (__u64)&is_identify;
> > >
> > >   printf("sending identify command...\n");
> > >   printf("cmd.id:%x cmd.raw.opcode:%x\n",cmd.id,cmd.raw.opcode);
> > >   printf("cmd.raw.rsvd:%d\n",cmd.raw.rsvd);
> > >   rc =3D ioctl(fd, CXL_MEM_SEND_COMMAND, &cmd);
> > >
> > > Appreciate your help all along.
> > >
> > > Ravi
> > >
> >
> > raw commands are not allowed by default, you must turn on
> > CONFIG_CXL_MEM_RAW_COMMANDS in the kernel build config.
> >
> > ~Gregory
>
>
>
> --
> Ravi



--=20
Ravi
