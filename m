Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5778C15B13B
	for <linux-cxl@vger.kernel.org>; Mon, 14 Oct 2024 10:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728900742; cv=none; b=qQ3XAh4oWpjyTL+9cbGekDxnOWqaMjF3WPfN/a2ZKrFSJNtbdqDlQ8O7rtEnmbF48GCGroWLubQe6efmNeEUx1qmze1JRc4KfTOH9DSqNtYsUgTn1LW7/Lo8E2Bo50XVNrxrsXXQH/gjRu1Qg1b/FemcmvlOG63vSDQ3yOf4SUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728900742; c=relaxed/simple;
	bh=O7Veko7jVfUbDoMsjUPqNOV1uTiqBNL5CAKI2KNMHus=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RuT2xC1ODHgvwDPvtWcUGP9kWCSIkHtZ2VuGWI2dK/yQFGoBXmQi3tkhw/8C+13gHX4LxWJV/u9Cv9aRDiaewvW84cmwSY4FhMpN/pMcVzKeXW80PR1hnJnuIwTLNBvtRFo1oYLwFK/UdZQzs/KycEN5uW0k+gQ9raa5mRPCbYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XRtFy5V36z6L74Q;
	Mon, 14 Oct 2024 18:07:50 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id BC5C81400D9;
	Mon, 14 Oct 2024 18:12:17 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 14 Oct
 2024 12:12:17 +0200
Date: Mon, 14 Oct 2024 11:12:16 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <ajay.opensrc@micron.com>
CC: <mst@redhat.com>, <john@jagalactic.com>, <emirakhur@micron.com>,
	<ajayjoshi@micron.com>, <sthanneeru@micron.com>, <Ravis.OpenSrc@micron.com>,
	<arramesh@micron.com>, <dave@stgolabs.net>, <qemu-devel@nongnu.org>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v1] hw/cxl: Fix background completion percentage
 calculation
Message-ID: <20241014111216.000014c2@Huawei.com>
In-Reply-To: <20240914112021.2730383-1-ajay.opensrc@micron.com>
References: <20240914112021.2730383-1-ajay.opensrc@micron.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Sat, 14 Sep 2024 16:50:21 +0530
<ajay.opensrc@micron.com> wrote:

> From: Ajay Joshi <ajayjoshi@micron.com>
> 
> The current completion percentage calculation
> does not account for the relative time since
> the start of the background activity, this leads
> to showing incorrect start percentage vs what has
> actually been completed.
> 
> This patch calculates the percentage based on the actual
> elapsed time since the start of the operation.
> 
> Fixes: 221d2cfbdb ("hw/cxl/mbox: Add support for background operations")
> 
I'll include this is a fixes series I send to Michael + list later
today.  However for future reference, no line break between tags in
the tags block as it breaks some scripting.  I'll tidy that up.
Note I think you missed Michael's point about this on the first version.
+ as a second version, even without changes, this should have been v2.


Thanks

Jonathan

> Signed-off-by: Ajay Joshi <ajay.opensrc@micron.com>
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index c2ed251bb3..873d60c069 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -2708,7 +2708,8 @@ static void bg_timercb(void *opaque)
>          }
>      } else {
>          /* estimate only */
> -        cci->bg.complete_pct = 100 * now / total_time;
> +        cci->bg.complete_pct =
> +            100 * (now - cci->bg.starttime) / cci->bg.runtime;
>          timer_mod(cci->bg.timer, now + CXL_MBOX_BG_UPDATE_FREQ);
>      }
>  

