Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA234CDF9
	for <linux-cxl@vger.kernel.org>; Fri, 31 May 2024 06:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.37.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717137084; cv=none; b=WdU246sNKFJLdhNVXXsNfp4MYVvL+hDamGJg2CMXsOXOBodhqUzm6QHDxWGPCNWPumSrDegUXBxgHvMOdH/hN4JnUR1pJ4kmjIpcXN4p+V29Z86bcQHdTKANuXsbZvxS/GZ1VkJjfdsy7N8fzz9fsAP/F88GFCdeOo5efzw6kLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717137084; c=relaxed/simple;
	bh=iLJEIxVeTZ+1G/KbkNITGWV5+C/+pptGIjjsrmHWuB0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RlTiKG8ccdTYYVOiRIbehqyitif3K9ATzgtBPvGxW2TIvQDFrPj2T8j+ReSbERRqKS10TRnTRvs3rFr/U94D6ZywsfN5jK4mzQKuKldsQtb0536pa0uhLR6MWBI1UAixWLQF0bHTWRiTOoHbtV4Qel/pTsSGJmH7cX0od7YsnKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=ggJN8qu/; arc=none smtp.client-ip=139.138.37.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="ggJN8qu/"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1717137081; x=1748673081;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iLJEIxVeTZ+1G/KbkNITGWV5+C/+pptGIjjsrmHWuB0=;
  b=ggJN8qu/16MSnK0C7FgF9scBBKPZZb/46FkJdAjvmPDwYUUDT+B32rt3
   4MkJG21nQOFuYu+CLDtXZtvaPLJwCr4PGBCOkiBbkT22e+l4SZv7SCXlg
   ycl4Cp3U5Opi3YtV/abbWWyWdvgc7IoP8MBXBB4sWoxQQW71qqp+1k+XD
   P52EZ/665iG47U4GMpgufwJJjE5rzxvET9O4PQMO9uyJuEuEFxy0AnMjR
   byH+s8XYV9jL5jnAhC0qQPE1x3wITiP7SMjdI0VK7l4zQhD6S1yWqSaPP
   Uay+20GH+gL20ZnJppYbvsR66M8gcShAwzD1V0kSzBB8Z23Y78tYHa7ON
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="140038497"
X-IronPort-AV: E=Sophos;i="6.08,203,1712588400"; 
   d="scan'208";a="140038497"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 15:30:10 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 6769BC2AA3
	for <linux-cxl@vger.kernel.org>; Fri, 31 May 2024 15:30:08 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id AAA241451E
	for <linux-cxl@vger.kernel.org>; Fri, 31 May 2024 15:30:07 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 3B3BB20094AE4
	for <linux-cxl@vger.kernel.org>; Fri, 31 May 2024 15:30:07 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 67DFB1A000A;
	Fri, 31 May 2024 14:30:06 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Fan Ni <fan.ni@samsung.com>
Subject: [ndctl PATCH v2 1/2] daxctl: Fix create-device parameters parsing
Date: Fri, 31 May 2024 14:29:58 +0800
Message-Id: <20240531062959.881772-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28420.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28420.005
X-TMASE-Result: 10--6.622300-10.000000
X-TMASE-MatchedRID: 2FW4hmrwT1x6aArAc+gIexFbgtHjUWLyjlRp8uau9oYrGdGOV/v5a338
	DhskX88zh6y6sVpgqH1BCdSPDWIImy/7QU2czuUNEhGH3CRdKUX5UnqVnIHSz3Kidlm+PMQk2c5
	16rvzqru1cNZAaGmKfhsK4Gmn0aQ5NtwF1IC9LrV2o0eWLPgBZ3EJxqEF0kDO31GU/N5W5BDmn1
	MY2amWUWsRPSp/FWsq7Gwv1cOg4ZMfE8yM4pjsDwtuKBGekqUpI/NGWt0UYPAWEy2WCnvw5FISD
	qSv2ueapXz6cJSyyW3qGTW8xB7wNWEoVHihj+TK
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Previously, the extra parameters will be ignored quietly, which is a bit
weird and confusing.
$ daxctl create-device region0
[
  {
    "chardev":"dax0.1",
    "size":268435456,
    "target_node":1,
    "align":2097152,
    "mode":"devdax"
  }
]
created 1 device

where above user would want to specify '-r region0'.

Check extra parameters starting from index 0 to ensure no extra parameters
are specified for create-device.

Cc: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V2:
Remove the external link[0] in case it get disappeared in the future.
[0] https://github.com/moking/moking.github.io/wiki/cxl%E2%80%90test%E2%80%90tool:-A-tool-to-ease-CXL-test-with-QEMU-setup%E2%80%90%E2%80%90Using-DCD-test-as-an-example#convert-dcd-memory-to-system-ram
---
 daxctl/device.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/daxctl/device.c b/daxctl/device.c
index 839134301409..ffabd6cf5707 100644
--- a/daxctl/device.c
+++ b/daxctl/device.c
@@ -363,7 +363,8 @@ static const char *parse_device_options(int argc, const char **argv,
 		NULL
 	};
 	unsigned long long units = 1;
-	int i, rc = 0;
+	int rc = 0;
+	int i = action == ACTION_CREATE ? 0 : 1;
 	char *device = NULL;
 
 	argc = parse_options(argc, argv, options, u, 0);
@@ -402,7 +403,7 @@ static const char *parse_device_options(int argc, const char **argv,
 			action_string);
 		rc = -EINVAL;
 	}
-	for (i = 1; i < argc; i++) {
+	for (; i < argc; i++) {
 		fprintf(stderr, "unknown extra parameter \"%s\"\n", argv[i]);
 		rc = -EINVAL;
 	}
-- 
2.29.2

