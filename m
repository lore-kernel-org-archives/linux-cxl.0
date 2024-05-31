Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com [139.138.36.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FBB7E785
	for <linux-cxl@vger.kernel.org>; Fri, 31 May 2024 06:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717137085; cv=none; b=ZkQ19UGbuuTDtmupMgVJBKWzZs+SZIYjcXG0wScb6QyoAJOU1KA2TRPYcL8KUAxbqMukcOJkl9AGjgNNWLGIvB9/CNDFAc204ZUbhoisfAO9xIkcUH2L/6pXSVQqHsES+bUwhRfdawzwXKAkGI6bunDPYeljQmXtW0muorAImWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717137085; c=relaxed/simple;
	bh=IWtEyx9i9yRl2EuhAPC3tSYXvWNJsQwLilJxpMUryM0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FBkIamx+CvKtc7IS+j+dqWLJwd/xobF6fR3IxDdqZ4Tk8bYnafIXLpBtkHlSeSW/p3+IxmksA60o2oiks8mwjkST1fL0LIfrk9mkEkhCA7nnDUd03vJBSQvlVMlxi0JcAG5ljSmHdmsosnq+NfAOQJathuLW/4Cre5nmBBry9l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=cn0lfIM9; arc=none smtp.client-ip=139.138.36.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="cn0lfIM9"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1717137083; x=1748673083;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IWtEyx9i9yRl2EuhAPC3tSYXvWNJsQwLilJxpMUryM0=;
  b=cn0lfIM90HKOG5S/pvyZE9XHF2/rZVRiHJNo7DIlnonOvgxQCXfY2is2
   jaXZh+0q78C0zHvjPTNjGDJOdpErk8Zu82vov/39qlLjick6npevYgbzl
   LKzgHNdI0XxjOSqaHPpbGOAazIJW+plf0HR0iT6IMhI7Mkrba9Xc62KXq
   EdAnKWwn4cgP3dZMZoFvz56qMLY/wUXmIm4E3kCUOMk6F1odzBwPO2/j7
   Z6zD95d1Sn4nZxNGA3Fahw71PM41eHKWeDkfqEQuMMtHH6lhCYbCmsEKq
   VdTZxnZ4ESIJBmOWPAGC3G91ZcSZeOx9KwvWuyst+rTu694xQx9Pt1RMw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="148344322"
X-IronPort-AV: E=Sophos;i="6.08,203,1712588400"; 
   d="scan'208";a="148344322"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 15:30:12 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id EDC7AD8060
	for <linux-cxl@vger.kernel.org>; Fri, 31 May 2024 15:30:10 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 26808DB9EC
	for <linux-cxl@vger.kernel.org>; Fri, 31 May 2024 15:30:10 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id AEC8320094AE0
	for <linux-cxl@vger.kernel.org>; Fri, 31 May 2024 15:30:09 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 480C51A000A;
	Fri, 31 May 2024 14:30:09 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>
Subject: [ndctl PATCH v2 2/2] daxctl: Remove unimplemented create-device options
Date: Fri, 31 May 2024 14:29:59 +0800
Message-Id: <20240531062959.881772-2-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240531062959.881772-1-lizhijian@fujitsu.com>
References: <20240531062959.881772-1-lizhijian@fujitsu.com>
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
X-TMASE-Result: 10-2.488500-10.000000
X-TMASE-MatchedRID: MqppGi75AUUZHQl0dvECsQvBTB90+he+MVx/3ZYby781Y73PdzvXZLgn
	iNV4jJPwIvrftAIhWmLy9zcRSkKatSzTDssIplz246cXaPycFZt9LQinZ4QefCP/VFuTOXUT3n8
	eBZjGmUzkwjHXXC/4I8ZW5ai5WKlymCV4gU8lWsz/1hbP+Fqh7eqMnXegSEdr91jBQLI4BNGvFg
	1FCaEoYEjUuO4XeawM8DNMIbJZpozv341GSeLuQr28gjTZvH6vEWW0bEJOTAVAdUD6vW8Z1mZAM
	QMIyK6zB8/x9JIi8hKhgLRzA45JPQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

RECONFIG_OPTIONS and ZONE_OPTIONS are not implemented for create-device
and they will be ignored by create-device. Remove them so that the usage
message is identical to the manual.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V2: make the usage match the manual because the usage is wrong.
---
 daxctl/device.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/daxctl/device.c b/daxctl/device.c
index ffabd6cf5707..781dc4007f83 100644
--- a/daxctl/device.c
+++ b/daxctl/device.c
@@ -98,8 +98,6 @@ OPT_BOOLEAN('\0', "no-movable", &param.no_movable, \
 static const struct option create_options[] = {
 	BASE_OPTIONS(),
 	CREATE_OPTIONS(),
-	RECONFIG_OPTIONS(),
-	ZONE_OPTIONS(),
 	OPT_END(),
 };
 
-- 
2.29.2

