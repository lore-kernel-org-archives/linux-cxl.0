Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC701BD014
	for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 01:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=23.83.212.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740015435; cv=fail; b=LZ1/ROaATYV8lEFRtFhVNpu5UUo3JMbgXakg6PteDE8wAWAHF1F6iWaMrYyPGyxzO3KGLVBg3SEcezLBvmpdecpBcFzp+ZYOvX6d2ODaz+BITwn4kBL9lrsylckn1w4W67OA60kqX5EBeD58Byv2JSIaQVT4CNdOkjhRs/sDhro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740015435; c=relaxed/simple;
	bh=uwmn7BVjOSiw7Yjrd5YJobf2/4TUvp527FZOl3ymLqw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RSFqjOkbc+QBV0uucsGo0omFyL1Vd060VANOlsc0975K7djn9qRVmY/P49X5htuQoK53oJmjyYmtRBhuA1hgboswTnp2ikTkehbFW6QFDsdKQIyd3QvVUWoocWsDMB3gzpRXOvCi+RPuvf+0vJqRM5TGpqT2gj48Yv2hRafdFyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=cjLswAjw; arc=fail smtp.client-ip=23.83.212.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="cjLswAjw"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 1353E901B3E;
	Thu, 20 Feb 2025 01:37:07 +0000 (UTC)
Received: from pdx1-sub0-mail-a300.dreamhost.com (100-97-27-146.trex-nlb.outbound.svc.cluster.local [100.97.27.146])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 9EF33902691;
	Thu, 20 Feb 2025 01:37:06 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1740015426; a=rsa-sha256;
	cv=none;
	b=QTrgPHj9fSB8m0whExptLGWY/aWkFRq/vj/hsutqHKE8xcBVhtwDQM11n3CdZ2HqXI4j+v
	p1lzTEBeXIsHwStLaPhvEej+PQogrKldnCOZoUGcVRcBajLRmAbc0y/GiHFidhsNJl/WD9
	EsAhvXfFQVOZLgFkTe4vC+hrvTmHvxNkbYJrN13IdESnk3Bsc5RgjHEQlsqW/2Zzkugkf/
	Mgt5g9XcFoLI3kmY2WQt9qSfaSONfYLJQrcB577R6i2+k6m42ucehMEy5htfkmV4hJ/I80
	J8kYYz1aGGcLsWf7KW8omaykszIzFK7MIGFHSViDlpfdL3QBcZW7pIa+rfStsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1740015426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=dP5fD5Lj/OskC/JhcJ7KYBHPzFU0UrZygNcBx9OEUr4=;
	b=KmTzRvk9uhYq+ZcAQXEu6pJv5MjXf4Pjyijxz7PDD1hO/nkw4mWH+cyVDpxGH/Jo8dT/SZ
	HK51Zgdj6jyLYxdz34of6+UWxJHMfZSUWB0hTnSaOqVuAa6Ecf9rmFUqj2nb70z8sgtp99
	mq7NAYdOWqfquOmP+GLJJtTF5+RrpVEuqSY4HTtbsgTc+Oimc0dz7PrAlB+rv8A2GkI29O
	4+KWmgCOnRlj/JwfRd82WVOkJ6fVAWSuPFqRIcnyGWfBEoenirD3Nn3gFp6texuDG3RUgh
	TOLwZu79MLuDZBsRIAC57KS3kQayajCiPU0ODxl6iSIDj2/ZuH9QE8jKt5ew3g==
ARC-Authentication-Results: i=1;
	rspamd-6d7cc6b78d-8pd7z;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Shelf-Lettuce: 25b7a42e3b33d690_1740015426959_3929177649
