Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF6AC433F5
	for <linux-cxl@archiver.kernel.org>; Mon,  6 Dec 2021 17:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243020AbhLFRh2 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 6 Dec 2021 12:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243019AbhLFRh2 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 6 Dec 2021 12:37:28 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D82EC061746
        for <linux-cxl@vger.kernel.org>; Mon,  6 Dec 2021 09:33:59 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id j5-20020a17090a318500b001a6c749e697so286846pjb.1
        for <linux-cxl@vger.kernel.org>; Mon, 06 Dec 2021 09:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZCNDUaZwG42zsrD+nUIdp5Fhk9/kNd2z7N3qN5iVpFM=;
        b=jZExPsUZmQv0TnZWqobDBLNSwFFOTTqctWaRSIxRc9gpI9QyJc8O17Ab8LHdv3zopI
         TNSYIxz48G3PAFJcwd5as5STiYUhr4bxSY2x12WwtzODTMPlgucTq5Ro2Vik2Z1jVC82
         HAohTGtlutekLZrB5b5Ya0Gf5DAGJjg0gjcjqK8Rl11p528QdP/euK8FTJUVJ2MuPWLF
         +WwbgIDwmP4M5wMMh6uZizNtQbQhFjLD/wazy7THo6z3jN2pjDxRI6IRl2P0BUbNrxuj
         lhIKaUFM715f3EXsYRg4ghLivOwZaKo5JwmZxOy6kh2J3+2hPalKGvyok5qVkWlysQQe
         fwjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZCNDUaZwG42zsrD+nUIdp5Fhk9/kNd2z7N3qN5iVpFM=;
        b=qSMFpMtKlTQ6ElnwazCFaKsv0P5Z+bkXjYrNLNwO5e5AcR0suu2jos0e7JGg+ROzkV
         0KteCkP8PWQTuop7qF+eS8r+9VtGS0aRrzpk1OzKVq13UBU92iiqKoO255cHnt3DTK3W
         Lu2XMMYZYIOFpRrmZf0I8X4r56WeE1QKmtFH0deF+PUs9XGeYxQGdJZSUuaQmfYH+cv+
         EueVGTtOCwwTr7F+u6e1Zlev/4aFBHrmP8fUf9hKiVSH/78j3q1tueVNEizrBwzcH17/
         lNyBNIMJ/Dhr2jseqmzxfhGNyePCPM2LZCNB2rpbfnLxHOOKQ0IYT9H3/N7uodyAVeTE
         w4eQ==
X-Gm-Message-State: AOAM5331zE0dLFNWHD3JgXN3h99Tq3V8nYfVEP8tpyZ22nZG4ZwG9yWq
        xYlLuCN3G46ATwLiIt5OmlweDI39L56yMU2xtHnwZ1kceMY=
X-Google-Smtp-Source: ABdhPJzfILCxZAvJeMmGwDKMN1sl+9yd4O6diGBAGgQKRH8YoIoNn/CFRvQiMvI6YvtvAuqcgEvk+zdT+v2Y0IjSAFA=
X-Received: by 2002:a17:902:7fcd:b0:142:8ab3:ec0e with SMTP id
 t13-20020a1709027fcd00b001428ab3ec0emr44616668plb.4.1638812038936; Mon, 06
 Dec 2021 09:33:58 -0800 (PST)
MIME-Version: 1.0
References: <163855973642.1338601.12855868083437118567.stgit@dwillia2-desk3.amr.corp.intel.com>
 <163855974678.1338601.8865645356209268622.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20211206104623.000010da@Huawei.com>
In-Reply-To: <20211206104623.000010da@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 6 Dec 2021 09:33:48 -0800
Message-ID: <CAPcyv4hc9fz4Ncc2g0photprWEoCQj4jJxqpHpOgFayY5eu4Sg@mail.gmail.com>
Subject: Re: [PATCH 2/2] cxl/pci: Defer mailbox status checks to command timeouts
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Dec 6, 2021 at 2:46 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Fri, 3 Dec 2021 11:29:06 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > Device status can change without warning at any point in time. This
> > effectively means that no amount of status checking before a command is
> > submitted can guarantee that the device is not in an error condition
> > when the command is later submitted. The clearest signal that a device
> > is not able to process commands is if it fails to process commands.
> >
> > With the above understanding in hand, update cxl_pci_setup_mailbox() to
> > validate the readiness of the mailbox once at the beginning of time, and
> > then use timeouts and busy sequencing errors as the only occasions to
> > report status.
> >
> > Just as before, unless and until the driver gains a reset recovery path,
> > doorbell clearing failures by the device are fatal to mailbox
> > operations.
> >
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Just some bike-shedding on naming - up to you whether you think it is worth a tweak.
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Thanks,
>
> J
> > ---
> >  drivers/cxl/pci.c |  138 ++++++++++++++---------------------------------------
> >  1 file changed, 36 insertions(+), 102 deletions(-)
> >
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index 519795432708..36f80437a11a 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -72,14 +72,16 @@ static int cxl_pci_mbox_wait_for_doorbell(struct cxl_dev_state *cxlds)
> >       return 0;
> >  }
> >
> > -static void cxl_pci_mbox_timeout(struct cxl_dev_state *cxlds,
> > -                              struct cxl_mbox_cmd *mbox_cmd)
> > -{
> > -     struct device *dev = cxlds->dev;
> > +#define report_status(dev, status, msg)                                        \
> > +     dev_err_ratelimited(dev, msg ", device state %s%s\n",                  \
> > +                         status & CXLMDEV_DEV_FATAL ? " fatal" : "",        \
> > +                         status & CXLMDEV_FW_HALT ? " firmware-halt" : "")
> >
> > -     dev_dbg(dev, "Mailbox command (opcode: %#x size: %zub) timed out\n",
> > -             mbox_cmd->opcode, mbox_cmd->size_in);
> > -}
> > +#define report_cmd_status(dev, cmd, status, msg)                               \
>
> Naming wise, can we hint that this is an error print?  maybe
> report_err_cmd_status() or similar?

Sure, I'll go with cxl_err() and cxl_cmd_err().
