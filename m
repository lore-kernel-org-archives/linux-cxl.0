Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A7F11CBF
	for <linux-cxl@vger.kernel.org>; Fri, 23 Feb 2024 08:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708678752; cv=none; b=orgzAc3Y+vOa32NWniPFvGSzvG1dVLwrNrtHVUPaOVaqihTxRjlH4Rb/+OnQ8sk/tubnO9ObfSoiXwV5oP24bFO7TnFtdIKhPMr2TR0sd9zpaBjzgaDMDjfUwFejBWbnVFpQJb9NfFWTl7zGtfgTzmk0cH5BmO8Gj0d0vWRjWYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708678752; c=relaxed/simple;
	bh=nvl+uHWtG/ShKifY5Zj4dXoiari9a0gpdNX0tFhsWAk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ggUs4ScIGquDKVW8gqgSI+jvKw8mtZ+Ad8YayAGipABhadJHJyxSEDMPM8jmuk0wuB3qnpK6sAJD3kvmZsiI8s0VxKyaZZrLAGXW7mRE3rxrnnVSQQCEaHD5PfCNv9SFpxcFCAM6ewg/Zsj3wtkveSlGEa5uAh7zXRzlWNburUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Th3jt3rLbz6K6cC;
	Fri, 23 Feb 2024 16:54:58 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
	by mail.maildlp.com (Postfix) with ESMTPS id 20D221414C4;
	Fri, 23 Feb 2024 16:59:07 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 08:59:06 +0000
From: <shiju.jose@huawei.com>
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>
CC: <dave@stgolabs.net>, <fan.ni@samsung.com>, <jonathan.cameron@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <linuxarm@huawei.com>,
	<shiju.jose@huawei.com>
Subject: [PATCH v5 0/3] hw/cxl/cxl-mailbox-utils: Add feature commands, device patrol scrub control and DDR5 ECS control features
Date: Fri, 23 Feb 2024 16:58:59 +0800
Message-ID: <20240223085902.1549-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
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
https://gitlab.com/shiju.jose/qemu.git branch: cxl-scrub-2024-02-22
and is based on Jonathan's branch
https://gitlab.com/jic23/qemu/-/tree/cxl-2024-02-14 

Changes
v4 -> v5
1. Changes for Jonathan's comments. Thanks.
  - Changed for separate scrub controls per CXL type3 device.
  - Added config flag settings for the feature entries.
  - Changed to for loop in the cmd_features_get_supported()
    function.
  - Changes for supporting multipart feature data transfers.
	etc.

v3 -> v4
1. Rebased to Jonathan's latest branch cxl-2024-02-14.
2. Changes for Davidlohr's comments. Thanks.
  - Changed CXL feature attributes to static.
  - Rename attrb -> attr.
  - Use MIN().
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

 hw/cxl/cxl-mailbox-utils.c  | 395 ++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c          |  23 +++
 include/hw/cxl/cxl_device.h |  57 ++++++
 3 files changed, 475 insertions(+)

-- 
2.34.1

