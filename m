Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B04C48BE6
	for <linux-cxl@archiver.kernel.org>; Sat, 12 Jun 2021 00:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E19961374
	for <linux-cxl@archiver.kernel.org>; Sat, 12 Jun 2021 00:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbhFLBB0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 11 Jun 2021 21:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbhFLBB0 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 11 Jun 2021 21:01:26 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E6FC061574
        for <linux-cxl@vger.kernel.org>; Fri, 11 Jun 2021 17:59:26 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 22-20020a17090a0c16b0290164a5354ad0so6795952pjs.2
        for <linux-cxl@vger.kernel.org>; Fri, 11 Jun 2021 17:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=alKWtRf3ItBX1cFlUtmADgfZ9EVycRgYerLOrkJRXx0=;
        b=Htuos/iB//vMWzgZYbDBBCRU0c4kW6QOoC2RL4Yla2GuQInvtS47oVxFOJuef0Gjuz
         fu+IY3smWb5wOkrcZoT0taRnEQLokCHYgjQo+7j0PH0WZ2mNFACHTVe9d5F3d+327zJH
         Ir74uPmJTVGmf6p+FaFEGAr04l30TLizurAY3paQK4TMU+RhG8yB8buWrCODz/37Ltve
         g73tE7IOb3YJVjvqN9fsPu8UhKgI2ySnTKlflU/GoO581v8QNbU6qw1PVC3xGeRavP49
         UrqyYmpaJw/a/PGF9+9OkQYh5cqsJjavwXKB3qn1KtqY4MeG0S/08kGd1fYV/KwPY3SR
         k1nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=alKWtRf3ItBX1cFlUtmADgfZ9EVycRgYerLOrkJRXx0=;
        b=ecdiNIhQ3UDMbcg9hZG654NgLqF55k+KQtoDGHfFUGj2XqAGe6zrLAN78ZHlzuYPlR
         nxOGEAVvVegMJUOhzRDTVrIXyh8dWyUAK8m8EHkO4/vxY752O7YaYgkgMHpzNGHtmST3
         QWf6JMbjQ9LhAuwHFRhdEI1tgRudBb9WfCZ/aL/XQUJobi5TULHid5cSLtNLWtfpJC+t
         bznqVj05EPdSKnq35MJHrx1gkcq+WF2Ik3Sg0EorfpZOnczcFFchavoGjogD95sXGncA
         P5VVYFaXHFgwYqEQCRmJgQjPej8I/fE8mMQmAYHVQ1gMP9ymZJ7DTZi2FdQSL1JrlTR4
         ffTw==
X-Gm-Message-State: AOAM530/+oMC1zw4xJXuQOrkMstnahHYM52LGbmzNmuOjOODeBscq/RU
        ex253KIpZb7IfUXYKUkk5Aie3jzgtmptK5j2YM0A1Q==
X-Google-Smtp-Source: ABdhPJwntfX9HK0rNpSLv0FA2PIDOfraJdWNEzPME87aHlsI1YigoMHkBY9zfWIZ4zkZlZTrMVgCLVKEjIQ3uwuqYpA=
X-Received: by 2002:a17:90a:fc88:: with SMTP id ci8mr11850938pjb.13.1623459566104;
 Fri, 11 Jun 2021 17:59:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210610185725.897541-1-ben.widawsky@intel.com> <20210610185725.897541-3-ben.widawsky@intel.com>
In-Reply-To: <20210610185725.897541-3-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 11 Jun 2021 17:59:15 -0700
Message-ID: <CAPcyv4hpxbnvGVQAc15RwGyu1XH8JyiBs8prBG8Rx2wkL3=MpQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] cxl/region: Create attribute structure / verify
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

On Thu, Jun 10, 2021 at 11:57 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> Introduce a verification mechanism for a region. Regions have complex
> configuration requirements and it is beneficial to provide a way to
> verify the constraints are met before trying to bind. Primarily it adds
> ABI to inform userspace of more detailed information about what failed
> rather than the limited choices of errno at bind time.

If you want to give userspace more data about an internal process
that's a TRACE_EVENT().

> It's important to point out that a verified region can still fail to
> bind, but the first step in binding will be to run the same verification
> algorithm.

I don't see this point of giving userspace a racy / less accurate
answer than the bind result.
