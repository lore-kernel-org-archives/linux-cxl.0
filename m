Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E18A63C
	for <linux-cxl@vger.kernel.org>; Mon, 25 Dec 2023 01:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i1z0vygY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703468472; x=1735004472;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=+/ejLxGNpFbNNzOCv0dSxvrW5DZ2de11Dlcx1iNrf4Y=;
  b=i1z0vygYSnQZnGXoRVehbSF955sewut+AYkF6PWB6g4y0bJ1RV9CGrfS
   5j2oi45qxRuU8g1vj/TZBsonBgtHu/VrOiF97b8t9EdaiQgfnNTpFXuv2
   Lx32g1aJGbbWWzboNQXTCfS/w9tMJ5B5TwZhIJyKJQZIu9Ez9WdoT8x7/
   yI2rC+09EQYHc1GrrA4JazflLglF5odtfO5/5LCy8GwhqlJPYDI4j/6gI
   rgvFU0nYl49uk5848IhRdRJKUhAt7IJNZ6XmiNZT0bLLUW1LvYqI2sQkt
   KJr+oamZXNSvGhP1eKFctoZLuJEHFuhqqku8h4HcutoV8oS5dzTmC0WDY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="9776697"
X-IronPort-AV: E=Sophos;i="6.04,302,1695711600"; 
   d="scan'208";a="9776697"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2023 17:41:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="1109039968"
X-IronPort-AV: E=Sophos;i="6.04,302,1695711600"; 
   d="scan'208";a="1109039968"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2023 17:41:08 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,  Jonathan Cameron
 <jonathan.cameron@huawei.com>,  Dave Jiang <dave.jiang@intel.com>,  Vishal
 Verma <vishal.l.verma@intel.com>,  Ira Weiny <ira.weiny@intel.com>,  Dan
 Williams <dan.j.williams@intel.com>,  <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] ACPI: NUMA: Fix overlap when extending memblks to fill
 CFMWS
In-Reply-To: <20231223000025.1401076-1-alison.schofield@intel.com> (alison
	schofield's message of "Fri, 22 Dec 2023 16:00:25 -0800")
References: <20231223000025.1401076-1-alison.schofield@intel.com>
Date: Mon, 25 Dec 2023 09:39:09 +0800
Message-ID: <87sf3rf4ci.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

<alison.schofield@intel.com> writes:

> From: Alison Schofield <alison.schofield@intel.com>
>
> When the BIOS only partially describes a CFMWS Window in the SRAT
> the acpi driver uses numa_fill_memblks() to extend existing memblk(s)
> to fill the entire CFMWS Window, thereby applying the proximity domain
> to the entire CFMWS.
>
> The calculation of the memblks to fill has an off-by-one error, that
> causes numa_init to fail when it sees the overlap:
>
> [] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x7fffffff]
> [] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0xffffffffff]
> [] ACPI: SRAT: Node 1 PXM 1 [mem 0x10000000000-0x1ffffffffff]
> [] node 0 [mem 0x100000000-0xffffffffff] overlaps with node 1 [mem 0x100000000-0x1ffffffffff]
>
> Fix by making the 'end' parameter to numa_fill_memblks() exclusive.
>
> Fixes: 8f1004679987 ("ACPI/NUMA: Apply SRAT proximity domain to entire CFMWS window")
> Reported-by: "Huang, Ying" <ying.huang@intel.com>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/acpi/numa/srat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index 12f330b0eac0..b99062f7c412 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -308,7 +308,7 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
>  
>  	cfmws = (struct acpi_cedt_cfmws *)header;
>  	start = cfmws->base_hpa;
> -	end = cfmws->base_hpa + cfmws->window_size;
> +	end = cfmws->base_hpa + cfmws->window_size - 1;

IIUC, this makes end inclusive instead of exclusive.  That is, from
"[start, end)" to "[start, end]".  Am I right?

If so, later in the function, "numa_add_memblk(node, start, end)" is
called, where "end" is expected to be exclusive.  And I think that it's
better to make the parameter "end" of numa_fill_memblks() consistent
with other numa_memblk family functions, that is, exclusive.

>  	/*
>  	 * The SRAT may have already described NUMA details for all,
>
> base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86

--
Best Regards,
Huang, Ying
