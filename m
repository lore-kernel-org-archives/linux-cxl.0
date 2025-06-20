Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEE8290D85
	for <linux-cxl@vger.kernel.org>; Fri, 20 Jun 2025 14:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750429023; cv=none; b=ek0XKfg9Sz0VpIL4tKr7zupqzNs0bGzavw+RUgRiRpKM2A9ULC+m4GA6lbnYUvtnGNjSOGCQQKqp33mkRY7My0Q18gRHANvd0QY+SBzVPy5wDNPj4HKPtlI/Uuw3i8L4420aK7T+AuLyvrYuLEZlVnNQH/m5VkSXpVA+y9AEVm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750429023; c=relaxed/simple;
	bh=q/2HPImVNbaAvNthgpA9e3iA84n/sj5vuc79upALPBE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GdGbRFGpz/SG+XGdiw8c45mOoNGXPiEcxPiEwIUQ8SW8rWaraDrDLa4Yd/5CwtZgyhPPko+7hyq0JC+fCfa4dKcIJFcn/DxKDIus8QnPetFrxWtgi2pafBqVeRbC/pLH2uWDNYj4D480QwWlJ1OyKIHgB4JiC6ZXySA5ZrG3LEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bNzxp5Qt1z6L5cB;
	Fri, 20 Jun 2025 22:14:38 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 892DC140446;
	Fri, 20 Jun 2025 22:16:57 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 20 Jun
 2025 16:16:57 +0200
Date: Fri, 20 Jun 2025 15:16:55 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <shiju.jose@huawei.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH v2 5/7] hw/cxl/cxl-mailbox-utils: Move declaration of
 scrub and ECS feature attributes in cmd_features_set_feature()
Message-ID: <20250620151655.00001cea@huawei.com>
In-Reply-To: <20250619151619.1695-6-shiju.jose@huawei.com>
References: <20250619151619.1695-1-shiju.jose@huawei.com>
	<20250619151619.1695-6-shiju.jose@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 19 Jun 2025 16:16:17 +0100
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Move the declaration of scrub and ECS feature attributes in cmd_features_set_feature()
> to the local scope where they are used.
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

Local scope is fine, but I'm fairly sure that style wise these
files always use variable declarations at start of scope (except
for when g_auto_free is in use where it gets more complex).



> ---
>  hw/cxl/cxl-mailbox-utils.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 4d0c0b3edc..83668d7d93 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -1459,10 +1459,6 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
>                                             CXLCCI *cci)
>  {
>      CXLSetFeatureInHeader *hdr = (void *)payload_in;
> -    CXLMemPatrolScrubWriteAttrs *ps_write_attrs;
> -    CXLMemPatrolScrubSetFeature *ps_set_feature;
> -    CXLMemECSWriteAttrs *ecs_write_attrs;
> -    CXLMemECSSetFeature *ecs_set_feature;
>      CXLSetFeatureInfo *set_feat_info;
>      uint16_t bytes_to_copy = 0;
>      uint8_t data_transfer_flag;
> @@ -1508,8 +1504,9 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
>              return CXL_MBOX_UNSUPPORTED;
>          }
>  
> -        ps_set_feature = (void *)payload_in;
> -        ps_write_attrs = &ps_set_feature->feat_data;
> +        CXLMemPatrolScrubSetFeature *ps_set_feature = (void *)payload_in;
Move the declaration to start of scope.

You can do assignment there as well as I don't think we care if we cast them
to the wrong type as header version isn't what we think it should be.

> +        CXLMemPatrolScrubWriteAttrs *ps_write_attrs =
> +                                &ps_set_feature->feat_data;
>  
>          if ((uint32_t)hdr->offset + bytes_to_copy >
>              sizeof(ct3d->patrol_scrub_wr_attrs)) {
> @@ -1535,8 +1532,8 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
>              return CXL_MBOX_UNSUPPORTED;
>          }
>  
> -        ecs_set_feature = (void *)payload_in;
> -        ecs_write_attrs = ecs_set_feature->feat_data;
> +        CXLMemECSSetFeature *ecs_set_feature = (void *)payload_in;
> +        CXLMemECSWriteAttrs *ecs_write_attrs = ecs_set_feature->feat_data;
>  
>          if ((uint32_t)hdr->offset + bytes_to_copy >
>              sizeof(ct3d->ecs_wr_attrs)) {

