Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6912F37F74B
	for <linux-cxl@vger.kernel.org>; Fri, 28 Aug 2026 10:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787911544; cv=none; b=cHIZV7UsPCVZW58t3V/5F+v9nRSyepUsSQF/+VgmHxcp8hVm4++RB91QWawuqTlyfAJ1kyHM0G0dEpehzr79uyP84aA3TdiXPq45b2Ny85joqHBtFxJ8xBgTtpgeAdtnUagu7GujWmE8TVIsuL3Lv4817zd3y47KtSWF6O02tas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787911544; c=relaxed/simple;
	bh=cFx9Ux4XBvjTU5xB472uhCxv5y/5cwXhGH7RFgF4IV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZcXtmOSuOIE0wJ70eQEa1Ji933sWpaOJXuroYB6TxdpDxu5f8zx7MggzDwjOVC6a1DlHMRF843UETwwJ7Y2ALCIZDKge7QUQoNRMldGb8gyIfhWzE5gRhWk1CKEmykmgdy/y2lW6odIjbgM90asWEobf/jQBdgvd4FqguEU4WUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cpNQsLuO; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cpNQsLuO"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787911537; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=V/bY+2BGacHBQaSONjdxFGv1T988RUVBXyN1mtK2tK0=;
	b=cpNQsLuO5ibjL0wlcngZ9naIzEZeRm3gR3T35mpLSJ90St8WLx1odCg+rSC4Kbu2doqAmyoKUk2YWYHzEsG0rGEifqgQvQLoCozU9AJax4j79huuqv5pgJ16xqpLNDsZuADv7lz293U+/HiRpDuu0Kl0dGu3riCRbxeuxgoLZYg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R531e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0X9m7gsE_1787911520;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0X9m7gsE_1787911520 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 28 Aug 2026 18:05:35 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: Junjie Cao <junjie.cao@intel.com>
Cc: palmer@dabbelt.com,
	alistair.francis@wdc.com,
	mst@redhat.com,
	imammedo@redhat.com,
	sunilvl@ventanamicro.com,
	sunilvl@oss.qualcomm.com,
	jic23@kernel.org,
	pbonzini@redhat.com,
	liwei1518@gmail.com,
	daniel.barboza@oss.qualcomm.com,
	zhiwei_liu@linux.alibaba.com,
	chao.liu@processmission.com,
	anisinha@redhat.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	guoren@kernel.org,
	qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH 3/4] hw/riscv/virt: Provide a 32-bit MMIO window for CXL host bridges
Date: Fri, 28 Aug 2026 18:05:18 +0800
Message-ID: <20260828172602.300003-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827193716.200002-1-cp0613@linux.alibaba.com>
References: <20260821081954.1171-4-cp0613@linux.alibaba.com> <20260826133754.355453-1-junjie.cao@intel.com> <20260827193716.200002-1-cp0613@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Junjie,

Following up on my earlier note -- I have done the rework and the
end-to-end verification you flagged.

Reworked along the extra-pci-roots line: riscv virt now calls
pci_bus_add_fw_cfg_extra_pci_roots() to advertise the pxb-cxl expander
root bus, and EDK2's PciBusDxe enumerates behind it and assigns the
root-port window and bus numbers.  build_crs() then emits a correct
_CRS for the ACPI0016 host bridge.  The regenerated DSDT shows the
firmware-assigned window (DWordMemory 0x40400000-0x405FFFFF, a
QWordMemory, and WordBusNumber [0x0C-0x0D]), and as you noted it scales
to multiple pxb-cxl (each gets its own window from the shared aperture).

Verified end-to-end on a booting RVA22 guest:

  # cxl list                      -> mem0 (4 GiB), port1, root0
  # cxl enable-memdev mem0        -> enabled 1 mem
  # cxl create-region -d decoder0.0 -w 1 mem0 -> region0 committed
  # daxctl online-memory dax0.0   -> onlined memory for 1 device
  # free -h                       -> 3.8Gi -> 7.8Gi (+4 GiB)

I will send the respun series shortly.

Thanks again,
Pei
