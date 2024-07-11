Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107C015957E
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jul 2024 16:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720713608; cv=none; b=p8wEfLrirbAzl4101gLDGSV174NvgtkPg/q0mcOJkFvm9PYW8IjXcuuirifutWaMIQgbi/tq7+6RVAJHVMbbzYDyIVSRF/ZMTTh5/fiHM7BFKgFHfd/2tqiI5dDALqqOBt0rF8+T4syWfgrFtyBuiufl9UNPij/j2BWWXc6WvMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720713608; c=relaxed/simple;
	bh=VIrGBbPtCzX5zZuVtIA285cQGoAa1katLVvvl/dLzrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VuT4fPTgbq4nTrtMHQnKGV6SBuQbLK+9bVrPMTZUb9ZocwDpDjkg4uQr31d5uYo+Cb0EXuuzpkWkZtYqjo2ywhKDdb6Llok2atm7zXX1dkla1S448JmaTzcm+qh5fPuSAWjL5ot7BNToTZwQMOBgDzRnvbQUc9ILYi60/ilvvek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bps2sWBh; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bps2sWBh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720713607; x=1752249607;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VIrGBbPtCzX5zZuVtIA285cQGoAa1katLVvvl/dLzrI=;
  b=bps2sWBhjavpRbJxXOhUNy4qIuZly3p5AZyR6nLLghnMlTB/9feealaH
   hV7x6Fcm/4qfUbHyqisu+XEpDBWPjGobBmpsLOicnn9YcsY6JeJoHSkcG
   svSMr1bc2vPECt8guPZ+TlrxizfVCEK7RfSFDtctU245NQZ0/heWQjFSd
   zJ8cCkB+E4jnjophZAIZepMfQfrpTwXKQqvPWlprb9fCw6I3lxSV5JrPM
   Q7oAYMQob55ZoG7O1tmtwtBpCMZdHbv9I6+hXIHnnhbU/m37lACwJ5BJX
   h+WyqMTxSD3ABbWFG6TGGlU46b1cLdxQoUpnZBRCyLdmrbeXVcTxXxUos
   A==;
X-CSE-ConnectionGUID: 7dlzTXR9Q56T8lPVvZ+GvA==
X-CSE-MsgGUID: KBXsBUxjQCGYctDJLZFZIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="35543186"
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="35543186"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 09:00:07 -0700
X-CSE-ConnectionGUID: FT5qDi66SEeEr/77lg7Hhw==
X-CSE-MsgGUID: 9lFczmA4Sz69AqA/CuQ9uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="48672935"
Received: from ccbilbre-mobl3.amr.corp.intel.com (HELO [10.125.110.51]) ([10.125.110.51])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 09:00:05 -0700
Message-ID: <2052d49f-cd24-4d96-ab15-93afc303a3ba@intel.com>
Date: Thu, 11 Jul 2024 09:00:04 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/3] cxl: Calculate region bandwidth of targets with
 shared upstream link
To: Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com, ira.weiny@intel.com,
 vishal.l.verma@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net
References: <20240710222716.797267-1-dave.jiang@intel.com>
 <20240710222716.797267-3-dave.jiang@intel.com>
 <Zo8317DPRkLOsOlH@aschofie-mobl2>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <Zo8317DPRkLOsOlH@aschofie-mobl2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/10/24 6:39 PM, Alison Schofield wrote:
