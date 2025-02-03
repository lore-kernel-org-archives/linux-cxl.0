Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7B5209681
	for <linux-cxl@vger.kernel.org>; Mon,  3 Feb 2025 16:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738599556; cv=none; b=Jl6Oz+j5XaSRfUlXGyNJBvsyp38JljJ9557f41GOsqCIQJcyyiOf6kLoZymv9e/4Om4xYqVLTBNVMMFJRqUfdO3KuSurojGLJwTezBNSNd7BifQK/sWaFTW23Fci1sPm+uC7LMES+c2Du9bAYjBFfmIiTxrXCsIMzGnNrFJfjiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738599556; c=relaxed/simple;
	bh=sp5RRQ5CtG9fu8uXdWj1rNyiMt0gWAOKUEaH1On7csg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BtH4PZEOb1ODECZAMToH5YfxfYrOKg35pJDU2FaMjmiNT2A43K8vj11TCJVcAs4eWM5ilxgQDWMmRkiP2CaJuTeI6bxyY0MMYfSiZ3SaaDiIJQY2J+SAO5ZviUODVE1I6R0ywLyY+VYFP9MX73uh7Iz13iyhz6pUmwAV8oRYvDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yms7n0vjhz67LJ2;
	Tue,  4 Feb 2025 00:16:37 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 8817A1406AC;
	Tue,  4 Feb 2025 00:19:09 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Feb 2025 17:19:09 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>, <mst@redhat.com>
CC: <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH qemu 0/5] hw/cxl: Cleanups and interleave support.
Date: Mon, 3 Feb 2025 16:19:03 +0000
Message-ID: <20250203161908.145406-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

First set of CXL updates for the 10.0 cycle.
- Mixture of cleanup and hardening against a repeat of recent MSI-X
  numbering bug.
- Expanded interleave support (been on my tree a long time)

Whilst I think these are in a good state, review always welcome.

Li Zhijian (4):
  hw/cxl: Introduce CXL_T3_MSIX_VECTOR enumeration
  hw/mem/cxl_type3: Add paired msix_uninit_exclusive_bar() call
  hw/mem/cxl_type3: Fix special_ops memory leak on
    msix_init_exclusive_bar() failure
  hw/mem/cxl_type3: Ensure errp is set on realization failure

Yao Xingtao (1):
  mem/cxl_type3: support 3, 6, 12 and 16 interleave ways

 include/hw/cxl/cxl_device.h  |  4 ++--
 hw/cxl/cxl-component-utils.c |  9 ++++++--
 hw/cxl/cxl-device-utils.c    | 12 ++++------
 hw/cxl/switch-mailbox-cci.c  |  4 +++-
 hw/mem/cxl_type3.c           | 45 +++++++++++++++++++++++++-----------
 5 files changed, 48 insertions(+), 26 deletions(-)

-- 
2.43.0

