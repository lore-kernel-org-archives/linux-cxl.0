Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259F219307F;
	Sun, 20 Apr 2025 10:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745145843; cv=pass; b=NMxg2/oTvPCReSkm/ZZCzoGYCTUPSbqMHqNKHmroTydA4sjbYs3tWszidSIsp/gb17TwKUy+u9oU7vlWO9nTYek65keqMrlJ5dTqVFmIKH6lGcIGahS11pfBdSEvBy1YAK1D/LEMPyOvzrOPOVZJsp7zxdI7RVrgcZtpNbaTpXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745145843; c=relaxed/simple;
	bh=PWYFMmO+iR47lm/ddx59Sc1DPiV4axr/eOWPunCDIiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mvf1v4EcKJRf4rzWn02qqJk32JGE2ov0KuZPpQ+YyxsqQ+jRs39HI+FSpScAj2UJgFhbsXvyB2fgV8MAkivmEK1JE2TtzJgeIuwCwwtKvaujuqQEnBz6q3uWa50GkVZWu1Ln0f0HZfcs6pL3EgZBGSjW0pHOSX6wFDCBTzIy9Gg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=Y4RSIuWo; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="Y4RSIuWo"
ARC-Seal: i=1; a=rsa-sha256; t=1745145826; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XjPsx1/n1uSIVnX/suohkUDbajP+7O/wd2OeLjcqBaY0xuVHppTUjNyV302Ny5iVoCR5k03qv77ZbDzV/QfwpDzWtGdQJcCOD59a8NiICxDiNtagOYfM4PIz6xI0ef2VLrcvfWxPUbN/lE94gzRJ2iO5o3yiZSDzPjuqO8GW/8I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1745145826; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=hWDw9CvSC4YIePOz1zzyXcsNS4TgkUIQuni3j/tAgjY=; 
	b=YazC4pBgRLlJ47PoZg2tOsvAjOQkXiPbFQdlfQmJqW91Q2nkgwvy2VznDNWp7WQu+Kg3T3Skmmx8AUafKE79v1lW8dDrZtuja1Ql1IXszvBIv0SdQmlji4Qv3ujDtTTMHLLBSwgQ37ozzhgwsyke246dKCHsbBhXeZuRRkg2tAo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1745145826;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=hWDw9CvSC4YIePOz1zzyXcsNS4TgkUIQuni3j/tAgjY=;
	b=Y4RSIuWo79s/9puAhne+AZfGQWLtLNz+344TGNDZLypvARx1XN+UukytYFQQBf8T
	9ICQ4Peo0rS1ww06uWUAtR+9Hui4+wP29egXHAPoMRi8rwVlXlsoSRfLBKd62zExiYu
	esotF7n/KI74eMg8WYjVvgyLMqNDQ8Q8eVlb9URA=
Received: by mx.zohomail.com with SMTPS id 1745145822883792.8313869958675;
	Sun, 20 Apr 2025 03:43:42 -0700 (PDT)
Message-ID: <3b412741-4fda-4285-b1bb-80c89f0fcf38@zohomail.com>
Date: Sun, 20 Apr 2025 18:43:37 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl: core: Initialize eiw and eig to fix potential
 uninitialized use
To: Purva Yeshi <purvayeshi550@gmail.com>
Cc: huang.ying.caritas@gmail.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com
References: <20250419203530.45594-1-purvayeshi550@gmail.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250419203530.45594-1-purvayeshi550@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr080112274e68700a8a72a4b065481ed9000072f7cd7a2df0c8d61ea24aa357f2445eaa0a8ac5f65143ee78:zu08011227cfdc1948b3e342d90fa52c2c0000e483fd76ceb76f9c97859b11afaebe57a19dbdf1075aaeb916:rf0801122db30812ea3c4bf6dc54636e23000051187a6e38b8ed37a121e2b118b6e0e83f1b1c54f0fcd20275dc1cda9e4ec5:ZohoMail
X-ZohoMailClient: External

On 4/20/2025 4:35 AM, Purva Yeshi wrote:
> Fix Smatch-detected issue:
>
> drivers/cxl/core/region.c:1292 check_interleave_cap()
> error: uninitialized symbol 'eiw'.
> drivers/cxl/core/region.c:1297 check_interleave_cap()
> error: uninitialized symbol 'eig'.
> drivers/cxl/core/region.c:1299 check_interleave_cap()
> error: uninitialized symbol 'eig'.
>
> Smatch reports possible uninitialized usage of these variables if
> the helper functions ways_to_eiw() or granularity_to_eig() fail to
> assign values under certain conditions.
>
> Initialize the eiw and eig variables to zero when they are declared
> in check_interleave_cap() to prevent potential use of uninitialized
> values.

I also met them during checking cxl drivers code with code inspection tools. But they are not real issues, because both iw and ig are checked before calling check_interleave_cap(). That means check_interleave_cap() will always get a eiw and a eig correctly.

they are checked in cxl_port_setup_targets() in auto-assembly case, otherwise checked in interleave_ways_store() and interleave_guranularity_store().

I am not sure if we need this patch, let's see if other reviewers have more comments.


Ming

>
> Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
> ---
>  drivers/cxl/core/region.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index c3f4dc244df7..edf8636f190a 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1266,8 +1266,8 @@ static int check_interleave_cap(struct cxl_decoder *cxld, int iw, int ig)
>  	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
>  	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
>  	unsigned int interleave_mask;
> -	u8 eiw;
> -	u16 eig;
> +	u8 eiw = 0;
> +	u16 eig = 0;
>  	int high_pos, low_pos;
>  
>  	if (!test_bit(iw, &cxlhdm->iw_cap_mask))


