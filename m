Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90670335D3
	for <linux-cxl@vger.kernel.org>; Fri,  1 Nov 2024 13:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730467214; cv=none; b=Gt2KBSONMSPBZ5RvvsTAR8qJYA+dgFeNipSzeXJSxFS+Xki0C8HkPyDbAVyZltjKdFc4PFmxPdnrXXqVDjN5IDul5YcNtNAA6vqyrX2Q4LrDX1FFPqTP0yoi2gKnbkBEDwOA0fR4mF/X4oZMlGNCZsVHBBsKpb9REdNwkbX50UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730467214; c=relaxed/simple;
	bh=qDhCHOpFn0pqxBWZmq16f4Acdy1AoxvzvOMb2RKYbbE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CwfO/AhHwfTk6QdfaLirlF5B1c7PhOEA9k+SRcCPnbc4ts3lXSe0SixIJej1jle0stASdzGPPrl3uVWce5w2PVsdJw7XWi1Y1F5HfQyP0YPtOKEpvhqS8tU3TKJMiKHkeRGUHXSpMd0rzU3CW+xSNl+iIVolEfPdz0GtdMEiOLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xg1dv1d4Bz6JB8H;
	Fri,  1 Nov 2024 21:18:43 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 1BC561400D3;
	Fri,  1 Nov 2024 21:20:07 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 1 Nov 2024 14:20:06 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <linux-cxl@vger.kernel.org>, <mst@redhat.com>, <qemu-devel@nongnu.org>
CC: Fan Ni <fan.ni@samsung.com>, <linuxarm@huawei.com>
Subject: [PATCH qemu 0/2] hw/cxl: Misc fixes
Date: Fri, 1 Nov 2024 13:20:03 +0000
Message-ID: <20241101132005.26633-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)

Two fixes that Fan posted a while back found testing the improving Linux
kernel support.
(qemu prefix is just to avoid confusion in the linux-cxl patchwork instance)

Based-on: [PATCH 0/7] hw/cxl: Round up of fixes.
Based-on: Message-id: 20241014121902.2146424-1-Jonathan.Cameron@huawei.com

Fan Ni (2):
  cxl/cxl-mailbox-utils: Fix size check for cmd_firmware_update_get_info
  hw/cxl/cxl-mailbox-util: Fix output buffer index update when
    retrieving DC extents

 hw/cxl/cxl-mailbox-utils.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

-- 
2.43.0

