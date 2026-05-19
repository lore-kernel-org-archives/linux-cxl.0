Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AA43BB130
	for <linux-cxl@vger.kernel.org>; Tue, 19 May 2026 21:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779224525; cv=none; b=rKyjnt8bRczSyGWuWLIeXKssJpfe3WcpihGuPwj6HSqdEkgnhwdtBOBVvjMhfaZ7l2uruCNNizU6rIthoUf6xmq+YakIkdPiuYzERnzk7S5YT3UqCwNoHaQPcLu/q0sgmlpOYwC32LLloEFPa8Vy5I7tKFzkDTPFVKmNUmh3CgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779224525; c=relaxed/simple;
	bh=T16Ngfqy8AC1yMgKRQ/g7jrOk4JNdAG0x9oBzEhayM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=riurCv0EA3rr4GkbZPapJKzB7APoFgZmen1DENHuAEXPhKdVZfwN00veSBj/EcScJPnqi1dHpEKf20DB4HQltLDOHzIztHdT3cjF7K39str8lJu5PWnOHYMFEGqKUN0WBgjc7CGiyVM5nB6nSX4mKYpdLYrH/f8NNySxdcJjupk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGVuCubf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGVuCubf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF9A1F00894;
	Tue, 19 May 2026 21:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779224523;
	bh=p03xqoQYlYArBvp2NbGkqXi3xPKw+zRyIno6T8ri+L0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZGVuCubf8orBnh0tg06Bp+A+cwj+odlap2VcwDTOdO7yXOe7VLvcr5BWx5LIPvs/+
	 6InLoRcj8U+mG+OgV5x4SsDweZXAHf0sui3BVH5EM0Pw5Z3zGhdsE5SiGX4jtKrxWF
	 HzJH8mwn6ocXIBCtDYG35I2JsH0WDB2CzJUx2RKaNjSW3y3YZVPh1rAL9ZjAEinEoT
	 em8A5+X+MZnZksJU8vuDcP37JQnol7wDaM8/vcwtdLeV9zKOtC93xGO9rIm+0o9sU2
	 jwS5/OgmqTJWMS60+omEtxHpTanAFf7pxVkrvd33tpWM/buTKxPfUok4SH7coGv3fH
	 m86n7/MfWi/Qg==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id EC862F40075;
	Tue, 19 May 2026 17:02:02 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 19 May 2026 17:02:02 -0400
X-ME-Sender: <xms:ys8Mau0Q5Px--oUNynOJsXrbedN2a3Xc-Gkz1DeI3uy9p6XcMPKs0Q>
    <xme:ys8Man8J-c8o1rE5GC1fMQ6I3ZfFw0VJrZccJR3tsFhYSJby5I1QwvUFLjHgjF_mK
    45DfYyrtLRoBp-F-KWNRc6wMrbX0hRFQMp8xGsEpeGR0DFxMQ45Ogk>
X-ME-Received: <xmr:ys8MavO3t9GRni52vMHUbtw69OeUuq325FqapUsQqEYEcmQqzI4ZrzcmOpbpIkqhwzZ2x50U7G7CXlyFSmEL76US5C4P3ImxxTI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugedvjeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeffrghnucghihhllhhirghmshcuoegujhgsfieskhgvrhhnvghl
    rdhorhhgqeenucggtffrrghtthgvrhhnpeeuheffhfelleelgedutdfhleefjeejvedtke
    fgjeefgfettdeljeefvefhueeiveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpegujhgsfidomhgvshhmthhprghuthhhphgvrhhsohhnrghlih
    hthidqudejjedvfedtgeehhedqfeeffeelgedtgeejqdgujhgsfieppehkvghrnhgvlhdr
    ohhrghesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehlihhnuhigqdgtgihlsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepuggrvhgvrdhjihgrnhhgsehinhhtvghlrdgtohhmpdhrtg
    hpthhtoheprghlvghjrghnughrohdrlhhutggvrhhoqdhprghlrghusegrmhgurdgtohhm
    pdhrtghpthhtohepjhhitgdvfeeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughjsg
    ifsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ys8MarfOIi5HRNcGUHHMxUJMm4jMO_aqkbQM7fjSrHeDI_e0Y0uRHA>
    <xmx:ys8MauUqVGIY3elxy9ZX-C48yLNEsPAnPjtZ48KlfymTdeMBCVfBtQ>
    <xmx:ys8MajhbeKH8wwcDqLlR22wypWTi3e5UH1tpgb-opI8r80jii8WwlQ>
    <xmx:ys8Mat9uDOBYdUpexp0vre9d8gsDYFCvIYaNisTkiwb-ndsan-s-aw>
    <xmx:ys8MalbQ7B9TX35hic7kacoFO93g1FL0Z3MVtUolHt57Ez3doP0nq_sR>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 May 2026 17:02:02 -0400 (EDT)
