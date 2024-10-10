Received: from rusty.tulip.relay.mailchannels.net (rusty.tulip.relay.mailchannels.net [23.83.218.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C118E3E479
	for <linux-cxl@vger.kernel.org>; Thu, 10 Oct 2024 03:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.252
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728529386; cv=pass; b=JO3BQwuAjzypOldWuBpfa1Xy1E5eyk3iFEV1pJU6YxCtIKT9SNmpa4zBNJqppFq5CZwAOiWBrg8otS8h05DRidEMfiqtEA1k38DWSYBOn2gKhF+DI36uqe6N395MhmKzdExJzWYtnZcX3AU0vL6ZpiJ1QuZTgFAXFp+adg/hWQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728529386; c=relaxed/simple;
	bh=FaycmGtil8JhCTekzB7hbcELFoLEX+URWkrx9huW6oI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fb6yyCRQXx9hl8hiMCxhI0MSE2BAYYPw9mD2jkXYReDu3zq3JIuVZnjbLRzreTIpHvC88AVcrvMKnmTrWh+WtxFp3MMjfpVtVktR5A5MZtThos8C3z7DnoY1PgQq+kN92EX9za1SFSsHX4vXzMYcXACUElkLt3GNYTeyP1EmlNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=qll/b0OI; arc=pass smtp.client-ip=23.83.218.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="qll/b0OI"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 8E01782364A;
	Thu, 10 Oct 2024 02:54:18 +0000 (UTC)
Received: from pdx1-sub0-mail-a216.dreamhost.com (100-96-90-148.trex-nlb.outbound.svc.cluster.local [100.96.90.148])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 26F9D823944;
	Thu, 10 Oct 2024 02:54:18 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1728528858; a=rsa-sha256;
	cv=none;
	b=DXwo0wHDooIwajanNpjwZHlIMbHIds85xQXHcBBY4yA9zJeuog7VXW/Czdy7wFV91SNpJv
	hDTUXFRzyOcESe18vLUySDTm7SFnmXOXKE5j6zYH//sFQRpCE0FdLo2y8jdAOFlcqkbEv1
	4MA9rNHHZJI0+3U64VQvHpkk62YOLZLKtmJk8C0AqzI79RtnYt1492BYzjXzbOrZcPLDAh
	xdcmM97cxykKxkEP7IQpXbBCnODzX8RfnmaIdPur37wTr0+Ip1hZ1lJiQtt8tJHlfxxEfu
	qs1LuPuuHTIy14YU4q0nzw7xWs2xP6fIP3N5R5GAnajIxg0hMXqMdDXkCQHnSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1728528858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=XhKU0AE1uncaAAcKjtVUJtMae/mmu+f96EkLUsuX8Lo=;
	b=ZoX5FYJxmCUuks1gYvPlmT9M6/Dxa5zVWKIy04RbEQ1wuLJ7JbEIFBywYQakV/T8lIdDMv
	vOr9GP2sIvWfFCcY6gqGs6CSoyJlbm/RliuJKfkb7roZ9nm0ceH5V82ubXI3ZoNxjn1fqz
	+SfmjS1yW7jkK0vpIAnoniaw1qtX99nCjCCy/BR80NFETzU1FClO3reyNpF8B7XSSDDhjJ
	+C2f2jyTDlhewyNS14CsQ+XCyOrR4bjIDjqTSx6MbuJN4HI46iTxl9Nb29fNKROV4enpyT
	Hk6csSotOjZeqbj5mW+U3v2TYG0b0yLLxOnc4ktHgnWyXe/b9t4gDE7f4o0KZA==
ARC-Authentication-Results: i=1;
	rspamd-5fcd6bf96c-hrs9w;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Celery-Fearful: 696674c52a7c3ed1_1728528858456_1484141695
X-MC-Loop-Signature: 1728528858456:1036919767
X-MC-Ingress-Time: 1728528858456
Received: from pdx1-sub0-mail-a216.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.90.148 (trex/7.0.2);
	Thu, 10 Oct 2024 02:54:18 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a216.dreamhost.com (Postfix) with ESMTPSA id 4XPDqY1t83zB1;
	Wed,  9 Oct 2024 19:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1728528858;
	bh=XhKU0AE1uncaAAcKjtVUJtMae/mmu+f96EkLUsuX8Lo=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=qll/b0OIrAYom0ssIJgB40SniKGFufVwsOHiROJOLwrWA3bFrfzw2jPk0Aak3T3VM
	 7R53D7vrO95hlU9+tXDZWFRceDTJ9y39HvNkzH59ylC+6T9DZMdkPKX2UMR7JokSK5
	 qN4LTe/TJJ727+FcRRXgulWDeMQITfobFeGDYFe9KE4PUuByOYPA2hPtXwTTpuF/qH
	 lL+1rGxx/JxgvZzbSOs7q9wPFA7uk6YysJodEzXsAPVOg4Fo4z60p8peYkD3rpZA3u
	 IqGEa+Zd4Iwa0IyYl8vuU1kNf1wyWipwUH+YmxHm9g/OThPIUtT1sAkSumup2AmXyu
	 OmnB4vNktovSQ==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jonathan.cameron@huawei.com,
	will@kernel.org,
	mark.rutland@arm.com
Cc: dave.jiang@intel.com,
	alison.schofield@intel.com,
	dan.j.williams@intel.com,
	ira.weiny@intel.com,
	fan.ni@samsung.com,
	a.manzanares@samsung.com,
	linux-cxl@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	dave@stgolabs.net,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3] perf/cxlpmu: Support missing events in 3.1 spec
Date: Wed,  9 Oct 2024 19:52:08 -0700
Message-ID: <20241010025208.180458-1-dave@stgolabs.net>
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

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/perf/cxl_pmu.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
index 43d68b69e630..bee4b5b52ec6 100644
--- a/drivers/perf/cxl_pmu.c
+++ b/drivers/perf/cxl_pmu.c
@@ -354,7 +354,7 @@ static struct attribute *cxl_pmu_event_attrs[] = {
 	CXL_PMU_EVENT_CXL_ATTR(d2h_req_wowrinvf,		CXL_PMU_GID_D2H_REQ, BIT(13)),
 	CXL_PMU_EVENT_CXL_ATTR(d2h_req_wrinv,			CXL_PMU_GID_D2H_REQ, BIT(14)),
 	CXL_PMU_EVENT_CXL_ATTR(d2h_req_cacheflushed,		CXL_PMU_GID_D2H_REQ, BIT(16)),
-	/* CXL rev 3.0 Table 3-20 - D2H Repsonse Encodings */
+	/* CXL rev 3.0 Table 3-20 - D2H Response Encodings */
 	CXL_PMU_EVENT_CXL_ATTR(d2h_rsp_rspihiti,		CXL_PMU_GID_D2H_RSP, BIT(4)),
 	CXL_PMU_EVENT_CXL_ATTR(d2h_rsp_rspvhitv,		CXL_PMU_GID_D2H_RSP, BIT(6)),
 	CXL_PMU_EVENT_CXL_ATTR(d2h_rsp_rspihitse,		CXL_PMU_GID_D2H_RSP, BIT(5)),
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

