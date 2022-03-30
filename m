Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3452C433F5
	for <linux-cxl@archiver.kernel.org>; Wed, 30 Mar 2022 00:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbiC3AUL (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 29 Mar 2022 20:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235006AbiC3AUK (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 29 Mar 2022 20:20:10 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6102815FFA
        for <linux-cxl@vger.kernel.org>; Tue, 29 Mar 2022 17:18:26 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id w7so14643842pfu.11
        for <linux-cxl@vger.kernel.org>; Tue, 29 Mar 2022 17:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AdkjD8oNNsoq881wdu5esBq67NhFyRmlRQY2Vu8kj+Q=;
        b=hnTlHwXo2KrPQfT9vs7m6rpjUSsjfYPHLJZSR0mYcPgmz1cn5BMRDoUrVyOFVjm1Sp
         KuaGTfKQxBnFp4QjZvlouA50eXQdYPHaRA5z6QZ0tfBM4dPVBs/aXJRZzYiqWC01lTav
         rnMP43l84w5ZyoDK6oJGvhL9WoXLhfRMwpIztt429s/FziRoPkUY9XOOploIiJHAWzcg
         6CE5QkJ421zwvZKJoyQA30THrajPeOBzBNgjKFEt4Lb5xgVkwBgKI4VVG2ADuggmyldF
         r/NT0BB2WrDbba9C6nw/Ls7yb1uUiHToi6hdaucNn3GVjNQiDXKDB7P6AYTEefaCqsIl
         5r7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AdkjD8oNNsoq881wdu5esBq67NhFyRmlRQY2Vu8kj+Q=;
        b=gZZv6cKn51hs8pWQOYPV3nHTPQre1qSGeipVoOWoutFS5LdlRtGR1H99SAUCm7t2DX
         gcJt7hUeDyloaGvjlKwOMoandL6JEZdFbWHMyUmZRm4MCx+D3C27F5TBD1MY087nSN69
         I5PVlaXPdM+r9uFe0x4PDA+YIew8peCZXiGCGdc+0EI5HgOPBF7D4QizYdC6nnOuWWLj
         CynlaCeubW86zH5EAIQ36BLWxqH5T+N7lylIQ+bQo+trtU1vtwQMfBrD2F8Q+QA++ZYY
         /RexoCZaDJWPujkpK7+Hu9yi8XCHigiSRAcwBnol7lKtXdrD1ZzC3ac0t1+R2WWSQ5KD
         qanA==
X-Gm-Message-State: AOAM531DLjh7sl+7L9sz2rgRyRMXq2i8WfmP3TOAsr4eSZ1b67NOZxUR
        kR8nYLSmcNtdQlAlMCc16cYBjDNtM3uwJlLHwCFsjQ==
X-Google-Smtp-Source: ABdhPJyMvi923V54PvR5ZsvIq0uRvc13L0x+LhoQL7jeDrmju6ae2gWUEOQX3EUc6e+bXkOB0gB8eTeymJZiLr3dMSY=
X-Received: by 2002:a05:6a00:228f:b0:4fa:e4c9:7b3b with SMTP id
 f15-20020a056a00228f00b004fae4c97b3bmr29579913pfe.61.1648599505832; Tue, 29
 Mar 2022 17:18:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220317234049.69323-1-dave@stgolabs.net> <20220317234049.69323-4-dave@stgolabs.net>
In-Reply-To: <20220317234049.69323-4-dave@stgolabs.net>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 29 Mar 2022 17:18:14 -0700
Message-ID: <CAPcyv4jFgN6cpRjK=Uzhu6A1wVBThjsjzE9Eg4hHYEZD=ratgw@mail.gmail.com>
Subject: Re: [PATCH 3/5] cxl/mbox: Improve handling of mbox_cmd return codes
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Mar 17, 2022 at 4:41 PM Davidlohr Bueso <dave@stgolabs.net> wrote:
>
> Upon a completed command the caller is still expected to check
> the actual return_code register for to ensure it succeed. This
> adds, per the spec, the potential command return codes. It maps
> the hardware return code with the kernel's errno style, and by
> default continues to use -ENXIO (Command completed, but device
> reported an error).
>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/cxl/core/mbox.c |  2 +-
>  drivers/cxl/cxlmem.h    | 90 ++++++++++++++++++++++++++++++++++++++++-
>  drivers/cxl/pci.c       |  2 +-
>  3 files changed, 91 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 778b04a0fb0a..d4d4a16820b7 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -171,7 +171,7 @@ int cxl_mbox_send_cmd(struct cxl_dev_state *cxlds, u16 opcode, void *in,
>                 return rc;
>
>         /* TODO: Map return code to proper kernel style errno */
> -       if (mbox_cmd.return_code != CXL_MBOX_SUCCESS)
> +       if (mbox_cmd.return_code != CXL_MBOX_CMD_RC_SUCCESS)
>                 return -ENXIO;
>
>         /*
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 5d33ce24fe09..268597d1ff33 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -85,9 +85,97 @@ struct cxl_mbox_cmd {
>         size_t size_in;
>         size_t size_out;
>         u16 return_code;
> -#define CXL_MBOX_SUCCESS 0
>  };
>
> +/*
> + * Per CXL 2.0 Section 8.2.8.4.5.1
> + */
> +enum {
> +       CXL_MBOX_CMD_RC_SUCCESS = 0,
> +       CXL_MBOX_CMD_RC_BACKGROUND,
> +       CXL_MBOX_CMD_RC_INVINPUT,
> +       CXL_MBOX_CMD_RC_UNSUPPORTED,
> +       CXL_MBOX_CMD_RC_INTERNAL,
> +       CXL_MBOX_CMD_RC_RETRY,
> +       CXL_MBOX_CMD_RC_BUSY,
> +       CXL_MBOX_CMD_RC_MEDIADISABLED,
> +       CXL_MBOX_CMD_RC_FWINPROGRESS,
> +       CXL_MBOX_CMD_RC_FWOOO,
> +       CXL_MBOX_CMD_RC_FWAUTH,
> +       CXL_MBOX_CMD_RC_INVSLOT,
> +       CXL_MBOX_CMD_RC_FWROLLBACK,
> +       CXL_MBOX_CMD_RC_FWRESET,
> +       CXL_MBOX_CMD_RC_INVHANDLE,
> +       CXL_MBOX_CMD_RC_INVPA,
> +       CXL_MBOX_CMD_RC_INJPOISON,
> +       CXL_MBOX_CMD_RC_MEDIAFAILURE,
> +       CXL_MBOX_CMD_RC_ABORT,
> +       CXL_MBOX_CMD_RC_INVSECURITY,
> +       CXL_MBOX_CMD_RC_PASSPHRASE,
> +       CXL_MBOX_CMD_RC_MBOXUNSUPPORTED,
> +       CXL_MBOX_CMD_RC_INVPAYLOAD,
> +};
> +
> +#define CXL_CMD_RC(_value, errno, str)         \
> +       [CXL_MBOX_CMD_RC_##_value] = {          \
> +               .err = errno,                   \
> +               .desc = str,                    \
> +       }
> +
> +/*
> + * mbox cmd hardware return_code handling
> + */
> +struct cxl_mbox_cmd_rc {
> +       int err; /* proper kernel style errno */
> +       const char *desc;
> +};
> +
> +static const struct cxl_mbox_cmd_rc cxl_mbox_cmd_rctable[] = {
> +       CXL_CMD_RC(SUCCESS, 0, NULL),
> +       CXL_CMD_RC(BACKGROUND, ENXIO, "background cmd started successfully"),
> +       /* errors here on out */
> +       CXL_CMD_RC(INVINPUT, ENXIO, "cmd input was invalid"),
> +       CXL_CMD_RC(UNSUPPORTED, ENXIO, "cmd is not supported"),
> +       CXL_CMD_RC(INTERNAL, ENXIO, "internal device error"),
> +       CXL_CMD_RC(RETRY, ENXIO, "temporary error, retry once"),
> +       CXL_CMD_RC(BUSY, ENXIO, "ongoing background operation"),
> +       CXL_CMD_RC(MEDIADISABLED, ENXIO, "media access is disabled"),
> +       CXL_CMD_RC(FWINPROGRESS, ENXIO,
> +                       "only one FW package can be transferred at a time"),
> +       CXL_CMD_RC(FWOOO, ENXIO,
> +                       "FW package content was transferred out of order"),
> +       CXL_CMD_RC(FWAUTH, ENXIO, "FW package authentication failed"),
> +       CXL_CMD_RC(INVSLOT, ENXIO,
> +                       "FW slot specified is not supported for requested op"),
> +       CXL_CMD_RC(FWROLLBACK, ENXIO,
> +                       "rolled back to the previous active FW"),
> +       CXL_CMD_RC(FWRESET, ENXIO, "FW failed to activate, needs cold reset"),
> +       CXL_CMD_RC(INVHANDLE, ENXIO,
> +                       "one or more Event Record Handles were invalid"),
> +       CXL_CMD_RC(INVPA, ENXIO, "physical address specified is invalid"),
> +       CXL_CMD_RC(INJPOISON, ENXIO,
> +                       "allowed poison injection has been reached"),
> +       CXL_CMD_RC(MEDIAFAILURE, ENXIO, "permanent issue with the media"),
> +       CXL_CMD_RC(ABORT, ENXIO, "background cmd was aborted by device"),
> +       CXL_CMD_RC(INVSECURITY, ENXIO,
> +                  "not valid in the current security state"),
> +       CXL_CMD_RC(PASSPHRASE, ENXIO,
> +                       "passphrase doesn't match current passphrase"),
> +       CXL_CMD_RC(MBOXUNSUPPORTED, ENXIO,
> +                       "not supported on the mailbox it was issued on"),
> +       CXL_CMD_RC(INVPAYLOAD, ENXIO, "invalid payload length"),
> +};

You can define the table and the enums together with Steven's trick [1]

#define CMD_CMD_RC_TABLE                                                    \
        C(SUCCESS,      0,      NULL),                                   \
        C(BACKGROUND,   -ENXIO, "background cmd started successfully"),  \
                ...
        C(PAYLOADLEN,   -ENXIO, "invalid payload length")
#undef C
#define C(a, b, c) CXL_CMD_RC_##a
enum  { CMD_CMD_RC_TABLE };
#undef C
#define C(a, b, c) { b, c }
static struct {
        int err;
        const char *desc;
} cxl_mbox_cmd_rctable[] = { OPS };
#undef C

Ideally you could align the columns so it's easy to read which
hardware code relates to which errno.

[1]: See "cpp tricks and treats": https://lwn.net/Articles/383362/
