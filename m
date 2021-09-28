Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3969C433EF
	for <linux-cxl@archiver.kernel.org>; Tue, 28 Sep 2021 00:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B37B4611EF
	for <linux-cxl@archiver.kernel.org>; Tue, 28 Sep 2021 00:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238275AbhI1AUW (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 27 Sep 2021 20:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236941AbhI1AUW (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 27 Sep 2021 20:20:22 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFCBC061575
        for <linux-cxl@vger.kernel.org>; Mon, 27 Sep 2021 17:18:43 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id w14so17424843pfu.2
        for <linux-cxl@vger.kernel.org>; Mon, 27 Sep 2021 17:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HQg3yzmMlR0cDWVqRt+s3u6XqtnpAiVhWS58E0nEWg0=;
        b=hfAQ+5H3UJJe5WMUKl0csp8tR99aZvMCiKEKV3tDjcwYHPZMT7utSl6V6DivfgUmxX
         MJOG5MSrF63YW9roCXvcdBrdEMxRcEC1sevIKklBa8Cp/RDy7yKavbf2AA+v2tWfK3yb
         sFZ53DY/MW+Ud8GiBgeg7Lb0IODvflkfxptX9p9zEj27ozyn82acP2zZin6HMvhDO2CZ
         l4fOZxKFHPKkHfvOw0l79We8jn4QBaz/adLQyYtmY6KjJiAkPc9Pl7C83fx4qjeRCQd8
         QLNrD3wWFaiewbBN+i1POhQqLkY9W6Gy0jesFD9qwUyw80ks392doF6Ez2UmUS4Xz2Fu
         XTVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HQg3yzmMlR0cDWVqRt+s3u6XqtnpAiVhWS58E0nEWg0=;
        b=575NcLhh/SAzOxl5iHRr0n88+gKgXkRt5OAM5J2ZjEoyHS+2DXR+v30YgDENYHyyU5
         QEvUT+izaPwsnn8nFcYYOs26bKl460vajNVcezP9qvmr6/oVocH93ajrKqT8DBnsM3xw
         79uLJKfT/G23DrFaq0YRMJBQJHtMI4hfmfSkvXV8euPFzEnSmOSPy7POBjBzovdaOe4L
         O0H1agd//yZPxlZVR7EuBy2skAfGaaGBUxRu6OmOyGB1g8mAhoMUZyYjn1Z8GtkfXIcj
         DiH+jIvbN8/OPAnxQLe61k6olvc9vDJ6mxhTzoO6BywIgbYL7dH7U/gDn/ZEIuO9h/Gn
         XykA==
X-Gm-Message-State: AOAM530cRiciqaCeaVolkDD4+I6AE/t4tzN6J48oxPGz5PgBZWtahoxN
        +t3sZZQ76Tr29KR2GPksTi9fCh0Cve1ibNdhf1yTU0d+yWlbJQ==
X-Google-Smtp-Source: ABdhPJy47ZTrcuxV0i2AT47YY+b+fmZ6tgL/uolxNHHoY4LgZUUV2GOg+gh5Dd/CE07TQhacGbUR3wwejC4Mjq+5RNU=
X-Received: by 2002:a63:1e0e:: with SMTP id e14mr2014371pge.5.1632788323208;
 Mon, 27 Sep 2021 17:18:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210924212817.489801-1-ben.widawsky@intel.com>
 <CAPcyv4gsVCoaqX81q57XZSAOqQmdLbdruGGxBpOk59nNRn+hXg@mail.gmail.com>
 <20210927224522.gvybo3nhbgqhjbwo@intel.com> <CAPcyv4gmsmtOap8jwu7zEC6K1PCeTGSwRwEHKbBGksRERdCUnQ@mail.gmail.com>
 <20210928000605.eh5yiqdkty45z6px@intel.com>
In-Reply-To: <20210928000605.eh5yiqdkty45z6px@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 27 Sep 2021 17:18:35 -0700
Message-ID: <CAPcyv4gAJBV8Z3Xfi+R+DL6x3LXoOtHkcnsewU6Ru8YmH-bfSQ@mail.gmail.com>
Subject: Re: [RFC PATCH] cxl: switch usp to parent cxl_port
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Sep 27, 2021 at 5:06 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
[..]
> > Per-above you probably want to start the scan below each root port, or
> > otherwise filter out the top-level scan work that cxl_acpi owns.
>
> The scan will skip everything until it finds a USP or DSP which cxl_acpi
> wouldn't be touching. I don't have any issue with:
>
> >         list_for_each_entry(dport, &root_port->dports, list)
> >                 pci_walk_bus(dport->subordinate, match_uport, ctx);
>
> but I don't see any issue with the current code either. Did I miss something?

if (pdev->bus != root_bus)
    return 0;

Doesn't that always fail for the switches in question? Did I miss
where root_bus is updated?
