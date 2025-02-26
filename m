Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3AB19DF62
	for <linux-cxl@vger.kernel.org>; Wed, 26 Feb 2025 07:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740553984; cv=pass; b=n/0JTJ+MV6HgBrsAx0C9wqko1ZxkBOHOAAiKxL3TqkgOD9LqrFyezZVP5nK04ADpPalpdTlGrwht5BUPTMTqRN1haDUbAjW3h/MpTyMkfYWN/LB71jUZCOvg9vr/FWWn1vRBRphguxSplhz/l73KyFNthEF7N6yFxJT+0nstnd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740553984; c=relaxed/simple;
	bh=fS4hv3OuLKWRiVJqrpdued9a01S9RZ5yLRmDGILjx3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NfmvQ0JX5lqvoJdH+JgNOezjSW2tYEN28eKTDaYilIXT2P7HikNK18dsE7i4L/oz6+x6qrBDMM4jh2Unlba6MBipQJIfJB/eAnX4D8kCDY9oE9Sefz/se7S+C0DfhBE3nz72+WTlsTn4fn/L5Ge3/QWa24SGwzyPqyxlKWEEDrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=IG6Lc6SZ; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="IG6Lc6SZ"
ARC-Seal: i=1; a=rsa-sha256; t=1740553972; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RL/DlidX47wO64+HnGRmvBchk16r5veNb4FJNDs86nKppviqlenjhkyALe9SAPiFNsPfs82obyqtclRKzj0+W+Ef+bY5a6DtCRQo8JuPRsrVOpGn3x/mxIQEU4lVZdyo+aZjP2mq+rqGwVJ1tPKCappcWMiUP37fec397p1dlSI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740553972; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3+aLdy1rhd0D9qEHZ3/a6H+A31r+aU4h9t1BCXeDeig=; 
	b=N6sSYHvSYiWNI2JXXqzbCO9LoA/eRs8myf0VzNeMClXq9P+3X4ebeRVCLfObGQtq8/YEjtuPI89Q8g9jolm8JCrnVkqWOkgtGHBSWFk3z2BN5QbVsldT03Ti+Dp7oTOTaiRXVDkxYlE8Iwzb+EBBsiUz8aa85gbpwI95MH7ATOQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740553972;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=3+aLdy1rhd0D9qEHZ3/a6H+A31r+aU4h9t1BCXeDeig=;
	b=IG6Lc6SZGTZqMYS5WSfghSgFe06BfdxY3YIZIeAG60wndP+ZBXu425B55o6utycL
	C93jMW1LkCmNDKvHzHHY5DeIvYitccilRLiBT46JHKqirBUum+XU8rwbLKYnclphuqa
	JXeC2rfbPN0x9oMwsu1AQ6PaElzSLqKOd+mSzo9o=
Received: by mx.zohomail.com with SMTPS id 1740553969711432.83493523903314;
	Tue, 25 Feb 2025 23:12:49 -0800 (PST)
Message-ID: <71f703fc-5171-46ad-86b5-f74432a728ae@zohomail.com>
Date: Wed, 26 Feb 2025 15:12:46 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/region: Allow 6 & 12 way regions on 3-way HB
 interleaves
To: alison.schofield@intel.com
Cc: linux-cxl@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
References: <20250224235817.2259508-1-alison.schofield@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250224235817.2259508-1-alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr08011227f9ca53ba9f848d80b5aa7f180000b16a3f8d3445f2fbeef2aae977f3db34ecf53745233cd95e3d:zu0801122732f516a52b532aee280b1b4d000031d9b8369545895919ad32f783145d43beb211e072e80a2de8:rf0801122d41ba2b921678cbb560a83e53000056d8780013443920e5b4a811b4a5fcfa2fb496a8013efd8c25497aa7fd17d6:ZohoMail
X-ZohoMailClient: External

