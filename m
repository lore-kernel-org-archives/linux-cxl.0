Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D14130A73
	for <linux-cxl@vger.kernel.org>; Fri, 30 Aug 2024 03:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724987790; cv=none; b=K5asJqt3BP64SvUlwUzaOQLjt+bOms0O4C20X4z3R2bXiCkXuTnpZG8G7sdkVqQzuinp67R+gRbeV+TRzXHZy/Q5VTaYVM5lBlhRR1LR3k16OWhktumdzDO1tcGBpAPxASD6yp3rRi1AxIzjaOGXp2sS5tzXNBkSrC2anF99hwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724987790; c=relaxed/simple;
	bh=6KBNMtmHpLZB62Ti/cGKeG1byM1V55bceSDHI6XEh94=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=l7Z1cx52TvlhDA8bdAEj0YjLL6GwS4LqbJckqR0LhLt47CvfPNs6TGJsJjmSGPno5jPJo7zpYzGTxFq45yQggF7QGXabfv+p6noBuHWZ1Eql+y0rPLrPUb7ZJUn1tWBAstC28QWMOmmos2kxJctzfcJJsAZU5zyLuKVqfPW0XcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwDn6iJ7OdFmiZ2AAg--.18366S2;
	Fri, 30 Aug 2024 11:16:11 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
	by mail (Coremail) with SMTP id AQAAfwAnVLRyOdFmhaMpAA--.16473S3;
	Fri, 30 Aug 2024 11:16:03 +0800 (CST)
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: Jonathan.Cameron@Huawei.com,
	ardb+tianocore@kernel.org,
	quic_llindhol@quicinc.com,
	peter.maydell@linaro.org
Cc: devel@edk2.groups.io,
	qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org,
	chenbaozi@phytium.com.cn,
	wangyinfeng@phytium.com.cn,
	shuyiqi@phytium.com.cn,
	Yuquan Wang <wangyuquan1236@phytium.com.cn>
Subject: [RFC PATCH edk2-platforms 0/2] add basic support for CXL on sbsa-ref
Date: Fri, 30 Aug 2024 11:15:43 +0800
Message-Id: <20240830031545.548789-1-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwAnVLRyOdFmhaMpAA--.16473S3
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQANAWbQ2MkCDAAAsk
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7Kr1DZFy8urWfuw4fWFWDCFg_yoW8Cw4UpF
	Wa93WYkFWUCryIkw4fGa4Fvr4rCa1fZr4DCrsFqw18ua43tFn8Xr4ftF1xtF13JF93W39r
	WF18t34rCa1F93DanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

RFC because
- Many contents are ported from Jonathan' patch on qemu virt design

- Bring plenty of PCDs values and modifying the original PCIE values

- Less experience and not particularly confident in ACPI area so this might be
  stupidly broken in a way I've not considered.

This series leverages Jonathan's patches[1] to add acpi0016 & acpi0017 objects into the
previous DSDT table of sbsa-ref. Since the acpi0016 implementation model on qemu side is
the pxb-cxl, this cxl Bus would share the MMIO space and ECAM sapce of PCIE Bus. Thus I
divide some space from PciMmio32、PciMmio64、PciExpressBar to support cxl-related values.

Based on the new CEDT definitions patch on edk2[2], this series adds a static Cedt.aslc to
support the [SBSA_CXL_HOST] & [SBSA_CXL_FIXED_WINDOW] space on sbsa-ref.

Since I was first developing this platform design for cxl, at the initial stage I only reserved 
one cxl host bridge (Bus: 0000:fe) and a cxl root port underneath (fe:00.0), therefore, only one
cxl device(ff:00.0)could be added by user on this cxl Bus.

Link:
[1]: https://lore.kernel.org/linux-cxl/20220616141950.23374-2-Jonathan.Cameron@huawei.com/
[2]: https://edk2.groups.io/g/devel/topic/rfc_patch_0_1/108173029

Yuquan Wang (2):
  SbsaQemu: Add acpi0016 & acpi0017 objects into DSDT
  SbsaQemu: AcpiTables: Add CEDT Table

 Platform/Qemu/SbsaQemu/SbsaQemu.dsc           |  30 +-
 .../Qemu/SbsaQemu/AcpiTables/AcpiTables.inf   |  20 +-
 Silicon/Qemu/SbsaQemu/AcpiTables/Cedt.aslc    |  70 +++
 Silicon/Qemu/SbsaQemu/AcpiTables/Dsdt.asl     | 410 +++++++++++++++++-
 Silicon/Qemu/SbsaQemu/AcpiTables/Mcfg.aslc    |   2 +-
 .../SbsaQemuPciHostBridgeLib.c                |   4 +-
 .../SbsaQemuPciHostBridgeLib.inf              |   3 +
 Silicon/Qemu/SbsaQemu/SbsaQemu.dec            |  34 +-
 8 files changed, 555 insertions(+), 18 deletions(-)
 create mode 100644 Silicon/Qemu/SbsaQemu/AcpiTables/Cedt.aslc

-- 
2.34.1

