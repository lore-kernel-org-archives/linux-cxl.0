Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com [209.85.160.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16821C3BEB
	for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 23:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768434662; cv=none; b=Wuq15e8icOrd10DBWG47y0qWrWeK/KHkvsMSFbygxpdmtJ8roVLDtaXjXwb6q4n30eb96cDMakBlzdlGLFBJ0LNKGWBGG5XuY5SX/IWfwHShfCTaSH14AyL+4g2nXX+MzdsirX58t0C5vwWljGgmYx2cay17alckqBBdY4WECU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768434662; c=relaxed/simple;
	bh=flZoV7rTu0HoLnYzDWHCPkEv69kRnAJvNaCvCfg2dPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VfEtqkrlnmWBJ8CrEO1llmuTHsJF5M7/U8bPhi5wGaBpm3gKqKN36zRNIaPjG2EZQYyLGmzdy+yP3wNrrkGwZUSL0cBZco4A3oC9x8sr7Z51EX/OArLJhu7O58YjWh2n9bQ+eAS2OduauKJn4QpXkmlA8I4G9Rk9ut8SdDJxgmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=oWyMwjBX; arc=none smtp.client-ip=209.85.160.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="oWyMwjBX"
Received: by mail-qt1-f195.google.com with SMTP id d75a77b69052e-5014600ad12so2465931cf.2
        for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 15:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768434660; x=1769039460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TeEc8tQJdZv6wSmBwJwNJ7eg8WiARnEu4gZS0Yp4t4I=;
        b=oWyMwjBX22v8yHY2pW4bCncKyV7OQmVAe3zxh9urKrdGY6ZS6DArZzjw+/xS601u06
         eoI7eF+lI29c9mthYINGEBUp2rVhSzIXcEU7qYW8l8W/MWaFIpBH5tC2+CI+L1njOe9s
         L4LYD9ldrEiCyPv54FUZboM4R9LGo+VxvhtWqMM/fAWKi2BcO/KA3wlFw7KhU0kCvVfV
         YdUtSLKaZ5BDA45SwiXGsPUPsalVCvseEysDttzIQnYlxK5u1PNyf6t7wt/RgU7FwnNy
         ItUv9gUpV42LdBOrM2FTmT4ppBEo1AePqtcbqQIsJQqAuiuhcUNpDsc/ZYgtA4M6pXz6
         Yx0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768434660; x=1769039460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TeEc8tQJdZv6wSmBwJwNJ7eg8WiARnEu4gZS0Yp4t4I=;
        b=UWkBXMU7/aMMmjtNQvfDTixJstwbNsoQ9T+l+BvMD1SnKZ50PfZTtDETz9NYDdvzd1
         Gu1ZswmCBdNphoir+mK9JMEt1mmcm4dUo8uJQHklUaPKzwwG7rPkHO34ANYD/+91GYCx
         xqA5mgFLGV3uHbb/Um/77nMk56K3q+N71RNG2T6KFTQHIW6zlJ5QJXYth6U1BJObit4q
         Sbq988dqjQkD/SbGlRx9+/0ZsaGlNtWVHCLP5y2AOG5zbQ0RaDmhZT25VNp3ArhLEfXE
         pu7KRF1p1/coYV+bOlGboNBqp2ThX3XWiL6D+wRWc6kB1/zljVlF107KOxV+uqfZZxia
         wnQQ==
X-Gm-Message-State: AOJu0Yyc1AzvbrkwyDFfIatlgNSdDTDF23aQLarh1QfCMe5qDJY5nO+l
	tc/LBTPw9j1gqxpJN77XXtQf7tQ8ImhTmYAj0ZgYE8GbHz8oPqE9MT78GIPKRHs6KgM=
X-Gm-Gg: AY/fxX6dHJjjWAP+ZcRSk/sb11f1Y5h1nkxJzIBUA0w7+4G1C65CbIgAFamI88PX6aS
	T3vkxHECbAEaGT2HcIGdlt8FfyzBDcMnoPlWaVXbFZOyRnjaCXO7Fb9t1oNqAOBqxRVn0yHtrOX
	OEeKXPSj5haMv6QFBOG9igT0jkwXEnVlUlw8hubPvu/Ik1R2SsIfwO8doJYWC+o97w+scfBuSQC
	R076k6/NWk/UqE3nasdBzO6i6c8d+6LoDqrqUGvyEw02CvE58HTupmTu48uO0i5hBBu+YsxLQdr
	BELmoT7dGBbe1cfb0m7PTSl1f0pfd/LmxRzX0yzHZrzJkc0Otd0ItpF/ndLtN5LuqtRgQd78Zbd
	dr3pQXAWHg7EEWHXT1jMB1Z4v+5iRyGZ/mhJ/EraHxhfj1Pur0gkw2emd1ILIEWNja3QmtvTX/w
	ISirv1uKsF64HeDlY6eE1B/A/kC3f3XlPuQfib6L0PkPr01UHHHy7TlAal+JnfhmVr5OyCys7e0
	7rL8qBcJP9gJA==
X-Received: by 2002:a05:622a:181d:b0:4ee:1d0c:15e8 with SMTP id d75a77b69052e-5014a99becfmr55478081cf.74.1768434659885;
        Wed, 14 Jan 2026 15:50:59 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890772346f8sm188449106d6.35.2026.01.14.15.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 15:50:59 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	kernel-team@meta.com,
	dan.j.williams@intel.com,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	david@kernel.org,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	osalvador@suse.de,
	akpm@linux-foundation.org
Subject: [PATCH v2 1/5] mm/memory_hotplug: pass online_type to online_memory_block() via arg
Date: Wed, 14 Jan 2026 18:50:17 -0500
Message-ID: <20260114235022.3437787-2-gourry@gourry.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114235022.3437787-1-gourry@gourry.net>
References: <20260114235022.3437787-1-gourry@gourry.net>
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
type via a local variable. No functional change.

Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 mm/memory_hotplug.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 389989a28abe..5718556121f0 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1337,7 +1337,9 @@ static int check_hotplug_memory_range(u64 start, u64 size)
 
 static int online_memory_block(struct memory_block *mem, void *arg)
 {
-	mem->online_type = mhp_get_default_online_type();
+	int *online_type = arg;
+
+	mem->online_type = *online_type;
 	return device_online(&mem->dev);
 }
 
@@ -1578,8 +1580,12 @@ int add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 		merge_system_ram_resource(res);
 
 	/* online pages if requested */
-	if (mhp_get_default_online_type() != MMOP_OFFLINE)
-		walk_memory_blocks(start, size, NULL, online_memory_block);
+	if (mhp_get_default_online_type() != MMOP_OFFLINE) {
+		int online_type = mhp_get_default_online_type();
+
+		walk_memory_blocks(start, size, &online_type,
+				   online_memory_block);
+	}
 
 	return ret;
 error:
-- 
2.52.0

