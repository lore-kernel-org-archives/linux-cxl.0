Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BE635F8DB;
	Tue, 11 Nov 2025 15:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762874060; cv=none; b=pkOCV1mAr9NlK8r2gKVEay7donVyKsMEsA4Mf9ob5nDPKvx4ynSojatvNRQeDsoOqS6zlLyEPkwI3KBXQ/CSyKWlWKahGJ1l5E7ULJg5XRM4asN5pt1gjZboZYEUJhxTO/RYchYS0HT4YyTUe0iBtcrSgxvXIg9vs2FDdfmcnf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762874060; c=relaxed/simple;
	bh=Z/cwKWAqGc+Ac4kxqDtsRR+hAGZpyH5Gyys2pMx63DU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lCUULU6ns3c4PXKyrp5JmEdLtJV4DMALH93PQO5PyufvVTI8sntdnQQmzzh+XPbhfQi0f8yAfbard9BCkpBh7GDI41VKg5ZQebZniLug1Sx46JI+1syZWCTdPspRaqFg/9r12ryseu/NGt9HFlYd5dWAtIqoNUHE5/BjibRgKAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d5VRn3Cf7zHnGhl;
	Tue, 11 Nov 2025 23:13:57 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id B5EB7140432;
	Tue, 11 Nov 2025 23:14:14 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 11 Nov
 2025 15:14:13 +0000
Date: Tue, 11 Nov 2025 15:14:12 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v4 07/14] cxl/region: Use region data to get the root
 decoder
Message-ID: <20251111151412.00000335@huawei.com>
In-Reply-To: <20251103184804.509762-8-rrichter@amd.com>
References: <20251103184804.509762-1-rrichter@amd.com>
	<20251103184804.509762-8-rrichter@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 3 Nov 2025 19:47:48 +0100
Robert Richter <rrichter@amd.com> wrote:

> To find a region's root decoder, the endpoint's HPA range is used to
> search the matching decoder by its range. With address translation the
> endpoint decoder's range is in a different address space and thus
> cannot be used to determine the root decoder.
> 
> The region parameters are encapsulated within struc cxl_region_context
> and may include the translated Host Physical Address (HPA) range. Use
> this context to identify the root decoder rather than relying on the
> endpoint.
> 
> Modify cxl_find_root_decoder() and add the region context as
> parameter. Rename this function to get_cxl_root_decoder() as a
> counterpart to put_cxl_root_decoder(). Simplify the implementation by
> removing function cxl_port_find_switch_decode(). The function is
> unnecessary because it is not referenced or utilized elsewhere in the
> code.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>

One trivial thing that tickled my "that looks different" filter.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

>  static int match_region_by_range(struct device *dev, const void *data)
> @@ -3584,9 +3576,11 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
>  	};
>  
>  	struct cxl_root_decoder *cxlrd __free(put_cxl_root_decoder) =
> -		cxl_find_root_decoder(cxled);
> -	if (!cxlrd)
> -		return -ENXIO;
> +		get_cxl_root_decoder(cxled, &ctx);
> +
> +	rc = PTR_ERR_OR_ZERO(cxlrd);
> +	if (rc)
> +		return rc;

I think this is more often seen as:

	if (IS_ERR(cxlrd))
		return PTR_ERR(cxlrd);

>  
>  	/*
>  	 * Ensure that if multiple threads race to construct_region()

