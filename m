Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8863D6CD7
	for <linux-cxl@vger.kernel.org>; Tue, 28 Apr 2026 08:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777366352; cv=none; b=in3vlCyHfjFUqHTnq8s0sMCAGP7yAVEe19v/Z4pNWWxCMqAdMGyB5eE/UxsK6NiSEBX/n6VWxDgoYqpHLBSBRqSm56IOQ+jlqk7n1qoxFeYURdmW23SZnyY7bRwgNdN8SarqJdULMrx9g3ojvGt4w/eccFGOJkKyZO7iUSy/MAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777366352; c=relaxed/simple;
	bh=RLwD2N0mv9roKLCXFV0rn/6h7B6QYUYygiZ/+w9HG6w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PV6HfA3c5PIPec/dn2hHq1Tw1fmYB5GgkRZI0bAbBQKxU6VSZWkjnR6gN1oWB/2mEDTnOQJjEQiUbPON3YNhB+KDneJ4mhhN/UR4uActIhriYNDBmRCKmvq6X082SQveV/EhHRA7aNNGLh7J1yoS9YkQ8DqMr3mgtW3bsHrfjOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bRpVICZo; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bRpVICZo"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35d965648a2so10020959a91.0
        for <linux-cxl@vger.kernel.org>; Tue, 28 Apr 2026 01:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1777366348; x=1777971148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e3sNHSEvdT5tHKgIgohZAf9cczsNpU7ZSQz8YQr/Ej8=;
        b=bRpVICZoP0TzWr7Pw348t9xtmqix5UI2h+uW0jZL63sRqRzSuZP5PAY1T2AqJ02mbe
         sJxF2zlcN4jpkA0ASXzwlCWPnGdKds+sXJvUaOFW+xR4xsXWG8MXiFvACiEaLktLH746
         AeThbeKtaRDfb812GlExEGDsLM97YMqrtXvtkekHyEaUX5XlzO7wcFRIbz5NoD7zvQUX
         4EpyjFiyvC1fVpr7LXOTCwxV06yv61egLQYNNNs8D/5bJytSSv32xDVaj/JqZFz3jufH
         Y2D2reKwalx/04fLAdZ6UneGVGDXBmXudiyMUMuC7ZCRgCH3HxDQ4CkN4AelVz4Aj0nd
         kUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777366348; x=1777971148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e3sNHSEvdT5tHKgIgohZAf9cczsNpU7ZSQz8YQr/Ej8=;
        b=dVXMOxvqKZ8N8GNsTiZnltjSG+IgSumdeKOi2IpXIPFHYdaT7BwM2yd8Y2ET1pN+8j
         19MR6j4ny1Qui5LImobnTtsRJrNPXqvzHJX7UiMKQShzthZir7uaTZiMP82f/2m3eRa6
         9Y/b0y1LrOSIa6EQ22IEv0eXytIeMP02q0Sp64GWKu37gp/NMc78cAPXDMb7c5ms8UON
         mx0zv0LjDZYo8jQIyls3LjJUNyoQ8AEkLMEwPFnkxHrk2hS4Uo8gAMVlUQUYPAqmbPDn
         QGfU1QPG5wv9kR8eVnkcl0DHaINPCiCUepAmhke0t+xxsLYM8YXqVPdvNts+FEtaKbyC
         vTMg==
X-Forwarded-Encrypted: i=1; AFNElJ8eU/LHVGn6zZzWBHpRbhNbEHZflyKhla+gkNGveuW5l9pW91wzjU01LqdM1Igt1ekBglaYQm6wPYg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2izo4y3AXkK7ykhiricdknFHCJhO5KYEk4A+hgVdC7ZakpIcT
	rqFMX2a1QRBi027oxuAuQMHynUMetuaI551u8HenSgJmtcC1mbVnvwVVSpw1895cdW4=
X-Gm-Gg: AeBDiet4Tu6qLQkfBAOPypWsqoseQH9jN9zC3ti/2gwRu+zU5HA+WBBBjMM4SUdELPX
	sWTDPdY7NyFZBQAqJ09+u2GJp6nDS8EBh7Hi2zhA5K4TzCnOGJjhQgxHSr9qB/cPBUz8eZVOqLi
	MbckbJysYIDonp566u1pRpjguajBFQkS8GkODWyFHeWu9rZexSfRTgAePsPhNbzK8vNll898vz1
	Ar1nwnlYDENgKlFtiSYlBs05UQxC0779Sm3XVY+eVZe+AfesDi7KDhDBfco9iz6b2Ii5sactIQK
	HZ/STzavO0KqVAb8iZgNVFd20GSnlzrtGDyraDA1xxNyf0ICMdK9UB7UenxYeFSJCRJYncypagJ
	PYkg2sL4wNq6Uuke6cFTfEcYsR5mVoUKw8Afaqmo3j5V5u67GRtSZgYsdRX4pDL37TdqLBPvu7b
	g4ynuIz0y23n/WPe3TsDJmOGcWkGEhaGLkiSt/aMVSQkYIPos89FzYaqs=
X-Received: by 2002:a17:90b:2ccb:b0:362:ded3:bbcb with SMTP id 98e67ed59e1d1-3649204c801mr2305930a91.25.1777366348422;
        Tue, 28 Apr 2026 01:52:28 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.103])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364902e7debsm2889080a91.15.2026.04.28.01.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 01:52:28 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Vishal Verma <vishal.l.verma@intel.com>,
	Ying Huang <huang.ying.caritas@gmail.com>,
	Dan Williams <djbw@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	linux-mm@kvack.org,
	linux-cxl@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	muchun.song@linux.dev
Subject: [PATCH v2 0/3] mm: Fix memory block leaks and locking
Date: Tue, 28 Apr 2026 16:52:16 +0800
Message-Id: <20260428085219.1316047-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes two memory block device reference leaks and one
locking issue around the per-memory_block hwpoison counter.

Changes in v2:
- Add Acked-by from Oscar Salvador to patch 1.
- Keep the series as pure bug fixes; defer
  memory_block_get_by_id()/memory_block_put cleanup to a separate
  series.
- Add Reviewed-by from Miaohe Lin to patch 2.
- Add device_hotplug_lock handling in patch 3.

Muchun Song (3):
  mm/memory_hotplug: fix memory block reference leak on remove
  drivers/base/memory: fix memory block reference leak in poison
    accounting
  drivers/base/memory: fix locking for poison accounting lookup

 drivers/base/memory.c | 18 ++++++++++++++----
 mm/memory_hotplug.c   |  2 ++
 2 files changed, 16 insertions(+), 4 deletions(-)


base-commit: 7080e32d3f09d8688c4a87d81bdcc71f7f606b16
-- 
2.20.1

