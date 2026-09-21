Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01815515880
	for <linux-cxl@vger.kernel.org>; Mon, 21 Sep 2026 23:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790033275; cv=none; b=FrvGLhbOUukx/6F6udiQYc8Ln7GliQkK2QC3/kM6Jf8bo+dM0QBJTPHE6KIaFXj1wSyk1xrvJJTgf0eZD55G5/S7NeHTV+6/XjgmA+fPn/GFEeH7G35CqbncHjyweM+h4nL84YfzEssEso27cygTmoLpZkD++mgmqi8R6kfVLKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790033275; c=relaxed/simple;
	bh=wSoBrY5aActZNJwIlPvrhQW9BlTWa1Qxj7fkU+fr53c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mk3WjpRRW45uT7ZrS4GZsJ05LphN0A4d7vjgkY3ybnFasQistWlywBsEBd2AdfUzSKNhovFoBzNqfFTUvHuf7k50pZOEWkdLD7q1pAnlUGapXInEIe2CuUnJ7o+L6Vwb1msgAljBCiCQCSdHet3se61Rx2qCHXbN5JjBGApShhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yv5Ecuxq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yv5Ecuxq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 427FA1F00898;
	Mon, 21 Sep 2026 23:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790033267;
	bh=CD2O14qamazKdXmCdCfA0d7SXfbQFg5TJL747WqEiyM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Yv5EcuxqK9zqCducNsKobk+gA8OHZgbOSAWNguLvtWYIxQxj13qq2qBpLlbxLMRVT
	 KzjtVNrwkJGiWOD4ve+2fYVWA1cCcbdaU77PMF9CrqTtrS8K456Tm7X3N761ZB2lcY
	 J9N/dunGDbUf/M2mKBxCOyiUTKjoyuQIZd5ihQRVUXoJS4gOMXQKbElJX54cWWwbQb
	 4AvphUggjqnOSnaUJt3TvK2TP3ekDsXpv4aURljObj3Hv9RLIVQdPpyd3yJTypqxmE
	 wW3OUT+dUnZKpTm0fyJNDmXbEYJcrpptbaxVXaLtKydnZz1KAtfjwR3+KMHIr7mPVr
	 kdULyOWc1Iidw==
Date: Tue, 22 Sep 2026 00:27:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Anisa Su <anisa.su887@gmail.com>
Cc: linux-cxl@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>, Alison
 Schofield <alison.schofield@intel.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Li Ming <ming.li@zohomail.com>, Gregory Price
 <gourry@gourry.net>, Richard Cheng <icheng@nvidia.com>, Ben Cheatham
 <benjamin.cheatham@amd.com>, Ira Weiny <iweiny@kernel.org>, Anisa Su
 <anisa.su@samsung.com>, Wonjae Lee <wj28.lee@samsung.com>, Junhee Park
 <jh9934.park@samsung.com>, Heesoo Kim <habil.kim@samsung.com>
Subject: Re: [PATCH v14 3/8] cxl/cdat: Gather DSMAS data for DCD partitions
Message-ID: <20260922002743.4b80425a@jic23-hlaptop>
In-Reply-To: <20260918203049.7273-4-anisa.su@samsung.com>
References: <20260918203049.7273-1-anisa.su@samsung.com>
	<20260918203049.7273-4-anisa.su@samsung.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Sep 2026 13:30:12 -0700
Anisa Su <anisa.su887@gmail.com> wrote:

> From: Ira Weiny <iweiny@kernel.org>
> 
> Additional DCD partition (AKA region) information is contained in the
> DSMAS CDAT tables, including performance and shareable attributes.
> 
> Match DCD partitions with DSMAS tables and store the meta data.
> 
> Signed-off-by: Ira Weiny <iweiny@kernel.org>
> Co-developed-by: Anisa Su <anisa.su@samsung.com>
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> Tested-by: Wonjae Lee <wj28.lee@samsung.com>
> Tested-by: Junhee Park <jh9934.park@samsung.com>
> Tested-by: Heesoo Kim <habil.kim@samsung.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> 
One little thing inline. Either way
Reviewed-by: Jonathan Cameron <joanthan.cameron@oss.qualcomm.com>

> @@ -419,12 +443,13 @@ void cxl_endpoint_parse_cdat(struct cxl_port *port)
>  	}
>  
>  	rc = cxl_port_perf_data_calculate(port, dsmas_xa);
> -	if (rc) {

This ended up a bit nasty from an unusual code structure being less
readable than ideal point of view.

> +	if (rc)
>  		dev_dbg(&port->dev, "Failed to do perf coord calculations.\n");
> +
> +	cxl_memdev_apply_dsmas(cxlds, dsmas_xa, rc == 0);
> +	if (rc)
>  		return;
> -	}
Can you make this
	rc = cxl_port_perf_data_calculate(port, dmsas_xa);
	cxl_memdev_apply_dsmas(cxlds, dsmas_xa, rc == 0);
	if (rc) {
		dev_dbg(&port->dev, "Failed to do perf coord calculations.\n");
		return;
	}

or just duplicate to keep things simple to read.

	rc = cxl_port_perf_data_calculate(port, dmsas_xa);
	if (rc) {
		dev_dbg(&port->dev, "Failed to do perf coord calculations.\n");
		cxl_memdev_apply_dsmas(cxlds, dsmas_xa, false);
		return;
	}

	cxl_memdev_apply_dsmas(cxlds, dsmas_xa, true);

	...
Second one probably a little better as keeps messages i order if we
happen to get a print from cxl_memdev_apply_dsmas()



>  
> -	cxl_memdev_set_qos_class(cxlds, dsmas_xa);
>  	cxl_qos_class_verify(cxlmd);
>  	cxl_memdev_update_perf(cxlmd);
>  }


