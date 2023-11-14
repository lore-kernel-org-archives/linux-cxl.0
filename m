Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E9133CC8
	for <linux-cxl@vger.kernel.org>; Tue, 14 Nov 2023 18:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DC/X9NnD"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB9311B
	for <linux-cxl@vger.kernel.org>; Tue, 14 Nov 2023 10:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699986321; x=1731522321;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MZy5ZTsFI2n99XgfEMou54KPjEvP85WRoKMWZP5LpUQ=;
  b=DC/X9NnD2vLR+TpBGdtj2HuAtYC6Lsbpvh83pWZKYfSj+4USuzkXjQuy
   xqR7jm5COTpStKNtrZ6HCQNkdjRnIp6g07ibflTfcQHXAnsqLPST6EYRr
   cg96sHHN+8ozU/McQpiXLFsC08U6sbqFtkJKSC9KKqbt9jz0Zr4Vb4bF1
   ZzIyi7MJFQsqxa9Yeu+SlOvdp05OcJHnMWAFD/em+1pzh1geUl9b5hrDv
   qtGxkCy3ojUbBj8SbKEsq/KVxIBUQgIlpxIeng2FzKQDzn+q5TAD8ujzA
   Z0fzTdrkJyY20/uftvBJzJo5Nr6Hw6Qzf0X1sBJXsERQ4022PPhMngXGt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="370063819"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="370063819"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 10:25:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="768333629"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="768333629"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.87.32])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 10:25:20 -0800
Subject: [PATCH] cxl: Convert pioson ops rwsem usages to scope based resource
 management
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org, alison.schofield@intel.com
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, vishal.l.verma@intel.com,
 ira.weiny@intel.com, dan.j.williams@intel.com
Date: Tue, 14 Nov 2023 11:25:20 -0700
Message-ID: <169998626910.1958731.10157698499207717733.stgit@djiang5-mobl3>
In-Reply-To: <20231114025342.1123681-1-alison.schofield@intel.com>
References: <20231114025342.1123681-1-alison.schofield@intel.com>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Cleanup the rwsem usages in the poison ops to reduce complexity and reduce
code lines.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---

Hi Alison, follow on patch to yours. Can't be backported, but nice clean
up going forward.

 drivers/cxl/core/memdev.c |   32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 961da365b097..9ab748fadb38 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -227,8 +227,8 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd)
 	if (!port || !is_cxl_endpoint(port))
 		return -EINVAL;
 
-	down_read(&cxl_region_rwsem);
-	down_read(&cxl_dpa_rwsem);
+	guard(rwsem_read)(&cxl_region_rwsem);
+	guard(rwsem_read)(&cxl_dpa_rwsem);
 
 	if (cxl_num_decoders_committed(port) == 0) {
 		/* No regions mapped to this memdev */
@@ -237,8 +237,6 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd)
 		/* Regions mapped, collect poison by endpoint */
 		rc =  cxl_get_poison_by_endpoint(port);
 	}
-	up_read(&cxl_dpa_rwsem);
-	up_read(&cxl_region_rwsem);
 
 	return rc;
 }
@@ -324,12 +322,12 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
 	if (!IS_ENABLED(CONFIG_DEBUG_FS))
 		return 0;
 
-	down_read(&cxl_region_rwsem);
-	down_read(&cxl_dpa_rwsem);
+	guard(rwsem_read)(&cxl_region_rwsem);
+	guard(rwsem_read)(&cxl_dpa_rwsem);
 
 	rc = cxl_validate_poison_dpa(cxlmd, dpa);
 	if (rc)
-		goto out;
+		return rc;
 
 	inject.address = cpu_to_le64(dpa);
 	mbox_cmd = (struct cxl_mbox_cmd) {
@@ -339,7 +337,7 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
 	};
 	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
 	if (rc)
-		goto out;
+		return rc;
 
 	cxlr = cxl_dpa_to_region(cxlmd, dpa);
 	if (cxlr)
@@ -352,11 +350,8 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
 		.length = cpu_to_le32(1),
 	};
 	trace_cxl_poison(cxlmd, cxlr, &record, 0, 0, CXL_POISON_TRACE_INJECT);
-out:
-	up_read(&cxl_dpa_rwsem);
-	up_read(&cxl_region_rwsem);
 
-	return rc;
+	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_inject_poison, CXL);
 
@@ -372,12 +367,12 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
 	if (!IS_ENABLED(CONFIG_DEBUG_FS))
 		return 0;
 
-	down_read(&cxl_region_rwsem);
-	down_read(&cxl_dpa_rwsem);
+	guard(rwsem_read)(&cxl_region_rwsem);
+	guard(rwsem_read)(&cxl_dpa_rwsem);
 
 	rc = cxl_validate_poison_dpa(cxlmd, dpa);
 	if (rc)
-		goto out;
+		return rc;
 
 	/*
 	 * In CXL 3.0 Spec 8.2.9.8.4.3, the Clear Poison mailbox command
@@ -396,7 +391,7 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
 
 	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
 	if (rc)
-		goto out;
+		return rc;
 
 	cxlr = cxl_dpa_to_region(cxlmd, dpa);
 	if (cxlr)
@@ -409,11 +404,8 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
 		.length = cpu_to_le32(1),
 	};
 	trace_cxl_poison(cxlmd, cxlr, &record, 0, 0, CXL_POISON_TRACE_CLEAR);
-out:
-	up_read(&cxl_dpa_rwsem);
-	up_read(&cxl_region_rwsem);
 
-	return rc;
+	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_clear_poison, CXL);
 


