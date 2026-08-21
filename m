Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCFB3812D2
	for <linux-cxl@vger.kernel.org>; Fri, 21 Aug 2026 08:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787301806; cv=none; b=S6DK5MlLy5mUkxooDm42Ysp4MmX0zq3W1U28kYFbqOVy8CNv9zbRdAnpnWsBhhrCZUwLTNQYIHZZurO/Ra6FAo7KtTtZ9szqxYY+R3Q1lem9vbGEqEpJLYO1zOZgnzIYKVThtv7RbL2kgUY0OBPp1uQ87YtyHq3swaiBs+Z02lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787301806; c=relaxed/simple;
	bh=ZeT4dhXCB/xmZfLkBDn9x+OiG3PNLplP01TyLhb4kM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ppCNf9vncSBbJ8XIFLY9ImyaWb1rF8jddNOFGaLrbeT8mtgkS9dsDb14kq9i3Q1nfXa0rzXUY6YkRrLu7qrIcajoNfKmRvADADxAA0FAoCI9LgvNM5cVtRvo2BjYXw/sbDSt7ZQAEFO0Iw0SvsHsnY3aAnd1G9PkjTv4rsCXLu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=MSOCkApv; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MSOCkApv"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787301802; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=b41w8VW63KRyFZO+qnBXe9Lo6XQR4ouNbjUjcLhUCOQ=;
	b=MSOCkApvPg/FrUhplCv7k0kVc75sPeUBDIjbP02uOZ28v6V240vJDxaVXMTfMJJUWAZuYaYJpctiE5VdrRJtgQ2FiyABkORLs7VtycpqQgS3zj4LIvGIow0RTwwnLVsk+dOJldHRcXRkTGPm5Xh4UDq5jVRzd7Hv3MHf/SMmjLU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R321e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0X9LqY0t_1787301797;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0X9LqY0t_1787301797 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 21 Aug 2026 16:43:21 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: palmer@dabbelt.com,
	alistair.francis@wdc.com,
	mst@redhat.com,
	imammedo@redhat.com,
	sunilvl@ventanamicro.com,
	jic23@kernel.org
Cc: pbonzini@redhat.com,
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
Subject: Re: [PATCH 0/4] hw/riscv/virt: Add CXL support to the RISC-V virt machine
Date: Fri, 21 Aug 2026 16:43:13 +0800
Message-ID: <20260821163922.100001-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821081954.1171-1-cp0613@linux.alibaba.com>
References: <20260821081954.1171-1-cp0613@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

Apologies, I forgot to add the version tag in the subject prefix.  This
is actually v3 of the series; the changelog against v2 and v1 is in the
cover letter.  Please ignore the missing "v3" tag for now -- it will be
tagged correctly in the next revision.

Sorry for the noise.

Thanks,
Pei
