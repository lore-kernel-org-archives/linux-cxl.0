Received: from barn.pear.relay.mailchannels.net (barn.pear.relay.mailchannels.net [23.83.216.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5E13C2F
	for <linux-cxl@vger.kernel.org>; Fri, 21 Feb 2025 02:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=23.83.216.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740105219; cv=fail; b=QwocnI8CY57vAbqwQtTOcnLwNPk7nF/Nryh2FRwhAkoUCvJmsVrJyBhPbtBWX0F15/FUKK5JvPlE7xBYKrI77llTowyOFuH9oXpJ/5FwpiNAMLmO4uP8v5WscYADO7bg9Tuuu6ulKB0DBJ8pitBGyhDb4+aUcDtg7v4awYQ3VIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740105219; c=relaxed/simple;
	bh=9FbtL0CiOH8YZOaJ8zy5pKANCxmPdJQXhbsYBZeIR+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DUSMEFzhlHuW6ooXbIuopUyWrNJlJvoKVONDmHJwntvqrhXf74EUumBXGWnLgKBXh37fmRWXIlOLzZY6Gvg9jCStd7d9AGsCQXXiT1OAZrTl5M077QgTxYUwvX+5ulgNluh3onSFj1B3fGHiFw2LNE0kyZQ7iSak5fS8YU9CF2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=SyT/riCw; arc=fail smtp.client-ip=23.83.216.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="SyT/riCw"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 0B7E178300F;
	Thu, 20 Feb 2025 22:02:44 +0000 (UTC)
Received: from pdx1-sub0-mail-a229.dreamhost.com (100-101-208-252.trex-nlb.outbound.svc.cluster.local [100.101.208.252])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 80F4778312D;
	Thu, 20 Feb 2025 22:02:43 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1740088963; a=rsa-sha256;
	cv=none;
	b=Nmek303d/ATjhNA1gRJ2ZuuRcyz/BeGji7WHswEtSsRIrSDx7NVyUBPSH/BhoachiwNZTi
	L88ITSn2Gthk1DX5JtHLzCi473OaqdoNUk3StVpTlyCTxrZfXbtrhwYSLGbhHs60JSdsiF
	s5j8lO0AJmI8aiwqCaeu7po8C3TssJK5IusJEdHa8xjmqeuaVfYhtCuv5dHQno2DW5Qd3S
	yktFCbHs/EE2nQXIqCGPMttW58hu59MWtV3vtdLYC/P1JB1tygNlHXBjq5CdYJ5APgogrX
	TgFzKTJN+POGj4gX5WR4AlHapGkMQEgYtASl+jNvvgERbRQCeWAODhIB3JRbbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1740088963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=HE4yw7t8QdxBlWx+Mw8t8qjzm4JBkWSw7XlScUXuTwE=;
	b=iaAO9j84fJvqwgKk8vf8K+ml8YyqEhmR+taNMmLIvNfgBgl9LZxfL2F2AXmBuO5LhmdTEP
	Gc5C+KXA4ws1J2svLKlAVaj8URIz60WIOfOVoEqM69HOvixGz7+2MPvbe191OSzlUrIAG0
	rFrAzGpio2/D5+uA2lU/bh0OFj4sC4vhwTf9FrovAOctTORUqtsIUBUEC4KXbOB6BNAJaw
	TJ7xmPfGNr5+RpjxYQxF92UHhCM4XZLVdrydDgOQcvTldeJ0k3fJhkXmVXJwQhzAA1bM1q
	gWuX49H0NvG1IgIW4Bbe322XqsPyQESybvyewMCA1Ho7BBEOcQ78sXwDT/zq6w==
ARC-Authentication-Results: i=1;
	rspamd-6d7cc6b78d-56wzv;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Good
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Eyes-Decisive: 36a19a3323ea6251_1740088963924_3244690159
X-MC-Loop-Signature: 1740088963924:505088856
X-MC-Ingress-Time: 1740088963924
Received: from pdx1-sub0-mail-a229.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.101.208.252 (trex/7.0.2);
	Thu, 20 Feb 2025 22:02:43 +0000
Received: from localhost.localdomain (unknown [104.36.25.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a229.dreamhost.com (Postfix) with ESMTPSA id 4YzS1G3SQJz7L;
	Thu, 20 Feb 2025 14:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1740088963;
	bh=A+Z+pjkn06zjAUF9YWa+SCCQMAmkJ3ZA5ItluKtMwLo=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=SyT/riCwLvGyjIXNwxm0xuCk5x99VHf6jvRghOO5489cu376zRJlfuNivhIyhehsZ
	 pH5oie/ekLHEaa37XjG1mm1d7gUKKa9hzhHQZWdbk50kJ/D5yKpOpTZFzx5fheO5RL
	 tS659LuQJtuQEhl99xrDOUgiCArvYkED7yORcm+cvW/6qCrv3qQSa5dLV4MCPk42C2
	 2gzwgvTvXopYWviddZcZ8GLXvkRbAaqlOkkRH63u0MabH1A0D5BWi2hmAHGtpjj0NH
	 FPSq2rFpp5rxPlcPLb2U2vl0Xyhgh6hcl9HD5uFnqITfYEkIAUcQxZWGgsabEYNSsY
	 ApU+l2de1UUVA==
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
Date: Thu, 20 Feb 2025 14:02:33 -0800
Message-Id: <20250220220235.276831-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250220220235.276831-1-dave@stgolabs.net>
References: <20250220220235.276831-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

... to a better suited 'cxl_arm_dirty_shutdown()'.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
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
index bd0b6533d863..5afd9ca9a944 100644
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

