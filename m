Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B697B33D5
	for <linux-cxl@vger.kernel.org>; Tue,  5 Mar 2024 10:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709634903; cv=none; b=RJZ9JWQsDX7/wd0L4OLM473ETgi465Zs64QC33UtxKtRSgFQTGasD1XBMvrnnnbH0SH8HYLyOfW5qmbhvTmNeC8/nd3+duOpkCikPcvK3rJU2R0SrtMb/+jGgaHe4/JEY+uRI0q7Q1fKswyKWGSU4u4qAqNDdxfSsF33fb6fbbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709634903; c=relaxed/simple;
	bh=dGSo+iykMKs9/R/Cu0v22dHgdQXo3fNYg0ic4XQAKko=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lLWuyYquognkAkGownnZQiXThyR/PHEY3f5QZJYipQX71c/b3z2bDupEZqz0ohk+Bx5xZ5auON4AFmjd+4ONYwbmV/5NYLzRyI2JqhTkznzH0Rh30RGj71or9k7yKuBFYYKiiTZf8i0o3YFmEAE9EVPk4P6yq9lJ21JYJBxhPKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TpsJS43zyz6D8rl;
	Tue,  5 Mar 2024 18:30:00 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id D8E3914182C;
	Tue,  5 Mar 2024 18:34:56 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 5 Mar
 2024 10:34:56 +0000
Date: Tue, 5 Mar 2024 10:34:55 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>
Subject: Re: [PATCH v3] cxl: Fix the incorrect assignment of SSLBIS entry
 pointer initial location
Message-ID: <20240305103455.000064bc@Huawei.com>
In-Reply-To: <20240301210948.1298075-1-dave.jiang@intel.com>
References: <20240301210948.1298075-1-dave.jiang@intel.com>
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
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 1 Mar 2024 14:09:48 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> The 'entry' pointer in cdat_sslbis_handler() is set to header +
> sizeof(common header). However, the math missed the addition of the SSLBIS
> main header. It should be header + sizeof(common header) + sizeof(*sslbis).
> Use a defined struct for all the SSLBIS parts in order to avoid pointer
> math errors.
> 
> The bug causes incorrect parsing of the SSLBIS table and introduces incorrect
> performance values to the access_coordinates during the CXL access_coordinate
> calculation path if there are CXL switches present in the topology.
> 
> The issue was found during testing of new code being added to add additional
> checks for invalid CDAT values during CXL access_coordinate calculation. The
> testing was done on qemu with a CXL topology including a CXL switch.
> 
> Fixes: 80aa780dda20 ("cxl: Add callback to parse the SSLBIS subtable from CDAT")
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Hmm. This is far from a minimal fix.  The end result is nicer though so fair enough.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Pity there is no direct variable containing the count so we could do
a __counted_by() - don't think you can do maths in that unfortunately.


> ---
> v3:
> - use var for sizeof() instead of struct (Alison)
> ---
>  drivers/cxl/core/cdat.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index 08fd0baea7a0..0363ca434ef4 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -389,36 +389,38 @@ EXPORT_SYMBOL_NS_GPL(cxl_endpoint_parse_cdat, CXL);
>  static int cdat_sslbis_handler(union acpi_subtable_headers *header, void *arg,
>  			       const unsigned long end)
>  {
> +	struct acpi_cdat_sslbis_table {
> +		struct acpi_cdat_header header;
> +		struct acpi_cdat_sslbis sslbis_header;
> +		struct acpi_cdat_sslbe entries[];
> +	} *tbl = (struct acpi_cdat_sslbis_table *)header;
> +	int size = sizeof(header->cdat) + sizeof(tbl->sslbis_header);
>  	struct acpi_cdat_sslbis *sslbis;
> -	int size = sizeof(header->cdat) + sizeof(*sslbis);
>  	struct cxl_port *port = arg;
>  	struct device *dev = &port->dev;
> -	struct acpi_cdat_sslbe *entry;
>  	int remain, entries, i;
>  	u16 len;
>  
>  	len = le16_to_cpu((__force __le16)header->cdat.length);
>  	remain = len - size;
> -	if (!remain || remain % sizeof(*entry) ||
> +	if (!remain || remain % sizeof(tbl->entries[0]) ||
>  	    (unsigned long)header + len > end) {
>  		dev_warn(dev, "Malformed SSLBIS table length: (%u)\n", len);
>  		return -EINVAL;
>  	}
>  
> -	/* Skip common header */
> -	sslbis = (struct acpi_cdat_sslbis *)((unsigned long)header +
> -					     sizeof(header->cdat));
> -
> +	sslbis = &tbl->sslbis_header;
>  	/* Unrecognized data type, we can skip */
>  	if (sslbis->data_type > ACPI_HMAT_WRITE_BANDWIDTH)
>  		return 0;
>  
> -	entries = remain / sizeof(*entry);
> -	entry = (struct acpi_cdat_sslbe *)((unsigned long)header + sizeof(*sslbis));
> +	entries = remain / sizeof(tbl->entries[0]);
> +	if (struct_size(tbl, entries, entries) != len)
> +		return -EINVAL;
>  
>  	for (i = 0; i < entries; i++) {
> -		u16 x = le16_to_cpu((__force __le16)entry->portx_id);
> -		u16 y = le16_to_cpu((__force __le16)entry->porty_id);
> +		u16 x = le16_to_cpu((__force __le16)tbl->entries[i].portx_id);
> +		u16 y = le16_to_cpu((__force __le16)tbl->entries[i].porty_id);
>  		__le64 le_base;
>  		__le16 le_val;
>  		struct cxl_dport *dport;
> @@ -448,8 +450,8 @@ static int cdat_sslbis_handler(union acpi_subtable_headers *header, void *arg,
>  			break;
>  		}
>  
> -		le_base = (__force __le64)sslbis->entry_base_unit;
> -		le_val = (__force __le16)entry->latency_or_bandwidth;
> +		le_base = (__force __le64)tbl->sslbis_header.entry_base_unit;
> +		le_val = (__force __le16)tbl->entries[i].latency_or_bandwidth;
>  
>  		if (check_mul_overflow(le64_to_cpu(le_base),
>  				       le16_to_cpu(le_val), &val))
> @@ -462,8 +464,6 @@ static int cdat_sslbis_handler(union acpi_subtable_headers *header, void *arg,
>  							  sslbis->data_type,
>  							  val);
>  		}
> -
> -		entry++;
>  	}
>  
>  	return 0;

