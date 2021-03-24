Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCC1C433E0
	for <linux-cxl@archiver.kernel.org>; Wed, 24 Mar 2021 18:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 586D161A0A
	for <linux-cxl@archiver.kernel.org>; Wed, 24 Mar 2021 18:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237741AbhCXSzn (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 24 Mar 2021 14:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbhCXSzM (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 24 Mar 2021 14:55:12 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5217C061763
        for <linux-cxl@vger.kernel.org>; Wed, 24 Mar 2021 11:55:11 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id jy13so34616103ejc.2
        for <linux-cxl@vger.kernel.org>; Wed, 24 Mar 2021 11:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=USTLtYBddABHrCkfh8cUV6zNpEAW0Ov01BpHFOTxbnQ=;
        b=w3abrHi+NxbMHphiQvyDtmRcFsDLtW5AQyYp20f3KJPpuwYsWX3fJsqfzMzYnMhH/R
         Fk30eR/4s0H8kaLLhRboOVth2XKChSMtBFt667SxwIvELjtVW1NdYqcPLcTXbDirW9su
         VV5Gdz9dQvlcw8JGpg5hiBoXgZz1a9odf4hgkD68ghazH32AXiLvt4ELIilfjsFwxh7o
         uRQv+KhH8FGKU5sEUSsj5ov2iRnQYKS8tLSWz24eQEl7hShVRBabZRvsmbULUdUQ79p3
         ETSLU+2C06bf+9iXAM9KoAFTxuBVHwyAZXeVzhfindb0zDHb6bg2iAUnxX15PsTyx+ET
         Yqdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=USTLtYBddABHrCkfh8cUV6zNpEAW0Ov01BpHFOTxbnQ=;
        b=r1LJAfW/sX0SnTO/nQOvPsBMkHFUMwLs0rN3c7F918IfOVadZN35raQfHSTtUHqfC6
         7EQ+31nSEkoZdcax3LzUEXyPHIWiqqg6sCbAEegC42T7YJbsTt67rCEKLDPbNj+aUltp
         xQX9EgRzuakCne0Frpy5v/vD/iXD2h2lcYTbBw3WoD87XjqL8qDVt9UKTiwD6u89mmaG
         i04HItC0MfcaQl2I1q1uhmLJvbvVtV2pJ5uN+R23EaYUadQW1msZdhNVyNKKNLLcGLep
         7V3Ol4UFum/650OS3Xhe+1CEuHmnU2iNTbFIxj9twtHrvBLF5LjAWN+FUpA4FfdtkKVl
         P3IA==
X-Gm-Message-State: AOAM533MdK5BmuFKsxmXf8UqjlP/Qs4724xf55LB8fMtWdLjRBuE9dA2
        InYB0jIY2XO2ZtIQAVU9ZhDoGQdYIo86DxXnuqfztg==
X-Google-Smtp-Source: ABdhPJw3o8Ig8Vtss2skp4YnpH1ywJ3FAhDAcKSwnmAXfzy6tPPsWUk2gtGLflW/kkKv9ppaUegpuDoH2a4TfjQRgBI=
X-Received: by 2002:a17:906:2bc3:: with SMTP id n3mr5381135ejg.418.1616612110562;
 Wed, 24 Mar 2021 11:55:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210324141635.22335-1-rrichter@amd.com>
In-Reply-To: <20210324141635.22335-1-rrichter@amd.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 24 Mar 2021 11:54:59 -0700
Message-ID: <CAPcyv4gQzTZHX+fO45V+U4onhOA-H-U6E+GeqySdxHvNcqYeUg@mail.gmail.com>
Subject: Re: [PATCH] cxl/mem: Force array size of mem_commands[] to CXL_MEM_COMMAND_ID_MAX
To:     Robert Richter <rrichter@amd.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Mar 24, 2021 at 7:17 AM Robert Richter <rrichter@amd.com> wrote:
>
> Typically the mem_commands[] array is in sync with 'enum { CXL_CMDS }'.
> Current code works well.
>
> However, the array size of mem_commands[] may not strictly be the same
> as CXL_MEM_COMMAND_ID_MAX. E.g. if a new CXL_CMD() is added that is
> guarded by #ifdefs, the array could be shorter. This could lead then
> further to an out-of-bounds array access in cxl_validate_cmd_from_user().

Good catch.

>
> Fix this by forcing the array size to CXL_MEM_COMMAND_ID_MAX. This
> also adds range checks for array items in mem_commands[] at compile
> time.
>
> Signed-off-by: Robert Richter <rrichter@amd.com>

Thanks, applied.
