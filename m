Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF39C433EF
	for <linux-cxl@archiver.kernel.org>; Thu, 28 Apr 2022 17:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346366AbiD1REu (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 28 Apr 2022 13:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234392AbiD1REu (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 28 Apr 2022 13:04:50 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4D6140F4
        for <linux-cxl@vger.kernel.org>; Thu, 28 Apr 2022 10:01:35 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id w17-20020a17090a529100b001db302efed6so3423041pjh.4
        for <linux-cxl@vger.kernel.org>; Thu, 28 Apr 2022 10:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gd/K8krvAPWi+okSoX/WeDwibwWuKSE8ydN/JkjTURI=;
        b=OvTWc97Vl2/X989/qmHj1LCifD5rUP4LJjqZBVrRuI1AsqYhkhlEB1geozCpRCm6Gw
         QxTe5QKRM9vKVDOi011Bqgn6dOPIvat6fgumHTXCf7HePnbq2IPRqALDc7IXr5vW8g4Q
         DCN6yuVdckjPOXyayazIP5kD/p3j5V/gz2CLs7CUJM0rwkWKYkTspbFD5wh3NzmAAIrL
         6ZXfGV1s04MCGjfGyxSGIEL0HYWdbtymTeb1Vm4eXe5GMJFVBwOVYXInZgbcDszkgNkm
         APR/MsD6QSDepyYDVcnFhh70Syz1s4Ax5xoNWlhvFHY4U/+Vsyzt3XV8JEzLo1fOf1hY
         l/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gd/K8krvAPWi+okSoX/WeDwibwWuKSE8ydN/JkjTURI=;
        b=GHvqn5icujm2KI7SW0eORQMZn54/1nVsC9ECVnzgD8BWD+4F6AOvDeGn/Dfk3pTFpB
         s34HTtPk4i6n38eTXZehWOr0qVMma/q6kqIcMF46SzsZcHKTOUKMdlho13BDhgLbhy5e
         ibY2LzoBH3HWco5iSj1GNBC4n8EdXGHeqX57wyGqJQ13hWzue0yARYn40ld9nc/7lZyM
         kLgECzgRPWT1kRBa8n66t7ZrrZXx2VOKbdy8IwTuwhgBM3pEkGnFiB5ouX/Uk/T6MzZV
         D8y+AbTAXBWzpr5Gl9gCGhN+mvdF0MUKiA/AuT7n2jN0aBAHpY7pugc6CiLX4XQQFAbh
         8foA==
X-Gm-Message-State: AOAM530xmYV/NEMNrMiFAZVhqRmcTqkqQtxGYdoYI9B+jS1Y9XjPELoV
        xmDC3478uWQl2Kls6elHT7zPOzxc334q9uXAlcwX7A==
X-Google-Smtp-Source: ABdhPJxt1svQqZ32Cf8qWatX7K19f42NNGX4e8sgGGqAaq5SDAYTQxtJLoUkESIYZI7fZnFmEnstvucVm6i91gziJZo=
X-Received: by 2002:a17:90b:4b01:b0:1d2:abf5:c83f with SMTP id
 lx1-20020a17090b4b0100b001d2abf5c83fmr39123940pjb.93.1651165295046; Thu, 28
 Apr 2022 10:01:35 -0700 (PDT)
MIME-Version: 1.0
References: <YmpgkbbQ1Yxu36uO@kili>
In-Reply-To: <YmpgkbbQ1Yxu36uO@kili>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 28 Apr 2022 10:01:24 -0700
Message-ID: <CAPcyv4h6JNM9cnkdTK-kax-3agWgziN+AEAU7mqZ+=SEWzHjMQ@mail.gmail.com>
Subject: Re: [PATCH] cxl/mbox: fix logical vs bitwise typo
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Apr 28, 2022 at 2:39 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> This should be bitwise & instead of &&.
>
> Fixes: 6179045ccc0c ("cxl/mbox: Block immediate mode in SET_PARTITION_INFO command")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks Dan, good find.
