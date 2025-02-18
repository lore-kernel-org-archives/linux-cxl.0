Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BBE2BB15;
	Tue, 18 Feb 2025 01:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739843315; cv=none; b=Ig5xxzIsB+w9m5XH7zc0RMe4FU23mh6T/Eva8NzRI+x15AMOXj9qLp8jgXYp5Fyqusk3wwP+KZ5mc+JHVpcgN4H2yqPuF3qijRo69MqjihMq9lZ1JP7mcM8NzX41ZhJ9XepbZWVwQtj1vdXol1NB4sP8zQtcFJT+upe9j9iuRl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739843315; c=relaxed/simple;
	bh=OO7nrpSmAi383YTQ5W6eFOW6yskghpQp9xhTLohVSqg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f4WR4TRicbkJroFu2lIt0M6cSuppl76yRZN0MW36e1/j7dQsUvy9qYNqhX3oy0RbbDXvCFTH3ypqgiUR/GAyIfRP+Dou5vKeRmFNgS0Pj7u+faPigXkzYLdGVAawbFG4qTq803wI6QE5HmBdZgtdcYS2KWgTN4tgNBPptOu878M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwAnLAzf5rNnaJFxAw--.12994S2;
	Tue, 18 Feb 2025 09:48:15 +0800 (CST)
Received: from phytium.com.cn (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwDX3YnW5rNnzKMqAA--.56977S3;
	Tue, 18 Feb 2025 09:48:10 +0800 (CST)
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
Subject: [PATCH v3 0/1] cxl/pmem: debug invalid serial number data
Date: Tue, 18 Feb 2025 09:47:45 +0800
Message-Id: <20250218014746.166565-1-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwDX3YnW5rNnzKMqAA--.56977S3
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAFAWezlaEArQADsL
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7tr17CrykKry5CFWkZr4fXwb_yoW8Gry5pr
	Z3tFWxCF98GrW7Zw4xZr1rWF1YgF48Cr4rWry8J348Grn5Jr1SvrZaya9Fyay7GrW0kr4Y
	gryjvanxuF9ru3DanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

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

 drivers/cxl/pmem.c           | 8 ++++++++
 tools/testing/cxl/test/mem.c | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

-- 
2.34.1

