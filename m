Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF22C48BE0
	for <linux-cxl@archiver.kernel.org>; Fri, 11 Jun 2021 19:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0373561364
	for <linux-cxl@archiver.kernel.org>; Fri, 11 Jun 2021 19:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbhFKTLZ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 11 Jun 2021 15:11:25 -0400
Received: from mail-pl1-f180.google.com ([209.85.214.180]:46855 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbhFKTLZ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 11 Jun 2021 15:11:25 -0400
Received: by mail-pl1-f180.google.com with SMTP id e1so3291658pld.13
        for <linux-cxl@vger.kernel.org>; Fri, 11 Jun 2021 12:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6m80Z2mndzL27Wtu9J5IuMxR9RUrpcAOgtyf8nDW8h4=;
        b=eMiff3k5ulvvE1pWOBt/zG2iCzZv0cMKtXVlBieggum0yljBeLBzAVrBvzf3JVusw4
         o3MivEGRp1MaEGNQXZUO4bI7KBVVF1/1tkRKCIQae0xKeZLgeP+N4wtaXZv066rdcxY7
         pQRc1N2nyZ78sciG5Ntj8aATdJIXQ6zqDIY61Mp27nUn2XQ19BIAGtbdbfZvkULx948N
         MWVcPPdSGyqzMl0mZKVS8kzlURHgPQPDIK5ofYqOY1jzSxG1U+I6P1X1b7wLsLZuOwfV
         sjAhq60IgfO8AQwyKv+wL000zTVBWJ7/7AplbBId7cJ0malGwDkDSR/xrIdvqEt09evZ
         1Wpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6m80Z2mndzL27Wtu9J5IuMxR9RUrpcAOgtyf8nDW8h4=;
        b=LT4vl/vl49tpjk4mlgep7KZ0y60rik052m1XgfViH4HQFf3lA7KV/TpssW4SiLxnbD
         FuP9wZN80uHofwrlMqdPiGwg3IAVkhf4DmtI78N2I8ktQpuvXgHMEcu/uPUqOjdeAoY+
         d1DVjWTbfjMS34WVkNzgAABeg9xqNizzHx2R65XsVrS2FSMmSKs2AsuNDZ7MtOa4V3hH
         tLYGXWjeiN27Ix5I04wdNIBo4NdF9dqWm+4VQTNmIsO/6gqN8j7rTxDBPzOvIjgcb8/M
         JUdbxK3Bw7g+8cMJkrpGeuLaPPD2qnzbw1pfUQUhUGxjgwlTSKPrg0Pq/GvM/2vY2Xaw
         9CYw==
X-Gm-Message-State: AOAM533RP/IQmjdYOo06pttyTMyfhddfJiVCj6Vpdh2gZrXwTYxZZAX7
        8q6nDc3+EMvk/AKcdwbrkKm6EpVwI3dJ/3hxnhsHVQ==
X-Google-Smtp-Source: ABdhPJwud8cuaR6R+g1bLBa0Cyz1E6E6b3pZ+x2SLcY/l4XVzg8YwGIW9dWV+GylMvqjsVxCOeWS6jYCfLCnDmNlQzA=
X-Received: by 2002:a17:90a:8589:: with SMTP id m9mr10334561pjn.168.1623438506643;
 Fri, 11 Jun 2021 12:08:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210610215332.991905-1-ben.widawsky@intel.com> <20210611190111.121295-1-ben.widawsky@intel.com>
In-Reply-To: <20210611190111.121295-1-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 11 Jun 2021 12:08:15 -0700
Message-ID: <CAPcyv4goxp8zh5FXu0qPFVVY-6HW5tsbMjwNcKW3fXwV7vOing@mail.gmail.com>
Subject: Re: [PATCH v2] cxl/hdm: Fix decoder count calculation
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Jun 11, 2021 at 12:01 PM Ben Widawsky <ben.widawsky@intel.com> wrot=
e:
>
> The decoder count in the HDM decoder capability structure is an encoded
> field. As defined in the spec:
>
> Decoder Count: Reports the number of memory address decoders implemented
> by the component.
> 0 =E2=80=93 1 Decoder
> 1 =E2=80=93 2 Decoders
> 2 =E2=80=93 4 Decoders
> 3 =E2=80=93 6 Decoders
> 4 =E2=80=93 8 Decoders
> 5 =E2=80=93 10 Decoders
> All other values are reserved
>
> Nothing is actually fixed by this as nothing actually used this mapping
> yet.

I'll still add the Fixes tag because the original commit is broken
even if the impact of fixing this bug is moot in the near term.
