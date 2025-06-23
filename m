Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C886AD51;
	Mon, 23 Jun 2025 09:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750670856; cv=none; b=DKlgXi1TJs+cIae6qn8oMVVsALbVplvkzxnkHhIo2q07j7NOncWzlOxXDOULblMulFVTvDwJKErg2Lpd93aVEolx84wh/W0ZOkHJDEUKr4XhqB+cK5KgUdr6vf7Ay5vI+aVHfyfrNjmGsanHfcYT4Brs4U/7DMq+d5xgTByfqcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750670856; c=relaxed/simple;
	bh=q7oJSYwirHOOEYci9Vsvx/PmgyNKO2aIYxM5EObmOXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tnF6T446Vvq07QfK9yCXrVMCnOpuk+p88oR7iAuv6rObr3OBgk9Y77lc6R6zVxhzUCzScQD4tZ9NsBLCupOXtCGM7xiwiyaCVpLu04ufkMlN4drsxyVckrw/CGBHon7gewE+X3JJHZFHoHDy+OYFEBeuGkmUB++17qdOGy6akFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ESdAMab6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ESdAMab6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E27AC4CEEA;
	Mon, 23 Jun 2025 09:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750670855;
	bh=q7oJSYwirHOOEYci9Vsvx/PmgyNKO2aIYxM5EObmOXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ESdAMab6d81Q7RX3glu6wx3ZVAyvGuwGx2KY6WmdSSL8+XN1BsnMjO2aoYzE2lJVR
	 ovIRp100yEvaP4BmfymeewpZ3CzCyIEQOmeZOWJOBo5SV+snCnawcHDRp3jvrOWUlq
	 D1Vi/z0hA0EN7pKwY86DHDDBEg4AsxxnDUHItF3k=
Date: Mon, 23 Jun 2025 11:27:33 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Pranav Tyagi <pranav.tyagi03@gmail.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com, ming.li@zohomail.com,
	rrichter@amd.com, jeff.johnson@oss.qualcomm.com,
	peterz@infradead.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] cxl/port: automate cleanup with __free()
Message-ID: <2025062343-brilliant-laziness-e2cf@gregkh>
References: <20250623091929.366357-1-pranav.tyagi03@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623091929.366357-1-pranav.tyagi03@gmail.com>

On Mon, Jun 23, 2025 at 02:49:29PM +0530, Pranav Tyagi wrote:
> Use the scope based resource management (defined in linux/cleanup.h) to
> automate the lifetime control of struct cxl_endpoint_decoder. This
> eliminates the explicit kfree() call and makes the code more robust and
> maintainable in presence of early returns.
> 
> Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
> ---
>  drivers/cxl/core/port.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index eb46c6764d20..c35946882b20 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -10,6 +10,7 @@
>  #include <linux/slab.h>
>  #include <linux/idr.h>
>  #include <linux/node.h>
> +#include <linux/cleanup.h>
>  #include <cxl/einj.h>
>  #include <cxlmem.h>
>  #include <cxlpci.h>
> @@ -1888,14 +1889,14 @@ EXPORT_SYMBOL_NS_GPL(cxl_switch_decoder_alloc, "CXL");
>   */
>  struct cxl_endpoint_decoder *cxl_endpoint_decoder_alloc(struct cxl_port *port)
>  {
> -	struct cxl_endpoint_decoder *cxled;
>  	struct cxl_decoder *cxld;
>  	int rc;
>  
>  	if (!is_cxl_endpoint(port))
>  		return ERR_PTR(-EINVAL);
>  
> -	cxled = kzalloc(sizeof(*cxled), GFP_KERNEL);
> +	struct cxl_endpoint_decoder *cxled __free(kfree) =
> +		kzalloc(sizeof(*cxled), GFP_KERNEL);
>  	if (!cxled)
>  		return ERR_PTR(-ENOMEM);
>  
> @@ -1904,7 +1905,6 @@ struct cxl_endpoint_decoder *cxl_endpoint_decoder_alloc(struct cxl_port *port)
>  	cxld = &cxled->cxld;
>  	rc = cxl_decoder_init(port, cxld);
>  	if (rc)	 {
> -		kfree(cxled);
>  		return ERR_PTR(rc);
>  	}
>  
> -- 
> 2.49.0

Note, I can't speak for the maintainers of this subsystem, but
generally, making changes like this for no real good reason, for code
that has been around for years, is really not needed at all.

If you fix a bug with it, sure, but changes for the sake of "let's use
this new feature" in here really might not be necessary.

Why not add cleanup.h support to code paths that actually fix existing
bugs instead?

Also, you have added some coding style errors to the code now with this
patch, which also is generally not considered a good idea :)

thanks,

greg k-h
