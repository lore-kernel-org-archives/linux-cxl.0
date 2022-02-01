Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7332CC433F5
	for <linux-cxl@archiver.kernel.org>; Tue,  1 Feb 2022 01:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbiBABcI (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 31 Jan 2022 20:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbiBABcI (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 31 Jan 2022 20:32:08 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5384DC061714
        for <linux-cxl@vger.kernel.org>; Mon, 31 Jan 2022 17:32:08 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id s2-20020a17090ad48200b001b501977b23so1012856pju.2
        for <linux-cxl@vger.kernel.org>; Mon, 31 Jan 2022 17:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XRLAa5TR3EHkLrr6oIGYc+Zb7vJHNpVte3URB1U9ueY=;
        b=zKyYFVyU81epyr6OHJTOSiyb6PsiTtrJTCVhwrmPXcj0knLWiDmoq1hNrfqvy3e+BX
         ZoivvcPqEfvtZj9Pvbd7GVotp5WoGIYiTe9o6t8UMWi1f/575/L2PBTyUmfrUm6L8syn
         iWn3uMJL+1EDykBBQbO/4Wp5dn81yc0AoGrR24XgmgZEMVb6fi6FTcUF06OGYxV3TvlV
         ZwsyWEP2vME8ViVZKyR9xQjzCkz8aURUBCtvQwA+XNqJJmvuwjgfKU53/SpDNzN1r49A
         kwtt78SSsmz18x/fueuQh56IhDaE6mdzOEcXnkqKRy28BzAzBOCaW/9YWOgR3MtxYsir
         hXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XRLAa5TR3EHkLrr6oIGYc+Zb7vJHNpVte3URB1U9ueY=;
        b=OmWOogK4ccwB4WMLMggYPr+vsP1P/I/+5v6ei/c6A7Of368Nl1gg3yujGSF9F1CRPb
         saKjdOtuoSgn/M3LFCDdFykI4w0E/4RZorkwAnvBvTgF0Gj257Ezx7ZwXIrtSJbR5T8I
         6+KN4115zXd4eu5MbXVfRDl/TmPEW/C6KQ8KRlwp/lJ17QYQRxme0uovHCcDgwI4NeN+
         3lBwkGqRDq/xahyzycg2I6CrfZ0BuKzlO3ofIlWNj71TPo3NBVLSNiu/ipaFVhSpxWY1
         /c/uFSNO9hku/z7PoTESn0m/TyDJheeSVyaI5MaP7Eb/xHPAtV+pJeqlQdVO3WfPjqn5
         zqnQ==
X-Gm-Message-State: AOAM531YD/Uek7mqjsQyZ9UO0d6FgBIfpvkz35bRAXxywOYC+j2sci0f
        PsOMIsK22X2a1evewsnZBaDMMKLlEZgpA5jqiVDjNw==
X-Google-Smtp-Source: ABdhPJyH62To2f39TJHPMQD+PmPnu3hOx6CJ9lnIfxcmZ+5Y+itByJr22t1wkvb4MTSNqEGhcGZ4Ees/OP1/BE9bd5o=
X-Received: by 2002:a17:902:b20a:: with SMTP id t10mr23263040plr.132.1643679127836;
 Mon, 31 Jan 2022 17:32:07 -0800 (PST)
MIME-Version: 1.0
References: <cover.1642535478.git.alison.schofield@intel.com>
 <e98fa18538c42c40b120d5c22da655d199d0329d.1642535478.git.alison.schofield@intel.com>
 <CAPcyv4j4Nq1AAxH2CybQCH3pcBpCWgCsnY5i=OfKQXd_C_3xWA@mail.gmail.com> <20220201012509.GA913535@alison-desk>
In-Reply-To: <20220201012509.GA913535@alison-desk>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 31 Jan 2022 17:32:00 -0800
Message-ID: <CAPcyv4imtsKLm8BqYOh53hGh46T0BLeUROb8BJWbGzGyPpzJJQ@mail.gmail.com>
Subject: Re: [ndctl PATCH v3 5/6] libcxl: add interfaces for
 SET_PARTITION_INFO mailbox command
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Jan 31, 2022 at 5:20 PM Alison Schofield
<alison.schofield@intel.com> wrote:
>
> Dan, One follow up below...
>
> On Wed, Jan 26, 2022 at 03:41:14PM -0800, Dan Williams wrote:
> > On Tue, Jan 18, 2022 at 12:20 PM <alison.schofield@intel.com> wrote:
> > >
> > > From: Alison Schofield <alison.schofield@intel.com>
> > >
> > > Users may want the ability to change the partition layout of a CXL
> > > memory device.
> > >
> > > Add interfaces to libcxl to allocate and send a SET_PARTITION_INFO
> > > mailbox as defined in the CXL 2.0 specification.
> > >
> > > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > > ---
> > >  cxl/lib/libcxl.c   | 50 ++++++++++++++++++++++++++++++++++++++++++++++
> > >  cxl/lib/libcxl.sym |  5 +++++
> > >  cxl/lib/private.h  |  8 ++++++++
> > >  cxl/libcxl.h       |  5 +++++
> > >  4 files changed, 68 insertions(+)
> > >
> > > diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
> > > index 5b1fc32..5a5b189 100644
> > > --- a/cxl/lib/libcxl.c
> > > +++ b/cxl/lib/libcxl.c
> > > @@ -1230,6 +1230,21 @@ cxl_cmd_partition_info_get_next_persistent_bytes(struct cxl_cmd *cmd)
> > >         cmd_partition_get_capacity_field(cmd, next_persistent_cap);
> > >  }
> > >
> > > +CXL_EXPORT struct cxl_cmd *cxl_cmd_new_set_partition_info(struct cxl_memdev *memdev,
> > > +               unsigned long long volatile_capacity, int flags)
> > > +{
> > > +       struct cxl_cmd_set_partition_info *set_partition;
> > > +       struct cxl_cmd *cmd;
> > > +
> > > +       cmd = cxl_cmd_new_generic(memdev,
> > > +                       CXL_MEM_COMMAND_ID_SET_PARTITION_INFO);
> > > +
> > > +       set_partition = (struct cxl_cmd_set_partition_info *)cmd->send_cmd->in.payload;
> >
> > ->in.payload is a 'void *', no casting required.
> >
>
> send_cmd->in.payload is a __u64 so this cast is needed.
>
> Of course, I wondered what Dan was thinking ;) and I see that struct
> cxl_cmd's input_payload is indeed a 'void *'.
>
> I believe this is the correct payload here, umm..  because it works ;)
>
> But - let me know if you suspect something is off here.

You're right...

...however :), I think this casting is what the core
cxl_cmd_alloc_send() helper is doing for everyone when it does:

cmd->send_cmd->in.payload = (u64)cmd->input_payload;

...so cxl_cmd_new_set_partition_info() can safely switch to the
shorter cmd->input_payload and drop its own redundant local casting.
