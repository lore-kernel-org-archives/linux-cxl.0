Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6385EC433F5
	for <linux-cxl@archiver.kernel.org>; Thu, 31 Mar 2022 22:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240560AbiCaWPM (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 31 Mar 2022 18:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239969AbiCaWPL (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 31 Mar 2022 18:15:11 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB63723BE7
        for <linux-cxl@vger.kernel.org>; Thu, 31 Mar 2022 15:13:21 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id c2so843561pga.10
        for <linux-cxl@vger.kernel.org>; Thu, 31 Mar 2022 15:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HAkzSKoARw4W5M/05NnpNlTsJ4UBBzdHLgF+g5O6UAo=;
        b=EXSn3zoZI8olPRavCT/LSZVZ6orIPv388AT6wbsdV51NVsFE2SfQXWwHd+lQzi/g1M
         VS+7Cz0gX8rVOE0H1dXJzMp3Cm2T9Jkcp1qSti9Ddd5S4J+2gCo/xETA9upDs3+ermPn
         V2ZNLUNnhwg9kzAcgKxWK3oGWXg50bUbRbwj9Xt5ezg5ouKdRLin/A1miPH0G17DJoKL
         HsgfYCg8M4WqgBekNPcf4pmRoZXdmu4Ss0WYtf+IPjinJPzMf5MBAK5c/cFWkwco32R+
         V5fsZGoMxj1YhqpdG9qWklZlEop4JbmK8SXh+pYc1jU9YrnOXf2HforAwqFfBoKslmqj
         4XNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HAkzSKoARw4W5M/05NnpNlTsJ4UBBzdHLgF+g5O6UAo=;
        b=W8bHAqbkDufn0mKfghr1/ibEn8THFzYAFv/DBASaChHdtWd+eytBO3RpOUIwpdp2p4
         Oz0L4sZRZRw4zFplFWSS6J1w70FjM4vi82RlK7rMppKac69/wXdipBmsU6FTyJt1O2Gk
         O+pIrZCuyiKtogpBeOrlcK6E8h3uPjb0GP/2Dd4JXbufPPV8A0u3wAoyBem2Kdu76mi5
         UmKjusevilsWRFiBrPXfFmzq24orAcYbK3yGLD/MOrR6IXctJomGOSpbOiK9m+Atw6aK
         RSfBPuTWxCR2YCwumyWSuFtci2onw64zoGTwcubdZlMf3Vq03Ab//zcBh3uM9E4G80pL
         0zxg==
X-Gm-Message-State: AOAM530q/sKywvT4DXwtanMRG6O+TslbEEN6RTRo3TNwbir4nBdzyFX8
        3ErL+3P4Ba0uv6/5wmUXaKTjPnVA3hD7Mn35TOeyQg==
X-Google-Smtp-Source: ABdhPJwhLsWtaUaXS8vjL/8jeKhh8cxahxLQUHJLPWidWGvCwyLes9giGrnbTcfOKbqxZ2UP/fxZnwM++na7Cw/YyCY=
X-Received: by 2002:a05:6a00:8ca:b0:4e0:2ed3:5630 with SMTP id
 s10-20020a056a0008ca00b004e02ed35630mr7698974pfu.3.1648764801270; Thu, 31 Mar
 2022 15:13:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1648687552.git.alison.schofield@intel.com> <accc6abc878f0662093b81490a1a052f2ff6f06e.1648687552.git.alison.schofield@intel.com>
In-Reply-To: <accc6abc878f0662093b81490a1a052f2ff6f06e.1648687552.git.alison.schofield@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 31 Mar 2022 15:13:10 -0700
Message-ID: <CAPcyv4gH12RTSxjHL3RYszHw+ofJupkv8q5AvBADFC+Dtf=qxQ@mail.gmail.com>
Subject: Re: [PATCH v5 9/9] cxl/pmem: Remove CXL SET_PARTITION_INFO from
 exclusive_cmds list
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
> With SET_PARTITION_INFO on the exclusive_cmds list for the CXL_PMEM
> driver, userspace cannot execute a set-partition command without
> first unbinding the pmem driver from the device.
>
> When userspace requests a partition change to take effect on the
> next reboot this unbind requirement is unnecessarily restrictive.
> The driver does not need to enforce an unbind because partitions
> will not change until the next reboot. Of course, userspace still
> needs to be aware that changing the size of persistent capacity
> on the next reboot will result in the loss of data stored. That
> can happen regardless of whether it is presently bound at the time
> of issuing the set-partition command.
>
> When userspace requests a partition change to take effect immediately,
> restrictions are needed. The CXL_MEM driver currently blocks the usage
> of immediate mode, making the presence of SET_PARTITION_INFO, in this
> exclusive commands list, redundant.
>
> In the future, when the CXL_MEM driver adds support for immediate
> changes to device partitions it will ensure that the partition change
> will not affect any active decode. That means the work will not fall
> right back here, onto the CXL_PMEM driver.
>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Looks good.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
