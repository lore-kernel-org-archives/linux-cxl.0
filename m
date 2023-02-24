Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9561C6FA8E
	for <linux-cxl@archiver.kernel.org>; Fri, 24 Feb 2023 19:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjBXTrK (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 24 Feb 2023 14:47:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjBXTrJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 24 Feb 2023 14:47:09 -0500
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3686C1A7
        for <linux-cxl@vger.kernel.org>; Fri, 24 Feb 2023 11:47:07 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id E78F041C64;
        Fri, 24 Feb 2023 19:47:06 +0000 (UTC)
Received: from pdx1-sub0-mail-a250.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 6AF3641D30;
        Fri, 24 Feb 2023 19:47:06 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1677268026; a=rsa-sha256;
        cv=none;
        b=CtSQ4lFyXAYVw2+Rzg3FRZzWnKKaM2g4ZXpA8kdi04x6mF6t96jpoSuB0cpW0MYbkHex0P
        PBBVwIRKco9pWYlx3/ORk5s/WYdTKBZIO80cECktw6E8s3nMBo96GTOgkbSwKdfLUCLQGQ
        9jcoopOE7kBmGESG6ubh9hm91aIn+rzr5AiB6X8vhvrx5JJoVbj9BOoztwtO8n+XfNLYZ/
        qVTkclI2vnsHuKvoF5beePsl0m5Kchaib3XLs43b933gRlEKKOj0sqwcS71HMc5yHXRof9
        dohOOwL05SNZjzmowW0v9w8VgLFUSAP9QZZcopoM8iV4k897P52BHFQIy98cWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1677268026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=NZUKbFkQhmzwX/XIY66T6M+R2xD4t4IwbUDe6lPcZLc=;
        b=uLK/luq7Z9ujVFPWTpW4kiACNTRh0c89c6/aN4bHceU4OPERDraW25LoGDfOBOUGmi215T
        O3KFmHW/A7Sw1S6KPFM7JVCVk+eniNmUS6zFRWeKOEyeQBD5OPA2onnOvL1+1ixBrpJx8P
        ue6vrJ8ldWygbIAVnE26jtaDgufuSchXhnCF4JwNWnTsOraTF+WdIDmwqxHoTXIzTYzl6Q
        lhx71HWtvkGN3SMfsXsT/qfeEFiUmxB7ZiRznDTDmllMG57rZ8yfkoz3AK4Iw+NxSR99Dx
        MBVgYKZeN2aZ1Hxo0d5QGTT5RRlvNqhcgAEY7ARDXuQaGFTlaKJsgm64Bq2wFw==
ARC-Authentication-Results: i=1;
        rspamd-9788b98bc-mldnf;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Lyrical-Company: 785f337656f19f58_1677268026781_3588991372
X-MC-Loop-Signature: 1677268026781:2446644040
X-MC-Ingress-Time: 1677268026781
Received: from pdx1-sub0-mail-a250.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.97.74.37 (trex/6.7.1);
        Fri, 24 Feb 2023 19:47:06 +0000
Received: from offworld.. (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a250.dreamhost.com (Postfix) with ESMTPSA id 4PNgQK2SvNz2Q;
        Fri, 24 Feb 2023 11:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1677268026;
        bh=NZUKbFkQhmzwX/XIY66T6M+R2xD4t4IwbUDe6lPcZLc=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=pGXZIXJ073EoaYBAknYQTP4EeoqbIFeEduSAc/hetNHFRpo9guUYwUXtziHmRN/sK
         /2PxHEWELdPpNjk5/F8jpmpfhSqjpMcF6GxI0bFXmpFNQFdBOxAeKbSaFzyRgOwfSP
         hjtm5d//12/a8p7c2GW/s6BJj9IT+s6PkGGsr97Y3KYUIW1PC0woWOqev9evaqQIYL
         WqA2kZpX4QdMRX8mlaCVYVH5NVQvzxMfvvxkiO6XxIWkgsC95QuXdNEPd24Y+21oYz
         hSnzP4wCbX8vrn8bNgwq1KKV/0L7a/PI3Wdou3pvE0ZhilJ8sxsyFL7up2wxYXLtvY
         FILCXZn9wJcDg==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     jonathan.cameron@huawei.com, ira.weiny@intel.com,
        fan.ni@samsung.com, a.manzanares@samsung.com,
        linux-cxl@vger.kernel.org, dave@stgolabs.net
Subject: [PATCH 3/7] cxl/region: Add cxl_memdev_active_region()
Date:   Fri, 24 Feb 2023 11:46:48 -0800
Message-Id: <20230224194652.1990604-4-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230224194652.1990604-1-dave@stgolabs.net>
References: <20230224194652.1990604-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Track all regions associated to a memdev in order to
tell if the device might be in active use.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/core/memdev.c |  1 +
 drivers/cxl/core/region.c | 33 +++++++++++++++++++++++++++++++--
 drivers/cxl/cxl.h         |  6 ++++++
 drivers/cxl/cxlmem.h      |  4 ++++
 4 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 47cc625bb1b0..68c0ab06b999 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -306,6 +306,7 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
 	dev->type = &cxl_memdev_type;
 	device_set_pm_not_required(dev);
 	INIT_WORK(&cxlmd->detach_work, detach_memdev);
+	INIT_LIST_HEAD(&cxlmd->region_list);
 
 	cdev = &cxlmd->cdev;
 	cdev_init(cdev, fops);
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index f29028148806..cea9de6457b9 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1730,7 +1730,10 @@ void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled)
 {
 	down_write(&cxl_region_rwsem);
 	cxled->mode = CXL_DECODER_DEAD;
-	cxl_region_detach(cxled);
+	if (!cxl_region_detach(cxled)) {
+		struct cxl_region *cxlr = cxled->cxld.region;
+		list_del(&cxlr->node);
+	}
 	up_write(&cxl_region_rwsem);
 }
 
@@ -1749,8 +1752,12 @@ static int attach_target(struct cxl_region *cxlr,
 
 	down_read(&cxl_dpa_rwsem);
 	rc = cxl_region_attach(cxlr, cxled, pos);
-	if (rc == 0)
+	if (rc == 0) {
+		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+
 		set_bit(CXL_REGION_F_INCOHERENT, &cxlr->flags);
+		list_add_tail(&cxlr->node, &cxlmd->region_list);
+	}
 	up_read(&cxl_dpa_rwsem);
 	up_write(&cxl_region_rwsem);
 	return rc;
@@ -1778,6 +1785,8 @@ static int detach_target(struct cxl_region *cxlr, int pos)
 	}
 
 	rc = cxl_region_detach(p->targets[pos]);
+	if (rc == 0)
+		list_del(&cxlr->node);
 out:
 	up_write(&cxl_region_rwsem);
 	return rc;
@@ -2654,6 +2663,26 @@ int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_add_to_region, CXL);
 
