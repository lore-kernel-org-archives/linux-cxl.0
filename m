Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E234C4332F
	for <linux-cxl@archiver.kernel.org>; Wed, 24 Nov 2021 21:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235271AbhKXV6Z (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 24 Nov 2021 16:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233981AbhKXV6Y (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 24 Nov 2021 16:58:24 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC93C06173E
        for <linux-cxl@vger.kernel.org>; Wed, 24 Nov 2021 13:55:14 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id h63so3323623pgc.12
        for <linux-cxl@vger.kernel.org>; Wed, 24 Nov 2021 13:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TPBQUt0tCRzND1C2ALyzEsJ9E9HTMJ4xkRWjXNZ5unY=;
        b=23wlbioc0N/EnbIWNRkOAZVvaAX0IbTHN3Sjo5N/T3e1sa1mnt77IHbiYLMME0dsoF
         dcmKykn+2BdtPoPcagubhUy6bIQGPogG/AWG1fWQbGDPGzSqvBOZOMgaJKWe8TCGsiHJ
         qKuwJrQt61vDS03qVkQRWGyVzpvlFluFs07sgYZab6OhGvJrxEfyCzT+7W1TjBZ4QCGu
         y6aRItOuFxGlq6gTNmgQEVV8yFOe9IdEiSFTdP9WCLh/HtEQrNm6w/gmLuDxAXN6MH6N
         4DAYZQ5Qn+MSioliYz7ooRXTIS0iKQFcZI97mnu58HpXWm1IMXRNVqmWvxdfQiJD3trx
         A47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TPBQUt0tCRzND1C2ALyzEsJ9E9HTMJ4xkRWjXNZ5unY=;
        b=TxlU9Hf17ntyva6/yITVnHX9tFQvOl1Kid69IhHTOzuVmoRAZ2TzTfp0NZxo/CD/J4
         eWJ9uNfgQpzpsQxDZUpRYafUbKRvjKm4V7G1DdmBDkBuevRwQtJPLEJX87VmpthalWOg
         IXWohkZY+i3WqYEpdE4ds1ynC/hZxTpXK2HAf7rLwrxppwVVdSrDD1alLeqhfQ+sR0Gr
         Igj8HAFKfU9aSBTz9pZgppWcbdOKeiyI1lbZjcDpJKpxoN+d637r/lcQf7qVgTiD9x7G
         mUP7KnW/pp/oVxTZMZukUsjntIsvM3SJ5xCX93lybWFrAF7hpoS0Qei0PHfoavlOEiAQ
         PbPA==
X-Gm-Message-State: AOAM531HsLkImb3h24BDZ9j9YeJf2SM9NkAFctk/P0LOep0n4I/SIPsg
        /SOYi4sdK89uk6ukCizOHDuEXGjdKJjq5w8bIhJVGw==
X-Google-Smtp-Source: ABdhPJwhLn6YY0GSMTSdK5HRsMmlZdjbDdU6GXNdtmEZDwymbQUfTi97P/waaJwyFhpVBoDS0YiBDiP/oKm1SKeqihw=
X-Received: by 2002:a63:8141:: with SMTP id t62mr10800461pgd.5.1637790913904;
 Wed, 24 Nov 2021 13:55:13 -0800 (PST)
MIME-Version: 1.0
References: <20211120000250.1663391-1-ben.widawsky@intel.com> <20211120000250.1663391-6-ben.widawsky@intel.com>
In-Reply-To: <20211120000250.1663391-6-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 24 Nov 2021 13:55:03 -0800
Message-ID: <CAPcyv4jUExKbFhTXQGs_ayUvQqrp_76Z5Wywf7=ADXKcTF3DnQ@mail.gmail.com>
Subject: Re: [PATCH 05/23] cxl/pci: Don't poll doorbell for mailbox access
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Nov 19, 2021 at 4:03 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> The expectation is that the mailbox interface ready bit is the first
> step in access through the mailbox interface. Therefore, waiting for the
> doorbell busy bit to be clear would imply that the mailbox interface is
> ready. The original driver implementation used the doorbell timeout for
> the Mailbox Interface Ready bit to piggyback off of, since the latter
> doesn't have a defined timeout (introduced in 8adaf747c9f0 ("cxl/mem:
> Find device capabilities"), a timeout has since been defined with an ECN
> to the 2.0 spec). With the current driver waiting for mailbox interface
> ready as a part of probe() it's no longer necessary to use the
> piggyback.
>
> With the piggybacking no longer necessary it doesn't make sense to check
> doorbell status when acquiring the mailbox. It will be checked during
> the normal mailbox exchange protocol.
>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
> This patch did not exist in RFCv2
> ---
>  drivers/cxl/pci.c | 25 ++++++-------------------
>  1 file changed, 6 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 2cef9fec8599..869b4fc18e27 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -221,27 +221,14 @@ static int cxl_pci_mbox_get(struct cxl_dev_state *cxlds)
>
>         /*
>          * XXX: There is some amount of ambiguity in the 2.0 version of the spec
> -        * around the mailbox interface ready (8.2.8.5.1.1).  The purpose of the
> +        * around the mailbox interface ready (8.2.8.5.1.1). The purpose of the
>          * bit is to allow firmware running on the device to notify the driver
> -        * that it's ready to receive commands. It is unclear if the bit needs
> -        * to be read for each transaction mailbox, ie. the firmware can switch
> -        * it on and off as needed. Second, there is no defined timeout for
> -        * mailbox ready, like there is for the doorbell interface.
> -        *
> -        * Assumptions:
> -        * 1. The firmware might toggle the Mailbox Interface Ready bit, check
> -        *    it for every command.
> -        *
> -        * 2. If the doorbell is clear, the firmware should have first set the
> -        *    Mailbox Interface Ready bit. Therefore, waiting for the doorbell
> -        *    to be ready is sufficient.
> +        * that it's ready to receive commands. The spec does not clearly define
> +        * under what conditions the bit may get set or cleared. As of the 2.0
> +        * base specification there was no defined timeout for mailbox ready,
> +        * like there is for the doorbell interface. This was fixed with an ECN,
> +        * but it's possible early devices implemented this before the ECN.

Can we just drop comment block altogether? Outside of
cxl_pci_setup_mailbox() the only time the mailbox status should be
checked is after a doorbell timeout after submitting a command.

>          */
> -       rc = cxl_pci_mbox_wait_for_doorbell(cxlds);
> -       if (rc) {
> -               dev_warn(dev, "Mailbox interface not ready\n");
> -               goto out;
> -       }
> -
>         md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
>         if (!(md_status & CXLMDEV_MBOX_IF_READY && CXLMDEV_READY(md_status))) {
>                 dev_err(dev, "mbox: reported doorbell ready, but not mbox ready\n");

This error message is obsolete since nothing is pre-checking the
mailbox anymore, and per above I see no problem waiting to check the
status until after the mailbox has failed to respond after a timeout.
