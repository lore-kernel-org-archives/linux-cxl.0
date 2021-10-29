Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCB6C433EF
	for <linux-cxl@archiver.kernel.org>; Fri, 29 Oct 2021 23:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0069B60230
	for <linux-cxl@archiver.kernel.org>; Fri, 29 Oct 2021 23:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbhJ2XGQ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 29 Oct 2021 19:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhJ2XGP (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 29 Oct 2021 19:06:15 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6349C061570
        for <linux-cxl@vger.kernel.org>; Fri, 29 Oct 2021 16:03:46 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id n18so7763163plc.2
        for <linux-cxl@vger.kernel.org>; Fri, 29 Oct 2021 16:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kxte/SZFPUmFwF0hQ6pr6fOg32ZSIyD88r/VzMokSDs=;
        b=o48FHu13v9BpvS6CbzQ65aWQGm7uepWhDHFrGvT51ehxYmqneFYHWflBf7HOKY85mS
         kKUjSxtsQRX+CPfBwaFQYpcbvitIkwclGtoy1WbYWOGce8Qe4gL2AOeRq4rWcaNRU7o9
         SA3wSd9J4m0ztudc+EibHKBLB5hdlw4YNG8punaRsD2zGDEZ9uHezIR02UYbVeeNGygK
         kKZaWZWR6OUmG6PYF8bNWdAmKJwgQIkTj3dHnb+YpcIlMM4OEySUnbCd4+JijnLsglPk
         4jOXq2F4Wy2FuMOI+qZPBHOz9r0Oa9iLPwpMMtL2zydnizf/o1XixoULcMnfOuWhqB0O
         P+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kxte/SZFPUmFwF0hQ6pr6fOg32ZSIyD88r/VzMokSDs=;
        b=yEY78WXL1JwHQmaTaVUsIYDd4z4rM+1jBM6OyRV997jTDfmOOM49c6V0WIIGxvcpw3
         ZMPDzdytOIR1DMzBR1LDzEQUhuUCm724AWlZDAt7Y9vPbTdcGqY97JLlRC5PUV/Si5/h
         ho+zsqfKDAxR+rgRvIlw0Gai+YlI6Hty+vis8Izr9LDiyLPWhLY+FhKZUVZ8KjT2QI51
         qze0FTyBE/T3Jc4ap7fLuyBe5DgjZgG/hJ05D4Fz3Z0NJzK6OkwZaTbucXoW192yJkvi
         uZxlPLghBuwocaUugTKu3CUetKZ0OZpnXZDJ3KlZCaiywUsKTA2w6pVWwmGCb/Cx1f+h
         b3vw==
X-Gm-Message-State: AOAM532d3Q4UnREh3SlB8x9a5HpxqEuJfU6AYt//jdknGNJxozaQ6Srg
        tX+k6B7W/9voEou8C4TEZFdcYHb9eFoKVa+lJG99Hg==
X-Google-Smtp-Source: ABdhPJx7dtGqAti29GJKjC2mHfRVtYkYGWt5JfRdSTAW/IiG4KG+fhDBSlky8HrURz+WoTpOCfsqgeAoNBc/4T4JYX0=
X-Received: by 2002:a17:90a:a085:: with SMTP id r5mr22743033pjp.8.1635548626134;
 Fri, 29 Oct 2021 16:03:46 -0700 (PDT)
MIME-Version: 1.0
References: <20211022183709.1199701-1-ben.widawsky@intel.com> <20211022183709.1199701-8-ben.widawsky@intel.com>
In-Reply-To: <20211022183709.1199701-8-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 29 Oct 2021 16:03:34 -0700
Message-ID: <CAPcyv4jZhrKR4qEqx8-oWt+LPbmXOHJUc=3pUcG_ZQGqc2U1xw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 07/28] cxl/core: Move target population locking to caller
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Oct 22, 2021 at 11:37 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> A CXL port driver which would be responsible for adding decoders will
> want to do so during probe.

"In preparation for a port driver that enumerates a descendant port +
decoder hierarchy, arrange for an unlocked version of
cxl_decoder_add(). Otherwise a port-driver that adds a child decoder
will deadlock on the device_lock() in ->probe()."

...although when I write it that way I would expect to see
cxl_decoder_add_locked() in this patch.

The port driver patch is big enough already, so pulling the API
addition into this patch would be my preference.
