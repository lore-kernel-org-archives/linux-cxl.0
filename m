Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB4E40DB40
	for <linux-cxl@vger.kernel.org>; Mon,  7 Sep 2026 06:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763712; cv=none; b=PH9iyVIEgQuMhHvDkd+PCF2cdDquYrlSOWCIOeSuPrdun/fe54UcIC0CseJFBJ7fzCiM+E8Qo19u+KLISWCLSqV6ykReHdQVumlrO+0b0bAeiHoO1yFBWsbW7nqLJ/P89DFoSlco60LI5V1AIvg9RUUDqoLXaZIY9iFLrXWGPYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763712; c=relaxed/simple;
	bh=RUHEqybby6EmQWI3hj728MG7xqtCE/bhq0ciqsSZO6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s1hb12Aqk+AjmPxviavUoRSik/hRzFB41mnip4StpMdzLTFhlDOYXv+sJWqHCuU5Lw3pmjQEfhR+XQSFSrjFkehO2ujzmeo8/J73OlnTeAWDnJma/D5RhLz7uM0b03ChSbUXYdHPEm58XUT241oQdO4Es2LxfkILcUp6ZwJ3vqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=h4t9VElC; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="h4t9VElC"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788763704; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=RUHEqybby6EmQWI3hj728MG7xqtCE/bhq0ciqsSZO6U=;
	b=h4t9VElCUzyUoRlYIteGbcfHYDhRmtWxC0tIeNRwxrKa/5sYzZHTA5259TCasZarPvPPL5XTFK+uOokF63zEQ43HY7vI2X8iFVJbLiOAkz8dZij151+vYmwx87dh8Be7vS7A3pu/BJVx5vYleKkj9kGMQcBegPD7nZ3dyILCyCw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0XAQ7hPo_1788763696;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0XAQ7hPo_1788763696 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 07 Sep 2026 14:48:22 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: palmer@dabbelt.com,
	alistair.francis@wdc.com,
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
	junjie.cao@intel.com,
	guoren@kernel.org,
	qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v5 0/6] hw/riscv/virt: Add CXL support to the RISC-V virt machine
Date: Mon,  7 Sep 2026 14:48:13 +0800
Message-ID: <20260908023000.620001-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904074710-mutt-send-email-mst@kernel.org>
References: <20260831132340.5345-1-cp0613@linux.alibaba.com> <20260904074710-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Michael,

> I am guessing this will be merged by riscv maintainers?
>
> acpi things
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

Yes -- the plan is for this series to go through the RISC-V tree.
Thanks for the Acked-by.

Thanks,
Pei
