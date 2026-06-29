Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580F93B42F2
	for <linux-cxl@vger.kernel.org>; Mon, 29 Jun 2026 09:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782724231; cv=none; b=eQbSkdrMFOuEcYBL2FJLKInUaAAgja2UOsGVQqWnNn11nM3sSxMBFiP+qY4iFKIA71NafRVcltc9yQx57yR3RR6Ug6vqNmWkYL4yzkvDoessxb3XJpHfRrQY/mXaNVF7H81w1zVUKByN3L6wLCBvawrpWcv28Gpl0p89eYf0fbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782724231; c=relaxed/simple;
	bh=cWSTOqfNKFUiiCcPmBA38s9HF/7AxHSB7v6e87yRM0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rmQOujKz0UfADQCnfJNCizLnLqtBanBkmUFMixIYceA8kwWYfcivxMiXmhQ1l072wUsM1Ljjyx+7WyYovkHp1wSoo3x/EtQPVU7lwvIQ4AiJ0Hg2URWu/34JZUOnqvoDDK5EIEixY2/NCD9TwiY05/DzNI+zDpHh2TVL5syxJNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fXPUczre; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fXPUczre"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782724226; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=cWSTOqfNKFUiiCcPmBA38s9HF/7AxHSB7v6e87yRM0Q=;
	b=fXPUczreWQmI7lNDtECCbvecftnG/FgPuRNKbhnu3NektzmEN/L5lfO3QKjSGICYSza2FnrV5Yx/R6rA0CUV5oGigq/RscIrJN7dBDRTkaf4A1io88xsgVALa/ZUr8nKtiYnfbmEj8aLIf9C0gDXeHpZZ9QTqI0GTK1BMqjIXmw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R441e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0X5qxXep_1782724221;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0X5qxXep_1782724221 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 29 Jun 2026 17:10:25 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: jic23@kernel.org,
	pbonzini@redhat.com,
	palmer@dabbelt.com,
	alistair.francis@wdc.com,
	liwei1518@gmail.com,
	zhiwei_liu@linux.alibaba.com,
	chao.liu.zevorn@gmail.com,
	sunilvl@ventanamicro.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	imammedo@redhat.com,
	mst@redhat.com,
	guoren@kernel.org,
	qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 3/4] hw/riscv/virt,gpex: Provide 32-bit MMIO window for CXL host bridges
Date: Mon, 29 Jun 2026 17:10:17 +0800
Message-ID: <20260629091019.71770-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <79017627-4888-415a-9686-16367490b5b5@oss.qualcomm.com>
References: <20260618093827.3507-1-cp0613@linux.alibaba.com> <20260618093827.3507-4-cp0613@linux.alibaba.com> <79017627-4888-415a-9686-16367490b5b5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Daniel,

On 6/24/2026 2:21 PM, Daniel Henrique Barboza wrote:
> We can get rid of the braces - it's just adding an extra identation level while
> not doing anything special. 'mmio32_size' can be declared at the start
> of create_fdt_pcie().

Makes sense. I'll move mmio32_size to the top of create_fdt_pcie() and
remove the extra braces in v3.

Thanks,
Pei
