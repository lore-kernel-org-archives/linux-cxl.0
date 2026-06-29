Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7D73F871E
	for <linux-cxl@vger.kernel.org>; Mon, 29 Jun 2026 09:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782724100; cv=none; b=oiD5Eq6jvB15lX3pgITEBAItvK0A492ahhu7WiuUW8yiXcfBrr+duyCI8bvazpKXvxMVyUth6EzqX50mmLG4zIkBkYjvxOgsLGtcFH4p3ddr/G4w1LUryHfkGc8b8cWJtjc1d/rszH/tZjNRG/HN80MPUj1kVe5e/f8RbQnOUyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782724100; c=relaxed/simple;
	bh=LzWebt2N38JwZEZ1JACS9HKeD9Fq9BQkWSIhuVBYvQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iH1LyhzcrbCOuccd9CT/hoaZ4KIPbmO8qrAxDSCrG/xYyNYxWZxbq9PijB/Z1Gjyn9X0Ib/hotnVnvNQ530k8m6AxzB/+HEZm5DSMH4RS7L8Ln4zpfP1lG9Y6e0P6vfeb9xQ/svamHDKLter6x0XUX22j+Mml8U1xsmqC66k04Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=VouXxjGg; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VouXxjGg"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782724095; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=sA9OP5Rc4bDJBSMnQRtXfrB+IycsWvdoBnf4BVsHUjM=;
	b=VouXxjGg3Ud7vXyH/i56x/s90Dlu3YmyvI6hoo1DiYm3TTqXqIRsRkjLNyDZ1gxG8wEMnSnc4VFThgv5F5ZQ9VLJtiH5SdCUl8hz71+1xk8njRh7HttKNWZcd+zkXyLsqBkWWng7Rp3Mn6cY31fvDybmdLhEd8ct9xGzgST4DlE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0X5qEOg5_1782724089;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0X5qEOg5_1782724089 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 29 Jun 2026 17:08:14 +0800
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
Subject: Re: [PATCH v2 1/4] hw/riscv/virt: Add CXL support to the RISC-V virt machine
Date: Mon, 29 Jun 2026 17:06:41 +0800
Message-ID: <20260629090654.70869-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <9279723a-b079-4749-b3a5-e6e7ecfd2121@oss.qualcomm.com>
References: <20260618093827.3507-1-cp0613@linux.alibaba.com> <20260618093827.3507-2-cp0613@linux.alibaba.com> <9279723a-b079-4749-b3a5-e6e7ecfd2121@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Daniel,

On 6/24/2026 1:42 PM, Daniel Henrique Barboza wrote:
> create_cxl_host_reg_region() is doing the same check:
>
>     if (!s->cxl_devices_state.is_enabled) {
>     (...)
>
> Maybe we could squash these update_mmio() lines in the same helper to have
> everything CXL related in the same place.  The helper would need to be
> renamed to something more appropriate (e.g. cxl_host_state_init() since we're
> at init time).

Thanks for the review. You are right, the x86 pc_memory_init() path keeps
the CXL host register region creation and the FMW address programming
inside a single 'if (is_enabled)' block, and there is no reason for
RISC-V to split them. I'll fold the cxl_fmws_set_memmap() and
cxl_fmws_update_mmio() calls into create_cxl_host_reg_region(), rename
the helper to cxl_host_state_init(), and drop the duplicate guard in
virt_machine_init() in v3.

Thanks,
Pei
