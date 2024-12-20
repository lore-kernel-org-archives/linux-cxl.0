Received: from toucan.tulip.relay.mailchannels.net (toucan.tulip.relay.mailchannels.net [23.83.218.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A14199E8D
	for <linux-cxl@vger.kernel.org>; Fri, 20 Dec 2024 19:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=23.83.218.254
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734721517; cv=fail; b=guTaTaJ0f+br1UKz5JJzZIpzPbp5yjghkN5uDi+TfSMbfWsi7Ct58zOtDyJJ3+7n/78ADsCNoQiWib94Kdwe+9DHDcNdqSEHzjnWwTU8qCn2O/28k3s6PlH31sseQhn1QY5EhSP25zoxsqVpX/t0uL/u2Wmv7WdP4UCFDyQyBaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734721517; c=relaxed/simple;
	bh=Qs0lzuuM209lPCqgU9l3lbgBL80aIJoXZyVyZ8gjzTA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nkczyyQi+/hjBEz7hEpNQBKdY+j1nDhRK8NSn84YL+gUawXUZCGr5Xb/hbTtHw+jh/XwQNqM1qzOygi7ZJn7Rxm/dAXhYkkK6Ghp5Qw84qEvPy72v9fnedYBToBuWDbXz+Pi9z1ShmwXbczBTklEhorYK2/pTezZnpOWlb/qDxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=h00N2M9P; arc=fail smtp.client-ip=23.83.218.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="h00N2M9P"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id E75CD4E5175;
	Fri, 20 Dec 2024 16:43:46 +0000 (UTC)
Received: from pdx1-sub0-mail-a227.dreamhost.com (trex-1.trex.outbound.svc.cluster.local [100.106.33.149])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 7C9D34E4B02;
	Fri, 20 Dec 2024 16:43:46 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1734713026; a=rsa-sha256;
	cv=none;
	b=l+GxxsDZlH+QLkx4Zebg53/hSFQBqPR48NnrLfxTThKkXjjPocslKWrD8H0gEMCTJ/9D+h
	lQaij2AgoGYamN9TRDmFcIGYr1m7segnU3mogZCogX8GujdI2sZlc+F2WL0E00+ip19tET
	pSbuqYV2BrcwckbUzTTS6D6H+SMel2EvCttftrmyn2TgZKUdk/QnOffElbXX2eS+UyOuOk
	IrD6+P6aC9IKxrh+5jNtXbRrxzOmsRNRrTnbdJv/NX8VA/yJ7hXhnHFGu9uoqS0I3e1Vwa
	sgR4W3cXcIjeIRXes5t94ck3ubHWiZMmS90i9mHCbtLxphoDYsVcvqNJLqwFHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1734713026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=p1QOa6E+ADU1ZB8LzYw4BcNghw4Kv0QvfaQj/piO1vE=;
	b=Bzlw7O9PLCTQAzUmrgUFZYdV8kPT8gfWvQl1oM4jmLPPtscZfS6APPSHu8oXrEOCAWWA1+
	HsnGGkJspgOMRL9K+9LDuKgo09U3bedzeWAEUqXY2p2fljUCDBXwOmYo9hRccUzxkSU66+
	ujy9Lo+LjX+vJYAEUZupEtXmyFycJMleZPx94ebBBnveLUOjfXkXuaIlP2irXuWLPOXmC0
	CHdMh5j0LxXLzSJcYLs4vPJGEDNcrSxlE5uxeOf4qI1YSl4jv1Rc434eTemgqVGOc5iNJI
	dKYEebVlUnxVZA4yW84dMI0qOd7L5TW3dH5Fmlj12aoEs4vIthTEBn8laebydw==
ARC-Authentication-Results: i=1;
	rspamd-56bf78cbd4-tsrbq;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Bottle-Arithmetic: 79ea9b60196c31f5_1734713026812_71358791
X-MC-Loop-Signature: 1734713026812:2154941353
X-MC-Ingress-Time: 1734713026812
Received: from pdx1-sub0-mail-a227.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.106.33.149 (trex/7.0.2);
	Fri, 20 Dec 2024 16:43:46 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a227.dreamhost.com (Postfix) with ESMTPSA id 4YFCss4cwWzCv;
	Fri, 20 Dec 2024 08:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1734713026;
	bh=5ehXfeXCkTL+2C1ar6EXUWGf1qEOIryfZclKJ1CqQ5I=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=h00N2M9PCkKcuHrmVtIe6gb/GVjXg7Xm1U66xSO5AA0BnCS3e8+ulopXF96G7hop+
	 J7HedliH9NXqG7NEF9hHzokgR1TedU+dopKIpRGhFdnHbWZCl86jY4sqNf3x0LGrIx
	 jc2YZyVdznKHpcVKm/+m6ACXylFAHOjY/FSRmNArFei6mW8bjGD9cl0kyPdvuA1bpp
	 b5l7xWl6jrZD/BvCRZroGSqYabky/PUeqj5YTL105nNXjAxuLrskKuXKJCFMMs+pGt
	 9voa2445JHTz8Rwa/FJmanE7v9mwNX3nMFLqDxZ89wly+jBksH5MrxfOWdPy3ZbHu5
	 l0pn/TyUxLYVA==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com,
	dan.j.williams@intel.com
Cc: jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	seven.yi.lee@gmail.com,
	hch@infradead.org,
	a.manzanares@samsung.com,
	fan.ni@samsung.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org
Subject: [PATCH RFC v2 0/1] cxl/pci: Support Global Persistent Flush (GPF)
Date: Fri, 20 Dec 2024 08:43:36 -0800
Message-Id: <20241220164337.204900-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Changes from previous RFC:
 - Added dirty shutdown support such that users can tell via Health
   if there was any data integrity issues. This patch is still marked
   RFC because while in fail (GPF) scenarios that successfully flush the
   data the dirty state is cleared, there is no mention of the regular
   reboot and shutdown scenarios:
   
      o Is the spec relying on the driver to do so? (currently we can
        only reach hot-unplug for this). Regardless, this could use some
	clarification in the spec.
	
      o The spec only mentions reboot/shutdown in that it sets the dirty
        state upon data integrity issues.
   
 - Limited max T1 timeout to 20 seconds (lockup detector default)

For testing, there are patches out for qemu (dirty shutdown):

    https://lore.kernel.org/linux-cxl/20241220160026.204055-3-dave@stgolabs.net/
    
... as well as those shown in the previous RFC:

   https://lore.kernel.org/linux-cxl/20241205082101.1193038-1-dave@stgolabs.net/

Thanks!

Davidlohr Bueso (1):
  cxl/pci: Support Global Persistent Flush (GPF)

 Documentation/driver-api/cxl/maturity-map.rst |   2 +-
 drivers/cxl/core/mbox.c                       |  17 +++
 drivers/cxl/core/pci.c                        | 104 ++++++++++++++++++
 drivers/cxl/core/port.c                       |  68 ++++++++++++
 drivers/cxl/cxl.h                             |   3 +
 drivers/cxl/cxlmem.h                          |  24 ++++
 drivers/cxl/cxlpci.h                          |  64 +++++++++++
 drivers/cxl/pci.c                             |  97 ++++++++++++++++
 8 files changed, 378 insertions(+), 1 deletion(-)

--
2.39.5

