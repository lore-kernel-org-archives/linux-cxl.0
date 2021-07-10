Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1F1C07E99
	for <linux-cxl@archiver.kernel.org>; Sat, 10 Jul 2021 01:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84133613C7
	for <linux-cxl@archiver.kernel.org>; Sat, 10 Jul 2021 01:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbhGJBQf (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 9 Jul 2021 21:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbhGJBQf (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 9 Jul 2021 21:16:35 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6AEFC0613DD
        for <linux-cxl@vger.kernel.org>; Fri,  9 Jul 2021 18:13:50 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id b12so3000206plh.10
        for <linux-cxl@vger.kernel.org>; Fri, 09 Jul 2021 18:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E+bsZUEt7jEa9VtBVO5r71NpsmIkbIckeAP5aRj4V0k=;
        b=aoq5VFBqxzjGvZusosc0RibzR+/NCluyJa3/Dauw7DairhXuPjq0/GiVThRhYcAYYd
         RjLunKQTiB9zhcduUAOgKScNYC0mj05Ih+JRM00F0/4gJSokpW/RsoR56Or0EDFW/bjc
         o8zCJqYSjDHAp3xmf15BBKXXpnZxe8cLMiasQLwcCUQ6fygn+bVPx4YlaEygKgjQ6gme
         39rAuSWLhBGXOfxqSAvMcFzDExmeIGqdkQuGVH3e/07vVHnPjvnV4rS0M77/xLTgjJOk
         GUC4aRWRAH2Q0c1VEVlVhu1Gy4QiBgIEkd3TRB3prO614aLPlYgXMmAdWVjGrIj6ohiQ
         40og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E+bsZUEt7jEa9VtBVO5r71NpsmIkbIckeAP5aRj4V0k=;
        b=oOl7eQAa/pHQnOt2Iv40fbgYEPvEnNOxRMObBOfJrOQYvnTTjllDi7pPOi06oMsvd8
         7N28XGkifO0ZmUGGKDftw9WgzJ2fM7wfWnQEPOpOA+hPXyW1E+SxPADi0LZDYQ9Zb6wX
         PA6gaa1bUJGGyU1PIjxPF/kMZ2T6w9dSbhgkXXqA9WcIlAXpQobSBLM6NK7HMWGGx53V
         u3UR9cdtvMLKYvfyzikG77UCVSm30qcJwVffUyUtFcNga3bGUp3iqGNkNaSoyywROmP+
         +uV7vf2esgVfGqvmKJCpBowVZqJpZWJ3971LjiVGM9tFMzufu2ivavZK90PuKK9DfH7o
         cbnA==
X-Gm-Message-State: AOAM531yfV6snnLTdhDpEyXxokB3Ja8NELaI0CGAUILTXLwcL1m1Lh0x
        eALpaFlurX8HTv82TNwFPWOaGlVYjxV7mMlJa7WxrQ==
X-Google-Smtp-Source: ABdhPJw1Pt6X98jWmZ/S4RIkiLdddwL4sIFzXkwHlVH7NCkUn8L9QeVbvkjXOUp7tp7a7ErbNdC2Zu52Q2oYWYOnenk=
X-Received: by 2002:a17:902:6bc7:b029:129:20c4:1c33 with SMTP id
 m7-20020a1709026bc7b029012920c41c33mr33330183plt.52.1625879629987; Fri, 09
 Jul 2021 18:13:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210701201005.3065299-1-vishal.l.verma@intel.com> <20210701201005.3065299-4-vishal.l.verma@intel.com>
In-Reply-To: <20210701201005.3065299-4-vishal.l.verma@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 9 Jul 2021 18:13:39 -0700
Message-ID: <CAPcyv4gsABLaFD0gvQBDjmn2qszXZsMy4GXH-BciUyBBAPEn2Q@mail.gmail.com>
Subject: Re: [ndctl PATCH v3 03/21] cxl: add a local copy of the cxl_mem UAPI header
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     Linux NVDIMM <nvdimm@lists.linux.dev>, linux-cxl@vger.kernel.org,
        Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Jul 1, 2021 at 1:10 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> While CXL functionality is under development, it is useful to have a
> local copy of the UAPI header for cxl_mem definitions. This allows
> building cxl and libcxl on systems where the appropriate kernel headers
> are not installed in the usual locations.
>
> Cc: Ben Widawsky <ben.widawsky@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>

Looks good,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
