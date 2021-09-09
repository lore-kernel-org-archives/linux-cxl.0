Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC2AC433F5
	for <linux-cxl@archiver.kernel.org>; Thu,  9 Sep 2021 18:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA6F06113A
	for <linux-cxl@archiver.kernel.org>; Thu,  9 Sep 2021 18:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235674AbhIISjb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 9 Sep 2021 14:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233698AbhIISja (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 9 Sep 2021 14:39:30 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3086CC061574
        for <linux-cxl@vger.kernel.org>; Thu,  9 Sep 2021 11:38:21 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id n18so2680575pgm.12
        for <linux-cxl@vger.kernel.org>; Thu, 09 Sep 2021 11:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=943STyQuyGAFkNgg01KO1B1DOWI2nJ+DvbHRe4VQe08=;
        b=SE1IaZXRM0if+XOxEyUHiAgzlj7edQcax03xjz/nobuVIAC6iBVsnndPz6VW1zc1bx
         8U/YDlhIEyZ+jLI7dh+7hT5DHIiJCUAtJwFDnQ/MbMRG06AB6u5wYkKWcbXwcZHRf1N0
         jIYoSrLQS/oCN7zSZ1VMeUIXpmQ5F1XXNFYUXYHZmA3uU41aHtufb6eimdhTtLTHJiCb
         ggd+SyvwldXbBojXmBgOUBrhjA5z5FtgReveeEqIiM//zGAiMxaxd2Kvbm6T+kiqxjgq
         6nJkUsCxmzdt7sxbLTmacaE4v7XfPEN0ncqc2h+72LMY1Egst8gpPYpzAmJPRiQOAvOy
         lJcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=943STyQuyGAFkNgg01KO1B1DOWI2nJ+DvbHRe4VQe08=;
        b=RQcU/u/GKZzuhRjP3G/HxQt0n/a0Z9oQ/QftZpEAoyJL4MgHVQEzQAz4AtZ6XMm8HH
         LRtX7oOornMI040oFgJ3JPJAwIezIOsr8++LSf/AnynR0ssre2MB+7d5kqDDfh0didj0
         3fCR/cXlqshBSNOfM3WlQ4nJvHVEjXRAbEECuy8jeze3Dzb0u5Z/Y/dpfB8xbWYX7bQ5
         fb1TNrF3MRs70lGKe0ngAoT+Y+pXMuLK2YU2kwmNxkNlrRUitMiiC8oUS2lK7JB5W7r8
         wGlOZNWJ02Zf3SwvAAwWSwXpPFaiuqwYyWv36P/jxaHy9y9op3NdYMjaa8jDfmhDxOoO
         PCaQ==
X-Gm-Message-State: AOAM530qWFdNrm4VoeH84fqZzO085jrWc3TstLq+HJ9it5+e04dxLoxJ
        wQuiYXKJ73QvZZ0F09BNnZvDowgEtHjvJ84EZbuH1g==
X-Google-Smtp-Source: ABdhPJzaO1bUJk+gLrDMJZ/3Nc2cF+/Ng3dxm4BqVAu72P0SuULafmwFIpT1iuFPjfh0DyxQNu4j0+Ux4oCJR+sqRdg=
X-Received: by 2002:a62:6d07:0:b0:40a:33cd:d3ea with SMTP id
 i7-20020a626d07000000b0040a33cdd3eamr4089769pfc.61.1631212700703; Thu, 09 Sep
 2021 11:38:20 -0700 (PDT)
MIME-Version: 1.0
References: <163116429183.2460985.5040982981112374615.stgit@dwillia2-desk3.amr.corp.intel.com>
 <163116431893.2460985.4003511000574373922.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210909155829.vjqznxbql2fgna3q@intel.com>
In-Reply-To: <20210909155829.vjqznxbql2fgna3q@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 9 Sep 2021 11:38:09 -0700
Message-ID: <CAPcyv4hNMBH4v2Kp2q4w0WdCcZSV54mUuJg9wCVk7kkEey_CEA@mail.gmail.com>
Subject: Re: [PATCH v4 05/21] libnvdimm/label: Define CXL region labels
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Sep 9, 2021 at 8:58 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 21-09-08 22:11:58, Dan Williams wrote:
> > Add a definition of the CXL 2.0 region label format. Note this is done
> > as a separate patch to make the next patch that adds namespace label
> > support easier to read.
> >
> > Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/nvdimm/label.h |   32 ++++++++++++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
>
> Wondering how awkward it's going to be to use this in the cxl region driver. Is
> the intent to push all device based reads/writes to labels happen in
> drivers/nvdimm?

I am looking at it from the perspective that namespace provisioning
and assembly will need to consult region details. So drivers/nvdimm/
needs to have region-label awareness regardless.

Now, when the CXL side wants to provision a region, it will also need
to coordinate label area access with any namespace provisioning
operations that might be happening on other regions that the CXL
device is contributing.

Both of those lead me to believe that CXL should just request the
nvdimm sub-system to update labels to keep all the competing label
operations and cached label data in-sync.
