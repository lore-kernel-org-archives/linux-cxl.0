Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE344685
	for <linux-cxl@vger.kernel.org>; Fri, 30 May 2025 10:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748601236; cv=none; b=cQ7bwB2P7dEaC/opLWGnU2Blh794CqwHQnj0NQBIjZPmeFueouP12NQqhcnn1zMZDUn1Ybs0mBP9tgNNvOQFaeYmTzTvGmdsE34Ni6pGXT4IdIEXBEAQ357A4kmxDYecHwgXNtHtCuO+wjHqcTYOK9XCInY4l1bN2VnEA40+g/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748601236; c=relaxed/simple;
	bh=HKsCIZazk6eWGbpyOCCF0pZ78PtZb7poTtXzei6A+co=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PwaZB/P3T2Q7eLjCLRMn5OMj4SCAhRzSJj49bQrY3oH/nIxJNWvzYuV4zltWEvvbMa3kSWjlrKal9ezulMFKQQK8kRBQw/xrY+NqySzIh/nCxnMe0T5skR6UCb9olN6r8vPyYS3XdGajoWyBaahtYDTcRCVrI7WlZ8FK2S71w1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwCnp2OBiTloKGIMDw--.1107S2;
	Fri, 30 May 2025 18:33:37 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
	by mail (Coremail) with SMTP id AQAAfwD3iyWAiTlo1VtFAA--.9604S3;
	Fri, 30 May 2025 18:33:36 +0800 (CST)
From: wangyuquan <wangyuquan1236@phytium.com.cn>
To: jonathan.cameron@huawei.com,
	fan.ni@samsung.com,
	mst@redhat.com,
	marcel.apfelbaum@gmail.com
Cc: chenbaozi@phytium.com.cn,
	qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org,
	wangyuquan <wangyuquan1236@phytium.com.cn>
Subject: [RFC PATCH v2 0/2] cxl: Support creation of a new CXL Host Bridge
Date: Fri, 30 May 2025 18:33:18 +0800
Message-Id: <20250530103320.534173-1-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwD3iyWAiTlo1VtFAA--.9604S3
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAGAWg4uXAE3gAFsA
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7tw15AF47XF15tF1Uury8Krg_yoW8AFWUp3
	WqgryfAr4kKry2ya1fA3y7JF4rArs5Wa15CF1xuw10yryUtF4DJrn7Ca1YvFyUCayUZr13
	J3Z8JF1kW3WUZFJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

v1 -> v2:
- Move the code of new bridge to hw/pci-host/cxl.c
- Fix and simplify some logic on handling the different bridge types

Background
==========
Currently the base CXL support for arm platforms is only on Jonathan's
patches[1]. Some platform like SBSA-REF can be more like a real machine,
thus the support of cxl could be meaningful. However, the pxb-cxl-host
realization on this platform seems not satisfying their requirements[2].

New CXL HOST design
===================
This work defines a new cxl host bridge type (TYPE_CXL_HOST). This
could be considered as a prototype of an independent cxl host bridge
which combines gpex features (ecam, mmio windows & irq) and CXL features.

The root bus path of CXL_HOST is "0001:00", that would not affect the
original pcie host topology. In the previous, the pxb-cxl-host with
any cxl root ports and cxl endpoint devices would occupy the BDF
number of the original pcie domain. This new type provide a solution
to resolve the problem.

Remaining problems
==================
I tried to use 'object_resolve_path' but it could not work in
'cxl_fmws_link_targets', so I used 'TYPE_DEVICE' to match that.

Yuquan Wang (2):
  hw/pxb-cxl: Rename the pxb cxl host bridge
  pci-host/cxl: Support creation of a new CXL Host Bridge

 hw/cxl/cxl-host-stubs.c               |   2 +
 hw/cxl/cxl-host.c                     |  66 +++++++++---
 hw/pci-bridge/pci_expander_bridge.c   |   8 +-
 hw/pci-host/cxl.c                     | 145 ++++++++++++++++++++++++++
 hw/pci-host/meson.build               |   1 +
 include/hw/cxl/cxl.h                  |   7 +-
 include/hw/cxl/cxl_host.h             |   2 +
 include/hw/pci-host/cxl_host_bridge.h |  25 +++++
 8 files changed, 234 insertions(+), 22 deletions(-)
 create mode 100644 hw/pci-host/cxl.c
 create mode 100644 include/hw/pci-host/cxl_host_bridge.h

-- 
2.34.1

