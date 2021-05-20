Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A81FC433ED
	for <linux-cxl@archiver.kernel.org>; Thu, 20 May 2021 19:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D49061355
	for <linux-cxl@archiver.kernel.org>; Thu, 20 May 2021 19:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234698AbhETTwE (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 20 May 2021 15:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233763AbhETTwD (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 20 May 2021 15:52:03 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35846C061574
        for <linux-cxl@vger.kernel.org>; Thu, 20 May 2021 12:50:42 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id b15-20020a17090a550fb029015dad75163dso5887012pji.0
        for <linux-cxl@vger.kernel.org>; Thu, 20 May 2021 12:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=np0O6j7Ps31+6ffsQlXt2UisobA9H03jHJUStu8dHEI=;
        b=Kgkyxrlo4XpPS1RVI5/C/JzJj/gpStEfY5HFZd+6Dt9WOdLIs5S6uwwmVdvYFAKUZE
         Y9mbF/4syhSPB3H/0CSUWSt+qfOR6exdIgJVWEXOsVCCldMIoF3Dy575Z4GzrcYAFI7p
         LezbyQD2d5wSpP5lMuRoaz4QHd0S7mhlvgD5vLfHKEm5+dxDp0kudoS1wdwjfFgEpgei
         cyS0YFPEof/rk+wgiyssUqvsYZx9jRJV/DJiR/vpfxVyuiYIe8URjO5tD+XZeRQ9nRji
         QATe031wEQGjHmz6NWAzKYyIT+M6j1YyU3+E82MW8L2O4+VXo750bG8T50YbUKTFEoBl
         JUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=np0O6j7Ps31+6ffsQlXt2UisobA9H03jHJUStu8dHEI=;
        b=OY/pH5BJPOEf4ViREzsB6sFYRECfuMpAm/S+NKCHxE0nRfPiFCMb5DU5l5SvMJhqOz
         mDCF5aYkxmxGJL7qchCPg3o+ofjHVM0IUarxV/stTpLc+PGPLou+aw+ULS46ttyi90rt
         oO5aOSavd4WnxD22jsUdoOqM/w/jqxZSbV2RGFAD7vbV0+LSGrdfHNHMKvCsTV8C/4tJ
         srSiKrZ7NOQUyDg7GAVOGYevAllxbGEcS+EFMB0+voAmfAQeUy4u+AI3CqMtDO0DhJ9R
         DtzChzr3Fj0d+2tYTnVJaSDbPqopYKCSYtevMdoW5JhNeGHOAeRIy5Q3yEvHlTBjJVyd
         UcGQ==
X-Gm-Message-State: AOAM530uxrpUBKXgdUESyjbjF16x9zZRxwJ5nMX5lFk+ihyX0Dpt3x/J
        Qb1wrz+iaNaZok+hNb9QQZAzcwzBolBp+5CezTIZA8CpS3A=
X-Google-Smtp-Source: ABdhPJxFjf6zGhF251uBnZLbrUIEvsZ8zQU5JOi/KOmDSvc764y4r4/Qp9X+6DkbkDDPmyIdvXkWUlrZBiIbaiCEAIo=
X-Received: by 2002:a17:902:8693:b029:eb:53f:1336 with SMTP id
 g19-20020a1709028693b02900eb053f1336mr7721487plo.52.1621540241715; Thu, 20
 May 2021 12:50:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210520194745.1095517-1-vishal.l.verma@intel.com>
In-Reply-To: <20210520194745.1095517-1-vishal.l.verma@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 20 May 2021 12:50:31 -0700
Message-ID: <CAPcyv4h0iNDHAEvfrYT3bDFAeY7K4v6VoiYRtLsbv59GZiguJw@mail.gmail.com>
Subject: Re: [PATCH] cxl/pci.c: Add a 'label_storage_size' attribute to the memdev
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, May 20, 2021 at 12:48 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> The 'Identify Device' mailbox command returns an 'lsa_size', which is
> the size of the label storage area on the device. Export it as a sysfs
> attribute so that userspace tooling to read/write the LSA can determine
> the size without having to run an 'Identify Device' on their own.
>
> Cc: Ben Widawsky <ben.widawsky@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---

Looks good to me:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
