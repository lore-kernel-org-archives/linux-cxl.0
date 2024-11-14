Received: from poodle.tulip.relay.mailchannels.net (poodle.tulip.relay.mailchannels.net [23.83.218.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4708B1AC45F
	for <linux-cxl@vger.kernel.org>; Thu, 14 Nov 2024 22:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.249
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731622681; cv=pass; b=ZNYOKqMUTnkx6ka7TfC3VVpMmEXBh6B2GWASIG9aoiuMaCMyA9bSHCfhNGbI5V25NolltAi9Jbfh3nCp/5dn151NR2th9phRbT79VeoKz1RFxEOeH6xJ/4ABMJjxIEbFCOB9CzZsmJZZnFe8t8DiGnXEZB1uD8159s0QiqR5hNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731622681; c=relaxed/simple;
	bh=LgUA0KNx718wujUsUwBSefRoTiz4FfCM/26pxTXo15E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PHff/X3KJVJcWqWKKHpUicGwQKC+BertgxdjxaOo4BCn0guKVSGNHFO1H9uqGsvNvUJ7iIkYq95SfWkJbEwgMXZ9JZT/a8G5k8R56InsGfNKPVJ8I+WzK3qF/aqjWIW0+VdpOpoprsb7Aubzr0WmFX1O4M3A8WpQA6m63g3jKeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=WGITTmlo; arc=pass smtp.client-ip=23.83.218.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="WGITTmlo"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 973EEC1D79;
	Thu, 14 Nov 2024 21:38:43 +0000 (UTC)
Received: from pdx1-sub0-mail-a233.dreamhost.com (trex-8.trex.outbound.svc.cluster.local [100.111.109.236])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 1F899C3CF7;
	Thu, 14 Nov 2024 21:38:43 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1731620323; a=rsa-sha256;
	cv=none;
	b=4JHIE7SF9Qnx2eSfg+LPvdvt7AERAkOXH+QrLOi3juuCYKD02bA2r+pvKnDVllNDjOtXuw
	6HhUcnJwndf9+r0BZ6BPQ9dQB+K2YpxlPQL+4YffuCFIjaBm0RzL6cGA9eUdCAspve0JNe
	F3L3tWnV9NJR5uiHJ11KGbbO8cb5nHvECxF4T25DxyDCkrVw4xSwvM1mg1xjmCYjzfAVc8
	8ZSvR1ipZTjBxCofiWiSylkHePmTfBoWj7MfRdRpP0P6fbQh8phX1hJI3Q0OY+q0TxQmmo
	42Bg/FVTxtTc4WUQ+fyVyC6rGPpShmpGdAYlDM7gpqDnL1NKTmzasTd8it3Eug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1731620323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=OYm0g8k3fBxj7KfPxV6h2Ev+gtxx8fg5hi3oMeVyzxs=;
	b=Cs13CmS4XfG5YIDmDpID2Pfo6pI8pXa1KjACUpRcowCFXLy+lQ3/kPg+FQf07Y8CRJpm1f
	kpCE0+tYTSl50mkKQeh2LfMwXd5g9kmPZ6uK+1ym411d2qcF53fQsw9z18fyOX3+DzlMI1
	2hMITPaIF3QC0lTotCEKm2eLpt5cMhV5H9GeintOdVqz+mNl/3XPQ94Nmlup1woAwEplL3
	grO4Uo9YSb7tKrA8knMADBMbO80qkGNHx10GmLmkDpq7iGR/eIR4KidJ157xuMS4AXla1x
	lb2t4MjpvbkTwDEO+pt2pXJBkKvuMRIizhNCUj/R+zFfjJc5rmSX5S+IqGvoUw==
ARC-Authentication-Results: i=1;
	rspamd-645676964-kdvg4;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Reign-Glossy: 2ae9610077860b20_1731620323429_58666898
X-MC-Loop-Signature: 1731620323429:2798751667
X-MC-Ingress-Time: 1731620323428
Received: from pdx1-sub0-mail-a233.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.111.109.236 (trex/7.0.2);
	Thu, 14 Nov 2024 21:38:43 +0000
Received: from localhost.localdomain (unknown [108.175.208.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a233.dreamhost.com (Postfix) with ESMTPSA id 4XqD6p2QDhz7d;
	Thu, 14 Nov 2024 13:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1731620322;
	bh=OYm0g8k3fBxj7KfPxV6h2Ev+gtxx8fg5hi3oMeVyzxs=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=WGITTmloaS5QLfK1q9SZY4QfLTOaXiwk3D6iQvxwsOTVE/ROp9TBx91GEMfb9dSHP
	 6SsbN/qgX8gG6a5Vay0r2nHFh3SGq+D7/cyM5/N2ny7ia6rnuVSDmAMJE/BFvFFrDC
	 PXGygj6KUPRqHDG9iG5xg1fXdTGdBhKd2oM9T/FYbocmGiq8LluBr6TDLcMdQ1KcEE
	 Ov2T5LTe6i6Ld+bjranXzMc/lNyLEJYhVmP7fuydfX3sOAT0gKwWf3/Uxn9HRdnFmx
	 ETFXJmg4Ve13WmGnWqlcWNtmpCBBaRsqdwJdeAuBOXIe1sy6xvdVrb9GVh6RuXmG9+
	 YeXxhzJj6Td5A==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com
Cc: dan.j.williams@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	linux-cxl@vger.kernel.org,
	dave@stgolabs.net
Subject: [PATCH] cxl/pci: Fix potential bogus return value upon successful probing
Date: Thu, 14 Nov 2024 13:34:39 -0800
Message-ID: <20241114213439.6022-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If cxl_pci_ras_unmask() returns non-zero, cxl_pci_probe() will end up
returning that value, instead of zero. Found by code inspeaction.

Fixes: 248529edc86 (cxl: add RAS status unmasking for CXL)
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 188412d45e0d..01092e5b3b46 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -948,7 +948,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	pci_save_state(pdev);
 
-	return rc;
+	return 0;
 }
 
 static const struct pci_device_id cxl_mem_pci_tbl[] = {
-- 
2.47.0

