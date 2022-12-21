Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968B5C4332F
	for <linux-cxl@archiver.kernel.org>; Wed, 21 Dec 2022 13:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiLUNHL (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 21 Dec 2022 08:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233761AbiLUNHG (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 21 Dec 2022 08:07:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E5A17E35
        for <linux-cxl@vger.kernel.org>; Wed, 21 Dec 2022 05:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671627982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o3jX7C5Aw744uKwkAVb0g5nxr4VOJ9b/gRPk+zP0tyc=;
        b=MLABDNNcvNCoPKvG66M6iuJQs0FTzDl8zTPX2YB1Qfciq2E7QcSllgLxi7x/sKnF7pC/UA
        pW/G37wsCzVhEOnxS2a9H2E3cL/tNlv2/kDt+wWV//6T3Sw95lxtBiHT7xvNclR7RcT3fU
        I+OONODVwZ7WeS9Ch22+j3Xo9P72VVY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-618-oteA1B9cMAmGwEFlpLY7EQ-1; Wed, 21 Dec 2022 08:06:21 -0500
X-MC-Unique: oteA1B9cMAmGwEFlpLY7EQ-1
Received: by mail-wm1-f71.google.com with SMTP id bi19-20020a05600c3d9300b003cf9d6c4016so916090wmb.8
        for <linux-cxl@vger.kernel.org>; Wed, 21 Dec 2022 05:06:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o3jX7C5Aw744uKwkAVb0g5nxr4VOJ9b/gRPk+zP0tyc=;
        b=AFOytJhaLkGp6422/XHeewzKI9xwX2cfNSXnDZ/eQvc30Qhfrr1R58jKt/ER8aNFgH
         nGwiljX4bHyeM1/gZ1gAFLozzjJvfVCF3l4BiDaYXpviX65vl9o2cNblIT9YE/lBgl8l
         rHPMRpcThTz9+GBUJditIjBYiGv/V5gL93WBFcudyEUpru5qXOcXYFK45vVvhhwKyVbR
         m1q0kqh15b0UlYevDQEdBkx3+6EP+B8OeZd+ZkAymK+E/Z7yOvqb7SWQkQorvuKUS4gV
         fOGffwHB/EIlhjhLWz1qHI3fIvLbUZ5dgFgwyh8cnbP26DvQECIcApAaFWYHtpuHlvDJ
         NBPw==
X-Gm-Message-State: AFqh2kp7dEAbrUwoeeOq2QP+I1hrQtCUKOwlySeo3gYRFP1PCYhaG37O
        mslzYb5bw9X7QvJFoT7NmsY2pfncrMkfMmhRPLOUxEuDHHYP7GOY20bz6sPp9RrkTiGbUoz3K+N
        Mo7CsARv/0v0Xmj3zarYZ
X-Received: by 2002:adf:dd92:0:b0:242:39bc:4ac with SMTP id x18-20020adfdd92000000b0024239bc04acmr988239wrl.51.1671627980059;
        Wed, 21 Dec 2022 05:06:20 -0800 (PST)
X-Google-Smtp-Source: AMrXdXt7zQaGeEOZZSTq3UVWgA0fJSnFCkvHDycgzb+YXgsMUy7NBZ23lkTgr4AOSa5q6aR6kSjVNg==
X-Received: by 2002:adf:dd92:0:b0:242:39bc:4ac with SMTP id x18-20020adfdd92000000b0024239bc04acmr988225wrl.51.1671627979801;
        Wed, 21 Dec 2022 05:06:19 -0800 (PST)
Received: from redhat.com ([2.52.8.61])
        by smtp.gmail.com with ESMTPSA id u4-20020a5d4344000000b00242710c9910sm15300724wrr.8.2022.12.21.05.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 05:06:19 -0800 (PST)
Date:   Wed, 21 Dec 2022 08:06:16 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     qemu-devel@nongnu.org
Cc:     Peter Maydell <peter.maydell@linaro.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
        Ben Widawsky <ben.widawsky@intel.com>
Subject: [PULL 33/41] hw/cxl/device: Add Flex Bus Port DVSEC
Message-ID: <20221221130339.1234592-34-mst@redhat.com>
References: <20221221130339.1234592-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20221221130339.1234592-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

The Flex Bus Port DVSEC was missing on type 3 devices which was blocking
RAS checks.[1]

Add the Flex Bus Port DVSEC to type 3 devices as per CXL 3.0 8.2.1.3.

[1] https://lore.kernel.org/linux-cxl/167096738875.2861540.11815053323626849940.stgit@djiang5-desk3.ch.intel.com/

Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Ben Widawsky <bwidawsk@kernel.org>
Cc: qemu-devel@nongnu.org
Cc: linux-cxl@vger.kernel.org
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Message-Id: <20221213-ira-flexbus-port-v2-1-eaa48d0e0700@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/mem/cxl_type3.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 255590201a..dae4fd89ca 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -295,6 +295,17 @@ static void build_dvsecs(CXLType3Dev *ct3d)
     cxl_component_create_dvsec(cxl_cstate, CXL2_TYPE3_DEVICE,
                                GPF_DEVICE_DVSEC_LENGTH, GPF_DEVICE_DVSEC,
                                GPF_DEVICE_DVSEC_REVID, dvsec);
+
+    dvsec = (uint8_t *)&(CXLDVSECPortFlexBus){
+        .cap                     = 0x26, /* 68B, IO, Mem, non-MLD */
+        .ctrl                    = 0x02, /* IO always enabled */
+        .status                  = 0x26, /* same as capabilities */
+        .rcvd_mod_ts_data_phase1 = 0xef, /* WTF? */
+    };
+    cxl_component_create_dvsec(cxl_cstate, CXL2_TYPE3_DEVICE,
+                               PCIE_FLEXBUS_PORT_DVSEC_LENGTH_2_0,
+                               PCIE_FLEXBUS_PORT_DVSEC,
+                               PCIE_FLEXBUS_PORT_DVSEC_REVID_2_0, dvsec);
 }
 
 static void hdm_decoder_commit(CXLType3Dev *ct3d, int which)
-- 
MST

