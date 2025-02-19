Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE033FD4;
	Wed, 19 Feb 2025 04:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739937670; cv=none; b=VE/XmrbgJPlLyF/cLFG5YlMvMPmJzOBWOccVFdG3S2ezfBuuXstWBoJ4gsKpejKPTCixVWVi1CehdBW+1X+lU2o8cMUi1FL39XdzQHdDwt4w/7tNKlTe1Ka8aMBZeVtRg5PMRw9D6MVmGKlI2HYbe1tbeOJJRG4E5YyC1IieDTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739937670; c=relaxed/simple;
	bh=fk0S69OXoWGhCkwG1c3XSHDJpwDUlLpHP5pQ+wJ1u8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c6J3pfyF+6I4zYNH3C8ziQpAKcaKCgnFn3cT2ozI3kq7FTTlMzkEUsuBx9lbTJuo44vdaN2EgJQr5iZEFwbRDWVRpXrBLqS+3nSqmLSfOg8zSQvF6Up5P/d4jpadQgnyIqAiHYAs6FsMyv8HhhHzz51nTNKHR3TU8kxIn6XslQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwCXHC17V7Vnj+DgAw--.2846S2;
	Wed, 19 Feb 2025 12:00:59 +0800 (CST)
Received: from phytium.com.cn (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwCHjYl4V7VnvbsrAA--.18029S3;
	Wed, 19 Feb 2025 12:00:58 +0800 (CST)
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
Subject: [PATCH v5 0/1] cxl/pmem: debug invalid serial number data
Date: Wed, 19 Feb 2025 12:00:28 +0800
Message-Id: <20250219040029.515451-1-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwCHjYl4V7VnvbsrAA--.18029S3
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAGAWe0524BYAAAs9
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7CF17tw1xWryUCr4fAry7ZFb_yoW8WrW5pF
	Z3KFWfCF98GrW7Zw1xZw1rWF1Ygr48Cr1UGr18tw18Kr4kJr10vrWSya9Fya47GrWvyF4Y
	gryjvFsxuFy293DanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

v4 -> v5:
- Put the info[i].offset assignment after the info[i].serial

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

