Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A485241754;
	Sun, 21 Dec 2025 14:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766326591; cv=none; b=Esbsj+NttWa1Q9EQgfq+MM4r8ZZX5YkMY7buqCNwsFKKXZrDaJTbDHJBVxxR+bzvmwnb7DdI6XOpv9CTxLFaEGpbBdkPfff3jXASn/7N7lxJioeo5EfVYUUIHx33MCC1Cx0w147nfV+PEVk/vF8RZUbuS6h039ZgtJ8XwZHDx1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766326591; c=relaxed/simple;
	bh=R662WfUW8fzz2Lk7Zk1lmbk6WAIhElEfrhii+q+4paM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sWQFwQfcZNUdA/rhpagwbYmv41BcYMuqMRBfBX7ydTbPBiuX5vFYklbiApJ+RlT86Vn1IyObebIkzlYDhK2rYT6YIGq7VyECRrigqjyCO7vLx6ufQSF07FAB00cgHSJsOG5EsGuvJG+HnGBaGuKGbjAytzsOlnoupgT2cEnVf4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=MiOy5a4/; arc=none smtp.client-ip=80.12.242.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="MiOy5a4/"
Received: from fedora.home ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id XKDDv5WpAxWB5XKDEvwo6K; Sun, 21 Dec 2025 15:15:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1766326511;
	bh=4CF7lA+tpW5yONwhd/4JOcysxrvmqrwS96S3j58xGOw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=MiOy5a4/UEvMBkTjkFe9l4rOGFLaGBHBwxLdJTCt005AXZicGaCPvauWaxi+etSLG
	 fBavmllN7Fn02lL7Bd6Pe4Y36ZArze8GfM380p4t2zCMNfieIgtp6fzhPa4WjiKJTl
	 kunQDOMTdcgOULI+1vGuVvVwpCc79sJABPsGOw/PDrpTv2FcoRFHbbkcwN+rqBXb19
	 OVTxuJXnCSlRYbKdYlFUFG8ANKSDM0FLQxOpwapcs5yX9hkk1AkC6vTYTpOYN9IedC
	 llcGG2OnTfYoHmxpYV8/IC3+/PUbP2S6BfTc1hwLDpPTk/sT7PCZ8zgBzcZhwICr6P
	 8NxT88TVHdU+A==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 21 Dec 2025 15:15:11 +0100
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-cxl@vger.kernel.org
Subject: [PATCH] cxl: Slightly simplify emit_target_list()
Date: Sun, 21 Dec 2025 15:15:04 +0100
Message-ID: <589ee57cfc275c5249885e1eace22e9bf3a9561d.1766326481.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sysfs_emit_at() never returns a negative error code. It returns 0 or the
number of characters written in the buffer.

Remove the useless test. This simplifies the logic and saves a few lines of
code.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/cxl/core/port.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index fef3aa0c6680..b77c1600beaa 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -151,7 +151,7 @@ static ssize_t emit_target_list(struct cxl_switch_decoder *cxlsd, char *buf)
 {
 	struct cxl_decoder *cxld = &cxlsd->cxld;
 	ssize_t offset = 0;
-	int i, rc = 0;
+	int i;
 
 	for (i = 0; i < cxld->interleave_ways; i++) {
 		struct cxl_dport *dport = cxlsd->target[i];
@@ -162,11 +162,9 @@ static ssize_t emit_target_list(struct cxl_switch_decoder *cxlsd, char *buf)
 
 		if (i + 1 < cxld->interleave_ways)
 			next = cxlsd->target[i + 1];
-		rc = sysfs_emit_at(buf, offset, "%d%s", dport->port_id,
-				   next ? "," : "");
-		if (rc < 0)
-			return rc;
-		offset += rc;
+		offset += sysfs_emit_at(buf, offset, "%d%s",
+					dport->port_id,
+					next ? "," : "");
 	}
 
 	return offset;
-- 
2.52.0

