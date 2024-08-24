Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29423156993;
	Sat, 24 Aug 2024 05:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724476716; cv=none; b=jG6124L+6TmclytyzqKfdWN4i4BOpJjShursg2cZZ64SPSAKxRBAgR7AoQmkePFbnwNrX4ibbvxBTKTA1PlwvIRLmpnCnbYsCBivj1XwSNzOJ1vt9DZanIqX/eEKIdQ3TCX4FRi9390F6CxMVsHnW4tqy4V9YQP1zBvU9tupUxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724476716; c=relaxed/simple;
	bh=QTFsUswSZHPkUq8sNmhCtJUYg5IXvcA4zATtwM9mnUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ffAAzFv+BNmgUFiqUbp+73atmrZGgegfD2CeT4KoFultK0PN50YdKfNlNE4zjuI6xozjz51JlVBuUq0jE1JaS/FUItrQzwv+wgWNs+dWZ83GYZZm+5l/aAkc1TSwwnN9sCfiJZoaPDWnUYCIWKyLK8V5qhcfPoBfTeyoZli6cqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D+fzet8T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D+fzet8T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18D1CC4AF09;
	Sat, 24 Aug 2024 05:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724476715;
	bh=QTFsUswSZHPkUq8sNmhCtJUYg5IXvcA4zATtwM9mnUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D+fzet8Tl/b8OavUzpddAwOGIQV3W4tGvdc3I1XlCgtnKItk0u31CgaRaz0D+LDIq
	 R9gIzBpVGXYH3YP9+NoXUjPNoDXgOZPuayIPeHK03rV8mAp0wiE27iBleR8W3Pgm0Q
	 gNKzIac5nWfZqR2PkdDo7nb5+1fLl+0ko7mwzpfU=
Date: Sat, 24 Aug 2024 11:23:29 +0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Timur Tabi <timur@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux1394-devel@lists.sourceforge.net, netdev@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH v2 1/4] driver core: Make parameter check consistent for
 API cluster device_(for_each|find)_child()
Message-ID: <2024082419-aspirate-pediatric-ee88@gregkh>
References: <20240815-const_dfc_prepare-v2-0-8316b87b8ff9@quicinc.com>
 <20240815-const_dfc_prepare-v2-1-8316b87b8ff9@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815-const_dfc_prepare-v2-1-8316b87b8ff9@quicinc.com>

On Thu, Aug 15, 2024 at 10:58:02PM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> The following API cluster takes the same type parameter list, but do not
> have consistent parameter check as shown below.
> 
> device_for_each_child(struct device *parent, ...)  // check (!parent->p)
> device_for_each_child_reverse(struct device *parent, ...) // same as above
> device_find_child(struct device *parent, ...)      // check (!parent)
> 
> Fixed by using consistent check (!parent || !parent->p) for the cluster.
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  drivers/base/core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 1688e76cb64b..b1dd8c5590dc 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -4004,7 +4004,7 @@ int device_for_each_child(struct device *parent, void *data,
>  	struct device *child;
>  	int error = 0;
>  
> -	if (!parent->p)
> +	if (!parent || !parent->p)
>  		return 0;
>  
>  	klist_iter_init(&parent->p->klist_children, &i);
> @@ -4034,7 +4034,7 @@ int device_for_each_child_reverse(struct device *parent, void *data,
>  	struct device *child;
>  	int error = 0;
>  
> -	if (!parent->p)
> +	if (!parent || !parent->p)
>  		return 0;
>  
>  	klist_iter_init(&parent->p->klist_children, &i);
> @@ -4068,7 +4068,7 @@ struct device *device_find_child(struct device *parent, void *data,
>  	struct klist_iter i;
>  	struct device *child;
>  
> -	if (!parent)
> +	if (!parent || !parent->p)
>  		return NULL;

My review comments that I just made previously were more "generic",
sorry.  This change looks fine, there's no additional runtime overhead
for doing this check as we already have to dereference the pointer, so
might as well be consistant.  I'll go queue this up next week when I get
back from conference travel.

thanks,

greg k-h
