Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA54D132C23
	for <linux-cxl@vger.kernel.org>; Thu, 15 Feb 2024 15:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708010291; cv=none; b=MSuTRpsT72l4giOJ4qyT3dyfYYwFCp7LmM+q/JwMcyLdRpQc5FhO/y8TtJDdBKGkDPfQui+yoFtiLsVUt/6/smdK4L766hSsg81bJqeUAn6s9bzCCi+3R8IpnVDivgnV/72uUR0qkjH9ENqcv5wNrq81Wn9WD+9F7q5mEPfbeOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708010291; c=relaxed/simple;
	bh=gatTXr6ADPFGPC3KI6SYK5h4xYX7WVfxY0q81vjW8to=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PvUrw2Pszjen0cq8YGLgqNrb9m00y1ZxQX0dVXabSKw+q8E6WdXgxCiPdVLnjQNkvm7n/iaptxelOZAQcdHpSbdJat7wPcYXZMFBXb2GyXxBQq2Zfik1bBzqckUitOi2edUYTqkTVdnD0pWJsIljMPSQ2UogKlRf877IiANJGks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TbJWd0DZXz6K8xR;
	Thu, 15 Feb 2024 23:14:37 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id D0D2F140DAF;
	Thu, 15 Feb 2024 23:18:04 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 15:18:04 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Gregory
 Price <gregory.price@memverge.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?=
	<alex.bennee@linaro.org>, <richard.henderson@linaro.org>
CC: <linux-cxl@vger.kernel.org>, <qemu-arm@nongnu.org>, <linuxarm@huawei.com>
Subject: [RFC PATCH 0/1] target/arm: Fix FEAT_HADFS when page tables are in MMIO (cxl)
Date: Thu, 15 Feb 2024 15:18:03 +0000
Message-ID: <20240215151804.2426-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

https://lore.kernel.org/qemu-devel/20240215150133.2088-1-Jonathan.Cameron@huawei.com/
gives more details of the reason the CXL emulation uses MMIO space
(short answer is it has very fine grained address routing).

Obviously this one is lower priority for me to upstream as the ARM support in
general is only in my CXL staging tree (I'll get back to that soonish).

The equivalent tests with CXL memory and forcing applications to run from it
on ARM64 TCG ran into an additional issue.  We need to be able to do
atomic compare and swap to update the access and dirty flags as part of
a page walk if we have the ARM 8.1 FEAT_HADFS (note you can disable this in
the kernel then this problem isn't hit but that's not a viable long term
solution though it did help me diagnose the problem)

As the patch says I'm far from confident on this fix. Whilst it 'works'
for little endian at least I'm hoping someone more familiar with the locking
requirements etc can let me know if the BQL is the right option here and
people can give a general opinion on whether such a hack is the right
solution.

Jonathan Cameron (1):
  arm/ptw: Handle atomic updates of page tables entries in MMIO during
    PTW.

 target/arm/ptw.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

-- 
2.39.2

