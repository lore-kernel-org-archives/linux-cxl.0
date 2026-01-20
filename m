Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD0D43E9C9;
	Tue, 20 Jan 2026 14:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768919368; cv=none; b=jEt/TfRu/6P3ZzhJFIw/a4a1oww6/qft7ABZzr8dHTL4GLvVKN49B5koRLMBYaoOKZxvja2VIUgsCjxm0sfaPHX3ef8cyU9G7ZSxWyBtNTprrlyFp0YrdtiC2sNkl/GCwd3947aW39hyV2qVIxU62K0NDjC18ka4KXHmKVkbfHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768919368; c=relaxed/simple;
	bh=X0klicOWOTDVaN/SovukcpPVe1G2PfKXGGR4bDp/zDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dl7+OIL8tDqjDTg7964qAhDxQMUkYL9XKjSn5tab91f2vLVgLNUJdAqFbP2ObYEH6GwWOY7yGSnE3zSnuqfEzMMOGhE87QCDAdz1N40Mb5656/aBewa6s+Pp2+hNtbYPAJ1qAsR9eUlnENMOtc4/DCV65oU8J9VPKoXye8gonbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=O7WyVxhr; arc=none smtp.client-ip=139.138.61.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="O7WyVxhr"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1768919367; x=1800455367;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X0klicOWOTDVaN/SovukcpPVe1G2PfKXGGR4bDp/zDc=;
  b=O7WyVxhrzf3ZsjhniIwCRbpQu3jxiM7ce3/9EJZ50fYcIsNEc1XbAVHj
   vAb7HhSFZohKlQ8MckDwrEzHRiS7cG7yDGq7u85nQk/0n5qXzN2WYWVjV
   QRZVR1eCWmhftKJE3dUbkjgLsmdlgwrfnUEZn3uN7KMyd//09cwdi3jZc
   8z86V83x9cZuSRX89E/YbSnYRWdOEj5V2YEuTVWRfVvfkSUXbSElhkpPH
   cxBmCePYpR68kaTsMvZgbB94e+V92m3QJit14P4a2qFNX0LP2OHcBRPL9
   +1FGVVizxlNIOuwfRc7M93DkKnhreGkuGSkQXtPg5BadADrJvkcRhq2y0
   A==;
X-CSE-ConnectionGUID: 0SJUeBAdQaa2FBPMyu2AWQ==
X-CSE-MsgGUID: 98e1dkFLS/GLoWpkSsDbUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="205256396"
X-IronPort-AV: E=Sophos;i="6.21,240,1763391600"; 
   d="scan'208";a="205256396"
Received: from unknown (HELO az2nlsmgr3.o.css.fujitsu.com) ([20.61.8.234])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 23:28:15 +0900
Received: from az2nlsmgm2.o.css.fujitsu.com (unknown [10.150.26.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgr3.o.css.fujitsu.com (Postfix) with ESMTPS id E6A5A100034D;
	Tue, 20 Jan 2026 14:28:15 +0000 (UTC)
Received: from m3004.s.css.fujitsu.com (m3004.s.css.fujitsu.com [10.128.233.124])
	by az2nlsmgm2.o.css.fujitsu.com (Postfix) with ESMTP id 58E371C00131;
	Tue, 20 Jan 2026 14:28:15 +0000 (UTC)
Received: from nezuko.soft.fujitsu.com (unknown [10.118.236.61])
	by m3004.s.css.fujitsu.com (Postfix) with ESMTP id 8BF9020053F2;
	Tue, 20 Jan 2026 23:28:13 +0900 (JST)
From: Pawel Mielimonka <pawel.mielimonka@fujitsu.com>
To: dan.j.williams@intel.com,
	alison.schofield@intel.com
Cc: Smita.KoralahalliChannabasappa@amd.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	Pawel Mielimonka <pawel.mielimonka@fujitsu.com>
Subject: [PATCH v2 0/1] cxl/cli: HPA-ordered destroy-region teardown
Date: Tue, 20 Jan 2026 23:32:11 +0900
Message-ID: <20260120143212.3006273-1-pawel.mielimonka@fujitsu.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251125143826.282312-1-pawel.mielimonka@fujitsu.com>
References: <20251125143826.282312-1-pawel.mielimonka@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v2 of the series.

Changes since v1:
 - Rework teardown ordering to account endpoint decoders shared across
   regions under the same bus/port
 - This addresses scenario described by Alison when a memdev is
   targeted by regions under multiple root decoders.

Alison, if you have a chance, could you please retest this version
against your multi-root-decoder configuration to confim that the
teardown now behaves correctly in that scenario?

Pawel Mielimonka (1):
  cxl/cli: enforce HPA-descening teardown order for destroy-region

 cxl/region.c | 110 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 108 insertions(+), 2 deletions(-)

-- 
2.45.1.windows.1