On 2/25/2025 7:58 AM, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
>
> The CXL driver requires the granularity of a region and it's root
> decoder to be the same. This is particularly restrictive for 3-way
> host bridge interleaves where the only spec defined interleave
> configurations for creating 6-way and 12-way regions on a 3-way HB
> interleave require mixed granularities.
>
> CXL 3.1 Specification 9.13.1.1:
> Legal Interleaving Configurations: 12-way, 6-way, and 3-way
>
> Adding support for these new interleaves touches these areas:
>
> 1) User created regions employing "cxl create-region" fail when the
> ndctl tool gets a mixed granularity request. That is addressed in
> a patch to the ndctl tool.
>
> 2) User created regions employing sysfs directly fail at the sysfs
> store of the non-matching region granularity. That restriction is
> lifted here. Note that the driver immediately allows any reasonable
> 3-way HB granularity, but the region config may still fail later
> if the ways/gran between region and root decoder are incompatible.
>
> 3) Auto created regions, in which the drivers role is to reflect
> the BIOS created region and provide RAS support, basically sneak on
> by. The driver ignores the root decoders granularity and assumes it
> is the same as the regions. The impact being that endpoint devices
> appear out of order and DPA to HPA address translations that depend
> on that order are invalid. Here the driver stops making that same
> granularity assumption and checks for an allowable granularity.
>
> A new helper, interleave_granularity_allow(), is used in both the
> user and auto creation path to allow the newly supported configs.
>
> Another new helper, gran_multiple(), is used in sorting, target
> list searching, and distance calculations, supporting the new
> root granularity to region granularity multiples.
>
> And, as noted in 2), there's an added check to see if the
> selected sysfs ways/gran make sense when considered together.
>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/cxl/core/region.c | 101 +++++++++++++++++++++++++++++++-------
>  1 file changed, 82 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 3cb91cf0e2dd..9d4716b7fcf8 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -532,6 +532,31 @@ static ssize_t interleave_granularity_show(struct device *dev,
>  	return rc;
>  }
>  
> +static bool interleave_granularity_allow(struct cxl_decoder *cxld, u16 ig)
> +{
> +	/*
> +	 * When the host-bridge is interleaved, disallow region granularity
> +	 * != root granularity with the exception of 3-way HB interleaves.
> +	 * Allow the CXL Spec defined 3-way HB interleaves that can only be
> +	 * configured when host-bridge interleave is greater that the
> +	 * region interleave. (CXL 3.1 Specification 9.13.1.1)
> +	 * Allow 2+2+2 interleave where HB gran is 2 * region granularity
> +	 *	 4+4+4 interleave where HB gran is 4 * region granularity
> +	 *
> +	 * Regions with a granularity greater than the root interleave result
> +	 * in invalid DPA translations (invalid to support).
> +	 */
> +	if (cxld->interleave_ways > 1 && ig != cxld->interleave_granularity) {
> +		if (cxld->interleave_ways != 3)
> +			return false;
> +
> +		if (cxld->interleave_granularity % (2 * ig) &&
> +		    cxld->interleave_granularity % (4 * ig))
> +			return false;
> +	}
> +	return true;
> +}
> +
>  static ssize_t interleave_granularity_store(struct device *dev,
>  					    struct device_attribute *attr,
>  					    const char *buf, size_t len)
> @@ -551,15 +576,7 @@ static ssize_t interleave_granularity_store(struct device *dev,
>  	if (rc)
>  		return rc;
>  
> -	/*
> -	 * When the host-bridge is interleaved, disallow region granularity !=
> -	 * root granularity. Regions with a granularity less than the root
> -	 * interleave result in needing multiple endpoints to support a single
> -	 * slot in the interleave (possible to support in the future). Regions
> -	 * with a granularity greater than the root interleave result in invalid
> -	 * DPA translations (invalid to support).
> -	 */
> -	if (cxld->interleave_ways > 1 && val != cxld->interleave_granularity)
> +	if (!interleave_granularity_allow(cxld, val))
>  		return -EINVAL;
>  
>  	rc = down_write_killable(&cxl_region_rwsem);
> @@ -1290,6 +1307,23 @@ static int check_interleave_cap(struct cxl_decoder *cxld, int iw, int ig)
>  	return 0;
>  }
>  
> +static int gran_multiple(struct cxl_region *cxlr)
> +{
> +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> +	int root_decoder_gran = cxlrd->cxlsd.cxld.interleave_granularity;
> +	int region_gran = cxlr->params.interleave_granularity;
> +
> +	/*
> +	 * In regions built upon 3-way HB interleaves, the root decoder
> +	 * granularity can be a multiple of the region granularity. The
> +	 * multiple value is used in sorting and distance calculations.
> +	 */
> +	if (cxlrd->cxlsd.cxld.interleave_ways != 3 || !root_decoder_gran)
> +		return 1;

Hi Alison,


root decoder granularity is possible to be 0 here? I checked the code, the minimal value of it should be 256(CXL_DECODER_MIN_GRANULARITY), it was set in __cxl_parse_cfmws().

maybe this '!root_decoder_gran' checking is not needed?


Ming

[snip]