From: Dan Williams <djbw@kernel.org>
To: linux-cxl@vger.kernel.org
Cc: dave.jiang@intel.com,
	alejandro.lucero-palau@amd.com,
	jic23@kernel.org
Subject: [PATCH 1/5] cxl/region: Block region delete during region creation
Date: Tue, 19 May 2026 14:01:54 -0700
Message-ID: <20260519210158.1499795-2-djbw@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260519210158.1499795-1-djbw@kernel.org>
References: <20260519210158.1499795-1-djbw@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expand the range lock, rename it "regions_lock", to disable region deletion
in the critical period between construct_region() and attach_target(), as
well as the period between device_add() and registering the remove actions.

Otherwise, userspace can confuse the kernel. It can violate the assumption
the region stays registered through the completion of cxl_add_to_region().
It can violate the assumption that devm_add_action_or_reset() is working
with a live 'struct cxl_region'.

It is ok for the region to disappear outside of those windows as that
mirrors device hotplug flows where the proper locks are held.

Fixes: a32320b71f08 ("cxl/region: Add region autodiscovery")
Signed-off-by: Dan Williams <djbw@kernel.org>
---
 drivers/cxl/cxl.h         |  4 ++--
 drivers/cxl/core/port.c   |  2 +-
 drivers/cxl/core/region.c | 12 ++++++++++--
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 1297594beaec..3900a0778571 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -359,7 +359,7 @@ struct cxl_rd_ops {
  * @cache_size: extended linear cache size if exists, otherwise zero.
  * @region_id: region id for next region provisioning event
  * @platform_data: platform specific configuration data
- * @range_lock: sync region autodiscovery by address range
+ * @regions_lock: sync region discovery, construction, and deletion
  * @qos_class: QoS performance class cookie
  * @ops: CXL root decoder operations
  * @cxlsd: base cxl switch decoder
@@ -369,7 +369,7 @@ struct cxl_root_decoder {
 	resource_size_t cache_size;
 	atomic_t region_id;
 	void *platform_data;
-	struct mutex range_lock;
+	struct mutex regions_lock;
 	int qos_class;
 	struct cxl_rd_ops ops;
 	struct cxl_switch_decoder cxlsd;
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index c5aacd7054f1..6e7a70d51cfe 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -2016,7 +2016,7 @@ struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
 		return ERR_PTR(rc);
 	}
 
-	mutex_init(&cxlrd->range_lock);
+	mutex_init(&cxlrd->regions_lock);
 
 	cxld = &cxlsd->cxld;
 	cxld->dev.type = &cxl_decoder_root_type;
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e50dc716d4e8..b5601e89e302 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2779,6 +2779,10 @@ static ssize_t create_region_store(struct device *dev, const char *buf,
 	if (rc != 1)
 		return -EINVAL;
 
+	ACQUIRE(mutex_intr, regions_lock)(&cxlrd->regions_lock);
+	if ((rc = ACQUIRE_ERR(mutex_intr, &regions_lock)))
+		return rc;
+
 	cxlr = __create_region(cxlrd, mode, id, CXL_DECODER_HOSTONLYMEM);
 	if (IS_ERR(cxlr))
 		return PTR_ERR(cxlr);
@@ -2838,6 +2842,11 @@ static ssize_t delete_region_store(struct device *dev,
 	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
 	struct cxl_port *port = to_cxl_port(dev->parent);
 	struct cxl_region *cxlr;
+	int rc;
+
+	ACQUIRE(mutex_intr, regions_lock)(&cxlrd->regions_lock);
+	if ((rc = ACQUIRE_ERR(mutex_intr, &regions_lock)))
+		return rc;
 
 	cxlr = cxl_find_region_by_name(cxlrd, buf);
 	if (IS_ERR(cxlr))
@@ -3776,12 +3785,11 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 	 * for the HPA range, one does the construction and the others
 	 * add to that.
 	 */
-	mutex_lock(&cxlrd->range_lock);
+	guard(mutex)(&cxlrd->regions_lock);
 	struct cxl_region *cxlr __free(put_cxl_region) =
 		cxl_find_region_by_range(cxlrd, &ctx.hpa_range);
 	if (!cxlr)
 		cxlr = construct_region(cxlrd, &ctx);
-	mutex_unlock(&cxlrd->range_lock);
 
 	rc = PTR_ERR_OR_ZERO(cxlr);
 	if (rc)
-- 
2.53.0

