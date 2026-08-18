Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E1F227BB9;
	Tue, 18 Aug 2026 23:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787097122; cv=none; b=Tqvs4q70kB2S34ULOuGZw6GzZBRa0mYrsOkyyjRaDG5wCuqfZQIqYzSr7ojErekhsW0OAst8CSLaVR0DvjG6U99w0mggcKdSf8N2ysI5Mr9qVXTCPgp9moOtWWCj3MTR5cbX40dSYiQ5ppzU+DUWGNyzcUfko1U/zGl/BRrEyKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787097122; c=relaxed/simple;
	bh=L990xuR/6vaRQh3yoOojeocPtioHO71nxgXks9/gB4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sbKSx14f7yn5dtVgQPDMkf550buQJjoaUxou7rq/yUkb1qTIJj+5XS/Hr6V19R4jX2tS02noLEdCZcu0eqxSnlAlTtZnnOuYtARp+Wk7TWXX7Sll9NyW3hm/U/PZayjJ16jIVB9dVh7SyQilpdFz75wxdiO6J4WgG343WmIMLMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RleUt1hl; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RleUt1hl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787097121; x=1818633121;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=L990xuR/6vaRQh3yoOojeocPtioHO71nxgXks9/gB4M=;
  b=RleUt1hlEyNPoXOv+6Uh4uIBlMySnu1PMzopQuzgxMeanjXz9g6TrIU6
   NIYL/uhysmHEdQ3Y9f2Q9S2Uw8+WZsZZ8Ziwyx1oVQSy6W31swnuDY97e
   gKPs9/OlwjvG0kUP03fNxQdOdDHPnT3IzXxE+URBTcmlzuT7Lh9Ek/F5B
   RqEHpY+J+IuxQZZ8ETFYn9gpJZnuJs6r2yW23xaEWfZ2ZWbqfOiBM3pyf
   RDLihPd5hqsps6x92aFo6ZQbpXhrXGoBF14tvAf0nNS39YU5d1KNoMKyZ
   YbUnRkrfegLJoukCF3rA9Yr7phmcx3IQ/jn2mRMXCjTdXmyoM5eYaUl55
   Q==;
X-CSE-ConnectionGUID: 1E60y40GSHuDvRM17MXyfA==
X-CSE-MsgGUID: z+QScdsfTUqkt2LWfL614A==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="113145190"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="113145190"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 16:52:00 -0700
X-CSE-ConnectionGUID: ix78zv/qToiXtcyu8+KZjg==
X-CSE-MsgGUID: mHBW4kBOQduqOqA1pKQ/2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="267340353"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.111.209]) ([10.125.111.209])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 16:51:57 -0700
Message-ID: <b0741acd-327d-43ce-94d8-8f06730e2430@intel.com>
Date: Tue, 18 Aug 2026 16:51:56 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/7] cxl/fwctl: Propagate feature RPC delivery errors
To: Richard Cheng <icheng@nvidia.com>, dave@stgolabs.net, jic23@kernel.org,
 alison.schofield@intel.com, vishal.l.verma@intel.com
Cc: iweiny@kernel.org, ming.li@zohomail.com, gourry@gourry.net,
 rrichter@amd.com, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 kees@kernel.org, newtonl@nvidia.com, kristinc@nvidia.com,
 kaihengf@nvidia.com, kobak@nvidia.com
References: <20260813034538.13189-1-icheng@nvidia.com>
 <20260813034538.13189-8-icheng@nvidia.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260813034538.13189-8-icheng@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/12/26 8:45 PM, Richard Cheng wrote:
> FWCTL_RPC requires delivery failures to be returned as ioctl errors,
> while device errors are reported in the output. Get and Set Feature
> instead converted all failures into normal responses, sometimes with a
> SUCCESS device status.
> 
> Initialize the return code to SUCCESS. When the helper fails without a
> device error code, return its errno. Continue reporting actual device
> errors through rpc_out->retval.
> 
> Fixes: 5908f3ed6dc2 ("cxl: Add support to handle user feature commands for get feature")
> Fixes: eb5dfcb9e36d ("cxl: Add support to handle user feature commands for set feature")
> Signed-off-by: Richard Cheng <icheng@nvidia.com>
> ---
>  drivers/cxl/core/features.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> index 8d44ce829497..30e00faaf3a9 100644
> --- a/drivers/cxl/core/features.c
> +++ b/drivers/cxl/core/features.c
> @@ -232,7 +232,7 @@ ssize_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
>  	int rc;
>  
>  	if (return_code)
> -		*return_code = CXL_MBOX_CMD_RC_INPUT;
> +		*return_code = CXL_MBOX_CMD_RC_SUCCESS;

With "success" set here, should we drop setting of *return_code at the end of function since it's no longer necessary?

>  
>  	if (!feat_out || !feat_out_size)
>  		return -EINVAL;
> @@ -289,7 +289,7 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox,
>  	size_t hdr_size;
>  
>  	if (return_code)
> -		*return_code = CXL_MBOX_CMD_RC_INPUT;
> +		*return_code = CXL_MBOX_CMD_RC_SUCCESS;

I think similar for this function as the previous comment?

DJ

>  
>  	if (feat_data_size > U16_MAX - offset)
>  		return -EINVAL;
> @@ -492,6 +492,9 @@ static void *cxlctl_get_feature(struct cxl_features_state *cxlfs,
>  	data_size = cxl_get_feature(cxl_mbox, &feat_in->uuid,
>  				    feat_in->selection, rpc_out->payload,
>  				    count, offset, &return_code);
> +	if (data_size < 0 &&
> +	    return_code == CXL_MBOX_CMD_RC_SUCCESS)
> +		return ERR_PTR(data_size);
>  	*out_len = sizeof(struct fwctl_rpc_cxl_out);
>  	if (data_size <= 0) {
>  		rpc_out->size = 0;
> @@ -544,6 +547,8 @@ static void *cxlctl_set_feature(struct cxl_features_state *cxlfs,
>  	rc = cxl_set_feature(cxl_mbox, &feat_in->uuid,
>  			     feat_in->version, feat_in->feat_data,
>  			     data_size, flags, offset, &return_code);
> +	if (rc && return_code == CXL_MBOX_CMD_RC_SUCCESS)
> +		return ERR_PTR(rc);
>  	*out_len = sizeof(*rpc_out);
>  	if (rc) {
>  		rpc_out->retval = return_code;

