Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7713F288505
	for <linux-cxl@vger.kernel.org>; Thu, 16 Apr 2026 15:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776355172; cv=none; b=Vg9O0fCoxVQOKC2U/f/5b01SKSoUovpLQV0SNxVh9a/LMv6GJzsk/Sb2dCZs142ooAz5fmB51OBgndzgaDd+UiaBR2dYs6ccUvRqDJ1qJ5mMv/0WbIkkfYqZxwUNxGlb23goJmLNf2NQglN28L0JnN++nPU/TX1c/97Ouaqoz+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776355172; c=relaxed/simple;
	bh=ISzTWXn1i6FWC38U17PB//hVrJpyS8b4Tu4OiAGAxus=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sqc1ENrFvs1EvrMhr+E7JNLaDWYQ0iMKQdPeZOGnrNOJQZOrGrREzDFv1MEPDSiRXE/jjaoaUI3RX5RHDi/kJ2opaFqb9kLyUZM3OmKKKN7PP/leUExhh6swuWeRIifS+a9A6X2nb/tlrUWPRZyLPWJTeQWAtN8sWyIsDumjJW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fxN3w3hkBzHnGjl;
	Thu, 16 Apr 2026 23:59:08 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id CED7D40571;
	Thu, 16 Apr 2026 23:59:26 +0800 (CST)
Received: from localhost (10.123.51.176) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 16 Apr
 2026 16:59:25 +0100
Date: Thu, 16 Apr 2026 16:59:24 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Jonathan Cameron via qemu development <qemu-devel@nongnu.org>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>, <buzzy0257@gmail.com>,
	<jic23@kernel.org>, <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
	<berrange@redhat.com>
Subject: Re: [PATCH qemu] hw/cxl: Avoid out of bounds read when userspace
 requests data off end of CDAT.
Message-ID: <20260416165924.00002043@huawei.com>
In-Reply-To: <20260416155421.9876-1-Jonathan.Cameron@huawei.com>
References: <20260416155421.9876-1-Jonathan.Cameron@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Thu, 16 Apr 2026 16:54:21 +0100
Jonathan Cameron via qemu development <qemu-devel@nongnu.org> wrote:

> The requested entry is controlled by the guest so must be checked against
> the number of entries that actually exist.
> 
> Reported as a security issue, but CXL emulation has since been declared
> to not be suitable (yet) for virtualization use cases and so the security
> handling policy does not apply.
> 
> Fixes: f5ee7413d592 ("hw/mem/cxl-type3: Add CXL CDAT Data Object Exchange")
> Fixes: 882877fc359d ("hw/pci-bridge/cxl-upstream: Add a CDAT table access DOE")
> Reported-by: Buzzy <buzzy0257@gmail.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: <jic23@kernel.org>

I have a very short memory it seems and forgot to add linux-cxl
despite adding it to the MAINTAINERS entry yesterday. 

> ---
>  hw/mem/cxl_type3.c           | 4 ++++
>  hw/pci-bridge/cxl_upstream.c | 4 ++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 4739239da3c5..763b6a024403 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -278,6 +278,10 @@ static bool cxl_doe_cdat_rsp(DOECap *doe_cap)
>      }
>  
>      ent = req->entry_handle;
> +    if (ent >= cdat->entry_len) {
> +        return false;
> +    }
> +
>      base = cdat->entry[ent].base;
>      len = cdat->entry[ent].length;
>  
> diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
> index b6281cbd4cb0..fa53fa2777fd 100644
> --- a/hw/pci-bridge/cxl_upstream.c
> +++ b/hw/pci-bridge/cxl_upstream.c
> @@ -158,6 +158,10 @@ static bool cxl_doe_cdat_rsp(DOECap *doe_cap)
>      }
>  
>      ent = req->entry_handle;
> +    if (ent >= cdat->entry_len) {
> +        return false;
> +    }
> +
>      base = cdat->entry[ent].base;
>      len = cdat->entry[ent].length;
>  

