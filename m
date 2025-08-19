Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17643301499;
	Tue, 19 Aug 2025 17:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755624185; cv=none; b=O5zV9b5MtGN6plhzl4Gu93kAm8LbevlBgn7PvISNZp8wW7bTGsdnQ7zwTBp6pUZxreGs0C1SLjEtHozdH8jevwNh2kdo1lZwOZYYHGhypGOY6SsbhClvTw1mB1+AI7geKPm6V21cktTMTrDJAPkvdiZ4I3sNpEMDg+bUh+wIV2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755624185; c=relaxed/simple;
	bh=cRnlfBfryZOg+T9IodurvKY+BZYRtILfqxWOhVyDt3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mmec/bbzeLsxB3kqGxNq7pV68/xLUTWL8PZ3iZzAZAycGrRY3CoLB+6i3ch++blCmP9meQ5cJot885X3+ARfqY6fMP9zdrrkd6uS/LfZG4Q8+tu33qQO5CfbRoYFccyGxO+s9SFZCxc36pnlpyjZDQS3XErZhj51Uqa/B6pSvZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Yp6OtxJR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Yp6OtxJR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=CiOHD0EjdMzyYUYSfL6pDjJNdoKu6vKXHv5cwpcNzRE=; b=Yp6OtxJRdTBVvs8Vr8ogKUSzFt
	0bM/opI+D3C8sMkopX1HjOUwIJl52DLXqORkJIk1qxvyBQOMVJDrOQm9tlW/4cnrcm5FoboYe6Cyw
	MZ8xubsu1UIwxYr290Of1esjwTJG7pDqrNsPlXStJ0+lBHYAxI13Z1Rkd0mkW5ADMRqByWgt87EQs
	QjgLqOX+8qLdr15m5XQ1xu0QSbcw5AhND2JMqoilz4QXd3hJnHX/D/vAxSUjSlv47SawoMMjNOnrp
	hyv/DT5HHCbQUelWfiPri/F/GZQdlfNXFnimzmM598PAqv1kDbos6yF6g6gkJOKUf6tCApBCgR1VD
	pMJnSndA==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoQ35-0000000B60W-1fG9;
	Tue, 19 Aug 2025 17:23:03 +0000
Message-ID: <ac123979-109e-46df-93f5-4dff9648f38f@infradead.org>
Date: Tue, 19 Aug 2025 10:23:02 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation/driver-api: Fix typo error in cxl
To: Moktar SELLAMI <smokthar925@gmail.com>, linux-kernel@vger.kernel.org
Cc: linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Gregory Price <gourry@gourry.net>, Alok Tiwari <alok.a.tiwari@oracle.com>,
 linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org
References: <20250819084116.13108-1-smokthar925@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250819084116.13108-1-smokthar925@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/19/25 1:41 AM, Moktar SELLAMI wrote:
> Fixed Typo in the driver-api/cxl/devices/devices.rst
> 
> functionalty -> functionality
> 
> Signed-off-by: Moktar SELLAMI <smokthar925@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/driver-api/cxl/devices/device-types.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/driver-api/cxl/devices/device-types.rst b/Documentation/driver-api/cxl/devices/device-types.rst
> index 923f5d89bc04..7f69dfa4509b 100644
> --- a/Documentation/driver-api/cxl/devices/device-types.rst
> +++ b/Documentation/driver-api/cxl/devices/device-types.rst
> @@ -22,7 +22,7 @@ The basic interaction protocol, similar to PCIe configuration mechanisms.
>  Typically used for initialization, configuration, and I/O access for anything
>  other than memory (CXL.mem) or cache (CXL.cache) operations.
>  
> -The Linux CXL driver exposes access to .io functionalty via the various sysfs
> +The Linux CXL driver exposes access to .io functionality via the various sysfs
>  interfaces and /dev/cxl/ devices (which exposes direct access to device
>  mailboxes).
>  

-- 
~Randy
