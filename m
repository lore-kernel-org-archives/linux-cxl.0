Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFF02D60A
	for <linux-cxl@vger.kernel.org>; Fri,  9 Feb 2024 11:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.37.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707479737; cv=none; b=SYkso2XYxNJ6sJ3MNEp7Ffpbmop3pLjCdBjIaof7DziBlMtPuaX8wkSP5QJoxmGKNqegqKSwsjf5o5do5NXCObZ87mNnrv/SHGvLLEnrZw9Cbwx0PY0pSYQrw17JiY2SqUt+kLfAqSeTlbxHhyjg4MO1asdBk6PnnkW3qWH9u/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707479737; c=relaxed/simple;
	bh=gc1QJi8tjO2QU5afLszjKGpMkpijLoZiKrlgk9mPnlY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cBZVrNZKYXBYyYh2cWQQZhMLRUwvxQHPpq9tKEI+Du5QaJk8r/SUYXIZIAmctOe0kO+jwkzGW6L3SGX3lPWxjZdHzpxyjVu0ThVv/jTXaEVNcK4f9ri32iqquO84C/Xf7pVnnujpEztY/WAygWHiyv0Cd3RSu/n6/yyAmpbj3jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=snT+q5bf; arc=none smtp.client-ip=139.138.37.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="snT+q5bf"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1707479735; x=1739015735;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gc1QJi8tjO2QU5afLszjKGpMkpijLoZiKrlgk9mPnlY=;
  b=snT+q5bfyQtnsWrU/mLV04JzBt5k5STW7FsoIbTF03lIBKvSX2lQWwVZ
   gC10Yp2a9eXRJ3flntcb5yOOVMFbOlxrgtXODgklXj/env3sH3g7P5X1c
   CSJ63s3DEUPX/rAFMdPFLzqK9sKSqxnBuT9ZI87bw0dtBgBupECOzhl1C
   bty4sqjFpGmmAzfW53h+eoNwN2a59BJW8zKcxFkI7c3wZxF5jcnYignMF
   e+MGtOeYskD9HUZ/XxgD19MUvEH/9xfw6+Y8GROEW4EZrR75rLtUlEyup
   1fYOOUNZq0Xv2UobNJevSq229iXHQeD2YXdEwLrBeZC/mMFfiZs312U5Y
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="128242539"
X-IronPort-AV: E=Sophos;i="6.05,256,1701097200"; 
   d="scan'208";a="128242539"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 20:54:22 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 213682382C
	for <linux-cxl@vger.kernel.org>; Fri,  9 Feb 2024 20:54:20 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 5AD3ED20B6
	for <linux-cxl@vger.kernel.org>; Fri,  9 Feb 2024 20:54:19 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id E41051EBDBD
	for <linux-cxl@vger.kernel.org>; Fri,  9 Feb 2024 20:54:18 +0900 (JST)
Received: from irides.g08.fujitsu.local (unknown [10.167.226.114])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 794861A00A1;
	Fri,  9 Feb 2024 19:54:18 +0800 (CST)
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
To: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org
Cc: Jonathan.Cameron@huawei.com,
	dan.j.williams@intel.com
Subject: [RFC PATCH 2/2] hw/cxl/type3: send a GMER while injecting poison
Date: Fri,  9 Feb 2024 19:54:12 +0800
Message-Id: <20240209115417.724638-3-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240209115417.724638-1-ruansy.fnst@fujitsu.com>
References: <20240209115417.724638-1-ruansy.fnst@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28180.007
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28180.007
X-TMASE-Result: 10--6.213600-10.000000
X-TMASE-MatchedRID: QDRvHZvo+kv1zRJIGToPzk7nLUqYrlslFIuBIWrdOePfUZT83lbkEIJd
	/Yi3ky8jb7vhAFDgsdNFiEGX44FuA+UWmx8yAzoMfUkgDiuGxn99LQinZ4QefOYQ3zcXToXr+gt
	Hj7OwNO2OhzOa6g8KrQIvbT/YA/9KBTgUwp2Sy8TyO2GUnhfHBQyliSfkl61FtbbmxzTU8Oc=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Send a signal to OS to let it able to handle the poison range.

TODO: This is an rough draft, will add more parameters for
qmp_cxl_inject_poison() to set to GMER.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 hw/mem/cxl_type3.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index d8fb63b1de..813f7f2175 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1116,6 +1116,11 @@ void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t length,
 
     QLIST_INSERT_HEAD(&ct3d->poison_list, p, node);
     ct3d->poison_list_cnt++;
+
+    /* Emit an GMER event, let os handle it */
+    qmp_cxl_inject_general_media_event(path, CXL_EVENT_LOG_FAILURE, 0, start,
+                                       0, 0, 4, false, 0, false, 0,
+                                       false, 0, NULL, errp);
 }
 
 /* For uncorrectable errors include support for multiple header recording */
-- 
2.34.1

