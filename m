Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BCBC433EF
	for <linux-cxl@archiver.kernel.org>; Thu, 27 Jan 2022 22:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236300AbiA0WqF (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 27 Jan 2022 17:46:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232505AbiA0WqF (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 27 Jan 2022 17:46:05 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF6CC061714
        for <linux-cxl@vger.kernel.org>; Thu, 27 Jan 2022 14:46:04 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id 128so4284522pfe.12
        for <linux-cxl@vger.kernel.org>; Thu, 27 Jan 2022 14:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5baFyXldvQMErFU+/ifbyciqTBCmZNJDFU4jFRID7Sc=;
        b=jc5NcQe5YZDoJ8NVYCY0XyYexoxkcBDTwpQPjuG/lEMLr+zJUaq5FPhRACD01OV9Wv
         XR2Xp6NMg3zfcFPeg8cMdfUuiSigVhuUYet7Ll4ht3A5gt1I35lrOqr/ye/dkOWugt+G
         GeymfKAWdOf8t1KPcYXfR3t5se1bo8I//nmwZACwmcE8RMSdWoK7HXphWji4JR2pigtE
         Rau+TBN4vRoRG2HFz6EmhS2gZJLyoV05tVA5Rl2P4rTCPW0VqZdeX5hyOO0Ma5FX9/sD
         PsuqJD3j+xCvzM8F+ikQ8eN4Bm/SX6A0a0PXgLB+aDFLV1nBmzLr++HnOevLY/NLNQME
         UNvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5baFyXldvQMErFU+/ifbyciqTBCmZNJDFU4jFRID7Sc=;
        b=ghF1cS/6syXS8zexAvyxj7G6nMyTTCkIMzQj5EkwIMMJISuyJxnmYhQwE76Xs5Cx2b
         22upg9NOSrbCE5zbaBrHYuFYHrnQEqTCvJWw9dVOIXL7dJLkzKPgEBhEjGwzU+QpWBVC
         p/LCEJ1rsZNFLpeiHd9xXfo0OJuUSGK3wfLMt0NmgUyA1o3cKlRnpkOAUOoBxOeeYKCB
         +HfdcL14ZdyG9G9BMHzL01yGC9QokuzQE9TjgMq5ZVoJ0lbZNsjxsS126SavUj5hyknN
         bg8GoRZ0lx51Jtsj1cXK2RLhjwuVOaPxw7m1OeF6mo47GmC6rCV3gqKhy8zygUasKzSh
         zSeg==
X-Gm-Message-State: AOAM530QQKgTaQ3Kl3It0F9ihyMeY7nv9IJ2tJpFnwY3h7Lha2AcOx8E
        pwEBonSerGJwdIj/q2CtUhnY4JI8qkFj2EhjE1meiH0tZWqZnA==
X-Google-Smtp-Source: ABdhPJzEmxxk1ppI610r8vxQ20er+wXH07RAWUU25vYVKbXyfrMjJazNJ+F9r1YtkkAP1AtheniX47agrsCbnenki90=
X-Received: by 2002:a63:550f:: with SMTP id j15mr4335426pgb.40.1643323564338;
 Thu, 27 Jan 2022 14:46:04 -0800 (PST)
MIME-Version: 1.0
References: <20220127212911.127741-1-ben.widawsky@intel.com> <20220127212911.127741-3-ben.widawsky@intel.com>
In-Reply-To: <20220127212911.127741-3-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 27 Jan 2022 14:45:53 -0800
Message-ID: <CAPcyv4irOFTkrtAai7SLK1pdKNceQv83JrVoh5P5Px5xC5t3WQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] cxl/core: Add more decoder attributes to sysfs
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, patches@lists.linux.dev,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Jan 27, 2022 at 1:29 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> The decoder attributes are consumed by userspace in order to program and
> verify the CXL topology.
>
> An example of the new attributes is with x1 and 8192 granularity:
> archlinux ~ # cat /sys/bus/cxl/devices/decoder0.0/interleave_{ways,granularity}
> 1
> 8192
>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  drivers/cxl/core/port.c | 21 +++++++++++++++++++++

Looks good, just missing the update to Documentation/ABI/testing/sysfs-bus-cxl
