Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE2CC4332F
	for <linux-cxl@archiver.kernel.org>; Thu, 31 Mar 2022 22:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242275AbiCaWKj (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 31 Mar 2022 18:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbiCaWKi (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 31 Mar 2022 18:10:38 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B23F48387
        for <linux-cxl@vger.kernel.org>; Thu, 31 Mar 2022 15:08:47 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id bc27so860012pgb.4
        for <linux-cxl@vger.kernel.org>; Thu, 31 Mar 2022 15:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v/sdpW7qXHc4gYX5S3gfEHzNo+DBGIbe6+uXEbphsWI=;
        b=wbE3kciIY8l20WyG4JxHUDQ3Pxc+zRTVZuzjdqf/W64LeL639hQ9eGREWxK5GWA9xY
         5TI2mA2IbNBUTOBGgR/8uYr24AiUIcU6SFgrWJpmVS3+brs7TFZGj3aVO4QqENs8DBH9
         vXTco8ki+xtDQYk2+M4UTtgEHIYsFYs6u/iw79H594qV/9wXWu6cCoKyQzFCCS0uzGK6
         Ca0IxEe3DLj1KYDSx8JclWWg3bdAEyx6PAebV+hrvg6W38oHI8F29HTIKARjiOYo4t3s
         zAjlNo7VyNjIq6NxZ8iQhl+V6JUqf6EnyEzxZoNgwoaNK9XVRK7YAN5X8VJxlqM/Z6Mf
         17tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v/sdpW7qXHc4gYX5S3gfEHzNo+DBGIbe6+uXEbphsWI=;
        b=H+SMOxrC9SIc2XQnF6NUx13ipVXpVGXN980e3740mDc56WPC+uVx4vaerR2/nDBHSF
         43XLxEyqmYJgbIwl5URFbr2DyHP+xVFlMYJRx+8/w/nZwXO+fxQSFJHXg4lKJMSZJBEg
         B6mLs626KRBEBocjkGVPrL9FS0owYOety36meBdldAapgJgIWC+g3wpXJyHDq2l4BT7j
         arhR/6yuRxEU9uCYFxy069LvFM1dy94PVo3BkKjPMS2/HQi1BBolnXj22Kk9YhA1404K
         0Rd6MU7xe0NXVjK7IpAFN5RzXpebkrTkbLFSS+F2c2gsgHTgVxzQjFLAtD0LKxrVvm5F
         wOnw==
X-Gm-Message-State: AOAM530CQNXAGXKPJjd0KpPIE0mVaHavkhss1SE5qJ1ISF2fZBz2Qq1U
        qtfQ56BT/TQsfXhYc9bxVuWVKU86votK3F+RTtBfiQ==
X-Google-Smtp-Source: ABdhPJzLkuJ4n8Z5RYLJdHS/KL7nOj+f/qzemXToZQqMyokxuwyNROFyTATQrB2WpxZlQECZMvnOhW2lqYcV3lraTfU=
X-Received: by 2002:a05:6a00:8ca:b0:4e0:2ed3:5630 with SMTP id
 s10-20020a056a0008ca00b004e02ed35630mr7683995pfu.3.1648764526740; Thu, 31 Mar
 2022 15:08:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1648687552.git.alison.schofield@intel.com> <c11a437896d914daf36f5ac8ec62f999c5ec2da7.1648687552.git.alison.schofield@intel.com>
In-Reply-To: <c11a437896d914daf36f5ac8ec62f999c5ec2da7.1648687552.git.alison.schofield@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 31 Mar 2022 15:08:36 -0700
Message-ID: <CAPcyv4gSVdfO-DKTT+f71t4R4C-8Ppnif=tH5OKq-GT7ukcWjA@mail.gmail.com>
Subject: Re: [PATCH v5 7/9] cxl/mbox: Move cxl_mem_command param to a local variable
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
> cxl_validate_command_from_user() is now the single point of validation
> for mailbox commands coming from user space. Previously, it returned a
> a cxl_mem_command, but that was not sufficient when validation of the
> actual mailbox command became a requirement. Now, it returns a fully
> validated cxl_mbox_cmd.
>
> Remove the extraneous cxl_mem_command parameter. Define and use a
> local version only.
>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Looks good,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
