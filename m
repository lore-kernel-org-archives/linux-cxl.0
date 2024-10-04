Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AFC157484
	for <linux-cxl@vger.kernel.org>; Fri,  4 Oct 2024 11:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728042279; cv=none; b=LQFDF/FM/4P3Tw+LdC0TRhI6jNVHjsWQit6t8GMQAmnx2g4jWIlgyTFxxspQy9H06CYBV2mglv2LDsFt+I6sTsPa79iOKIgUDEW8VLccznR+p0e1zBA/uG43GCW/IeGA0B8jUChtZgQlMYBynJMmjvfJ+4L/z0icU7gjpm5QZN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728042279; c=relaxed/simple;
	bh=/lkWcFb8UntGN5MxzW4ovwKVc4iGeawqy07mrl63yac=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UlGK/NhvGOgLbfQ1XQLvmCOpT1X2yuuret6xQU+r51t/OVw/qBpx08K1Nc4ktD40PCQd6Pf18z7E8DMMj4XDerHq+idBp3C8VkF6goebbAHQp1h6IFB6GtP48voUnV5DjaPfHogAJCF1BSorjk5caTmlhGn86t1uB6p5lwOnm94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XKmt6730Yz6HJJD;
	Fri,  4 Oct 2024 19:44:30 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 53F2A1400CA;
	Fri,  4 Oct 2024 19:44:34 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 4 Oct
 2024 13:44:33 +0200
Date: Fri, 4 Oct 2024 12:44:32 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <ira.weiny@intel.com>, <fan.ni@samsung.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2] perf/cxlpmu: Support missing events in 3.1 spec
Message-ID: <20241004124432.00005b67@Huawei.com>
In-Reply-To: <20240930203445.149954-1-dave@stgolabs.net>
References: <20240930203445.149954-1-dave@stgolabs.net>
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
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 30 Sep 2024 13:34:45 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Update the CXL PMU driver to support the new events introduced
> in the latest revision. These are:
> 
> - read/write accesses with TEE constraints.
> - S2M indicating Modified state.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Driver is in perf though so you need to +CC perf maintainers as
they will probably pick this up directly.

Jonathan

> ---
> 
> Changes from v1:
>  - only update spec references of groups that are affected (Alison, Dave).
> 
>  drivers/perf/cxl_pmu.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> index 43d68b69e630..644caf039718 100644
> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c
> @@ -377,12 +377,14 @@ static struct attribute *cxl_pmu_event_attrs[] = {
>  	/* CXL rev 3.0 Table 13-5 directly lists these */
>  	CXL_PMU_EVENT_CXL_ATTR(cachedata_d2h_data,		CXL_PMU_GID_CACHE_DATA, BIT(0)),
>  	CXL_PMU_EVENT_CXL_ATTR(cachedata_h2d_data,		CXL_PMU_GID_CACHE_DATA, BIT(1)),
> -	/* CXL rev 3.0 Table 3-29 M2S Req Memory Opcodes */
> +	/* CXL rev 3.1 Table 3-35 M2S Req Memory Opcodes */
>  	CXL_PMU_EVENT_CXL_ATTR(m2s_req_meminv,			CXL_PMU_GID_M2S_REQ, BIT(0)),
>  	CXL_PMU_EVENT_CXL_ATTR(m2s_req_memrd,			CXL_PMU_GID_M2S_REQ, BIT(1)),
>  	CXL_PMU_EVENT_CXL_ATTR(m2s_req_memrddata,		CXL_PMU_GID_M2S_REQ, BIT(2)),
>  	CXL_PMU_EVENT_CXL_ATTR(m2s_req_memrdfwd,		CXL_PMU_GID_M2S_REQ, BIT(3)),
>  	CXL_PMU_EVENT_CXL_ATTR(m2s_req_memwrfwd,		CXL_PMU_GID_M2S_REQ, BIT(4)),
> +	CXL_PMU_EVENT_CXL_ATTR(m2s_req_memrdtee,		CXL_PMU_GID_M2S_REQ, BIT(5)),
> +	CXL_PMU_EVENT_CXL_ATTR(m2s_req_memrddatatee,		CXL_PMU_GID_M2S_REQ, BIT(6)),
>  	CXL_PMU_EVENT_CXL_ATTR(m2s_req_memspecrd,		CXL_PMU_GID_M2S_REQ, BIT(8)),
>  	CXL_PMU_EVENT_CXL_ATTR(m2s_req_meminvnt,		CXL_PMU_GID_M2S_REQ, BIT(9)),
>  	CXL_PMU_EVENT_CXL_ATTR(m2s_req_memcleanevict,		CXL_PMU_GID_M2S_REQ, BIT(10)),
> @@ -404,10 +406,11 @@ static struct attribute *cxl_pmu_event_attrs[] = {
>  	CXL_PMU_EVENT_CXL_ATTR(s2m_bisnp_curblk,		CXL_PMU_GID_S2M_BISNP, BIT(4)),
>  	CXL_PMU_EVENT_CXL_ATTR(s2m_bisnp_datblk,		CXL_PMU_GID_S2M_BISNP, BIT(5)),
>  	CXL_PMU_EVENT_CXL_ATTR(s2m_bisnp_invblk,		CXL_PMU_GID_S2M_BISNP, BIT(6)),
> -	/* CXL rev 3.0 Table 3-43 S2M NDR Opcopdes */
> +	/* CXL rev 3.1 Table 3-50 S2M NDR Opcopdes */
>  	CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_cmp,			CXL_PMU_GID_S2M_NDR, BIT(0)),
>  	CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_cmps,			CXL_PMU_GID_S2M_NDR, BIT(1)),
>  	CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_cmpe,			CXL_PMU_GID_S2M_NDR, BIT(2)),
> +	CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_cmpm,			CXL_PMU_GID_S2M_NDR, BIT(3)),
>  	CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_biconflictack,		CXL_PMU_GID_S2M_NDR, BIT(4)),
>  	/* CXL rev 3.0 Table 3-46 S2M DRS opcodes */
>  	CXL_PMU_EVENT_CXL_ATTR(s2m_drs_memdata,			CXL_PMU_GID_S2M_DRS, BIT(0)),

