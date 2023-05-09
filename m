Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C31C7EE22
	for <linux-cxl@archiver.kernel.org>; Tue,  9 May 2023 15:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235664AbjEIPY7 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 9 May 2023 11:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjEIPYs (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 9 May 2023 11:24:48 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12EB46AA
        for <linux-cxl@vger.kernel.org>; Tue,  9 May 2023 08:24:47 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1aad5245571so41430645ad.1
        for <linux-cxl@vger.kernel.org>; Tue, 09 May 2023 08:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683645887; x=1686237887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1xqTlhCuOMEySxCpIGDOY/17nSui9/3djdb2737bjTc=;
        b=RhpWB1eIAcVtyj2EGg6MLu8VI5QAG91SmDEKHHb6nOso/f2iR2ciEzmubLBPD0bEAG
         Qs4AhoulyTAb95GRBvnba4mZMEHWMqD8fVtaeovRzRYrnHS684qOwun4XPr3cc3vrzAJ
         gNPPzy/kCWj8cOXwcHfHCJWZpFBnElXdqu09441zdT3yP4MrLzt12RH9cLrET82XfOki
         +3hCNTMzRWy3yfKoGF4YsaE6sk56M+tzDzR/5/sJ/Sd7stcSu+fzbvBQh7yTN1p5aifK
         pZ5tQJEYaY8FWT+NXihz2XGn3WF51+0qO7nzkfgZekUlcPk8TC0fQSDlxY4HQv5FBlEz
         pIIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683645887; x=1686237887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1xqTlhCuOMEySxCpIGDOY/17nSui9/3djdb2737bjTc=;
        b=H9IWVPPGeMFOxf6o/N2J31lmS0S/PESo4fx/6boYE7mKjzfONNArU7GrMtOQfXqUMz
         fReIp2JLq3dOztvFvFdgWxvP7L009zxbfBi+WaA0jgtsi96PidyxcMtvS9EM3DYUnMP0
         i64P7gHqeF9Wbs3cmR1/BInRk6qdzTP5/WOrFOg//EUu+dsUaN9B6Xq8bpA/rZ2I8gVw
         MPImOmu/bPoP0hFxpXcQJGvJhQ+xDdiEubRRrX+4kYh4ZxfGDw8aAW6eSePGK3Me9ajL
         Qy+JNZxqWGf8/2tuVoLAEHRBhrdNBmqRyV8CENyp8WB7nGfjAjI+MGMHV3qqPj3XIu7W
         sz1Q==
X-Gm-Message-State: AC+VfDxp6gz2fh8eunJ+IQbQp4b1iIzD4Cn/fmb9dVVePJn8++ZEgCEd
        iI6uLOsu70nTvRIc09h2UnzOmshIT5w=
X-Google-Smtp-Source: ACHHUZ4JI0hkhf+QqYjZzAa/irLxrR3lEzxDsucwCw3qHBVuy0IyRQrFYxMlt2/QCZBggrX6881kXA==
X-Received: by 2002:a17:903:1208:b0:1a6:4606:6e06 with SMTP id l8-20020a170903120800b001a646066e06mr17108693plh.17.1683645886811;
        Tue, 09 May 2023 08:24:46 -0700 (PDT)
Received: from localhost ([1.230.133.98])
        by smtp.gmail.com with ESMTPSA id f2-20020a170902ce8200b0019ef86c2574sm1704049plg.270.2023.05.09.08.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 08:24:46 -0700 (PDT)
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Cc:     Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [ndctl PATCH 0/3] cxl: clean up and fix typos
Date:   Wed, 10 May 2023 00:24:24 +0900
Message-Id: <20230509152427.6920-1-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hello,

Looking around QEMU-based emulated CXL device with ndctl, I've found
some miscs to fix up including typo and removal of some redundant
funciton name in a log.

Please review.
Thanks,

Minwoo Im (3):
  cxl/list: Fix typo in cxl-list documentation
  cxl: region: remove redundant func name from error
  cxl: fix changed function name in a comment

 Documentation/cxl/cxl-list.txt | 10 +++++-----
 cxl/region.c                   |  5 +++--
 2 files changed, 8 insertions(+), 7 deletions(-)

-- 
2.34.1

