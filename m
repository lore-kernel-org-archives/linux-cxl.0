Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88B73EA97E
	for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 12:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788179235; cv=none; b=vDnFVd8Nek/4wD8f0Wr0+0H/LjFZkYZ5s6SJJvfoa0htOCvGxRSkXAHnCvPwI9ABVBwRQ6xl6O4/yjCKdz4IcJycnbzZo6FY1O7STJgDjqkxU+o3nULpioxn86CKFtXaNAudAiSHJr82l0yebx99IYFOZNlYz2UYPXB7qtcecOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788179235; c=relaxed/simple;
	bh=MfytZgrUoxi5w+GhXTszANgVF/RRSgRgxu/r5c0/kwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XRZdATPyzmHXt8bMRxYABLYqAFNLsJUW9YkE8VR97IgWMFLcJMu4r+SJWihoG2pRgFqQ/R2CfKHIJD+Fy0IEhbx5l9GPAnJW9pxct2SwamXpPT42IJcsc6JpgVq6nBH6sLL0qCcxt3kw5CKhxag2S9/U2qLOCAb93oqpQKS407M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Z+xBdN9I; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Z+xBdN9I"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788179230; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=MfytZgrUoxi5w+GhXTszANgVF/RRSgRgxu/r5c0/kwY=;
	b=Z+xBdN9IvO7Gg7W2H63dO34x3q/wM4iKp1L6Yk3SMMwdbVI6QeSVnGf+CAlGDtBklpBYnK1aUDuEtRxT3gExIvVGv4YtSzlHVAXMqGjbOn9fSnlhTao0Txku+MXjklNVgHSPJ6lIzKBg0ycY9OLlZtv9mmOUrm4eTVat3DAFCZM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R761e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0X9zRnOJ_1788179224;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0X9zRnOJ_1788179224 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 31 Aug 2026 20:27:08 +0800
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
Subject: Re: [PATCH v4 6/6] tests/qtest: Update RISC-V CXL ACPI golden master binaries
Date: Mon, 31 Aug 2026 20:27:01 +0800
Message-ID: <20260831092000.610001-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831063826.409086-1-junjie.cao@intel.com>
References: <20260828151317.815-1-cp0613@linux.alibaba.com> <20260828151317.815-7-cp0613@linux.alibaba.com> <20260831063826.409086-1-junjie.cao@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Junjie,

Thanks a lot for catching this and for the detailed analysis.

> A golden carrying the firmware's allocation is the same situation as
> the q35 CXL golden with SeaBIOS, it just has to come from the blob the
> test boots.

You are right, my mistake: the golden was generated against my local
edk2-stable202602 build used for the boot testing, not the in-tree
edk2-riscv-code.fd that the test boots.

I have regenerated DSDT.cxl with the in-tree firmware and it now
matches yours (same 6331 bytes, sha1
20608434d5b8c7e06d24a59e3a366cb23d1b0238).
I will update DSDT.cxl and the related details in the commit message
in v5.

Thanks,
Pei