> On Wed, Jul 10, 2024 at 03:24:01PM -0700, Dave Jiang wrote:
>> The current bandwidth calculation aggregates all the targets. This simple
>> method does not take into account where multiple targets sharing under
>> a switch or a root port where the aggregated bandwidth can be greater than
>> the upstream link of the switch.
>>
>> To accurately account for the shared upstream uplink cases, a new update
>> function is introduced by walking from the leaves to the root of the
>> hierarchy and clamp the bandwidth in the process as needed. This process
>> is done when all the targets for a region are present but before the
>> final values are send to the HMAT handling code cached access_coordinate
>> targets.
>>
>> The original perf calculation path was kept to calculate the latency
>> performance data that does not require the shared link consideration.
>> The shared upstream link calculation is done as a second pass when all
>> the endpoints have arrived.
>>
>> Testing is done via qemu with CXL hierachy. run_qemu[1] is modified to
>> support several CXL hierachy layouts. The following layouts are tested:
>>
>> HB: Host Bridge
>> RP: Root Port
>> SW: Switch
>> EP: End Point
>>
>> 2 HB 2 RP 2 EP: resulting bandwidth: 624
>> 1 HB 2 RP 2 EP: resulting bandwidth: 624
>> 2 HB 2 RP 2 SW 4 EP: resulting bandwidth: 624
>>
>> Current testing, perf number from SRAT/HMAT is hacked into the kernel
>> code. However with new QEMU support of Generic Target Port that's
>> incoming, the perf data injection is no longer needed.
>>
>> [1]: https://github.com/pmem/run_qemu
>>
>> Suggested-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>> Link: https://lore.kernel.org/linux-cxl/20240501152503.00002e60@Huawei.com/
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>
>> ---
>> v7:
>> - Add test notes in commit log. (Dan)
>> - Move cxl_memdev_get_dpa_perf() to cxled_memdev_get_dpa_perf(). (Dan)
>> - Add a DEFINE_FREE(free_perf_xa). (Dan)
>> - Address 2hb2rp2ep issue Jonathan reported. (Jonathan)
>> - Added more kdoc comment headers. (Dan)
> 
> Looks like potential kdocs are not annotated w /** 

Ooof yeah I missed them all. Will fix.

> 
> 
>> - Rename helper functions to be more clear on what they do. (Dan)
>> - Move activiation point to after cxl_region_setup_targets(). (Dan)
>> ---
> 
> snip
> 
>> +/*
>> + * cxl_region_shared_upstream_perf_update - Recalculate the bandwidth for the region
>> + * @cxl_region: the cxl region to recalculate
>> + *
>> + * The function walks the topology from bottom up and calculates the bandwidth. It
>> + * starts at the endpoints, processes at the switches if any, processes at the rootport
>> + * level, at the host bridge level, and finally aggregates at the region.
>> + */
>> +void cxl_region_shared_upstream_bandwidth_update(struct cxl_region *cxlr)
>> +{
>> +	struct xarray *usp_xa, *working_xa;
>> +	int root_count = 0;
>> +	bool is_root;
>> +	int rc;
>> +
>> +	lockdep_assert_held(&cxl_dpa_rwsem);
>> +
>> +	usp_xa = kzalloc(sizeof(*usp_xa), GFP_KERNEL);
>> +	if (!usp_xa)
>>  		return;
>> +
>> +	xa_init(usp_xa);
>> +
>> +	/* Collect bandwidth data from all the endpoints. */
>> +	for (int i = 0; i < cxlr->params.nr_targets; i++) {
>> +		struct cxl_endpoint_decoder *cxled = cxlr->params.targets[i];
>> +
>> +		is_root = false;
>> +		rc = cxl_endpoint_gather_bandwidth(cxlr, cxled, usp_xa, &is_root);
>> +		if (rc) {
>> +			free_perf_xa(usp_xa);
>> +			return;
>> +		}
>> +		root_count += is_root;
>>  	}
>>  
>> +	/* Detect asymmetric hierachy with some direct attached endpoints. */
>> +	if (root_count && root_count != cxlr->params.nr_targets) {
>> +		dev_dbg(&cxlr->dev,
>> +			"Asymmetric hierachy detected, bandwidth not updated\n");
>> +		return;
>> +	}
>> +
>> +	/*
>> +	 * Walk up one or more switches to deal with the bandwidth of the
>> +	 * switches if they exist. Endpoints directly attached to RPs skip
>> +	 * over this part.
>> +	 */
>> +	if (!root_count) {
>> +		do {
>> +			working_xa = cxl_switch_gather_bandwidth(cxlr, usp_xa,
>> +								 &is_root);
>> +			if (IS_ERR(working_xa))
>> +				goto out;
>> +			free_perf_xa(usp_xa);
>> +			usp_xa = working_xa;
>> +		} while (!is_root);
>> +	}
>> +
>> +	/* Handle the bandwidth at the root port of the hierachy */
>> +	working_xa = cxl_rp_gather_bandwidth(usp_xa);
>> +	if (rc)
>> +		goto out;
>> +	free_perf_xa(usp_xa);
> 
> I was going to say something about getting rid of the goto's
> and just freeing and returning in line like was done ~36 lines
> above..but then realize something went astray here in the code
> movement.  Here and below, rc isn't set.

Copy paste mistake looks like. Will fix. Also will remove the gotos. 

> 
> 
>> +	usp_xa = working_xa;
>> +
>> +	/* Handle the bandwidth at the host bridge of the hierachy */
>> +	working_xa = cxl_hb_gather_bandwidth(usp_xa);
>> +	if (rc)
>> +		goto out;
>> +	free_perf_xa(usp_xa);
>> +	usp_xa = working_xa;
>> +
>> +	/*
>> +	 * Aggregate all the bandwidth collected per CFMWS (ACPI0017) and
>> +	 * update the region bandwidth with the final calculated values.
>> +	 */
>> +	cxl_region_update_bandwidth(cxlr, usp_xa);
>> +
>> +out:
>> +	free_perf_xa(usp_xa);
>> +}
> 
> snip
> 
>>
>>
> 
