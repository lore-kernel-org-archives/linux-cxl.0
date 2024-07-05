Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9192146A96
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jul 2024 11:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720179670; cv=none; b=FT1GNQpphzyr8cTYnoBVyPyGtD22uw5OLkn1mqNo09A91gaeMTuW6Lwqo9ZRbNtAScW9ghZqaJBhSZtaEe791lapBhDlGKkLgwGAgxsaL0Ryvy1397ivvg4su/9+87EdasEvp/N1GglHlY0eJkn7WddojLK3xCHfdQR1WXbNOWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720179670; c=relaxed/simple;
	bh=stbT2Lz7fSlZxFF3tPHSgKGkqVfNAIkp/07z4taLkuA=;
	h=Date:From:To:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CHQNSAg9kTWStbx/uPg3/JGkh6Kd5ubOBwXjfy8C+rSeqHc8Vq3Wmw3FIM2wPjAKL66GBLGLKp/O9RpewYNjyquLwLdaeEeB3WhMiaDwAGxKguJJLBHN+4Ins0ldCX5EZs5pEjKwnDuXIqJxyeiLTOMqpfTxbB+UAa4mXmGB2oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WFs5L1wLXz6JBW1;
	Fri,  5 Jul 2024 19:40:22 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 66FD5140B55;
	Fri,  5 Jul 2024 19:41:06 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 5 Jul
 2024 12:41:06 +0100
Date: Fri, 5 Jul 2024 12:41:04 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <linux-cxl@vger.kernel.org>, <mst@redhat.com>, Markus Armbruster
	<armbru@redhat.com>, <qemu-devel@nongnu.org>, Li Zhijian
	<lizhijian@fujitsu.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH qemu 0/3] hw/cxl: Misc minor improvements
Message-ID: <20240705123930.000064e8@huawei.com>
In-Reply-To: <20240702143425.717452-1-Jonathan.Cameron@huawei.com>
References: <20240702143425.717452-1-Jonathan.Cameron@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 2 Jul 2024 15:34:22 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> Before pushing on to more significant features a few unrelated patches
> doing tidying up + one to avoid people setting the memory backend both
> for a CXL type 3 device and as normal RAM in an attempt to get SRAT to
> cover it correctly.  We've had multiple 'bug' reports from this and if
> nothing else I'd like to stop getting those!
> 
> Based on master + the two DCD series Michael Tsirkin has queued.
> 
> Based-on: [PATCH v8 00/14] Enabling DCD emulation support in Qemu
> Based-on: https://lore.kernel.org/qemu-devel/20240523174651.1089554-1-nifan.cxl@gmail.com/
> Based-on: [PATCH qemu 0/2] hw/cxl: DCD tweaks and improvements.
> Based-on: https://lore.kernel.org/qemu-devel/20240625170805.359278-1-Jonathan.Cameron@huawei.com/

I'll send a v2 that replaces the unused cfmw_list with the fix
that makes us of it to avoid a crash.


> 
> Fan Ni (1):
>   hw/cxl/cxl-mailbox-utils: remove unneeded mailbox output payload space
>     zeroing
> 
> Jonathan Cameron (1):
>   hw/cxl: Check for multiple mappings of memory backends.
> 
> Li Zhijian (1):
>   hw/cxl: Get rid of unused cfmw_list
> 
>  include/hw/cxl/cxl.h       |  1 -
>  hw/cxl/cxl-host.c          |  1 -
>  hw/cxl/cxl-mailbox-utils.c |  7 -------
>  hw/mem/cxl_type3.c         | 15 +++++++++++++++
>  4 files changed, 15 insertions(+), 9 deletions(-)
> 

