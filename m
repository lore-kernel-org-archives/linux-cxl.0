Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBC2C433EF
	for <linux-cxl@archiver.kernel.org>; Thu,  9 Sep 2021 15:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEEA8610C9
	for <linux-cxl@archiver.kernel.org>; Thu,  9 Sep 2021 15:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbhIIPST (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 9 Sep 2021 11:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbhIIPSS (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 9 Sep 2021 11:18:18 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8B4C061574
        for <linux-cxl@vger.kernel.org>; Thu,  9 Sep 2021 08:17:09 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id rj12-20020a17090b3e8c00b001991428ded8so1294918pjb.1
        for <linux-cxl@vger.kernel.org>; Thu, 09 Sep 2021 08:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AzpI9xRwH63S4sY7PZzWuRKdR4DgsYKYQ1tUCrYHpxo=;
        b=dJ10V6/NsRo1W9cdQBMQ3kp9HeqUBGBiGonqDUGUrQA+L/9hCpOXCtlJ0JXYs2sB8w
         Yx4b1wAxryGQ6OH96UxXMo6WhIWD2ZQ57Wlzqpzgv8Czoe6Z3nB0xVnBP0/yZUGO5//k
         pAkusPFChxSxD2HMYcwbDANynJHFOkupRKJPfyuOUes4LzWfOXG0QYSWKAjZhHZOhDAe
         XSVaQbZpuStkHpq7VfzNWJSGfYLR1jvvYMXyGO/5Q1H4yLUWnKwlAjqhvQ4kUd7MUPNt
         U0ILtq36aeKM/fxEJyDEqHK0n86gJzQrp4+1rPKTjH3TeJ0ZGCUQQizchR4kneFZgDA4
         9VZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AzpI9xRwH63S4sY7PZzWuRKdR4DgsYKYQ1tUCrYHpxo=;
        b=xAPvloPKgpNbrM9lJBpASUcDCPNTEF9ICybTLCAZXe2g0a/TKWonTZXZlB9X2CcOs6
         ytCfDG5pJZb/0XEFj4pCwC4NC5GOEkiW2VDG6mqggBGEZ8qRKtuCK49g0+g7Zd7yka71
         FxF+XBHmTbiob1AWqRUyrOeKE6l91EzUx6/gX7s2c9qvSI5N/kFjy1u8Oteedb+Jy5Xy
         SkxQYAokfvDFG+b99U85JAzHDWiwZ7IlX8W2Otu/P6HoIQIqAI3ytr+y28dO537oDHmE
         5U8OqGk33HaSKYw8cYGiVybeELtqcCTCd+XyVa97pEai5MxWQdbEQ/BmoucxJybBqnW/
         5JeA==
X-Gm-Message-State: AOAM530jF4LCZxMcin9m4Kkl/loeo9nAy+djzMo2hyfgbnXYabyVVLY2
        lS+fIAx3qPgjcBhRyn91QnO/GE5jxALYTmF6KY38uw==
X-Google-Smtp-Source: ABdhPJwb3JKlDwjVI/1z+amoXzg0p9IxzGtjt02Ri3upXE1tVsq1lvKgxOb9/WOQY4kaqGujr7fVvf4WeKYHQOZCudc=
X-Received: by 2002:a17:90a:d686:: with SMTP id x6mr4219398pju.8.1631200628814;
 Thu, 09 Sep 2021 08:17:08 -0700 (PDT)
MIME-Version: 1.0
References: <163116429183.2460985.5040982981112374615.stgit@dwillia2-desk3.amr.corp.intel.com>
 <163116430804.2460985.5482188351381597529.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210909140942.000025e5@Huawei.com>
In-Reply-To: <20210909140942.000025e5@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 9 Sep 2021 08:16:58 -0700
Message-ID: <CAPcyv4hvMzk3uaV6wRCoqpbHXRmx4HvDyvc0OovLUbAJc7bXkw@mail.gmail.com>
Subject: Re: [PATCH v4 03/21] libnvdimm/labels: Introduce the concept of
 multi-range namespace labels
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Ben Widawsky <ben.widawsky@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Sep 9, 2021 at 6:10 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Wed, 8 Sep 2021 22:11:48 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > The CXL specification defines a mechanism for namespaces to be comprised
> > of multiple dis-contiguous ranges. Introduce that concept to the legacy
> > NVDIMM namespace implementation with a new nsl_set_nrange() helper, that
> > sets the number of ranges to 1. Once the NVDIMM subsystem supports CXL
> > labels and updates its namespace capacity provisioning for
> > dis-contiguous support nsl_set_nrange() can be updated, but in the
> > meantime CXL label validation requires nrange be non-zero.
> >
> > Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> (gave tag on v3 and this looks to be the same).

Whoops, sorry about that, now recorded.
