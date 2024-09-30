Received: from seashell.cherry.relay.mailchannels.net (seashell.cherry.relay.mailchannels.net [23.83.223.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09467174EF0
	for <linux-cxl@vger.kernel.org>; Mon, 30 Sep 2024 20:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.162
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727729649; cv=pass; b=SdPrYly+ZNxxdjRi3G/m4RL6owTK7MGWuuM/5e1283ghab98ArQRepWoVEOgKlwWRrscq2vitfrD0oQ3cQ8jEkofzgsSqn/FfFlvGpj2x3cUF4EPoXt6weDJO6qsKe6CFvZQELA2sdRDAMcRf+1rvt3pl1tF7GGA0XaycC6Zwno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727729649; c=relaxed/simple;
	bh=UNIKu8VUsz1Qa70A/lpfbAYdeD5H5MpRjUiSpzt0v1I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SlrF7GuhJGwfJ3fl47BmhVtwm3GS3iPGhUOuDoFF79VFQtxsAeEEotCqXAY4K6nFEcimzs4MzY05ddBxRizMXfXCybW7TSVfiG7Kh8fyH5mXHRfNbIwrnbC/G3U3x1RzWshHxP/vk+oDLffIEyRdPycOrCzAzGqiyrZW7mzwp5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=hS1zHIBT; arc=pass smtp.client-ip=23.83.223.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="hS1zHIBT"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 2D5887806F4;
	Mon, 30 Sep 2024 20:36:13 +0000 (UTC)
Received: from pdx1-sub0-mail-a281.dreamhost.com (trex-7.trex.outbound.svc.cluster.local [100.96.87.181])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id B0BC6785A54;
	Mon, 30 Sep 2024 20:36:12 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1727728572; a=rsa-sha256;
	cv=none;
	b=1GoFodHqocmylypAPQCzTsBEsztF2l2iZa/Jxo7UCSOfH4slqfzkxSMh5pwhgxc8ywqef4
	wYqedwh4YWNv+mRB+tTXd9X4kKdwVAWpY5cVa8CDctV8WR8dKdCW1eF7zcIjk0S4Xrip+A
	jSelsAVq2dhtyGN3hgOOmvzdh+nhfgTjGMuAeiZMuhP2Slgkf+elxGGw5cbOgfsD+5ohRn
	SPYMz8vKpTpEgHuvOxK/7Qf9GIAAqQYS8CEvinX4LsKdsVUQo/LqVzcYsE1lov3RbuMMRV
	NMGvO4RquiQCA8yCsjI64A9kDVisZ7Yl1GqusH8FdXQYqE1xLop978vXWKpo+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1727728572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=9IGUX+FzzK9phvyuovMHlzaIGYgc851fORp5ivSfdlU=;
	b=AUy2X1wnweyVPFjZlFd2jtsKMqZX27/dFXE8GzLWCZu++Mk7cnRDla3h9LeoIt/cKDF6/5
	anE+2GzCwhUQJZ+9F5P/ZpDjcSgTgwzWLBnx04FsFFj7VOU1z/8vW7tTZ4LiB7PNFt4omb
	LvWI4+KlfhaG6yvBg6Lvy4blHPMLext9SPjBJlkALD+DawJkil/nU8GrPbgEZ44Sr5L2ce
	A4NPRH7hthuAYvs89eh/B/w8w4MtT5gC1kkQPVfAT/n5G8w1PQsnVrfCw4A2VQrBYk6D5W
	J2gvfcMoKmKztNwdme7dlz1Ece62zx4oep4+z0xA7Rz2i2OOtMjkoBWkDGiohg==
ARC-Authentication-Results: i=1;
	rspamd-9d66c6866-9gmrn;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Vacuous-Scare: 1311b6706f629492_1727728572973_1618280945
X-MC-Loop-Signature: 1727728572973:459566395
X-MC-Ingress-Time: 1727728572972
Received: from pdx1-sub0-mail-a281.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.87.181 (trex/7.0.2);
	Mon, 30 Sep 2024 20:36:12 +0000
Received: from localhost.localdomain (unknown [104.36.31.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a281.dreamhost.com (Postfix) with ESMTPSA id 4XHXsS0Wp7zRX;
	Mon, 30 Sep 2024 13:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1727728572;
	bh=9IGUX+FzzK9phvyuovMHlzaIGYgc851fORp5ivSfdlU=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=hS1zHIBTjLu+48gIoqBOGt/9FZM4FrQL8SrjsBniqEuodTriq3ZpniAi4xF/4cuzy
	 +MmXRNp+/6N0Cm8RI5jiYKA1N2nLz+PZlpCVIJw45AUPq10+WDeGZz6WECi/eLa5d7
	 PnGW+LfwBgyl70OhCKKTFL/uAgE8RKIoU+v95ZeyFeEPnmAeT+TPYLAtpi4PyJwSby
	 /RIfVtkmdgoe6ce8/QcM/WM4iuSNzLAPoVa3BFd42z2eeb4uv4hfzjPITZqXMutQCn
	 pxWNsgatm8FTzl2y4uoV5D652Kp7glnWDtg/LAznmu3+e4CCt2bJD3dn1zZmMnAK/V
	 eiNvJ3T/63XZQ==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jonathan.cameron@huawei.com
Cc: dave.jiang@intel.com,
	alison.schofield@intel.com,
	dan.j.williams@intel.com,
	ira.weiny@intel.com,
	fan.ni@samsung.com,
	linux-cxl@vger.kernel.org,
	dave@stgolabs.net
Subject: [PATCH v2] perf/cxlpmu: Support missing events in 3.1 spec
Date: Mon, 30 Sep 2024 13:34:45 -0700
Message-ID: <20240930203445.149954-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the CXL PMU driver to support the new events introduced
in the latest revision. These are:

- read/write accesses with TEE constraints.
- S2M indicating Modified state.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---

Changes from v1:
 - only update spec references of groups that are affected (Alison, Dave).

 drivers/perf/cxl_pmu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
index 43d68b69e630..644caf039718 100644
--- a/drivers/perf/cxl_pmu.c
+++ b/drivers/perf/cxl_pmu.c
@@ -377,12 +377,14 @@ static struct attribute *cxl_pmu_event_attrs[] = {
 	/* CXL rev 3.0 Table 13-5 directly lists these */
 	CXL_PMU_EVENT_CXL_ATTR(cachedata_d2h_data,		CXL_PMU_GID_CACHE_DATA, BIT(0)),
 	CXL_PMU_EVENT_CXL_ATTR(cachedata_h2d_data,		CXL_PMU_GID_CACHE_DATA, BIT(1)),
-	/* CXL rev 3.0 Table 3-29 M2S Req Memory Opcodes */
+	/* CXL rev 3.1 Table 3-35 M2S Req Memory Opcodes */
 	CXL_PMU_EVENT_CXL_ATTR(m2s_req_meminv,			CXL_PMU_GID_M2S_REQ, BIT(0)),
 	CXL_PMU_EVENT_CXL_ATTR(m2s_req_memrd,			CXL_PMU_GID_M2S_REQ, BIT(1)),
 	CXL_PMU_EVENT_CXL_ATTR(m2s_req_memrddata,		CXL_PMU_GID_M2S_REQ, BIT(2)),
 	CXL_PMU_EVENT_CXL_ATTR(m2s_req_memrdfwd,		CXL_PMU_GID_M2S_REQ, BIT(3)),
 	CXL_PMU_EVENT_CXL_ATTR(m2s_req_memwrfwd,		CXL_PMU_GID_M2S_REQ, BIT(4)),
+	CXL_PMU_EVENT_CXL_ATTR(m2s_req_memrdtee,		CXL_PMU_GID_M2S_REQ, BIT(5)),
+	CXL_PMU_EVENT_CXL_ATTR(m2s_req_memrddatatee,		CXL_PMU_GID_M2S_REQ, BIT(6)),
 	CXL_PMU_EVENT_CXL_ATTR(m2s_req_memspecrd,		CXL_PMU_GID_M2S_REQ, BIT(8)),
 	CXL_PMU_EVENT_CXL_ATTR(m2s_req_meminvnt,		CXL_PMU_GID_M2S_REQ, BIT(9)),
 	CXL_PMU_EVENT_CXL_ATTR(m2s_req_memcleanevict,		CXL_PMU_GID_M2S_REQ, BIT(10)),
@@ -404,10 +406,11 @@ static struct attribute *cxl_pmu_event_attrs[] = {
 	CXL_PMU_EVENT_CXL_ATTR(s2m_bisnp_curblk,		CXL_PMU_GID_S2M_BISNP, BIT(4)),
 	CXL_PMU_EVENT_CXL_ATTR(s2m_bisnp_datblk,		CXL_PMU_GID_S2M_BISNP, BIT(5)),
 	CXL_PMU_EVENT_CXL_ATTR(s2m_bisnp_invblk,		CXL_PMU_GID_S2M_BISNP, BIT(6)),
-	/* CXL rev 3.0 Table 3-43 S2M NDR Opcopdes */
+	/* CXL rev 3.1 Table 3-50 S2M NDR Opcopdes */
 	CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_cmp,			CXL_PMU_GID_S2M_NDR, BIT(0)),
 	CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_cmps,			CXL_PMU_GID_S2M_NDR, BIT(1)),
 	CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_cmpe,			CXL_PMU_GID_S2M_NDR, BIT(2)),
+	CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_cmpm,			CXL_PMU_GID_S2M_NDR, BIT(3)),
 	CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_biconflictack,		CXL_PMU_GID_S2M_NDR, BIT(4)),
 	/* CXL rev 3.0 Table 3-46 S2M DRS opcodes */
 	CXL_PMU_EVENT_CXL_ATTR(s2m_drs_memdata,			CXL_PMU_GID_S2M_DRS, BIT(0)),
-- 
2.46.1

