Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AAE1DDC07
	for <linux-cxl@vger.kernel.org>; Thu, 17 Oct 2024 13:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729170531; cv=none; b=AGs+nzOyHzHyOhF/ZDlPF10v7xPNI/83G4voOxyfiit9+ALPrHtp69JigBgJ+hhbnCfvFW6dF/JvzQxp3366QRSMslHm+Clexavfu3OPH6vlQRIff5h2PKJyuMuO9HDJp9IYPxpgjVP3kAldnK4NB9bhCpu32jtSOM3Q4GICXJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729170531; c=relaxed/simple;
	bh=Ec/cergO07Wd2PRsNvlnEq57LqoJSo+hAKsHrsTc8Ck=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BCUDPc+igfQ34nQ1pURG/sAUzquQUjzSNjhymWHdko6DgL8b/6AX8HYSKAIdmoPX8V/oeeUbK+3lqIoTKERqCD1yNb8oAYEh4tpEbl4A85+6X3NafZHVQNbDcuLMHm5KWa1Zx3MFEjApR3FwBP7xF8wbjNew1w6kv83kAvWwDVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XTp6X4BSXz6JBT8;
	Thu, 17 Oct 2024 21:08:04 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id DBD3B140119;
	Thu, 17 Oct 2024 21:08:44 +0800 (CST)
Received: from localhost (10.122.19.247) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 17 Oct
 2024 15:08:44 +0200
Date: Thu, 17 Oct 2024 14:08:43 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>,
	<a.manzanares@samsung.com>, <dave@stgolabs.net>, <nmtadam.samsung@gmail.com>,
	Fan Ni <fan.ni@samsung.com>
Subject: Re: [QEMU PATCH] hw/cxl/cxl-mailbox-util: Fix output buffer index
 update when retrieving DC extents
Message-ID: <20241017140843.00004685@huawei.com>
In-Reply-To: <20241015190224.251293-1-nifan.cxl@gmail.com>
References: <20241015190224.251293-1-nifan.cxl@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 15 Oct 2024 11:51:26 -0700
nifan.cxl@gmail.com wrote:

> From: Fan Ni <fan.ni@samsung.com>
> 
> In the function of retrieving DC extents (cmd_dcd_get_dyn_cap_ext_list),
> the output buffer index was not correctly updated while iterating the
> extent list on the device, leaving the extents returned incorrect except for
> the first one.
> 
> Fixes: 1c9221f19e ("hw/mem/cxl_type3: Add DC extent list representative ...")
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
I'll queue this up alongside that other fix.

thanks,

Jonathan
p.s. I'm having some issues with the list servers bouncing my emails so this
may not reach the list.

> ---
>  hw/cxl/cxl-mailbox-utils.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index c82ad50ac8..58f8930272 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -2233,6 +2233,7 @@ static CXLRetCode cmd_dcd_get_dyn_cap_ext_list(const struct cxl_cmd *cmd,
>              stw_le_p(&out_rec->shared_seq, ent->shared_seq);
>  
>              record_done++;
> +            out_rec++;
>              if (record_done == record_count) {
>                  break;
>              }

