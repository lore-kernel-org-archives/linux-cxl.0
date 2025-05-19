Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFAA1EFFB7;
	Mon, 19 May 2025 09:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747648560; cv=none; b=XmU1bGvH/RaIWpeFJoPK9wcgttMjzFCN8CzRTif0xQE08OTILvSrzoZgDB1x8l9/Md42sxjvxxamZOA3VrApQ9E5awM+ETJ1FjsCjSU8nB3UgbsdoGpj2PpnWMW3w0Z/N+9yPLZfPgAmfZQrV2MnJX31+n3/K8/qRPAwhSoeQvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747648560; c=relaxed/simple;
	bh=/BBt/YKZxcHqUw83XYKVQf4e84Ptzk+g75V+O9txIR8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B3w6UUv7cArUyWUz/wrARm+0JQbEGqebkKu9VwygCb9ArJDIOKzkIe+dmqnBYA1tRf7BmBt3imtIVwIWPUM47KTt80n4JEUcXDZgz7AmHU6dx7WFHqTJ2YV4RoOk8Pn1e7N0vB849DnCLmbVP6tVJNoMtPDhD/Z7P6itTERqegw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b1Cj56Nstz6K9nQ;
	Mon, 19 May 2025 17:55:05 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id EA99C1402F0;
	Mon, 19 May 2025 17:55:52 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 19 May
 2025 11:55:52 +0200
Date: Mon, 19 May 2025 10:55:50 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Sumanth Gavini <sumanth.gavini@yahoo.com>
CC: <skhan@linuxfoundation.org>, <dave.jiang@intel.com>,
	<ira.weiny@intel.com>, <dave@stgolabs.net>, <ming.li@zohomail.com>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] docs: ABI: Fix "firwmare" to "firmware"
Message-ID: <20250519105550.000051ab@huawei.com>
In-Reply-To: <20250517110332.1289718-1-sumanth.gavini@yahoo.com>
References: <20250517110332.1289718-1-sumanth.gavini.ref@yahoo.com>
	<20250517110332.1289718-1-sumanth.gavini@yahoo.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Sat, 17 May 2025 04:03:16 -0700
Sumanth Gavini <sumanth.gavini@yahoo.com> wrote:

> Fix misspelling reported by codespell
> 
> Signed-off-by: Sumanth Gavini <sumanth.gavini@yahoo.com>
+CC linux-cxl

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  Documentation/ABI/testing/sysfs-bus-cxl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 99bb3faf7a0e..d0d58b74f382 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -242,7 +242,7 @@ Description:
>  		decoding a Host Physical Address range. Note that this number
>  		may be elevated without any regionX objects active or even
>  		enumerated, as this may be due to decoders established by
> -		platform firwmare or a previous kernel (kexec).
> +		platform firmware or a previous kernel (kexec).
>  
>  
>  What:		/sys/bus/cxl/devices/decoderX.Y

