Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C2BC71153
	for <linux-cxl@archiver.kernel.org>; Tue, 29 Aug 2023 00:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234511AbjH1X7g (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 28 Aug 2023 19:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234529AbjH1X7Q (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 28 Aug 2023 19:59:16 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85434194
        for <linux-cxl@vger.kernel.org>; Mon, 28 Aug 2023 16:59:11 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6bcae8c4072so2593621a34.1
        for <linux-cxl@vger.kernel.org>; Mon, 28 Aug 2023 16:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zptcorp-com.20221208.gappssmtp.com; s=20221208; t=1693267151; x=1693871951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IUo0CJ4EA2cSjpBbm5UWbTWxas5uq/UQuNEb0p2d3Nw=;
        b=wotTVMxzKb2raV/b5ci/o35YkrvpUCcZAncbnVhrWr5vkLNEzu9qYPr1+EWF1ii2JY
         2qDs+Cj0FppFNW+Ht0nr1tmHUINAuFLaigcf+PN+BfHroddUi7GfnNz1+5cBtX3nshBy
         M7aF5he+BULyUhlm3ace0Yfzq6lk8CqvZUIma7myyA9+5Ktn9wi67GK8nS1FMFBbXPIZ
         o8edEfHbZcyhwkt/zVrrgP0fiXrQT79wJifSMlyLr/W9uvWE1S0tSfgWjTr5Zrd59gq4
         FogYh5/T5jOou4ee3Kp0Zgk4aFWFwU22dKVNh+od8RKw1n7+v6KIJAQDQCRiISz4qivz
         SHsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693267151; x=1693871951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IUo0CJ4EA2cSjpBbm5UWbTWxas5uq/UQuNEb0p2d3Nw=;
        b=L4A+K+C4KBHD+F1d6AuSJKVYnT+/mqguRvglXyYMpJ4sODNWOowp0wJbcBO1JoKIA0
         lI1OyNFwQSMKCeyIY/Hbo7P42NBRb+h2e6f28Yzao4l/sgkh4RF67vPQ6MVfmZIQgSWn
         GlNuAgGqQzze5n59yM4M2mgfB20C1P0Cl0YE4zp+QDxDdm1dA7U/a6yQgxzK/TO5xjL1
         oCFqH7NZ8dV+J5C7sP3UGMlzWXwZQ2dkSVkZloVXA4/+VX+xbX0iK9R5E1XFDzMVFY0K
         YArw6dWD4+3LmY90a7gEDN6eIPSdI5lUUbRzxPE4MrFbbNIjVzzAuJd3fFLfMUlK6xyL
         v/Bg==
X-Gm-Message-State: AOJu0YxPbF6NYdWWCPZwVA1Wz3wSRRAq8XX9yqfn3fJh/SY7sJMyMuvm
        NdGbiCSR13IKYknzZti3N1UThnXMJyDBRcmfagnS3Xlo/HHYloZ/D7g+bAKf9U2erOQ1VSaaPz8
        C/xlxsUcEEdVxGZqaUYq4y/N6jhQrIg==
X-Google-Smtp-Source: AGHT+IEFE3U08hNn0XCtXtkjgkO/dncOLiX0ifE41UKTtm+g9zeAcvV1jc5QahXSLZpZiUm9m4/Vw6ikYezujCH7dJ8=
X-Received: by 2002:a9d:7d97:0:b0:6bd:9b7:1072 with SMTP id
 j23-20020a9d7d97000000b006bd09b71072mr11620041otn.37.1693267150869; Mon, 28
 Aug 2023 16:59:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAGEDW0dTTvnm-ZzSv_aDLNKj-gZja1A2s3+HKfY8wBn5rX4XdQ@mail.gmail.com>
 <20230823175526.0000368e@Huawei.com> <ZOZgVm3fx8fEf8xq@memverge.com>
In-Reply-To: <ZOZgVm3fx8fEf8xq@memverge.com>
From:   Dimitrios Palyvos <dimitrios.palyvos@zptcorp.com>
Date:   Tue, 29 Aug 2023 01:59:00 +0200
Message-ID: <CAGEDW0eJFhn1QDTn1JMdXDsqH2gXxonX+J_76GJSvewZhFYt_g@mail.gmail.com>
Subject: Re: QEMU freeze with CXL memory in Normal zone and stress-ng
To:     Gregory Price <gregory.price@memverge.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Thanks for the responses Jonathan & Gregory!

On Wed, Aug 23, 2023 at 9:39=E2=80=AFPM Gregory Price
<gregory.price@memverge.com> wrote:
> To me, what you're describing isn't the system freezing.  I have
> observed that the performance of CXL memory is so poor that the kernel
> will simply prefer not to use the memory at all (as it in will prefer
> using swap space instead, because it's that slow).
>
> When a system crawls to a halt like this, it's anyone's guess as to
> whether things like watchdogs and background tasks start preventing
> forward progress.  Your interrupt injections may be masked by emulated
> timers and all kinds of other stuff.  Basically you end up in a
> starvation situation, and the only real answer to that problem is
> "execute faster".

The explanation about the slowness and ZONE_NORMAL makes sense. I just
want to stress that I cannot see *any* CXL memory accesses after the
guest system freezes.
However, I guess that a potential deadlock in
the kernel could explain this behavior.

Another - maybe unrelated - thing I noticed when investigating this
issue: QEMU branch
cxl-2023-07-17 (from https://gitlab.com/jic23/qemu) seems to have
issues with gdb even in normal execution: pressing <Ctrl-C> in gdb
while targeting QEMU started with flag -s does not work ("The target
is not responding to interrupt requests"). This issue does not exist
in cxl-2023-05-19, where gdb kernel debugging works fine until the
guest freezes.

On Wed, Aug 23, 2023 at 6:55=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
> Long shot, but can you add code to print the address and size of each acc=
ess.
> There might be something nasty around edge conditions that we've gotten
> wrong in the emulation - I thought I'd poked them all but maybe not.

That's something I can try. I will collect a detailed memory access
trace and ping you back if I
notice anything interesting.

Kind regards,
Dimitris

--=20
**CONFIDENTIALITY NOTICE:*
*
*The contents of this email message and any=20
attachments are intended solely for the addressee(s) and may contain=20
confidential and/or privileged information and may be legally protected=20
from disclosure. If you are not the intended recipient of this message or=
=20
their agent, or if this message has been addressed to you in error, please=
=20
immediately alert the sender by reply email and then delete this message=20
and any attachments. If you are not the intended recipient, you are hereby=
=20
notified that any use, dissemination, copying, or storage of this message=
=20
or its attachments is strictly prohibited.=C2=A0*
