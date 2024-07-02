Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B26A1E50F
	for <linux-cxl@vger.kernel.org>; Tue,  2 Jul 2024 14:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719930901; cv=none; b=uvFC46pBca1MzTxCTq/7r9ky/x2iR3k8d7O8Bbhov0GCiCh9bctdnPoooNP84jmjPQhDMPOPXASfE3THIDo5n3ohHJuwgz/+10UuaZxcej0A47hBwXKzV62MF/H00gzRd2VvK15HVR1bic3+4vCuUJriAcbHW0qRYZEOJHV9MJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719930901; c=relaxed/simple;
	bh=hi7rml5fRVG8BeBY67HnKyLb3DG0HI/aJXrS3FfwCAA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RJ9t9TT0dFCYQ6FypgEkBCnTBub1ci58KqRkndlGx/xwQG+tOoPlkw4CVPUyJzO51V8OZRDOXvtQmVCaI06nlsB8Bh8rGziSZ91CkfeLXuHw1wcFVQ1beU83rieKARb4CPFf6V2QaydhSRhjmsd9yANIBnD4GavWI8feakg078Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WD54z63qGz6J6pg;
	Tue,  2 Jul 2024 22:33:55 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 96733140B55;
	Tue,  2 Jul 2024 22:34:56 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 15:34:56 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <linux-cxl@vger.kernel.org>, <mst@redhat.com>, Markus Armbruster
	<armbru@redhat.com>, <qemu-devel@nongnu.org>, Li Zhijian
	<lizhijian@fujitsu.com>
CC: <linuxarm@huawei.com>
Subject: [PATCH 1/3] hw/cxl: Get rid of unused cfmw_list
Date: Tue, 2 Jul 2024 15:34:23 +0100
Message-ID: <20240702143425.717452-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240702143425.717452-1-Jonathan.Cameron@huawei.com>
References: <20240702143425.717452-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

From: Li Zhijian <lizhijian@fujitsu.com>

There is no user for this member. All '-M cxl-fmw.N' options have
been parsed and saved to CXLState.fixed_windows.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/cxl/cxl.h | 1 -
 hw/cxl/cxl-host.c    | 1 -
 2 files changed, 2 deletions(-)

diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
index 75e47b6864..e3ecbef038 100644
--- a/include/hw/cxl/cxl.h
+++ b/include/hw/cxl/cxl.h
@@ -43,7 +43,6 @@ typedef struct CXLState {
     MemoryRegion host_mr;
     unsigned int next_mr_idx;
     GList *fixed_windows;
-    CXLFixedMemoryWindowOptionsList *cfmw_list;
 } CXLState;
 
 struct CXLHost {
diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index c5f5fcfd64..926d3d3da7 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -335,7 +335,6 @@ static void machine_set_cfmw(Object *obj, Visitor *v, const char *name,
     for (it = cfmw_list; it; it = it->next) {
         cxl_fixed_memory_window_config(state, it->value, errp);
     }
-    state->cfmw_list = cfmw_list;
 }
 
 void cxl_machine_init(Object *obj, CXLState *state)
-- 
2.43.0

