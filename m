Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC93C433EF
	for <linux-cxl@archiver.kernel.org>; Fri, 12 Nov 2021 21:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B168161073
	for <linux-cxl@archiver.kernel.org>; Fri, 12 Nov 2021 21:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235698AbhKLV66 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 12 Nov 2021 16:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbhKLV65 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 12 Nov 2021 16:58:57 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0C4C061766
        for <linux-cxl@vger.kernel.org>; Fri, 12 Nov 2021 13:56:06 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id b68so9570361pfg.11
        for <linux-cxl@vger.kernel.org>; Fri, 12 Nov 2021 13:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PF+Db0UtQ07kU5lBc+mvHyAIrkndth9X28SjtsBN2FU=;
        b=NWFsJ1cNnED05crH2nhDwDg9KE/4G4rZ3rmGqPP8USOGUu+SMZy5Ur1LXx0PEKElxV
         nfdapYM4U10BWU+Jw9w4/VgJ3MN1fRz4CYqSf1RUSOkn5627t44ZvIcTfqpxvhBO6//d
         lo6BIpLL0jyQ5ELRlAv7mo+mjvxHPqjj8j4xzW8/l9q7ktam1RAEesyVZQvTAyqX7Ail
         312Iq+1dqn0FnUFKwJuAzCcvPLIVBV58+HFqfQiidxaZEvgIBQFRZ2nCgGljur+Rl96z
         enuw1VAh9agdEP6w81YgqHmZjT5t/GlMVO9VjzcFe9ZwsPkLkUXJkgfbiZbql7K/lVj9
         d9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PF+Db0UtQ07kU5lBc+mvHyAIrkndth9X28SjtsBN2FU=;
        b=2MUsezFfZBvUd4ZWUh7aKuVulw6gR3WqrHh/e4e+2/Dl7iutVDu3VF7X8sgPJcfixA
         5EjXEDtHa62CbxOVg1jPras9JCIHObFqJ2McqS/iXDEUO/ZjfjVWAg69cC0dte42yn23
         CW5KYu1QKh1uTJhVuFvmPLAYqz4+0GO94aTHNYP9f3oadRfSQFbDaA3/R2nvdi72Trdx
         gRN3QKtM8skatkutUsgzvxd8nUH1PnnY/5acIut9KeCpmj2qIBGrlazNkDuIvze4Sf/s
         3G4KICvXt2qxMM46epIi0ZxsEG50uuvierM2bQLq/wp7HEUj7Wg9IU62vbOXemFOBZil
         3cXQ==
X-Gm-Message-State: AOAM533B+wML94EEOO+9+AE/RHRap8tYPhve4/H07FO2nb4gzVfuHjes
        mnXbu4ncQZfQc/Nruwb6Ubgj5vR/r9GlPRBTti9OeA==
X-Google-Smtp-Source: ABdhPJwyFEuWJkyEb/ZMBQPQv1yoWJGWauAD6tOdiPAxiHJjmDtKMcqoMWcJc7toKxRWEaqhGl0IRUGpvGcQ6AIoMl0=
X-Received: by 2002:a63:584e:: with SMTP id i14mr7003745pgm.356.1636754166029;
 Fri, 12 Nov 2021 13:56:06 -0800 (PST)
MIME-Version: 1.0
References: <20211111204436.1560365-17-vishal.l.verma@intel.com> <20211112215245.1887356-1-vishal.l.verma@intel.com>
In-Reply-To: <20211112215245.1887356-1-vishal.l.verma@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 12 Nov 2021 13:55:54 -0800
Message-ID: <CAPcyv4iROggvmHV-AqagQ6uMoYOuBs=OZ0mv0eYa3-2H+VYODA@mail.gmail.com>
Subject: Re: [ndctl PATCH v6 16/16] cxl: add health information to cxl-list
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Nov 12, 2021 at 1:52 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> Add JSON output for fields from the 'GET_HEALTH_INFO' mailbox command
> to memory device listings.
>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>

Looks good,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
