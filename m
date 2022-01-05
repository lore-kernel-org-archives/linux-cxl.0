Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74932C433EF
	for <linux-cxl@archiver.kernel.org>; Wed,  5 Jan 2022 03:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiAEDW0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 4 Jan 2022 22:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiAEDWZ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 4 Jan 2022 22:22:25 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBB9C061761
        for <linux-cxl@vger.kernel.org>; Tue,  4 Jan 2022 19:22:25 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id o63-20020a17090a0a4500b001b1c2db8145so1981488pjo.5
        for <linux-cxl@vger.kernel.org>; Tue, 04 Jan 2022 19:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EKXXMyW17upeqYNPseiC57t1roSrNuMgRBcYFS/Cn48=;
        b=wdPsxr5ZpxV6pXRK0toKdgcFCLwtRv9a/Tuofp/f0vCX76nFzFhOpFxaPqdQQRkTcV
         cPkAXQtRzsH3tdp02ZjFp68OTvcCGyUYxt+eI6FsnsVYSn3o92eZlTqFh6Kqjh8esXM8
         Jyn8HpQLkmxWDEPaSWxAUIzfrKuJ71cp7l7Z6r3TUr2p0ERpsiuTT3wQVWwyur7pjMY6
         kcammZ/fWPouhIWAvykJXg3vETlX2UHAMJ54xVFD8OAt7PFDTJXSLUBbJkw7I4wUn7j2
         8lVjysZx3ZQp+VpGBZXZ1xS9V9CkBKrZ4xZpyHTR46ItrZKZ3tYsXcMUDLl24qB67Ro6
         UGLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EKXXMyW17upeqYNPseiC57t1roSrNuMgRBcYFS/Cn48=;
        b=PV6WrIs6x9g+whCm9KnRZWhnhnw9ZHvDpCz1CdH//Iv+H+g2GYKKGjH9X3QHqQKtgG
         HCJbV2dLoZM3WUO5wP4AJR5uSNDgJp8mbqU1JguxP13Kqj03W7DqTNcnb0r/7EB+iZgK
         YjJJaPh38DtFhFzF4PHPveZtYFpp9P6dIIFmU3KXCaZToaFs32Ok9RYOen5Qh4qAmPlJ
         iDYnF8YJkO2zL7qLtP8p09DTA1ZnBet5NgTzQ0DA34EAnnr3IW7oUrFaPEUlXHh0k582
         H1Hz3iXjxm6mn/ImhumH/t2KffuCgXY9JVVF/n+PENbcZRxBhSnhdPNpxlim2eVccYGX
         XF8w==
X-Gm-Message-State: AOAM531ARO5MxvMWWzlgymw2H7VTWkpF7CUTj9aBomHOMaaNLR9NCX4p
        9R0hqZDJ2sAFjcKcggbytWQoSmXVXFDNrunUIBtOtw==
X-Google-Smtp-Source: ABdhPJzf6TcbcwNR9X36HIimIm4mlqyAUoSUgOxrj3aMJ8Z8qSBiudCbjHIfRdM9iyoy0QdE2Q7PBF1Gd2MjFnhEdes=
X-Received: by 2002:a17:902:c94d:b0:149:16cb:22e1 with SMTP id
 i13-20020a170902c94d00b0014916cb22e1mr51906508pla.34.1641352944820; Tue, 04
 Jan 2022 19:22:24 -0800 (PST)
MIME-Version: 1.0
References: <20220103202100.784194-1-alison.schofield@intel.com>
 <20220104232134.y7j5rs4ljizkl462@intel.com> <20220105005916.GA790377@alison-desk>
In-Reply-To: <20220105005916.GA790377@alison-desk>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 4 Jan 2022 19:22:14 -0800
Message-ID: <CAPcyv4j1fOTLSLad4__gFQvLhEhXRyAuoHY7M1GetyQ1qdNASA@mail.gmail.com>
Subject: Re: [PATCH] cxl/mbox: Do not allow immediate mode in SET_PARTITION_INFO
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Jan 4, 2022 at 4:54 PM Alison Schofield
<alison.schofield@intel.com> wrote:
>
> Thanks for the review Ben...
>
> On Tue, Jan 04, 2022 at 03:21:34PM -0800, Ben Widawsky wrote:
> > On 22-01-03 12:21:00, alison.schofield@intel.com wrote:
> > > From: Alison Schofield <alison.schofield@intel.com>
> > >
> > > User space may send the SET_PARTITION_INFO mailbox command using
> > > the IOCTL interface. Inspect the input payload and fail if the
> > > immediate flag is set.
> > >
> > > This is the first instance of the driver inspecting an input payload
> > > from user space. Assume there will be more such cases and implement
> > > with an extensible helper.
> >
> > Not sure if it's useful, but this was implemented at some point:
> > https://lore.kernel.org/linux-cxl/20210210000259.635748-8-ben.widawsky@intel.com/
>
> Thanks. Looking.
>
> >
> snip
>
> > > @@ -405,6 +440,14 @@ static int handle_mailbox_cmd_from_user(struct cxl_dev_state *cxlds,
> > >             }
> > >     }
> > >
> > > +   if (!cxl_payload_from_user_allowed(mbox_cmd.opcode,
> > > +                                      mbox_cmd.payload_in)) {
> > > +           dev_dbg(dev, "%s: input payload not allowed\n",
> > > +                   cxl_command_names[cmd->info.id].name);
> > > +           rc = -EINVAL;
> > > +           goto out;
> > > +   }
> > > +
> >
> > Perhaps foolishly, the kdocs for handle_mailbox_cmd_from_user() documents the
> > error conditions. Would you mind adding EINVAL?
>
> I'm going to try to mv the allowable check, so this will go away.

Wouldn't the error code be EBUSY just like the other commands the
kernel blocks based on the state of the device?

It's moot if this is moving.

>
> >
> > Also, cxl_validate_cmd_from_user() was supposed to handle this kind of stuff.
> > All validation from user commands should spawn from that. Is there some reason
> > this one is different?
>
> The existing cxl_validate_cmd_from_user() happens before we copy the
> payload from user - so this payload check didn't fit in there.
> Let me look at reorganizing a bit so validating the cmd and it's payload
> can both spawn from cxl_validate_cmd_from_user().

Having cxl_validate_cmd_from_user() setup the 'struct cxl_mbox_cmd'
and then forward that along to handle_mailbox_cmd_from_user() doesn't
sound too bad. It does mean we need to remember that if the kernel
grows internal paths for calling commands that might be disallowed by
the state of the device we might need to move this validation out of
the "from user" context.
