Received: from dormouse.elm.relay.mailchannels.net (dormouse.elm.relay.mailchannels.net [23.83.212.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83B353E23
	for <linux-cxl@vger.kernel.org>; Mon, 13 Jan 2025 02:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736736783; cv=pass; b=P30AToFsmiNkySsZ8lLaScu5hmOm9lAGgDYvQ90hafuL+Wcwe2Ybtzwn1pGjA1WLuH7gCIRLCslmAU1Yf7oICc1rHLSpqqLiP8dwUq6wTLVZaEKKqmtEU9vXoOGpGRr99v8zc5UaByPD9qvvmM6XAnta8xl6pod8Nmq4P2okBug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736736783; c=relaxed/simple;
	bh=TjhV2EiStncTwJctQtVRqLxrcE8wft3davOR07KW6Lw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mOMCvPyW4Ax6hQs8Rvhk8FaB02XKoeyCdFJWnLma3Lo+4nCN3Rfi+mAis/665wosqzlqBUURnuPOi3MzkvbN6Z/D+Cu3Pw8IDPNtKhh0vy2Z2z4XqnJNFMer6QTVDJTRw/E4MknTd79KwBbeoGvmKPlK8h9kxBmYWxT1oblPvMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=MbsQ6r+X; arc=pass smtp.client-ip=23.83.212.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="MbsQ6r+X"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 0D01F1C1BA8;
	Mon, 13 Jan 2025 02:52:55 +0000 (UTC)
Received: from pdx1-sub0-mail-a293.dreamhost.com (trex-3.trex.outbound.svc.cluster.local [100.110.108.105])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 909F71C0C2E;
	Mon, 13 Jan 2025 02:52:54 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1736736774; a=rsa-sha256;
	cv=none;
	b=DNO1Ux+oXdRNQH/NT6EI0vwfqIpLcnFHqnRGk2O2Z+kgAqCLej5RIm4Nw+OV2Hc1Dvfpel
	Tjhfo0eNXmxtzVRV5d9jmTrgBd6rm6/6ncDyGwxmGG/wRcM6dUPIp0z9rN0P0BB/iafLB1
	u0fH2eXt1+fCowb4mLGs/rvyT3YwD21gyTOrU1Hm/g2igGz6mDOimLkIOFl8jErBNErmPN
	jagxTJABnpJMYgJo72CKgXAfKMUN27t8cpWvbBLNe5QHoAY9SIMmkCL+eNCX6Wgr5uROZj
	2HYOFBx+9UAp1d/OH9EhSueUHNAw5F29SToOsezUN7iQ/VBNEfT/3m3VkiJ1bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1736736774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=WUsF3nbyX4soIK5yYueHp8UL7lqPEOQYsj2mqiC2t6A=;
	b=Hnl1OKLIbBzGe70AftCX7HYT1S86AG5PDpvcKXN+HXZu8OE272p2lodGQlq8YFNuz8PX8t
	znvq8I13u/vPm/P5gKby7qiqszA/4WTadOW52vkdleVnsBO5fqTzjGEq/Vgwm1LO5NjdYA
	hNAfFukHUvBYyPxt7uu1gBFcPkLS/bJecvyhUnyCEhMFnjcYHzo1Q83UW0vYdvVLqpffY1
	7UxNOq7YgvFBpS11w6fCYzk85cmzzPay4P9Xj1OrGWrwiRmSfj3D+rydCwWTtFXWvYI5YQ
	mLzZBfGBoOtP8aLASSAAua0epaeNudPnVbTPvaWol4hX2xJqsCyUtEqm1zQo1g==
ARC-Authentication-Results: i=1;
	rspamd-7df4dcbd86-6r7gt;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Keen-Glossy: 11db90882137230d_1736736774856_2703388398
X-MC-Loop-Signature: 1736736774856:1785708920
X-MC-Ingress-Time: 1736736774856
Received: from pdx1-sub0-mail-a293.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.110.108.105 (trex/7.0.2);
	Mon, 13 Jan 2025 02:52:54 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a293.dreamhost.com (Postfix) with ESMTPSA id 4YWcJ56mD9zB9;
	Sun, 12 Jan 2025 18:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1736736774;
	bh=WUsF3nbyX4soIK5yYueHp8UL7lqPEOQYsj2mqiC2t6A=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=MbsQ6r+XKZ4Xk4rMnK7Xbbf+n4Q/Oovr7BTzkApWmdy7RRsIWaS9k78A+JEXPwoWG
	 dFVrwunNjWw8hfW0us4MjRlniUwkGnMomJeOU+M8jzL6/2rlDm+1fbo2OYXULQf+aY
	 mt9tDaJpboT/psfXwyI29y2GUBKkWp2gmVErcksOrtslpm0FXlfO4zFkYnKK1k+mP4
	 s6UUllM1CKjx1RGr3PXpPtE4c1T91AtnOZe4k0IttxBExCEp/L8vZRft4XdqZ9h+uT
	 pI+j49b0ezGj1EBzUVn4tt3+QI3JCLSN/M+tJx0nXQsw1197Uh1vNFJJfzrodfE27X
	 7QyrVezW2INpA==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com
Cc: dan.j.williams@intel.com,
	Jonathan.Cameron@huawei.com,
	ira.weiny@intel.com,
	alison.schofield@intel.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org
Subject: [PATCH 0/2] cxl: Some ABI doc updates
Date: Sun, 12 Jan 2025 18:52:38 -0800
Message-Id: <20250113025240.327124-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Two small ABI doc fixes.

Thanks!

Davidlohr Bueso (2):
  cxl: Plug typos in ABI doc
  cxl: Document missing sysfs files

 Documentation/ABI/testing/sysfs-bus-cxl | 26 +++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

-- 
2.39.5

