Received: from crocodile.elm.relay.mailchannels.net (crocodile.elm.relay.mailchannels.net [23.83.212.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9041253B42
	for <linux-cxl@vger.kernel.org>; Tue, 28 Jul 2026 14:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.212.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785250061; cv=none; b=oLydlCXB2R1pEAWu5ajD0jL6uW5w9piiYPDfJTNpr6SrWJEMH5a5uUwi+3J4aKf4AtWI1OYGiuavzggqY2gapiBieR1UPePrcKp7t5z+/jU+I5k8o4GxKXXh5Je/cFGb9IePtXlRVgz4LLRnW1e4CsykieghKuOh+Z/nrqWzNmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785250061; c=relaxed/simple;
	bh=AWspOop5FpvJR4HtQaqSAL2utklPORUxe1kPhyvtQ+I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hKKsdpvf8Jf1/zscQVUG2bRA6037goxCKVFVvPeOhQC1yIEuHE9aaA3G9gN6Kf1hImqZ8kZVUf8BnK6iib8CHaz3ERSe+sC9ruKVOa0jGDEsTwJybJKdZGp3sqNWJ4FC/PfJZOZzyOPa9Rwfch9rpdwuKJaqZ6bsvs6LNPp/WPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=WYmCms1p; arc=none smtp.client-ip=23.83.212.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="WYmCms1p"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id D277B402A78;
	Tue, 28 Jul 2026 14:41:54 +0000 (UTC)
Received: from pdx1-sub0-mail-a216.dreamhost.com (100-108-77-99.trex-nlb.outbound.svc.cluster.local [100.108.77.99])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 751F8400B93;
	Tue, 28 Jul 2026 14:41:50 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Unite-Thread: 0b8195e23c33d35c_1785249714763_15189015
X-MC-Loop-Signature: 1785249714762:2178931470
X-MC-Ingress-Time: 1785249714762
Received: from pdx1-sub0-mail-a216.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.108.77.99 (trex/8.0.2);
	Tue, 28 Jul 2026 14:41:54 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a216.dreamhost.com (Postfix) with ESMTPSA id 4h8dT95prXz2N;
	Tue, 28 Jul 2026 07:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1785249710;
	bh=N1hHblkcNPDeeN62ZbicHgM9YL1NxvJusbV5MzI8oWE=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=WYmCms1pSqKRWcf/niXg1AgR9wa1G74vD6ITvLoRFKhNK+6VbTyI1eSnNYOV6vjCc
	 TDfPogZj8Iw3nQKcEhdo7bUscZ4HDuaY4mSNmXZQ5cH+a1RAr5APH6HxREU+kwdtXt
	 TC1GfhkpgIkilJ6D+XEYRnH1DRk9OAmo/H32BJOqHaLQOPtTcOu9nPpHDLU7PE/2Dp
	 wTlX7O7Cjxm+0fsy1uqVgqtQdAs6HZvjJSqjL7Q/6+087l4LmDgLcjtkIju2DBu8l/
	 dOInhpil6p9fvn1q0Q221/+zSCI1IfgyWD0NNqsFwENB93YMJStFgKXzcjNH9N1Obd
	 LM98U5CHJxICA==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com
Cc: jic23@kernel.org,
	alison.schofield@intel.com,
	icheng@nvidia.com,
	benjamin.cheatham@amd.com,
	alucerop@amd.com,
	dongjoo.seo1@samsung.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org
Subject: [PATCH v7 6/8] cxl/region: Log the coherency model at region creation
Date: Tue, 28 Jul 2026 07:41:34 -0700
Message-Id: <20260728144136.709882-7-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260728144136.709882-1-dave@stgolabs.net>
References: <20260728144136.709882-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Region assembly emits plenty of debug information - resources,
interleave geometry, target placement - but not the coherency model
the region operates in.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/core/region.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 840acc330ede..76c6dc28a407 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2741,6 +2741,17 @@ void kill_regions(struct cxl_root_decoder *cxlrd)
 		unregister_region(cxlr);
 }
 
+static const char *cxl_region_coherency(struct cxl_region *cxlr)
+{
+	if (cxlr->type == CXL_DECODER_HOSTONLYMEM)
+		return "HDM-H";
+
+	if (cxl_root_decoder_is_bi(cxlr->cxlrd))
+		return "HDM-DB";
+
+	return "HDM-D";
+}
+
 /**
  * devm_cxl_add_region - Adds a region to a decoder
  * @cxlrd: root decoder
@@ -2785,8 +2796,9 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
 		return ERR_PTR(rc);
 	}
 
-	dev_dbg(port->uport_dev, "%s: created %s\n",
-		dev_name(&cxlrd->cxlsd.cxld.dev), dev_name(dev));
+	dev_dbg(port->uport_dev, "%s: created %s %s\n",
+		dev_name(&cxlrd->cxlsd.cxld.dev), cxl_region_coherency(cxlr),
+		dev_name(dev));
 	return cxlr;
 err:
 	put_device(dev);
-- 
2.39.5

