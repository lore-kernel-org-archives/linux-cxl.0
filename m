Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA9CC433EF
	for <linux-cxl@archiver.kernel.org>; Wed, 30 Mar 2022 03:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242255AbiC3D0y (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 29 Mar 2022 23:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242266AbiC3D0x (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 29 Mar 2022 23:26:53 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9F0120D80
        for <linux-cxl@vger.kernel.org>; Tue, 29 Mar 2022 20:25:08 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id bx24-20020a17090af49800b001c6872a9e4eso4885248pjb.5
        for <linux-cxl@vger.kernel.org>; Tue, 29 Mar 2022 20:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uA394TBIAAuw6da0vjaUA2zDkz8KAwbfgdksBWdw/dI=;
        b=kfN5pN1gkqUdQIXTgNHstKhvzHarHt/QvFTTFXeUimStBq4TITM/heVqlygg+rL22E
         huR8ctGn/4JID6Sod4Syrx166elJQNIcOGRlcZ6TiUCU/PXq/MiPhLZGNBG2wBiNgCsU
         HGUy/PWikjI/hEtzvdKRkfHSSWO4WgNLy2TUDUhNEUdCk0LqpBI4S4neczY7kjJiCrfX
         gqJhdGsbilnBQ4V5Z2bgIwyC6fn1OQkqPCXsGai20R6QNY5+2J0fuwV91na6Haf/KEFf
         LqIIK+5HxhbFIXNmKMxNJjag9jRZHUdfzGzUHERcScYl7++cxtNq1L6NgOiT7TCRKUF9
         Vm0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uA394TBIAAuw6da0vjaUA2zDkz8KAwbfgdksBWdw/dI=;
        b=i9sRtpoYFMG5/oAuu0RmYaLxoXEEQWqqJQBUeQWqlvywrxYaThcnCq9K/TD1bkrRJx
         C2o1Xg2ZCanH03Va9gkK6OXY8D1kGTYuqDoNw3UKGZONjBeB3D1kctBb63aU7LYT7rKO
         GiRg+En2TugHFFoxfkXQ/oVij5fDXf1EuKZFeciz1ef4Sd/jjNG6h7/tbgaPKgjonp4w
         +o9XyIFt8EAi21clKQ/vzkZC9vrJqZVD3nRhG3CMMUKYqcldczPbVy8RwLBDU0SCWCI0
         vA+IPXq0Swk+gdjUK3zhcgmz+XxpefqOThJcZSFhNbXOt3p8gCVnbLAMIAn2r6lOvOhW
         cO5g==
X-Gm-Message-State: AOAM533EYXo3VbByIrICnTUcybhKGA2W89YUaS5wa9tsOiZFXPKqgUaS
        QeeiX5jmyPrw+Brs6b1QkwdoKazvBoOZXBFr22RHSQ==
X-Google-Smtp-Source: ABdhPJyfZoRmkKQV0Pppi3TZm8LOGs9Ox4qCCD5SXK7JOcaZu2gKd4lrffwLaaPEdMETeSjmJaFa6cNkfBNvAIEzs3Q=
X-Received: by 2002:a17:90a:430d:b0:1bc:f340:8096 with SMTP id
 q13-20020a17090a430d00b001bcf3408096mr2541066pjg.93.1648610707723; Tue, 29
 Mar 2022 20:25:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1648601710.git.alison.schofield@intel.com> <019101a518b00407aaa19a497e8d973c364e1d12.1648601710.git.alison.schofield@intel.com>
In-Reply-To: <019101a518b00407aaa19a497e8d973c364e1d12.1648601710.git.alison.schofield@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 29 Mar 2022 20:24:57 -0700
Message-ID: <CAPcyv4ic6RjbKvcaH8+1pFXG+ppRG-fDOpZ5Z7XkAPEkWL0ZrA@mail.gmail.com>
Subject: Re: [PATCH v4 2/9] cxl/mbox: Move raw command warning to raw command validation
To:     "Schofield, Alison" <alison.schofield@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Mar 29, 2022 at 6:28 PM <alison.schofield@intel.com> wrote:
>
> From: Alison Schofield <alison.schofield@intel.com>
>
> This move serves two purposes: 1) Emit the warning in the raw
> command validation path, and 2) Remove the dependency on the
> struct cxl_mem_command in handle_mailbox_cmd_from_user() in
> preparation for a refactor of that function.
>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Looks good to me:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
