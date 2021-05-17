Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8565C433B4
	for <linux-cxl@archiver.kernel.org>; Mon, 17 May 2021 18:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C4EA61002
	for <linux-cxl@archiver.kernel.org>; Mon, 17 May 2021 18:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237313AbhEQSwu (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 17 May 2021 14:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234049AbhEQSwt (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 17 May 2021 14:52:49 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B171C061573
        for <linux-cxl@vger.kernel.org>; Mon, 17 May 2021 11:51:32 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id o127so4115940wmo.4
        for <linux-cxl@vger.kernel.org>; Mon, 17 May 2021 11:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=SNhJ9v68Yd6CovqAzSkr8gnH/9xi6E2wSyGQTwBHBgg=;
        b=WYx8m5r0K4ZpwoHWhHGQUtgAEYcBYGOrTmAgmlGUnwvzeQ3zECDxqwI5IvV7DkKV3o
         gjmYmsHoZo3kVUxH4EVbgwj59wQjOhZEzIdUbD1ExTEGyms5evzuIFK7POie1ogJ444T
         CeZcnLfChjbJBr7vAQ75/Z8HDpI3nbKVD3IY+GiJ/RjNREQlg+TMUfi0Dg3xMFYtKb3S
         T+tPh5Fg5HtAc6ORy0ZdZjr8zEv7IkAzwX3adDjOnxzTBbWg4YZCKyt5pjoZ5JTVE0o1
         z2r3acAvjQjboYHOU+FUzcOq4jZvsRC6iTkNvAqVKXOwHtSbCGXhVAur+A8T1ndUraaP
         AdnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=SNhJ9v68Yd6CovqAzSkr8gnH/9xi6E2wSyGQTwBHBgg=;
        b=aI/+2/GKgjHOTbzouVy5IxEw5VgVt+5r3Fj2fu6nTg46I5DL8/wSqHaSStyy7kwzFT
         BweK2VYoj/NZt1xXQ7ix/V1wuyoZP5yinUHY7b41W2n5ApHUlSM4qTyJ+TVfC5DAA9e8
         w3hBDnD//M6l9Ce2eoDBMjwmyGlvpgpeRvtzZbGxG9fafC/HSW3IXFQ9FH+6k6acBTvV
         xQCQANEcEJxtEHXcBbn7KnI8Mhq2OLP75jrhRR1ViDbmRzgONKBk9EI+hO05An4DpU0P
         mWLA494vBqg4Xg5Kn2Oo01A940S5gG084oyw96GS504UaLl34YrsaMxmYyxEBk+4H0uv
         Ervw==
X-Gm-Message-State: AOAM530X/qS36X2AnVkbNybLvLc0qmFp9ekRab/i3PyJ3X4JLfzSdBBk
        Gt8LHwdqsJV+r4Vt9VIV2ciINadqEeWzeuPfUnl5OAtX3C8=
X-Google-Smtp-Source: ABdhPJwFfq+S576I1+JEGocNHg3fauWQmmX+rFPUCoNZbDk5cQmhFu8759g7H2JjHazafYQ7MqcRf3+F52iSydwiEPk=
X-Received: by 2002:a05:600c:214f:: with SMTP id v15mr503977wml.146.1621277490986;
 Mon, 17 May 2021 11:51:30 -0700 (PDT)
MIME-Version: 1.0
From:   Dengcheng Zhu <dengcheng.zhu@gmail.com>
Date:   Mon, 17 May 2021 11:51:20 -0700
Message-ID: <CAOfQC9_aEmNKO2AmmX7JKwpZcj-HtMdoJBv+bH8qvbw0siTGOA@mail.gmail.com>
Subject: Access to CXL memory
To:     ben.widawsky@intel.com, dan.j.williams@intel.com
Cc:     linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi,

I learned that CXL memory could be exposed to the system as a NUMA
node as well as an mmap()able device.

Two questions are:

- Can these 2 forms coexist at the same time?
- If yes, how does memory management work between these 2 interfaces?

Please shed some light upon this issue.

Thanks,
Dengcheng
