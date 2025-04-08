Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAB320E6E6
	for <linux-cxl@vger.kernel.org>; Tue,  8 Apr 2025 08:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744101736; cv=none; b=VO6X1X3MFbcQnb1pAl5B8fMM4cnWcUMtylY4aoW/oJ8je64XLxJwWKx7w81z5DVjO35DWaq082LfdZC3wfztdxbuzjIuMhr/JwydVf4Ejndmstfb75lZABm95TzVVXj2zB4/dg5duuPG6vltniKPQffdM6R2lBW3+UFdKTNSTUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744101736; c=relaxed/simple;
	bh=yfp7ZLJzJ3T6+jfItD9eSdSCs18BSakhbdMuLwSLgnA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kdb+JNe5g6ONTVVdVyVUwIY28+270lVOwpMSzcGSBP+CrUaPSbeI955+RsoMEtcz/jdVt60RqT4kZn6BSnuBd3xqHwGwYeMqVQXUdu7k2xv0XBV9xa9zrKNzExxYpZAmm5IvB05LqfdUexsKBQfS8XxQPHsWAamHSdTvjF51UCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nzFSRnjP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vr5BSHqh; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nzFSRnjP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vr5BSHqh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nzFSRnjP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vr5BSHqh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nzFSRnjP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vr5BSHqh"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BB44F21180;
	Tue,  8 Apr 2025 08:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744101731; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=TaIF8uOFvFJGyXMEdrAO+/oj2U/AdR6oWCeZo8P3C/k=;
	b=nzFSRnjP3i64LMhGosn4pJSXZ0FQllLqoqEq/FogbeJRqHB2WBtmDxz2PchQ0BUmD2xzlo
	3JMq2VO6fkeD6TvZQTJGW3opBXLT0h9t4RmZtt3INAsJklvnaGkak8HX5Uv/jb7UL2mlz0
	2mPGdad2Dn0zw3w1e8p0He74/mp5b4s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744101731;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=TaIF8uOFvFJGyXMEdrAO+/oj2U/AdR6oWCeZo8P3C/k=;
	b=vr5BSHqhwc/y6Qh5FDRBzpguk0i4apuBlQFHiwsHUH107WRH29mZoiF1cWmjNhjG329SRQ
	LZNjsUrE/twIVCAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nzFSRnjP;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vr5BSHqh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744101731; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=TaIF8uOFvFJGyXMEdrAO+/oj2U/AdR6oWCeZo8P3C/k=;
	b=nzFSRnjP3i64LMhGosn4pJSXZ0FQllLqoqEq/FogbeJRqHB2WBtmDxz2PchQ0BUmD2xzlo
	3JMq2VO6fkeD6TvZQTJGW3opBXLT0h9t4RmZtt3INAsJklvnaGkak8HX5Uv/jb7UL2mlz0
	2mPGdad2Dn0zw3w1e8p0He74/mp5b4s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744101731;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=TaIF8uOFvFJGyXMEdrAO+/oj2U/AdR6oWCeZo8P3C/k=;
	b=vr5BSHqhwc/y6Qh5FDRBzpguk0i4apuBlQFHiwsHUH107WRH29mZoiF1cWmjNhjG329SRQ
	LZNjsUrE/twIVCAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 39BE113691;
	Tue,  8 Apr 2025 08:42:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RglWC2Ph9Gd6VgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 08 Apr 2025 08:42:11 +0000
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
Subject: [PATCH v2 0/3] Implement numa node notifier
Date: Tue,  8 Apr 2025 10:41:50 +0200
Message-ID: <20250408084153.255762-1-osalvador@suse.de>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BB44F21180
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

v1 -> v2:
  - Remove status_change_nid_normal and the code that
    deals with it (David & Vlastimil)
  - Remove slab_mem_offline_callback (David & Vlastimil)
  - Change the order of canceling the notifiers
    in {online,offline}_pages (Vlastimil)
  - Fix up a couple of whitespaces (Jonathan Cameron)
  - Add RBs-by

Memory notifier is a tool that allow consumers to get notified whenever
memory gets onlined or offlined in the system.
Currently, there are 10 consumers of that, but 5 out of those 10 consumers
are only interested in getting notifications when a numa node changes its
memory state.
That means going from memoryless to memory-aware of vice versa.

Which means that for every {online,offline}_pages operation they get
notified even though the numa node might not have changed its state.

While we are doing this, remove status_change_nid_normal, as the only
current user (slub) does not really need it.
This allows us to further simplify and clean up the code.

The first patch gets rid of status_change_nid_normal in slub.
The second patch implements a numa node notifier that does just that, and have
those consumers register in there, so they get notified only when they are
interested.

The third patch replaces 'status_change_nid{_normal}' fields within
memory_notify with a 'nid', as that is only what we need for memory
notifer and update the only user of it (page_ext).

Consumers that are only interested in numa node states change are:

 - memory-tier
 - slub
 - cpuset
 - hmat
 - cxl

Oscar Salvador (3):
  mm,slub: Do not special case N_NORMAL nodes for slab_nodes
  mm,memory_hotplug: Implement numa node notifier
  mm,memory_hotplug: Rename status_change_nid parameter in memory_notify

 drivers/acpi/numa/hmat.c  |   6 +-
 drivers/base/node.c       |  19 +++++++
 drivers/cxl/core/region.c |  14 ++---
 drivers/cxl/cxl.h         |   4 +-
 include/linux/memory.h    |  38 ++++++++++++-
 kernel/cgroup/cpuset.c    |   2 +-
 mm/memory-tiers.c         |   8 +--
 mm/memory_hotplug.c       | 117 +++++++++++++++++++++-----------------
 mm/page_ext.c             |  12 +---
 mm/slub.c                 |  41 ++-----------
 10 files changed, 145 insertions(+), 116 deletions(-)

-- 
2.49.0

