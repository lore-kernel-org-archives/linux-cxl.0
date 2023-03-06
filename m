Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33699C61DA4
	for <linux-cxl@archiver.kernel.org>; Mon,  6 Mar 2023 19:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjCFTAM (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 6 Mar 2023 14:00:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjCFS77 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 6 Mar 2023 13:59:59 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1680B6BC07
        for <linux-cxl@vger.kernel.org>; Mon,  6 Mar 2023 10:59:26 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id ne1so7328132qvb.9
        for <linux-cxl@vger.kernel.org>; Mon, 06 Mar 2023 10:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112; t=1678129164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YSEzrBbnOGfPyPQYfp34OBDYlnxFMTXWBpgA02dumwM=;
        b=f96alH2tzoKp2MwVGaLNlyhaxc7N/kn+Ia0YwLmbx3R5e0Gc+hpIKHTRAJQI5TNLI9
         PMv+3O+nyKlBwQSkwUGKWkt/vn8w28EnBKqQieBaRmwtzH70q6xiOBc9N2vE2WReEbBx
         28fCK4lDcdzyeKKKEKMoI0NUj1dtAeGFJhbOw9Bl1ERfTmmGYaEsxFjz1g5iY/9rbrx/
         DWima6fxzhxMqPS2dJM4srdqJcNn7vZbuCFEk5MI4mkesuHnd80qO0SBdg+BbfQX5wIi
         SpaaIvSn1ODmFg/7TuSRuzZjwxQonVfYKMofxS3c52vCPTiTT1TZ7gPKIJ+e2sTRSqlr
         KQHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678129164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YSEzrBbnOGfPyPQYfp34OBDYlnxFMTXWBpgA02dumwM=;
        b=YDLvl9T12tiWozxM6SDgpxMgaNxw58y1hPIM2l56V8QTRGIU59lspyr9wwnpEqsTTw
         VqZppdanscLg0TYdmrHxcXOYzAfkXO2y1D21F3NdBEM++Fugk/goq10abaofqTREeDV9
         fBtQ4UBfTKR81K5soKYgtOf/HDCQlzEiqMLvaMSuNbDgTxcJH1PoSzl0MtegvlUVpYIx
         tNiTbNSSawTQxL5zG8Bh/QzYrZ6QZNC9049w1QdUtl8eTKuRh8FSV0sIZoxGUQijCVf/
         VtGtFX789NE12tYrmQPgtIktBN3NaOlKOYRYMQOzIYPXN4CAJ5WGSDKt+E8PszGt8Kzc
         jxmQ==
X-Gm-Message-State: AO0yUKU4qufFzUW9ejP8m6DJgGMlxmygPHy5CKHsjhtglVEMVdMP3SCV
        GbLF1tw12ZPvae2hA9fvb5fxhg==
X-Google-Smtp-Source: AK7set/aUZev5tqle/ibUoPbgFSWJn3eWzxvXn7Gu7xUejEzJ7T8WD2okaXXOmrMe5aUIbbRlVTupA==
X-Received: by 2002:a05:6214:c46:b0:56e:a630:2626 with SMTP id r6-20020a0562140c4600b0056ea6302626mr18475815qvj.45.1678129163704;
        Mon, 06 Mar 2023 10:59:23 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id bn2-20020a05620a2ac200b0073bad2f9380sm7997222qkb.14.2023.03.06.10.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 10:59:23 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     Jonathan.Cameron@huawei.com
Cc:     linux-cxl@vger.kernel.org, a.manzanares@samsung.com,
        viacheslav.dubeyko@bytedance.com,
        Viacheslav Dubeyko <slava@dubeyko.com>
Subject: CXL Fabric Manager (FM) architecture diagrams
Date:   Mon,  6 Mar 2023 10:59:13 -0800
Message-Id: <20230306185913.1060918-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi Jonathan,

You can find diagram online now:

(1) Diagram 1: single host with Fabric Manager (FM)
https://github.com/computexpresslink/cxl-fm-architecture/blob/main/diagram1-cxl-fm-single-host-with-fm.pdf

(2) Diagram 2: single host with orchestrator
https://github.com/computexpresslink/cxl-fm-architecture/blob/main/diagram2-cxl-fm-single-host-with-orhestrator.pdf

(3) Diagram3: Multi-headed device
https://github.com/computexpresslink/cxl-fm-architecture/blob/main/diagram3-cxl-fm-multi-headed-device.pdf

(4) Diagram 4: Multi-headed device + Orchestrator
https://github.com/computexpresslink/cxl-fm-architecture/blob/main/diagram4-cxl-fm-multi-headed-device-orchestrator.pdf

(5) Diagram5: Multiple hosts with Fabric Manager (FM)
https://github.com/computexpresslink/cxl-fm-architecture/blob/main/diagram5-cxl-fm-multiple-hosts-with-fm.pdf

(6) Diagram 6: Multiple hosts with orhestrator
https://github.com/computexpresslink/cxl-fm-architecture/blob/main/diagram6-cxl-fm-multiple-hosts-with-orhestrator.pdf

(7) Diagram 7: Distributed Fabric Manager (FM)
https://github.com/computexpresslink/cxl-fm-architecture/blob/main/diagram7-cxl-fm-distributed-fm.pdf

(8) Diagram 8: Layered Fabric Manager (FM) and separate orchestrator
https://github.com/computexpresslink/cxl-fm-architecture/blob/main/diagram8-cxl-fm-layered-fm-and-separate-orchestrator.pdf

(9) Diagram 9: BMC based layered Fabric Manager (FM)
https://github.com/computexpresslink/cxl-fm-architecture/blob/main/diagram9-cxl-fm-bmc-based-layered-fm.pdf

So, have I missed something?
Should we correct something on diagrams?
Does it look good?

Thanks,
Slava.
