Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBA9C7EE23
	for <linux-cxl@archiver.kernel.org>; Tue, 23 May 2023 10:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjEWKvr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 23 May 2023 06:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236617AbjEWKui (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 23 May 2023 06:50:38 -0400
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702771B0;
        Tue, 23 May 2023 03:49:20 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-513fd8cc095so174223a12.0;
        Tue, 23 May 2023 03:49:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684838959; x=1687430959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r+DDAHkCIVvsdLua1ZsXqc8YshdkjLYGEdEPiP8VfRY=;
        b=Ko4zgcsEZ2BIoffQz6j+O7IXvIjbjaHhPu4hhfOX+7BqzBbbk7e97Aceb6eqTxVY4d
         WsC4aAl+r58/teUqj4oL55xEszDxSM2cHiCHB+24n+tcgG+f7LSDcgXuNqxpvh2h18mY
         iq6L+/7zfknaKdXVMSsOFaRy94oJTztSBn9kTAPQdmFnoUYIZSvlsbWovQNY+GFtzI4P
         OS6bMpuQw9diz+yNrt3iGWou5/vAqGwZZDxCu/yYuncCexI3ODFVqgIg5ac7lzae0JvF
         YySKN0L4/R+1ss4huK+8V8NfIVbqPnbEmr4HbkAPI4Ju7Wx7m7zIXUs+TmCdPdWDtY5r
         YAfg==
X-Gm-Message-State: AC+VfDwOX/Hd485Es1o1qZwqRyVBsjGD+LNQHg3UNWdTR59I4LRsU+8r
        BIATm9q/IxWvsyJC6xvORtU8R2Un6/c1icSvIKg=
X-Google-Smtp-Source: ACHHUZ5G3dD7ZKW30/dmMYJbfOBQc35e1Am0I5d1KYVnwzzWM5uIQyKmYZGI7cXxPHdWzpAHtCPkF3G+0JZ836Ok+Cg=
X-Received: by 2002:a17:906:1019:b0:96f:4cd0:56a1 with SMTP id
 25-20020a170906101900b0096f4cd056a1mr11805374ejm.5.1684838958555; Tue, 23 May
 2023 03:49:18 -0700 (PDT)
MIME-Version: 1.0
References: <168443445827.2966470.16511867875780059322.stgit@djiang5-mobl3>
 <168443480048.2966470.1931302851443645778.stgit@djiang5-mobl3> <646bf9cbbbd2c_33fb3294e5@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <646bf9cbbbd2c_33fb3294e5@dwillia2-xfh.jf.intel.com.notmuch>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 23 May 2023 12:49:06 +0200
Message-ID: <CAJZ5v0jL6Ebzi7KG0+=PGp5vCS2v8rNeLcLtCSxCBB7DXBZWeA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] acpi: Add defines for CDAT SSLBIS
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Dave Jiang <dave.jiang@intel.com>, linux-acpi@vger.kernel.org,
        linux-cxl@vger.kernel.org, rafael@kernel.org, lenb@kernel.org,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, lukas@wunner.de,
        Jonathan.Cameron@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, May 23, 2023 at 1:25 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Dave Jiang wrote:
> > Add upstream port and any port definition for SSLBIS.
> >
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> >
> > ---
> > See https://github.com/acpica/acpica/pull/874
> > Merged
> > ---
> >  include/acpi/actbl1.h |    3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> > index 15df363b9144..c6189fafe87f 100644
> > --- a/include/acpi/actbl1.h
> > +++ b/include/acpi/actbl1.h
> > @@ -419,6 +419,9 @@ struct acpi_cdat_sslbe {
> >       u16 reserved;
> >  };
> >
> > +#define ACPI_CDAT_SSLBIS_US_PORT     0x0100
> > +#define ACPI_CDAT_SSLBIS_ANY_PORT    0xffff
> > +
> >  /*******************************************************************************
> >   *
> >   * CEDT - CXL Early Discovery Table
>
> Similar to the last patch, just define these locally outside of
> include/acpi/actbl1.h in the patch that needs them and drop the ACPICA
> entanglement.

Yes, if they are not used anywhere else, it's better to do that.

The local definitions can be dropped later when upstream ACPICA acquires them.

That said, it would be prudent to submit an upstream ACPICA pull
request adding them too.
