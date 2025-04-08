Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6112641FF
	for <linux-cxl@vger.kernel.org>; Tue,  8 Apr 2025 08:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744101744; cv=none; b=QJZtPsxQEE/AEU3uzQt2YHs58uGiO8NAA4UMqytJ597nGxtjisEdlDNKBjB6gn+7gwThJyB7m+812l+DGTIaPMC9HbcsS6SOYKJyeJ1GnqirclGuK7/C2da02arTvxXpy5wGFqOiB8lNjdIgvJHiWanwzrkzRiUypOaz9a37dM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744101744; c=relaxed/simple;
	bh=4uuCI2JtloExpEnTLlRd2twahd6Cdr93hVG2zOH3s0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qt5tXIdUGYGntjSZpiT8AjWmedfGWRwf2SMXgzhLDZdMQxSVvY6Yd9BX2k4+EwGmq8SEPe9sOa+xsqp5blRq1Sxg1fYtTtPDXaV5O+6tn9qhJCQVr3V4Bk4D112AZr8yaJM73GZhCapCk5r1QSyWzetPjQy0CkVM0mdvwJ3ldvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2XwOos+r; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yTNQnpGT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2XwOos+r; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yTNQnpGT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2XwOos+r";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yTNQnpGT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2XwOos+r";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yTNQnpGT"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8F70F21185;
	Tue,  8 Apr 2025 08:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744101735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OY+ktWKu7rfDC6OOLEBMjxNMAtURJVUDnyjqclkHyqM=;
	b=2XwOos+reVOOfP6FDGwVtID+hc1km1M67+rQc5mr+wTPYI+REDBlJopVzQMlrL1E7CAO3E
	lUZL0Ic521Xjz97TP4pFuGxx9Im+1n0C5l+Qu2L+8CF+krGA9KcSddez6DZ54mT/8hhuOJ
	o60Gtr334jhZUSn5GaswJ2c8wNyZDI4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744101735;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OY+ktWKu7rfDC6OOLEBMjxNMAtURJVUDnyjqclkHyqM=;
	b=yTNQnpGT7fZKJ4td9Qa8ZhjB6Y7OIvjcsBUoPEfAj65BwcjwxQLJQ2GTC7ZjNZwKOLm8BS
	wl7Jz92XSxp3RgCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=2XwOos+r;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=yTNQnpGT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744101735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OY+ktWKu7rfDC6OOLEBMjxNMAtURJVUDnyjqclkHyqM=;
	b=2XwOos+reVOOfP6FDGwVtID+hc1km1M67+rQc5mr+wTPYI+REDBlJopVzQMlrL1E7CAO3E
	lUZL0Ic521Xjz97TP4pFuGxx9Im+1n0C5l+Qu2L+8CF+krGA9KcSddez6DZ54mT/8hhuOJ
	o60Gtr334jhZUSn5GaswJ2c8wNyZDI4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744101735;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OY+ktWKu7rfDC6OOLEBMjxNMAtURJVUDnyjqclkHyqM=;
	b=yTNQnpGT7fZKJ4td9Qa8ZhjB6Y7OIvjcsBUoPEfAj65BwcjwxQLJQ2GTC7ZjNZwKOLm8BS
	wl7Jz92XSxp3RgCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0EAFA13691;
	Tue,  8 Apr 2025 08:42:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cFXGAGfh9Gd6VgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 08 Apr 2025 08:42:15 +0000
From: Oscar Salvador <osalvador@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Vlastimil Babka <vbabka@suse.cz>,
	Harry Yoo <harry.yoo@oracle.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-cxl@vger.kernel.org,
	Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 1/3] mm,slub: Do not special case N_NORMAL nodes for slab_nodes
Date: Tue,  8 Apr 2025 10:41:51 +0200
Message-ID: <20250408084153.255762-2-osalvador@suse.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408084153.255762-1-osalvador@suse.de>
References: <20250408084153.255762-1-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8F70F21185
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Currently, slab_mem_going_going_callback() checks whether the node has
N_NORMAL memory in order to be set in slab_nodes.
While it is true that gettind rid of that enforcing would mean
ending up with movables nodes in slab_nodes, the memory waste that comes
with that is negligible.

So stop checking for status_change_nid_normal and just use status_change_nid
instead which works for both types of memory.

Also, once we allocate the kmem_cache_node cache  for the node in
slab_mem_online_callback(), we never deallocate it in
slab_mem_off_callback() when the node goes memoryless, so we can just
get rid of it.

The only side effect is that we will stop clearing the node from slab_nodes.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/slub.c | 30 +-----------------------------
 1 file changed, 1 insertion(+), 29 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index b46f87662e71..e716b4cb2d0e 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -6164,36 +6164,12 @@ static int slab_mem_going_offline_callback(void *arg)
 	return 0;
 }
 
-static void slab_mem_offline_callback(void *arg)
-{
-	struct memory_notify *marg = arg;
-	int offline_node;
-
-	offline_node = marg->status_change_nid_normal;
-
-	/*
-	 * If the node still has available memory. we need kmem_cache_node
-	 * for it yet.
-	 */
-	if (offline_node < 0)
-		return;
-
-	mutex_lock(&slab_mutex);
-	node_clear(offline_node, slab_nodes);
-	/*
-	 * We no longer free kmem_cache_node structures here, as it would be
-	 * racy with all get_node() users, and infeasible to protect them with
-	 * slab_mutex.
-	 */
-	mutex_unlock(&slab_mutex);
-}
-
 static int slab_mem_going_online_callback(void *arg)
 {
 	struct kmem_cache_node *n;
 	struct kmem_cache *s;
 	struct memory_notify *marg = arg;
-	int nid = marg->status_change_nid_normal;
+	int nid = marg->status_change_nid;
 	int ret = 0;
 
 	/*
@@ -6251,10 +6227,6 @@ static int slab_memory_callback(struct notifier_block *self,
 	case MEM_GOING_OFFLINE:
 		ret = slab_mem_going_offline_callback(arg);
 		break;
-	case MEM_OFFLINE:
-	case MEM_CANCEL_ONLINE:
-		slab_mem_offline_callback(arg);
-		break;
 	case MEM_ONLINE:
 	case MEM_CANCEL_OFFLINE:
 		break;
-- 
2.49.0