+bool cxl_memdev_active_region(struct cxl_memdev *cxlmd)
+{
+	bool ret = false;
+	struct cxl_region *cxlr;
+
+	down_read(&cxl_region_rwsem);
+	list_for_each_entry(cxlr, &cxlmd->region_list, node) {
+		struct cxl_region_params *p = &cxlr->params;
+
+		if (p->state >= CXL_CONFIG_ACTIVE) {
+			ret = true;
+			break;
+		}
+	}
+	up_read(&cxl_region_rwsem);
+
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_memdev_active_region, CXL);
+
 static int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
 {
 	if (!test_bit(CXL_REGION_F_INCOHERENT, &cxlr->flags))
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index b834e55375e3..e211241b079b 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -502,6 +502,7 @@ struct cxl_region {
 	struct cxl_pmem_region *cxlr_pmem;
 	unsigned long flags;
 	struct cxl_region_params params;
+	struct list_head node;
 };
 
 struct cxl_nvdimm_bridge {
@@ -773,6 +774,7 @@ struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev);
 int cxl_add_to_region(struct cxl_port *root,
 		      struct cxl_endpoint_decoder *cxled);
 struct cxl_dax_region *to_cxl_dax_region(struct device *dev);
+bool cxl_memdev_active_region(struct cxl_memdev *cxlmd);
 #else
 static inline bool is_cxl_pmem_region(struct device *dev)
 {
@@ -791,6 +793,10 @@ static inline struct cxl_dax_region *to_cxl_dax_region(struct device *dev)
 {
 	return NULL;
 }
+static inline bool cxl_memdev_active_region(struct cxl_memdev *cxlmd)
+{
+	return false;
+}
 #endif
 
 /*
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 934076254d52..4e31f3234519 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -5,6 +5,7 @@
 #include <uapi/linux/cxl_mem.h>
 #include <linux/cdev.h>
 #include <linux/uuid.h>
+#include <linux/list.h>
 #include "cxl.h"
 
 /* CXL 2.0 8.2.8.5.1.1 Memory Device Status Register */
@@ -40,6 +41,8 @@
  * @cxl_nvd: optional bridge to an nvdimm if the device supports pmem
  * @id: id number of this memdev instance.
  * @depth: endpoint port depth
+ * @region_list: List of regions that have as target the endpoint
+ *               decoder associated with this memdev
  */
 struct cxl_memdev {
 	struct device dev;
@@ -50,6 +53,7 @@ struct cxl_memdev {
 	struct cxl_nvdimm *cxl_nvd;
 	int id;
 	int depth;
+	struct list_head region_list;
 };
 
 static inline struct cxl_memdev *to_cxl_memdev(struct device *dev)
-- 
2.39.2

