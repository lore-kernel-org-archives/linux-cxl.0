Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B89BC433F5
	for <linux-cxl@archiver.kernel.org>; Fri, 10 Sep 2021 23:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8F1060F5B
	for <linux-cxl@archiver.kernel.org>; Fri, 10 Sep 2021 23:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234809AbhIJXrI (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 10 Sep 2021 19:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbhIJXrH (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 10 Sep 2021 19:47:07 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75023C061574
        for <linux-cxl@vger.kernel.org>; Fri, 10 Sep 2021 16:45:56 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id bb10so2148146plb.2
        for <linux-cxl@vger.kernel.org>; Fri, 10 Sep 2021 16:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2gnVvDGdoT8g3N+NEvKXu5azgc/LLWB72SoQek3WJco=;
        b=RjC9LETXSIRvsi+YHLB3ADlEUmCwbrCDPi/Ac8+Pc1TW6EGPmchDUuewiJunsZuKL7
         haDs4TrTBcYgrH0D+L2nGHBx50ZnuCXlAx/3DoPlo1T7whDSjsoxhOrVBMV6SNPDSHWA
         ZnUvh0KKq19/mwOi+LqOsdRiLyKvEbnmHDiWj4gHT8FARXAcN6ApxMlIQtPBp0R4rNc0
         EcmEzmVjBwUhsul7QAOw/bSDZHxSbEAER6OCUax2ufXPgjJuV9gYNeP59+HQYVauE4TJ
         17vrDQuHcMIP1LLEz/pi98fhjlRCIwDGNE05cZNNWTWeoYQrDmL+n/Y6JNdiKLdfVpeJ
         K5xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2gnVvDGdoT8g3N+NEvKXu5azgc/LLWB72SoQek3WJco=;
        b=0gK+z4bVUXcLj6AbR4OeWlaKPEu394uLLeJS3bVaBdKjuAWgfOwhaiXPUu5fJM9bOm
         +xc6mxkXP2BORH2PmUyjVA6DQyu/lbwUoYnNlc2DvmbZUeXxhvMDhW7vWAMFLyLIDMak
         2dZvpXm22MHUvLAJWLHctjfDE+rW5yII9yBZv+nIJ5JeOweIn/tebGGHo+2HUF46OFG1
         Ffpf0w9FZC7z4Z/eeS2oPtzct58maV9TWPYZhFunPzlQscWUVhG1GW27GtUoyNS1aJi6
         DmSVh2/aZkU/jOVG2mJ/YLgwKaQnfc4Ua7g9PXZTT0b8pSrgmDTAuhjTBWiHkNAX7dOu
         l3Mw==
X-Gm-Message-State: AOAM530zt6YlsACVLbL/BXeYK32nn3SK9gUT8XK8tEOtEqcK44bkWI2I
        pgMgq99yIWFg4yYn8CqEO5hd5xCcvrssJyfO8IQOB9GwHX9lFA==
X-Google-Smtp-Source: ABdhPJxM9zO/hyJmno6G40id/NnQvPd/10D0D1yCIm+++NgkdCaRtoQfBiGD+wBakHh/OEhvsPm6u7nFGjKIAJNmtcI=
X-Received: by 2002:a17:90b:513:: with SMTP id r19mr110702pjz.93.1631317556088;
 Fri, 10 Sep 2021 16:45:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210902195017.2516472-1-ben.widawsky@intel.com>
 <20210902195017.2516472-10-ben.widawsky@intel.com> <CAPcyv4iaSJuo2UUwO+LgXVO5QEBwvr20rLeKuHZ_2QJ-XizC+g@mail.gmail.com>
In-Reply-To: <CAPcyv4iaSJuo2UUwO+LgXVO5QEBwvr20rLeKuHZ_2QJ-XizC+g@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 10 Sep 2021 16:45:45 -0700
Message-ID: <CAPcyv4j2P1a9qdDKBWXnJwrQx7oruAgfaru3_v1RnegfGPrSCQ@mail.gmail.com>
Subject: Re: [PATCH 09/13] cxl/pci: Retain map information in cxl_mem_probe
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

On Fri, Sep 10, 2021 at 4:12 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Thu, Sep 2, 2021 at 12:50 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > In order for a memdev to participate in cxl_core's port APIs, the
> > physical address of the memdev's component registers is needed. This is
> > accomplished by allocating the array of maps in probe so they can be
> > used after the memdev is created.
>
> Is this still needed if you append this map information to the memdev directly?

Disregard. The lack of diff context and my leaky brain made me forget
that devm_cxl_add_memdev() is at the bottom of cxl_pci_probe(). I
would just squash this with the patch that actually needs it.
