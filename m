Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD249C47094
	for <linux-cxl@archiver.kernel.org>; Mon,  7 Jun 2021 17:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5A8D6105A
	for <linux-cxl@archiver.kernel.org>; Mon,  7 Jun 2021 17:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbhFGRHA (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 7 Jun 2021 13:07:00 -0400
Received: from mail-pj1-f54.google.com ([209.85.216.54]:44555 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbhFGRG7 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 7 Jun 2021 13:06:59 -0400
Received: by mail-pj1-f54.google.com with SMTP id h12-20020a17090aa88cb029016400fd8ad8so434471pjq.3
        for <linux-cxl@vger.kernel.org>; Mon, 07 Jun 2021 10:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WyajxUxD+qII3ozGjsYJB4YKIUgJgPWfBGe14Hw5m2s=;
        b=ed/0PzMWKcKEyHTP/yKjwBx0JvITUSJQcZm8zLlSmnLmTn3XfbBvCvTUprBKit9LiI
         mEfZstpZ3HjM4s5khmBvBsJH5XdDYs75OEPphft1zPtGdG19kU5l7Qlu/lko9AmpgoK9
         qknyWnlJ8aIDK5ItieJ1cII0XqSLwUe6h7PBLQ0xnTzzzeGgARou9TXEx6NJ1mTWa+dz
         PboVozhKwY82GAQ/HNVbBi4ykNnfwnOjefgWT/P3nMz8jalTcpRqQ6XxZitfCdIbOMHG
         8HGzmoRQp53yAfDM6W+uPM3XfWtvsu2WRGhyqB9p6ocpzivvWRB6d16bwdVDKhCqDrsQ
         UTug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WyajxUxD+qII3ozGjsYJB4YKIUgJgPWfBGe14Hw5m2s=;
        b=CtfC1HH12lUHkET4JmYw0ps15H0zbq+kvEkiULpfC+zUfFmWnWVAkJg0IBSic44pMi
         XFp7vONK8fXaF29qfPxtkjJ4vRFYalSGErfOJbEa7LWQH5B2sEAZ0hCypS2X7znUW2r/
         1fZ10LKhfFMvm3g+cr7iA2umKRtjIAWUyz3IryWK5F06Qh0Hd2Fppcn8c103jMjtqxy5
         sposUn7kQHmKW4/RykxV2AHThwD+XZYkYlx+x6hLLZtnd//KGPpSpkGYhlovL+fPAj7y
         qjEbTNuHVKY3Fo0+1dh9qb7Awg9xQizC/zS6vVh9KdxEd3Szdl7eJXox7Dkl5wIxzWsJ
         /YAA==
X-Gm-Message-State: AOAM533KZdgZsrmbNdenmzEuo6b9BaDevpeBruCtk/HFWSor6ZKig39+
        dbCSqcNPQeyU8JOpIn276fWV9BRnj8v5TDjgoCnJQw==
X-Google-Smtp-Source: ABdhPJxYAfvSMbKm5tmzBj3vnoPe4a8Paiz65/ivTITcRl25ajJ+YtxumvZdZK55xIyWjmiQ3dvqnRN/amfMUhHvDrM=
X-Received: by 2002:a17:90a:fc88:: with SMTP id ci8mr114198pjb.13.1623085448150;
 Mon, 07 Jun 2021 10:04:08 -0700 (PDT)
MIME-Version: 1.0
References: <162295949351.1109360.10329014558746500142.stgit@dwillia2-desk3.amr.corp.intel.com>
 <162295949886.1109360.17423894188288323907.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAJZ5v0jhh8EXNY9C1_HpD7tdW9s5uNkKdyLOEDAgeK4yHpFXdA@mail.gmail.com>
In-Reply-To: <CAJZ5v0jhh8EXNY9C1_HpD7tdW9s5uNkKdyLOEDAgeK4yHpFXdA@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 7 Jun 2021 10:03:57 -0700
Message-ID: <CAPcyv4hZTrf8a-Ga6yWxMqeg7xy=p5_m6CXKssXY-eKG9otsqA@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] cxl/acpi: Local definition of ACPICA infrastructure
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-cxl@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Alison Schofield <alison.schofield@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Jun 7, 2021 at 5:26 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Sun, Jun 6, 2021 at 8:05 AM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > The recently released CXL specification change (ECN) for the CXL Fixed
> > Memory Window Structure (CFMWS) extension to the CXL Early Discovery
> > Table (CEDT) enables a large amount of functionality. It defines the
> > root of a CXL memory topology and is needed for all OS flows for CXL
> > provisioning CXL memory expanders. For ease of merging and tree
> > management add the new ACPI definition locally (drivers/cxl/acpi.h) in
> > such a way that they will not collide with the eventual arrival of the
> > definitions through the ACPICA project to their final location
> > (drivers/acpi/actbl1.h).
>
> I've just applied the ACPICA series including this change which can be
> made available as a forward-only branch in my tree, if that helps.

Yes, please, that would be my preference. When I created this patch
the concern was that a stable branch was possibly weeks away.
