Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292BBC432BE
	for <linux-cxl@archiver.kernel.org>; Sun, 29 Aug 2021 17:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0267D60F55
	for <linux-cxl@archiver.kernel.org>; Sun, 29 Aug 2021 17:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhH2RQr (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 29 Aug 2021 13:16:47 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:52386
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229706AbhH2RQr (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 29 Aug 2021 13:16:47 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id A99C63F232;
        Sun, 29 Aug 2021 17:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1630257353;
        bh=L0cf0NjF33stKTs19OGzzZa1hPrIN3qceVlEcaV1VHI=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=GUpZLZcJJgEiVEMdZQAdfGUIlElVrVH3hzTJGGFCBAQ3QWs5zujv569+wkkWCBatf
         sd282FNyIX1QjNp7G+HiSNgPxDAXiuo15hWX4eAzhX9r74qe2WGsdfvKzYl+SLBqS1
         U2SvWRyxtv1c+goNWhgswT9fczZImDFUNNZ1uAb+82Yx79PvcnH1mmSNfn8oSRLzmN
         ffLhvaXr00xia6PqTYPpg6CUSpab8gJZm6KS2LOwYgdHpx8h0i4SBEuLl0LJJj7qlc
         ppv4JSqSR2RhWsf7Ziu2MFY7aV003wv/+lEe31fPn16zK+Bhjug198Cv29l9olXgfv
         6eo2f8SrVcMQw==
From:   Colin King <colin.king@canonical.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] cxl/core: Fix a deference of a pointer cxl_port before it is null checked
Date:   Sun, 29 Aug 2021 18:15:53 +0100
Message-Id: <20210829171553.532596-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The assignment of pointer port with a dereference of pointer cxl_port
occurs before cxl_port is null checked. Fix this by only assigning port
once cxl_port has been null checked.

Addresses-Coverity: ("Dereference before null check")
Fixes: b7ca54b62551 ("cxl/core: Split decoder setup into alloc + add")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/cxl/core/bus.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
index 0b85351be6bf..55db46ba8a18 100644
--- a/drivers/cxl/core/bus.c
+++ b/drivers/cxl/core/bus.c
@@ -494,7 +494,7 @@ EXPORT_SYMBOL_GPL(cxl_decoder_alloc);
 int devm_cxl_add_decoder(struct device *host, struct cxl_decoder *cxld,
 			 int *target_map)
 {
-	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
+	struct cxl_port *port;
 	struct device *dev;
 	int rc = 0, i;
 
@@ -509,6 +509,7 @@ int devm_cxl_add_decoder(struct device *host, struct cxl_decoder *cxld,
 		goto err;
 	}
 
+	port = to_cxl_port(cxld->dev.parent);
 	device_lock(&port->dev);
 	if (list_empty(&port->dports))
 		rc = -EINVAL;
-- 
2.32.0

