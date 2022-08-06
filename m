Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6E0C19F2D
	for <linux-cxl@archiver.kernel.org>; Sat,  6 Aug 2022 16:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbiHFQvc (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 6 Aug 2022 12:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbiHFQvb (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 6 Aug 2022 12:51:31 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9170DEAB
        for <linux-cxl@vger.kernel.org>; Sat,  6 Aug 2022 09:51:29 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id u6so607412ljk.8
        for <linux-cxl@vger.kernel.org>; Sat, 06 Aug 2022 09:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=lnGqPaY2GUog4uwdnr/Yc5LiCp03/xOlV0gKZ4CC3VA=;
        b=V54OSIJK0wc+KwpvZzl2UQupuZVlchtMw6KlsvtAd7RDI4N11TDsA9e1mga53FpF/i
         uq3aENKL1b2bGmi5dhiM/v1nBvua1FU7IAcWjvkkoJqbxcC5jzHwau/JV0PZ1CpSSBeg
         QOiM82vr02XcO2OY6tpzrJSjgYUh9hr+rFkmM6w0ggYrqYvUE6TAouQiNeC0i8FEqepx
         X7z9tmjyk0bMY6RPM2BC/+0ded5Q9Ae+B843gIC3xQUB7gXj1tFazKmPT5SLg736TwPV
         Yi/dj9RUncQMVk5n8yNC0TmQPAlw5SrAl08F3mN/eZ3JhbLLn8ncZSlY1JTeFKYYMFpr
         tdIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=lnGqPaY2GUog4uwdnr/Yc5LiCp03/xOlV0gKZ4CC3VA=;
        b=bLBlfwmHW57+/or0ZzeDkFzvJAjOTR+y7FeEn4Qky7Ues6AJruZe35EsOUiRMGdZUD
         e7ut66bbkTi+YfrJa9FfxcTLUKcgNb/gSeawkWn2aOx5L98M6rOaStKyRnp45P/RjQwR
         7lKTo9Aq/fZZTV7Nm1FU8Yps9dLfIWcbxD2SzJHfGBn32UsPOcYfOaOu/DRNDbhPevfZ
         kHu/eHlhSxODfqvX/w4xHFCv5sv+1jla56IhazrcoubUWzd7xakBCdGyQZSlx3Ut53AR
         OvFzznOvzEWKfbu4KerujNMI6JxRA7YqoWZhHl47BpyzO3YSwt8Du//11ZIJ7OER48es
         KJcA==
X-Gm-Message-State: ACgBeo3MILlFT9T73A+pdw623yZmoxsEMRSwtdfDBmsphRYIJ+Wd+Rkw
        i9OhVvDIGu45/w65tITEjvoReHDiqqJIiZAxq2t0/17810U=
X-Google-Smtp-Source: AA6agR7SeruvJEd9CulvDSGOtWs4ULEWcIuxYLwRFRXmo9zgRvyIb6jLfLHUte4sD9C0XDcKXsiS8y5mqGxN6p0OZo0=
X-Received: by 2002:a2e:9807:0:b0:25e:4860:fbf0 with SMTP id
 a7-20020a2e9807000000b0025e4860fbf0mr3366437ljj.333.1659804688017; Sat, 06
 Aug 2022 09:51:28 -0700 (PDT)
MIME-Version: 1.0
From:   Chloe Alverti <xloi.alverti@gmail.com>
Date:   Sat, 6 Aug 2022 19:51:16 +0300
Message-ID: <CANpuKBMD4tWk-s3DRSvzquTVfoDMp+5X_fp90N1HDHkb4u-v7Q@mail.gmail.com>
Subject: The future of DAX in linux kernel
To:     nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi!

My name is Alverti Chloe and I am a PhD student! I have been
working/studying the past year on system support for persistent
memory.
I wanted to kindly ask you your view about DAX kernel support; will it
continue to evolve/be supported in the mainline since Optane memory
has announced to be over?
Is DAX going to be used as an interface for CXL compatible storage devices?

Thank you very much in advance!
Best Regards,
Chloe
