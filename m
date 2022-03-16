Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9BCC433F5
	for <linux-cxl@archiver.kernel.org>; Wed, 16 Mar 2022 02:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbiCPCQA (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 15 Mar 2022 22:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbiCPCP7 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 15 Mar 2022 22:15:59 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA4B642C
        for <linux-cxl@vger.kernel.org>; Tue, 15 Mar 2022 19:14:46 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id p17so651872plo.9
        for <linux-cxl@vger.kernel.org>; Tue, 15 Mar 2022 19:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GYgLGDjN7bBh9eUkBYm9fB085sxIPX8tBbz7CcJSMNo=;
        b=357HrcwQ7kar2/o5pnP5AYSakCaFEeywuRqBR1G0sPFiFI0aWyTE7tq2Q1M8p9FbkE
         cd3EO7BBzDRtnJihqjula3R4xYGIwH8djuGMvCMLR3++9qstOJiFgfikq4kHHYf8xQv/
         vwYxoXqDcS/m+XNe6JOTbz9hIvb8lpJszUx8b2ry5WLFE1vL1TUQneVLxzoNmqhjsRuP
         eJF5Fd7ASYZyxqzBf0cKrUk03PQT9QvAvrdFb2VdQ7qnfu7psm/cYXQ7MK961SoGMjrh
         U+HBjd+tKGf84hWtXTENlt1DhWrpWbKTCbiMG4XB7RAESiQ0qDemQXLAXj+mMVq7H1zT
         4EBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GYgLGDjN7bBh9eUkBYm9fB085sxIPX8tBbz7CcJSMNo=;
        b=ko4jhFV8sww8Gw5FqGQSnVcG7AD9iPh2xl49JqVneI4az6TOGeWo3lb8C5tcKe6JBC
         3n9P21nfrtNc3Uxn8GKUtc07sdiiI0UTaLFv0i/MiFY40NpH50fes3mTB0q94RR2SFFe
         m7ELH/YrHmyzltNrK9Hda/n3BOKZeizlHjUi5WToEzsFhiJ+u7dWXoXrI0d/fap0VZ/P
         Ew6amqRlyXYExoqB04xBigMERFGbcXsPfBIPN+btxni4gPhTqNn6QIkLC5vCuf4azmCT
         bI5kkb/3dWomVEb4eYESFZfxLs1hjiuDMzUZ3fjh4iq64e3wtK+w+nWL4nfF1CZ9yXAu
         bzPQ==
X-Gm-Message-State: AOAM530x7WB7qy4Ol9/dGHVJC2X+XQtfmkVLJnX9RDuTCt+rurPz3+uG
        rIUl5eukx3vmf+RcXZXV1e/VX6NFv8gw0xrlNWNvTA==
X-Google-Smtp-Source: ABdhPJwNhPjn7GnmwxQze0BbWCInQRhNFjfnPN2lX/9ea5M35+LmR1tFTNso0Kvg0f8enSe82CwFo8zJb/J2Ir1Wyc4=
X-Received: by 2002:a17:90a:430d:b0:1bc:f340:8096 with SMTP id
 q13-20020a17090a430d00b001bcf3408096mr7786077pjg.93.1647396886019; Tue, 15
 Mar 2022 19:14:46 -0700 (PDT)
MIME-Version: 1.0
References: <164730733718.3806189.9721916820488234094.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164730735324.3806189.4167509857771192422.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20220316020028.2yqjvez4avwrni5l@offworld>
In-Reply-To: <20220316020028.2yqjvez4avwrni5l@offworld>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 15 Mar 2022 19:14:35 -0700
Message-ID: <CAPcyv4hDbqa2d_6ZEwcNAUjgu_Aw7p_f_eB4UN=MrpOrb6QPxA@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] cxl/mem: Make cxl_dvsec_range() init failure fatal
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Mar 15, 2022 at 7:01 PM Davidlohr Bueso <dave@stgolabs.net> wrote:
>
> On Mon, 14 Mar 2022, Dan Williams wrote:
>
> >In preparation for the cxl_pci driver to continue operation after
> >cxl_dvsec_range() failure, update cxl_mem to check for negative error
> >codes in info->ranges. Treat that condition as fatal regardless of the
> >state of the HDM configuration since cxl_mem needs positive confirmation
> >that legacy ranges were not established by platform firmware or another
> >agent.
> >
> >Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> >---
> > drivers/cxl/mem.c |    3 +++
> > 1 file changed, 3 insertions(+)
> >
> >diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> >index cd4e8bba82aa..50704deb2ff0 100644
> >--- a/drivers/cxl/mem.c
> >+++ b/drivers/cxl/mem.c
> >@@ -88,6 +88,9 @@ __mock bool cxl_dvsec_decode_init(struct cxl_dev_state *cxlds)
> >       void __iomem *crb;
> >       u32 global_ctrl;
> >
> >+      if (info->ranges < 0)
> >+              return false;
> >+
>
> Nit: shouldn't this be part of the next patch that actually implements negative
> info->ranges?

I considered that. Ben had asked for a split and this patch is able to
stand alone since info->ranges is always >= 0 until the next patch.
