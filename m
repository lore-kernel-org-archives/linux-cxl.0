Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C45D31F9B3
	for <linux-cxl@vger.kernel.org>; Tue, 30 Jun 2026 21:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782854336; cv=none; b=C2GYn95V5zyJ1o7zdPGrXctp5+Bx9n0XgvopC4bNrjr+kWkobQHBDzg7/WPcC2R5da4YH/4d5rGTVf3rvXA4KVvwu1GQ6xA8NxtbKOvQxtk3UQ99lMb+nBAZqa28C9hGiYfZZd6neQSDBQzL4ICk1FG3yuws3cCreSCLdds3aWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782854336; c=relaxed/simple;
	bh=X6kC2z4Xyj+V+APtGHSXJjIu5DjDPN1Hl4dMPopeuUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H1vpsp5x1lKFdsBL8B3EM4r5WbT/EnEUkwRbanzojRzIBHDVaGFUxtAsiZgHDd8ZmrCj/4cAYmB5LvBXd84xFKGGEHKLmH5sY1BGsRUKz2NeIb8SRcfutxcCEKFtCR1Jid3jEnD3cI7/QVLMKEE5vDwFUuwt9hLrU/USWZ38z+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=tMnQRe/d; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="tMnQRe/d"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-92e55b62640so197959085a.0
        for <linux-cxl@vger.kernel.org>; Tue, 30 Jun 2026 14:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1782854334; x=1783459134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BKwO5GGulWgyuo4GgOfyW93Razp13/peNYJDujzNXk0=;
        b=tMnQRe/dS+T69qgQKnqce/JmKMfKJZYHbcrtXH1l/x5200ujtRZK2QIpE+USeWaNA4
         wbB43QKOlGzMa0fdK/c0PENvzzFHKAONe5Z4OVeaFhAqcC85zsvhaORboGpOR3o73LE+
         JqHvSvSEX7ZdSJzF2jQ0bWk0FI6/S3Q6AUgqxS1KPDyDmurYUq1i+wKEc5TbSx7Hx7eF
         OqQXPLiGzlzHQFp3T/uHV6Kf3SLowZrc+tS0ePdyauy5yMoFh7UDckp/E6DK1+cXURhT
         yiqf/mr3ZSYGWKzIiBIAqOTcNFlDgnqRK3GqXN7e20M+/QcNbFtzSJaN9iYjHEMfszLU
         t9Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782854334; x=1783459134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BKwO5GGulWgyuo4GgOfyW93Razp13/peNYJDujzNXk0=;
        b=gzBqR6vFGqt+G3BbAQRXI8xCMebmLSt2RDRFzqLhzZE6wFPWsk/ONuAr704B5TGZVb
         s2tHpL4elDThwTWKKiz8E1h9FqJmu6jMpNIXWqQDandNkxRB87zDNacEF9UpY9Q0Wtuw
         h/uEmvaIfflUQmeCkwVTEprdEpo8JUL/biKpH69Mrec0G37jHh0FPfZIPoP06jPYwwPJ
         cDQhqxsbDkrIA7ndH1T3KJm2yGvaGGGXbZTM99K8YXXxN0M6hl21vboXjpC0EM1063r+
         uhuaZztUL5WV3EK3O22guTyxEnxL5SDBlvyly0a9n8qp6ujwZGOR1+JF5Xb19MVqmiWB
         0ZHg==
X-Forwarded-Encrypted: i=1; AFNElJ/PShckkcsE4KoKIWlVYq8VOBESVFmvHKb2gjU9rleon6E7o/bJYpQ9g3lp236ilgdhdZoq1XU96e8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGJWIfCLunCZ5DIpLIR8RYpNfrveiHVCnHuWwFzq4NMSGqP1yB
	lk/KoygtUllNlYNenuTRqitpv96JbZT01sRV5byF535yuJUeIsGjiuzus5U58+ItI1A=
