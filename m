Received: from hamster.birch.relay.mailchannels.net (hamster.birch.relay.mailchannels.net [23.83.209.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B242534F47C;
	Thu, 22 Jan 2026 02:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769048663; cv=pass; b=atGmCXLbWa4/eshBKU8SyWJSJEx1VYbx7hJFzpO7DwWe4NGFmq/5SnkbfaIr2ua7Vz5H26LJMKWTz8MTW6RAQsKMaNOvvUSXYExYlW9tHFTuaO/HfNRL2gJbnp0m/0msrOGMQetNlc2VVXrVbeU899LFW3Lg6EF0IONyNWMVoHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769048663; c=relaxed/simple;
	bh=15sIz9ogoAxdv1E29PowkrmHECCfWXFBnJXEeBAh4R8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F9CS/oFGRZZd3b+Q9ttUuZsJDcmWYPjhWMZMwJNJYkPGnZBKKJnVkbTtfCG5n6XAKeQFSQCVq1n/c4DraGTu/8KTvQeY/imIDvSHSDJT0yx+OnCk5VS4t+9469I7+fjqSOjNqj0Bmkp76sIjXfwf1X9hM/Ff61f1ZbLnhlWd6IU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=nImBSDhA; arc=pass smtp.client-ip=23.83.209.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="nImBSDhA"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id E8D5E162E2B;
	Thu, 22 Jan 2026 01:59:06 +0000 (UTC)
Received: from pdx1-sub0-mail-a208.dreamhost.com (trex-green-9.trex.outbound.svc.cluster.local [100.111.174.51])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 6B86B162F23;
	Thu, 22 Jan 2026 01:59:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1769047146;
	b=AEaM7gKH2+Sz7KTpLkCkGl0Stk0Ctu4XjNxdJTljguu917JbDjhsoid4L1J4cDpZEkwDy7
	wI6kEwqxvGMTXnjfqKzzot5NpFM0EYueeCx8/vZ8CvR0DaAFsA9iYK8Cp0f+o4llQFvKMC
	e2SC8BOMxE2N/rlsbYEMXKD22KChFcxxf9ohTA8r3VN9r1Tclc6OYECeYZrz0DAe44KAbE
	GuVQZcOVB/JqhrpHNa7/gwT7l8oASUSpaFvaH+m26KV6VH74hHidszEauSG1bJVTwkmgTs
	ZqQVLJA4nbmgOF57Ceq8nicmt7yxf7b2cXR4zd5DMPnj54X6WdU/GJcfhyq3uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1769047146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=pvrVXklow2ltkGecngvnKcaf4ZF/wRPI1iEuPesRnGY=;
	b=YIiR2bsV/lSOgAkqU4FZ1HIae+Lvsf7Cp0hm4aWHBeySLXrHtBLWHbnyhXUODSvpJ1PK1l
	Si0Ac3IVkko2rhypD7AqVDHGJXuBEPwXbw0xBx/5wX6pxqeV3B+gfhDqTm/yi9XhkE4DIW
	NyrJr3iyRT6kizpq2sDztpqk/cIS8mtfOTQuIGUi2+zOzEv7m2E1vPJ8b9XT9/YYlPCdjI
	6+aihUr7S+LGRnuvge9/1qO1Ch+1OQmlDHUUrop96At9cMBI5+eoKKmnhk4u9ckv/mnip5
	XzTwUJz4ySnI/w9+yW2y1bTUCvHveXM5klYiTRqV4Qu8Jpvu3q7dibzEdgpEFw==
ARC-Authentication-Results: i=1;
	rspamd-7b97d4c6f5-s6hgm;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Whimsical-Macabre: 5a3428f411239b49_1769047146737_1860100794
X-MC-Loop-Signature: 1769047146737:1327611904
X-MC-Ingress-Time: 1769047146737
Received: from pdx1-sub0-mail-a208.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.111.174.51 (trex/7.1.3);
	Thu, 22 Jan 2026 01:59:06 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a208.dreamhost.com (Postfix) with ESMTPSA id 4dxPPP522rz3X;
	Wed, 21 Jan 2026 17:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1769047146;
	bh=pvrVXklow2ltkGecngvnKcaf4ZF/wRPI1iEuPesRnGY=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=nImBSDhA0BKHwXUMuOiEct34NyA9hydWF5ZiuYJwX+s/M5VBthnn4nn3yulcVQtaz
	 XZ557ucL7W+zV0p24FsYEzHE61dOMtGpJFnxAIfRTA24SMJ/91AxI+U3TO9ce3ou50
	 znskKk3gJyzaMkhioFHlwKrSO2nZpls/pVuXdv9loiAxWIQNn0aqyLd2YxJKXAWdUQ
	 VY1JRu7eleVm7XsZNkTu76TcS5IMtEau37O7FDD0v+7Fg6Gg/GSToNDb2y/uX6/4n7
	 2yPLbjTNEXkKGoAF5MqxDy9XmK7H0RGWXGXbkUojykohknp1xWGSQ+7wi5osZyQicC
	 jel8rELsF01yQ==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.hansen@linux.intel.com,
	peterz@infradead.org,
	bp@alien8.de
Cc: hpa@zytor.com,
	dan.j.williams@intel.com,
	Jonathan.Cameron@huawei.com,
	dave.jiang@intel.com,
	dave@stgolabs.net,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-cxl@vger.kernel.org
Subject: [PATCH] x86, memregion: Avoid big hammer from cpu_cache_invalidate_memregion()
Date: Wed, 21 Jan 2026 17:58:25 -0800
Message-Id: <20260122015825.873904-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reason for getting away with wbinvd_on_all_cpus() was originally
that the users at the time were a one time at boot occurrence, so it
mitigated a lot of the effects of the system-wide disruptiveness and
cache destruction. This has now changed with users such as provisioning
memory through CXL Dynamic Capacity Devices.

Lets instead use clflushopt and only invalidate the range in question.
The performance of course scales poorly with the region size but is
ultimately less invasive.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 arch/x86/mm/pat/set_memory.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 6c6eb486f7a6..4a1c4f6bec17 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -372,6 +372,19 @@ int cpu_cache_invalidate_memregion(phys_addr_t start, size_t len)
 {
 	if (WARN_ON_ONCE(!cpu_cache_has_invalidate_memregion()))
 		return -ENXIO;
+
+	if (static_cpu_has(X86_FEATURE_CLFLUSHOPT)) {
+		void *vaddr = memremap(start, len, MEMREMAP_WB);
+
+		if (!vaddr)
+			goto fallback;
+
+		clflush_cache_range(vaddr, len);
+		memunmap(vaddr);
+
+		return 0;
+	}
+fallback:
 	wbinvd_on_all_cpus();
 	return 0;
 }
-- 
2.39.5

