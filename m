Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC604307A0
	for <linux-cxl@vger.kernel.org>; Thu, 27 Aug 2026 12:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787833068; cv=none; b=jJndWpvPkzsC5Gp8aX96Es1vc0Tm4Pr3gOrMZX7ekmA/CnZUci7WoIueH5qwYhyld3DKJsbc7CzpCvFYbz6IjSOCK0TkMKNx//ViomRQXwuD6sxHzog0ZQkZKpN+sO8TUJZy0Q0lZ8xKT6V7cIA0fGxGVZoPrBnf2EY1fcIMUZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787833068; c=relaxed/simple;
	bh=8DE8YWrYIhz1nyWrytlZP/KXEdy+Shl5A+B+FYzj0KQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r047jfgEItVtmy1CIPStaLkd6z2icSUKtHsHxfIRoy0RceMIKcfitN7M6GlC5ruTv3W7Gjm7+zaS8UuLPVfGpsA1aJa9Fo3vP6n+D6skpBavwAD5qDuiF/ig33m8j6Qewb2EB+9KrZ+Q9wSRk2JbK6lJ2U8bezjLttBJgAWYohs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=x2TxSLlk; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="x2TxSLlk"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787833058; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=8DE8YWrYIhz1nyWrytlZP/KXEdy+Shl5A+B+FYzj0KQ=;
	b=x2TxSLlkPRc3w6xOQpSTRj3NmBalI/+sJZWzHzFZeikHRAMKN80P5KNMH9IVtQ17SGyVtvc0QHMJIWvgzwPYIDly4XSVDZ9CmjHIIv0auFmceTKYYpy7iy89efgfVIVs7G8Wns7vsKWuJ/edM+PMHupmbnkDLeqDZEjbhnYwxb4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0X9jaGtO_1787833047;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0X9jaGtO_1787833047 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 27 Aug 2026 20:17:36 +0800
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
Date: Thu, 27 Aug 2026 20:17:24 +0800
Message-ID: <20260827193716.200002-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826133754.355453-1-junjie.cao@intel.com>
References: <20260821081954.1171-4-cp0613@linux.alibaba.com> <20260826133754.355453-1-junjie.cao@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Junjie,

Thanks a lot for the careful review, and especially for taking the time
to actually run this and trace the root cause rather than just pointing
at the symptom.

You are right, and I should correct my earlier judgement: I had convinced
myself the firmware had no way to learn about the expander bus, so I went
down the simulate-in-QEMU route. The real root cause sits one level up --
riscv virt simply never advertises the expander root bus to the firmware.

Thanks for the new direction and for the groundwork you have already done
along this line. That is clearly the better approach, and it matches the
"fix UEFI to perform required initialization" option Igor raised on v2.

I will rework 3/4 following your guidance. Before respinning, I will also
do the end-to-end verification you flagged as missing -- on a booting CXL
guest -- and I will sync back with you once I have the result.

Thanks again,
Pei
