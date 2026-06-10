Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B370E176FB1
	for <linux-cxl@vger.kernel.org>; Wed, 10 Jun 2026 13:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781096604; cv=none; b=n2HjMU82jF2KlRWYhYBGOFF7/HKVnHuFWSM5tXgSspdR+//iQnS29g6Qx64gtcZdzEQDy+k89+ijC+Tp8hW2LLdzS0Y1EzC7JaefX07E0WnCZgX2PU76LlFnLWdFprXQbnUndBTWYUfvi1sYIK4i9vudUmpKG3pvXaltCTiR7+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781096604; c=relaxed/simple;
	bh=N+CtByy1wqDSnoOp8HTnH8h/ihZxBj0faKna5dktqow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MlnMFFlMIdMu/yhy9uGlmx2Mea8M23tn2JeGrtWySK166+NMPgz7iITYjmaRCD2THNQX1mrG5ligxiOwxLYONISvRQxV1mwgSZSqKtbdUsUJhEJh+UdTvDEptW/728G4mtERo6i1QrbIi6gKgUN0ObF7Mdb6gHoYhoeekUgYv1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GzYMKc4/; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GzYMKc4/"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781096600; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=NZ4BHM1yjrt16IQRj2LtjsWfvfTTrCOqekiJi6pkNgg=;
	b=GzYMKc4/UXVHH6NfgNLjT3u+YL37BYl2FoYxqDPaYQPKeqeqLjcPWH3YAI1Et7PZ7g+pJOJDvG6Tpzl9EHzGWc3GJVRA4uJBm3usg2FnbnInjLoSNJTaIP/unLOAAhejmvDzoklK8roc2XeNUrEMGvZleR0jfYCD8EVa4yyYSQc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0X4ajruV_1781096595;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0X4ajruV_1781096595 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 10 Jun 2026 21:03:19 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: jic23@kernel.org
Cc: alistair.francis@wdc.com,
	chao.liu.zevorn@gmail.com,
	cp0613@linux.alibaba.com,
	daniel.barboza@oss.qualcomm.com,
	guoren@kernel.org,
	linux-cxl@vger.kernel.org,
	liwei1518@gmail.com,
	palmer@dabbelt.com,
	pbonzini@redhat.com,
	qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org,
	sunilvl@ventanamicro.com,
	zhiwei_liu@linux.alibaba.com
Subject: Re: [PATCH 4/4] hw/cxl: Map committed HDM decoder ranges as RAM for direct DMA
Date: Wed, 10 Jun 2026 21:03:15 +0800
Message-ID: <20260610130315.134515-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609133634.7dbb892c@jic23-huawei>
References: <20260609133634.7dbb892c@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 9 Jun 2026 13:56:11 +0100, Jonathan Cameron <jic23@kernel.org> wrote:

Hi Jonathan,

> +CC linux-cxl as that's where you are more likely to get feedback on 
> CXL aspects.
> 
> For this one there is a more comprehensive solution that restricts this
> to the cases that are valid (no interleaving going on).
> https://lore.kernel.org/qemu-devel/20260318171918.146-1-alireza.sanaee@huawei.com/#t
> It is rather more complex as a result.
> 
> For other cases we have always intentionally left it as not supporting
> what you have here because we want the interleave to be correct and testable.
> 
> As far as I'm concerned that series of Alireza's has been ready to merge for
> a while. I've been a bit busy with other things so haven't been poking
> for that though.  Might be a week or two before I get back on top of things.
> 
> Anyhow, please give Ali's series a go and see if that works for you.
> There may well be other corners we haven't thought of!

Thanks for pointing out Alireza's series.

I'll test Alireza's series against the RISC-V virt machine with the
same CXL + daxctl + virtio DMA workflow. If it resolves the issue,
I'll drop this patch from v2 and just rebase patches 1-3.

I'll report back once I've tested.

Best,
Pei
