Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095D9C433EF
	for <linux-cxl@archiver.kernel.org>; Thu, 14 Oct 2021 02:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E199A61152
	for <linux-cxl@archiver.kernel.org>; Thu, 14 Oct 2021 02:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbhJNCmz (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 13 Oct 2021 22:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbhJNCmy (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 13 Oct 2021 22:42:54 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9759C061570
        for <linux-cxl@vger.kernel.org>; Wed, 13 Oct 2021 19:40:50 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id oa12-20020a17090b1bcc00b0019f715462a8so3703225pjb.3
        for <linux-cxl@vger.kernel.org>; Wed, 13 Oct 2021 19:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nb+jCdt1cxdmo1MN1mk7LJYJedlQCBtaKMOVlSOlQEY=;
        b=IDftfOhcW1/zTJ6JjXqN23CPVG9owXVSaWWhhL+uEfJWbdnoRuQV1CHuCEal6bVFXu
         3O0Ogc2F/D57OAgm++rfZzZTtyco0i6PcDZfSVlTlmx7AZer+YMnxLuO2GWBVmZ5d5Yt
         Jy9GtAMV3scDbek5Jtfeu1dr71DUf6P4X89dAujuuL70RmQzIhNnIwksEO5X5pmLCrmb
         LynIhDNH7wUdoMx1Ts4d+TUqTZi2ZzebidofM2TOonuvmAPaux7U2yYASApHmVmwKvND
         58fOoUqI9rA696kFNx3Fe0hSxNiRWmkvSoDeuMmC97QgGS7fMKPXmJ4n80ztQp0d2FdE
         vSKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nb+jCdt1cxdmo1MN1mk7LJYJedlQCBtaKMOVlSOlQEY=;
        b=fpkF2ftDahev1BLXdhq+XSxuQeP2akm0xa++Q+uvpcFqOcgapgc+xK9N9sqRGyvu1/
         GKjSTjuY5+JPB6o02w6wgrwuc8J8QqRN7Y7ciXEpLrt9iIf2G/GzWnm0FokysCYrdPTA
         i0YnaFWN6ffYlkA7r3Wi31wRut1f3uPG3feC3lkaI6B/MVQO0rxlLnhF8uKtccW1hiPr
         mcLWEQD/tzruJ79te8FXwmtEww6VY0M/NAYCsA6G2kFtDJfU/32+iXAiximHm8jo0eRS
         WVOG6wgTSeG8E6IPavZqxe0r+JOFP+dn32wNvIdOLCN6qw2FhGl0FNIcrTtwNNvz+82q
         5Q2Q==
X-Gm-Message-State: AOAM530NHSzrc8JTs2DLrEdLhp75TMrpVWodHjdwfN/8Oh+bCVCavQSq
        MKcEWp62L8gzrLcvXbAamf1rauT+OpxOeR/zmEw0qI18WwyTmw==
X-Google-Smtp-Source: ABdhPJzwO8boQJc+ST6VAWBcIOMUEsww+JngjT3FXpsRAvz/oQSuwQHUk2pAdSoGFRiRjx0ZtMmik3MXoHEpPI8op9A=
X-Received: by 2002:a17:90b:350f:: with SMTP id ls15mr3416080pjb.220.1634179250293;
 Wed, 13 Oct 2021 19:40:50 -0700 (PDT)
MIME-Version: 1.0
References: <20211007082139.3088615-1-vishal.l.verma@intel.com> <20211007082139.3088615-5-vishal.l.verma@intel.com>
In-Reply-To: <20211007082139.3088615-5-vishal.l.verma@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 13 Oct 2021 19:40:39 -0700
Message-ID: <CAPcyv4gYeS_1fTJ2bnUFx3vEuGUyW5qdLcndwdV3Z1=vgahf7A@mail.gmail.com>
Subject: Re: [ndctl PATCH v4 04/17] util: add the struct_size() helper from
 the kernel
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Oct 7, 2021 at 1:22 AM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> Add struct_size() from include/linux/overflow.h which calculates the
> size of a struct with a trailing variable length array.
>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>

Looks good,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
