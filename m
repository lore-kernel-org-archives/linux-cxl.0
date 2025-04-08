Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16F9263C7B
	for <linux-cxl@vger.kernel.org>; Tue,  8 Apr 2025 08:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744101750; cv=none; b=QbtTjLUGdN43cpDn+A3ewfX/sCV29u4ASNJ8VZJujpvxXAVS6FYnVBzhy2qcQdAUGbq4NWFi0ojC/7mLqxaISGJbJcnBIAWZpd2LiDIIOofA+mesv90fyjubP+6HCBw4bR+5MGWE3MsT6GXZpMXdBV26FV2AfEvmJMx8XgVxTnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744101750; c=relaxed/simple;
	bh=esPq+m55JjydPKmeP5AvlPLBoUxxnD+A6ZhyJ3fFSW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZSBPDQrH/e//HddZocNLdXTeKzjwEdHMUfBG5zrdlVbgAtUaGFBM3A6NG5XMY8mFX1A4ynYRmxE2J3n0MHup68IMRBgI8zBINYLTxS4DwZmBvdpeFgIRDaeW/CEDJcMrCu0pKPoGuw46i6VSUp8TxTVmcfJHp/FsM5MfvdQHCUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=G6x6iznC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=x8d0FELz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=G6x6iznC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=x8d0FELz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="G6x6iznC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="x8d0FELz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="G6x6iznC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="x8d0FELz"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 94EF01F388;
	Tue,  8 Apr 2025 08:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744101738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EbHqyD5MPLNmbHBByHN31fJenBrFZtOPsSi4jdC01rk=;
	b=G6x6iznCrdzY0itk2HMicKZH0IC8c06xkBWSokxCN6boaS04LYm+Rw4o8JGBWeRoM9wkYq
	i8D2RmlNBK3DLacMQwFmpQZvrrg157UV8Oe0q1LA/IDLKU6TZm00onqcqs9UnBCbgVCxz2
	8nDLXcCD8E1MzdRVdslqdjDVV5JxR54=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744101738;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EbHqyD5MPLNmbHBByHN31fJenBrFZtOPsSi4jdC01rk=;
	b=x8d0FELzVTCthqRW8sKH9jRxMbo2+4oBUED76yIjwVqCt4WZlh4pnfViRcmW84h7DxCmfA
	EUU+QMnPB+sS+rCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=G6x6iznC;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=x8d0FELz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744101738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EbHqyD5MPLNmbHBByHN31fJenBrFZtOPsSi4jdC01rk=;
	b=G6x6iznCrdzY0itk2HMicKZH0IC8c06xkBWSokxCN6boaS04LYm+Rw4o8JGBWeRoM9wkYq
	i8D2RmlNBK3DLacMQwFmpQZvrrg157UV8Oe0q1LA/IDLKU6TZm00onqcqs9UnBCbgVCxz2
	8nDLXcCD8E1MzdRVdslqdjDVV5JxR54=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744101738;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EbHqyD5MPLNmbHBByHN31fJenBrFZtOPsSi4jdC01rk=;
	b=x8d0FELzVTCthqRW8sKH9jRxMbo2+4oBUED76yIjwVqCt4WZlh4pnfViRcmW84h7DxCmfA
	EUU+QMnPB+sS+rCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 146F313A80;
	Tue,  8 Apr 2025 08:42:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +LYwAmrh9Gd6VgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 08 Apr 2025 08:42:18 +0000
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
Subject: [PATCH v2 3/3] mm,memory_hotplug: Rename status_change_nid parameter in memory_notify
Date: Tue,  8 Apr 2025 10:41:53 +0200
Message-ID: <20250408084153.255762-4-osalvador@suse.de>
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
X-Rspamd-Queue-Id: 94EF01F388
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.de:dkim,suse.de:mid,suse.de:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

The 'status_change_nid' field was used to track changes in the memory
state of a numa node, but that funcionality has been decoupled from
memory_notify and moved to node_notify.
Current consumers of memory_notify are only interested in which node the
memory we are adding belongs to, so rename current 'status_change_nid'
to 'nid'.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/memory.h |  2 +-
 mm/memory_hotplug.c    |  4 ++--
 mm/page_ext.c          | 12 +-----------
 3 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/include/linux/memory.h b/include/linux/memory.h
index a5b8068cf182..241a98e31277 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -117,7 +117,7 @@ struct memory_notify {
 	unsigned long altmap_nr_pages;
 	unsigned long start_pfn;
 	unsigned long nr_pages;
-	int status_change_nid;
+	int nid;
 };
 
 struct node_notify {
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 84248f2e36f8..19f2f8a08645 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1192,6 +1192,7 @@ int online_pages(unsigned long pfn, unsigned long nr_pages,
 
 	mem_arg.start_pfn = pfn;
 	mem_arg.nr_pages = nr_pages;
+	mem_arg.nid = nid;
 	node_states_check_changes_online(nr_pages, zone, &node_arg);
 
 	if (node_arg.status_change_nid >= 0) {
@@ -1204,7 +1205,6 @@ int online_pages(unsigned long pfn, unsigned long nr_pages,
 	}
 
 	cancel_mem_notifier_on_err = true;
-	mem_arg.status_change_nid = node_arg.status_change_nid;
 	ret = memory_notify(MEM_GOING_ONLINE, &mem_arg);
 	ret = notifier_to_errno(ret);
 	if (ret)
@@ -2018,6 +2018,7 @@ int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 
 	mem_arg.start_pfn = start_pfn;
 	mem_arg.nr_pages = nr_pages;
+	mem_arg.nid = node;
 	node_states_check_changes_offline(nr_pages, zone, &node_arg);
 
 	if (node_arg.status_change_nid >= 0) {
@@ -2029,7 +2030,6 @@ int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 	}
 
 	cancel_mem_notifier_on_err = true;
-	mem_arg.status_change_nid = node_arg.status_change_nid;
 	ret = memory_notify(MEM_GOING_OFFLINE, &mem_arg);
 	ret = notifier_to_errno(ret);
 	if (ret) {
diff --git a/mm/page_ext.c b/mm/page_ext.c
index c351fdfe9e9a..477e6f24b7ab 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -378,16 +378,6 @@ static int __meminit online_page_ext(unsigned long start_pfn,
 	start = SECTION_ALIGN_DOWN(start_pfn);
 	end = SECTION_ALIGN_UP(start_pfn + nr_pages);
 
-	if (nid == NUMA_NO_NODE) {
-		/*
-		 * In this case, "nid" already exists and contains valid memory.
-		 * "start_pfn" passed to us is a pfn which is an arg for
-		 * online__pages(), and start_pfn should exist.
-		 */
-		nid = pfn_to_nid(start_pfn);
-		VM_BUG_ON(!node_online(nid));
-	}
-
 	for (pfn = start; !fail && pfn < end; pfn += PAGES_PER_SECTION)
 		fail = init_section_page_ext(pfn, nid);
 	if (!fail)
@@ -436,7 +426,7 @@ static int __meminit page_ext_callback(struct notifier_block *self,
 	switch (action) {
 	case MEM_GOING_ONLINE:
 		ret = online_page_ext(mn->start_pfn,
-				   mn->nr_pages, mn->status_change_nid);
+				   mn->nr_pages, mn->nid);
 		break;
 	case MEM_OFFLINE:
 		offline_page_ext(mn->start_pfn,
-- 
2.49.0

