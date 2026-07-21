Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300A6471243
	for <linux-cxl@vger.kernel.org>; Tue, 21 Jul 2026 23:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784678215; cv=none; b=Yws6sHoOUOlYCRck5ywpgFOfRunFZW0RmoEY3LsPc1gqog/OLbaNY9A8XcbSCVDKS3ClnRC6TVFTi59j0DkOgFoP3PU2dvaGsYvjs2MEoJORjO2PEryJN23+AbnJeYrE6F0O13bcZdUMsPTLMMPIm0Ls1ugYGMcVaJi7ZArMfJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784678215; c=relaxed/simple;
	bh=BJRGUNKMz+RzawRXASXIsXO7+mnQVFfCyUFDT5mB558=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lnZqtmSqXFezhGJ8B7PBgRUxK5t0lnlxmJ67sD3y+/WZJrycBqwNAL68cKlxwf59Jh+DYL6c696HL4VoNQC8eMt8qUr7yCgmkkaTFkMMOTcKM8cRlTZVYwbnYL/JB8yYJFPWfMnKNSM/8NruIdkL6YXADtQT9SQN3arYZVhSY50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lswdQSnS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lswdQSnS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 461391F000E9;
	Tue, 21 Jul 2026 23:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784678213;
	bh=DG1uYWICheKw8iTlNzqeWrHqepDkwI3THdmQnVn+jJE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lswdQSnSIRqoLsic0butxHhUeVhDPmMms6gE7Z0xNvZDjZu007rmw/bsGPZBLe7+7
	 21xZ8SpWhhuRObci8xfN29Y9FNebQiP6l2CSqThgKfbzWmYqXd/TuOb9HuWKr7GGJC
	 M1VQVj/1zM7cNvN/GpeU+3XDCEab41iXWiGmD+cRBErsNLn3N1dyxFm6GgMqir/14V
	 32fpMH73f4g+pkam1uotsXEc7Zh/PmoevmKH4MgYhNreXighfYH8ED4BE0jlff7Oyj
	 wIbWkJ5SeXPRnQ0xESKiWaURC1w+i+sWSs/4wgjHs/Cuhw65E+qFuTLG3Xz7zrBX2c
	 4O583C3OxHMpg==
Date: Wed, 22 Jul 2026 00:56:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Dan
 Williams <djbw@kernel.org>, Li Ming <ming.li@zohomail.com>,
 linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 2/2] cxl/region: Use __free(put_device) in
 find_pos_and_ways()
Message-ID: <20260722005648.360ddf68@jic23-huawei>
In-Reply-To: <03aceaa0001651c28f221988c9e845f59bf1d84d.1784654628.git.alison.schofield@intel.com>
References: <3a36953b5c665cb9544ba61dafbea0b0fa508c77.1784654628.git.alison.schofield@intel.com>
	<03aceaa0001651c28f221988c9e845f59bf1d84d.1784654628.git.alison.schofield@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Jul 2026 10:37:04 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> Use __free(put_device) for the switch decoder reference returned by
> device_find_child() instead of releasing it with an open-coded
> put_device().
> 
> This matches the scoped device reference handling used elsewhere in
> the file.
> 
> Suggested-by: Li Ming <ming.li@zohomail.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
> 
> This is a new patch added in series after the UAF fixup in patch 1/2.
> 
> 
>  drivers/cxl/core/region.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index c86dd9d55e93..4d7d96d03ece 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1911,9 +1911,9 @@ static int match_switch_decoder_by_range(struct device *dev,
>  static int find_pos_and_ways(struct cxl_port *port, struct range *range,
>  			     int *pos, int *ways)
>  {
> +	struct device *dev __free(put_device) = NULL;

No to this.  See rules in cleanup.h.
This is the path to grumpy Linus if he happens to spot it.

Short story is declaration and destructor must be in same statement
as the constructor.  Here that means 

	struct device *dev __free(put_device) =
		device_find_child(&parent->dev, range, match_switch_decoder_by_range);

I would go long on that second line given it's only a bit beyond 80 chars
and the two lines are horrible enough to read without becoming 3.



>  	struct cxl_switch_decoder *cxlsd;
>  	struct cxl_port *parent;
> -	struct device *dev;
>  	int rc = -ENXIO;
>  
>  	parent = parent_port_of(port);
> @@ -1945,8 +1945,6 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
>  			dev_name(port->parent_dport->dport_dev),
>  			dev_name(&cxlsd->cxld.dev));
>  
> -	put_device(dev);
> -
>  	return rc;
>  }
>  

