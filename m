Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B099C433F5
	for <linux-cxl@archiver.kernel.org>; Wed,  3 Nov 2021 00:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F7F661050
	for <linux-cxl@archiver.kernel.org>; Wed,  3 Nov 2021 00:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbhKCBAR (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 2 Nov 2021 21:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhKCBAQ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 2 Nov 2021 21:00:16 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52182C061714
        for <linux-cxl@vger.kernel.org>; Tue,  2 Nov 2021 17:57:41 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id g11so654483pfv.7
        for <linux-cxl@vger.kernel.org>; Tue, 02 Nov 2021 17:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tx5izF5ieiWqUFhVPPAd5fPBgdOsQUNseMGSg8a7ISo=;
        b=sn3bChFooilv+LsPqraxuV6llHk/lYxpiixCzX4MmloacFCdKLgdUqevI9Oscw61I8
         oq0nQQ8npxcHu08xiRuvahfxiWnTkFke0IusD5YkHJySX/6AqqO2lTOdfamdNanuqzHl
         39NFddmWj+a8yK3YQph3yT70Czo47DCnxghcWEPGC6QIb2U6RYSuScEtsOrcBHna3RZn
         KD3kIB8ntVQl8v1Pu8V/rGed5eK+XRSqB12XJJOuhqEtlkA2Jc/aTLPqkAfkqq9LCyDJ
         l+wuB2D7N3Zaj1uqKeMDFVoCReIH4ee7jtjnW7+9Y63S0Fa8pxBuhxRqWwiNbmOVtj8u
         AXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tx5izF5ieiWqUFhVPPAd5fPBgdOsQUNseMGSg8a7ISo=;
        b=jTIHyLFQMy54rc8TSSHD/R4JLmBLy+noWE1DeFv+siJAI72Wpwf6wjyPY1/cYhHBS5
         79vXzt2VfCiZibf+x7FIh9X52nVbnriqd/rE8tbN/wsV7wzUjk1fepnWnYjlVzJxaqGU
         WhXKpxhBSgJYiykY9dSXtvXqoYV/CjKMMbCV3Cxmd3tSDWTDH2dnkz/S2Myk8UozlkAw
         wEdV+jwFQq2mURF0O34Tri2X9QcpXK2KknCMXy6siLj6n6WtRD9DfgBCbG+uFhv/kufi
         +7619gDW62fhdUR6JY7b5p+fOlXVz3061JiCiHs3iv2Pz7e9u9k+Xoon817UByGzz5w8
         c4Sw==
X-Gm-Message-State: AOAM5308NvwsDizaB9KSV9BIax2Zxw5ismbSQFIqRvbAFLxWFy3/HHYi
        vRLtT3dRN/r8m3ZIfdG53ztt8o0l27Y3Rp3eykkrWA==
X-Google-Smtp-Source: ABdhPJz5R2Su/mHZo9b6SQxOfxThr3KX7+2P9xZl43G1UFW9oDsqafDx3cvV/WhfNzJGrsfoLr4BpE1BQeFCXHA4EZE=
X-Received: by 2002:a63:6bc2:: with SMTP id g185mr30281347pgc.356.1635901060801;
 Tue, 02 Nov 2021 17:57:40 -0700 (PDT)
MIME-Version: 1.0
References: <163553734757.2509761.3305231863616785470.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20211101113026.00001d2a@Huawei.com>
In-Reply-To: <20211101113026.00001d2a@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 2 Nov 2021 17:57:30 -0700
Message-ID: <CAPcyv4hKmQX1C22VXq38coAYSFaCh=FRLo_vOtoZjU4K+e7CGw@mail.gmail.com>
Subject: Re: [PATCH] cxl/pmem: Fix reference counting for delayed work
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, "Weiny, Ira" <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Nov 1, 2021 at 4:30 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Fri, 29 Oct 2021 12:55:47 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > There is a potential race between queue_work() returning and the
> > queued-work running that could result in put_device() running before
> > get_device(). Introduce the cxl_nvdimm_bridge_state_work() helper that
> > takes the reference unconditionally, but drops it if no new work was
> > queued, to keep the references balanced.
> >
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> Good spot, I'm guessing this was an inspection thing rather than a problem
> you've managed to trigger, but either way.

Correct, it was by inspection. I expect it would be extremely
difficult to hit this race in practice.

> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks!
