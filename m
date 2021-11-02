Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAA7C433F5
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Nov 2021 01:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6F2660724
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Nov 2021 01:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbhKBB4o (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 1 Nov 2021 21:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbhKBB4n (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 1 Nov 2021 21:56:43 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B402FC061714
        for <linux-cxl@vger.kernel.org>; Mon,  1 Nov 2021 18:54:09 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id t11so13532386plq.11
        for <linux-cxl@vger.kernel.org>; Mon, 01 Nov 2021 18:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dKZ/fvG5lf3sRlKKiojPY8Oqh8Cd2e7C14EzfIfpmG4=;
        b=Zw6Xeom7vzrPagkQiKW7Ixd47/74gI9QtnElQrSOL0DjHUAHkKpFqDXuryuR3i6AMX
         vSvsXThpEmp/T4QLMi8h3KVk+OgpMU4ahXJ61kV5Girfcuwm0PRV7EbE8sHq3B8bxJDm
         xTXCY62rEzefF+rCCdGHvxJqiIUFxLsyaCS4JIpgvJF8YxlKgsHbSWuI682jdk+mz0Bj
         FXoVtqaq5WFlqtSxLzUa1aFuBKfdt0XxixuUplxy7ZFV+8eueeRp7p1SPGuIKJBB7u9F
         mWjXFF68/qgkjDgI0mU2//ck+5qdALAeGazasWkyr0KTky26USTxMD6Qh9rzT/tTP3hQ
         P54A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dKZ/fvG5lf3sRlKKiojPY8Oqh8Cd2e7C14EzfIfpmG4=;
        b=Is5DyVi068vpP6SdliBjlvTSH70whdGFcv/YCtUwhuxMjAU/HpsEvvAPyygRL7dTk+
         Q0853P9qLbmLqY3+MxnrhuQ9MhjVKnZursoKvme+JVh6NJBL4J9YgZxXN+7+F0Ir0xvM
         aERvDoCal/alfnMnJ0HphN6uwCGzefdZoLdAwOqVI8yaLywZaAdJowVde9uPqzhPboSB
         4o4co4+B6hMX9PtS0Pm15u2LM65+Y257IhqQ1q1bHCVGYv491nNec3Iiun3t9VZkbEiB
         9NaQWG4Npr1Hkbx7KHVqAO2MNYD0156x3xjka2eVIxpAMC+KLC0I4boj8JCbzFWd+oCN
         6UbA==
X-Gm-Message-State: AOAM530NNbkueFBSuhzU6pi5557pDFqdS31qLBbX88r3HlHhiFZmx5U9
        LOQcGFuJTVi0E6SRjJjqkmkYtesOpkZ0337klbsAGQ==
X-Google-Smtp-Source: ABdhPJyhkAMzZE74Pagc2aRiA0EahLSYqUuXuPpc6+kmdjVYEvJIPTcHC+5d8ll6xN60wfPHP4+zTGAB02czdygWt9w=
X-Received: by 2002:a17:90b:350f:: with SMTP id ls15mr3035735pjb.220.1635818049123;
 Mon, 01 Nov 2021 18:54:09 -0700 (PDT)
MIME-Version: 1.0
References: <20211022183709.1199701-1-ben.widawsky@intel.com>
 <20211022183709.1199701-14-ben.widawsky@intel.com> <CAPcyv4i9zc4HtXJ4eQpVtGF38xMNNuFy1MwLQR5fb65Wy+XekQ@mail.gmail.com>
 <20211101220010.bryozhtydumb6waj@intel.com>
In-Reply-To: <20211101220010.bryozhtydumb6waj@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 1 Nov 2021 18:53:58 -0700
Message-ID: <CAPcyv4jjy0_Uf-66+sCRaraJG9aBgesHO_QsJn7j=Yd7DMq4HQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 13/28] cxl: Flesh out register names
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

On Mon, Nov 1, 2021 at 3:00 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 21-10-31 13:18:36, Dan Williams wrote:
> > On Fri, Oct 22, 2021 at 11:37 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > >
> > > Get a better naming scheme in place for upcoming additions. To solidify
> > > the schema, add all the DVSEC identifiers to start with.
> >
> > The title and this changelog don't give anything of substance to
> > review the patch.
> >
> > This also looks like a rename and addition of more definitions. The
> > rename has one rationale, the additional definitions have a different
> > one, so split those into 2 patches, or fold the additions into the
> > patch that uses them.
> >
>
> I added more than necessary as a means to codify the naming scheme [as stated].
> Many of them are not used. I can split this patch into two, though I personally
> don't find it offensive to do it as one. Before I do that, I'd like to know
> though if you're going to reject the patch if I'm not actually using all of the
> defines later on.
>

They don't all need to be used, but a rationale for adding them is the request.
