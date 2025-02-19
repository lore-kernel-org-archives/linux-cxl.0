Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723301925BF;
	Wed, 19 Feb 2025 03:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739934726; cv=none; b=Or77qqu+XlHuKfm1sbINMgovVNmSfA+FutVPPP1Eo81sBFbJ8NbkTcUUMSlI5L0ycPse/l3cG72CuAGch4VrSD8QEdc1ztefP2rpNhk0Fg112knApiEkon0wf76z7YZTi4bV2UHccmeeM1+YClZnDdKGt0PRNg4TpdecOz4Dn8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739934726; c=relaxed/simple;
	bh=Y4x9AJ4sFAsA6vxBXOn1lrmRO3mYJXJAUoR0KvIWu1M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DtXTwZ2XPiVA81IHou+AyG7vMLxJDFIQfKj5FWqgAuzWkS4/3IWYMbT9ZOSy0Cu+1X9I2l79NVTmxyDM/z0HlJ9yML/XpMBKOKNKO3RGGB6GIY8oRI5VPt9nQcWcHEsIqPOmIFyYEh6Sf572pBpCoG4XuGCwWbhE9W7V39iuysA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwCXnQ31S7Vnnt+tAw--.15444S2;
	Wed, 19 Feb 2025 11:11:49 +0800 (CST)
Received: from phytium.com.cn (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwBnaobyS7VnB7QrAA--.6774S3;
	Wed, 19 Feb 2025 11:11:48 +0800 (CST)
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chenbaozi@phytium.com.cn,
	Yuquan Wang <wangyuquan1236@phytium.com.cn>
Subject: [PATCH v4 0/1] cxl/pmem: debug invalid serial number data
Date: Wed, 19 Feb 2025 11:11:12 +0800
Message-Id: <20250219031113.407526-1-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwBnaobyS7VnB7QrAA--.6774S3
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAGAWe0524A4QADs+
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7CF17tw1xWryUCr4fAry7ZFb_yoW8XFW5pF
	Z3KFWfCF98GrW7Zw4xZr1rWF1YqF48Cr4UGryrtw18Gr4kJr10vrWSya9Fya47GrWvvF4Y
	gryjvFsxuFy7u3DanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

v3 -> v4:
- Pull the info[i] assignment and check code up

v2 -> v3:
- Add an inline comment
- Debug serial number before its assignment

v1 -> v2:
- Change 'dev_dbg' to 'dev_err'


Background
==========
A device with missing or invalid serial number is not compliant with the
spec. But we could still use it to create a nvdimm pmem region and set a
non-zero cookie of nd_interleave_set, for example:
  1. create a cxl pmem region interleaved with 2 devices (one with
     serial number 0 and the other with serial number 1), and the cookie
     would be non-zero/valid.
  2. create the second cxl pmem region by 1 device with no serial number
     and this region would have a non-zero cookie because the offset of
     dpa is non-zero.

Problem
=======
In a nvdimm interleave-set each device with an invalid or zero
serial number may cause pmem region initialization to fail, but in
cxl case such device could still set cookies of nd_interleave_set
and create a nvdimm pmem region.

CXL Pmem Validation
===================
This patch adds the validation of serial number in cxl pmem region creation.
The event of no serial number would cause to fail to set the cookie
and pmem region.

cxl-test
========
A mock serial number is set from the platform device id and 0 is a valid
platform device id. For cxl-test to work properly, always +1 on mock
device's serial number.

Yuquan Wang (1):
  cxl/pmem: debug invalid serial number data

 drivers/cxl/pmem.c           | 12 ++++++++++--
 tools/testing/cxl/test/mem.c |  2 +-
 2 files changed, 11 insertions(+), 3 deletions(-)

-- 
2.34.1

