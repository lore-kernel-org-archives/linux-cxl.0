Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092A0C433EF
	for <linux-cxl@archiver.kernel.org>; Thu, 27 Jan 2022 23:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237266AbiA0XBN (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 27 Jan 2022 18:01:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiA0XBN (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 27 Jan 2022 18:01:13 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C165C061714
        for <linux-cxl@vger.kernel.org>; Thu, 27 Jan 2022 15:01:13 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id k17so4264405plk.0
        for <linux-cxl@vger.kernel.org>; Thu, 27 Jan 2022 15:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hXS3kWqyVFXOys+FKNxIiCQdEE0HfarQAzqiYcmbDIM=;
        b=yyFI8kfPrIE8QZh1D+XrxSb/AzUutpNij6UClU9RspM/THAOrI/Q79Kz5H/++pqSGQ
         p3/UQsp75GN8qRnBRRPsqproOsJ5Ypb+pdKxJNsE+FCtxT2GHhFQ/uWR/k2lmISghLA3
         AUfD8+fs4+zZpMPsHR6DICJ9um3vPl2fa2H+y6XD/yrGy5Uxuisqv0AszygXjSpknf1x
         aRLHylcc/ff/b8RfiXlLxgnKQP5za5j7t5xOHNSPID4OwIlL6ckL/DRc0O7FSQYn8SRs
         XXSN+JBpeeVw8ii4ylUFwxWI+PbALawEvBqcn1LVL/JT4j1NAW41nSMhHdwXWqTVQuLK
         1Snw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hXS3kWqyVFXOys+FKNxIiCQdEE0HfarQAzqiYcmbDIM=;
        b=dGoQjnAuCCRTUeCJUoEXL52TWVizNLDAiH5ItRFriBINOZZ0+9Okk7iLiz1txKSa/2
         FIMfzBJWZQIH+WQdYfeJy4DXnXo6RlzI37PNfzOcVY/yYX8onNQnvcVN/hJezpoxURvf
         GZRt23RFFnL+vL6uSWy3mo8tyBWygtIoXpZ06Q06P6pkEExvwSU7TJOlQ4tKQb23CuRt
         5NEYxAgabQib9+Vsotla3avanNEAFtgQ7S3iIT+ts6Nyhh5qnRMhn9Bnk+JYJJmi4Nby
         C9ZZ0o2F9cmeBVt4l9fSQ/byvIaVCXlxVD+omfG5EuaVjXVL+K+WDnzdc1kDZoBFrKuL
         9iWA==
X-Gm-Message-State: AOAM533BppfeyW3sBBTa1EFUMHPEF99i9fH9/Zmm/j7k5erv+kEPsCPU
        +27wjZJNhbeDoVDpFEgIfrXV1PyMabsd85a1xbaWIx4mgOlf4A==
X-Google-Smtp-Source: ABdhPJxkA6ZpsdcxMUZGGn6tauLrw+wsUswB/xUSNiHcDA+JZa82+fRPX52aGZP+YafqN5Nf//jSXay7sVhkEIOOny0=
X-Received: by 2002:a17:902:b20a:: with SMTP id t10mr5323881plr.132.1643324472580;
 Thu, 27 Jan 2022 15:01:12 -0800 (PST)
MIME-Version: 1.0
References: <20220127212911.127741-1-ben.widawsky@intel.com> <20220127212911.127741-4-ben.widawsky@intel.com>
In-Reply-To: <20220127212911.127741-4-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 27 Jan 2022 15:01:01 -0800
Message-ID: <CAPcyv4iMhVcymQupnC32nKAFY8yrZpc3c2HxzxSuT_8KjfPYfg@mail.gmail.com>
Subject: Re: [PATCH 3/4] cxl/core: Extract IW/IG decoding
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, patches@lists.linux.dev,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Jan 27, 2022 at 1:29 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> Interleave granularity and ways have specification defined encodings.
> Extracting this functionality into the common header file allows other
> consumers to make use of it.
>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
>
> ---
>
> I'm in favor of making these helps part of UABI. Having userspace and
> kernel disagree (because of differing spec versions for example) would
> be difficult to manage.
>
> Thoughts?

I have no strong objections to adding these to the UABI, but it does
not stop disagreements about the translation if the definition ever
changes. For example, the cxl-cli user tooling is snapshotting a local
copy of include/uapi/linux/cxl_mem.h, not including it directly from
the current system header location. Even then it's relying on sysfs +
raw values to interact with IW and IG, not the encoded ones.

I guess this does help tools like lspci that may want to decode HDM
decoder registers, but there's not a strong pull for that
functionality either as evidenced by the response to:

https://github.com/pciutils/pciutils/pull/59

So, keeping this in drivers/cxl/cxl.h instead of
include/uapi/linux/cxl_mem.h is fine for now.
