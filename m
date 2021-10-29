Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B3FC433EF
	for <linux-cxl@archiver.kernel.org>; Fri, 29 Oct 2021 22:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D58666103E
	for <linux-cxl@archiver.kernel.org>; Fri, 29 Oct 2021 22:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbhJ2W1o (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 29 Oct 2021 18:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhJ2W1n (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 29 Oct 2021 18:27:43 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA334C061570
        for <linux-cxl@vger.kernel.org>; Fri, 29 Oct 2021 15:25:14 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id gn3so8137794pjb.0
        for <linux-cxl@vger.kernel.org>; Fri, 29 Oct 2021 15:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lWdESddijh/xWpWegkm3EXnbhxITI8x8BfwxjUarsG8=;
        b=ACq7i7ZaMVNfDeaZGUMI4gTkEJYg55OnnhKe9acRMVjm9PfLb2cL58lo9rQywUqVMD
         YhU7cwgGVJIQSHVZN2wNGJlhSkazS+EB1J40JRu79KL38lXN5oGHtQ759JBC4yFbjA3D
         K7+xg0qxAJrrPJ63fIyGz35trbEkIRp+w3mUqYf5OWn+L573TNLLmKmVhmIPcjW+6eoJ
         7/KGJ8TWrHHoYq3F9JYKu8n3x5lpfAF5fmF2qDlyIoYYhZyO8Uk7suL1VsV0KEfNF/DG
         UuIEgb8viR9K6Se5tI1MZVAeBuE6cWV6VpKQ0NDM9frAwB3z95k2V3vNOPkBU3H3IVEP
         v+pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lWdESddijh/xWpWegkm3EXnbhxITI8x8BfwxjUarsG8=;
        b=goBKn7UMvpx/o+IwjoRzSSoliiZKZGdgQ2WA5XlwOKpuP2MuLHYHxC2/qJtOKVfsen
         kDTQ+jIUYQvUiZIBoc0O6Wqu7OAtZesXd8CkxHxAOHXyQ8KrrrMrAwRtyxnhRfHhbkpO
         4+jU6rGnMfNIRNpvoMNhZyRJbUuiKTHY9FZXPZry2KsT/iaQxTfS70Zp/1Tf3PAkD+26
         x5jarDJor9fsSSB0stay5OC1DtYrxgMtcyBT/vMg4Cm5gTiFqx/kl2Iux3z/seO6+LiG
         /hpMq9U1qszhsDYom8kChCbneG+MJgKcJE654NsS27mkwZpjbBtv6xWBLFduwW++aG40
         gpTw==
X-Gm-Message-State: AOAM53378K6rmsYpmZ8VOpkcFKvmev6pleQ0n74Oz0wBGnJRitWL7ZWe
        NULySslF5z2lac8G6nMNtnDUOqD1P4NxZpV955sSyg==
X-Google-Smtp-Source: ABdhPJyWRlQ8iHqPV3Z9HrnOy+C4rgjAhV7sBw4EerTJlnn1Dnc/XWTbCoEtcjpvkL2b9IQ2IPuvz1v4SVLnGQauvdc=
X-Received: by 2002:a17:90b:3b88:: with SMTP id pc8mr13941324pjb.93.1635546314503;
 Fri, 29 Oct 2021 15:25:14 -0700 (PDT)
MIME-Version: 1.0
References: <20211022183709.1199701-1-ben.widawsky@intel.com>
 <20211022183709.1199701-7-ben.widawsky@intel.com> <CAPcyv4iiMFCUEg+8zk6yqSmA_9jXjkjkEpYdj4zVr8n=GbodvA@mail.gmail.com>
 <20211029220258.ghqdgnehg6ptjy3e@intel.com>
In-Reply-To: <20211029220258.ghqdgnehg6ptjy3e@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 29 Oct 2021 15:25:02 -0700
Message-ID: <CAPcyv4i8Sw+aja+XtVDWNzf4S6bEj96dgQYk3+=k=C1NJxYBAQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 06/28] cxl: Introduce endpoint decoders
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

On Fri, Oct 29, 2021 at 3:03 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 21-10-29 14:00:21, Dan Williams wrote:
> > On Fri, Oct 22, 2021 at 11:37 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > >
> > > Endpoints have decoders too. It is useful to share the same
> > > infrastructure from cxl_core. Endpoints do not have dports (downstream
> > > targets), only the underlying physical medium. As a result, some special
> > > casing is needed.
> > >
> > > There is no functional change introduced yet as endpoints don't actually
> > > enumerate decoders yet.
> >
> > The nr_targets type change either needs to be commented on here, or
> > moved to its own patch.
>
> Do you have a preference?

Slight preference for separate patch.
