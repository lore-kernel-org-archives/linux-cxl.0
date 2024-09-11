Received: from slateblue.cherry.relay.mailchannels.net (slateblue.cherry.relay.mailchannels.net [23.83.223.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF80A2EAE5
	for <linux-cxl@vger.kernel.org>; Wed, 11 Sep 2024 21:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726091981; cv=pass; b=o3NApq1HfTuYGeNJkqCq+R4CAu2ZByDW7Wed3pbbbvRcKxpyvWzvVhMMLu4tfuflJfhYApr+3UGr1J7c7fgrOUqhCXmpOPdz/y/kkMy4/sOSfnbuj3sPDD2KvgEdFiqWZeMWQImmRr6yIDkYMIUuagz3CkJ4zghHTp1Lx1zqX1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726091981; c=relaxed/simple;
	bh=s/eA6v5pmr7tv5WthEy7srNqeZudfooRhzCI0eHkBqI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QmAIbjcXcO449//kXIizkMBsahvwaY3vK2PviX+Rde3cnjXzdKt31CUCfbSNIKlYY0GnADfEQe60KmW3njYcepFFxZ+wtM9lXVbUVF0aRk+0kDENrhI419mp9Xozm0QBdtrPdotWtOdoniEywlAF73lKGsjk5UV2siz9elzbH34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=k7vy5ATu; arc=pass smtp.client-ip=23.83.223.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="k7vy5ATu"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 67FBA1A3D33;
	Wed, 11 Sep 2024 21:53:01 +0000 (UTC)
Received: from pdx1-sub0-mail-a311.dreamhost.com (trex-7.trex.outbound.svc.cluster.local [100.96.74.238])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 15BC41A3CE6;
	Wed, 11 Sep 2024 21:53:01 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1726091581; a=rsa-sha256;
	cv=none;
	b=14JNnpVtrWzNbuRDmH4vovx+sLDRNLsk3zJ2OcZsiEyf3rhmfLVwpLx6xaHGgyOlKgLWbz
	ASkvJmfd7gc/9vSYck+0jC1f5kNbY4sASRiS6OO/wFUF0TUTOreMm5ZRtjhoFM3BoQCvPe
	MZvA2kgzMmVtMGqIchD2RN5vMI5u3Pmw0SfPtUpqKjw7pI8vepSEKmibqFCARoVfssRqdl
	gOabPYinAMpPpAF+g/mUlSokRLKZFL9t3vrnNwzK26LHVr6c7kbyioJ6zNvjNl0FklfCPn
	mcmnltljlUoj2YFhaSQgq2y8NDxTCMy0GSObiCda81op6NmK00dr15PA3YZC0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1726091581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=9Nnr6uSdQ5RrNfmJjurtblM11RMqyI1AHVlzHm5oxZM=;
	b=LAE6ttKrS0CsR0Pg8NUKX+yhu0gZh780lvsflRj/s3q/XCuszD5RxhsovycemT34h0n5Gc
	VGsjAAzVpJFDMt9ZC9zUeQKDJXkUWtrQADTV4mNk55G9id6Go+RAaI2DX297NYrZtSZUwE
	cCnD900zA3IwR7zIinQ4eyGydrvRoeaYEkddtoqcEZGw7cR5Jfb5k9RIoIMl68Fh5govmx
	SC84wIJNIzR186iYZ81FyZw+3HZlqNAvtj2ohEybdBPypQZ34Y9Ot3xBocioTvWjjg0hb/
	55AKq4URVZ4V2e30JqYg4ATjsEwrfEtvbzCtY6Tx3Rt438laqMYc6tZKm5f2TQ==
ARC-Authentication-Results: i=1;
	rspamd-77766c4bb8-lhtrb;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Grain-Snatch: 7530eb252d49db3c_1726091581312_1260044576
X-MC-Loop-Signature: 1726091581312:1279010088
X-MC-Ingress-Time: 1726091581312
Received: from pdx1-sub0-mail-a311.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.74.238 (trex/7.0.2);
	Wed, 11 Sep 2024 21:53:01 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a311.dreamhost.com (Postfix) with ESMTPSA id 4X3vSr4fphzQt;
	Wed, 11 Sep 2024 14:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1726091580;
	bh=9Nnr6uSdQ5RrNfmJjurtblM11RMqyI1AHVlzHm5oxZM=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=k7vy5ATuDX8PdWshs1ugv7GESpPYTnwHHnKmawZVVVol3NUtUIdWcg9pSiY8EHgoU
	 TRh52Z+prXA7Zpmi1MViUVTr7psAic6ny6t76WBcT5GX+Nl36l+ulAoLa9BBH8VIbG
	 4CDnMjqp+eVDhsFrWizt94dB/rxU8TX61Q6jo4JYmKjIlQsrgB7rqfitV7DYK5G0LE
	 MIvKWqq+cLHkD9i1ZIirNF3jZFRkz6UJAu/m+R6Bd6oKdKBw9hhvQBTRbmSF1UnIry
	 p2m7yD98U1JnvoEO50Ns14RG8inolz4rDsfjxlWle5slclrXv9otKqfkOfs4cEnmTo
	 8ye/cjEROPShg==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jonathan.cameron@huawei.com
Cc: fan.ni@samsung.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org
Subject: [PATCH] perf/cxlpmu: Support missing events in 3.1 spec
Date: Wed, 11 Sep 2024 14:52:21 -0700
Message-ID: <20240911215221.308483-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.46.0
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
 drivers/perf/cxl_pmu.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
index 1f93a66eff5b..13005f410ee0 100644
--- a/drivers/perf/cxl_pmu.c
+++ b/drivers/perf/cxl_pmu.c
@@ -63,7 +63,7 @@
 
 #define CXL_PMU_COUNTER_REG(n)		(0xc00 + 8 * (n))
 
-/* CXL rev 3.0 Table 13-5 Events under CXL Vendor ID */
+/* CXL rev 3.1 Table 13-5 Events under CXL Vendor ID */
 #define CXL_PMU_GID_CLOCK_TICKS		0x00
 #define CXL_PMU_GID_D2H_REQ		0x0010
 #define CXL_PMU_GID_D2H_RSP		0x0011
@@ -338,7 +338,7 @@ static ssize_t cxl_pmu_event_sysfs_show(struct device *dev,
 
 static struct attribute *cxl_pmu_event_attrs[] = {
 	CXL_PMU_EVENT_CXL_ATTR(clock_ticks,			CXL_PMU_GID_CLOCK_TICKS, BIT(0)),
-	/* CXL rev 3.0 Table 3-17 - Device to Host Requests */
+	/* CXL rev 3.1 Table 3-22 - Device to Host Requests */
 	CXL_PMU_EVENT_CXL_ATTR(d2h_req_rdcurr,			CXL_PMU_GID_D2H_REQ, BIT(1)),
 	CXL_PMU_EVENT_CXL_ATTR(d2h_req_rdown,			CXL_PMU_GID_D2H_REQ, BIT(2)),
 	CXL_PMU_EVENT_CXL_ATTR(d2h_req_rdshared,		CXL_PMU_GID_D2H_REQ, BIT(3)),
@@ -354,7 +354,7 @@ static struct attribute *cxl_pmu_event_attrs[] = {
 	CXL_PMU_EVENT_CXL_ATTR(d2h_req_wowrinvf,		CXL_PMU_GID_D2H_REQ, BIT(13)),
 	CXL_PMU_EVENT_CXL_ATTR(d2h_req_wrinv,			CXL_PMU_GID_D2H_REQ, BIT(14)),
 	CXL_PMU_EVENT_CXL_ATTR(d2h_req_cacheflushed,		CXL_PMU_GID_D2H_REQ, BIT(16)),
-	/* CXL rev 3.0 Table 3-20 - D2H Repsonse Encodings */
+	/* CXL rev 3.1 Table 3-25 - D2H Response Encodings */
 	CXL_PMU_EVENT_CXL_ATTR(d2h_rsp_rspihiti,		CXL_PMU_GID_D2H_RSP, BIT(4)),
 	CXL_PMU_EVENT_CXL_ATTR(d2h_rsp_rspvhitv,		CXL_PMU_GID_D2H_RSP, BIT(6)),
 	CXL_PMU_EVENT_CXL_ATTR(d2h_rsp_rspihitse,		CXL_PMU_GID_D2H_RSP, BIT(5)),
@@ -362,11 +362,11 @@ static struct attribute *cxl_pmu_event_attrs[] = {
 	CXL_PMU_EVENT_CXL_ATTR(d2h_rsp_rspsfwdm,		CXL_PMU_GID_D2H_RSP, BIT(7)),
 	CXL_PMU_EVENT_CXL_ATTR(d2h_rsp_rspifwdm,		CXL_PMU_GID_D2H_RSP, BIT(15)),
 	CXL_PMU_EVENT_CXL_ATTR(d2h_rsp_rspvfwdv,		CXL_PMU_GID_D2H_RSP, BIT(22)),
-	/* CXL rev 3.0 Table 3-21 - CXL.cache - Mapping of H2D Requests to D2H Responses */
+	/* CXL rev 3.1 Table 3-26 - CXL.cache - Mapping of H2D Requests to D2H Responses */
 	CXL_PMU_EVENT_CXL_ATTR(h2d_req_snpdata,			CXL_PMU_GID_H2D_REQ, BIT(1)),
 	CXL_PMU_EVENT_CXL_ATTR(h2d_req_snpinv,			CXL_PMU_GID_H2D_REQ, BIT(2)),
 	CXL_PMU_EVENT_CXL_ATTR(h2d_req_snpcur,			CXL_PMU_GID_H2D_REQ, BIT(3)),
-	/* CXL rev 3.0 Table 3-22 - H2D Response Opcode Encodings */
+	/* CXL rev 3.1 Table 3-27 - H2D Response Opcode Encodings */
 	CXL_PMU_EVENT_CXL_ATTR(h2d_rsp_writepull,		CXL_PMU_GID_H2D_RSP, BIT(1)),
 	CXL_PMU_EVENT_CXL_ATTR(h2d_rsp_go,			CXL_PMU_GID_H2D_RSP, BIT(4)),
 	CXL_PMU_EVENT_CXL_ATTR(h2d_rsp_gowritepull,		CXL_PMU_GID_H2D_RSP, BIT(5)),
@@ -374,45 +374,50 @@ static struct attribute *cxl_pmu_event_attrs[] = {
 	CXL_PMU_EVENT_CXL_ATTR(h2d_rsp_gowritepulldrop,		CXL_PMU_GID_H2D_RSP, BIT(8)),
 	CXL_PMU_EVENT_CXL_ATTR(h2d_rsp_fastgowritepull,		CXL_PMU_GID_H2D_RSP, BIT(13)),
 	CXL_PMU_EVENT_CXL_ATTR(h2d_rsp_goerrwritepull,		CXL_PMU_GID_H2D_RSP, BIT(15)),
-	/* CXL rev 3.0 Table 13-5 directly lists these */
+	/* CXL rev 3.1 Table 13-5 directly lists these */
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
-	/* CXL rev 3.0 Table 3-35 M2S RwD Memory Opcodes */
+	/* CXL rev 3.1 Table 3-41 M2S RwD Memory Opcodes */
 	CXL_PMU_EVENT_CXL_ATTR(m2s_rwd_memwr,			CXL_PMU_GID_M2S_RWD, BIT(1)),
 	CXL_PMU_EVENT_CXL_ATTR(m2s_rwd_memwrptl,		CXL_PMU_GID_M2S_RWD, BIT(2)),
 	CXL_PMU_EVENT_CXL_ATTR(m2s_rwd_biconflict,		CXL_PMU_GID_M2S_RWD, BIT(4)),
-	/* CXL rev 3.0 Table 3-38 M2S BIRsp Memory Opcodes */
+	/* CXL rev 3.1 Table 3-45 M2S BIRsp Memory Opcodes */
 	CXL_PMU_EVENT_CXL_ATTR(m2s_birsp_i,			CXL_PMU_GID_M2S_BIRSP, BIT(0)),
 	CXL_PMU_EVENT_CXL_ATTR(m2s_birsp_s,			CXL_PMU_GID_M2S_BIRSP, BIT(1)),
 	CXL_PMU_EVENT_CXL_ATTR(m2s_birsp_e,			CXL_PMU_GID_M2S_BIRSP, BIT(2)),
 	CXL_PMU_EVENT_CXL_ATTR(m2s_birsp_iblk,			CXL_PMU_GID_M2S_BIRSP, BIT(4)),
 	CXL_PMU_EVENT_CXL_ATTR(m2s_birsp_sblk,			CXL_PMU_GID_M2S_BIRSP, BIT(5)),
 	CXL_PMU_EVENT_CXL_ATTR(m2s_birsp_eblk,			CXL_PMU_GID_M2S_BIRSP, BIT(6)),
-	/* CXL rev 3.0 Table 3-40 S2M BISnp Opcodes */
+	/* CXL rev 3.1 Table 3-47 S2M BISnp Opcodes */
 	CXL_PMU_EVENT_CXL_ATTR(s2m_bisnp_cur,			CXL_PMU_GID_S2M_BISNP, BIT(0)),
 	CXL_PMU_EVENT_CXL_ATTR(s2m_bisnp_data,			CXL_PMU_GID_S2M_BISNP, BIT(1)),
 	CXL_PMU_EVENT_CXL_ATTR(s2m_bisnp_inv,			CXL_PMU_GID_S2M_BISNP, BIT(2)),
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
-	/* CXL rev 3.0 Table 3-46 S2M DRS opcodes */
+	CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_cmptee,			CXL_PMU_GID_S2M_NDR, BIT(5)),
+	/* CXL rev 3.1 Table 3-53 S2M DRS opcodes */
 	CXL_PMU_EVENT_CXL_ATTR(s2m_drs_memdata,			CXL_PMU_GID_S2M_DRS, BIT(0)),
 	CXL_PMU_EVENT_CXL_ATTR(s2m_drs_memdatanxm,		CXL_PMU_GID_S2M_DRS, BIT(1)),
-	/* CXL rev 3.0 Table 13-5 directly lists these */
+	CXL_PMU_EVENT_CXL_ATTR(s2m_drs_memdatatee,		CXL_PMU_GID_S2M_DRS, BIT(2)),
+	/* CXL rev 3.1 Table 13-5 directly lists these */
 	CXL_PMU_EVENT_CXL_ATTR(ddr_act,				CXL_PMU_GID_DDR, BIT(0)),
 	CXL_PMU_EVENT_CXL_ATTR(ddr_pre,				CXL_PMU_GID_DDR, BIT(1)),
 	CXL_PMU_EVENT_CXL_ATTR(ddr_casrd,			CXL_PMU_GID_DDR, BIT(2)),
-- 
2.46.0

