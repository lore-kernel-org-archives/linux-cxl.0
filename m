Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F1C4D90B1
	for <linux-cxl@vger.kernel.org>; Tue, 21 Jul 2026 15:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784646563; cv=none; b=CytmF+Clg+AEWz5Pcfa2btg5seRmBCkiOGxw9H4UQhbnOChJuzUOrMMbv+U/0LL7xnEP297w6umPSMOudqbCijbPkTz59laPFuCRUG44kQKAM17tweV/zXNJLQ+VpixPPtsVSTRNmaKkBdblIFp8ee0yBKTkXs9iQcEqPq/ygI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784646563; c=relaxed/simple;
	bh=b6hf/7dwGHf2YGiyWyyEzr07MRmmPumtP+D2l2gFed0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mn4jqI1bmzfkq4TRz2F6rDOPUudNB9Px1enX6RlBk5gobJM4A9JIgbQTpZxZ2Nxxri2U0mZ9Alv3689TWkSb9YCAIDvJ7ekH8hSeYLCRTuPvkwvwnzKW4EelYt4quBDOd02CYw3OqDGpmiQUXjczcnvLArkzUNF2gIZoR5hqfNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OPCrMEOM; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OPCrMEOM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784646561; x=1816182561;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=b6hf/7dwGHf2YGiyWyyEzr07MRmmPumtP+D2l2gFed0=;
  b=OPCrMEOMxoVMA/icE0fbmA3sAulTlEv2BXf5qnFz+gDBbQDR/WAX1XDq
   hHsA356ccn+M8JkjlNnuSprsyctfQbnhEYgOZkIKDDQ/lnuhhX2CULI9y
   vsn0fqlGl2Jw4BtXauL/zvhn8HkHhvS0zBO1iDU8OdW42X9mnKlzhayfc
   Hc+jhpva5x/SIuDl5wRbEY2RWMbUd4nRaykFd6tujHsmVIV0id2jd8Qtn
   j8vm5he2sMTYtS+B+GLsEDJIAzp7ntER0ITPmaCOofHqqpIpB5Nk4SSd/
   N7/Nk8DG2+NKecw6pmJ+uNjfhpA9VV0ryykEFUYAzFVzUHVgB/jH2AkWr
   g==;
X-CSE-ConnectionGUID: ErjGM+LfTVS8ztMqu69Zig==
X-CSE-MsgGUID: FcYy4ZK5T8eo+LS5x0WDHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="85194309"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="85194309"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 08:09:20 -0700
X-CSE-ConnectionGUID: VIK3goZ9TYyhmzQA49Y9cg==
X-CSE-MsgGUID: UxCgS3BIQiG2l76bvFya8w==
X-ExtLoop1: 1
Received: from bradocaj-mobl.ger.corp.intel.com (HELO [10.125.109.244]) ([10.125.109.244])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 08:09:18 -0700
Message-ID: <bcd3fde1-a312-4865-8a74-7dfe1b175e6e@intel.com>
Date: Tue, 21 Jul 2026 08:09:17 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] cxl/hdm: Make switch decoder target parsing
 endian-safe
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>,
 Dan Williams <djbw@kernel.org>, Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org, Srirangan Madhavan <smadhavan@nvidia.com>,
 Richard Cheng <icheng@nvidia.com>
References: <cover.1784595445.git.alison.schofield@intel.com>
 <f98abc5edccc4fed9250d29df76ac677e3e51702.1784595445.git.alison.schofield@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <f98abc5edccc4fed9250d29df76ac677e3e51702.1784595445.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/20/26 6:59 PM, Alison Schofield wrote:
> Switch decoder target IDs are stored one per byte, starting with
> target 0 in the least significant byte. The current code accesses
> those bytes in memory order, which only matches register order on
> little-endian hosts.
> 
> On big-endian hosts, the target IDs are reversed and the decoder is
> associated with the wrong downstream ports.
> 
> Extract each target ID from the register value with an explicit shift
> and mask so the target mapping is independent of host endianness.
> 
> Fixes: d17d0540a0db ("cxl/core/hdm: Add CXL standard decoder enumeration to the core")
> Reviewed-by: Richard Cheng <icheng@nvidia.com>
> Reviewed-by: Li Ming <ming.li@zohomail.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
>  drivers/cxl/core/hdm.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 1f995191baf5..077aface1a2a 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -976,14 +976,11 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  {
>  	struct cxl_endpoint_decoder *cxled = NULL;
>  	u64 size, base, skip, dpa_size, lo, hi;
> +	u64 target_list;
>  	bool committed;
>  	u32 remainder;
>  	int i, rc;
>  	u32 ctrl;
> -	union {
> -		u64 value;
> -		unsigned char target_id[8];
> -	} target_list;
>  
>  	if (should_emulate_decoders(info))
>  		return cxl_setup_hdm_decoder_from_dvsec(port, cxld, dpa_base,
> @@ -1122,9 +1119,9 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  
>  		lo = readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
>  		hi = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
> -		target_list.value = (hi << 32) + lo;
> +		target_list = (hi << 32) + lo;
>  		for (i = 0; i < cxld->interleave_ways; i++)
> -			cxld->target_map[i] = target_list.target_id[i];
> +			cxld->target_map[i] = (target_list >> (i * 8)) & 0xff;
>  
>  		return 0;
>  	}

