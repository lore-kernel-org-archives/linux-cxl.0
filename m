Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EE61D86F7
	for <linux-cxl@vger.kernel.org>; Thu, 10 Apr 2025 15:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744297419; cv=none; b=TB8rsoqCR19PFel6Ijuxr0llZ1syuIxlbjq7wwuuDjh0qydGXNqEAlcw+Jg2zs6ORbQ9s20l+StFVGqT7xqqzRt+Mh3NUw2M30E3ZTI8/wMSiCvndI8EroeGav49PKZ4iSr9HOTG+4whuFWFk3peGnfzD8Uzk1a6UdUOpQqBVJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744297419; c=relaxed/simple;
	bh=WVxiUSoh7bEyk5oMe3354sPJopI+4jObybYUKq2EnQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ha+ramGJNr9JydOTTv3oo27FC6RMPFAEti4lAkRVT8eq3/nSuTY8NHQ8Ejw7/XJ6mcXcWOGQ3BQHgK6PJsdiR0kFdpwQBgBgc//KOJaTwU0tZW+RnpC3MF0ELi4wb7/0YhusBAPb0272lm3f/hIzHeohNcCMdXY+7vEZceBGYJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=hmcaw09H; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="hmcaw09H"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0A2B740E0242;
	Thu, 10 Apr 2025 15:03:33 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id L_afJDhHaqbu; Thu, 10 Apr 2025 15:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1744297409; bh=8/LRmNJ44lwRyxIsHBOZFadHAcapXvc4IkG3GqpWlU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hmcaw09Hbun2L1R0FX+A3w6mXUkx2p3PWAIS+6/8/vV9BFPy9ZictESbXIHz+ltl4
	 awPtFHjHLj2yyieZVWuv/SAQ9VSYwoCe5wM5YSzTQ06tYb7G2NpRwCwrhadMmQ7m8y
	 TbeShMAyxRYLVGm5ZgNPIlWrzhTYsBnT2gSUSBNGKcq6boL7ipYQLm0g4kTc6tCKYz
	 MxRwcpBh3F5/9E6Rm20y1/WW7uysuDQ4a+L16xf7mr+X2qFunz9qYvOZDmj5vBDRVn
	 sZZ261byeR6WyWlm0rul/P8aSO+b8mjtkCm7a5YfjfqHrIxKmT9pUOxRzoq2jQDZv2
	 xmm0BtoyFcQRFKyz4MH6L/uQkhINxGKgBplQTIFyPFWCsZVG5ThqdEcKHbctZM0mpL
	 fyE48NR5Uc8Esr0DGMaAQSr55aaK5UrmseDUwf9idYeiOrfaG81D1OGwO33+BmwHVo
	 0GNQ73jqxzB4DrMVb6JtsNyT6q93mmIXKQR2qFhbRlOUI3l1OpEsKXpaWU/RITciZy
	 bFFpasrcm0PXLIdsvY0RX/KvxCnKTJRf3eR9LP1opjHq4/7I5F0jZDn2O/Yqi/AaZb
	 /9paY+qaUoT35qpubthzB60VAWk9F+8sE9FCQwA0lwcCbWDw8hw2tj1nloayjYSB8N
	 uAzhLeDEJKiO4jNL7h1Hu2j4=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2766540E0196;
	Thu, 10 Apr 2025 15:03:22 +0000 (UTC)
Date: Thu, 10 Apr 2025 17:03:15 +0200
From: Borislav Petkov <bp@alien8.de>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, jgg@nvidia.com, saeedm@nvidia.com,
	jonathan.cameron@huawei.com,
	Dan Williams <dan.j.williams@intel.com>,
	Li Ming <ming.li@zohomail.com>
Subject: Re: [PATCH v8 2/9] cxl: Move cxl feature command structs to user
 header
Message-ID: <20250410150315.GHZ_fds7lfQWfdQDrg@fat_crate.local>
References: <20250307205648.1021626-1-dave.jiang@intel.com>
 <20250307205648.1021626-3-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250307205648.1021626-3-dave.jiang@intel.com>

On Fri, Mar 07, 2025 at 01:55:32PM -0700, Dave Jiang wrote:
> diff --git a/include/uapi/cxl/features.h b/include/uapi/cxl/features.h
> new file mode 100644
> index 000000000000..7f7ab4aefec2
> --- /dev/null
> +++ b/include/uapi/cxl/features.h
> @@ -0,0 +1,169 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * Copyright (c) 2024,2025, Intel Corporation
> + *
> + * These are definitions for the mailbox command interface of CXL subsystem.
> + */
> +#ifndef _UAPI_CXL_FEATURES_H_
> +#define _UAPI_CXL_FEATURES_H_
> +
> +#include <linux/types.h>
> +#ifndef __KERNEL__
> +#include <uuid/uuid.h>
> +#else
> +#include <linux/uuid.h>
> +#endif

This doesn't help in allmodconfig builds:

In file included from ./usr/include/fwctl/cxl.h:12,
                 from <command-line>:
usr/include/cxl/features.h:11:10: fatal error: uuid/uuid.h: No such file or directory
   11 | #include <uuid/uuid.h>
      |          ^~~~~~~~~~~~~
compilation terminated.
make[4]: *** [usr/include/Makefile:85: usr/include/fwctl/cxl.hdrtest] Error 1
make[3]: *** [scripts/Makefile.build:461: usr/include] Error 2
make[2]: *** [scripts/Makefile.build:461: usr] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/home/amd/kernel/linux/Makefile:2006: .] Error 2
make: *** [Makefile:248: __sub-make] Error 2

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
