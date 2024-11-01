Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C23919BBC
	for <linux-cxl@vger.kernel.org>; Fri,  1 Nov 2024 13:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730468736; cv=none; b=QhsGx0YzpbnXJnjJBHr2NMvXjcGHXRpI9qiRRVLTkD+jFKfDUX5ZfN6IkRM7OS+ns/XpCfcQBVteHAhjHbP4tmZGIDLGDdmXmf+t7kjEe8QVALRrdAYxoYMbbsx1HMKMADCrF4OmevIQ9FPHj6ZzX9hwtC2Rh158SrLKatSz+kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730468736; c=relaxed/simple;
	bh=ULt2LLAzl8m0+d6X2vQvVwGoC1seT5JR5YrnmO7mW14=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=djkQmNVjrEB6e6vfRofIoSMmilkrGljK6UENvlS7Nj/T8wqa8O/JtvzUo/HdKyCDpEQRvRVjpTKPhyvzkWJzEVO1DMVaRyVmm6kISX5i6tfKUlL7X20iNcY4+qvrDpuk9raFWmBdtoD2opVTasxiZoEYIBD+9p0tbrqeS8vc8jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xg29w6wGVz6K6jf;
	Fri,  1 Nov 2024 21:43:00 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 855151400D3;
	Fri,  1 Nov 2024 21:45:32 +0800 (CST)
Received: from localhost (10.122.19.247) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 1 Nov
 2024 14:45:32 +0100
Date: Fri, 1 Nov 2024 13:45:30 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <linux-cxl@vger.kernel.org>, <mst@redhat.com>, <qemu-devel@nongnu.org>,
	Esifiel <esifiel@gmail.com>
CC: Fan Ni <fan.ni@samsung.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH qemu 00/10] hw/cxl: Mailbox input parser hardening
 against invalid input.
Message-ID: <20241101134530.00003470@huawei.com>
In-Reply-To: <20241101133917.27634-1-Jonathan.Cameron@huawei.com>
References: <20241101133917.27634-1-Jonathan.Cameron@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 1 Nov 2024 13:39:07 +0000
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> The CXL device mailbox has some variable sized input commands. The payload
> length for each must be established using command especific structures.
> 
> If user space is either buggy or malicious, it may use size fields to
> indicate fields beyond the end of the payload sent.  Some checks on this
> were missing and Esifiel picked up on this.  I've tagged all these fixes
> with Esifiel's Reported-by as either they were in the report or are similar
> issues in other commands.
> 
> These can mostly be easily tested by using the raw mailbox commands option
> in Linux and injecting broken commands from user space.
> 
> A typical command needs to first check that there is enough data to get to
> the command specific sizing fields, then check the reported size is less
> than or equal to the available payload.
> 
> Note that I think it very unlikely anyone is currently using CXL emulation
> with a VM that they do not trust, but that may happen in future so good to
> fix these paths now.

Sorry, forgot to list dependencies.

Based-on: [PATCH 0/7] hw/cxl: Round up of fixes.
Based-on: [PATCH qemu 0/2] hw/cxl: Misc fixes

Based-on: Message-id: 20241014121902.2146424-1-Jonathan.Cameron@huawei.com
Based-on; message-id: 20241101132005.26633-1-Jonathan.Cameron@huawei.com


> 
> Jonathan Cameron (10):
>   hw/cxl: Check size of input data to dynamic capacity mailbox commands
>   hw/cxl: Check input includes at least the header in
>     cmd_features_set_feature()
>   hw/cxl: Check input length is large enough in
>     cmd_events_clear_records()
>   hw/cxl: Check enough data in cmd_firmware_update_transfer()
>   hw/cxl: Check the length of data requested fits in get_log()
>   hw/cxl: Avoid accesses beyond the end of cel_log.
>   hw/cxl: Ensuring enough data to read parameters in
>     cmd_tunnel_management_cmd()
>   hw/cxl: Check that writes do not go beyond end of target attributes
>   hw/cxl: Ensure there is enough data for the header in
>     cmd_ccls_set_lsa()
>   hw/cxl: Ensure there is enough data to read the input header in
>     cmd_get_physical_port_state()
> 
>  hw/cxl/cxl-mailbox-utils.c | 73 ++++++++++++++++++++++++++++++++------
>  1 file changed, 62 insertions(+), 11 deletions(-)
> 

