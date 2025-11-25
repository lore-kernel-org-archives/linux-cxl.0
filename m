Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E33E2DAFB5;
	Tue, 25 Nov 2025 14:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764081388; cv=none; b=Hy/QQ+T0gcpxzHn2Kseyt61M28CrKYu/Umo24dRlQs8DBXlOv1u/tkzhtDdLtAawzx3fQpIkZzq4qUmY+/x8abXUbm+XPtbR85rCKWWxDE6q6ZVJB4RDZ+XXCAA9VgFHgvqgSNK2OT0IFrOjEN0o/vvGsArFITobDs2V5Y7Nbg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764081388; c=relaxed/simple;
	bh=8b7urrXN6YtwvK1HvGbozepxJw4SYgsLqBo1XzShTqo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L2oVsBiYntUMJECQnYQ23lU3rMBa1FqTlSae7C3SVj5WWAH3KRZ0wreICvTVIPwsH9rBi5x4f11563OVtq5392cLn9xqcCEm6JyNdhwegElyrnlWIarwxpjxOcHwECfUl7ix1QiMNvdw/LDTIC6zHmuKVAa3hbwNjvmliu1zdGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=GaVPz0gO; arc=none smtp.client-ip=68.232.139.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="GaVPz0gO"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1764081387; x=1795617387;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8b7urrXN6YtwvK1HvGbozepxJw4SYgsLqBo1XzShTqo=;
  b=GaVPz0gOormUegL+0qHZsGKyg/Vp4Qv98ZLqEn2ojCZcoe0U2I1vU+RY
   /2URmC/UcQT7H7d0/up4lz0ZN4L/e5OJGLbjiZ1Muuzy5UXeRmv65RNIb
   9XoLLcOcnSDqsWMRp+nOcTCs6n/LxW2L3S0nZmWLMcle70h3oEuenDT4f
   NDzbQyVQ9wPj8QLVhsmkmornw81Yi6m9EGEFlHDghn72cqZm7VHuUug67
   oJ+JXkxQQZPAxuE2GD1D+qbPBOXQIwAgEqHruCuPewDHQf6pgcZ1/f83t
   rh3eZEroHp7KWIn8lPFA2cPrdT5Ky3Cu66OYCUxJg/UJv1spBmwGcaZh9
   A==;
X-CSE-ConnectionGUID: fMnLFYc5Qj2NkTP1RDm3PQ==
X-CSE-MsgGUID: 538E0P1URHi/1wy4ThpiZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="219738539"
X-IronPort-AV: E=Sophos;i="6.20,225,1758553200"; 
   d="scan'208";a="219738539"
Received: from unknown (HELO az2nlsmgr3.o.css.fujitsu.com) ([51.138.80.169])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 23:36:19 +0900
Received: from az2nlsmgm1.o.css.fujitsu.com (unknown [10.150.26.203])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgr3.o.css.fujitsu.com (Postfix) with ESMTPS id 771B51000344;
	Tue, 25 Nov 2025 14:36:19 +0000 (UTC)
Received: from m3003.s.css.fujitsu.com (sqmail-3003.b.css.fujitsu.com [10.128.233.114])
	by az2nlsmgm1.o.css.fujitsu.com (Postfix) with ESMTP id E7DA7C01ECA;
	Tue, 25 Nov 2025 14:36:18 +0000 (UTC)
Received: from nezuko.soft.fujitsu.com (unknown [10.118.236.61])
	by m3003.s.css.fujitsu.com (Postfix) with ESMTP id 381D42005371;
	Tue, 25 Nov 2025 23:36:17 +0900 (JST)
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
Subject: [RFC PATCH v1 0/2] cxl/cli: HPA-ordered destroy-region teardown
Date: Tue, 25 Nov 2025 23:38:22 +0900
Message-ID: <20251125143826.282312-1-pawel.mielimonka@fujitsu.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series addresses an issue in destroy-region, where
region teardown relied on libcxl enumeration order, which is not
guaranteed to match the increasing HPA order exposed by the kernel. 
When a decoder window is fully populated, attempting to destroy a
non-last region causes kernel-side validation to fail (e.g.
set_dpa_size(..., 0) returns an error), and subsequent destroy/create
sequences may become impossible.

The CXL specification requires that decoder programming (and the
implicit teardown path) must preserve continuous HPA coverage and
proceed strictly in order: decoder m before decoder m+1, with each
covering an HPA range below the next one. Practically, this means that
region teardown must follow HPA-descending order and must stop as soon
as a gap in the requested suffix is encountered.

The patch introduces destroy_multiple_regions(), which collects all
regions under a given root decoder, sorts them by HPA, and destroys
only the suffix requested by the user (or all regions in the case of
“all”). The implementation guarantees that only valid teardown
sequences are attempted and prevents decoder state inconsistencies
observed during repeated destroy/create cycles.

Enable/disable paths and all existing bus/port/decoder filtering
remain unchanged.

Pawel Mielimonka (2):
  cxl/cli: add helpers to collect and sort regions by HPA
  cxl/cli: enforce HPA-descending teardown order for destroy-region

 cxl/region.c | 114 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 111 insertions(+), 3 deletions(-)

-- 
2.45.1.windows.1

