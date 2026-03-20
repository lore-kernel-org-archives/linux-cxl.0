Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C40284896
	for <linux-cxl@vger.kernel.org>; Fri, 20 Mar 2026 14:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774018677; cv=none; b=NWb2LUjGnRyK4SxMCavb2sFwjee0ojYVdUeT3eWu7I7sEd0ldvjuzXdo4Gd6+6vFOS/uyy7m+6imX8L87aH/xzZIZ9/XyFpkyZBBeDGGlaLk70NtuPMZXRg8TswVzAikbBGdGLeFDKzNt/RtToZydOXF77gy2Al1Q0gzBOqDTDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774018677; c=relaxed/simple;
	bh=JbmjPPJUggaTAO+PmXnCOlC7FAruDNW9Iwj2+ENCmXk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jlYXj9s2Qs7T5Dx81C266FrH05ir+3Y/lTahKb2YAJ9wWZ85cEGLlQGy+6oCdc0XANcyBLomHozSLA8oPU1RS5rX/KQZgH3CXcA4M0RQSwvRdEWQ9/nfqWQj4T8ZPEogMnxp/AubDtkdLsqnGYystYrRxHBjVFjD53SG4PVhsuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fclz92pqgzHnGgl;
	Fri, 20 Mar 2026 22:57:25 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 0E60740589;
	Fri, 20 Mar 2026 22:57:51 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 20 Mar
 2026 14:57:50 +0000
Date: Fri, 20 Mar 2026 14:57:49 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<alison.schofield@intel.com>, <ira.weiny@intel.com>, <gourry@gourry.net>,
	<dongjoo.seo1@samsung.com>, <anisa.su@samsung.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/6] cxl: Add Back-Invalidate register definitions and
 structures
Message-ID: <20260320145749.0000656c@huawei.com>
In-Reply-To: <20260315202741.3264295-2-dave@stgolabs.net>
References: <20260315202741.3264295-1-dave@stgolabs.net>
	<20260315202741.3264295-2-dave@stgolabs.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Sun, 15 Mar 2026 13:27:36 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Add CXL Back-Invalidate (BI) capability IDs, register definitions for
> the BI Route Table and BI Decoder capability structures, and associated
> fields. This includes HDM decoder coherency capability and control fields
> needed to support HDM-DB (device-managed coherency with back-invalidate).
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---

> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index fa7269154620..74be940364e1 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -34,10 +34,12 @@ struct cxl_regs {
>  	 * Common set of CXL Component register block base pointers
>  	 * @hdm_decoder: CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure
>  	 * @ras: CXL 2.0 8.2.5.9 CXL RAS Capability Structure
> +	 * @bi: CXL 3.2 8.2.4.26/27 CXL BI Capability Structure

Whilst it is indeed one or the other depending on whether we are upstream or
downstream ports, smashing them into a single entry in here seems liable
to generate long term confusion.

Other than a bit of storage, given this is optional anyway I'm guessing it
doesn't cost us much to have bi_rt and bi_decoder?
I think we just hit the
if (!mi->rmap->valid) check and continue in cxl_map_component_regs().
I also don't really think it's our problem to check for hardware that
surfaces these caps on the wrong type of devices.  We'll map
it but not use it.



>  	 */
>  	struct_group_tagged(cxl_component_regs, component,
>  		void __iomem *hdm_decoder;
>  		void __iomem *ras;
> +		void __iomem *bi;
>  	);
>  	/*
>  	 * Common set of CXL Device register block base pointers
> @@ -80,6 +82,7 @@ struct cxl_reg_map {
>  struct cxl_component_reg_map {
>  	struct cxl_reg_map hdm_decoder;
>  	struct cxl_reg_map ras;
> +	struct cxl_reg_map bi;
>  };
>  
>  struct cxl_device_reg_map {
> @@ -162,6 +165,7 @@ struct cxl_dpa_partition {
>   * @regs: Parsed register blocks
>   * @cxl_dvsec: Offset to the PCIe device DVSEC
>   * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
> + * @bi: device is BI (Back-Invalidate) enabled
>   * @media_ready: Indicate whether the device media is usable
>   * @dpa_res: Overall DPA resource tree for the device
>   * @part: DPA partition array
> @@ -181,6 +185,7 @@ struct cxl_dev_state {
>  	struct cxl_device_regs regs;
>  	int cxl_dvsec;
>  	bool rcd;
> +	bool bi;
>  	bool media_ready;
>  	struct resource dpa_res;
>  	struct cxl_dpa_partition part[CXL_NR_PARTITIONS_MAX];

