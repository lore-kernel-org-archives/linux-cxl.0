Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2954B13B29B;
	Thu, 13 Feb 2025 06:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739428851; cv=none; b=Ad3qoUqrpnI4gn+2CXtN5OWmYt0QbznOir8GavLnYP2M4Y2LJ7gmgWnzlH9wrybT7YJocoHWrOxvIZc1lkIzN42Sm38BjzxAxeY8O3bHo2H6OpAoeqTrTaUKYPFZs/fFIT/gWrYorPkZNps2t5ZenHtPcImmFwmwJZIToQViWKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739428851; c=relaxed/simple;
	bh=uiYq/m+D8YJ34U/ACDq/KTXk1GBAmHmULfGwBs63PK4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=huOuNgO9VkHVTwyf0vxfD2cYwEJdypA4cizbDZXULEHIE5SXhpr+ku63tYkZp4bXaJO6ERuyRPzhDmmAWTqiesav5TaN3ccQDpQbzquzMU9Zbk/ZN38bHnSnMD56H5tgLslTVg4FQIFCX6XT6P0o7tSxMnGIC6VNNnLZis4sQto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwAnrCzdk61nEyPDAg--.29670S2;
	Thu, 13 Feb 2025 14:40:29 +0800 (CST)
Received: from phytium.com.cn (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwDHyYXbk61ngoElAA--.9652S3;
	Thu, 13 Feb 2025 14:40:28 +0800 (CST)
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
	Yuquan Wang <wangyuquan1236@phytium.com.cn>
Subject: [PATCH 0/1] cxl/pmem: debug invalid serial number data
Date: Thu, 13 Feb 2025 14:40:07 +0800
Message-Id: <20250213064008.4032730-1-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwDHyYXbk61ngoElAA--.9652S3
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAAAWes-icCNQAAsl
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvdXoWrZr1rJw4UWw45KFyUZF1fZwb_yoWkXwb_ua
	yDuFWxZa4UWF1ftF43JrWrJr98Ar4xGr1xXrWjqw4kJw47JFZxua9F93ZI9F18ur4xGrn5
	Xr1aka4fZ3WSgjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrnU
	Uv73VFW2AGmfu7jjvjm3AaLaJ3UjIYCTnIWjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUU
	UUUU=

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

Yuquan Wang (1):
  cxl/pmem: debug invalid serial number data

 drivers/cxl/pmem.c | 7 +++++++
 1 file changed, 7 insertions(+)

-- 
2.34.1

