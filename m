Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51900C433EF
	for <linux-cxl@archiver.kernel.org>; Fri, 10 Sep 2021 18:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28876610C8
	for <linux-cxl@archiver.kernel.org>; Fri, 10 Sep 2021 18:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbhIJSWP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 10 Sep 2021 14:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbhIJSWP (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 10 Sep 2021 14:22:15 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379CAC061574
        for <linux-cxl@vger.kernel.org>; Fri, 10 Sep 2021 11:21:04 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id s29so2589508pfw.5
        for <linux-cxl@vger.kernel.org>; Fri, 10 Sep 2021 11:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tZ6J+sH2Q/ti0xYxStLsW3/ZkNxwjdhDOtl9aciQxc0=;
        b=IYpR5lJDa8TnGJHPyAwCra85wLtM1D1pqr8KH2oB0z36Ji2aMv8rkGCFI9pclciFAH
         WLFmuWQWk+562hvIzyC0eJrv7D9NxWlM7t4JVYTj9KTJenRFJk38Wvl7avVtAep4iuvt
         eMjdNHv8ok7Cv2DUDEDVxncQxalQuZSClFWwS0DDxmPQHrXT5cxM0792Nyo1SoX8E4/g
         J5bKQJ1gsM6MzzHRuZwVJs+d+kTGMpo9Ldyccqg1ff/09CD7xmSyHsEkIRj0/LNhfvn8
         GSXYtkYVxe0A+Zo3l1dbnHM+12Qb0kQJQQ6taMfHRhXL0gNa1in8ajWkqSXjZEeTGtpt
         qarw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tZ6J+sH2Q/ti0xYxStLsW3/ZkNxwjdhDOtl9aciQxc0=;
        b=bh+GHdY7FWBY9g/4/xeeVlyoA6Ct8n5+0enj6iVdGkHQlTvBvq7st9g4D1kChQn3J+
         o9hHco23GZUUCf//WXwnOrmujN6hkai97TvI6sOMCsYVOBrv8x0DWtU7J+6UlniBVUj1
         5Z8GExHsnwfjGFr1ZYQCvRsUpFs0SOd5FVQnmriAgvTVubUOcwPwbiwFmhK+TFAMaKDF
         TuN+Hik52NXlfWrq+MEO+ToVWi9dym2PErH/Br7FyDLZi6QmBpn+oebg0OyNPfp9l9Gu
         3hR1mrGj5s9ldgAhANnRUDSHsYnZEKuvY6G58EbXD+oHzqPmzk4x0oKADAQLejC3I/TX
         jdYw==
X-Gm-Message-State: AOAM532hcngvdlS8/S2p1zHk48HMulBBRCntYLEdicV5eiLl3wqckqSh
        9lbKZa96oJccFrb7yyWJOD48PSWFqbppoeWUfR8NjVaj+mo=
X-Google-Smtp-Source: ABdhPJx/w1RkoxQpyyc1P9RQbrpvvFyLfpceQz1w9XXXOVINdHfSOtSpT1pv+tjHg48nuDMNbf5/d+vDWFThwzYgPOE=
X-Received: by 2002:a63:1e0e:: with SMTP id e14mr8427887pge.5.1631298063711;
 Fri, 10 Sep 2021 11:21:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210902195017.2516472-1-ben.widawsky@intel.com>
 <20210902195017.2516472-2-ben.widawsky@intel.com> <20210903150550.00006ed3@Huawei.com>
In-Reply-To: <20210903150550.00006ed3@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 10 Sep 2021 11:20:52 -0700
Message-ID: <CAPcyv4iXOXsKLx0bmr6isck_gsMMoJQW227wtHmyBvvDgwgNVQ@mail.gmail.com>
Subject: Re: [PATCH 01/13] Documentation/cxl: Add bus internal docs
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Sep 3, 2021 at 7:06 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Thu, 2 Sep 2021 12:50:05 -0700
> Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> > Kernel docs are already present in this file, but nothing is instructed
> > to generate them. Address that.
> >
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
>
> FWIW
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Arguably nothing to do with the later bits of the set though so
> I'd have had these doc improvements in a mini set of their own.

As long as whoever merges this knows that it could go into its own
topic branch if need be I think it's easier for contributors to send
straight line sets. My only ask is that the set is organized as fixes
=> cleanups => features. If a mildly "unrelated" change sneaks in not
related with the "feature" patches, that's ok to me.
