Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A262FF65F
	for <linux-cxl@vger.kernel.org>; Fri, 14 Nov 2025 08:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763109825; cv=none; b=KQVBK80YyDr42ijcaYxHnHn15RhXlG+ieaqTkb9ieZy/D/hamM76ifbM7Xi7vKn7HBzoICTNPK5R1OwvXkIf3mHYhgNPQ76ebBbfERK1xOPeT5GhbZrS3R4N5FdBfz7ZV8XlnLsx6eGPIrEx9R27sZT+e7eVsAl56lO7fCO7JOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763109825; c=relaxed/simple;
	bh=lKKJd6N0c6vkdPKpztznWmAt5ZIxCKgUOSOUVHUPlUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UZ6Z9b1i5szGNWa5bYpkIZrZcKxIBWszA6c6M8S7CH/9nQsBdFz5RECAJkjCIlPH7nLTzrECvdIjji0MKvAk66u6JF213eYwL30Gpl4wNWNcFWevlKBUox+0tmbgX2JvX/7M3pTNL6GtWowXa9qNXj5Xjuq9YU9IVtbdx0p5JQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JhlReM7v; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhlReM7v"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-297f35be2ffso26118205ad.2
        for <linux-cxl@vger.kernel.org>; Fri, 14 Nov 2025 00:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763109823; x=1763714623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CZqdt41d+LPz+pOMoPWH9r9sMNv7qqAmbnlAWDdsj9s=;
        b=JhlReM7vcFjPM2hMFIlKyqGoY2i+pDM3/bcl/pmGkCipBETUIBe7dBHDQX8F4i56pJ
         YOgWKZ6Ll15i/5OK7LrIJMvN7X/g7pTz9nBAFgjeRXo3Ax5btsg8LVC/ZIm6kli1Uwsn
         H3N/E326j5l5rH6zvziYdFCQtW/BCykLUvGBXJVmxCb/JTdNDNE3Bjs1YTnQLcr81R9J
         TJemABmm0TjMTEg8CsAGQ1+mEIFiFRzMasrlmh9fj6SaD88C/Wv+06kCRizQXyGxpXf8
         iBjvGn2KhkjuKda7pY44NUyyrwq3al/WEIZ8gN5Z4BgqY8H3762sJxwjLQq8NjA/Sv8w
         ovyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763109823; x=1763714623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CZqdt41d+LPz+pOMoPWH9r9sMNv7qqAmbnlAWDdsj9s=;
        b=Vcw41YxtsX+8yGvnjPoVafY1ccmqNprlD4dbIXyYA3WiJNuWqoASx8jhVYPjZpE9Br
         hBHEaCEOjvzeIG42zJ2GtkiYRR5S1wJSEp8cEBX9DRtwqkDCm2OIL1kkUd8w4Y1NtheB
         yrcpLGWEv5/HuU16Hh+Jtvl02lhLEA7LCJ6Gx9Y5XOXNl9hfK49eQ2n/bu6lCk69blLf
         y3ZEtSGVFc3gwDqx/EgELDlnhm0ZnumHi8Nyj/MF2Oooh+FdBJb9NBEVPnMTt4kNqU02
         vfw2lnw/PNMquG5SnQaAT7Y/UeIMn8ziVzLZ72PhBJxpDUOvby++IqA2O1mY0t9ssNVf
         zyJg==
X-Gm-Message-State: AOJu0YzNInxSmNE3FHBwyVh6rbxuxLoKwViRIyHGlOdc5JzpV8/ykCRd
	zrSLBkgJmmEDCEyS3lVOoGkoTRzx6cw0TgASHE6OPeWtzveUVJCQalQL
X-Gm-Gg: ASbGncsU4fU9R79H93Zu4negR+meQZBQcbO2lPwm7MC7lerLjzZnqDyxP7gkU+Xnt3x
	jAb64XatIL1WHbEtxlj76PQeIlysOKScFGsuCgQVYCbxIuryJYGK5nJxyoEUEFBO2MEC74VH6Mq
	bsBZcbhHw6uUmC+qeZVrL6RHQjgBpbIVJrmXcPpIgIVJ8F63Ak9hs40IgF+zfdgy7F4gMeM8lzh
	lwiZYrBx1dnWHGnLIOe/hUgd4WczyhHK+SCPWB8gi6S4nK8dSEdRlK3yw11TF3yS81xMRNOIPEe
	NMJg1Ag2LttsghG9cIm8rxYG7pKNmCpZXproxJ24e7CfzxHHt/23Ry34kMMqyOW7K3VRn4/QMxZ
	/DDEYtI61IWznUzFfz49kY3wvv4D2mtWH/nbullBOodM7FaGYm+qka7RaIT9jpn3PQHZauFzb5D
	DiJER0A3c6wFbuYh0=
X-Google-Smtp-Source: AGHT+IG9/SC6VdPA1FDIVemhgKL/bLY9YjlGaqmfBfHgryKUgf1+YXYjJdmBmW+U8go+rXobjJicqg==
X-Received: by 2002:a17:903:2349:b0:298:5abe:4b1 with SMTP id d9443c01a7336-2986a76bc5fmr23755615ad.52.1763109822755;
        Fri, 14 Nov 2025 00:43:42 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:4f6a:b780:1077:5032])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2b0d17sm48880405ad.72.2025.11.14.00.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 00:43:42 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: akinobu.mita@gmail.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	hannes@cmpxchg.org,
	david@kernel.org,
	mhocko@kernel.org,
	zhengqi.arch@bytedance.com,
	shakeel.butt@linux.dev,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com
Subject: Re: oom-killer not invoked on systems with multiple memory-tiers
Date: Fri, 14 Nov 2025 17:43:15 +0900
Message-ID: <20251114084315.155333-1-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAC5umyiA+KkQNTv-mN=mA9BXHmqMH9Trr_07XYOh=QTLLm=zNg@mail.gmail.com>
References: <CAC5umyiA+KkQNTv-mN=mA9BXHmqMH9Trr_07XYOh=QTLLm=zNg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Regarding the issue I reported where processes that run out of memory cannot be
terminated by OOM when demotion_enabled is true, this can be avoided by not
demoting if the target node does not have enough free memory.

Specifically, the can_demote() function, which determines whether or not to
demote, will be changed to also check whether the target node has enough free
memory (for example, whether the minimum watermark is exceeded).

Does this change make sense?

---
 mm/vmscan.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 8890f4b58673..63d751e54b08 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -356,7 +356,20 @@ static bool can_demote(int nid, struct scan_control *sc,
 		return false;
 
 	/* If demotion node isn't in the cgroup's mems_allowed, fall back */
-	return mem_cgroup_node_allowed(memcg, demotion_nid);
+	if (mem_cgroup_node_allowed(memcg, demotion_nid)) {
+		int z;
+		struct zone *zone;
+		struct pglist_data *pgdat = NODE_DATA(demotion_nid);
+		unsigned int highest_zoneidx = sc ? sc->reclaim_idx : MAX_NR_ZONES - 1;
+		int order = sc ? sc->order : 0;
+
+		for_each_managed_zone_pgdat(zone, pgdat, z, highest_zoneidx) {
+			if (zone_watermark_ok(zone, order, min_wmark_pages(zone),
+						highest_zoneidx, 0))
+				return true;
+		}
+	}
+	return false;
 }
 
 static inline bool can_reclaim_anon_pages(struct mem_cgroup *memcg,
-- 
2.43.0

