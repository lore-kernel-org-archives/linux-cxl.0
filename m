Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D94128812
	for <linux-cxl@vger.kernel.org>; Thu, 15 Feb 2024 11:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707994954; cv=none; b=r4dPymfdebLfMm65mcbP5b/Ag9mCRNJR3l7R55xHpR4Hu+9LsOnkpdCyoLoroF2MukqPBUedMGuTSwSA6hN6/gBbTnBMQS64P6s2kjBHEwnKZM9di+l+RBc/Q+p3f16hpGF5XazCjkDj9XbUoHYE6k6EFF8FFvcu1c3E7lJ/fH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707994954; c=relaxed/simple;
	bh=osxN4EprxtnwmGXxZyRE1fRKANyWOh/zNggUa1A+uko=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qiTkAgCbssYvFKda16FcC+KCuOP4u8S94MSrKFMnikQpUQjYxorbi1PUA+MTFitUdHiJDtYkum+9GqaPmT0AZikGVqSmyEY2sFwoOFHCxQSgl77y89LvTezaqmqZ72mz9oGXN0lbs0CQpQT7gKRorC4cnfqrE1Fuv9AEfjWxVg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TbBrj1RMtz6K8Kq;
	Thu, 15 Feb 2024 18:59:01 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
	by mail.maildlp.com (Postfix) with ESMTPS id B9F33140D26;
	Thu, 15 Feb 2024 19:02:28 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 11:02:28 +0000
From: <shiju.jose@huawei.com>
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>
CC: <jonathan.cameron@huawei.com>, <tanxiaofei@huawei.com>,
	<prime.zeng@hisilicon.com>, <linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH v3 0/3] hw/cxl/cxl-mailbox-utils: Add feature commands, device patrol scrub control and DDR5 ECS control features
Date: Thu, 15 Feb 2024 19:01:43 +0800
Message-ID: <20240215110146.1444-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500006.china.huawei.com (7.191.161.198)

From: Shiju Jose <shiju.jose@huawei.com>

Add support for the feature commands, device patrol scrub control and
DDR5 ECS control features.

CXL spec 3.1 section 8.2.9.6 describes optional device specific features.
CXL spec 3.1 section 8.2.9.9.11.1 describes the device patrol scrub control
feature.
CXL spec 3.1 section 8.2.9.9.11.2 describes the DDR5 Error Check Scrub (ECS)
control feature.

The patches are available here,
https://gitlab.com/shiju.jose/qemu.git branch: cxl-scrub-2024-02-15
and is based on Jonathan's branch
https://gitlab.com/jic23/qemu/-/tree/cxl-2024-02-05-draft 

Changes
v2 -> v3
1. Rebased and updated for 3.1 specification.

v1 -> v2
1. Changes for Davidlohr comments. Thanks.
 - Changed CXL SET feature data transfer flags as enum.
 - Modified pointer supported_feats to get_feats_out.
 - Removed an unnecessary branch.
 - Use MIN().
 - Move setting of hdr.nsuppfeats further down.
 - Return CXL_MBOX_UNSUPPORTED if non-zero selection flag is passed.
 - Add more IMMEDIATE_*.* flags set_feature.  
 - Corrected a spelling error.

Shiju Jose (3):
  hw/cxl/cxl-mailbox-utils: Add support for feature commands (8.2.9.6)
  hw/cxl/cxl-mailbox-utils: Add device patrol scrub control feature
  hw/cxl/cxl-mailbox-utils: Add device DDR5 ECS control feature

 hw/cxl/cxl-mailbox-utils.c | 368 +++++++++++++++++++++++++++++++++++++
 1 file changed, 368 insertions(+)

-- 
2.34.1

