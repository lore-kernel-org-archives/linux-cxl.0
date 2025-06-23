Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0739F72624
	for <linux-cxl@vger.kernel.org>; Mon, 23 Jun 2025 14:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750687548; cv=none; b=qQ/lfz7fxCVLM83mfMngxAinkb0PgaZEV6wZ4Jh+im/eGGlX9j7NlzDzZnsNYUwOr/xPc1mkAABXpMjMhcsF2t1Snhdmcee6lrI6imLLPFJVSzQjF9aoKIJ3FUW1jwgTylAHPFOODbnmIhngz7vKFwooRQyh3GsRjSjCRIgFNMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750687548; c=relaxed/simple;
	bh=RCNpfi87/i2G6eAA5z8nUNTWn4T1w8IurVhhz8t1K/E=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aaPHbA1X+SPuJWITruzKe4zpLFd8ejWAzRPMTuZm2VzGSPexI6IpdrfKM90TQ0CJmyYDIdL/jfEWBRvcd5DddoUw8Zz2s+ZqdWd5yZagkKGGkI/vqoG+Y8vVknXoJyUnSG+m4ckkleDBrRfRUHsEN75p9viFSdJPYUoHG1aqkWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bQqYH2fM4z6HK2Z;
	Mon, 23 Jun 2025 22:03:15 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 91FE41404FE;
	Mon, 23 Jun 2025 22:05:42 +0800 (CST)
Received: from localhost (10.122.19.247) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 23 Jun
 2025 16:05:42 +0200
Date: Mon, 23 Jun 2025 15:05:40 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <fan.ni@samsung.com>, <ravis.opensrc@micron.com>,
	<ajay.opensrc@micron.com>, <qemu-devel@nongnu.org>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH -qemu] hw/cxl: Use runtime for bg cmd running semantics
Message-ID: <20250623150540.00005450@huawei.com>
In-Reply-To: <20250617214832.579960-1-dave@stgolabs.net>
References: <20250617214832.579960-1-dave@stgolabs.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 17 Jun 2025 14:48:32 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> The current check incorrectly misses the 0% case, which semantically
> can either be not running or one that just started. The runtime
> is a better way to check for 0%, 100% or aborted. This is currently
> benign in the kernel equivalent without cancel support.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Looks good to me. I'll carry this on my local tree for now and combine
it with some other fixes to send to MST.

Probably push out a new cxl staging tree sometime in next few weeks.
> ---
> 
> Applies against 'cxl-2025-06-10' from jic23 tree.
> 
>  hw/cxl/cxl-device-utils.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
> index e150d7445762..add0ab615976 100644
> --- a/hw/cxl/cxl-device-utils.c
> +++ b/hw/cxl/cxl-device-utils.c
> @@ -95,13 +95,10 @@ static uint64_t mailbox_reg_read(void *opaque, hwaddr offset, unsigned size)
>          }
>          if (offset == A_CXL_DEV_MAILBOX_STS) {
>              uint64_t status_reg = cxl_dstate->mbox_reg_state64[offset / size];
> -            int bgop;
>  
>              qemu_mutex_lock(&cci->bg.lock);
> -            bgop = !(cci->bg.complete_pct == 100 || cci->bg.aborted);
> -
>              status_reg = FIELD_DP64(status_reg, CXL_DEV_MAILBOX_STS, BG_OP,
> -                                    bgop);
> +                                    !!cci->bg.runtime);
>              cxl_dstate->mbox_reg_state64[offset / size] = status_reg;
>              qemu_mutex_unlock(&cci->bg.lock);
>          }

