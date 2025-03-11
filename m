Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C287D5234
	for <linux-cxl@vger.kernel.org>; Tue, 11 Mar 2025 00:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741653463; cv=pass; b=LwlQ8bYSwIpOnGNd4HMUz+10gip8z5KTeFm9rDRqz44nMhFYkDNIuJA34qFnS1SIlBumpOdbHobbXgIGfdsR/OC8r8kLS3OyxpQiqTiTTUjimYnNZtuZpXfvCM41WJRk3oaTU1+M7l8GTkBg3q0wDDvRX4wUsXx31Dog12S85HE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741653463; c=relaxed/simple;
	bh=IfVkniVNAheWVADBcaLpqrdeJqvvMeZmJ9GE123bNAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mr64sFZMMr978bQkkV/POl3tMm+xehlOaoDZPxWZzQFTNcfoiTK1ANVYpxSOpMIzNCzKFtzkiu7dtu9DSHJ+8ZHH/X27aDmIB/lOI9cfZUY5TolXY/kb8nb5lFrnT+c+pi2mibC11WuvBgNk7hCvhuWg8d9gOps9SnpmYjtjsow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=daFWeURi; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="daFWeURi"
ARC-Seal: i=1; a=rsa-sha256; t=1741653446; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=i0BCvXLGATRO7IRyV8VJU4rN0LAct3u429DkKAloUXauzRd52Sq7IzjEQbRVFVeIPPctSomv1isulpac6CF5oVJs9LmGUwgYepWmlrQ3MmcYhTG7X4wmWm29m05jTibvsCuCEz5JYW07TAi/P6w3DZZG4A3gGMd6tMH1EgUq9Oc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1741653446; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=zIIJhIASnTCZyXkXEFxmueYL2i3gY3Mpj6nBPDLa/Ak=; 
	b=U4zolM3vqZ9emJ+yRb7Hq9Nka0k6F+3QQHWkVZ8wkN7PXfm3O8hFyX737c4WUHPjppFX92PSCssfw0Zhd6Mod7NumjfvR2/DUACcwqYlruV4m/Pc84iPc8f7WdzGff4pomQIxXzBkXaSEvrPI8ai0HBwYGXqWGvAdmLHqK/gha4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1741653446;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=zIIJhIASnTCZyXkXEFxmueYL2i3gY3Mpj6nBPDLa/Ak=;
	b=daFWeURir1p9ImieAkdtn0iLfdht0ryQfTbnTGYC40YuYb0+Ln2QK3ZqB0cj/l5u
	JbfjfllDe81/JexRuE6qpFOIabSr2g+cw3I7/Q13kBFKVJZd7y+uK8Y7/tbdmqh3SUG
	XwKz/IAh/tK9qJRuHZCPOGj7AWGUUCOS//zmANLs=
Received: by mx.zohomail.com with SMTPS id 1741653442840853.4018129122906;
	Mon, 10 Mar 2025 17:37:22 -0700 (PDT)
Message-ID: <28a42ab9-0cb6-4370-a3a5-4d375186016a@zohomail.com>
Date: Tue, 11 Mar 2025 08:37:20 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 9/9] cxl: Fixup kdoc issues for include/cxl/features.h
To: Dave Jiang <dave.jiang@intel.com>
Cc: jgg@nvidia.com, saeedm@nvidia.com, jonathan.cameron@huawei.com,
 linux-cxl@vger.kernel.org
References: <20250307205648.1021626-1-dave.jiang@intel.com>
 <20250307205648.1021626-10-dave.jiang@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250307205648.1021626-10-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr08011227460400453b48ce873a6c785e00001f819951185d1451370d28d617567278954fb5a744c6748e55:zu08011227fef7c77c143efef36480955600002dfffe9d09d9e2d269a81b50ff067d0fc41833a202f1378ee8:rf0801122dc6d7a9b2b60de3e8349f540e0000d0cfd48baf148550dc10532f1fecf6b583d58c4ad91660981f4e1a907a2696:ZohoMail
X-ZohoMailClient: External

On 3/8/2025 4:55 AM, Dave Jiang wrote:
> Fixup kdoc issues for include/cxl/features.h from linux-next build.
>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
> ---
>  include/cxl/features.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/include/cxl/features.h b/include/cxl/features.h
> index ead63573b0b4..cdd4c7131cc3 100644
> --- a/include/cxl/features.h
> +++ b/include/cxl/features.h
> @@ -51,8 +51,6 @@ enum cxl_features_capability {
>   * struct cxl_features_state - The Features state for the device
>   * @cxlds: Pointer to CXL device state
>   * @entries: CXl feature entry context
> - *	@num_features: total Features supported by the device
> - *	@ent: Flex array of Feature detail entries from the device
>   * @fwctl_dev: Firmware Control device
>   */
>  struct cxl_features_state {


