Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F258C433F5
	for <linux-cxl@archiver.kernel.org>; Tue, 22 Mar 2022 17:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbiCVRzF (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 22 Mar 2022 13:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236970AbiCVRzF (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 22 Mar 2022 13:55:05 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57714BCB1
        for <linux-cxl@vger.kernel.org>; Tue, 22 Mar 2022 10:53:37 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id v4so16264293pjh.2
        for <linux-cxl@vger.kernel.org>; Tue, 22 Mar 2022 10:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3s5gDWos+PtUBLd8/ihqJugKS3ctUwBv/GPhwSs2FSg=;
        b=J0hXkgmwRkfvoxa+/cJHitTUDL4MBLzi6/4VZaaROhoGfxwHEt9opFvvnk30v5W76A
         gSPMZK0GobqR+CVlBi0YKf08GT0gASfjlWZg7jTTZCWi1tsGBEU/boiHzw6vJavQMChW
         3+mm6C1Mus9NgYXuUAHqwUeWZeQpB1++KwRAZeikitNpYgIFbzWHIXyxCh+0By7ZWy0f
         93e0UaB9SSeMHBEV5+/uOc56iHw3Yx5LKftZuTA/67kUZ8gXdr7dZGsPBFP7eH9B/3/e
         VDS5j3NfD+/us8Wi/aSwLJgSNWcWyAjy7Hpc9pFWirXCQPOdPssBmAoiGSMJITWbxPme
         7jwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3s5gDWos+PtUBLd8/ihqJugKS3ctUwBv/GPhwSs2FSg=;
        b=22A16Rz2liy3WpkZQdLbc3SYHMq2vJ1bzaMtFX3NfiPYfcuuPnU6czGHm7jp8wdRrz
         ebcZlNCUbA1Z4Om0jYapGu99lYcpEvEyCIZ3MML2NtIQ2f8dgNHnATxWmmhLBna0fjAv
         B7jYzxja+4Ouim7UFPROMZPNhflofk2RqYtrEawLydSYAQVytAiTLKfXkN9GqSLVgBxD
         jJpPO4vOd7Xj02o/jl3OrsUdMDP3KfQhX5m2nm8/GMCPnPdyS2tm1nhX4sY798vKzvR3
         kNo+0a2agCLaFmhMt37CmLTS0F0vhtKgiehXDwJfHSdCVL25qRTTTbjdaYCu9HrVv1SV
         cdIw==
X-Gm-Message-State: AOAM532IdfwB9FGCgzBPQhoYyLfjfZPUJfyY3QHk2KFLEqnE+WOHgI6a
        dXSqZa+06vCSltZE0ywTF0+BK9OmCpNxnk+pEnwWTzRW3lE=
X-Google-Smtp-Source: ABdhPJyet6bOhKvdAllqdaC/IxzQPS5NrzuBCij/+cPDNReudOSbHOq6XC8Buzc2uf6Zwfci6Gv8/fi7bvkucL9VT0s=
X-Received: by 2002:a17:902:7296:b0:14b:4bc6:e81 with SMTP id
 d22-20020a170902729600b0014b4bc60e81mr19167073pll.132.1647971616906; Tue, 22
 Mar 2022 10:53:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220307094158.404882-1-wanjiabing@vivo.com>
In-Reply-To: <20220307094158.404882-1-wanjiabing@vivo.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 22 Mar 2022 10:53:29 -0700
Message-ID: <CAPcyv4im7c47C+jrTbQC=FGgCV35ME8vuYA2-KXYRKsdEuOuuQ@mail.gmail.com>
Subject: Re: [PATCH] cxl/core/port: fix NULL but dereferenced coccicheck error
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kael_w@qq.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Mar 7, 2022 at 1:43 AM Wan Jiabing <wanjiabing@vivo.com> wrote:
>
> Fix the following coccicheck warning:
> ./drivers/cxl/core/port.c:913:21-24: ERROR: port is NULL but dereferenced.
>
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>

Thanks, applied.
