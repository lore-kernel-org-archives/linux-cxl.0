Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DA9CE79AA
	for <linux-cxl@archiver.kernel.org>; Tue, 19 Sep 2023 16:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjISQ5a (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 19 Sep 2023 12:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjISQ5a (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 19 Sep 2023 12:57:30 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B1C8E
        for <linux-cxl@vger.kernel.org>; Tue, 19 Sep 2023 09:57:25 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-2769920fa24so907167a91.1
        for <linux-cxl@vger.kernel.org>; Tue, 19 Sep 2023 09:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695142644; x=1695747444; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nNjt24Z/4Up5z1oI7Ijl6nSXpUjUPgADeIUNGTbY+GI=;
        b=nk20upa579dLGx2o+/VJBDTXEWSVWI1YiSBT/prRaN1xm7jI6xuhvkVL0aBme/JKMg
         4Ll12M+8jtLaaG3qJqFTLlqEhMtKK0NCY85kqyMeYQ35rlnTbBpkFOK9D2vxOQZUFCLm
         wUeABip2DRT2MNUiF9syn+cYqEuguSNUnYDgxrr8om0I+mPkZ5c1MKVEc6fHZ8ZL9jS6
         BfsFOs1ipO+26eoznUPUFcmbbWMmYRcR+B4234qsGWsZiCA9E55EvMQ9JN097ZiKI41r
         XeC005niF32uOKtRgKDrjPxtGBkZBqz1mddxi2vE/CTaOLb2A2On7sS5HcKHSRGUzk2J
         aUqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695142644; x=1695747444;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nNjt24Z/4Up5z1oI7Ijl6nSXpUjUPgADeIUNGTbY+GI=;
        b=XBPEUW8Rf1LNYqb+Ds2MQ9+a1HMthfpnyDdSX7j04qZki29eT+iiBdB1HeilEubyy+
         ZvEo6ih5sSadNvDhTK+8ou9o2GcwsRjqzqY7XETRPhj9eJ1+dXuxWlwYQWlVq96jVYT9
         gpjTTk6N/v4AQUsdQnsAlnET3XWyMVHrPijyT4V8YuzHhNddY9RPCZoSkxsHBo/bzZGw
         AkUZ1+naKWJm0hUviybh2q/EP/fleL4ikuFTuNt+jPXFmggfhuLWQnixUThvjzXpJZos
         rdn2TiwclEvOwxKZchin6R2Hfx9V4j2OX+zH7gwZ51f/Gm0bRisQFdwd3oWhqEBlQse4
         3DPw==
X-Gm-Message-State: AOJu0Yyi29032FtqW6W9h6irlK8PwITP8MGZZSy8iNBZcEfV8gbin5XL
        A67ogySbh25yJ0sklyuLvPTet5GEy0+wxl7nYVdbbKCTl+Q=
X-Google-Smtp-Source: AGHT+IH5XddJ+XE4jFDPwm4TCab7WGx/dLl76FPyn9LEqZJeFAqWfU0zSEspKNjo7Hgb3z8jm2yXaekzYs1n0Jw1dlE=
X-Received: by 2002:a17:90a:cf8a:b0:273:e24e:36b9 with SMTP id
 i10-20020a17090acf8a00b00273e24e36b9mr327236pju.8.1695142643810; Tue, 19 Sep
 2023 09:57:23 -0700 (PDT)
MIME-Version: 1.0
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 19 Sep 2023 09:57:12 -0700
Message-ID: <CAHbLzkqNyGuqpcq21K9a_COgpgpbTK0LGkwE18XzdjiVbRqkKA@mail.gmail.com>
Subject: [QUESTION] Shall I set EFI_MEMORY_SP in firmware for CXL device?
To:     linux-cxl@vger.kernel.org
Cc:     Yang Shi <shy828301@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi CXL folks,

I'm trying to understand when I should set EFI_MEMORY_SP flag in
firmware for CXL device. My understanding is it should be *NOT* set if
the CXL device will be used as "System RAM", otherwise kernel will
treat it as "soft reserved".

EFI_MEMORY_SP + CONFIG_EFI_SOFT_RESERVE=n could make it work, but it
doesn't sound like the recommended way, right?

Thanks,
Yang
