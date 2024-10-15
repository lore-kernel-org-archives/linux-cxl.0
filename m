Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2D31B3931
	for <linux-cxl@vger.kernel.org>; Tue, 15 Oct 2024 16:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729010210; cv=none; b=gPoC+y80WtPA9zBO1NPIBB0q/IZmg4/4Z3oM75ckRIBecVvUnoKbFAYstMbTGTOQnmHfNjJWQ9uwHGRx5x0ShDGjaVidLy6xxwhgE+nMhWp4jmesUG8OIt2g4796EnnOggC/mO8GM9PXGcNlrBOKiKfJSr5eMSVl9ywz53sHrwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729010210; c=relaxed/simple;
	bh=93a7hMkVTJsnE5Oxla+BpAIjzU5vRhb0vpFbiZ0rNuY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XbZvhTfqnkcSsu8lPx78O5ZTFvLF8+BctQFs6vn4Y6qG9dDS5nK9ttXAupJkEPc6gLE6nk8keyXhDfcJJTmoZXbSySTz+w40rSfXkNbX/9B+mfmpmZE+9fRo+vfSBxzZgwdVdE1mVIEli2zmm7mQh5x6m907ep+/9ZxcdxWylFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XSfl32dsSz6L6qv;
	Wed, 16 Oct 2024 00:32:15 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 1D7AC140C98;
	Wed, 16 Oct 2024 00:36:44 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 15 Oct
 2024 18:36:43 +0200
Date: Tue, 15 Oct 2024 17:36:42 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <dave.jiang@intel.com>, <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <linux-cxl@vger.kernel.org>,
	<gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/5] cxl/port: Fix cxl_bus_rescan() vs
 bus_rescan_devices()
Message-ID: <20241015173642.00007d1f@Huawei.com>
In-Reply-To: <172862484920.2150669.7306809902566347902.stgit@dwillia2-xfh.jf.intel.com>
References: <172862483180.2150669.5564474284074502692.stgit@dwillia2-xfh.jf.intel.com>
	<172862484920.2150669.7306809902566347902.stgit@dwillia2-xfh.jf.intel.com>
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

On Thu, 10 Oct 2024 22:34:10 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> It turns out since its original introduction, pre-2.6.12,
> bus_rescan_devices() has skipped devices that might be in the process of
> attaching or detaching from their driver. For CXL this behavior is
> unwanted and expects that cxl_bus_rescan() is a probe barrier.
> 
> That behavior is simple enough to achieve with bus_for_each_dev() paired
> with call to device_attach(), and it is unclear why bus_rescan_devices()
> took the positition of lockless consumption of dev->driver which is

position

> racy.

Feels like should be +CC a few folk related to the driver core, GregKH
etc to get a sanity check on if they can recall why. +CC Greg.

> 
> The "Fixes:" but no "Cc: stable" on this patch reflects that the issue
> is merely by inspection since the bug that triggered the discovery of
> this potential problem [1] is fixed by other means.  However, a stable
> backport should do no harm.
> 
> Fixes: 8dd2bc0f8e02 ("cxl/mem: Add the cxl_mem driver")
> Link: http://lore.kernel.org/20241004212504.1246-1-gourry@gourry.net [1]
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Fix itself looks fine to me as it will check the dev->driver
under the device lock.

> ---
>  drivers/cxl/core/port.c |   13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index e666ec6a9085..b7828b6c7826 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -2084,11 +2084,18 @@ static void cxl_bus_remove(struct device *dev)
>  
>  static struct workqueue_struct *cxl_bus_wq;
>  
> -static void cxl_bus_rescan_queue(struct work_struct *w)
> +static int attach_device(struct device *dev, void *data)

That naming is never going to be a problem :)
I'd prefix this with something more specific

>  {
> -	int rc = bus_rescan_devices(&cxl_bus_type);
> +	int rc = device_attach(dev);
> +
> +	dev_vdbg(dev, "rescan: %s\n", rc ? "attach" : "detached");
>  
> -	pr_debug("CXL bus rescan result: %d\n", rc);
> +	return 0;
> +}
> +
> +static void cxl_bus_rescan_queue(struct work_struct *w)
> +{
> +	bus_for_each_dev(&cxl_bus_type, NULL, NULL, attach_device);
>  }
>  
>  void cxl_bus_rescan(void)
> 
> 

