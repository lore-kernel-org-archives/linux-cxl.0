Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753F113790B
	for <linux-cxl@vger.kernel.org>; Thu, 27 Aug 2026 12:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787833500; cv=none; b=ils87+9Toh+xWcvoye3cnuM4RLFFZp1pJMJppvFcoNpmdt3CvUPZnI3DT3fLK9cGzQDh7B60RV+KPIjMSSA7+An0CC2T45p3FiC/PHSmwBFupyAsxeFsbYQ5zG4k0g22UKvo3wW2xfHezbCeMmCXoTbWGmqVEhy0IpU6r4yMSRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787833500; c=relaxed/simple;
	bh=WCbPIEwOPcxussZw4Alt7xkC/2nDApgu43DAVkuV/q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S5sTp86l6zq/O2XI6gdME8dSiNaiQp6JxTMdc3SgRMBwyJIYby0pI6NKWmwwO9rZuPiBgw3t61HXT71zYQmYSdigJbmcWQRx5LkURvQQHMr6QKh6W2wEw+UeHMgpSUPAqfHjCmy6giD8vlq4bxZkHByO8sNcRbtmsbfQHl+ITUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=yo6vYbus; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="yo6vYbus"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787833490; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=WCbPIEwOPcxussZw4Alt7xkC/2nDApgu43DAVkuV/q8=;
	b=yo6vYbusYQxvVEY8x7AZbaYSO8M7wwteqKAJLnZCJ+diFU9xuQqvLRB1IhM5pxFDRqRya6FHqh1MGsORX4dbey+QP8cyTT9+wAb0jRkJpK9RaTlWV5Ty3pwJx+kYRwuT0csBqWVgPy0Gjw6bIRXmtFvHbv2bpHgCD2Jernc22Ew=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0X9ji.BX_1787833482;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0X9ji.BX_1787833482 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 27 Aug 2026 20:24:48 +0800
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
Subject: Re: [PATCH 4/4] tests/qtest: Add RISC-V ACPI bios tables test for CXL
Date: Thu, 27 Aug 2026 20:24:39 +0800
Message-ID: <20260827201758.300003-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826133812.355470-1-junjie.cao@intel.com>
References: <20260821081954.1171-5-cp0613@linux.alibaba.com> <20260826133812.355470-1-junjie.cao@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Junjie,

Thanks for the reminder.

I will first work on 3/4 along the extra-pci-roots line (and the
end-to-end verification on a booting CXL guest), then regenerate the
golden tables and respin this patch accordingly.

Thanks,
Pei
