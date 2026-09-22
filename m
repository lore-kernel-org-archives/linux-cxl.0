Received: from mail-pj2-f35.google.com (mail-pj2-f35.google.com [74.125.227.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF4A41DDE5
	for <linux-cxl@vger.kernel.org>; Tue, 22 Sep 2026 08:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790065561; cv=none; b=M86fdoAlwRBnkCLL5EKk7UF0Q4n36DarmFVgcIk9gql13CwbxrXT/AEdrrV6yiQMaeCu0vceGeo2pP6srZiYdZj1l3nBz7FvK2YFq3zeHv/xpppUj5xY1GF0oEW/lsFz4JtxoN2tfuLv2owUgdzJzhPs04O5YjIVrFX0rcirXLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790065561; c=relaxed/simple;
	bh=dBBpa7Ydst38i8cZsMQVxzXK9rqMNseU8twqVhQtE78=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BR4KktfgJzhdTNaNu9izttW2QxrWOiRE36i2FX73ky5qfHnJaFaPoyRkyuUBOhfwBn8sTLuiAqimqT6ABihgGemrLdxX4883S+IjUT9/z8E44ggfWAy5A+pU+eQw0jBa397/fOEY9Jq6VdA+i0+0uSCgt2EhfXjPNYq3Mzu15Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=EHyNhINq; arc=none smtp.client-ip=74.125.227.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="EHyNhINq"
Received: by mail-pj2-f35.google.com with SMTP id d9443c01a7336-2dd77300825so38736925ad.1
        for <linux-cxl@vger.kernel.org>; Tue, 22 Sep 2026 01:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1790065558; x=1790670358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Id4aiEwWk24mT8CByvlZpwQS9RXne8NT6QXvKFa3y1M=;
        b=EHyNhINq+oMknrG/8IGrEy2BE5yyRk8MEMJKq7Jbnnt/Sz0/usHcGFLqXJ4X8+kQS7
         UHZ8rN8b+/Qv4tJGJAbDRTXU+TcvuFLd5vBBWT3ZQhLu5VlDFyiCVDwLUEjLhfKu0HYt
         qSZWTDDmfKD85R0WFIEohMZKKnX9slN7Ii3rYNEWkVvpJAeIuI3KXXDhojiUZOgyzM1y
         mZDyyVet2TkAY4X3csjUQQtk5geFpHZpuGoQT7GwunKmS2L7BQu/BoYwjWPujhB+iyjh
         N524K2N4wC2wE8Xc8Mdn5NlvxK4sLgYlKFTx9rdvJrYBElfskWNQ5WX8iJC2iJbI9++k
         0vWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790065558; x=1790670358;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Id4aiEwWk24mT8CByvlZpwQS9RXne8NT6QXvKFa3y1M=;
        b=nD3e1UiSAm/Lh9tAjEtfAFO3MX06WGedM+o8Ec/8Swwk1Ez1cXX+PcVlBRKyjeMgWJ
         HIzOatZdRM6V54316fctA+cI6B4Pq/ObO9QNbS0Hhas8C2qGzWTnAo7HFBaE9cYJCtrN
         HA64vMl1Ii4E4y7qrSjEo/0NjwnX3LYQG7G869bkF25TAqnPXw6MyF47KDgmG+izgLqS
         QNTrpac22LXRa4g0qn8ngawhTBsZNrA2WG10z/dOkRCGnSkwZMeg/OSE4f3RnyfHjnet
         jEPh0X+5/K60AXF+tBQ0TYIm4UU3NuS5j+WlTgNK+7bBFRzWN4RaPrpTcqO0DUe9hd/0
         lS7A==
X-Forwarded-Encrypted: i=1; AKwUvBwqfT9LQmff0JGe8MevYX4jao+GXSlapIvJaxd9eCW6POxtDeeqY3V7LStSl+4n+RZeuy5+3UJmYEs=@vger.kernel.org
X-Gm-Message-State: AFuF++nbO8zIEK8sHe5VXMfGF7imdXHWn7YcJ6fTvJuK5KG5F/0TBrQN
	K+Vafe6Z4vqzTRQfv1lLWPOZgkogMT3VkfUdPVW2/HaNE82KF1mzuRBjClnoSBJAXmQ=
X-Gm-Gg: AYBFou1pZdkXhZ2EQk1QNEvQjM0b/80sNxOjv0hRcTpMUXh3gQHQVvZBDwi4aYPY8+p
	tVgxrQe6+lctlx6oTeoB+OCBKqs/qbsWX1TNNbbslTThahlkQ3PpgBvMoQZNcjL0xu+2ystHHgc
	JY8c5yrMdUesQ62llDDzJ5Xth3N+6SwuT0hlNmgNTKKLnuXzgf75fEe5GMr9cioK6I1rKAUyd3j
	Oe4wYxgy3UWEJv2r3teauCLM4F+FmVL7Az87zf9duCMElih5YsGOLsgE4Ai+pMznwQCM3NUFQKM
	NTzaVZp5MSspV73I9C+6SrOsD48l3nwamRTS+wzvIvIPf8MqahbrMJI6KGfuYXZBPIDC51mofyC
	RegqcfRbJW8MnSERRnJcFbS1BHvqS2mIi+G6kS8reQ/SbmAdIZVn+i6cP4CD+UxRBbqjVnB8Wce
	c/+SIj8Ayy7y304ZR5rw0r2eIcYcBeFMPM5gYe4AoKgGP8eMzLfLzPoHfXDm/Q0O/7YvYJSe9dR
	cYiQghgFggtXF0T9MqK
X-Received: by 2002:a17:90b:1e53:b0:39e:2c5c:a69a with SMTP id 98e67ed59e1d1-3a07309eb75mr436231a91.5.1790065558109;
        Tue, 22 Sep 2026 01:25:58 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a07385e516sm223056a91.0.2026.09.22.01.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 01:25:57 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Dan Williams <djbw@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Joao Martins <joao.m.martins@oracle.com>,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	muchun.song@linux.dev
Subject: [PATCH v2 0/2] dax: Fix Device DAX range allocation validation
Date: Tue, 22 Sep 2026 16:25:49 +0800
Message-ID: <20260922082551.874901-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While working on the HugeTLB Vmemmap Optimization (HVO) generalization,
Sashiko reported that memmap_init_zone_device() could be asked to
initialize struct pages with a large-page order for a physical range
that was not naturally aligned to that order.

Following the Device DAX call path confirmed that the condition was
reachable. Device DAX range validation checks the range size, but not
its start address. An unaligned range can therefore reach
memmap_init_zone_device() after the device binds, and a subsequent write
to a userspace mapping may trigger a kernel panic. With the help of an
LLM, I was able to reproduce the failure.

The automatic resize path has a related problem. It can split an aligned
size request across arbitrary free gaps, consume an unaligned fragment,
and leave the resize partially applied when a later allocation fails.

This series first fixes the mapping sysfs attribute to propagate
validation failures. It then validates both the start and size of every
Device DAX range and makes automatic resize account only for usable
aligned space.

The changes were tested by booting the kernel in a VM with a fragmented
dynamic DAX region. Misaligned mappings were rejected with -EINVAL,
aligned allocation and multi-range mmap read/write succeeded, and an
allocation exceeding the usable aligned space returned -ENOSPC without
leaving a partial allocation.

v2:
- Return explicit errors before Device DAX range allocation
  (suggested by Dave Jiang)
- Move the mapping error reporting fix before the range alignment
  validation fix for independent backports (suggested by Dave Jiang)
- Keep the alloc_is_aligned() name to avoid unrelated helper renaming
  (suggested by Dave Jiang)

v1: https://lore.kernel.org/all/20260915095621.3744167-1-songmuchun@bytedance.com/

Muchun Song (2):
  dax/bus: fix mapping attribute error reporting
  dax/bus: fix Device DAX range alignment validation

 drivers/dax/bus.c | 142 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 110 insertions(+), 32 deletions(-)


base-commit: 93f51579e7df248780214094418f205253383cc5
-- 
2.54.0

