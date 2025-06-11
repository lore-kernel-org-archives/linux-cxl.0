Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CB92E611C
	for <linux-cxl@vger.kernel.org>; Wed, 11 Jun 2025 11:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749640804; cv=pass; b=bW1k490R0XZNcjg6bTSGgMW1BoS5r/E6GrYcdbSgJ2zJwR3SRZgxPAjoClIm1KQOzMd9IPe7UQNeWUHxRxUBjPnGi+9zuMrzN3UeWD83HFkx+YpQDw62KylRwOgjUsci5a+p76xxLXtR9GG5ib7559pZojhC2sdCFDJBVO+kOFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749640804; c=relaxed/simple;
	bh=FeNhJM2Dxpa7pvKMZ7pvnz9MG3AoTZoXALf0yNB/Ufc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GLkKhrq8H+OMU8J/adLQ8T0b3hqMoNUNK7uEwRFLyUFqHkVMC1dDpobw/0FmNa9/1woW8rdkNXa0lRM5QC5ISVZZhxKnKg2Nfb1rwlYoEYscMNcOVXffN6w6CDYZyPMJYyY8DigRa9/U296LefOj4/S0kRidlpt55qvrHCW1YpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=dAwJN/T/; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="dAwJN/T/"
ARC-Seal: i=1; a=rsa-sha256; t=1749640791; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SJZWexCznftcWjVRdOD2ttXny27sHDDID+ixnKBvgQK4b87aewPT8WfRo+tbg9iQFx9VmrOJGEAnIDAX+UUKP6rI8BhmSxoOtfN0aUEWo3olNiIW3UgVEkK4U9Vw4njyXYcL5MKgdqi/2YYDk4SV7qcBRK/1UYUNETJPLxLHQ8g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1749640791; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=sm7OJIvvthIMZ7LtN9fkrAupjkAcUv/YxwqH4/TOQ4s=; 
	b=nyTaeWNTsxTxfbwB3ef0Daq4hGjHBhLzz07XKQwJGO+hfX9ar08gxhfx5t4/xFoPvhQIK0VORI0qLW+7HvWkditaSd4mF0tMw5k14KVfG+rdkp/G7Pc5Kxijd7ja91MPVEzaHErx7AAtG5sPcH5znyNGcvoYBhx//UTeeN3pTlc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1749640791;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=sm7OJIvvthIMZ7LtN9fkrAupjkAcUv/YxwqH4/TOQ4s=;
	b=dAwJN/T/qZ8S7lVenA6TCBvheNGOhkdYejrchuN4trWwgpp5YJbv600jPcxySRNM
	RgxcVabjilwJMUzIvgr1nMbJ8cJf4bXzln4vEw93bYuuOfZa1ssxzmrzbJsqUO/2/ak
	sj+MDJNUZeSHTP6RO8bdEhznd19CY080jgZpEzMc=
Received: by mx.zohomail.com with SMTPS id 1749640790574572.3484615543401;
	Wed, 11 Jun 2025 04:19:50 -0700 (PDT)
Message-ID: <e3d942a2-aa21-4195-8a2d-008236ea7276@zohomail.com>
Date: Wed, 11 Jun 2025 19:19:47 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl: Add comment about 'cxl_root_decoder' and flex array
To: Dave Jiang <dave.jiang@intel.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, linux-cxl@vger.kernel.org
References: <20250610175401.172660-1-dave.jiang@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250610175401.172660-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr080112272dc1875958f6cafe4ec5ce0c000049c9dfa607eae8a7a5575d3916fe2ec32b861a92a7df8ee7e7:zu08011227c958db066839ba5de485a3e0000006213d733f3833febf53a15332d9ab9dff10f008c0fd14f2ec:rf0801122d6301f051e87ede6387e3136100001b061be647c97ba3a6e9301eb9df30ee361cf5cd4b9472bc13126f87c80211:ZohoMail
X-ZohoMailClient: External

On 6/11/2025 1:54 AM, Dave Jiang wrote:
> Add a warning comment for 'struct cxl_root_decoder' to not add members
> after 'cxlsd' since 'cxlsd' has flex array at the end.
>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
> ---
>  drivers/cxl/cxl.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 9a17e8beca7a..68596e9216f3 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -445,6 +445,7 @@ struct cxl_root_decoder {
>  	int qos_class;
>  	const struct cxl_rd_ops *ops;
>  	struct cxl_switch_decoder cxlsd;
> +	/* DO NOT ADD AFTER THIS POINT, cxlsd has flex array component */
>  };
>  
>  /*
>
> base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
> prerequisite-patch-id: 77982cd1ed494cf0f747ccf74c6b8949be9837d6


