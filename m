Received: from quail.birch.relay.mailchannels.net (quail.birch.relay.mailchannels.net [23.83.209.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789A03644DB
	for <linux-cxl@vger.kernel.org>; Wed, 18 Mar 2026 18:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.151
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773860131; cv=pass; b=XuXVSyNaym53gj9n/pACsi5zg7F+EZny/X+plf33QORDPqAI5yZwaJMj9kIs7uvOiO1uW1NBZiSz7MabbPiS632xX8Jg468oKhA4wz2gwtgGXTybCS25xGRzyzuOIUfUUBd+BHMuDLKBQRUfhs4MnDzuZr2k2/HxamQ/KLgcfsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773860131; c=relaxed/simple;
	bh=JmNKcshpkqvRhM43DK8EnLhYQ5CqtYysNgg0t3unKn8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mnDz6dXooxW2DqQ72ltlwg2SCK3MY0jPk8nx9TVrb1fMF8mBiGXO7SthUIx5K6Z3m+OFxiNx4IJeN9cA7Fd8Bp4q3vIFxJbubnAfbmBmw9MAmogCCk3xIhA62Z45koRxOT4DRo1VKWPK5FC3yTrCwUhmKFPjVkxW4dg3yw+pxhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=enaPONgh; arc=pass smtp.client-ip=23.83.209.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="enaPONgh"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id A55FB5615FA;
	Wed, 18 Mar 2026 18:55:24 +0000 (UTC)
Received: from pdx1-sub0-mail-a234.dreamhost.com (100-113-227-94.trex-nlb.outbound.svc.cluster.local [100.113.227.94])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 553865625C9;
	Wed, 18 Mar 2026 18:55:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1773860124;
	b=+VxWY99mYz/0NNpHxqabOxxa2eRNcw+v3I0ASqyHTIHRgzTJ5KFTCra4Jjxk8rjEFn4u11
	LqnZif0pzWQ1ngkLDEwfmIKCs6mJmwh9r6mItwAhM5wGiumU0AHsV2AL3D/eevWRDjqwMm
	NAK7KLodbeHHSQ/OAT64dxemm5JA4mNy/AcUvITJH6zrwH29U9bH43ZaRpYeTahIfT0eeq
	Al4UwY8vPpOZL3AUgPEAuewrSbbspe1NaGskfHZn/n1zsKIOJU48hmMWgdf/6siL/7Ti5z
	MYae4rwJYRqpu1Y6HZl+3xPb+w8q/FRK5WlczKhrAAFzaQITTgSlugKTYF6tjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1773860124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=/iDOI+sSh+9Yee0cSH/s/5Ywv6VbWKUUjfu46SL03Fk=;
	b=i7rcYlJADz5XgKBZGz1owolu51FFwHeeG7rshkaVF/8A3mOlXnsffIVitay4sMx/0IIHoD
	JxU8UpXuNpVyDhEdfvTC2cxdZo+4W5PmdqgFcomPmrbN5HIs6lqL751sX6r8O4p7yZwBr8
	CTnifK9Bjkyr6PnydebCDx7h0PMAhGPRBgJsWPc/NuSz68nt3Z1glBNXEBgQWemN7XTinJ
	05IUTXj1pv59P5yvW9UfOTHpXhcJH6+wyDEC4VFi6DvSty5oYhAo/eAQt/xuTdfCzR5BYe
	ijoqKUOJadezeaHvKhnZvCWcg7BE2aaMIF5n5TdqDB05RN7szzpmT8z0ahwBKA==
ARC-Authentication-Results: i=1;
	rspamd-6d4cb6745-2x4br;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Print-Unite: 5792d40165fcc169_1773860124576_2741740077
X-MC-Loop-Signature: 1773860124576:1920558480
X-MC-Ingress-Time: 1773860124576
Received: from pdx1-sub0-mail-a234.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.113.227.94 (trex/7.1.5);
	Wed, 18 Mar 2026 18:55:24 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a234.dreamhost.com (Postfix) with ESMTPSA id 4fbdLg6ldRz1079;
	Wed, 18 Mar 2026 11:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1773860124;
	bh=/iDOI+sSh+9Yee0cSH/s/5Ywv6VbWKUUjfu46SL03Fk=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=enaPONgh2aOjuyK00GMVXJygXsC1Cmb/e00v7i2Y2WazMTJV/Ai5X/d/DWEzU0PtG
	 vtj+8PyyDYobi8taAHnN45hYEV0YxfibJ2MZy36TIrZJahpo4STQA0g51jPEY7zo3a
	 6blZJhCDZnFfmZAeZcT8ebpNEEYHgMmD7d1mSwocyxM9+vul+KJI/7EUDIC9bJimnO
	 NXMzRf8qQ0LkC5yrxRYrVUqyvTqgUDAqzZ/Z568dSRERDOIEkiNrR4UNOCJnQDquTj
	 lR9fzNcT9uGRETa1gsK/0pRf6VYk6qqqNXthCq75zIyWww1Kdpdd+Jhgi7mrCDyeUz
	 GIE3pevbMAA/g==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jonathan.cameron@huawei.com
Cc: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org,
	dave@stgolabs.net
Subject: [PATCH 2/2] hw/cxl: Exclude Discovery from Media Operation Discovery output
Date: Wed, 18 Mar 2026 11:55:08 -0700
Message-Id: <20260318185508.3683044-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260318185508.3683044-1-dave@stgolabs.net>
References: <20260318185508.3683044-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Per CXL 4.0 Table 8-331, the Discovery operation "returns a list of
all Media Operations that the device supports, with the exception of
the Discovery operation (Class=0, Subclass=0)."

Filter out Discovery entries when building the output list and adjust
total_supported_operations accordingly.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 hw/cxl/cxl-mailbox-utils.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 71a012121c87..6932db963788 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -2593,7 +2593,7 @@ static CXLRetCode media_operations_discovery(uint8_t *payload_in,
     } QEMU_PACKED *media_op_in_disc_pl = (void *)payload_in;
     struct media_op_discovery_out_pl *media_out_pl =
         (struct media_op_discovery_out_pl *)payload_out;
-    int total = ARRAY_SIZE(media_op_matrix);
+    int total = ARRAY_SIZE(media_op_matrix) - 1; /* exclude Discovery */
     int num_ops, start_index, i;
     int count = 0;
 
@@ -2619,10 +2619,12 @@ static CXLRetCode media_operations_discovery(uint8_t *payload_in,
 
     num_ops = MIN(num_ops, total - start_index);
     for (i = 0; i < num_ops; i++) {
+        int idx = start_index + i + 1; /* skip Discovery (first entry) */
+
         media_out_pl->entry[count].media_op_class =
-                media_op_matrix[start_index + i].media_op_class;
+                media_op_matrix[idx].media_op_class;
         media_out_pl->entry[count].media_op_subclass =
-                    media_op_matrix[start_index + i].media_op_subclass;
+                    media_op_matrix[idx].media_op_subclass;
         count++;
     }
 
-- 
2.39.5

