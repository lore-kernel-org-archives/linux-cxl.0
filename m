Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480181A01B9
	for <linux-cxl@vger.kernel.org>; Mon, 23 Jun 2025 14:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750690206; cv=none; b=iIbhWeAUInqXSvQYUyiHTFEXfI1zJH7xIt7LL/QIqgeY30Yjhx2oDPXda/YIW2jANPVDV0tnmAYWlxi49nsfDAt186092jxh/6YzJ8y96VHRPvPRLAqOm4XbeusSjNxEm02aWXs++dYGrJqN6TnnID9PTgqJjO8vEHGB3Nf850Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750690206; c=relaxed/simple;
	bh=t23FVEVErgE+gLEVp8i5XIVQbzzYo9MnGh6KASd8pNI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R/D+aDZCj8yrUvg83VQ3T9qchGBm6RNjMcBQjXMxVY9CdRA0uSC8BrhAd8WvzaVz7NUNexKacn5jD6bvet2KR6Tr0jRagJ3IcGjP9n9MxujbV9BB2k7LmIg+7uTswqXu9pNyot8DH8GPinCEblyVd09jw+gN6pQaWO2Do7qrYZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bQrZQ2GYgz6D983;
	Mon, 23 Jun 2025 22:49:18 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 244FE1402E9;
	Mon, 23 Jun 2025 22:50:01 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 23 Jun
 2025 16:50:00 +0200
Date: Mon, 23 Jun 2025 15:49:59 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <jgroves@micron.com>, <ravis.opensrc@micron.com>,
	<fan.ni@samsung.com>, <anisa.su@samsung.com>, <a.manzanares@samsung.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 5/7] cxl/mbox: Allow userspace background commands
Message-ID: <20250623154959.00005d54@huawei.com>
In-Reply-To: <20250617193611.564668-6-dave@stgolabs.net>
References: <20250617193611.564668-1-dave@stgolabs.net>
	<20250617193611.564668-6-dave@stgolabs.net>
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

On Tue, 17 Jun 2025 12:36:09 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> CXL 3.1 introduced the ability to request that the current on-going
> background command be aborted. As such userspace may be allowed to
> monopolize the background operation capability if there are no
> other bg commands that want to run.
> 
> The policy here are as follows:
> 
> 1. Give bg-capable commands from the kernel higher priority than those
> from userspace (albeit currently no command). Therefore a userspace
> on-going command can be canceled so a kernel one may run instead.
> 
> 2. Userspace bg commands may cancel each other on demand. It is not
> up to the kernel to put any policies in place here.
> 
> 3. Any previously synchronous polling timedout command that is still
> running may also be aborted by any command. This window is expected
> to be small.
> 
> The context of doing the cancellation request is the same as the new
> incoming command, and will always hold the mbox_mutex, guaranteeing
> that any successful cancel does not race with a third thread coming
> in and stealing the effort.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/cxl/core/mbox.c |  9 ++++--
>  drivers/cxl/cxlmem.h    |  4 +++
>  drivers/cxl/pci.c       | 72 +++++++++++++++++++++++++++++++++++++----
>  include/cxl/mailbox.h   |  2 ++
>  4 files changed, 78 insertions(+), 9 deletions(-)

> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 3648efcc7c89..6ada0f502914 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c

> @@ -263,6 +264,8 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_mailbox *cxl_mbox,
>  	 * commands during this window.
>  	 */
>  	switch (mds->bg.opcode) {
> +	case 0:

I assume this is the race?  Add a comment so we can figure this out in future.

> +		break;
>  	case CXL_MBOX_OP_SANITIZE:
>  		/*
>  		 * Ensure no new command comes in until so. Keep the


>  static int cxl_pci_mbox_send(struct cxl_mailbox *cxl_mbox,
>  			     struct cxl_mbox_cmd *cmd)
>  {
> @@ -381,9 +437,11 @@ static int cxl_pci_mbox_send(struct cxl_mailbox *cxl_mbox,
>  	/*
>  	 * Ensure cxl_mbox_background_done() checks are safe amongst
>  	 * each other: no new bg operation can occur in between while polling.
> +	 *

Stray change.

>  	 */