X-Gm-Gg: AfdE7ck77r+3aylwGnFPj41VfgFqYautyysr/RFuH6PPxpml2lOXTq8XVOPq1fxdvPo
	3Ar5qf52WfS8m6zSryFcjBkRTd5fwg0AKfvSDnJTM1RJUiHX77mLXwXsXmmxpGL45B63l7nGg+B
	H2ohVvHzTAXX4lTo3H0cuC8CMA7klIIYUYlOhNCg3wPW9SJHymv0mDVaWutq+KXw0l/KN0RddyX
	L7afZavW3V1bXoHiL/eLmpRBnfPPN7dMQiF2aARRgEIw6eGcgdIySxSSaDfbTRMO/bMtMFdDO2I
	b3s+E+psRekd+qEkgmiYRC23awBZ7vXppLj3R7qRRCvgL3BlMfiiyhQdV04ROX0FluCrlhx+Lzv
	DPNa6IeUb/YYO8Ww1G1TygtgH+7p/Yg8YmJ9E1Rv5BETT3A2G1JNSQf52dyqNJyHg5JAIZETHiT
	tm2ac+SORs0NlmDje03TzrWHwrKIC1LG9+eTjlN7f74kXY+pLiFf9PS9uYfvUA/ui7gqIsrWJEm
	Q==
X-Received: by 2002:a05:620a:8018:b0:915:8f76:8005 with SMTP id af79cd13be357-92e6d8bc859mr391991585a.47.1782854333767;
        Tue, 30 Jun 2026 14:18:53 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e62366303sm335924285a.40.2026.06.30.14.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 14:18:53 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	kernel-team@meta.com,
	david@kernel.org,
	osalvador@suse.de,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	djbw@kernel.org,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	akpm@linux-foundation.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	shuah@kernel.org,
	gourry@gourry.net,
	iweiny@kernel.org,
	Smita.KoralahalliChannabasappa@amd.com,
	apopple@nvidia.com,
	Pankaj Gupta <pankaj.gupta@amd.com>
Subject: [PATCH v6 03/10] mm/memory_hotplug: pass online_type to online_memory_block() via arg
Date: Tue, 30 Jun 2026 17:18:35 -0400
Message-ID: <20260630211842.2252800-4-gourry@gourry.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260630211842.2252800-1-gourry@gourry.net>
References: <20260630211842.2252800-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify online_memory_block() to accept the online type through its arg
parameter rather than calling mhp_get_default_online_type() internally.

This prepares for allowing callers to specify explicit online types.

Update the caller in add_memory_resource() to pass the default online
type via a local variable.

No functional change.

Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>
Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 mm/memory_hotplug.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 7ac19fab2263..6833208cc17c 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1337,7 +1337,9 @@ static int check_hotplug_memory_range(u64 start, u64 size)
 
 static int online_memory_block(struct memory_block *mem, void *arg)
 {
-	mem->online_type = mhp_get_default_online_type();
+	enum mmop *online_type = arg;
+
+	mem->online_type = *online_type;
 	return device_online(&mem->dev);
 }
 
@@ -1494,6 +1496,7 @@ static int create_altmaps_and_memory_blocks(int nid, struct memory_group *group,
 int add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 {
 	struct mhp_params params = { .pgprot = pgprot_mhp(PAGE_KERNEL) };
+	enum mmop online_type = mhp_get_default_online_type();
 	enum memblock_flags memblock_flags = MEMBLOCK_NONE;
 	struct memory_group *group = NULL;
 	u64 start, size;
@@ -1582,7 +1585,8 @@ int add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 
 	/* online pages if requested */
 	if (mhp_get_default_online_type() != MMOP_OFFLINE)
-		walk_memory_blocks(start, size, NULL, online_memory_block);
+		walk_memory_blocks(start, size, &online_type,
+				   online_memory_block);
 
 	return ret;
 error:
-- 
2.53.0-Meta

