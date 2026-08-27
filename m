Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD511324B32;
	Thu, 27 Aug 2026 22:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787868685; cv=none; b=fipuUlwKQa2Bu2b41FIDD083edCxi3TZMsblDa5IAqYHR/+nqvhO8usiX8cC85dPfd6Rt1TP5+ZpbX2b4w8oVIsyJzN4zGD/viSmg9HQUZ+gDWHzeVqXvxvgvJaeS5ujBCszBHDqPN8t2jdh0Ui2X10/vXwWUHpeWj4m1RGgpvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787868685; c=relaxed/simple;
	bh=uX0S2UmESjyGWq6tsSbYZrtDXW/+7jm4Gbs35u4jmcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XRLTIvb33P5+QIFBz5yuJ/wfytbYOZjNTMkGOur1tqVu6dEL33E8lf2z5Jd7AurZfXx/HH30uVcdbJs2MAh2NMNvpJSWFmL/n5ay+qWhRTsp8dwTtog10DlOS9xfuLJ99muiun9vIM1tw37cnwbzU/UfOK0W0VnG64kwvC/x6bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=fail smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VUxZMVyI; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VUxZMVyI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787868673; x=1819404673;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uX0S2UmESjyGWq6tsSbYZrtDXW/+7jm4Gbs35u4jmcc=;
  b=VUxZMVyIYqylGpdp5nT85ZQtLkEsLGGkzSAe9juAjcnwSUk5I8kC9l+7
   Yqd7wVUAOxL08hAdYsn/P2qqfem8cybwnaq8opq8TjZJAxTN1dvx2FqTu
   /RQKKpjLkgE8GZ3nJAzmWhaWybMktXmbMqxKXVCNhQ/aQNhJrf+5+XJgI
   Whkmu/KIwYENefMTMLiQroJ1evucpoXKJ7WvFPsv1TBDDBAIH8sutM3po
   06mJu0AhEkkOx/xsTxpuCyGbGO+tWGwruRLL7+in0mdDrhEuqHZQ8qtzY
   ZaDnTUcMyciKsVmyLAKjtHJ86/ec8VhWTDlC2srAcuavseye10OCfb/EG
   g==;
X-CSE-ConnectionGUID: G/4ClQ6ARCaR2iBQW3Fsjw==
X-CSE-MsgGUID: KcBiS/neRBuZMH3EsBAcng==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="99539933"
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="99539933"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 15:11:11 -0700
X-CSE-ConnectionGUID: WAWowepoRY6Q4oJaVs4FgA==
X-CSE-MsgGUID: 0t8qqCcnR1OA+QR8efY88A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="268008018"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.109.124]) ([10.125.109.124])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 15:11:11 -0700
Message-ID: <e3447007-4bc7-46f5-9bd5-f59b84d6113e@intel.com>
Date: Thu, 27 Aug 2026 15:11:09 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/7] cxl/fwctl: Propagate feature RPC delivery errors
To: Richard Cheng <icheng@nvidia.com>, dave@stgolabs.net, jic23@kernel.org,
 alison.schofield@intel.com, vishal.l.verma@intel.com
Cc: iweiny@kernel.org, ming.li@zohomail.com, gourry@gourry.net,
 rrichter@amd.com, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 kees@kernel.org, newtonl@nvidia.com, kristinc@nvidia.com,
 kaihengf@nvidia.com, kobak@nvidia.com
References: <20260826014508.9989-1-icheng@nvidia.com>
 <20260826014508.9989-8-icheng@nvidia.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260826014508.9989-8-icheng@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/25/26 6:45 PM, Richard Cheng wrote:
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
> Changelog:
> 
> v1 -> v2:
> 	- Remove redundant CXL_MBOX_CMD_RC_SUCCESS assignments. (Dave Jiang)
> 
> ---
>  drivers/cxl/core/features.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> index 8d44ce829497..28b326df3398 100644
> --- a/drivers/cxl/core/features.c
> +++ b/drivers/cxl/core/features.c
> @@ -232,7 +232,7 @@ ssize_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
>  	int rc;
>  
>  	if (return_code)
> -		*return_code = CXL_MBOX_CMD_RC_INPUT;
> +		*return_code = CXL_MBOX_CMD_RC_SUCCESS;
>  
>  	if (!feat_out || !feat_out_size)
>  		return -EINVAL;
> @@ -267,9 +267,6 @@ ssize_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
>  		data_rcvd_size += mbox_cmd.size_out;
>  	} while (data_rcvd_size < feat_out_size);
>  
> -	if (return_code)
> -		*return_code = CXL_MBOX_CMD_RC_SUCCESS;
> -
>  	return data_rcvd_size;
>  }
>  
> @@ -289,7 +286,7 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox,
>  	size_t hdr_size;
>  
>  	if (return_code)
> -		*return_code = CXL_MBOX_CMD_RC_INPUT;
> +		*return_code = CXL_MBOX_CMD_RC_SUCCESS;
>  
>  	if (feat_data_size > U16_MAX - offset)
>  		return -EINVAL;
> @@ -341,8 +338,6 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox,
>  
>  		data_sent_size += data_in_size;
>  		if (data_sent_size >= feat_data_size) {
> -			if (return_code)
> -				*return_code = CXL_MBOX_CMD_RC_SUCCESS;
>  			return 0;
>  		}

Minor. the {} can now go.

>  
> @@ -492,6 +487,9 @@ static void *cxlctl_get_feature(struct cxl_features_state *cxlfs,
>  	data_size = cxl_get_feature(cxl_mbox, &feat_in->uuid,
>  				    feat_in->selection, rpc_out->payload,
>  				    count, offset, &return_code);
> +	if (data_size < 0 &&

Do we need to handle the 'data_size == 0' case here?

> +	    return_code == CXL_MBOX_CMD_RC_SUCCESS)
> +		return ERR_PTR(data_size);
>  	*out_len = sizeof(struct fwctl_rpc_cxl_out);
>  	if (data_size <= 0) {
>  		rpc_out->size = 0;
> @@ -544,6 +542,8 @@ static void *cxlctl_set_feature(struct cxl_features_state *cxlfs,
>  	rc = cxl_set_feature(cxl_mbox, &feat_in->uuid,
>  			     feat_in->version, feat_in->feat_data,
>  			     data_size, flags, offset, &return_code);
> +	if (rc && return_code == CXL_MBOX_CMD_RC_SUCCESS)
> +		return ERR_PTR(rc);
>  	*out_len = sizeof(*rpc_out);
>  	if (rc) {
>  		rpc_out->retval = return_code;


We may also need to add something like this because of the change of default return code. The code segment is similar to cxl_xfer_log().

diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
index 28b326df3398..2e62f3720072 100644
--- a/drivers/cxl/core/features.c
+++ b/drivers/cxl/core/features.c
@@ -259,6 +259,17 @@ ssize_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
                        .min_out = data_to_rd_size,
                };
                rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
+               /*
+                * Per CXL r4.0 8.2.10.6.2, when Offset + Count runs past the
+                * end of the Feature the device returns only the bytes up to
+                * the Feature size. cxl_internal_send_cmd() reports that as
+                * -EIO with a short payload, so stop and return what arrived.
+                */
+               if (rc == -EIO && mbox_cmd.size_out &&
+                   mbox_cmd.size_out < data_to_rd_size) {
+                       data_rcvd_size += mbox_cmd.size_out;
+                       break;
+               }
                if (rc < 0 || !mbox_cmd.size_out) {
                        if (return_code)
                                *return_code = mbox_cmd.return_code;
