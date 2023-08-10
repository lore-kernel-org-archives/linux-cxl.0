Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E38C001B0
	for <linux-cxl@archiver.kernel.org>; Thu, 10 Aug 2023 16:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbjHJQMZ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 10 Aug 2023 12:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbjHJQMZ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 10 Aug 2023 12:12:25 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4DAC270E
        for <linux-cxl@vger.kernel.org>; Thu, 10 Aug 2023 09:12:24 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fe45da0a89so2584708e87.1
        for <linux-cxl@vger.kernel.org>; Thu, 10 Aug 2023 09:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691683943; x=1692288743;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PIWo1jE6PSmoM/dv42Zbv4IihGAAtAl+uxyHEAdsHvQ=;
        b=TTmfaqRSMTKd50BgoaKB4aAZaXUG1RJL6PXQQOeIG1zEn51jSOUL8nX457EyXMFmSI
         KCQp0hOTWPh5YuOUAGILXkq2RMM59yRH56vxwNgRtfAcT9Yij1PH7rZLrH1ofyBE6slF
         kdX+TMAnOjZDTeaRUpOsrxCXx3JRCtQukbv9/2/AEy8yIN01HnJIRpI3+5elqmKucQk3
         yYea8Cn667viq38M8OQiU1G77MndbDi/WbfvbaiAFCcRa/Lq/87omqDRpuPNIctuCyFD
         +1LX1GMd8yykAvu1mZm4dAmJ312Y0WquFhF5gpR83Wri/FurqRdRuQHznmRJFtwg1gGj
         fvEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691683943; x=1692288743;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PIWo1jE6PSmoM/dv42Zbv4IihGAAtAl+uxyHEAdsHvQ=;
        b=ST21GXpj06c0tX8kxb6T31+YREcxmrI3W9ibz5ZB6wgfu9pbZdzxglT1rLWnmRALM+
         3LTI/7DppNrObovQd2XU1SZsL+l0JgoRQtUFOhhQ8DivAm1Qc5kswHhDiU8X3L+KAxvi
         9w50/AUcAFYFfskx1e8UzqNjYEFxP8bMyan0fZ9dGiP2vRyXSHMe3CcSps9SGg5RCbRr
         K/Rme0NsSNHgYLMGvkYcmvNw9/exAgrov/h7LFu7x5bUny4OFRMAOVjX/I2fuCZg/P2O
         UfJYxEv8EEnuiJmoaExLyq93DK8t9kcSGSScIVgkYRiWcScbft91gFOIV0gk/IHwQqdY
         sQZg==
X-Gm-Message-State: AOJu0Yy+R7VJUkOUyNt7cStm96T5c1Ev8f18TkLzBP54JvLQHXCHTdF6
        GRQB1bdzirRRimI0sqoLP/5kjFJBOfBCiERGI8l3imZ14Yw=
X-Google-Smtp-Source: AGHT+IGsysh5Kb3LYHdviHf0IyYB3D37QT8whqE9FhIAe2Kad59Byk8D5w/B1QTbkUC0oYjL0oBGCMOOz+N9vJp4Hlo=
X-Received: by 2002:ac2:5b5e:0:b0:4fe:7e3d:de7 with SMTP id
 i30-20020ac25b5e000000b004fe7e3d0de7mr976694lfp.29.1691683942558; Thu, 10 Aug
 2023 09:12:22 -0700 (PDT)
MIME-Version: 1.0
From:   Ravi Kanth <mvrravikanth@gmail.com>
Date:   Thu, 10 Aug 2023 21:42:12 +0530
Message-ID: <CAEvOrRz9s8CumbuMbkCU+eCHgAp20X6q0i1D6fi5vfa5_F6JnA@mail.gmail.com>
Subject: Support for CXL v3.0 spec with QEMU
To:     linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hello,

I am writing this mail to know if the latest QEMU has support for CXL
spec v3.0? I understand from the older tutorials that QEMU has support
for CXL v2.0. Is there any update to QEMU to support the CXL v3.0? I
would like to specifically test the CCI mailbox functionality which
has been added to CXL v3.0 spec.

Thank you in advance for your assistance.

Ravi
