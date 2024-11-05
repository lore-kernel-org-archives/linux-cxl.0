Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEC01D2B02
	for <linux-cxl@vger.kernel.org>; Tue,  5 Nov 2024 10:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730802972; cv=none; b=BuJuzdN/5mo4AOnMDDB1JuBABKQwwcAGt6g3k/E8Noy998+HDsFtwLtz/j30GKCcyOoqta+cl+ZNAqQGro/D6BiArF8MYVRKHIy1HehfTROlsdJw5sb28z93d1olVXZ9ZOp7MISIb5+ZOb8KzUut6D1OcsktZENI+oJ0zW9b+h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730802972; c=relaxed/simple;
	bh=UU4Put13JiaQTbdyjFnX8y5XEYl9SWRRebyywT49oSk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VHKQoKignDmfLtl9OYI/mmN70Le61oa6HVG1OwVXSEfVv/PNce/NcRBST3jrjZQIFPN6vR5e52HZrkbBZoP7acKw18Wzv7hPMemcbqi3CvoZTwgOVnpfP1k66KjSDoICOpa/Ir0Ezre83m67Fyumjcvn1tWgnUoN+T/sCslJLEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwDnTQ4F9SlnPMKHAw--.42989S2;
	Tue, 05 Nov 2024 18:35:49 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
	by mail (Coremail) with SMTP id AQAAfwCH3nr99ClnV4xHAA--.23012S3;
	Tue, 05 Nov 2024 18:35:42 +0800 (CST)
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: Jonathan.Cameron@Huawei.com,
	marcin.juszkiewicz@linaro.org,
	ardb+tianocore@kernel.org,
	quic_llindhol@quicinc.com,
	peter.maydell@linaro.org
Cc: chenbaozi@phytium.com.cn,
	devel@edk2.groups.io,
	linux-cxl@vger.kernel.org,
	asa-dev@op-lists.linaro.org,
	Yuquan Wang <wangyuquan1236@phytium.com.cn>
Subject: [RFC PATCH edk2-platforms v2 0/1] add basic support for CXL on sbsa-ref
Date: Tue,  5 Nov 2024 18:35:22 +0800
Message-Id: <20241105103523.415774-1-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwCH3nr99ClnV4xHAA--.23012S3
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAAAWcpJZAFfQAAsD
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7ArWxKFWxJrW8Zr47Cw17Wrg_yoW8CFWUpF
	WF9a13CFy5Ary2g393ua40vr4rC3WfZF48ursrXry8Wa43KF15Xrs7WFn2gF13Jrn3Ww4D
	Gr1kt34rAa1F93DanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

v1 -> v2:
- PCDs values about CXL exclusive MMIO32 & MMIO64 space
- CXL Bus range: 0xc0 ~ 0xff
- PCIE ecam space & Cxl ecam space
- CEDT format

RFC because
- Many contents are ported from Jonathan' patch on qemu virt design

- Bring plenty of PCDs values and modifying the original PCIE values

- Less experience and not particularly confident in ACPI area

This series leverages Jonathan's patches[1] to add acpi0016 & acpi0017 objects into the
previous DSDT table of sbsa-ref. Since the acpi0016 implementation model on qemu side is
the pxb-cxl, this cxl Bus would share ECAM sapce of PCIE Bus. Thus I divide some space
from Pcie Ecam to support cxl-related values.

To prevent breaking the original pcie mmio space, this adds exclusive mmio32 & mmio64
space for cxl host.

This defines the pcie bus range of cxl host is 0xc0 ~ 0xff, since the pxb-cxl-host as
well as cxl components on it would occupy the original pcie buses, the original pcie
ecam space should divided some range for pxb-cxl-host.

Based on the new CEDT definitions patch on edk2[2], this series adds a static Cedt.aslc to
support the [SBSA_CXL_HOST] & [SBSA_CXL_FIXED_WINDOW] space on sbsa-ref.

Link:
[1]: https://lore.kernel.org/linux-cxl/20220616141950.23374-2-Jonathan.Cameron@huawei.com/
[2]: https://edk2.groups.io/g/devel/topic/rfc_edk2_patch_v3_0_1/109403423#

Yuquan Wang (1):
  SbsaQemu: Support basic CXL enablement

 Platform/Qemu/SbsaQemu/SbsaQemu.dsc           |  23 +-
 .../Qemu/SbsaQemu/AcpiTables/AcpiTables.inf   |  19 +
 Silicon/Qemu/SbsaQemu/AcpiTables/Cedt.aslc    |  69 +++
 Silicon/Qemu/SbsaQemu/AcpiTables/Dsdt.asl     | 401 +++++++++++++++++-
 Silicon/Qemu/SbsaQemu/AcpiTables/Mcfg.aslc    |   2 +-
 Silicon/Qemu/SbsaQemu/SbsaQemu.dec            |  34 +-
 6 files changed, 537 insertions(+), 11 deletions(-)
 create mode 100644 Silicon/Qemu/SbsaQemu/AcpiTables/Cedt.aslc

-- 
2.34.1

