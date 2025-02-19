Received: from buffalo.tulip.relay.mailchannels.net (buffalo.tulip.relay.mailchannels.net [23.83.218.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C736187859
	for <linux-cxl@vger.kernel.org>; Wed, 19 Feb 2025 02:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=23.83.218.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739931334; cv=fail; b=tog7VnA40xAAYHzCHVdPcblXcJ7qgcBqi3CUx6l5M5MMMPf1D3RA9gIttG9PJjZSQpG5RiyUlnUmZbQDX5wepFK6dfS8DifnmNi7/BGYkBRZJI7Zohjn/a3+b0aDbpt1O1j159rZQfaFuSteXh/qcdLVwscpoLWhvx8xNARUUOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739931334; c=relaxed/simple;
	bh=dnNZCp4ptLEEa2T+51OuudSNTBJBq5FlcL3eNXhrGVg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NXPt9fPn9B8dWa/W5Dun3OwwusZFFKfd4lhun+TzKu6+yglkO+W+ylAHJcCxBjHsC8CjytNiMOZHRNYIjeFBddUWI7ttiMZbeSyR524AIn4iC4oIpvV2mhWQvsZAjaHxi7GtX7MX0myHiYAwgLGtnBXi3pyjVwme85dFoSKtMTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=o7kMFYpn; arc=fail smtp.client-ip=23.83.218.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="o7kMFYpn"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 40D1A18345C;
	Wed, 19 Feb 2025 02:15:26 +0000 (UTC)
Received: from pdx1-sub0-mail-a289.dreamhost.com (100-101-191-136.trex-nlb.outbound.svc.cluster.local [100.101.191.136])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id D06E2182C56;
	Wed, 19 Feb 2025 02:15:25 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1739931325; a=rsa-sha256;
	cv=none;
	b=k+K6alxqqyKV90zkz1jB0MqBynVhcGMmSMGKmhiFoFDMu9hMk7sKaiwlptSc+uEgS3Jqez
	9Xudnh7gbKvFyt7MeK8ZFhOshVDHYpYMYhPg0dizrejY9dCIQJ0ES3xllrfEA9+OvK1aRF
	5vQG7aLH0WnO/7n144pCk0d5hxil8vbMLMU+CNrez7mfhOBF+DeFfdJnFOb2Bg1wIcASNs
	zp0LkM75TezolZvJpcTScvkzlKk3vXt3THIQCq49167jmAZekxw8FEj3e3UWc+eaTpWg9k
	TbcDv0w7VwHJR/LYTo/+RQGpBaFEb/K40rMcFvHbL5ng6zTDG2t38JrGv9TwUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1739931325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=cXu71Rxk8iuvHkU8AhGSGzNvUadQT4fD3KJ5THE0ipM=;
	b=k7rsydEuIi182n8ki58GbxFmA0q12Jjn1sc4lgeqRZZFJFPUGv7YTSj2gHHq7GymtBRjut
	CTVh4sR5utQDBDTlyvxlOwePgaVD+Cy0Ov6kzDLhgTUL39Vx/NCpnWmqsz+edWuerUYCsy
	g+7E3E14fpTB6e2UXbjqtM49WUeFzg0gRA3LhBNtGRzRHbaXFa/vkfNgRN+9hajjy7Q1Jb
	IwV5pftgIUqhEyL22p7KJfRh9xusy9aNMDRbTLdYYnf2PPbWkz8TZIX2dlYLliDX07f0Lp
	snVRcebuXETSTThJAF8a1GE5cdFsVMv2BaEPKN6sqGHLGMRui/kgRAPT45SbZg==
ARC-Authentication-Results: i=1;
	rspamd-6d7cc6b78d-bq9x4;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Fumbling-Army: 077630a86db23a8a_1739931326153_1727152453
X-MC-Loop-Signature: 1739931326153:2124248045
X-MC-Ingress-Time: 1739931326153
Received: from pdx1-sub0-mail-a289.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.101.191.136 (trex/7.0.2);
	Wed, 19 Feb 2025 02:15:26 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a289.dreamhost.com (Postfix) with ESMTPSA id 4YyKjm708Zz8j;
	Tue, 18 Feb 2025 18:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1739931325;
	bh=IYpZ53/8tvO+3xfNWpcYVQNrS/JIc9fl49EIwLa5Onc=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=o7kMFYpnob7eTdmUE5UwOlYoYafm5xhROUM1f3XuYgBKTGPMzzRVL3oJ/orjvqaAE
	 DNPHoDlo1RF6t3juz2kT1N0vGKB6HFn6f33gPkZ/eX1Ojs8mj2oDKAdk+pQipL/EXB
	 2AbWns5+4XwYPj4Lu5YTKP1zpOJGHak/1216i5eHUV+8eIS5Hb/jdD0xnL0UVTyrHK
	 RbkuhEtxEDjB6WnMGFGS1A8qPHxIV9BMepXrmUDIjbppU/ffgzSKvxYqvkUbCnoXUI
	 CZRVSFRkotQhQ9Vk836yV/hFVH+zdXnm4osqr0QU3e9QOIeYOQFzrc+NdsPXwxjgg1
	 K3/kgEI0610vA==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com,
	dan.j.williams@intel.com
Cc: jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	seven.yi.lee@gmail.com,
	a.manzanares@samsung.com,
	fan.ni@samsung.com,
	anisa.su@samsung.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org
Subject: [PATCH 2/4] cxl/pmem: Rename cxl_dirty_shutdown_state()
Date: Tue, 18 Feb 2025 18:14:18 -0800
Message-Id: <20250219021420.214991-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250219021420.214991-1-dave@stgolabs.net>
References: <20250219021420.214991-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

... to a better suited 'cxl_arm_dirty_shutdown()'.

Suggested-by: Dave Jiang <dave.jiang@intel.com>
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

