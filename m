Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00A6C433EF
	for <linux-cxl@archiver.kernel.org>; Wed, 13 Apr 2022 21:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234621AbiDMVYj (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 13 Apr 2022 17:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239070AbiDMVYh (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 13 Apr 2022 17:24:37 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A932465480
        for <linux-cxl@vger.kernel.org>; Wed, 13 Apr 2022 14:22:15 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id bg24so3252939pjb.1
        for <linux-cxl@vger.kernel.org>; Wed, 13 Apr 2022 14:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4omrGBh4rMwEJEaoEHmM1XJRtehHXwGUeZy3KwoVcfc=;
        b=JHwn8yeQUIn0NLauMr393piIbTf3OTdCg4uXX41ukSp+4RGipfV9bBe8uRCqMHQlMX
         9S25rGSI3H+jBJ3AxQi2O0+xwcLfAeUPoncKPZXif+9g/IDp5dFHaydwnhjQANt1yLkX
         GyJs2zPbkf1G739gFU7CyFtLQ+Hj+1YOi7cWu3kWoOrz/uV1Z437+TvYQ0lzA9rafhT7
         uJIpadx77lSEA+Ry1z4neKG0sFKUF6fjIWOksJjovqetFl6uM2NWsDNj2hQ4DaJHC6NM
         AT+4sAQSWhMPQElg5pijJvYjZFQevAs1L2uYm7r9kasb7Oo/ecs3QY3jm2SnWWRZMTyP
         gytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4omrGBh4rMwEJEaoEHmM1XJRtehHXwGUeZy3KwoVcfc=;
        b=ELDr4ssDqmDmAR+XVDN5US+pDJXU/NdPpTAJCdGUWPpAuAP95BWGVtwrJ2qAYMeU3o
         kL/2adsvKQjWZZlsMSqnNAtY1kapwA+o/Uym+TBNyjJHLrHp5FfIgaP89gjMtMEGglFL
         ObzsIqLy59Z890oW5FbBG4mcyMxdzBbI7RLP9VqZmRTGf/kOYp3zmg0g6LxQ8umUP1uu
         hPfNTMDFm4YRlkGWbMVP+vsgdSgbdjpyNyV9J+sF6oZIYXQWaInyPxf6RjdpZwQqE/Df
         QxCwgok7joSp5CPiEzWyuC6HAaJKh0UEwfCTanQunELXoSIY1+l9SjxXiv+m9XdFtHj6
         c+/Q==
X-Gm-Message-State: AOAM532Rd3xdSTqb8pc/LhUiLhgYoUlvFQxHKblt1FL8v5TL0/+7aW4o
        TGe3Qr0JwtnCkLr3m1k5deCPPrX8FcNJzaLi3r0PIA==
X-Google-Smtp-Source: ABdhPJzJ1KuMUw+23/AIxQgzDx5RbhtEYcoArH9fBDCciyTF6G30/td30jwZCE13hnZ4ygVGIROTwReA5Afzf8G+BBY=
X-Received: by 2002:a17:90b:1804:b0:1cb:82e3:5cd0 with SMTP id
 lw4-20020a17090b180400b001cb82e35cd0mr743163pjb.8.1649884935282; Wed, 13 Apr
 2022 14:22:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220413183720.2444089-1-ben.widawsky@intel.com> <20220413183720.2444089-2-ben.widawsky@intel.com>
In-Reply-To: <20220413183720.2444089-2-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 13 Apr 2022 14:22:04 -0700
Message-ID: <CAPcyv4jJxeQ4MxG=coe+J-qsdDVZxP7f5oXSR0QkJoJ0d2tSdg@mail.gmail.com>
Subject: Re: [RFC PATCH 01/15] cxl/core: Use is_endpoint_decoder
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Linux NVDIMM <nvdimm@lists.linux.dev>,
        patches@lists.linux.dev,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Apr 13, 2022 at 11:37 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> Save some characters and directly check decoder type rather than port
> type. There's no need to check if the port is an endpoint port since we
> already know the decoder, after alloc, has a specified type.

...a smidge more clarity:

s/we already know the decoder, after alloc,/,by this point,
cxl_endpoint_decoder_alloc()/

Otherwise, looks good to me.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
