Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158F6381B0
	for <linux-cxl@vger.kernel.org>; Tue, 30 Jan 2024 06:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706594797; cv=none; b=US0/ujChhxyHdWBfbzeO59OB+jfS6PVH74OXe1Qhm/g0bOfIevU/hdGkYk8LG0P4wbrRqfFkxA3NIwCxwxSEvsnYnMsjMm/5Q3nZCNvHiVqx5bw3orRh5bwATtQxSa3djx7B/h5Eu6B3b01mOvfpgFvfJg1xW+xL2+Q+3vpnpAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706594797; c=relaxed/simple;
	bh=GSh+6al5SkYgVVoHPm8evYNj7mo8mXPoks//oua34j0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H+XKLcGhQw5SfT6zqrl/etI6mDQjYJJyxNuKt3++s9yK86jPpsiGlf+v13qnDut6mPc96ewV4bNrFiXe7aTIULM7Xxeifxey8rToJBdGXJUBF3iRTVGyNR/xMWjChvMxCHIdItv3vZyeamTkUg7s192bljNjeDBSsujW+RjLAHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=ItMnfCFw; arc=none smtp.client-ip=68.232.139.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="ItMnfCFw"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1706594796; x=1738130796;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GSh+6al5SkYgVVoHPm8evYNj7mo8mXPoks//oua34j0=;
  b=ItMnfCFwRqv6ffdKM1z1d9BRAYSlXogrvkqrE4xfPG5R28zE+2k2N1Cf
   lKB6vF5XyJx2OkXLUDUPg8MsVJYQQxhfXc4WbcvqyUgnA+txBccD1Yik2
   3qt7d+2sXoQ6k0MBEBeFpQDloXjuFUS+4SgKxy96+c0fs8/2KtXnHn2qA
   QkpHKPhgQ8Jh5qXHeWFqZJG7UGtNsPTYdjmgiBkEVXU7cg5cDUzLUP3UI
   hdmiSpsielGP3ypKa3uPz2nLDOVAhNxAwIRy8IKWXRu6+qkP43Vjj1Pjq
   axvmWikFz1cOQkZwieBB48r0ytcF4bmyMj1djq+dYfq4J1fNQ0fWtstGD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="149441481"
X-IronPort-AV: E=Sophos;i="6.05,707,1701097200"; 
   d="scan'208";a="149441481"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 15:05:24 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 6103551542
	for <linux-cxl@vger.kernel.org>; Tue, 30 Jan 2024 15:05:21 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 8D16DE6FDF
	for <linux-cxl@vger.kernel.org>; Tue, 30 Jan 2024 15:05:20 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 1E5D12007911C
	for <linux-cxl@vger.kernel.org>; Tue, 30 Jan 2024 15:05:20 +0900 (JST)
Received: from Fedora-38-3.g08.fujitsu.local (unknown [10.167.220.145])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id A4A0A1A006A;
	Tue, 30 Jan 2024 14:05:19 +0800 (CST)
From: Quanquan Cao <caoqq@fujitsu.com>
To: dave.jiang@intel.com,
	vishal.l.verma@intel.com
Cc: linux-cxl@vger.kernel.org,
	Quanquan Cao <caoqq@fujitsu.com>
Subject: [PATCH] cxl/hdm: Enhance handling of invalid decoders
Date: Tue, 30 Jan 2024 14:05:17 +0800
Message-ID: <20240130060517.19942-1-caoqq@fujitsu.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28150.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28150.005
X-TMASE-Result: 10--0.351200-10.000000
X-TMASE-MatchedRID: 9CLtS+2vXX+XC3sMAGu+n+OnF2j8nBWbVC0UatNKNpkf/28+P8WCgL8F
	Hrw7frluf146W0iUu2vv+zsxhXHiFY+4j70fHpSVngIgpj8eDcBpkajQR5gb3savT21DsLD/UEh
	Wy9W70AEnRE+fI6etklMiyxybj28UWYqQTBansIVUWx0Q8SzxIsQ6ONE67PGVg1lQCLVEfnI9+K
	hSaDKBoml1Tgh8B2FKlqnlrFrOyXCUI6ILU/An5MBgvHuudtHysNDybdOqCWh6WkJecb4mO8MYF
	nUbyvVJ/YPqDH/SjOk=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Add the condition check "base + size < base", enhanced
handling of invalid decoders. This check ensures the
decoder's address range calculation won't overflow.

Signed-off-by: Quanquan Cao <caoqq@fujitsu.com>
---
 drivers/cxl/core/hdm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 7d97790b893d..b8978d1c7a24 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -816,7 +816,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 
 	if (!committed)
 		size = 0;
-	if (base == U64_MAX || size == U64_MAX) {
+	if (base == U64_MAX || size == U64_MAX || base + size < base) {
 		dev_warn(&port->dev, "decoder%d.%d: Invalid resource range\n",
 			 port->id, cxld->id);
 		return -ENXIO;
-- 
2.43.0

