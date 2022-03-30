Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A249FC433F5
	for <linux-cxl@archiver.kernel.org>; Wed, 30 Mar 2022 00:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241434AbiC3AXA (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 29 Mar 2022 20:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235006AbiC3AW6 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 29 Mar 2022 20:22:58 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11436166E28
        for <linux-cxl@vger.kernel.org>; Tue, 29 Mar 2022 17:21:14 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id gb19so19058429pjb.1
        for <linux-cxl@vger.kernel.org>; Tue, 29 Mar 2022 17:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4S0RJDMnLdSA4DvDs8AqDAH8NPqf2EUowjF4fPVnqEE=;
        b=y2hysEGfcrFP9xasvcgS27YB0035JFciyN63yY7dvHm2ORvw+YANRYLX3uXce9LBPb
         cefXx8Hrjfnj5Y/lbsjyIU1EEBY3gHBCiQ5IZYcuzDdzKRqv+YbTdc/+l3GzKgMiLx5j
         p2l3ECSGVYCeQKSm+8FmXZF44sFTXkcX4mqCI3xkyiK5+5xu7T7TwtXlJxTHBUSUZ/EQ
         witBzNk1ua2naPV0MDuJl7QlU21yIscKUA3Dt29NwIQxv36Oos6QELmKxckcn571kWsc
         Eg+YiY7IMHqnbgGSlIulLHCLxyu0+/HTCdDdUgMHt1Lwaj0FiLRLFaFg65KyvRXGLr9x
         QG1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4S0RJDMnLdSA4DvDs8AqDAH8NPqf2EUowjF4fPVnqEE=;
        b=Z/HOUPIg1TPQk1XMrC2GL17z7Liv4m0cQqIKZdi5AnRaeiBPj7Ta9ncZjp9dvBdD7s
         yZJjziBKcZJ4UtKeFKJlNYedLy2ggvoe3skalAH4YJpR90JaVGY9RzJuqmPuNyg23ik1
         mI6TGTmJJjkmTNLCpD/3I5FqMtnhVkqwlcvinZ+hnohkQZtH2yDAIRJF5fiFHufaATSO
         l1G1GusPP/X2MJW6cHTu1UcIYPMzuVJCUj8woIxFBfjtx0ZNKduSrjQmGZQAIMY+gTjc
         0JDcp/cxYtW/ZlyDxSVlm4GmACTsoXjrdP6fNvX6oYVtSeV3mb3Lk2mIygKc2Jj0MTo1
         0SZg==
X-Gm-Message-State: AOAM530MF9jNLdCF/pMRYkdEHLZ/lPaJ2nfAHc9EhWFG0msENYdf/qDJ
        WJqkPh2/PjgVZg5D5Gx04YHAT1GRGj5F0cfo3l6Uog==
X-Google-Smtp-Source: ABdhPJzeedw0TLEPOOp0RUnG5zUi9PVcxY0k0z6taDTEOKQYBB/qSCgeovFVgjPSdElX58/sNfgtQYh/bYzTY/ZxDY0=
X-Received: by 2002:a17:903:32c7:b0:154:4156:f384 with SMTP id
 i7-20020a17090332c700b001544156f384mr32904985plr.34.1648599674315; Tue, 29
 Mar 2022 17:21:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220317234049.69323-1-dave@stgolabs.net> <20220317234049.69323-3-dave@stgolabs.net>
 <CAPcyv4jr8-pPBDq7+APZB1a2WjuGUQvFWmGqMoT9rT0UceCkKw@mail.gmail.com>
In-Reply-To: <CAPcyv4jr8-pPBDq7+APZB1a2WjuGUQvFWmGqMoT9rT0UceCkKw@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 29 Mar 2022 17:21:03 -0700
Message-ID: <CAPcyv4i6NrzLFBtr5GMpHRF8HgBV-e6sjxdKsx08ZjNOt6gp+w@mail.gmail.com>
Subject: Re: [PATCH 2/5] cxl/pci: Use CXL_MBOX_SUCCESS to check against
 mbox_cmd return code
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Mar 29, 2022 at 4:42 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Thu, Mar 17, 2022 at 4:41 PM Davidlohr Bueso <dave@stgolabs.net> wrote:
> >
> > Also mention the need for the caller to check against any
> > errors from the hardware in return_code.
> >
> > Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> > ---
> >  drivers/cxl/pci.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index 8a7267d116b7..c77e06aff8dc 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -177,9 +177,9 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
> >         mbox_cmd->return_code =
> >                 FIELD_GET(CXLDEV_MBOX_STATUS_RET_CODE_MASK, status_reg);
> >
> > -       if (mbox_cmd->return_code != 0) {
> > +       if (mbox_cmd->return_code != CXL_MBOX_SUCCESS) {
> >                 dev_dbg(dev, "Mailbox operation had an error\n");
> > -               return 0;
> > +               return 0;  /* completed but caller must check return_code */
>
> Looks like a good clarification to me.
>
> Applied.
>
> ...but note it won't appear anywhere until after v5.18-rc1 is out.

...although given there are already feedback comments on patch 1 and 3
I also don't mind if you resend the full series for v2.
