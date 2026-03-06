Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4B7361655
	for <linux-cxl@vger.kernel.org>; Fri,  6 Mar 2026 10:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772792098; cv=none; b=dtaSsQfyZ4lsSJUV+2GouuhdMsZsL9+xdGVxYtXiFmpXbdGc/gNCrNQNs+94axNcuglfInc6vNmO7gqq4A42Xkos6qiameeyLBB+7XRKj1sVPFLLiEjNRrRg/8ZkQpblvQ++QusmVxzjCuFNbjFoeJQTmfEtWX5rKYWzZyYpROQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772792098; c=relaxed/simple;
	bh=RELBxw4o4cRW4TyH+N1F/5uUWHVAqqFrP458prcnTAE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PxxrehD2EegDggjPfeU0+pGwifyr91C0UkYN/JiEo9B9RJG7UMQOc+QSMS10aVeNUFU2+vs7ev6Wt7y9dsdcuaTOYj6BNb8cnv8DBL/BwjJ8kaEu7+SgpqjbBRqx+TUmLOBQPQ91/OjovEiXQ/Zjh9k9HwArZt483/UGNwim5M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fS2LW4nmSzHnH7h;
	Fri,  6 Mar 2026 18:13:55 +0800 (CST)
Received: from dubpeml500008.china.huawei.com (unknown [7.214.146.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 2739940584;
	Fri,  6 Mar 2026 18:14:55 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.195.246.67) by
 dubpeml500008.china.huawei.com (7.214.146.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 6 Mar 2026 10:14:54 +0000
From: <shiju.jose@huawei.com>
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, <mst@redhat.com>,
	<peter.maydell@linaro.org>, <jonathan.cameron@huawei.com>,
	<dave@stgolabs.net>
CC: <linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH v2 3/3] hw/cxl/events: Fix handling of component ID in event records generation to not assume it is a string
Date: Fri, 6 Mar 2026 10:14:22 +0000
Message-ID: <20260306101423.986-4-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20260306101423.986-1-shiju.jose@huawei.com>
References: <20260306101423.986-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml500008.china.huawei.com (7.214.146.94)

From: Shiju Jose <shiju.jose@huawei.com>

Fix handling of component ID in event records generation to not assume it
is a string. Component ID in CXL events is 16 bytes data, but event record
generation copy 15 bytes only from the qmp "component-id" field using
strncpy. Replace strncpy with memcpy and copy the entire component ID
data.

Fixes: ea9b6d647f2f("hw/cxl/events: Add injection of General Media Events")
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 hw/mem/cxl_type3.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 3cb1096e16..03a5d1751f 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1895,8 +1895,7 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
     }
 
     if (component_id) {
-        strncpy((char *)gem.component_id, component_id,
-                sizeof(gem.component_id) - 1);
+        memcpy(gem.component_id, component_id, sizeof(gem.component_id));
         valid_flags |= CXL_GMER_VALID_COMPONENT;
         if (has_comp_id_pldm && is_comp_id_pldm) {
             valid_flags |= CXL_GMER_VALID_COMPONENT_ID_FORMAT;
@@ -2066,8 +2065,7 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log,
     }
 
     if (component_id) {
-        strncpy((char *)dram.component_id, component_id,
-                sizeof(dram.component_id) - 1);
+        memcpy(dram.component_id, component_id, sizeof(dram.component_id));
         valid_flags |= CXL_DRAM_VALID_COMPONENT;
         if (has_comp_id_pldm && is_comp_id_pldm) {
             valid_flags |= CXL_DRAM_VALID_COMPONENT_ID_FORMAT;
@@ -2185,8 +2183,7 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
              corrected_persist_error_count);
 
     if (component_id) {
-        strncpy((char *)module.component_id, component_id,
-                sizeof(module.component_id) - 1);
+        memcpy(module.component_id, component_id, sizeof(module.component_id));
         valid_flags |= CXL_MMER_VALID_COMPONENT;
         if (has_comp_id_pldm && is_comp_id_pldm) {
             valid_flags |= CXL_MMER_VALID_COMPONENT_ID_FORMAT;
-- 
2.43.0

