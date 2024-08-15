Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBF12A8D0
	for <linux-cxl@vger.kernel.org>; Thu, 15 Aug 2024 16:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723741072; cv=none; b=J4TtnYtJfDfyFbYBMIdaB6zLpnObRM9M96QJ94pDqdTYAzEvd9kaAHs1s8Yrz/PwB6mgKm3AwUAGybGql/lkF5FuFLAOjH4QeGmhl1fQZepj93u8/4Fx+IYLkgIhp3Wl8dQ76v7w5y9KBhQBggoGv0d2xhUpMfajV3K5IrblNDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723741072; c=relaxed/simple;
	bh=/aFRlv/TGyrWWJUawUmyvUoliiHNk4nVZha3tBgWgRw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=peSSRu+rwxAGM9AbHl210e3GV96Lc8WIAmLA6KSyivg8AOtjO4jBSNsdpT/oTcctekk9s6ydRwuZdp5wFS92QxoNlJLc/Sj4QV/Xrf0H12DBslmB+iPKJoFTlDtG9TxyABA1jtCKmfZtVAX24wHtIhCze28zcdFoUgs3FTh2/bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WlB6q1HcSz6K5Wg;
	Fri, 16 Aug 2024 00:54:27 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id F02FA140119;
	Fri, 16 Aug 2024 00:57:46 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 15 Aug
 2024 17:57:46 +0100
Date: Thu, 15 Aug 2024 17:57:45 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <alejandro.lucero-palau@amd.com>,
	<dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>, <dave@stgolabs.net>
Subject: Re: [PATCH 1/2] cxl: Move mailbox related bits to the same context
Message-ID: <20240815175745.000041cc@Huawei.com>
In-Reply-To: <20240724185649.2574627-2-dave.jiang@intel.com>
References: <20240724185649.2574627-1-dave.jiang@intel.com>
	<20240724185649.2574627-2-dave.jiang@intel.com>
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
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 24 Jul 2024 11:55:16 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Create a new 'struct cxl_mailbox' and move all mailbox related bits to
> it. This allows isolation of all CXL mailbox data in order to export
> some of the calls to external callers and avoid exporting of CXL driver
> specific bits such has device states. The allocation of
> 'struct cxl_mailbox' is also split out with cxl_mailbox_create() so the
> mailbox can be created independently.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Hi Dave,

Mostly good, but cxl_mailbox_create() needs another look.
Feels like a bit of cut and paste gone too far ;)

I'm not entirely convinced it shouldn't just remain embedded in
the parent structure with create replace with just an init()
function.  I don't mind that much though.

Jonathan


> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 2626f3fff201..9501d2576ccd 100644


> @@ -1408,6 +1454,34 @@ int cxl_poison_state_init(struct cxl_memdev_state *mds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_poison_state_init, CXL);
>  
> +static void free_cxl_mailbox(void *cxl_mbox)
> +{
> +	kfree(cxl_mbox);
> +}
> +
> +struct cxl_mailbox *cxl_mailbox_create(struct device *dev)
> +{
> +	struct cxl_mailbox *cxl_mbox __free(kfree) =
> +		kzalloc(sizeof(*cxl_mbox), GFP_KERNEL);
This is not somewhere I'd use the __free magic, because
failure to create a mailbox is very likely fatal and doing
so requires the dance with devm_add_action_or_reset() to
just free a structure.

So I'd just use devm_kzalloc()
and rely on caller to fail probe() or if not to do manual
cleanup of the structure.

There aren't any failure paths currently where the auto cleanup
gets used anyway other than the devm_add_action_or_reset()
which is not using auto cleanup anyway.

> +	int rc;
> +
> +	if (!cxl_mbox)
> +		return ERR_PTR(-ENOMEM);
> +
> +	cxl_mbox->host = dev;
> +	mutex_init(&cxl_mbox->mbox_mutex);
> +	rcuwait_init(&cxl_mbox->mbox_wait);
> +
> +	rc = devm_add_action_or_reset(dev, free_cxl_mailbox, cxl_mbox);
> +	if (rc) {
> +		cxl_mbox = NULL;
Non obvious as that's a suppression of what would otherwise
be a double free.  Having to do this rather defeats the point
of the simplification __free normally brings.

> +		return ERR_PTR(rc);
> +	}
> +
> +	return no_free_ptr(cxl_mbox);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_mailbox_create, CXL);
