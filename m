Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2875C31355C
	for <linux-cxl@vger.kernel.org>; Mon,  8 Dec 2025 09:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765186884; cv=none; b=CYsvkRkRYXMB0ojIYvsG8DNZ7C3dUww7YD1Ule/oBPObtWcKB8LNrsP//xdFsqhKWNKglgF8aZuJgPPEoKI6f/qhSg3EJrb7RsV4MWO6Cli6znGGxIW3P2z1idKWXMlOlObVrdyrJitQ/tJJwCgtMryDZ8J9dmECLiZAmJWAjfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765186884; c=relaxed/simple;
	bh=I+ItlwDH5Ucq3YsUbivU6u1+aOIHgfXQfqKyHbsPssY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ogBnBS90g65WsQioG4yxsQ+JJkBT/d6KO7qKSImXhisMF0six65IRRmS8KZva/GZ62nkxKjK73p4/LDVmKGyK+r3bDSamKzRFAlc8YIGQjdnLFid0qeAPO/mWxDuRVaX99Pj3pi8/GffFJlFiovHogPYpVpjSbu39ral/HlEiEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZVJRqnD; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZVJRqnD"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7baf61be569so4696525b3a.3
        for <linux-cxl@vger.kernel.org>; Mon, 08 Dec 2025 01:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765186880; x=1765791680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E2IsRlHfOxoQ25VAxxnSZ58QOHjCvp9Xb/KmFYxJM9w=;
        b=QZVJRqnDMU01xsqpoeC0GXO5iC8DLg/bxTptSr9Cm4QJpl4CzubIVuv8iBPj0H3unm
         YSXwKYPwFDwrI5umhYIys3phvVrVgzCAqE0GDtkPA2a5WWrbSMAFgBNU8rW3eM+MMQ5C
         cGtXCnVkJEjxeuiPxSeI6SeXF6yGSInAaGVQuVswt+0JR1aycF0i1vFvlKDODhAmsXw9
         pXGo4GAz7jzsFwsUSFouInR2ntCnf2hKIrUWQ5M4qG7uxoipwCte5EP/tFyzC507re0f
         E/mDjDPeArYfxls9BSBVcEMGG7/Q8PEyDOE0vRS5iVvNP4V4JPtO/rSZbRJG/LvBFKTj
         Um0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765186880; x=1765791680;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E2IsRlHfOxoQ25VAxxnSZ58QOHjCvp9Xb/KmFYxJM9w=;
        b=A0dVYrPg7t2aIT6AIoJails7NYPykBXr+odHiJKsATjm92kNEJL3O/Z75SGlSYmrMG
         p3DwoC+kDIkUmWBKn9zNczCkQSn55KcEjf7Q7VetLoWyD3oqbLBnCs9mtQOSZlOKIGnV
         GM5kTD33x3phaixNSYW4uDR2TyGV1xri60y3Avd0oOS9TR9xZCIBmBJdtkrrlwqnEpdV
         +A5GVDrsTa8TnGcJ12/H/m5lu1Jtq8qXt0a3Upgv/Fln9kWiJ/4ZQU49nsM3NAs1dWXM
         JkQQOqxLNHkbrJfoY1LuY1auEinQS4T+bGK6WftZ5SFPyuh+28xuQ8/esGrM5qhTJyVv
         Xb/g==
X-Gm-Message-State: AOJu0YwqB44Am/IHYzScHAZetUMIytqfdMrzhcQJEQIM/7KzH4ckrAy/
	VHKdKz/lTizFqo7ynz/nrbTlpSrNNTZkf0CbWjQfVWd/NVdZm+xftxor
X-Gm-Gg: ASbGncs62qgxv3NEei22vlh/GVfFp+2cX3HZE2ehXywXa75AOhyZVHqfJtDksHwbwmE
	Uf8uV71UEkmAEbBYHk1zuYhrZnolBZN6e3u2thmKZRaujp6aGcW+9YofJR9HbGXv3lkI2YvnSk/
	wvgzW3ObyzCFZ8H9wFCcH4sr29fWLSBSoEO5MVzi8+7LJecWrbAcOvTXfk8Xwp0KHFSqNcw9RLz
	FSaAPF20mKOVrKBSGtHZ6e9/n/4RRg/CQCx3C5uSyTHegtI05PAAQiQfYEIyO8oMduKG2jLa0lU
	2grAIaNa5R4HfuSSD04Jtbb/NiUHXQk8I41GwJU4R6YsFTh1XrYCHflnSSnUeq3CDEF6Z6ES6EW
	HpdI5lylgrgxjp5snMynBSEMPAx04Ch86jN7+FNRtIRdaBG1wRv/4qeF7muAK9wumCaG3/fC87B
	3GfU7qNK0aKFDUatiM/dxSWGNR
X-Google-Smtp-Source: AGHT+IEQSCv8PNnm1RLVVc473IhmbBhZy75uxF7k2QOy+9J7r7W1JX8p/WGoA+AAm/hEBAShqrmVsA==
X-Received: by 2002:a05:6a20:ed06:10b0:366:19e6:5089 with SMTP id adf61e73a8af0-36619e65142mr4333122637.9.1765186880316;
        Mon, 08 Dec 2025 01:41:20 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:e251:d9f:c2ef:caf4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bf6a36bbc60sm11675279a12.36.2025.12.08.01.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 01:41:19 -0800 (PST)
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
Subject: [PATCH 0/2] mm: fix oom-killer not being invoked when demotion is enabled
Date: Mon,  8 Dec 2025 18:40:26 +0900
Message-ID: <20251208094028.214949-1-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On systems with multiple memory-tiers consisting of DRAM and CXL memory,
the OOM killer is not invoked properly.

This patchset includes a fix for the issue and an enhancement that makes
the issue reproducible with numa emulation.

Link: https://lore.kernel.org/lkml/20251022135735.246203-1-akinobu.mita@gmail.com/

Akinobu Mita (2):
  mm: memory-tiers, numa_emu: enable to create memory tiers using fake
    numa nodes
  mm/vmscan: don't demote if there is not enough free memory in the
    lower memory tier

 mm/numa_emulation.c | 26 ++++++++++++++++++++++++++
 mm/vmscan.c         | 15 ++++++++++++++-
 2 files changed, 40 insertions(+), 1 deletion(-)

-- 
2.43.0

