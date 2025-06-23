Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3130A5FDA7
	for <linux-cxl@vger.kernel.org>; Mon, 23 Jun 2025 14:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750690256; cv=none; b=Ei5Ik4RKQSUqzH5hl5En02qZzussX59rzRsuWrfbD5bwqjyTRM72tX2qTaLIy0Lkx/L1h5sl7iVTEXBWJEFeVSy00ijlur6YeCF9JkBVE/j6F9y/HBVJCW7NHxqoCrcDy9xlcNy1gHtTJCtzzjzhOOUad77JvIZCwwVE48/yUDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750690256; c=relaxed/simple;
	bh=hYdkLz9WCXBCyWDRY1ZzYF7zQyz2Q8fwPP9NTPs4sjE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p4P8iVZqZ9oRdaS5eie8TGv5liZ9W7JlyE9JjhWm/HIUjg10bntuDYKv0mzzYl4IxH/Ijo1+LFaSLKlBfQCNBy2Id1D36fDL5MR1oCbnWXaGkKEJfj4xvwrIJBUbEYl6GrYxYNxZZm08BSybXTuNAhbPLatpaVL3O67KKyMliwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bQrYN2cykz6HK2b;
	Mon, 23 Jun 2025 22:48:24 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 9B413140114;
	Mon, 23 Jun 2025 22:50:51 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 23 Jun
 2025 16:50:51 +0200
Date: Mon, 23 Jun 2025 15:50:49 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <jgroves@micron.com>, <ravis.opensrc@micron.com>,
	<fan.ni@samsung.com>, <anisa.su@samsung.com>, <a.manzanares@samsung.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 6/7] cxl/mbox: Shout upon async bgcmd race
Message-ID: <20250623155049.00006f14@huawei.com>
In-Reply-To: <20250617193611.564668-7-dave@stgolabs.net>
References: <20250617193611.564668-1-dave@stgolabs.net>
	<20250617193611.564668-7-dave@stgolabs.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 17 Jun 2025 12:36:10 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Make the condition a warning, as the mailbox will be corrupted
> on such cases, which may trigger harder to debug issues down the
> line when simply returning a common error.

This is a little confusing.  I assume it is meant to be impossible to hit
this race?
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/cxl/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 6ada0f502914..6404b01b64c9 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -326,7 +326,7 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_mailbox *cxl_mbox,
>  		    mbox_cmd->user) {
>  			int timeout;
>  
> -			if (mds->bg.opcode)
> +			if (WARN_ON_ONCE(mds->bg.opcode))
>  				return -EBUSY;
>  
>  			/* give first timeout a second */

