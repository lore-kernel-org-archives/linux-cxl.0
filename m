Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A344A1FECD0;
	Thu, 20 Feb 2025 16:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740069049; cv=none; b=OPJysfUzBJAaq/hsSaA1NrrTwLD82QaEss+SkW/tu6AXRSX8NhT7nkEezg6EVIeBlb/nnjpxNFA5lOi07RVXklnHbpwDD7BayUhSpi7YHiHgSTdSHZT6/+G2NW2prZSvT/F/kMUnHS+NpwGT0OwKKUjFjNMmvgEQuccI9HFqLCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740069049; c=relaxed/simple;
	bh=h7I4a1m+lKDemV4C/AVPCUByB+1VJoQjS1c/3WUoNkM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H4WqFihEr8YSY7zS11o/XXAfOzHy9SmADzz1sGu6/f79zsfE84Crpv+mIkPVstFoLKidu2s/R+7U5nkioixbpzWNFKZqjmfL38DtUgLgUgsA7I/RtwH135xA8spjBZCyoAEo91t1X0HOQIB6vzWswRQdDvk9v/pmQfb2MJX0vM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YzJZH19G7z6L4tx;
	Fri, 21 Feb 2025 00:27:19 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 355FB140257;
	Fri, 21 Feb 2025 00:30:45 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 20 Feb
 2025 17:30:44 +0100
Date: Thu, 20 Feb 2025 16:30:43 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Gregory Price <gourry@gourry.net>
CC: <lsf-pc@lists.linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [LSF/MM] CXL Boot to Bash - Section 1: BIOS, EFI, and Early
 Boot
Message-ID: <20250220163043.000000cd@huawei.com>
In-Reply-To: <Z6LKJZkcdjuit2Ck@gourry-fedora-PF4VCD3F>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
	<Z6LKJZkcdjuit2Ck@gourry-fedora-PF4VCD3F>
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
 frapeml500008.china.huawei.com (7.182.85.71)


> 
> Example CEDT Entries (truncated) 
>          Subtable Type : 00 [CXL Host Bridge Structure]
>               Reserved : 00
>                 Length : 0020
> Associated host bridge : 00000005
> 
>          Subtable Type : 01 [CXL Fixed Memory Window Structure]
>               Reserved : 00
>                 Length : 002C
>               Reserved : 00000000
>    Window base address : 000000C050000000
>            Window size : 0000003CA0000000
> 
> If this memory is NOT marked "Special Purpose" by BIOS (next section),

Specific purpose.  You don't want to know how long that term took to
agree on...

> you should find a matching entry EFI Memory Map and /proc/iomem
> 
> BIOS-e820:   [mem 0x000000c050000000-0x000000fcefffffff] usable

Trivial but that's not the EFI memory map, that's the e820.
On some architectures this really will be coming from the EFI memory map.


> /proc/iomem: c050000000-fcefffffff : System RAM


> 
> 
> ---------------------------------------------------------------
> Step 3: EFI_MEMORY_SP - Deferring Management to the CXL Driver.
> ---------------------------------------------------------------
> 
> Assuming you DON'T want CXL memory to default to SystemRAM and prefer
> NOT to have your kernel allocate arbitrary resources on CXL, you
> probably want to defer managing these memory regions to the CXL driver.
> 
> The mechanism for is setting EFI_MEMORY_SP bit on CXL memory in BIOS.
> This will mark the memory "Special Purpose".

Specific purpose if we are keeping the UEFI naming.


