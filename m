Received: from silver.cherry.relay.mailchannels.net (silver.cherry.relay.mailchannels.net [23.83.223.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014341D5AB7
	for <linux-cxl@vger.kernel.org>; Fri, 15 Nov 2024 17:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731690737; cv=pass; b=lrJ0vyRpWXHHGelVCvrUHbC7SdDM6ziEAu2ORpwl7EERk6lCIPSuqTAYHuXgXeGyoflwKztWgBk1/SZNK9Aox0zYrd0CgZwANdRV7Ou5sIO5blUkrRZSdAZBJ1J0PKr3H1M0uZ/VASM1Q8q39N1EXEPgFFUozbPLnulg3P1mVMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731690737; c=relaxed/simple;
	bh=y9TLcZ7Khph8FReEO75XJVXCB3I5ATLumsV0jzHPWGY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dtZ4VhkAEgq1E8Af5Tvmn31ipPq1Gxgwb2wHPizXw/pX/kn5uhM+o2WoGsEWEiNYxny9/HSTJi4rWa3xlI0j7dcbWIXPD14mJ1YUdyQjehOJN8gEVez/m/UfeP00mQYyo4r2qVieDPmwoJlHedcU3w2bgkyLau4LixwKTzS0LAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=myfpP21l; arc=pass smtp.client-ip=23.83.223.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="myfpP21l"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id A2E8381FC3;
	Fri, 15 Nov 2024 17:04:37 +0000 (UTC)
Received: from pdx1-sub0-mail-a291.dreamhost.com (100-109-10-188.trex-nlb.outbound.svc.cluster.local [100.109.10.188])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 25A5E80E2F;
	Fri, 15 Nov 2024 17:04:37 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1731690277; a=rsa-sha256;
	cv=none;
	b=UiitiXMG1zvRNMWj28PKSQfqJ5xkSEFPj1JZsA5FKQtQMBrouxMX80MMv6Io89b1CqJjWK
	Cv2SAwF/6hoHsIKlMadM10HMnkyeDMMMMQ7kS45p1G5SdCxkNGN0wvc0dhPTLau90HZCB6
	DksRr80Pnvukr4sdS3iJfGUdNJYPkhpqNPGOAtyx27R3hM8SUVs1ClwjZRzXivXik//7bb
	DZfqhrC644WGyU1IogEaufkMh+XmVHN1qA6z1GezvBxnANjjHQ3CMAFFF8FYUz0ZeRlACS
	iOQhUs9UuJ7fTSaQZuSXNF80atAYkG0bnGiP2CvF25mVj5jiMjcJCCRiSjl25A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1731690277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=cCATYwjbP9Q6Dx1SrBNXaP1ifcOA8uR4i0plODJMVXM=;
	b=KQ3dGfJTIpvj2Es3IFe1zsWvhpzqMz3N6194ji42xAFiNsK7yWWOqn59F0Eyu3ybSBDYJU
	m/HTmWJvbFuu1p82xDv5MoVJDjgxLMLqkIQ3bpVbd22rs1vlp4CIfDB5svtVU60jFbDA5U
	xv5/0J8s7Dl+M8Jb3o4w8oP4SrDHIUeBe2wOE5EHtiPq+FYSCTW4jYpusiTbUbLHoVjOEo
	Ca9zaPfcDiLsnVV4zxfzN05G98q0AFMaDbktiBX7SImq46Rl6PTUIlNdyYEEsf5hqahcap
	WpFW8wwoENugzeJaUbzS9eXHjdbvq0XDr3A+foybzg1DaNy36Lr/WfOQ+E7psQ==
ARC-Authentication-Results: i=1;
	rspamd-7456989c76-4mhx9;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Wipe-Obese: 0e076fe211d9498b_1731690277530_600705341
X-MC-Loop-Signature: 1731690277530:29679083
X-MC-Ingress-Time: 1731690277529
Received: from pdx1-sub0-mail-a291.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.109.10.188 (trex/7.0.2);
	Fri, 15 Nov 2024 17:04:37 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a291.dreamhost.com (Postfix) with ESMTPSA id 4Xqk042M3xz6x;
	Fri, 15 Nov 2024 09:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1731690277;
	bh=cCATYwjbP9Q6Dx1SrBNXaP1ifcOA8uR4i0plODJMVXM=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=myfpP21lH5/a6a5S9dLbVywpMmd1bpg+Nu4fvIg4GR/O3DR87RhdR33bqwZB12zFV
	 6EgrMeIqGTOL9TuCsmKyyx4oksj/ArzQYrP6TjZguxhd2FMyYyKqhAexxDuANdI4bm
	 bWcPPIhP6JZAmBbJ9jwyfXKaAYRz09iyfiOpMjXo22UuRc9tUTz2AgiWHUM4hfGxXH
	 mPfGgnh7tF3k39jDi0JFxj0A70hSIMgzNZok8U0URyAwhHt+mcCwscnrLcRJHMNW3o
	 0wrF8WfaGXmGU+TCPyK8eKRdsXgnqZ4Nanu07JI7g6E1xjigUFWyyYrVJel9AXJOOe
	 Kkp5EC62sY/Fg==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com
Cc: dan.j.williams@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	fan.ni@samsung.com,
	a.manzanares@samsung.com,
	linux-cxl@vger.kernel.org,
	dave@stgolabs.net
Subject: [PATCH v2] cxl/pci: Fix potential bogus return value upon successful probing
Date: Fri, 15 Nov 2024 09:00:32 -0800
Message-ID: <20241115170032.108445-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If cxl_pci_ras_unmask() returns non-zero, cxl_pci_probe() will end up
returning that value, instead of zero.

Fixes: 248529edc86 (cxl: add RAS status unmasking for CXL)
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
Changes from v1:
 - Picked up Fan's review tag.
 - Continue to return rc (Alison).

 drivers/cxl/pci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index b2cb81f6d9e7..2012301fcfbf 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1032,8 +1032,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
-	rc = cxl_pci_ras_unmask(pdev);
-	if (rc)
+	if (cxl_pci_ras_unmask(pdev))
 		dev_dbg(&pdev->dev, "No RAS reporting unmasked\n");
 
 	pci_save_state(pdev);
-- 
2.47.0

