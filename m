Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD92C433EF
	for <linux-cxl@archiver.kernel.org>; Thu, 31 Mar 2022 22:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235779AbiCaWNE (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 31 Mar 2022 18:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242367AbiCaWM7 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 31 Mar 2022 18:12:59 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CD713E84
        for <linux-cxl@vger.kernel.org>; Thu, 31 Mar 2022 15:11:12 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id mp6-20020a17090b190600b001c6841b8a52so3576350pjb.5
        for <linux-cxl@vger.kernel.org>; Thu, 31 Mar 2022 15:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UIsuc+VMrZHjV/gOA9v1R2HCzMsCz3sjByLBSEfd/Uc=;
        b=tgiL3tXTR9ihSeeAQ77WFZQdby6+cj2zSm0bAwWlNestnU/wzjP0fHHqQiVD/lx9uZ
         oazGqpKExTg9esgDfG7V7VV1bqXJF2Qx+E/EGTbzjGlirTic0Ec2z1PSsgp7A2BZguGN
         z/HKhL1ZLc/U4f+0jvugj88tDtpXo/jXtDshuX7kThVbPgpzIC+UWkZchp9CtwjofstO
         o4pHtbr0X8I0Ps1sOhz9efmf3gsHGVROmHXYzMIBCkRpLlM/hvJCTQhbtBCi4pTjXQfn
         kPbsfY4WscCTZOVMzZvuHDCI5Yk0t2dAu5nCxQMVwkUoFVutZR9LP4e7yQoEw45vGiOY
         Bmqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UIsuc+VMrZHjV/gOA9v1R2HCzMsCz3sjByLBSEfd/Uc=;
        b=B5FU/WuorcSLF9br15ISQjSzzeOQgI6yxmGnER33H9t24MPQn37L2BJnIA3XBBjfwN
         ho30pwQpGfRCnjqf/9XU9OOPMIAyzaIEOvIkG/N56oGUa1D+SwJi2pHLcGxfKdDtSfwF
         P+Ko5WtvM5tipIRmDHJGWNF5kYrVuYtyFHSp8aqaxe0BTBB7YHtsaptIKe16YsJpupv/
         eaTJjewiBK94vqPCKJR99xcZTS4dDdaka4BIRnnTYYC4VSrS1u+myzLiWShLsEF+wMz6
         Z5GzAfTDx+pLH19lD5XFZ8KljMOOI6jXX4YPJGT7H/yzGUWv66qLpN9wNvnBptZ4KxWk
         nUkw==
X-Gm-Message-State: AOAM531scy5B6afmhwu4ogeMwaTN2g5ZmUt5GFJau3oezj+5QDKZW+0D
        DeZrFtC7FVislloxKemHwen1OgwyrB/ttbf/mkoyLXGXe8A=
X-Google-Smtp-Source: ABdhPJwifYZ/2DqepvKxV1o7z9C7klqh/ent7cWqhjxqtZg1SDVL/MO8j/9K81DJGTIgg8Mq1arMqXqxzq+uv9nBmv0=
X-Received: by 2002:a17:903:32c7:b0:154:4156:f384 with SMTP id
 i7-20020a17090332c700b001544156f384mr7434787plr.34.1648764671670; Thu, 31 Mar
 2022 15:11:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1648687552.git.alison.schofield@intel.com> <241821186c363833980adbc389e2c547bc5a6395.1648687552.git.alison.schofield@intel.com>
In-Reply-To: <241821186c363833980adbc389e2c547bc5a6395.1648687552.git.alison.schofield@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 31 Mar 2022 15:11:00 -0700
Message-ID: <CAPcyv4ifPKhyh-8SUjNW22KRARj43KOdX8r6sFHbpcZRSLCNug@mail.gmail.com>
Subject: Re: [PATCH v5 8/9] cxl/mbox: Block immediate mode in
 SET_PARTITION_INFO command
To:     "Schofield, Alison" <alison.schofield@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Mar 30, 2022 at 6:25 PM <alison.schofield@intel.com> wrote:
>
> From: Alison Schofield <alison.schofield@intel.com>
>
> User space may send the SET_PARTITION_INFO mailbox command using
> the IOCTL interface. Inspect the input payload and fail if the
> immediate flag is set.
>
> This is the first instance of the driver inspecting an input payload
> from user space. Assume there will be more such cases and implement
> with an extensible helper.
>
> In order for the kernel to react to an immediate partition change it
> needs to assert that the change will not affect any active decode. At
> a minimum this requires validating that the device is using HDM
> decoders instead of the CXL DVSEC for decode, and that none of the
> active HDM decoders are affected by the partition change. For now,
> just fail until that support arrives.
>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Looks good,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
