Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F221E88D
	for <linux-cxl@vger.kernel.org>; Fri,  5 Apr 2024 12:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712320390; cv=none; b=e2eOccKP3UoNBCaIgffLlTZaF5l3VLYP82RZTAVXwtw0cvANb6rxv5mtmC7HUc1CjwTAI8L5JYjhX8pkdBQpZ8DIaxFAXQpz966VgTUAgsgHX4iwIqehjFYpgk6Dk9Zbk1WkO/Ie4rYSDUV8uKGF112o55SEm3cqWp/JVprJ++E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712320390; c=relaxed/simple;
	bh=9SHLr4kgdBMTltsDh28c2reyp4vOXIXBZvUbzko6A3M=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=unO9KKOGFoKB73aJnpt8wNwrlkNSDJ/jJUbk0mhme+JDElugVWVM3EhYSJKqyo+ajSNgndhL7rhyNKv992h8qxoayunnKwGO/+krbw9LJqly64TGUZQBK+xuLoLXGkttWNcvW52Dh47OUZPuLr8IMMtBIhOrYcXR5ElcY/a88ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V9yXZ1JLfz67kgS;
	Fri,  5 Apr 2024 20:31:42 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id C68741400D4;
	Fri,  5 Apr 2024 20:33:04 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 5 Apr
 2024 13:33:04 +0100
Date: Fri, 5 Apr 2024 13:33:03 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<gregory.price@memverge.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <a.manzanares@samsung.com>, <dave@stgolabs.net>,
	<nmtadam.samsung@gmail.com>, <jim.harris@samsung.com>,
	<Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v6 12/12] hw/mem/cxl_type3: Allow to release extent
 superset in QMP interface
Message-ID: <20240405133303.000003de@Huawei.com>
In-Reply-To: <20240325190339.696686-13-nifan.cxl@gmail.com>
References: <20240325190339.696686-1-nifan.cxl@gmail.com>
	<20240325190339.696686-13-nifan.cxl@gmail.com>
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
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 25 Mar 2024 12:02:30 -0700
nifan.cxl@gmail.com wrote:

> From: Fan Ni <fan.ni@samsung.com>
> 
> Before the change, the QMP interface used for add/release DC extents
> only allows to release an extent whose DPA range is contained by a single
> accepted extent in the device.
> 
> With the change, we relax the constraints.  As long as the DPA range of
> the extent is covered by accepted extents, we allow the release.
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>

Nice.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  hw/mem/cxl_type3.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 2628a6f50f..62c2022477 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1935,8 +1935,7 @@ static void qmp_cxl_process_dynamic_capacity(const char *path, CxlEventLog log,
>                             "cannot release extent with pending DPA range");
>                  return;
>              }
> -            if (!cxl_extents_contains_dpa_range(&dcd->dc.extents,
> -                                                dpa, len)) {
> +            if (!ct3_test_region_block_backed(dcd, dpa, len)) {
>                  error_setg(errp,
>                             "cannot release extent with non-existing DPA range");
>                  return;

