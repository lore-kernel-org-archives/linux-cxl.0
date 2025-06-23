Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884342581
	for <linux-cxl@vger.kernel.org>; Mon, 23 Jun 2025 14:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750688563; cv=none; b=TV0bPu+ZLVC+oWUx1o725555TkZSYzuSr0YEymNJhRVRBpIQHaaHkTmNKjQwUF4bSWOyXuDtHpPNEZxHA+rcH4Zr0/jiqe2Wmrk9Aco0M5s7AaQef3wZP0Xcg9Uos5+5/OphuCoge8LHVZbmnoGKlE6/X3EU6pmuMFGEiW9XhFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750688563; c=relaxed/simple;
	bh=PS9ZnD3IOpXdVIFkmX0dTjbjxWAIuYBk3ThTyFGfpS4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IczCpWSf3sTHkAt0G8DxS4G9apmCfGyTUehHk5aYCeABIsUzeE4fZJ4YPeYxV+SdO2oOq2lVrgAtb52XfoQoIlPV9Bf8erfw5HwisWAIA4g/hmbpMHExsxdJHQS9oOK+UvN2AgoR+pVSzomb0ZM02kGPsg016JldOLV0uMngV5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bQqsy4WPfz6DJxy;
	Mon, 23 Jun 2025 22:17:42 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 001191402F6;
	Mon, 23 Jun 2025 22:22:38 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 23 Jun
 2025 16:22:38 +0200
Date: Mon, 23 Jun 2025 15:22:37 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <jgroves@micron.com>, <ravis.opensrc@micron.com>,
	<fan.ni@samsung.com>, <anisa.su@samsung.com>, <a.manzanares@samsung.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/7] cxl/mbox: Handle Activate FW as async bg
Message-ID: <20250623152237.00000d72@huawei.com>
In-Reply-To: <20250617193611.564668-3-dave@stgolabs.net>
References: <20250617193611.564668-1-dave@stgolabs.net>
	<20250617193611.564668-3-dave@stgolabs.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
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

On Tue, 17 Jun 2025 12:36:06 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Allow Activate FW to behave as Sanitize by running in an async
> context. These commands cannot be timesliced, and while it was
> the expectation that hardware vendors perform (offline) activating
> FW in a timely fashion, this might not always be the case.
> 
> This further reduces the timeout scenarios when handling the
> bg command synchronously.
> 
> Decouple the async background handling from security.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Trivial comment inline.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>


> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 5c7fd4a6704c..6fe42871fbf4 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -361,17 +361,11 @@ struct cxl_fw_state {
>   *
>   * @state: state of last security operation
>   * @enabled_cmds: All security commands enabled in the CEL
> - * @poll_tmo_secs: polling timeout
> - * @sanitize_active: sanitize completion pending
> - * @poll_dwork: polling work item
>   * @sanitize_node: sanitation sysfs file to notify
>   */
>  struct cxl_security_state {
>  	unsigned long state;
>  	DECLARE_BITMAP(enabled_cmds, CXL_SEC_ENABLED_MAX);
> -	int poll_tmo_secs;
> -	bool sanitize_active;
> -	struct delayed_work poll_dwork;
>  	struct kernfs_node *sanitize_node;
>  };
>  
> @@ -379,12 +373,17 @@ struct cxl_security_state {
>   * struct cxl_background_state - Driver background operation state info
>   *
>   * @enabled_cmds: All background commands enabled in the CEL
> + * @poll_dwork: polling background work item
> + * @poll_tmo_secs: polling timeout
> + * @opcode: async running background command
>   */
>  struct cxl_background_state {
>  	DECLARE_BITMAP(enabled_cmds, CXL_BG_ENABLED_MAX);
> +	struct delayed_work poll_dwork;
> +	int poll_tmo_secs;
> +	int opcode;
>  };
>  
> -
Stray change?
>  /*
>   * enum cxl_devtype - delineate type-2 from a generic type-3 device
>   * @CXL_DEVTYPE_DEVMEM - Vendor specific CXL Type-2 device implementing HDM-D or

