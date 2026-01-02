Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCFC23741
	for <linux-cxl@vger.kernel.org>; Fri,  2 Jan 2026 15:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767368859; cv=none; b=RRlZwjbUxhqXI0DChKmiGxbwaSi03sHtRiG5kF8ZP4hiof5XTjD0U7RYvHYzPVnSFklt3NLRqC9LtiNjlJCvUz7eu+Swfguo5Z1aVwsE7Oy5fElR1y/rMuiuPgxM57Xuh+r6e+yWTfpCzzVYEEIxiyMUpts/eDPBYJ0ZYoTDsAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767368859; c=relaxed/simple;
	bh=ec+dH26s7KXx+MaMOFZ5v3O1N28LebbsHkAWhOhUB7Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=czf5ebhkR/x9wUH5yu0GRGQikJwRytbnB4t8idnOufkQn2EV7jQ4RDbFMyDo5kzxxQvMBDralsTXCvgSliarmcyRyByKt3Q4/w86Okw9e+pOCZ3Szz6fqcoEcGPmKR6A6y4bvOKz0vijh6ZsDzGAKtr33YrGXchvlMTx59eqNYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4djSjT418wzJ468V;
	Fri,  2 Jan 2026 23:46:37 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 2A2CA40569;
	Fri,  2 Jan 2026 23:47:33 +0800 (CST)
Received: from SecurePC-101-06.huawei.com (10.122.19.247) by
 dubpeml100005.china.huawei.com (7.214.146.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 2 Jan 2026 15:47:32 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Michael Tsirkin <mst@redhat.com>, <qemu-devel@nongnu.org>, Vinayak
 Holikatti <vinayak.kh@samsung.com>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>, Ravi Shankar
	<venkataravis@micron.com>
Subject: [PATCH qemu 0/2] hw/cxl: Two media operations related fixes.
Date: Fri, 2 Jan 2026 15:47:29 +0000
Message-ID: <20260102154731.474859-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)

Peter reported both of these last cycle.  Both are related to sanity
checking parameters.

Jonathan Cameron (2):
  hw/cxl: Check for overflow on santize media as both base and offset
    64bit.
  hw/cxl: Take into account how many media operations are requested for
    param check

 hw/cxl/cxl-mailbox-utils.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

-- 
2.48.1

