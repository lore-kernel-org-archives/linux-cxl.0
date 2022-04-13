Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72C4C433F5
	for <linux-cxl@archiver.kernel.org>; Wed, 13 Apr 2022 22:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235219AbiDMWId (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 13 Apr 2022 18:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbiDMWIc (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 13 Apr 2022 18:08:32 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC0E10FDF
        for <linux-cxl@vger.kernel.org>; Wed, 13 Apr 2022 15:06:09 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id y6so3119523plg.2
        for <linux-cxl@vger.kernel.org>; Wed, 13 Apr 2022 15:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+TkOV5v3hXeRRZE7H5Vq1vLrZTdrHF1lFjpXd5xGlls=;
        b=q6sK4N3fFAyBdutlj3pA0WimzP1uGFTAe5+cE/dtB9yEAOFJIyKZsB84DqxChLidKx
         NU/g4XTKeQyD1+NLhsWf4RjmS2Fc1e0IJxDFaMN1dwYTZm+wByCBelYAyI1hISqJE/pY
         LYZ60ezMfuPQDGcV5PwaYU0RF9MTdkNiLzp0vMq33AAqgaT83wWiyVpFU0uTtOFjlNm0
         KLUinkvgkYLebCQXnIHpVm8jqXLkscZKeTq2fWyu5Bwd88Si7Lkim091Tik+Cq9bIZ0E
         x+2qoKZbDouq5Tkz+/6THbFbhmvGk1OUcm2EqH8Aw92H7EQPHtZ4kRYCBeNXvKpmxZyP
         lYkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+TkOV5v3hXeRRZE7H5Vq1vLrZTdrHF1lFjpXd5xGlls=;
        b=Gz6xNm4RPvy/vrHzK448eckepnNU9WfAZia5MC6JqU4LXIirOsvYWCXGlgdUTQdHFI
         U9eotpmuEzvQ7Geu+P/Gh6mcfNBjgwGZ4FghYf0B7W7jhTR2noumEzQUoUMVMOsarx8X
         gTMdgzRR7KYo2oVyHQEzVQ8Tqi06muc9kSpOkbsidhVTlmXf+eWhCU/LHFBFBmMRraAv
         VmQzYUkgS2Iiu6jowMdfuUwt3n4913kYqsTK38p6Fj2Nih3PVMY8aRgjjDchNnqiK/Jv
         UkfamLj4rKGXw5UO1U3ER+H0AxiL/7GOaAx54KZ/m3oMCdZuDwDVzdoFn8J1MFfMly+a
         VieQ==
X-Gm-Message-State: AOAM532TZGX8OJ13atBZWeIXLiqQn8lSpSQS13P71vXQJGRpS5+KZMQE
        6wCcZY698CXPNR+GSgvmaNjVqGwiDH3YuItfI8wFpg==
X-Google-Smtp-Source: ABdhPJzQWdsUZCwUxrbytfbWfiMVW0aRlZe6t/+QfsydcXfayxcE9qafFVe9BtUEBFbnbNU/t1NH5fSWq09IxrTa06I=
X-Received: by 2002:a17:90a:430d:b0:1bc:f340:8096 with SMTP id
 q13-20020a17090a430d00b001bcf3408096mr266248pjg.93.1649887569436; Wed, 13 Apr
 2022 15:06:09 -0700 (PDT)
MIME-Version: 1.0
References: <164982968798.684294.15817853329823976469.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164982970436.684294.12004091884213856239.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20220413093949.GW2731@worktop.programming.kicks-ass.net>
In-Reply-To: <20220413093949.GW2731@worktop.programming.kicks-ass.net>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 13 Apr 2022 15:05:58 -0700
Message-ID: <CAPcyv4g-88D=ysgY5aXS9-jDM+KzPqpUoKi8VxBQeK4WKtcRHw@mail.gmail.com>
Subject: Re: [PATCH v2 03/12] cxl/core: Refactor a cxl_lock_class() out of cxl_nested_lock()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Apr 13, 2022 at 2:40 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
>
> *Completely* untested (I wouldn't know where to begin and probably odn't
> have the hardware anyway), and known incomplete.
>
> What's wrong with something like this then?
>

I'll give it a shot, I think it solves all the cringeworthy aspects of
what I proposed.
