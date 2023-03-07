Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FA6C678D5
	for <linux-cxl@archiver.kernel.org>; Tue,  7 Mar 2023 16:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjCGQ02 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 7 Mar 2023 11:26:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjCGQ0D (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 7 Mar 2023 11:26:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B18362B5B;
        Tue,  7 Mar 2023 08:24:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4E34614A0;
        Tue,  7 Mar 2023 16:24:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A720C433EF;
        Tue,  7 Mar 2023 16:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678206290;
        bh=g9YKYXRLOxZcvkGL5b+oB/OVkHje6ucVJyEY5e4Bi3o=;
        h=From:To:Cc:Subject:Date:From;
        b=Tsyq8nwBmhmAox8As/aKGPK8yH8LjJZb0B3MTm4jUxYILuCMsIeDQqAUEf3WuICo9
         EmsmkUNnKbgyox8dDvB9OtRk8qO/3fdFlWjLXkFYJaxWLcVekhV9ZFIvfQIxeszOc5
         OOEumOkMsiX2HDJreYm6ZdAvIHYUiwD987hRdICkklAKhcZ7LJf/IkpHRU1gecdg0t
         rQanbYWWdork/TAF08UrC0pl+uszoqeoU1eydu6R5mYlS6ZYTm88wlK4Jzu0ypxhlX
         1/T3+lDGSOcLXwLuutxGOmeQ38BADUR3l1QBucgs7P3BJYX7KEGJPpr1mv1TFkEovU
         6mn2cXxTFbZCQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] cxl/pci: Remove unnecessary aer.h include
Date:   Tue,  7 Mar 2023 10:24:43 -0600
Message-Id: <20230307162443.858052-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

<linux/aer.h> is unused, so remove it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Ben Widawsky <bwidawsk@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
---
 drivers/cxl/pci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 60b23624d167..d3bc450717ce 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -9,7 +9,6 @@
 #include <linux/list.h>
 #include <linux/pci.h>
 #include <linux/pci-doe.h>
-#include <linux/aer.h>
 #include <linux/io.h>
 #include "cxlmem.h"
 #include "cxlpci.h"
-- 
2.25.1

