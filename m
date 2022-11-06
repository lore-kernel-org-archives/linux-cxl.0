Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E574EC4332F
	for <linux-cxl@archiver.kernel.org>; Sun,  6 Nov 2022 23:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiKFXrW (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 6 Nov 2022 18:47:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiKFXrV (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 6 Nov 2022 18:47:21 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE41D2C8
        for <linux-cxl@vger.kernel.org>; Sun,  6 Nov 2022 15:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667778441; x=1699314441;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/GWlhQQbKeBCJsRRb7NoP0PPinbVtX3YBlZOZiQkzsU=;
  b=H6yHtaTS4esv2N/N1J6D/TqNDmt2cJcIua4oogAVdSDdQmRxdwuLvNIo
   rtollx8xt+eiVQ1hA9mCvhvaQXKsivq598JXmQP1fQQiiNEcO3dQrtHHp
   DZTM2d/5i6NlVqFA3MQ8oF6lXeUIqJLBHZoE++vkZnI0+4CMnF68oOoA2
   Drs0CHWE7MfZCjaDp3ihZN+bhBmbGAn0KF14hpRNxp2xOOAwdLLWMCOMl
   v4tKUmrkJFcBI7+uTbU0eN6keQwDNkWNNbm53jo1w/6Ya5cLnw6El6jlj
   7RtiE8QhPNRFwTENIKI2M/saZoX3QWvzQW/D4pfAHdcGXBJEmIpDhssUP
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="396590969"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="396590969"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2022 15:47:20 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="964951408"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="964951408"
Received: from durgasin-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.240.219])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2022 15:47:20 -0800
Subject: [ndctl PATCH 06/15] cxl/list: Skip emitting pmem_size when it is
 zero
From:   Dan Williams <dan.j.williams@intel.com>
To:     vishal.l.verma@intel.com
Cc:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Date:   Sun, 06 Nov 2022 15:47:20 -0800
Message-ID: <166777844020.1238089.5777920571190091563.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <166777840496.1238089.5601286140872803173.stgit@dwillia2-xfh.jf.intel.com>
References: <166777840496.1238089.5601286140872803173.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The typical case is that CXL devices are pure ram devices. Only emit
capacity sizes when they are non-zero to avoid confusion around whether
pmem is available via partitioning or not.

Do the same for ram_size on the odd case that someone builds a pure pmem
device.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 cxl/json.c |   20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/cxl/json.c b/cxl/json.c
index 63c17519aba1..1b1669ab021d 100644
--- a/cxl/json.c
+++ b/cxl/json.c
@@ -305,7 +305,7 @@ struct json_object *util_cxl_memdev_to_json(struct cxl_memdev *memdev,
 {
 	const char *devname = cxl_memdev_get_devname(memdev);
 	struct json_object *jdev, *jobj;
-	unsigned long long serial;
+	unsigned long long serial, size;
 	int numa_node;
 
 	jdev = json_object_new_object();
@@ -316,13 +316,19 @@ struct json_object *util_cxl_memdev_to_json(struct cxl_memdev *memdev,
 	if (jobj)
 		json_object_object_add(jdev, "memdev", jobj);
 
-	jobj = util_json_object_size(cxl_memdev_get_pmem_size(memdev), flags);
-	if (jobj)
-		json_object_object_add(jdev, "pmem_size", jobj);
+	size = cxl_memdev_get_pmem_size(memdev);
+	if (size) {
+		jobj = util_json_object_size(size, flags);
+		if (jobj)
+			json_object_object_add(jdev, "pmem_size", jobj);
+	}
 
-	jobj = util_json_object_size(cxl_memdev_get_ram_size(memdev), flags);
-	if (jobj)
-		json_object_object_add(jdev, "ram_size", jobj);
+	size = cxl_memdev_get_ram_size(memdev);
+	if (size) {
+		jobj = util_json_object_size(size, flags);
+		if (jobj)
+			json_object_object_add(jdev, "ram_size", jobj);
+	}
 
 	if (flags & UTIL_JSON_HEALTH) {
 		jobj = util_cxl_memdev_health_to_json(memdev, flags);

