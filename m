Received: from butterfly.birch.relay.mailchannels.net (butterfly.birch.relay.mailchannels.net [23.83.209.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D652078F4F
	for <linux-cxl@vger.kernel.org>; Fri, 20 Feb 2026 00:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771546588; cv=pass; b=BdZYgeuHs+aZIq5NSV7lD7UemSDTzTr4L3Kgc3E9bcnwvm2lhnwXAp3+EH7SibPwcVi0tWFin0y2+ZN5Oof3asXoPD7xOS09KpVk7/SPL7x1VfkaE6xjTBab7fyLthj70Hn3cbFfoW0nY8I0bJBUdTT+j17SZjWKOdiaKiHcI+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771546588; c=relaxed/simple;
	bh=5cGhmzX0CirmULj6sswS+TGRO3oSihHiBVY2j58gjPI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dZ3cNQQ3PoT2osDaVrfSaL5WsKZyHPEJn0CEcTwZyXIPEYL1iwU+CauErnMGZDmaQ2dm/bx0QeZBPMluVKuyjyl13wpl60nZlE8BMqOQuBXOWpsVD/3uMhDdgwpj/btzWabbXudNnpK81KwEk5LtDUJDcrngKF0VakqoHGKW4k8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=OhzMcisU; arc=pass smtp.client-ip=23.83.209.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="OhzMcisU"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 10186822DB7;
	Fri, 20 Feb 2026 00:16:21 +0000 (UTC)
Received: from pdx1-sub0-mail-a248.dreamhost.com (100-99-123-38.trex-nlb.outbound.svc.cluster.local [100.99.123.38])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 9ACB6822DF6;
	Fri, 20 Feb 2026 00:16:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1771546580;
	b=V7Hhpr5CjU6Kql+HuYyfydyOgcmr8As1zdhg+KFhODHDFDLnqQmJyrGs9qpUvHE6rqZIsc
	M0m9b3US25KsngifuvyU0ta6ac6lCaod8dNVFwLnLli58sHeYRng4ItBwKoBFx5VF8Lx4f
	LaSs1vnoADcAZa6j8zoDZnWZnnQOIDIQARSU/1wzf35Y6V/1ePm0iuWsZyQcJbWSMog7K1
	phbQQ7Q5ptXxfyAKHr0tOhE5skJhERlA/R4mTuf9ThS+5Gtu8Kai40PwqhNGK0BsISLhUV
	ftHSImqhQ/L8SQKSPwIQzlYMhtJ3zna7RItpPIDaS9+/8RMSX80mHwxG+EH7Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1771546580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=MYKmUMik4qCvF5z1LuBzSws2Ii2TJLFJppQxpM1+HH4=;
	b=seKFcmG41Vt4smckbK49o228v1GsFt1ZTGNpblBJe7il5PAEzb+/chgklmPKyTksydIKnA
	7OzIl1qAZvdNH6/6C7puQBhWEI25dO/c6DEsJEdG7YBaZHYhBAnzz8KFjQnD67w6QUUjIc
	ER9QcaP5SpjEBIQ1JrWSg4sLTfTHBQjenQceV7ZchIApHOGgMELW4J2rsOH0/ACZDgnfOS
	5BVaZFRwcSPwESUC49rTACnfcpqUCXwNlcs0VJP4ythFAupXnP+ILAuX2EYYV+u8Rv+qlP
	tgETVb4Vz5InP9/Wk23lYDQS5wgHWOQahEnZ+DkMiVy2HCerVyitjAAtxWnlDw==
ARC-Authentication-Results: i=1;
	rspamd-659f7bc6cc-mzsps;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Decisive-Imminent: 75ecff580ac4f73b_1771546580891_3447882535
X-MC-Loop-Signature: 1771546580891:3672396179
X-MC-Ingress-Time: 1771546580891
Received: from pdx1-sub0-mail-a248.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.123.38 (trex/7.1.3);
	Fri, 20 Feb 2026 00:16:20 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a248.dreamhost.com (Postfix) with ESMTPSA id 4fH9lR7274zyr9;
	Thu, 19 Feb 2026 16:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1771546580;
	bh=MYKmUMik4qCvF5z1LuBzSws2Ii2TJLFJppQxpM1+HH4=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=OhzMcisUWZfUCQjBMLvvLUXLcQDKTa4X/iNE1UchrUaONvyPJBLQ45MnkKEUeBVMJ
	 tS9tyNJkqMfvjak2ASU7VX+nx2lTc6Gpy5oTV6Q7nhE+OfP6uIlgOjTz8W+L1MZXT9
	 MqJiEf5nDBULn//JrVRpPUFHTFTsqecw4N0mmAvdQyT3oQMT52y7NiRqERf1rK4dXY
	 P0VrR6JJQd64uDNqOvoaZYFhPKb+GhiLs7MCn1/yoc1CRYIsv6nXOeSJUvBWviWVT5
	 UOZydpBgTRrbCTx1GOGnHyOR3ROfKC/nVqMtIE0vu0sRjNYsz8rNAbEIpZHuH7nAB8
	 EYPo5LFANxE6w==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com
Cc: jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	linux-cxl@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH 0/2] cxl/mbox: fix undersized payload handling in cxl_payload_from_user_allowed()
Date: Thu, 19 Feb 2026 16:16:16 -0800
Message-Id: <20260220001618.963490-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

The first patch fixes a KSAN splat uncovered by cxl fuzzying, the second
is a follow up for maintain proper error code semantics.

Applies against 'next' from cxl.git.

Thanks!

Davidlohr Bueso (2):
  cxl/mbox: validate payload size before accessing contents in cxl_payload_from_user_allowed()
  cxl/mbox: return appropriate error in cxl_payload_from_user_allowed()

 drivers/cxl/core/mbox.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

--
2.39.5

