Return-Path: <SRS0=BidS=EF=vger.kernel.org=linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65930C388F9
	for <linux-cxl@archiver.kernel.org>; Fri, 30 Oct 2020 23:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 011F4221EB
	for <linux-cxl@archiver.kernel.org>; Fri, 30 Oct 2020 23:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="j7YlVXzI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbgJ3XiZ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 30 Oct 2020 19:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgJ3XiZ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 30 Oct 2020 19:38:25 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1815C0613D5
        for <linux-cxl@vger.kernel.org>; Fri, 30 Oct 2020 16:38:24 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id k3so10824310ejj.10
        for <linux-cxl@vger.kernel.org>; Fri, 30 Oct 2020 16:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oaa2w71+rAnegpLmEA2VDedlv8/1hcf/ls0nVw+ay8M=;
        b=j7YlVXzIXvjGz1W6wEFr2IvRljmaLyvNl6Sitp/ndZBcdpRSezt+q9fRmxZn4pLzXE
         8eNWbtmKtKsGsAUsmqxtrEJlTHd/uU2OJpboirYrbrnJyLvtkL1Anj34NYeLjzwWz7tB
         6gWESVcqOBo75SYm9ApScZXlMZCvXsGgPNsvRpOrXYORV17Hxx89Yb/tPeU3AdG6kkLD
         8B3JuEHKxIL9CMAtWGbtBz/i0mmMyROApTdPYpZUD4S/j9joh9xZK+NVxnCpwTdht9PK
         g6flXD2dkWzOUEnLOFMTFCktAIpA5VWmEYswM+mXJNHhzUCL043PXLSUjuPKoh6l9XOK
         IMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oaa2w71+rAnegpLmEA2VDedlv8/1hcf/ls0nVw+ay8M=;
        b=SgRxK7pskm2gekca+yBDSHvcZ8Vdm0Ja9zkpyV9P3BvSmL5ouGRkNfhLZaDtYegttw
         rCo37yhcw9MxfAAH4N7Id5KPGf3dCnkZ10B20Zn268b1dCOMuhHyIN8qBoi/C1JfRqF+
         3h/3bBGEg3FTOTaUzbOigwvaAc0XDOlRfjZZ9Gp9hPTKgZodruaNACqSMDgpjxZ96Jr7
         2s+QdPvpOjbrIDpG6bMROeqfdMPuRDYLJDo8F9gWKb97VJe+zyD/9lavvS7GFXuYUm0v
         uwYjRWAG8rSBrT702dz9UCtxUtctglM3nUqE1M+Sk6C0YC46uPlUT5noWVgeJfE2mX3L
         YC3Q==
X-Gm-Message-State: AOAM530knRvkPItQBkDZ0TH6g4zVIrYeBYBYz+1FWKluyjCa3anScbta
        qSdYbS5csCGEuN+6civ9G1IReK+cjRiGqmREZzuAig==
X-Google-Smtp-Source: ABdhPJwtCc03Ww3ywaAqzoU92hBs1onakLTktmy+A5i4c4DmLDlGm2KKz1byL4yamBvY1Ggn2mnktBVK6SECvhrWldU=
X-Received: by 2002:a17:906:241b:: with SMTP id z27mr4382398eja.418.1604101101947;
 Fri, 30 Oct 2020 16:38:21 -0700 (PDT)
MIME-Version: 1.0
References: <BL0PR12MB25321C8689BAFDF8678E5C69BD170@BL0PR12MB2532.namprd12.prod.outlook.com>
 <CAPcyv4jWFf0=VoA2EiXPaQphA-5z9JFO8h0Agy0dO0w6nDyorw@mail.gmail.com> <20201030205956.GO27442@casper.infradead.org>
In-Reply-To: <20201030205956.GO27442@casper.infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 30 Oct 2020 16:38:06 -0700
Message-ID: <CAPcyv4iNeTGrLLN6XLOc+c9CRUODfw9bi0GpjpJuYywniP6dXg@mail.gmail.com>
Subject: Re: Onlining CXL Type2 device coherent memory
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Vikram Sethi <vsethi@nvidia.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "Natu, Mahesh" <mahesh.natu@intel.com>,
        "Rudoff, Andy" <andy.rudoff@intel.com>,
        Jeff Smith <JSMITH@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Oct 30, 2020 at 2:00 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Oct 30, 2020 at 01:37:18PM -0700, Dan Williams wrote:
> > On Wed, Oct 28, 2020 at 4:06 PM Vikram Sethi <vsethi@nvidia.com> wrote:
[..]
>
> i don't know what you're talking about but you must both work for
> hardware manufacturers!

If only there was some software project that could comprehend these
details and synthesize an interface for applications to use. Even
better if this project had mailing lists with experts that could parse
the acronym soup into code patches.