X-MC-Loop-Signature: 1740015426959:1990725372
X-MC-Ingress-Time: 1740015426958
Received: from pdx1-sub0-mail-a300.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.97.27.146 (trex/7.0.2);
	Thu, 20 Feb 2025 01:37:06 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a300.dreamhost.com (Postfix) with ESMTPSA id 4Yywq55bwKzY0;
	Wed, 19 Feb 2025 17:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1740015426;
	bh=+z/h6H2QSLkOm/4RiNFIPp69ioOFW5rVG2F/XpJLmlo=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=cjLswAjw5j8jAIU8rsKNUHiMProGfXSAZxEyJyRyb+Q6ts/N7f2PO6DXNG+bvums7
	 MWjWQigUlooD2MxQpBYkSBRxAdgq/j0mlls18ID93hZUUU7FVmffh/2/2g4q+JHzrs
	 F+MPMUYzDDnSO/a0MExgAVr4aoUkZmTiaSJ+ino6K0oawKmmO86psAgPptVBIZ5puY
	 1hkuCeKp3PPbWdurTvmEqgUewyfR77eSF9uzUD6WTTt+5DwZzs3sPDc5ahrwRlXC/s
	 CITYh3dEMH1AnEjM3L99qzEpl/dM1E1eyD+H8tMT2M3LDQ01yCTEolxAoHAnIdP55p
	 L+VkhlYeU268A==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com,
	dan.j.williams@intel.com
Cc: jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	seven.yi.lee@gmail.com,
	ming.li@zohomail.com,
	a.manzanares@samsung.com,
	fan.ni@samsung.com,
	anisa.su@samsung.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org
Subject: [PATCH 2/4] cxl/pmem: Rename cxl_dirty_shutdown_state()
Date: Wed, 19 Feb 2025 17:36:02 -0800
Message-Id: <20250220013604.263489-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250220013604.263489-1-dave@stgolabs.net>
References: <20250220013604.263489-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

... to a better suited 'cxl_arm_dirty_shutdown()'.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/core/mbox.c | 4 ++--
 drivers/cxl/cxlmem.h    | 2 +-
 drivers/cxl/pmem.c      | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index c5eedcae3b02..86d13f4a1c18 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1281,7 +1281,7 @@ int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_mem_dpa_fetch, "CXL");
 
-int cxl_dirty_shutdown_state(struct cxl_memdev_state *mds)
+int cxl_arm_dirty_shutdown(struct cxl_memdev_state *mds)
 {
 	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 	struct cxl_mbox_cmd mbox_cmd;
@@ -1297,7 +1297,7 @@ int cxl_dirty_shutdown_state(struct cxl_memdev_state *mds)
 
 	return cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
 }
-EXPORT_SYMBOL_NS_GPL(cxl_dirty_shutdown_state, "CXL");
+EXPORT_SYMBOL_NS_GPL(cxl_arm_dirty_shutdown, "CXL");
 
 int cxl_set_timestamp(struct cxl_memdev_state *mds)
 {
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 8e1e46c348f5..6d60030139df 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -822,7 +822,7 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 			    enum cxl_event_log_type type,
 			    enum cxl_event_type event_type,
 			    const uuid_t *uuid, union cxl_event *evt);
-int cxl_dirty_shutdown_state(struct cxl_memdev_state *mds);
+int cxl_arm_dirty_shutdown(struct cxl_memdev_state *mds);
 int cxl_set_timestamp(struct cxl_memdev_state *mds);
 int cxl_poison_state_init(struct cxl_memdev_state *mds);
 int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
index a39e2c52d7ab..6b284962592f 100644
--- a/drivers/cxl/pmem.c
+++ b/drivers/cxl/pmem.c
@@ -90,7 +90,7 @@ static int cxl_nvdimm_probe(struct device *dev)
 	 * clear it upon a successful GPF flow. The exception to this
 	 * is upon Viral detection, per CXL 3.2 section 12.4.2.
 	 */
-	if (cxl_dirty_shutdown_state(mds))
+	if (cxl_arm_dirty_shutdown(mds))
 		dev_warn(dev, "GPF: could not dirty shutdown state\n");
 
 	dev_set_drvdata(dev, nvdimm);
-- 
2.39.5

