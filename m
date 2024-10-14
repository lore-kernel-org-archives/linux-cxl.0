Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCB61494BB
	for <linux-cxl@vger.kernel.org>; Mon, 14 Oct 2024 12:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728910472; cv=none; b=REcK2GUymc+eiUp9TxBDHLYXrij2TMhZldMdKOt9bvmaDGaab1k5U8wChLL4FVK1sv32tQaXtuqIGS77YxYLR+6JlS79DCZfrOT5xFg0moZ+KeOB8SE54FEb2UcRfLbaaxgahH5e9gDPEEtv/QkkVHzLs8nfVEkyqIu45xf7ujA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728910472; c=relaxed/simple;
	bh=YuvyWgVA2+Nqy/dl7GK+TrqR1byAkCnH/AFOha1rf1w=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UGq2dO7kimS5OaxfEUTlv89vpr9ogVLIr4Bym6KDg6Q4V+4EI3BEv4hhnmBnq4nFIp2wHM/udZi++Pguquuzb2jgLNJcEYgTqUWX0nSCr6HMrxG4UilD1e+4nZzEaihwZSIlsvFuhrYA6nTfj1/IuU+TYsH8KHCG4kpRFK6dG4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XRxxc4gXJz6HJlT;
	Mon, 14 Oct 2024 20:53:56 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 65A06140C72;
	Mon, 14 Oct 2024 20:54:28 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 14 Oct
 2024 14:54:27 +0200
Date: Mon, 14 Oct 2024 13:54:25 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <mst@redhat.com>, <qemu-devel@nongnu.org>, <linuxarm@huawei.com>
CC: Dmitry Frolov <frolov@swemel.ru>, Ajay Joshi <ajay.opensrc@micron.com>,
	Yao Xingtao <yaoxt.fnst@fujitsu.com>, Fan Ni <fan.ni@samsung.com>, "Shiju
 Jose" <shiju.jose@huawei.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 0/7] hw/cxl: Round up of fixes.
Message-ID: <20241014135411.00006b8a@huawei.com>
In-Reply-To: <20241014121902.2146424-1-Jonathan.Cameron@huawei.com>
References: <20241014121902.2146424-1-Jonathan.Cameron@huawei.com>
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
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 14 Oct 2024 13:18:55 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> A mixed bag of fixes that have all been on the list already with the
> exception of:
> "hw/pci-bridge: Make pxb_dev_realize_common() return if it succeeded"
> (so that's the one that needs more eyes).
> 
> I've tweaked the others to fix typos and correct Fixes tags (adding
> them where missing and fixing formatting), but they are fundamentally
> the same that has been reviewed on list.
Oops. This should have been
[PATCH qemu 0/7]...
to match the additions to the patch title for the others.
Note for qemu people, we do this for CXL patches to that it is
easier to manage the patchwork instance on linux-cxl as that is only
currently used to track kernel patches and hence these should be excluded.

Jonathan

> 
> Ajay Joshi (1):
>   hw/cxl: Fix background completion percentage calculation
> 
> Dmitry Frolov (1):
>   hw/cxl: Fix uint32 overflow cxl-mailbox-utils.c
> 
> Fan Ni (1):
>   hw/mem/cxl_type3: Fix More flag setting for dynamic capacity event
>     records
> 
> Jonathan Cameron (2):
>   hw/cxl: Fix indent of structure member
>   hw/pci-bridge: Make pxb_dev_realize_common() return if it succeeded
> 
> Shiju Jose (1):
>   hw/cxl/cxl-mailbox-utils: Fix for device DDR5 ECS control feature
>     tables
> 
> Yao Xingtao (1):
>   mem/cxl_type3: Fix overlapping region validation error
> 
>  include/hw/cxl/cxl_device.h         | 36 ++++++++++++++++++-----------
>  hw/cxl/cxl-mailbox-utils.c          | 31 +++++++++++--------------
>  hw/mem/cxl_type3.c                  | 15 +++++-------
>  hw/pci-bridge/pci_expander_bridge.c | 13 +++++++----
>  4 files changed, 49 insertions(+), 46 deletions(-)
> 

