Received: from tiger.tulip.relay.mailchannels.net (tiger.tulip.relay.mailchannels.net [23.83.218.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D592EF9B3
	for <linux-cxl@vger.kernel.org>; Tue, 17 Jun 2025 19:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.248
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750190141; cv=pass; b=ZkN5hsk86VXBF/onTgW1LDedOtnk5ZU29VaBWpum8w+wOlOliIdpVaRfVwkoXVuYLzZ93eDIMhTkHj0kxRIFijvrQ1HRODroeDU8u4mWd0iTXHZzAEZTrU45+Ib3fIVjJKU8iQY0Jn2QWlKQCijzLG7LGCJMDx/EoyhcUCWrBtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750190141; c=relaxed/simple;
	bh=aX9z7WWQtjEhO3xjpaXnd4v5iT6+hn3JatK/3K+oat0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZrKlLtSg5dE1+7aRRI5DTomzglruXqwmhxlp/EEKIGKx0zmPn7UZwucPca7aV9lgQhMKSYusdEV4EmAY5fqA/9THhAh0efJnKSdSMtu9mxQXeei74ed0XFU1H4P2No6hbkAkmnQLXi60fH9yx+gVH/4b+W64Z7Vph2QqQgtDnx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=b+tN/MXt; arc=pass smtp.client-ip=23.83.218.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="b+tN/MXt"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id CD70424EEA;
	Tue, 17 Jun 2025 19:38:06 +0000 (UTC)
Received: from pdx1-sub0-mail-a289.dreamhost.com (trex-green-1.trex.outbound.svc.cluster.local [100.103.64.67])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 6103924DD1;
	Tue, 17 Jun 2025 19:38:06 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1750189086; a=rsa-sha256;
	cv=none;
	b=nGlBiHgUgWyRkBbmQnKj6rgALvUMo82SuMy9Z8JXNvy2fBViwvzkxX36FC12zTHJynodIv
	CIn1OB77o6fouynuQLAaEd9ihC2vem6q//FQlxDyEgrh25mXhIlo4j6xx3qSF3+2ztQ2P1
	7kp57rh1yPUBhsGi9s+ECv1YLSBafV/wZoIiVJYu7GiMVxk7zNcFA0j1PYUmHNxe3sDxkt
	1hdC9/bYAdF/5Ho2oVrO1EvaMAZmqnWsteWoyI5vLMqvlB0EkJ1AIlL3NjO8ExYnjBhr4a
	DzOvNKFUCmmm+ji+ZvidQM7uyU+s6tSDvBhY3wV5/7cTY4IjOIIFY4yl5TZmlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1750189086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=zjMQtsWtygLjQGtpmh3FZARXXqU+GID18y4tEGp/2zI=;
	b=movXgVxYqiMuL8fP2+7ryG4gbhYZXjjxT+So5M21ES4Xndqf3TQjt62/3ylD8skMRUTFBE
	2GxRhEhIDn82mAviv+UEmsCcfRFFF1FO2213181bki1Y+Q8rlUoOR4Yk1kwaK7TrBn6wFh
	bzdWYhPnoYaHPI7+vwiPEwFdYMX54g/lis9ULOIDDXs4emc62hZ16Bq481JTE2DgsN5JeU
	8jjWs9r76BqPllVKbZgkZ7R9Xgnyr9zTnif58dX2lsDBkCenGMJo6BFM8kewn/G0RCuLNg
	p9sGmS8rHncdPqgm0V1kZCP9ri8kYI8XNyDflGmugv9IvpaRdAIeU/BE3ecxcw==
ARC-Authentication-Results: i=1;
	rspamd-5859dfb5d9-d2vbn;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Grain-Glossy: 7070ca686ad255da_1750189086726_2236307997
X-MC-Loop-Signature: 1750189086726:4230723635
X-MC-Ingress-Time: 1750189086726
Received: from pdx1-sub0-mail-a289.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.103.64.67 (trex/7.0.3);
	Tue, 17 Jun 2025 19:38:06 +0000
Received: from offworld.lan (syn-076-167-199-067.res.spectrum.com [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a289.dreamhost.com (Postfix) with ESMTPSA id 4bMHGP0BsWzJX;
	Tue, 17 Jun 2025 12:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1750189085;
	bh=zjMQtsWtygLjQGtpmh3FZARXXqU+GID18y4tEGp/2zI=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=b+tN/MXtXEyFqa8JOX+pKnvhLaNyAdTkJRY6pSgM2xHKgQ+kdO16oOlc5TMNLey2N
	 93qs1x8NJl1hfLKXFgcnXQWapf4U21j/UmiXIyjASNo4xRAqrgCQ6BtPbnAidi6/Ui
	 BfTkq4NDSW7MVrEhefciM/ov1/6bgzIDorhOp2waXnk7J7kL6OU2i5DL8o07lja4ZW
	 bRj9JAzKDzM69hreWCc2Qyyrb4IZ13ErAukdQyFdJ2nSpMrI3hOCDBw4l0JE6gatBa
	 IB80tXiNa8ftY/4RbNLj6QTxHPpGXB756+APtex8gFzYEc6bHaPI/S/tfeYdYGcsDC
	 ezFEb5GnLx4cg==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com
Cc: dan.j.williams@intel.com,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	jgroves@micron.com,
	ravis.opensrc@micron.com,
	fan.ni@samsung.com,
	anisa.su@samsung.com,
	a.manzanares@samsung.com,
	linux-cxl@vger.kernel.org,
	dave@stgolabs.net
Subject: [PATCH 6/7] cxl/mbox: Shout upon async bgcmd race
Date: Tue, 17 Jun 2025 12:36:10 -0700
Message-Id: <20250617193611.564668-7-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250617193611.564668-1-dave@stgolabs.net>
References: <20250617193611.564668-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make the condition a warning, as the mailbox will be corrupted
on such cases, which may trigger harder to debug issues down the
line when simply returning a common error.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 6ada0f502914..6404b01b64c9 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -326,7 +326,7 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_mailbox *cxl_mbox,
 		    mbox_cmd->user) {
 			int timeout;
 
-			if (mds->bg.opcode)
+			if (WARN_ON_ONCE(mds->bg.opcode))
 				return -EBUSY;
 
 			/* give first timeout a second */
-- 
2.39.5

