Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35A31DDD5
	for <linux-cxl@vger.kernel.org>; Mon, 19 Feb 2024 15:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708354848; cv=none; b=Q14pRGtDSy4yK6AxG/Cuxr50gs5MZXZ8SzDtwwpPRsaRxK7tAuEizekk8Ff0QdagxkPRqC1QDEtaUa20ecx5VHNbR5+kIZm+5ur/Ko3XfIJ0Fdp7XMFdGflLhzkWCTbOCaHflc2YU+U14QjO3IyUplNd5nQgqGcQgPyY5clGQp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708354848; c=relaxed/simple;
	bh=YFs2YzJDoFciPCpVTAJGfPf+LytlT7CTBW85NSlL8k8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oDQs9/h39WgNumMoSo9sG9BQRdPAkEjc/zN91zP0s7HHw7G7OpWiety3VPvNzVNhDZ5fUSdRO7wE+kKKoi1/Y/jC2PlBA1GkjidWVJP7cxuWnmax6chT9UsX6k472oqWzI9l/jGmQvpbi2nWSQLloCqrL6AjvDJGCKwwVQ9A1UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tdlwq6Bn5z6D8Yr;
	Mon, 19 Feb 2024 22:56:27 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
	by mail.maildlp.com (Postfix) with ESMTPS id 97557140B38;
	Mon, 19 Feb 2024 23:00:42 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 19 Feb 2024 15:00:42 +0000
From: <shiju.jose@huawei.com>
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>
CC: <jonathan.cameron@huawei.com>, <tanxiaofei@huawei.com>,
	<prime.zeng@hisilicon.com>, <linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH v4 0/3] hw/cxl/cxl-mailbox-utils: Add feature commands, device patrol scrub control and DDR5 ECS control features
Date: Mon, 19 Feb 2024 23:00:22 +0800
Message-ID: <20240219150025.1531-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
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
https://gitlab.com/shiju.jose/qemu.git branch: cxl-scrub-2024-02-19
and is based on Jonathan's branch
https://gitlab.com/jic23/qemu/-/tree/cxl-2024-02-14 

Changes
v3 -> v4
1. Rebased to Jonathan's latest branch cxl-2024-02-14.
2. Changes for Davidlohr's comments. Thanks.
  - Changed CXL feature attributes to static.
  - Rename attrb -> attr.
  - use MIN()
3. Added Reviewed-by: Fan Ni <fan.ni@samsung.com>

v2 -> v3
1. Rebased and updated for 3.1 specification.

v1 -> v2
1. Changes for Davidlohr's comments. Thanks.
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

