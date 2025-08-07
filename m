Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A5F27147C
	for <linux-cxl@vger.kernel.org>; Thu,  7 Aug 2025 10:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754564403; cv=none; b=BB6GG4BXcMaYd8xagwwqgwSBspNMNO8aQapUjUxeAIOjIMyJbpKVd0KaoyN9hd7CbOIy9SgHbshKvK52wMjbiF/33VJaVFq5Ufnnir7q3XboiYla3io28JkBF44BFSUOw3S9W+Rjh6k/74Z4wx8aZZvNfgA3ILlgyqzvNHVuWzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754564403; c=relaxed/simple;
	bh=Aa8rmdIrcFd9grSyxvL3lzUuXQtEnV29mr3kil7PogA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T70Kk4CU12OwrwY6GS3TTsv/WJN1xwSMwVrV6Q0wG/A/jL5iyG+1jjPK6kBn80683S0eR5xM9N2q3zD6kCK2H1ZQ1Bgk0/zbuN9d5OYIOVSypTiVePcvpNv7p8cec8DnHjEEUSTivz4UilCk7hEEvG/UeNbhZFGWILNvidcdlyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwAnvWAdh5Ro_T2ABA--.51317S2;
	Thu, 07 Aug 2025 18:59:41 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
	by mail (Coremail) with SMTP id AQAAfwDHTwcSh5RoT_kKAA--.12934S3;
	Thu, 07 Aug 2025 18:59:30 +0800 (CST)
From: wangyuquan <wangyuquan1236@phytium.com.cn>
To: jonathan.cameron@huawei.com,
	fan.ni@samsung.com,
	mst@redhat.com,
	marcel.apfelbaum@gmail.com,
	rad@semihalf.com,
	peter.maydell@linaro.org,
	leif.lindholm@oss.qualcomm.com,
	graf@amazon.com,
	claudio.fontana@huawei.com,
	philmd@linaro.org,
	richard.henderson@linaro.org
Cc: chenbaozi@phytium.com.cn,
	qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org,
	Yuquan Wang <wangyuquan1236@phytium.com.cn>
Subject: [RFC QEMU PATCH v4 0/2] cxl: Support creation of a new CXL Host Bridge
Date: Thu,  7 Aug 2025 18:59:08 +0800
Message-Id: <20250807105910.240070-1-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwDHTwcSh5RoT_kKAA--.12934S3
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAPAWiTrgAFhgAAsZ
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxGF4fuw1UCF4kCry5Xw48Xrb_yoW5Gr15pa
	1DKrWfCF4DKry3G3yfA3y7GF1rA395Ga15ur1xXw40yr92vF4DZrs7Ca1YvFyUWFWUCr18
	J3W7J3Z5W3W5Z37anT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

From: Yuquan Wang <wangyuquan1236@phytium.com.cn>

v3 -> v4:
- Simplify variable definitions (Jonathan)
- Fix some alignment and space problems (Jonathan)
- Include the header file for MemoryRegion (Jonathan)
- Rebased on 'Make the CXL fixed memory windows devices'
- Keep cxl_fixed_memory_window_config() static and remove its declaration in the header file
v2 -> v3:
- Update the commit message
- Fix some alignment and space problems
- Add a SPDX header for the new file
- Remove unnecessary comments
- Add CXL_HOST_BRIDGE config
v1 -> v2:
- Move the code of new bridge to hw/pci-host/cxl.c
- Fix and simplify some logic on handling the different bridge types

Background
==========
Currently the base CXL support for arm platforms is only on Jonathan's
patches[1]. Some platform like SBSA-REF can be more like a real machine,
thus the support of CXL could be meaningful. However, the pxb-cxl-host
realization on this platform seems not satisfying their requirements[2].

New CXL HOST design
===================
Defines a new CXL host bridge type (TYPE_CXL_HOST). This is an
independent CXL host bridge which combined GPEX features (ECAM, MMIO
windows and irq) and CXL Host Bridge Component Registers (CHBCR).

The root bus path of CXL_HOST is "0001:00", that would not affect the
original pcie host topology. In the previous, the pxb-cxl-host with
any CXL root ports and CXL endpoint devices would occupy the BDF
number of the original pcie domain. This new type provide a solution
to resolve the problem.

Remaining problems
==================
I tried to use 'object_resolve_path' but it could not work in
'cxl_fmws_link', so I used 'TYPE_DEVICE' to match that.

Reviewing
=========
Welcome more PCI folks to review this patch, thanks a lot!

Link:
[1]: https://lore.kernel.org/linux-cxl/20220616141950.23374-1-Jonathan.Cameron@huawei.com/
[2]: https://lists.nongnu.org/archive/html/qemu-arm/2024-11/msg00522.html

Yuquan Wang (2):
  pci-host/cxl: Support creation of a new CXL Host Bridge
  hw/pxb-cxl: Rename the pxb cxl host bridge

 hw/cxl/cxl-host.c                     |  56 +++++++---
 hw/pci-bridge/pci_expander_bridge.c   |   8 +-
 hw/pci-host/Kconfig                   |   4 +
 hw/pci-host/cxl.c                     | 146 ++++++++++++++++++++++++++
 hw/pci-host/meson.build               |   1 +
 include/hw/cxl/cxl.h                  |   7 +-
 include/hw/pci-host/cxl_host_bridge.h |  24 +++++
 7 files changed, 229 insertions(+), 17 deletions(-)
 create mode 100644 hw/pci-host/cxl.c
 create mode 100644 include/hw/pci-host/cxl_host_bridge.h

-- 
2.34.1

