Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D192264B0
	for <linux-cxl@vger.kernel.org>; Fri,  6 Mar 2026 09:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772787684; cv=none; b=HKuEj32gRHbDMlbC7Y0nXRMDkriL8OObMoq6kAZ0/lpMBLXJywsfwzOCKdSwY5GKQK/7ffVVx5HmQ0J4FA39brpiy3YNGA6G5lc8+KMez5ggF4XTcyjHFZEFaCBY+AHnbj9WiAd94MLmLUpgZcYwfSqDKatrOqtnXc12nB3trAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772787684; c=relaxed/simple;
	bh=1hd+7sDd/6SR2tgJnTn6VpxdbL3hmM3vk2N4XtD3RnI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rgISbgRVXm9IpRLoV+Q6xG6Ijd0InwFFrECS275L3NPVsfivJIUhj+yUGZGtxZioarZ4fQKq67cMLrl02b6JZFZyDW6EOoxl5Wtu1WUoPgV0wpdVWbVkS/329tN+xj/0Bs/OrlRt7mQJDHp8KnM4gvRQJe/2nI0XjNw2ddf+nNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fS0jc0YMMzHnGdH;
	Fri,  6 Mar 2026 17:00:20 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 7132440584;
	Fri,  6 Mar 2026 17:01:19 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 6 Mar
 2026 09:01:18 +0000
Date: Fri, 6 Mar 2026 09:01:17 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <shiju.jose@huawei.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, <mst@redhat.com>,
	<peter.maydell@linaro.org>, <dave@stgolabs.net>, <linuxarm@huawei.com>
Subject: Re: [PATCH 2/3] hw/cxl: Add fixes in Post Package Repair (PPR)
Message-ID: <20260306090117.00001a24@huawei.com>
In-Reply-To: <20260227223207.972-3-shiju.jose@huawei.com>
References: <20260227223207.972-1-shiju.jose@huawei.com>
	<20260227223207.972-3-shiju.jose@huawei.com>
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
 dubpeml500005.china.huawei.com (7.214.145.207)

On Fri, 27 Feb 2026 22:32:05 +0000
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
As for other two patches, try to indicate what sort of bug it is in the title.
Something like:
hw/cxl: Fix failure to remove repaired cachelines from 
> Add following fixes to the commit: hw/cxl: Add support for Maintenance
> command and Post Package Repair (PPR).
> 
> In cxl_perform_ppr(), remove and free the maintenance entry from QLIST
> if match is found and PPR operation is performed.

Needs a fixes tag.

> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 9c99422cd4..66a58396ee 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -2068,6 +2068,8 @@ static void cxl_perform_ppr(CXLType3Dev *ct3d, uint64_t dpa)
>                                  CXL_MEMDEV_MAINT_SUBCLASS_CACHELINE_SPARING,
>                                  ent, NULL);
>              }
> +            QLIST_REMOVE(ent, node);
> +            g_free(ent);
>              break;
>          }
>      }

