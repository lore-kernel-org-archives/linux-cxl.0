Received: from skyblue.cherry.relay.mailchannels.net (skyblue.cherry.relay.mailchannels.net [23.83.223.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DB51BD9C1
	for <linux-cxl@vger.kernel.org>; Fri, 20 Dec 2024 16:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734712703; cv=pass; b=nbbxiOeUj6KStuoz+HBJgI8nHFN+nT+Nrte1StYXLO6ERZ/oY1ozkzS/4Vb2wPzlizijtjEJYumj30BifBxWJEpxkfi6ZrcPRz2nlYEjHwqNN0ZFpshK+3SwM+QNrZRr0GgLvZc8PYATmQ5slcYspV++tVZW0oozpSZzdDLr27o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734712703; c=relaxed/simple;
	bh=Efpg4p8u2xuzT4D+SVMo5m51G0AuQqpI2RIywE0g6S4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZApx1/3uuK/olANtj/jlAmjVS75d6QYsrIBt5F9SvztUVezwNaEQJxnF+wsc17V1MXJPGCmX86AtJCy1bsKnUEDg4cXIbGlUcwr6aTGDdNBYqTjEvsy/ftF+piooMviJi4yQ/mPc62RDX+jSfjI9NgWZ/P1smlF/5GoXGw7Ug9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=ZdnRYYoS; arc=pass smtp.client-ip=23.83.223.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="ZdnRYYoS"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 8E51D7825D6;
	Fri, 20 Dec 2024 16:00:32 +0000 (UTC)
Received: from pdx1-sub0-mail-a227.dreamhost.com (trex-6.trex.outbound.svc.cluster.local [100.103.151.188])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 3232A78142E;
	Fri, 20 Dec 2024 16:00:32 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1734710432; a=rsa-sha256;
	cv=none;
	b=NmNUDTA7/dYRBPU4jpgFwGGf8ENmCCtdDAnE2vtGk939/uuaB3Gf68zva1sd5pTlVMf/Qc
	PCqr/NjS2jJxNM9VXfkSNcRPqzSAjAwcn4Pqh78Zk9qsMqlUTS4/RzqJWBy36cNdxk9psc
	pXkUqRci+i2zv167myoG7gILFXnUWSpR1BfY1HkJ0jJBMboAtMzDVptrGOB3TXLW2SWyg+
	RkqfWlFVHdt4ZQPi4qqU1bUOtNq5UrsrytvPVdmbUCHekzrscX0gMhiulN6lk5M1rw5V1z
	P8q9AMlradje4qnYeFFciD3JgsTTCmWC9aV/M8g6lFgscjLQAROUllErIOc+8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1734710432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=1ZQb0ZqlBuM5Rzz5ZXbTKtufcYiEwQv0eRm+Ift9zAQ=;
	b=aU6yyMnFyQUUAaDodzb77wgnaGjcmtgeg3XYAN3Jdnyi8u+/HWsQfnA77qOGHNJ6NZoglM
	KkBC/gIFSxG7sK6nKf1ThuiPMUyw6ibeOmgTW7FDJyJlVx51rEnKTmqFRUD7IVppeJM+Yn
	vjo0gTpEPptKevRN9pZivswHQRQW+ue6L+CpsMvY/xz4M+gwmg7YaCwm/oRr8sEeOoaK7S
	LcXBHp/rUIUcNqBSRq81VyPtqklfuMHARt7yx18CsQIvnm2/9htn0ojPfdRCpbKNnZpjT7
	XnbkLA+QwDdRESt86IFcFZnxAKXqiu4p0ZHQU5Wq1+2UfIAUpOTBj22MKi8aQg==
ARC-Authentication-Results: i=1;
	rspamd-7d788bbf85-g6lq9;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Shrill-Spot: 475b8a037fca168e_1734710432438_1033846240
X-MC-Loop-Signature: 1734710432438:2948546948
X-MC-Ingress-Time: 1734710432438
Received: from pdx1-sub0-mail-a227.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.103.151.188 (trex/7.0.2);
	Fri, 20 Dec 2024 16:00:32 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a227.dreamhost.com (Postfix) with ESMTPSA id 4YFBvz4KxmzCv;
	Fri, 20 Dec 2024 08:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1734710432;
	bh=1ZQb0ZqlBuM5Rzz5ZXbTKtufcYiEwQv0eRm+Ift9zAQ=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=ZdnRYYoSZ/fq4TNAiNloWHY8TZqAGZ6GBtfbWlyQU8FhlGfLBQfft2wkG8jlQ5mhT
	 xzEpJSO8a2/XNMgsI6vnXMzqf2slltxAXsvbVnsQw1bXvWVlSbMqzxw1xIaGZgzess
	 QunXTj4H371/yLsVAvw6hswwmixSC4t2QWSwNvy7lYA6TrWOAE0GWCunw7NNCenQtg
	 FJCpG9dp777KF+bcZANk36edyb50GHEyamusEEIrhdk39JCVPCuEWbxRUuM2oqeaJG
	 mxGJNL1SZPsY1zwG7DGRtzVx8qdzZw1eUqUmDJ8VeJpEHK8UFePBK8s272Fl0MHM85
	 93UAbk0FmLFfA==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jonathan.cameron@huawei.com
Cc: fan.ni@samsung.com,
	dan.j.williams@intel.com,
	a.manzanares@samsung.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org
Subject: [PATCH 1/3] cxl: Fix mbox cmd enum order
Date: Fri, 20 Dec 2024 08:00:24 -0800
Message-Id: <20241220160026.204055-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241220160026.204055-1-dave@stgolabs.net>
References: <20241220160026.204055-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the out of place commands into their proper place.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 hw/cxl/cxl-mailbox-utils.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 9c7ea5bc35b8..f6f993e7bc4f 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -86,11 +86,6 @@ enum {
         #define GET_PARTITION_INFO     0x0
         #define GET_LSA       0x2
         #define SET_LSA       0x3
-    SANITIZE    = 0x44,
-        #define OVERWRITE     0x0
-        #define SECURE_ERASE  0x1
-    PERSISTENT_MEM = 0x45,
-        #define GET_SECURITY_STATE     0x0
     MEDIA_AND_POISON = 0x43,
         #define GET_POISON_LIST        0x0
         #define INJECT_POISON          0x1
@@ -98,6 +93,11 @@ enum {
         #define GET_SCAN_MEDIA_CAPABILITIES 0x3
         #define SCAN_MEDIA             0x4
         #define GET_SCAN_MEDIA_RESULTS 0x5
+    SANITIZE    = 0x44,
+        #define OVERWRITE     0x0
+        #define SECURE_ERASE  0x1
+    PERSISTENT_MEM = 0x45,
+        #define GET_SECURITY_STATE     0x0
     DCD_CONFIG  = 0x48,
         #define GET_DC_CONFIG          0x0
         #define GET_DYN_CAP_EXT_LIST   0x1
-- 
2.39.5

