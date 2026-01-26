Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com [207.54.90.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34352AD2B;
	Mon, 26 Jan 2026 14:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769436732; cv=none; b=rPOspicj+siJJR6GVTCyRCILNAxh0P0BSK0eiYNuws8j3EI4KH/dj0aHWm7t2ilYPBEgyfwDb6I3BlMwbbwnEkJWiRh02EiGfD3Pbh0QupXTdkX7Y19FYzoFwaxG3lMpVlEsHFn2RUdoCLtDlOfE/ochOKdqzg+2X0bQ2q+M8rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769436732; c=relaxed/simple;
	bh=bZQ8UiTNtw2fIX2/Eow7cE71QE933IZxOucqYtK06bM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q3z8+YHPh1qkLTqzANYv89YiFwu+t0Nsd5kYkvtim+UJl0J4SSorPnxbnU8iiUOQ15eTlOJihUck+pSB49f5INbBqfnjB4DATc4Otlj0MZvU1bWscPBLWUGyDzAlhccQd/B8TyV536pNICeM1pkImcCOH8mIQAXdBxejO16rXlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=ij2kYBqP; arc=none smtp.client-ip=207.54.90.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="ij2kYBqP"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1769436731; x=1800972731;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bZQ8UiTNtw2fIX2/Eow7cE71QE933IZxOucqYtK06bM=;
  b=ij2kYBqP9F7lzJwsgY5CLYR2NlkEefZDpgR8SC9RIeHAsCHdO9X4gh/4
   2sZ5whP5DRvbt8X8iDuzSt4YYH2nPE1xy72aV/ipjghtw0YyjCNJeCMdA
   hpweukRAcIy1p2M08LezOenAezGV3IJtRoQUTJ0iPFdjQgv/OcpNNqmOt
   /0+1lli2dRcUFpYRIY6kCi3kedx/+JJcHZtKU3JeoQukHSCAnroq7SBXv
   E3BoSpHG5st1UKyOWP2NU3kOryoSZpusjmc7/h6Lps5osfkN8HZPxRJIY
   KR2d0aP0zKigM6KYPdG78ws7qwnjGetxjUfJLL+RQMSOvy3Nnd2RKmgnR
   Q==;
X-CSE-ConnectionGUID: WfK9fPjMTk6DtrxK+cdSxw==
X-CSE-MsgGUID: tZQeu9NnRyips53uQ2GIEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="227080512"
X-IronPort-AV: E=Sophos;i="6.21,255,1763391600"; 
   d="scan'208";a="227080512"
Received: from unknown (HELO az2uksmgr3.o.css.fujitsu.com) ([52.151.125.128])
  by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 23:11:00 +0900
Received: from az2uksmgm4.o.css.fujitsu.com (unknown [10.151.22.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmgr3.o.css.fujitsu.com (Postfix) with ESMTPS id 2634D1002B82;
	Mon, 26 Jan 2026 14:11:00 +0000 (UTC)
Received: from m3002.s.css.fujitsu.com (msm3.b.css.fujitsu.com [10.128.233.104])
	by az2uksmgm4.o.css.fujitsu.com (Postfix) with ESMTP id 9D7B31400370;
	Mon, 26 Jan 2026 14:10:59 +0000 (UTC)
Received: from nezuko.soft.fujitsu.com (unknown [10.118.236.61])
	by m3002.s.css.fujitsu.com (Postfix) with ESMTP id C60BE200B3B5;
	Mon, 26 Jan 2026 23:10:57 +0900 (JST)
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
Subject: [PATCH v3 0/1] cxl/cli: enforce HPA-descending teardown order
Date: Mon, 26 Jan 2026 23:14:58 +0900
Message-ID: <20260126141459.3935967-1-pawel.mielimonka@fujitsu.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v3 of the series. 
Apologies for the issues in v2 caused by an incorrect patch generation
step. v3 is generated from the correct tree after verifying, compiling
and testing, and it is confirmed to include correct changes.

The series implements:
 - Rework teardown ordering to account endpoint decoders shared across
   regions under the same bus/port
 - This addresses scenario described by Alison when a memdev is
   targeted by regions under multiple root decoders.
 - Correct formatting

Again, Alison, if you have a chance, please retest this version
against your configurations.

Pawel Mielimonka (1):
  cxl/cli: enforce HPA-descending teardown order for destroy-region

 cxl/region.c | 116 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 113 insertions(+), 3 deletions(-)

-- 
2.47.3

