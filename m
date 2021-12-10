Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC66C433EF
	for <linux-cxl@archiver.kernel.org>; Fri, 10 Dec 2021 19:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238398AbhLJTpH (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 10 Dec 2021 14:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbhLJTpH (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 10 Dec 2021 14:45:07 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE284C061746
        for <linux-cxl@vger.kernel.org>; Fri, 10 Dec 2021 11:41:31 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id x7so7572603pjn.0
        for <linux-cxl@vger.kernel.org>; Fri, 10 Dec 2021 11:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UCZUTok6qCgscxcVXcvCADjFgjSrwItBHMXkEgTLIAI=;
        b=4uZMY7WQnQNKTmypkZRSl+cI6gQ6P1N1NfHssYtm40mAGiZBOPyanmbhLEy3DH7Xiw
         daGbaZ8IwUL0ye0z7OFB6HLVhcQEhtCygGfhSKaGOyWd5t9MjW4N3PLoExgk6888FDiS
         GyVETkPp/1GCk7fBH7y4qfKBNNC5ph4/eS9uymPznAMZs4CNX9P3kH0Z5Q31+/wSBHCi
         MPDQRV/4n8Q0oPT82ERRaNB+6Bl0w8F5WJhkcwrw1e8WEf91iDrIp7yZW+SlgnddoA6R
         sXoGPzw9sROlOnXUfkqXFGnXSmfB90PIAOcyHXv59y2RQf3+u8h0Dt+smI7Twd0RRZaK
         F7Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UCZUTok6qCgscxcVXcvCADjFgjSrwItBHMXkEgTLIAI=;
        b=wJKY41JyYAO0Ic8X7SEb4cS5nofIDDKSRE1M6Psz+dP8jkLhnR3177tCwxVkFKjXqZ
         8jQuPVEMvKklovnqZSl+ZznXEah3AS8OM32mUXY3DzC2/X/J99XbpAzEen64DmMG6+4r
         2jwTiXR3tkJ0XLO6YfcyHKZVavMYi1fvSCkhY9vCwMstmNaZa4NogUJ37w22u0NkMoV6
         YjeuZdPno88IXubqgFN7RPGV0K1jLUHDwsCf38M2uWwQXJasoo1t3qThdmKksr9f+j1c
         hJJjSG0T2SU6b9wJxMNLE/f99XLClyhWEvUtQj9FWvpLmPkf/mJZqin4RaYvGkMOlxQM
         BmHQ==
X-Gm-Message-State: AOAM533y52Pn9ak8mnpillGOwNZgJanV89+4NUxefC+r7IRjdU3gvkTz
        CZls+35T5KVWAMw2KvUfx1Yhy9HCJnw7PxADw4drAA==
X-Google-Smtp-Source: ABdhPJzOTtAyjJW2HeZHQQd1wTzH/eB2wiPEFO/qQ5orP4tQ35Gl9UelLwXxpLXrIazNtQq2SFEBXgnJJ58VbXGi9nw=
X-Received: by 2002:a17:902:7fcd:b0:142:8ab3:ec0e with SMTP id
 t13-20020a1709027fcd00b001428ab3ec0emr76930400plb.4.1639165291320; Fri, 10
 Dec 2021 11:41:31 -0800 (PST)
MIME-Version: 1.0
References: <163164780319.2831662.7853294454760344393.stgit@dwillia2-desk3.amr.corp.intel.com>
 <163225205828.3038145.6831131648369404859.stgit@dwillia2-desk3.amr.corp.intel.com>
 <YbOswyDRX1SEtE8C@archlinux-ax161>
In-Reply-To: <YbOswyDRX1SEtE8C@archlinux-ax161>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 10 Dec 2021 11:41:20 -0800
Message-ID: <CAPcyv4j=rTOTKtjsLuWT=5uU8_YD7uLVNKtHrbDZOcBa4D6TCw@mail.gmail.com>
Subject: Re: [PATCH v6 21/21] cxl/core: Split decoder setup into alloc + add
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     linux-cxl@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Dec 10, 2021 at 11:39 AM Nathan Chancellor <nathan@kernel.org> wrot=
e:
>
> Hi Dan,
>
> On Tue, Sep 21, 2021 at 12:22:16PM -0700, Dan Williams wrote:
> > The kbuild robot reports:
> >
> >     drivers/cxl/core/bus.c:516:1: warning: stack frame size (1032) exce=
eds
> >     limit (1024) in function 'devm_cxl_add_decoder'
> >
> > It is also the case the devm_cxl_add_decoder() is unwieldy to use for
> > all the different decoder types. Fix the stack usage by splitting the
> > creation into alloc and add steps. This also allows for context
> > specific construction before adding.
> >
> > With the split the caller is responsible for registering a devm callbac=
k
> > to trigger device_unregister() for the decoder rather than it being
> > implicit in the decoder registration. I.e. the routine that calls alloc
> > is responsible for calling put_device() if the "add" operation fails.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Nathan Chancellor <nathan@kernel.org>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Reviewed-by: Ben Widawsky <ben.widawsky@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> Apologies for not noticing this sooner, given that I was on the thread.
>
> This patch as commit 48667f676189 ("cxl/core: Split decoder setup into
> alloc + add") in mainline does not fully resolve the stack frame
> warning. I still see an error with both GCC 11 and LLVM 12 with
> allmodconfig minus CONFIG_KASAN.
>
> GCC 11:
>
> drivers/cxl/core/bus.c: In function =E2=80=98cxl_decoder_alloc=E2=80=99:
> drivers/cxl/core/bus.c:523:1: error: the frame size of 1032 bytes is larg=
er than 1024 bytes [-Werror=3Dframe-larger-than=3D]
>   523 | }
>       | ^
> cc1: all warnings being treated as errors
>
> LLVM 12:
>
> drivers/cxl/core/bus.c:486:21: error: stack frame size of 1056 bytes in f=
unction 'cxl_decoder_alloc' [-Werror,-Wframe-larger-than=3D]
> struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targe=
ts)
>                     ^
> 1 error generated.
>
> This is due to the cxld_const_init structure, which is allocated on the
> stack, presumably due to the "const" change requested in v5 that was
> applied to v6. Undoing that resolves the warning for me with both
> compilers. I am not sure if you have a better idea for how to resolve
> that.
>
> diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
> index ebd061d03950..46ce58376580 100644
> --- a/drivers/cxl/core/bus.c
> +++ b/drivers/cxl/core/bus.c
> @@ -485,9 +485,7 @@ static int decoder_populate_targets(struct cxl_decode=
r *cxld,
>
>  struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targ=
ets)
>  {
> -       struct cxl_decoder *cxld, cxld_const_init =3D {
> -               .nr_targets =3D nr_targets,
> -       };
> +       struct cxl_decoder *cxld;
>         struct device *dev;
>         int rc =3D 0;
>
> @@ -497,13 +495,13 @@ struct cxl_decoder *cxl_decoder_alloc(struct cxl_po=
rt *port, int nr_targets)
>         cxld =3D kzalloc(struct_size(cxld, target, nr_targets), GFP_KERNE=
L);
>         if (!cxld)
>                 return ERR_PTR(-ENOMEM);
> -       memcpy(cxld, &cxld_const_init, sizeof(cxld_const_init));
>
>         rc =3D ida_alloc(&port->decoder_ida, GFP_KERNEL);
>         if (rc < 0)
>                 goto err;
>
>         cxld->id =3D rc;
> +       cxld->nr_targets =3D nr_targets;
>         dev =3D &cxld->dev;
>         device_initialize(dev);
>         device_set_pm_not_required(dev);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 3af704e9b448..7c2b51746e31 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -191,7 +191,7 @@ struct cxl_decoder {
>         int interleave_granularity;
>         enum cxl_decoder_type target_type;
>         unsigned long flags;
> -       const int nr_targets;
> +       int nr_targets;
>         struct cxl_dport *target[];

That change looks like the right way to go to me. Thanks for the follow-up!
