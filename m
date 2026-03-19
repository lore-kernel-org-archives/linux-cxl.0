Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725BF30E0FB
	for <linux-cxl@vger.kernel.org>; Thu, 19 Mar 2026 14:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773931858; cv=none; b=dHGn4nx/GPwR/TGcmJusWQWdGF0q9t6d1Hj2Z6HlNA86g9GlwzRh8ZoAdgMJy2VIqMSNLqlMSKQpREr/q7F9HVWcri9iYMt6r9Zibl7k0Pp9fhfYjr7burSDpbKbSzx/OSVM0sAhsHJP7C1W550m2/oBoFzfHxwQd7bQqg2cD08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773931858; c=relaxed/simple;
	bh=/1PUZz1fOKSJlFnq7X8L5m922K2ih7083EmVIjXp/9Q=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dFLIRYRC83K9K0DOGs0AB4juxrk5CQu217F8K3tTy+hAb73L6pr0r185DvJrgoZQ7ylSGGIEhgx6C0cv+wQ5sKfqh5u7Lon5TNSKWnc4rIEsayvrrFQUO7E4+B3Onbp1iip3r8XccxrLLgdUOWZimf6rVcndBiijOtc6eQvyJXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fc7sc2JvZzHnGkK;
	Thu, 19 Mar 2026 22:50:28 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 01B574056B;
	Thu, 19 Mar 2026 22:50:52 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 19 Mar
 2026 14:50:51 +0000
Date: Thu, 19 Mar 2026 14:50:50 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/2] hw/cxl: Respect Media Operation max ops discovery
 semantics
Message-ID: <20260319145050.00002acf@huawei.com>
In-Reply-To: <20260318185508.3683044-2-dave@stgolabs.net>
References: <20260318185508.3683044-1-dave@stgolabs.net>
	<20260318185508.3683044-2-dave@stgolabs.net>
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

On Wed, 18 Mar 2026 11:55:07 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> The Discovery handler rejects requests where start_index + num_ops
> exceeds the total number of supported operations. Per CXL 4.0
> Table 8-332, num_ops is the "Maximum number of Media Operation to
> return" - a maximum, not an exact count. The device should return
> up to that many entries, not reject the request.
> 
> Cap num_ops to the available entries from start_index instead of
> erroring the command.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
One trivial thing inline.

> ---
>  hw/cxl/cxl-mailbox-utils.c | 25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index a3143f3faa23..71a012121c87 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -2593,6 +2593,7 @@ static CXLRetCode media_operations_discovery(uint8_t *payload_in,
>      } QEMU_PACKED *media_op_in_disc_pl = (void *)payload_in;
>      struct media_op_discovery_out_pl *media_out_pl =
>          (struct media_op_discovery_out_pl *)payload_out;
> +    int total = ARRAY_SIZE(media_op_matrix);
>      int num_ops, start_index, i;
>      int count = 0;
>  
> @@ -2609,24 +2610,20 @@ static CXLRetCode media_operations_discovery(uint8_t *payload_in,
>       * sub class command.
>       */
>      if (media_op_in_disc_pl->dpa_range_count ||
> -        start_index + num_ops > ARRAY_SIZE(media_op_matrix)) {
> +        start_index >= total) {
>          return CXL_MBOX_INVALID_INPUT;
>      }
>  
>      media_out_pl->dpa_range_granularity = CXL_CACHE_LINE_SIZE;
> -    media_out_pl->total_supported_operations =
> -                                     ARRAY_SIZE(media_op_matrix);
> -    if (num_ops > 0) {
> -        for (i = start_index; i < start_index + num_ops; i++) {
> -            media_out_pl->entry[count].media_op_class =
> -                    media_op_matrix[i].media_op_class;
> -            media_out_pl->entry[count].media_op_subclass =
> -                        media_op_matrix[i].media_op_subclass;
> -            count++;
> -            if (count == num_ops) {
> -                break;
> -            }
> -        }
> +    media_out_pl->total_supported_operations = total;
> +
> +    num_ops = MIN(num_ops, total - start_index);
> +    for (i = 0; i < num_ops; i++) {
> +        media_out_pl->entry[count].media_op_class =
> +                media_op_matrix[start_index + i].media_op_class;
> +        media_out_pl->entry[count].media_op_subclass =
> +                    media_op_matrix[start_index + i].media_op_subclass;
Patch in general looks good, but the indenting here is a bit too creative
/ inconsistent.
        media_out_pl->entry[count].media_op_class =
                media_op_matrix[start_index + i].media_op_class;
        media_out_pl->entry[count].media_op_subclass =
                media_op_matrix[start_index + i].media_op_subclass;

or something along those lines.

> +        count++;
>      }
>  
>      media_out_pl->num_of_supported_operations = count;

