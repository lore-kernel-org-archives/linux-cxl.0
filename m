Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA4DC77B7C
	for <linux-cxl@archiver.kernel.org>; Wed, 19 Apr 2023 11:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjDSLRK (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 19 Apr 2023 07:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbjDSLRJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 19 Apr 2023 07:17:09 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B63125AD
        for <linux-cxl@vger.kernel.org>; Wed, 19 Apr 2023 04:16:38 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1a68f2345c5so21759155ad.2
        for <linux-cxl@vger.kernel.org>; Wed, 19 Apr 2023 04:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681902921; x=1684494921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=csi7oNtWPXDnV4DnWm8rsHdGZYECj2UWKBDvXfIeArc=;
        b=KhHhHD9Yv0bUsHPX02Gk/vqDXccsecbWqwMHMQzpw3K9z5N0lVI4ftDE6lx6wi/ekx
         yWnNjCU/shf3TxH/W1EEqI1N5ge3keGKGwGuEA0ftX/bt9+8SBRN0/+TET26LDbkT1+C
         tuOOTK8O/5ZjrZz7DkfG2q0VaJ4iH5zs6Kgf2MLaNGUNlLvc82E/BQcQHid3Okdz2QxX
         qHYJJjH2TzSme+NKi9WMy5HQyFc+EDlvKjwnZe4GArROmz2M28+t7mtjDyohXByeu35a
         W4g4n2FNqx5vaRHNdwN591o1gTJu4K42Pfeb7oAKgL3Kn2//PvPlY5zhrD/WKBHnFtHX
         T3/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681902921; x=1684494921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=csi7oNtWPXDnV4DnWm8rsHdGZYECj2UWKBDvXfIeArc=;
        b=dobUUnbbllMJcab0ik9cf0ylxtdEJR+9OXjxTtymCyIPMKDLvInCh6l31ccGoWymew
         TxXoqItORHEHSmX6LfIovUMZjkBebf4h9xKm5Y4tLFRJIsBQ6WutXpApQ0LmPkPxFbMZ
         FwGSIlYZTb4dHgMwvTW3KRDf5o3eplXDUpzBZB4Mc8KMQYKrNV4UDPNKaKSKOtJZcrW5
         VQQ+w4yn24aVfDVx6RAFxKSOLgZyr4i3Z0UJI0bfaZI5lRFqx++j+vyiRrchcjiPFxuX
         TxTFFKieuD8Zd7NkGoa9/YuLvZmb1f/BSBN7isV02BIv6AhTfZskkEfoPmYr1pFlAttJ
         UU1A==
X-Gm-Message-State: AAQBX9ceiE9LDl0uSzlSB3kZhDzLniMziAInl8DSVIwmXaUbCbPbiubr
        uFyMnRAg7gkZXFDE0Wg149Px4PtHhYk=
X-Google-Smtp-Source: AKy350Z4twdfgXLBjsHkD34hk2KyoGXD4nOleqktUB611R6U1GuY/mideu9kVU4/uR5bN8dRf/PGNg==
X-Received: by 2002:a17:903:1cf:b0:1a0:50bd:31bf with SMTP id e15-20020a17090301cf00b001a050bd31bfmr6027421plh.32.1681902921544;
        Wed, 19 Apr 2023 04:15:21 -0700 (PDT)
Received: from cxl-test.. ([103.181.222.211])
        by smtp.gmail.com with ESMTPSA id o4-20020a170902bcc400b001a6566045ccsm11194914pls.192.2023.04.19.04.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 04:15:21 -0700 (PDT)
From:   Raghu H <raghuhack78@gmail.com>
To:     linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        raghuhack78@gmail.com
Subject: [STYLE v1 0/3] Fixing check patch styling issues
Date:   Wed, 19 Apr 2023 11:14:40 +0000
Message-Id: <20230419111443.231151-1-raghuhack78@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The following patches are cleanup or fixing the styling issues found
using checkpatch

In cxl/core/mbox.c, in case of null check failure, returning errno or
-ENOMEM in this case is good enough, removing the redundant dev_err
message.

In cxl/core/port.c, there is line of spaces in the definition which
violates checkpatch coding sytle, restructured the definition to use
tabs

In cxl/core/region.c, the else is not required after the return
statement, cleaned it up.

Verified the build and sanity by booting the guest VM using the freshly
built components.

Raghu H (3):
  cxl/mbox: remove redundant debug msg
  cxl/core/port: Use tabs to fix styling errors
  cxl/core/region:Remove else after return statement

 drivers/cxl/core/mbox.c   |  4 +---
 drivers/cxl/core/port.c   | 18 +++++++++---------
 drivers/cxl/core/region.c |  7 +++----
 3 files changed, 13 insertions(+), 16 deletions(-)

-- 
2.39.2

