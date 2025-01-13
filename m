Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6712322AE7E
	for <linux-cxl@vger.kernel.org>; Mon, 13 Jan 2025 12:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736773145; cv=none; b=cfftioLsfqJwSxZxE2SZA4ZFbtLkzBc3oQAVtAb/590BWh2r5pJaRH8BrWsejtVzzbE6J+s/7CAqhabhdb8P7X7b6yFVNYndQI7zIBu5mr6+QbjHa6CFrw4psOWl4oI3VyHnBTBQkd6zTLwDsdh1WN7PRr+/oaYRbyoxEYW86Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736773145; c=relaxed/simple;
	bh=5lqCIIm3LN4S8KrrQX0phOSLEPfg+rMlD1B0bEKShng=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f4RebacbTmbm68vx+QuxLQHv7jwXU+hfQvHK9dtQPt+EOsDyWAOav4hTBbL/13EesA6S8otEF/pC9VJqFvCE+ksEf/+/9Z/yYsUkT+4ZGNn8ISi181H937hB8wJpO7BSMDUfsK0/2v4Ws8YSspDuqYyiW9wAXFm4rPdwAJC2Rqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YWsdv3ZFsz6K998;
	Mon, 13 Jan 2025 20:54:11 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 0422C140A9C;
	Mon, 13 Jan 2025 20:59:01 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 13 Jan
 2025 13:59:00 +0100
Date: Mon, 13 Jan 2025 12:58:59 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <dave.jiang@intel.com>, <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<alison.schofield@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/2] cxl: Document missing sysfs files
Message-ID: <20250113125859.00003dcb@huawei.com>
In-Reply-To: <20250113025240.327124-3-dave@stgolabs.net>
References: <20250113025240.327124-1-dave@stgolabs.net>
	<20250113025240.327124-3-dave@stgolabs.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Sun, 12 Jan 2025 18:52:40 -0800
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Add to the ABI documentation the payload_max and label_storage_size
> read-only files, which have been there since the early days.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 7bdf0eb79d7c..96c7fffa5442 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -18,6 +18,24 @@ Description:
>  		specification.
>  
>  
> +What:		/sys/bus/cxl/devices/memX/payload_max
> +Date:		December, 2020
> +KernelVersion:	v5.12
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) Maximum size (in bytes) of the mailbox command payload
> +		registers. Linux caps this at 1Mb if the device reports a
> +		larger size.

Spec currently caps it to 1MiB as well so a device reporting larger is buggy
but I guess we don't need to mention that :)
Units wise probably MB or MiB if we are being fusy. I think Mb is mega bit?

MB is slightly more common in ABI docs.  Oddly neither MiB or MB shows
up much. Mb not there at all.

> +
> +
> +What:		/sys/bus/cxl/devices/memX/label_storage_size
> +Date:		May, 2021
> +KernelVersion:	v5.13
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) Size (in bytes) of the Label Storage Area (LSA).
> +
> +
>  What:		/sys/bus/cxl/devices/memX/ram/size
>  Date:		December, 2020
>  KernelVersion:	v5.12

