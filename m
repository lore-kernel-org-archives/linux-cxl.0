Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5078CC433E0
	for <linux-cxl@archiver.kernel.org>; Mon, 22 Feb 2021 16:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A07264ED6
	for <linux-cxl@archiver.kernel.org>; Mon, 22 Feb 2021 16:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhBVQN2 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 22 Feb 2021 11:13:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbhBVQNA (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 22 Feb 2021 11:13:00 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985CBC061574
        for <linux-cxl@vger.kernel.org>; Mon, 22 Feb 2021 08:12:18 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id v22so22626528edx.13
        for <linux-cxl@vger.kernel.org>; Mon, 22 Feb 2021 08:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=emGlnXqclXarc6XinJzjsJwBcr9ep89p4hBrZ50PBUk=;
        b=HOfGy23TaiAXDhDXx6MF/w8gWpPG5jL9XO/SQfdnS4xfWn53XErZxVptHXfiEmec1z
         1DL2H5n6TC3X5AkERzAoWecGjOK425BHGyQv25Yu/R7rBRkka6KdGkaTmfa1USmK+zlz
         LrLDQuvbedGO2basfUH4ot9xU2OdYcWFLNK2W9qpB8Gcy1YnZBPCF5+9SRzg3eNHXwCg
         ib8Cb2IlOp18alWhJMP8n0+wMF1zfkeVf3z29yAaBJ+fo9vyFAIjcBAnF/wnB11NJeYF
         K7dKdfH6nZjrd3LCTLDa/rYV2/o6HNzPhlOtiWVceN58xD1AIy/U/OXUjmKnJhstuGti
         eYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=emGlnXqclXarc6XinJzjsJwBcr9ep89p4hBrZ50PBUk=;
        b=C6YJkkaR0yZXsiJe/jvf+JdIlO9muJvZKMOeDI3yMc9a+aF+0JqzCGFVgoKa2RovQq
         YK4x6dAZ5s7iZddFpNC316bsjtV2epMdh+UjtxIW4A1EG3WMwmlERn3O5Z7+4t24JUK9
         g0SFMKdu6/hx0czSJg1NBmWMtcj5hEyezX1umO+PkMotQciLlR+D2B4bSeHcLpQOoCAo
         1jJm0hn6g8NDqCjMRWiqu+YKKmGXS6bmfbuDc7CQ2Furm0Zqf1SPAyFWqaR8CXrHYgAH
         lXxAlMN+aiIhDXni+ZZ60Fu8naQJk/6Wy/oJUFCuQI7WWT8EKFaFYpXPRg0cSjxtXZK2
         2Gcw==
X-Gm-Message-State: AOAM531XYs2cnDybpRpYvTxbtl5o+z04g+N1gpGxKIQCRKIJxJH7dxLy
        Z9eNifulrIWdNO1kUTMq1naABImpGg0caL/OFL9wnw==
X-Google-Smtp-Source: ABdhPJzkbvr0lPYEuSyq3XzUq/hFn7o16di5v9Gr3bliZj4j+tNNJhDD+5mQGRMaYPMJBCwjYSnLAXoc2rxZaBbgCa0=
X-Received: by 2002:aa7:d315:: with SMTP id p21mr21752804edq.300.1614010337292;
 Mon, 22 Feb 2021 08:12:17 -0800 (PST)
MIME-Version: 1.0
References: <20210220215641.604535-1-ben.widawsky@intel.com>
 <CAPcyv4gfoe=QGuKV19ay51D-cqzRqTMLpD-p5whnJbYkKoGtBA@mail.gmail.com> <20210221034703.ncetonon7iseqd72@intel.com>
In-Reply-To: <20210221034703.ncetonon7iseqd72@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 22 Feb 2021 08:12:12 -0800
Message-ID: <CAPcyv4jx67uyiypbkM-Yd-yTMw-tcrKkkH3YdjkjBa3m2XXF0g@mail.gmail.com>
Subject: Re: [PATCH] cxl/mem: Fixes to IOCTL interface
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Sat, Feb 20, 2021 at 7:47 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 21-02-20 18:38:36, Dan Williams wrote:
> > On Sat, Feb 20, 2021 at 1:57 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > >
> > > When submitting a command for userspace, input and output payload bounce
> > > buffers are allocated. For a given command, both input and output
> > > buffers may exist and so when allocation of the input buffer fails, the
> > > output buffer must be freed. As far as I can tell, userspace can't
> > > easily exploit the leak to OOM a machine unless the machine was already
> > > near OOM state.
> > >
> > > This bug was introduced in v5 of the patch and did not exist in prior
> > > revisions.
> > >
> >
> > Thanks for the quick turnaround, but I think that speed introduced
> > some issues...
> >
> > > While here, adjust the variable 'j' found in patch review by Konrad.
> >
> > Please split this pure cleanup to its own patch. The subject says
> > "Fixes", but it's only the one fix.
> >
>
> This was intentional. I pinged you internally to just drop it if you don't like
> to combine these kind of things.

Apologies, I've been offline this weekend and missed that. I will
point out though that in general I will not change patch contents on
the way upstream. The adjusted patch must appear on the mailing list.
The new korg support for attaching attestation to patches requires
they all be on the list, so even small adjustments need new postings.

> It didn't feel worthwhile to introduce a new
> patch to change the 'j'.

Janitorial patches happen all the time, so I think it's ok.
