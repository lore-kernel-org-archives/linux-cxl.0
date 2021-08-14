Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2D8C4338F
	for <linux-cxl@archiver.kernel.org>; Sat, 14 Aug 2021 01:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCA0C610FE
	for <linux-cxl@archiver.kernel.org>; Sat, 14 Aug 2021 01:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236187AbhHNBLi (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 13 Aug 2021 21:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235870AbhHNBLi (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 13 Aug 2021 21:11:38 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C14EC061756
        for <linux-cxl@vger.kernel.org>; Fri, 13 Aug 2021 18:11:11 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id e19so14193206pla.10
        for <linux-cxl@vger.kernel.org>; Fri, 13 Aug 2021 18:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qnL7T8NMvGG9G3AlH5g9sF9LPriWI0ND5e8BllwSdbk=;
        b=nrxF3Ui5D04wXCf+vtGZaHKqCngvPLBCaOanX69s3uQlspIXsglaBOx1FUjyEcgDv6
         Ak/vub5MSwLo+39QnZBXzq20Trh01viFz/9sgzdeECfX30Gek3PM6ohX7scG1p/UZ4Hx
         Z0s5ZeE3wHis2ih64JNNpIHmHUWcx1vev6PlCAXgW0twU9BrEqF5JczXeHLFFxwOOhiM
         suo9XyHsQzpQ77NxwlheHQOJ3rhUBkyuCdM0LjryT42S4lN+Kcnl7GmsIMw6xnnQWlyz
         0ETGMhVvQ9c8tTJRABvzBOULwNgSo4ydWkr+1NXP6qb1ukVpf3OhAuWIrHVgMTm+AHoB
         C6BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qnL7T8NMvGG9G3AlH5g9sF9LPriWI0ND5e8BllwSdbk=;
        b=lIUwblPG0d1FYs4enmsXCSSA2xy9vqWDtH6nJ0wt9gcGzu7gtQGxMpAwoiD+5yeUZW
         IjxBoV90UNWOp+qAHh3kocwOUNniu0ItsDmsN6KBPyoqr7/LOkBIVcgKZur+Z7JgzoxQ
         FTKrmH1mckrvHYdXMfCUZSyRg8BZrgjKrTsVMx1xyojkWSi1l51tc/tTM4Q56dQB4X+f
         JuE/Dj+Cfe5Q8v5T7UHaGuQLlu3ODwa9V3QD0TE/ro7Nu/Ab4PNxsvDO6oovOsfLE4Qw
         wOdA3cpVAINbFpuXa3TOg92J4QnQ+IZGdtv9BtwiO9ghhiiPOCNk6L7dItx6SHkfCvj9
         Wndw==
X-Gm-Message-State: AOAM533aUFzgslzmT/uUdwpM1Nv1nmY+ZE95v9rKTmLl8juWjsHTflU/
        1otofBrHNi12tOm+giVm/mp0Cqn0aDq7XFekvhvfzxDR85VT2w==
X-Google-Smtp-Source: ABdhPJy0ikwgCGDKVWUTmrI2YFIpfNqQ9LxOIAtGo22My6IvqpF7YsJ/fqzXWx2sBj1ajOEXiDUuhp4nbeutmurR8RI=
X-Received: by 2002:a17:902:c10a:b0:12d:97e1:f035 with SMTP id
 10-20020a170902c10a00b0012d97e1f035mr3511055pli.52.1628903470611; Fri, 13 Aug
 2021 18:11:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210702040009.68794-1-ben.widawsky@intel.com>
In-Reply-To: <20210702040009.68794-1-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 13 Aug 2021 18:10:59 -0700
Message-ID: <CAPcyv4hcZVKmvpGMwF+QH8aLCWd16Rh5a4BU74=YdmNoC1716A@mail.gmail.com>
Subject: Re: [PATCH] cxl: Enable an endpoint decoder type
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Jul 1, 2021 at 9:00 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> CXL memory devices support HDM decoders. Currently, when a decoder is
> instantiated there is no knowledge of the type of decoder; only the
> underlying endpoint type is specified. In order to have the memory
> devices reuse the existing decoder creation infrastructure it is
> convenient to pass along the type of decoder on creation.
>
> The primary difference for an endpoint decoder is that it doesn't have
> dports, nor targets. The target is just the underlying media (with
> offset).
>

It's been a while, can you redo this patch just focusing on how to
represent an endpoint without redoing the typing for existing
decoders? It's not clear that cxl_decoder_type needs any updates. An
endpoint decoder is either accelerator or expander (2 or 3). What
makes an endpoint is merely that it is terminal in the sysfs decode
topology. Just like the difference between root decoders and switch
decoders is that root ones are origins of a decode hierarchy. You
identify root decoders by the parent port type and endpoints by the
lack of a target_map.

Yes, target_map is a recent addition, but it seems to naturally fit
the endpoint decoder definition since the target list is replaced with
DPA Skip Low on endpoints.

In short I don't think any new type information is needed, it can all
be inferred inside devm_cxl_add_decoder().
