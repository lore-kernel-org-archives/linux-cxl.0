Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7158306B3B
	for <linux-cxl@vger.kernel.org>; Fri,  5 Sep 2025 14:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757084103; cv=none; b=exiFG/B6OA16OvlGTfIav+R8X+NpkUPcEqFc2y26KavDQvTu3vei9s0o47/L1l97uda/O1+VLa7h2bmHLW5u7dRwFNomhl47ISO0iFi1NRJ9HmV5SQ+3YF8uC5esNHVYlA7Q1fCuzgWe6j75j5R2Ebjv2Msf1lY+iP50MCHm9sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757084103; c=relaxed/simple;
	bh=VijRTpSz96DdO9p387BHURhF5zSZx/J5sHg3+uh56VY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JxgUi7dlfXp77qyVa8jqI7p2gxqa/l7Z8KBYnDdJJnDLxEFKVusi2mAuy/FUfCug1G/FC1NOUiGAoJORE1CvdnzXuUORf9Ni3FRRRGtUO9Z5XQ4+4//mWe6GW9DslUKcri7JNgeUitSdhOlTjZRrdSxaV4ves1uJj16xjTBqqxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cJK9f4WPqz6L4vc;
	Fri,  5 Sep 2025 22:53:58 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A3245140373;
	Fri,  5 Sep 2025 22:54:57 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 5 Sep
 2025 16:54:57 +0200
Date: Fri, 5 Sep 2025 15:54:56 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Joshua Lant <joshualant@googlemail.com>
CC: <linux-cxl@vger.kernel.org>, Joshua Lant <joshualant@gmail.com>
Subject: Re: [QEMU- PATCH 1/1] cxl_type3: fix segfault in
 cxl_destroy_dc_regions
Message-ID: <20250905155456.00005f7f@huawei.com>
In-Reply-To: <20250904090346.884649-2-joshualant@gmail.com>
References: <20250904090346.884649-1-joshualant@gmail.com>
	<20250904090346.884649-2-joshualant@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu,  4 Sep 2025 10:02:22 +0100
Joshua Lant <joshualant@googlemail.com> wrote:

> CXL_TYPE3_CLASS() should be CXL_TYPE3_GET_CLASS() given object (CXLType3Dev)
> input. Leads to segfault in object_class_dynamic_cast.
> 
> Fixes: ef730035567
> 
> signed-off-by: Joshua Lant <joshualant@gmail.com>

Good find.

The Fixes tag needs fixing though.
Should be all part of the tags block and needs to include the patch name.
I'm not finding the SHA though.

I think that tag is probably Svetley's MHD callback patch which isn't upstream
so I'll squash this in my local tree and it will be fixed in the next tree
I put up on gitlab.com/jic23/

Thanks,

Jonathan




> ---
>  hw/mem/cxl_type3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index c4658e0955..14cb09d9fe 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -919,7 +919,7 @@ static void cxl_destroy_dc_regions(CXLType3Dev *ct3d)
>  {
>      CXLDCExtent *ent, *ent_next;
>      CXLDCExtentGroup *group, *group_next;
> -    CXLType3Class *cvc = CXL_TYPE3_CLASS(ct3d);
> +    CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
>      int i;
>      CXLDCRegion *region;
>  

