Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55DF2753FD;
	Fri, 14 Feb 2025 03:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739502642; cv=none; b=GpYH+l40BfbqqAswsIlx6j+RqfdUiisFFDxNeNufpZBSgolJHFroKWc95I7fH1RP+mh8OUWnee3/nBFobICIcEDgO9FQ/X9FzxMOAzzDZdKqGmsaTwYNCwgCxY4ERcy5OiFoHP7tOQsxQiQa1LELazFsm+C+EROh2utfTvf5zEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739502642; c=relaxed/simple;
	bh=oVbxAITTTA4lYG/fIcbZROvF34Vx3EHwgq/vUeOO4f0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DnJ18vvZbZU1r6SvqGREPp9yKpMnKv1RIU7xITVQ4V5p7tJytwiUHPrLXcXjqpt5XK73Ug1kyt1Skv0onsEiU0w4/g8w00akl8+O98AcFvTg8ZUTPS+HydNKC0qbuTEJWcax3eMKPgB6hybcSqXQXm5wzss+YRuI1X3NzlT+4lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwA3Hj4XtK5n_rK9Ag--.21686S2;
	Fri, 14 Feb 2025 11:10:15 +0800 (CST)
Received: from phytium.com.cn (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwA3PYkTtK5n+U4mAA--.10696S3;
	Fri, 14 Feb 2025 11:10:12 +0800 (CST)
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
Subject: [PATCH v2 0/1] cxl/pmem: debug invalid serial number data
Date: Fri, 14 Feb 2025 11:09:51 +0800
Message-Id: <20250214030952.4047438-1-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwA3PYkTtK5n+U4mAA--.10696S3
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAAAWes-icF6QAdsj
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7Wry7Xr13ZF43AFWrKF1rJFb_yoW8Gryxpr
	Z3tFWfCF98GrW7Zw1xZr1rWr1YqF18Cr4UGr18J348Krn5Jr1FvrZaya9Fya47GFW8Ar4Y
	gry0vanxZFy7u3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

Background
==========
In Qemu environment, the default serial number of cxl-type3 device
is UI64_NULL. But we could still use it to create a nvdimm pmem region
and set a non-zero cookie of nd_interleave_set, for example:
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

 drivers/cxl/pmem.c           | 7 +++++++
 tools/testing/cxl/test/mem.c | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

-- 
2.34.1

