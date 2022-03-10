Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BECC433F5
	for <linux-cxl@archiver.kernel.org>; Thu, 10 Mar 2022 03:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234822AbiCJDz3 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 9 Mar 2022 22:55:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234041AbiCJDz2 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 9 Mar 2022 22:55:28 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EEFE4481
        for <linux-cxl@vger.kernel.org>; Wed,  9 Mar 2022 19:54:28 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 132so3659411pga.5
        for <linux-cxl@vger.kernel.org>; Wed, 09 Mar 2022 19:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lU5YJqnIdV6EY+Secthv0iH88/tqXC8YBp4+e6GV1+A=;
        b=vWwRMK+EIdboVO5wlmn0/o8zduvLLav44n1w6rT88q/HHODVeCiCbS+vYYbHGA6UV4
         lsUNLp70L/1OLzQ47T9bzH+030qyZSx/MTTOE2xZetveZ6il1kDT29fEUBXfRltQ5Eu8
         hkkeBjJSg7iHJQ+N29qLjpIytfcxW3WAzHYEDpeJ6nrZymuJHrRgOPgpJSX0+QOuHvJm
         C4qvxbQoMS+p5LKHuVroK6YQqwERfAD36xIRKCK8+SWDj3416FPLgejd5Dp+6xYnE9CC
         VUFsXuGvwnhvkZXGQ0wL81sF7D/YaKSVq7dbXetnhyDB0ihysr99z/98GaqyiEjgr2an
         i4MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lU5YJqnIdV6EY+Secthv0iH88/tqXC8YBp4+e6GV1+A=;
        b=dnuag3bsxiAPpQkLcqMz3ONGGFSLlU14CMuKgisDAGs9Gvjk8nEvs7evSNudAfaO8f
         U1E3IH4cDwiDscH+xSMhZUTn/46n7khBPCyKsrNC19lqJY7D5WZeGtZmi0FleQ8d8SnQ
         plENdVon+rgl6ymbxmsPXLlR4ttK+c1uFETFF6SmHgjHMuOfkG2qUgQmWXDhvZTXT2ku
         QZ4RzbusWkMEAVoo78TMSYNJvg3RkHwi71gmv0cBFS+GS4Q0Vtaw2R3ce0JheHw8NnDR
         stNDubNccFy5CQNcwyOezlQISBRn3QzNr8zLkLmFgOctOGBcBZ48B3KBq08g6xuDneF/
         DYyg==
X-Gm-Message-State: AOAM5330ySowJcUlSp9lAK3LDwEYWKrbLB7bQmNRcxps9ClQLV62SZkc
        1H15/wDbjQH7UwhuO/NxOMXQW/UA95XHrVShjeigsw==
X-Google-Smtp-Source: ABdhPJwvemzucTPrgpseFphjjG8pwdptwyDczVK5E/gt4x73Np20Dd90o+US1aq+uxMNTq2O9E9h8MAmCdWWN6fMKqY=
X-Received: by 2002:a05:6a02:283:b0:342:703e:1434 with SMTP id
 bk3-20020a056a02028300b00342703e1434mr2456148pgb.74.1646884468421; Wed, 09
 Mar 2022 19:54:28 -0800 (PST)
MIME-Version: 1.0
References: <164610292916.2682974.12924748003366352335.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164610294604.2682974.11169622387063183603.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20220309182217.00006bf5@Huawei.com>
In-Reply-To: <20220309182217.00006bf5@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 9 Mar 2022 19:54:17 -0800
Message-ID: <CAPcyv4jJyRZG70+P-Y8_W_MbSW42wZ=SN8DbJvUL4Q6Y7kDkvQ@mail.gmail.com>
Subject: Re: [PATCH 03/11] cxl/core: Remove cxl_device_lock()
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Rafael J Wysocki <rafael.j.wysocki@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-cxl@vger.kernel.org, Linux NVDIMM <nvdimm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Mar 9, 2022 at 10:22 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Mon, 28 Feb 2022 18:49:06 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > In preparation for moving lockdep_mutex nested lock acquisition into the
> > core, remove the cxl_device_lock() wrapper, but preserve
> > cxl_lock_class() that will be used to inform the core of the subsystem's
> > lock ordering rules.
> >
> > Cc: Alison Schofield <alison.schofield@intel.com>
> > Cc: Vishal Verma <vishal.l.verma@intel.com>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Cc: Ben Widawsky <ben.widawsky@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> Makes sense, but perhaps the description should call out that after
> this patch it's not just a wrapper remove, but rather the lock
> checking is totally gone for now?

Sure, that's worth a note.

>
> Otherwise this looks fine to me. FWIW
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
