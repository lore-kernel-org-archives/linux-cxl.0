Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996BF331A61
	for <linux-cxl@vger.kernel.org>; Thu, 18 Dec 2025 09:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766049509; cv=none; b=sK3GaI7eQOnKdJ0+VANx4OxQ5vjdPvSh+BS+eRSKtPOIHgI7l4grycP6Z9LG//D0IoSPSLo65lxuyXP5Z7SSQNakRW5dRwMFfWN1am7BoeCk6WaABmq9qdzzxX6/BoRcUFQ13LVqvyMn//kGRnsoUpoPtnx7q4KbVRAqInGbQwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766049509; c=relaxed/simple;
	bh=FBBmFB+y4QTE7uT5IpWB+HJTDwRQ7n558jUzqT8MtcI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WielGKUmtSl9B60bxwPXle4EyrZTQpxUvCY4vXCtrY4k7OaQB1p7rSHJARKt2WlnPLjvR0zwHtZUYw7qycxXW0ztbD0oHooNPXDsJ3ctBnTPMI86lGSPVd41XsQ94wUQog2XPh/GBQDs5DW6vpJ8lcjXb1voWxEakV5m1dBbIJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dwie7w+p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dwie7w+p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766049505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=epJtLsu8TCXnSc0Kkcj7sH43/QN/yQBlXmzJonCvwA4=;
	b=dwie7w+pfO7MvW2XJp5ZMCsx59GB74/2uxS61RT1knpgXDuzBZbaAqRy0VxK8gEwFpQpzZ
	iKKMn6oBQmi+nZgXLjr7qULgCP2bTbcIH9JFbKdUsoHLwBR4T5ffENVBKT4P7+1wWvbwav
	68zgmTOabLNknN95NdH6nyXeqiNUSkk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-9_fldCfPMS-FG4gi2YHPSg-1; Thu,
 18 Dec 2025 04:18:21 -0500
X-MC-Unique: 9_fldCfPMS-FG4gi2YHPSg-1
X-Mimecast-MFC-AGG-ID: 9_fldCfPMS-FG4gi2YHPSg_1766049500
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D1DA18002F9;
	Thu, 18 Dec 2025 09:18:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.7])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6D8D8180049F;
	Thu, 18 Dec 2025 09:18:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 264DF21E6A27; Thu, 18 Dec 2025 10:18:17 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: jonathan.cameron@huawei.com,  ira.weiny@intel.com,  alucerop@amd.com,
  a.manzanares@samsung.com,  dongjoo.seo1@samsung.com,  mst@redhat.com,
  marcel.apfelbaum@gmail.com,  linux-cxl@vger.kernel.org,
  qemu-devel@nongnu.org
Subject: Re: [PATCH 3/5] hw/cxl: Allow BI by default in Window restrictions
In-Reply-To: <20251103195209.1319917-4-dave@stgolabs.net> (Davidlohr Bueso's
	message of "Mon, 3 Nov 2025 11:52:07 -0800")
References: <20251103195209.1319917-1-dave@stgolabs.net>
	<20251103195209.1319917-4-dave@stgolabs.net>
Date: Thu, 18 Dec 2025 10:18:17 +0100
Message-ID: <87wm2ki1wm.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Davidlohr Bueso <dave@stgolabs.net> writes:

> Update the CFMW restrictions to also permit Back-Invalidate
> flows by default, which is aligned with the no-restrictions
> policy.
>
> While at it, document the 'restrictions=' option.

I'd split the patch.  Up to you.

> Tested-by: Dongjoo Seo <dongjoo.seo1@samsung.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  hw/cxl/cxl-host.c | 2 +-
>  qapi/machine.json | 3 ++-
>  qemu-options.hx   | 4 +++-
>  3 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
> index e420b25176a6..ed0c76a31980 100644
> --- a/hw/cxl/cxl-host.c
> +++ b/hw/cxl/cxl-host.c
> @@ -64,7 +64,7 @@ static void cxl_fixed_memory_window_config(CXLFixedMemoryWindowOptions *object,
>      if (object->has_restrictions) {
>          fw->restrictions = object->restrictions;
>      } else {
> -        fw->restrictions = 0xf; /* No restrictions */
> +        fw->restrictions = 0x2f; /* No restrictions */
>      }
>  
>      fw->targets = g_malloc0_n(fw->num_targets, sizeof(*fw->targets));
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 225690d2986a..85e31432b038 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -555,7 +555,8 @@
>  #     BIT(2) - Volatile
>  #     BIT(3) - Persistent
>  #     BIT(4) - Fixed Device Config
> -#     Default is 0xF
> +#     BIT(5) - BI
> +#     Default is 0x2F
>  #
>  # @targets: Target root bridge IDs from -device ...,id=<ID> for each
>  #     root bridge.

This changes the default of @restrictions.  No problem since
@restrictions has not been in any release.  If it was, we'd have to
consider backward compatibility.

[...]

