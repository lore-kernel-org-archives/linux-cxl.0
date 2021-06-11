Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E394C48BD1
	for <linux-cxl@archiver.kernel.org>; Fri, 11 Jun 2021 17:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34BBC613D0
	for <linux-cxl@archiver.kernel.org>; Fri, 11 Jun 2021 17:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbhFKR2o (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 11 Jun 2021 13:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbhFKR2o (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 11 Jun 2021 13:28:44 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F61C061574
        for <linux-cxl@vger.kernel.org>; Fri, 11 Jun 2021 10:26:45 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id o17-20020a17090a9f91b029015cef5b3c50so6225531pjp.4
        for <linux-cxl@vger.kernel.org>; Fri, 11 Jun 2021 10:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rwlRUgxtvQfz0zoSOLcjhlbC6dsn/TbjPK+iylsS/wU=;
        b=IPjazK7B2X51JVkxiCZW2ibF0idPn3X0yKUoPW9OUYMX2MgOrQzuBF8bFw9f57n0qW
         p8spRnXgUi+i2eDISUCzWNb+NlxLUhfhlOASJ+20IJhqCisxvnozSgRHuz05kXMWcqEt
         BB0Vu7EjIkUQMgZVjFVux/Nw9p38VZxaEczxyuj4Bme1ULyk5BfnbTkwcKV2HpzPcOdU
         DQLNXa7y2MBH18MOs9T47zlqR3G6rYffmF46R5YVg/3Ff8bpM5DmeP2IJrueEiKutMkb
         GH5Uu66ZVonAj/VwjeAIWWPs6vkKF6d6ooH9F+WjAfO354WitdKw4PYoAgFFL97vEE9Z
         lc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rwlRUgxtvQfz0zoSOLcjhlbC6dsn/TbjPK+iylsS/wU=;
        b=c2gPZftzcOLIme5R7b00GoleNGNLOIRck4f2V1J1H/9QQcziQdN6m48B9GYVn3WXwI
         G9aB67uB1hlH8shDqBEso3YKJtfcPKj7N8c5Nsn3EkvmPEFXX2KWFAO5urSrPPUIhIcZ
         fv9nC3+wkPDhxQpYKATP/LB/0byjfVK7bZ5acDZZInKfOCkJwNkHRu4r7HcWu7JagHWx
         tKElGGkaqBl+J/m6VtXT8VZpFVelA0NNVgKKcvkedKdY9CbOaHzaX+t/0/c5OeNyC5xi
         7UBAgtX6uIJ1aa+fJMsKG092bd350xEC2wOlnKV31GStvXBGKByRGeIxJuQ6XMKvBj0+
         rDVQ==
X-Gm-Message-State: AOAM532Clu6C3+/9ZyDy7W28s6dbShYh3qYsO1rTalWQtqqCIJvCFTxa
        CqfoZX1CFZmnFI2UXpUk24Crw0x0UjRNDUQnMCgl0w==
X-Google-Smtp-Source: ABdhPJw5PLr+7BR+gjtdXmRB/pOoYVr5vqYzqBz0WVBisBacSCQKpwK1nPqmLE97GFzVHxPOYzK1cuxQO/q3wqQg5xk=
X-Received: by 2002:a17:90a:8589:: with SMTP id m9mr9945631pjn.168.1623432405368;
 Fri, 11 Jun 2021 10:26:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210611002224.1594913-1-ira.weiny@intel.com> <20210611002224.1594913-2-ira.weiny@intel.com>
In-Reply-To: <20210611002224.1594913-2-ira.weiny@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 11 Jun 2021 10:26:34 -0700
Message-ID: <CAPcyv4hpDFZj8zr47SLAx7Qy2UMz4c_E648e-ahGyu5nhzjcow@mail.gmail.com>
Subject: Re: [PATCH 1/3] cxl/pci: Store memory capacity values
To:     "Weiny, Ira" <ira.weiny@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Jun 10, 2021 at 5:22 PM <ira.weiny@intel.com> wrote:
>
> From: Ira Weiny <ira.weiny@intel.com>
>
> The Identify Memory Device command returns information about the
> volatile and persistent memory capacities.  Store those values in the
> cxl_mem structure for later use.  While at it, reuse the calculation of
> the volatile and persistent memory byte values to calculate the ram and
> pmem ranges.
>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  drivers/cxl/mem.h |  4 ++++
>  drivers/cxl/pci.c | 36 +++++++++++++++++++++++++++++++++---
>  2 files changed, 37 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/cxl/mem.h b/drivers/cxl/mem.h
> index 13868ff7cadf..8bd0d0506b97 100644
> --- a/drivers/cxl/mem.h
> +++ b/drivers/cxl/mem.h
> @@ -75,5 +75,9 @@ struct cxl_mem {
>
>         struct range pmem_range;
>         struct range ram_range;
> +       u64 total_cap_bytes;
> +       u64 volatile_cap_bytes;
> +       u64 persistent_cap_bytes;

Hmm, why these fields?

I would expect pmem_range and ram_range can already represent these
values and range_len(pmem_range) + range_len(ram_range) == total
capacity.
