Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D92ED69
	for <linux-cxl@vger.kernel.org>; Fri, 24 Nov 2023 05:53:48 -0800 (PST)
Received: from lhrpeml500006.china.huawei.com (unknown [172.18.147.226])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ScGcy1ZYdz6K9CH;
	Fri, 24 Nov 2023 21:52:18 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 24 Nov 2023 13:53:44 +0000
From: <shiju.jose@huawei.com>
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>
CC: <jonathan.cameron@huawei.com>, <tanxiaofei@huawei.com>,
	<prime.zeng@hisilicon.com>, <linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH v2 0/3] hw/cxl/cxl-mailbox-utils: Add feature commands, device patrol scrub control and DDR5 ECS control features
Date: Fri, 24 Nov 2023 21:53:34 +0800
Message-ID: <20231124135338.1191-1-shiju.jose@huawei.com>
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
X-CFilter-Loop: Reflected

From: Shiju Jose <shiju.jose@huawei.com>

Add support for the feature commands, device patrol scrub control and
DDR5 ECS control features.

CXL spec 3.0 section 8.2.9.6 describes optional device specific features.
CXL spec 3.1 section 8.2.9.9.11.1 describes the device patrol scrub control
feature.
CXL spec 3.1 section 8.2.9.9.11.2 describes the DDR5 Error Check Scrub (ECS)
control feature.

The patches are available here,
https://gitlab.com/shiju.jose/qemu/-/tree/cxl-scrub-2023-11-14
and is based on Jonathan's branch
https://gitlab.com/jic23/qemu/-/tree/cxl-2023-10-16

Changes
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

 hw/cxl/cxl-mailbox-utils.c | 360 +++++++++++++++++++++++++++++++++++++
 1 file changed, 360 insertions(+)

-- 
2.34.1

