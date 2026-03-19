Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C613D6488
	for <linux-cxl@vger.kernel.org>; Thu, 19 Mar 2026 14:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773932062; cv=none; b=L+vO7c46b2xNE6a92KA6pVBIQNZD7KtgSpixGuTQ6JvjhT4S364nngQaHd2DSdFzFnFscovmFMtxWGE4RRKaZ2t6I0zADdth+ztko1O241enq71CFLy2fHzC6V9+AcFao1/54ql4DdgUpSp9HwJu0huYF2o7qY8QPxc6wERx3Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773932062; c=relaxed/simple;
	bh=6SJRZkHESI+qlxn9jhysemE+gHWREZ2mm3JvOq78S+4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fTMx7e8dBJHNvwJX0fICw1OPbIkW/lJ876G7nr/y/WY2RhPpwnCPDfr7ySZo/XqPoEu8/qpwUBeUcsjZA8uYNQfnZ3BSGhIe7cfGcCpcsmuH7CjXCB0QmBpaVILnjYe41i9jQbfRCmO0XawYjKBlDYfcjnrHpKVagWPxX+R23Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fc7xb3DMtzHnGks;
	Thu, 19 Mar 2026 22:53:55 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 225794056B;
	Thu, 19 Mar 2026 22:54:19 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 19 Mar
 2026 14:54:18 +0000
Date: Thu, 19 Mar 2026 14:54:17 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/2] hw/cxl: Exclude Discovery from Media Operation
 Discovery output
Message-ID: <20260319145417.00005bc1@huawei.com>
In-Reply-To: <20260318185508.3683044-3-dave@stgolabs.net>
References: <20260318185508.3683044-1-dave@stgolabs.net>
	<20260318185508.3683044-3-dave@stgolabs.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Wed, 18 Mar 2026 11:55:08 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Per CXL 4.0 Table 8-331, the Discovery operation "returns a list of
> all Media Operations that the device supports, with the exception of
> the Discovery operation (Class=0, Subclass=0)."
> 
> Filter out Discovery entries when building the output list and adjust
> total_supported_operations accordingly.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Both could do with a fixes tag.

> ---
>  hw/cxl/cxl-mailbox-utils.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 71a012121c87..6932db963788 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -2593,7 +2593,7 @@ static CXLRetCode media_operations_discovery(uint8_t *payload_in,
>      } QEMU_PACKED *media_op_in_disc_pl = (void *)payload_in;
>      struct media_op_discovery_out_pl *media_out_pl =
>          (struct media_op_discovery_out_pl *)payload_out;
> -    int total = ARRAY_SIZE(media_op_matrix);
> +    int total = ARRAY_SIZE(media_op_matrix) - 1; /* exclude Discovery */
>      int num_ops, start_index, i;
>      int count = 0;
>  
> @@ -2619,10 +2619,12 @@ static CXLRetCode media_operations_discovery(uint8_t *payload_in,
>  
>      num_ops = MIN(num_ops, total - start_index);
>      for (i = 0; i < num_ops; i++) {
> +        int idx = start_index + i + 1; /* skip Discovery (first entry) */
> +
>          media_out_pl->entry[count].media_op_class =
> -                media_op_matrix[start_index + i].media_op_class;
> +                media_op_matrix[idx].media_op_class;
>          media_out_pl->entry[count].media_op_subclass =
> -                    media_op_matrix[start_index + i].media_op_subclass;
> +                    media_op_matrix[idx].media_op_subclass;
Indent comment follows through.

Otherwise LGTM.

I'll queue it up locally but if you want to send a new version and with mst@redhat.com
in the to, given it's fixes and where we are in the cycle they may get picked up sooner.

If you do that, 
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com> 
for both patches

Whilst I don't think anything else I have queued touches this code, make sure
you base on upstream qemu.

Thanks,

Jonathan



>          count++;
>      }
>  

