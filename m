Received: from dog.elm.relay.mailchannels.net (dog.elm.relay.mailchannels.net [23.83.212.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98C8271448
	for <linux-cxl@vger.kernel.org>; Thu, 19 Mar 2026 18:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773945802; cv=pass; b=eY8gsmWuhkveX2yT7n2JYUtPthF/nFO/aFkZ6C3duIcUmjUhJfkkW73xuslDTk7yviJX96uACFrLdt0XTiapbCGXi3mx0sTczkF0sJ3VbeBpUCO5piwU+J0PlodO00oARdQ9O/Sw8lwBX/KrJEOY3kgS/UNjl1uQPJ9kzuk5CBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773945802; c=relaxed/simple;
	bh=eDZNZNoYRCDfE5mJtchdFBT/VNfp0BYvZOu0XRFUHhs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qhqBSg1nKcZ41UcE1txtg7ASGlLwyAJhgncFq+UhJmPYIJhSl3xSTu34Bj3T9Le663VZgCMMG7qOBKqWhlsq28HlLjARpA02AXLshtIjTxrHTYzTzwflIyIb1CeLEaSEgSPgK9ysc8mBJRuAXqaSXJjWxPmR3fo7/iqhUWcb7iw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=p52jZUlV; arc=pass smtp.client-ip=23.83.212.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="p52jZUlV"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 04127223182;
	Thu, 19 Mar 2026 18:43:14 +0000 (UTC)
Received: from pdx1-sub0-mail-a227.dreamhost.com (100-115-72-182.trex-nlb.outbound.svc.cluster.local [100.115.72.182])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 96ACB22317B;
	Thu, 19 Mar 2026 18:43:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1773945793;
	b=6LS2OIH6t2VkYK+I71fKVDkUk5ydhA0/R5d6YFDeyEvi4dZkNxZPDDjCi226BNwsG08YEZ
	cBpxoQBxG3/zZ8YC6odbCo3T0yNHcgTHoKnQgsqzsO5GW+R1INqHAP6LbecmuagT1zj9Yx
	DPdIvLjMrSdZAfNqAH5t1rOjrFGE8DAUmSyYpgHR4iUFaYtsQKC5wuxPaPGh2UdYJoS/z/
	2bfVZX0uTSh/m2qv0OLc6Fe+S/xfF1lfOF2yGRizdwCWfEvAoKN/M1RU/EVZ45AqCvpSa+
	Uoo6BJoYJaDXcPxUR73/NZmECzuaT/xatb+0o06Nz748HA6ZhnkjaPIgIEgOmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1773945793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=aJ/6xWkZlH6NO7Ff7qmOszSXxiRY52wOFAFTxwsJZYA=;
	b=nVtl1j36vX3XvDzBYXglHMQLcMM3AVXG9UIwYko3uN8e4Z7Aiv/YARWvZ2wN9ZcUPDoWLf
	BsYIo9HPnsReRtWs1ZM1LtUKWYuabEndlyGniMJVUHRVRSvtM7oP3C5+/nobwPAJyZDcE1
	oMMebmC+8WaNRiIeVqK8D/xo3BxscgmRtKvBvDUUBUmc0IeL6XJuxMppj2Sp2nH02cY+J9
	G2bhvMGb8izKAQTFK33yUa4xpL/KM3qSBIglm+q7S0UPl2NNTQT1lwPzLBLH4ZHKRfC39m
	ORgBTPCsKDxpAhL79tmpIiWYXLa8TlF8S9F7YrXA7XqxSHDXzNagm6Tc9/qNjQ==
ARC-Authentication-Results: i=1;
	rspamd-7f98bb5847-b9j5n;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Desert-Wiry: 6afd8b96696e28c9_1773945793839_1018836678
X-MC-Loop-Signature: 1773945793839:2150298180
X-MC-Ingress-Time: 1773945793839
Received: from pdx1-sub0-mail-a227.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.115.72.182 (trex/7.1.5);
	Thu, 19 Mar 2026 18:43:13 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a227.dreamhost.com (Postfix) with ESMTPSA id 4fcF290mDvz34;
	Thu, 19 Mar 2026 11:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1773945793;
	bh=aJ/6xWkZlH6NO7Ff7qmOszSXxiRY52wOFAFTxwsJZYA=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=p52jZUlVdfF/PhmnCyV+2TuOaheB+gUsH9J5bpi9NAPgnDkR6Q4q0FGk688vat9yV
	 c5JOAqFgMw4k90m8M1NXTb+3RfKpd1k86FtQu9EQm7GIXsHrFX27hAFseNkFmLHZdT
	 sEIpdXgFNsBRADi1GrTtJzce9DgIQoiEicWlbfiSCfCMDQvMfPsBLBaOiijXradBaf
	 EmgqfzSsGB1zoXSc3O3pQKQAKiDvEAHOC9IaKRo2u0f2U3RVometG54zgILpt5cpZ5
	 5pw3joscIRufC/t/lsF6MnecwKjx4rboe3u/T++Friws6blStmLZei3DZkzwVubmDT
	 yu3DALwLYTVoQ==
From: Davidlohr Bueso <dave@stgolabs.net>
To: mst@redhat.com,
	jonathan.cameron@huawei.com
Cc: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org,
	dave@stgolabs.net
Subject: [PATCH v3 -qemu 0/2] hw/cxl: Media Operation Discovery fixlets
Date: Thu, 19 Mar 2026 11:42:54 -0700
Message-Id: <20260319184256.3762391-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Changes from v2: indent fix in patch 1. Added reviewed+fixes tags.
Changes from v1: cleaned up comments in patch 2.

While working on the driver side of this, I tripped on two qemu issues
around discovery semantics. I think this is the first time these code
paths are exercised.

Davidlohr Bueso (2):
  hw/cxl: Respect Media Operation max ops discovery semantics
  hw/cxl: Exclude Discovery from Media Operation Discovery output

 hw/cxl/cxl-mailbox-utils.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

-- 
2.39.5

