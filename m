Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35926381EB9
	for <linux-cxl@vger.kernel.org>; Wed, 16 Sep 2026 18:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789581681; cv=none; b=NNnhqVyksckTJ+IcGDcfF8WvhS0vpL32/Azl6OCX+hV/+T32ft10VGh8kQa6PKqanyphJzvA6hbUE3di3XU7pIjFs6o7PYHgr+riIiASRnl4JVeSEDG4/b+HLhyejk1daR9F5PsA9Fdb/YrodAGNfBFfhWWAAxk5ixniFiaac60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789581681; c=relaxed/simple;
	bh=kjgHeNOiJVQWfbxeDzVf1gvO+8wiXVNB+tfevnxf7W8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KwoN9h1XmPXIYZOOeINF+FRYU4iAysmuBnDokDJrragbS3s5Hcwa4XQRJis+f42VjwKEIyDzyqv/bWgcVIAdKQzlgX5nSHqlth2XYNbPktWFgsWO2X2fU5ABzvvALsZNGT3WWFEvXMNLoSR+vEB8MOyNMkDhoviBGPfg6TvXaI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lbop9vM5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lbop9vM5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B82B1F000FF;
	Wed, 16 Sep 2026 18:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789581666;
	bh=/IeEufI7a2f70BZJbdLtjLx8H08rdvLVS1Blm/Fu/iQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lbop9vM581cZgox3PznkSPHVSvCe3DGbSgr+tjDGPijuBn5tCQoNMt+Jtwbp3KfeT
	 J/V1qVNCmfm1uLv41Ilom00RtyRwc+x8+FQBN3OQylBXkv/r4Ynay+rbiV294Bk5Nm
	 0uaRIOMvoVOcJxDaLacBpCzLufRC37pCek2f1J5b+Se3f2FIK2XjcH06zA0GJL+tkj
	 X2tMQMdSFeOLMuAPeaRphigwUUAGVPPFcnctCZfgD0iLjCjmXCKGkNTwkjEObuUJy6
	 eGhMOEBN9c0nygt84RqqO9HSRG6YUA8YeIXuZd9DawtOHfnE9JpEZZ1QF+rH0K9+qB
	 k2A8AU/qBDzjA==
Date: Wed, 16 Sep 2026 19:00:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>, Vishal Verma
 <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>, Ira Weiny
 <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
 linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/region: Create node access attributes for
 CFMWS-only NUMA nodes
Message-ID: <20260916190059.66a15306@jic23-hlaptop>
In-Reply-To: <20260916120338.369436-1-kanie@linux.alibaba.com>
References: <20260916120338.369436-1-kanie@linux.alibaba.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Sep 2026 20:03:38 +0800
Guixin Liu <kanie@linux.alibaba.com> wrote:

> A NUMA node that only backs a CXL fixed memory window and is not
> enumerated by SRAT has no memory_target in the HMAT code. When the
> first memory of such a node comes online, hmat_callback() exits early
> at find_mem_target() without creating anything, and
> node_update_perf_attrs() only updates attributes that already exist,
> so the node never gets its accessN sysfs attributes at all:
> /sys/devices/system/node/nodeX/accessN/initiators/* stays missing even
> though the region's own sysfs reports the coordinates.
> 
> Commit debdce20c4f2 ("cxl/region: Deal with numa nodes not enumerated
> by SRAT") handled this by having the CXL region notifier call
> node_set_perf_attrs() directly for such nodes, but
> 
>   commit 2e454fb8056d ("cxl, acpi/hmat: Update CXL access coordinates
>   directly instead of through HMAT")
> 
> replaced that call with node_update_perf_attrs() on the assumption
> that the HMAT callback has already created the attributes. That
> assumption does not hold for CFMWS-only nodes.
> 
> Restore the distinction: when the node is not backed by a real SRAT
> pxm, create the attributes with node_set_perf_attrs() instead of
> only trying to update them.
> 
> Tested on a QEMU CXL topology with a CFMWS window whose memory is not
> described by SRAT or HMAT: after the region's first memory block comes
> online, node1 has no accessN directory before this patch; with it,
> node1/access0/initiators/{read,write}_{bandwidth,latency} appear with
> the calculated coordinates.
> 
> Fixes: 2e454fb8056d ("cxl, acpi/hmat: Update CXL access coordinates directly instead of through HMAT")
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>

Ah.  I should have caught this one.  Indeed looks correct.

My only concern is it is relying heavily on the fact we only do this
once which is not apparent at this layer in the code.  You need to go
looking in cxl_region_perf_attrs_callback() for that.

It is also a one way gate so even you tear down all regions in the NUMA
node (so the CFWMS) we don't do this update again.

Anyhow, I think all we need here is a note that this function will only
be called once per CFWMS and thus it is fine to register the sysfs attrs
here.

With that added, this looks good to me
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>


> ---
> checkpatch reports one "Prefer a maximum 75 chars per line" warning:
> the 2e454fb8056d reference line above is 84 columns because checkpatch
> requires the quoted title to match the git subject exactly, and that
> subject is 62 characters long. Wrapping it instead produces a
> GIT_COMMIT_ID error, so the long line is the lesser evil.
>  drivers/cxl/core/cdat.c   | 5 +++++
>  drivers/cxl/core/core.h   | 1 +
>  drivers/cxl/core/region.c | 5 ++++-
>  3 files changed, 10 insertions(+), 1 deletion(-)
> ---
>  drivers/cxl/core/cdat.c   | 5 +++++
>  drivers/cxl/core/core.h   | 1 +
>  drivers/cxl/core/region.c | 5 ++++-
>  3 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index 5c9f07262513..e28c40159d94 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -1072,3 +1072,8 @@ void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
>  		cxlr->coord[i].write_bandwidth += perf->coord[i].write_bandwidth;
>  	}
>  }
> +
> +bool cxl_need_node_perf_attrs_update(int nid)
> +{
> +	return !acpi_node_backed_by_real_pxm(nid);
> +}
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 35eaf636adc9..19a5b8edbfda 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -229,4 +229,5 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
>  
>  resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>  					   struct cxl_dport *dport);
> +bool cxl_need_node_perf_attrs_update(int nid);
>  #endif /* __CXL_CORE_H__ */
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 27e63e6dab7c..636435733754 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2630,7 +2630,10 @@ static bool cxl_region_update_coordinates(struct cxl_region *cxlr, int nid)
>  
>  	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
>  		if (cxlr->coord[i].read_bandwidth) {
> -			node_update_perf_attrs(nid, &cxlr->coord[i], i);
> +			if (cxl_need_node_perf_attrs_update(nid))
> +				node_set_perf_attrs(nid, &cxlr->coord[i], i);
> +			else
> +				node_update_perf_attrs(nid, &cxlr->coord[i], i);
>  			cset++;
>  		}
>  	}

