Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5BD369208;
	Sat, 21 Mar 2026 10:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774090649; cv=none; b=W1TC0FKgOt7MPVXBGgN46Mpb1YJn+6wy/P36xzcA9uUbkPgzvpN2dcYkfjyCFcWLmeZGjGl/yXxJTBFQDCP6VwI/SYf5X7Uy1e4aEjIVZKn8IM0l9rCizGSM7cBexgFmmMvvaDawgghN+wol4eRpVah02ikPRjjxMf+gP0pQqzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774090649; c=relaxed/simple;
	bh=82uVRUQu11NXyZsVPm82V/B3XnM+D6pCFBkj/vD7jSs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D6rLocQ2gPj+x2HTugs/H1O2hhiKiLoQuTOivXSogmlMxvVdy4nF9IfLymkt0zzwv/iRxMFM30njL5xfR7LsQTf9H4fFLoQ932puLmDEI6hzQEBryCHkbD2HEzhBeqhJ7BwLQJhxBOEcF40BB6KZZwir9E59079jos3Ht082p9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=Htv9cJW4; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="Htv9cJW4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1774090628;
	bh=TJKZtWiprgUspY4RNaw1d9jTovs7Pv0dIVGo3CDvBTg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=Htv9cJW4Nx3EqX1zI9OZ/O7lsNsTqx6O5wFbKC0Fr1BQYtdLR6NXRHe+Sy5njAHpe
	 RpYXGX+Pqz6xUt/n2h8KGzI3EKbMSH49pC1gNR977ojFh1o2q3m/1Wcqx2DUftxUzq
	 PDKAy0704GNbQ85NVjv2EsD93+j2ynebMAN4iGYc=
X-QQ-mid: esmtpsz21t1774090627t30d284b7
X-QQ-Originating-IP: AQ19W+u9FUPANAVegDK9vd8HUPQnUE5SAnb8ksdr+Z8=
Received: from localhost.localdomain ( [116.172.93.199])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 21 Mar 2026 18:57:04 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2755794152099023227
EX-QQ-RecipientCnt: 14
From: Kexin Sun <kexinsun@smail.nju.edu.cn>
To: david@kernel.org,
	osalvador@suse.de,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	linux-mm@kvack.org,
	linux-cxl@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: julia.lawall@inria.fr,
	xutong.ma@inria.fr,
	kexinsun@smail.nju.edu.cn,
	yunbolyu@smu.edu.sg,
	ratnadiraw@smu.edu.sg
Subject: [PATCH] drivers/base/memory: fix stale reference to memory_block_add_nid()
Date: Sat, 21 Mar 2026 18:57:04 +0800
Message-Id: <20260321105704.6093-1-kexinsun@smail.nju.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:smail.nju.edu.cn:qybglogicsvrgz:qybglogicsvrgz5b-0
X-QQ-XMAILINFO: MaRU8Otb0arbVV0pvG2mIRKbpNtxRNz4+Wzt0E26G2C3DERUIDG2B/WQ
	vc5dvIP/BTuiE4GmBRn4ZkEnrwFwPcTpQesISl2VIvqA5NA5GRSLSmN5f5t3j6MNs2aB8hz
	HDxTd8rWGAjLHQBOzxfthbVXdIjZ4kQsUzWel3RtT64WL11fEu+zwBHjggb6aCJjs5eyS2V
	NEeByi8vdhg6JQooj8ojcPHvYEv2qq5TMcp+BOJ/5XIz1Y2yBKhvJQLcpZh+k++ZcveEUR/
	GhWZjwYdBjAo+EI01lVCLQa0EU9u9Ps3a70oS3kUZZ+gq3MISkOoflaAMjweSFKHOnDD67o
	mpLgm+Gnz7vhtdpI5Gcbbg/2fD/xDtbNL0jGjQLciaetGAdafXIN38jxJIezkouYEgX7kTY
	dW1KugaLlbEecJB28jWz69vxYQPg79AYHGE0dn8708OF91oJrS2DqRVQ8XkfsYOmM0ubYTV
	1RwAlW9/Zp/sGFGYGSlTm5asj5nbDbGrUsENuTDWjHItiAWm0ltmkQPZ2jkE3t6omOacrF4
	1d1NinyU4yckXS0utLHnFeMTuPI0gxiaY2K/nwOvdwuMd4EhSK4LKQ0MOWRgoB71jfr8SHW
	v/MT6P+8DzOxClzR2TE8DDElzsmYtujRh3w0pEEuEDCLDZ1c27Q5vFjHq3tjk4j208A57Ih
	fAWMvHPUjDJnXn1eKa7IHx/0PD2HVS0avO250w1Eymg4JVA/2KPp56X9Df+pHwutDU9X8Or
	39C0c3seS1YFPp9CJGiwDnZOsMfNKIuB0cO1gq1MJ9qRl/3C5hfrI2BHIVsU5oakkpxSpUQ
	L9rgM7D9EBGETEhOpNJUQk+eIf2Ng1iFq3xm+VTYnWi+c5/zRMSUmCxujXh3swXAO4e9xhj
	/vFMgmCXhT72Dha3hMkp5/cLG9vImwu6CqBkfP6BGHjzL4Nm+mVBu3oZILXyH2Xi3D2bccL
	ZEb8sd1aE+/DaaXUx9UYSwR5Xn3n95wnhDAfhHlxO7/4VSsHASG67EMtcKxFpv5oBL4Eehs
	ZtaIGoaAQZdeO7WBWO7nMPl1QNoStdy3Bp2JGhUD9AUGfyVRWBhRIxGw2yg2x5YfYreHcfU
	g==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

The function memory_block_add_nid() was renamed to
memory_block_add_nid_early() by commit 0a947c14e48c
("drivers/base: move memory_block_add_nid() into the
caller").  Update the stale reference in add_memory_block().

Assisted-by: unnamed:deepseek-v3.2 coccinelle
Signed-off-by: Kexin Sun <kexinsun@smail.nju.edu.cn>
---
 drivers/base/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index a3091924918b..0d6ccc7cdf05 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -815,7 +815,7 @@ static int add_memory_block(unsigned long block_id, int nid, unsigned long state
 		/*
 		 * MEM_ONLINE at this point implies early memory. With NUMA,
 		 * we'll determine the zone when setting the node id via
-		 * memory_block_add_nid(). Memory hotplug updated the zone
+		 * memory_block_add_nid_early(). Memory hotplug updated the zone
 		 * manually when memory onlining/offlining succeeds.
 		 */
 		mem->zone = early_node_zone_for_memory_block(mem, NUMA_NO_NODE);
-- 
2.25.1

