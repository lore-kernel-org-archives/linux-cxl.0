Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA88C3D349F;
	Mon, 27 Apr 2026 17:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777310842; cv=none; b=l/zt32yvCqxYN2ObjNlhnpe61hmqKYL4j7WLz5GKD1Ds7Nc3W9tuxOr6qe/qpy7g+H7oc6N7/6yW/o/nMi0vRspSHmc1uQUd9jKb+hTSL3yQtlEYvDWQPG0lI1/2yyQHm/mLl821tb/VEsQUfKpmTOMDh4gwTSd+TzeC3VUgcT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777310842; c=relaxed/simple;
	bh=NYq9lXFC8KudYcnqYdHndij86Ukhz0k+Dqz0gchRTU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DXckG7UQsgpg8P7095nzkbzf+mu75QcWMFddX6j/2n0ow8QHLAOcwnCKMUIpFFeF3GNzxRRTrbDW2HwgGDJVjqRpcVPVUbEU+UGYlE8xTCjNWdp+79NMYkeB7QNuxO6hMxRSXMjaWm86trdeNhUHJtcV+7N9nABst5uaW+7ObGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nS3qMrUx; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nS3qMrUx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777310840; x=1808846840;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NYq9lXFC8KudYcnqYdHndij86Ukhz0k+Dqz0gchRTU8=;
  b=nS3qMrUxLMIjVfwz6DZCPZT4vWJwYjyBHQ5Md+w8ULRmMnbhzpBpBUkW
   RG+sgr5lbBj3VU+glf9tkTS7OTsfIPKpE6YyxevfGyURA41qj2kPf3QuZ
   7cK9EGTtwxWG0GHEwwnLiCnMkibxkyusNctU6j309tiy3gbatFjlTSYvJ
   Ly+dvVK1FKYAhyOMX+xVXk3QKQ8WOLEw0ypNN//MOQAxsO/83h3h4IxmU
   RMlt6nZc+TAXnoZDZVa0jfRppcxkK2yP22KY12owzIe/Iw6jYyK7brFSZ
   h6svYnP6L5WlJDXXVdtbzMibGJHvmAMJob6LzHCYm6J0Nn+GI3ge2Zj8R
   g==;
X-CSE-ConnectionGUID: /+++KLKHQYOWvfvWEUfn7Q==
X-CSE-MsgGUID: GcGRywLiRDKQWaWU0uVAcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="89295395"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="89295395"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 10:27:19 -0700
X-CSE-ConnectionGUID: 5lH2qBWVRACMg5n2h36Ntg==
X-CSE-MsgGUID: f0hBJUXaRkWHf0egUI5ZeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="233573391"
Received: from msatwood-mobl.amr.corp.intel.com (HELO [10.125.108.172]) ([10.125.108.172])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 10:27:18 -0700
Message-ID: <5d122716-440c-465f-a999-a9e1fa8e308d@intel.com>
Date: Mon, 27 Apr 2026 10:27:17 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] cxl/region: serialize devm action removal via
 scheduled work
To: Sungwoo Kim <iam@sung-woo.kim>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jic23@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <djbw@kernel.org>
Cc: Dave Tian <daveti@purdue.edu>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260427032010.916681-2-iam@sung-woo.kim>
 <20260427032010.916681-4-iam@sung-woo.kim>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260427032010.916681-4-iam@sung-woo.kim>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/26/26 8:20 PM, Sungwoo Kim wrote:
> devm_remove_action() must be called (1) only once and (2) only if the
> device is still bound to a driver. However, several race conditions
> allow multiple calls to devm_remove_action().
> 
> For example, delete_region_store() and devres_release_all() can race [1]:
> 
> CPU0                                    CPU1
> devres_release_all()
>    // take devres_lock
>    remove_nodes(devres_head) // mv to local todo
>    // drop devres_lock                   delete_region_store()
>                                            cxlr = cxl_find_region_by_name()  // success
>                                            devm_release_action(unregister_region)
>                                              devres_release()
>                                                devres_remove()
>                                                  // hold devres_lock
>                                                  find_dr(devres_head) // does not find it
>                                              WARN_ON(-ENOENT)
>    release_nodes() // drain todo
>      unregister_region(cxlr) // release() cb
>        device_del()
> 
> To prevent this, this patch introduces a new function,
> remove_devm_actions(), that safely performs devm_release_action().
> 
> remove_devm_actions() guarantees that devm_release_action() is called
> only once by guarding with a flag. Also, it checks if the device is
> still bound to a driver before calling devm_remove_action().
> 
> In order to check the binding, a device lock must be held. To do this,
> Dan suggested [2] using a workqueue, since a new work has no prior lock
> and is clean to acquire a device lock.
> 
> [1] https://lore.kernel.org/linux-cxl/20260310183644.4rwc7ilmzy4t5xp6@offworld/
> [2] https://lore.kernel.org/linux-cxl/69b0a0f8bfb0b_213210026@dwillia2-mobl4.notmuch/
> 
> Suggested-by: Dan Williams <djbw@kernel.org>
> Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
> ---
>  drivers/cxl/core/port.c   |  6 ++++++
>  drivers/cxl/core/region.c | 27 +++++++++++++++++++++++++++
>  drivers/cxl/cxl.h         |  9 +++++++++
>  3 files changed, 42 insertions(+)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index c5aacd7054f1..2f142cea7f26 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -2305,6 +2305,12 @@ bool schedule_cxl_memdev_detach(struct cxl_memdev *cxlmd)
>  }
>  EXPORT_SYMBOL_NS_GPL(schedule_cxl_memdev_detach, "CXL");
>  
> +bool schedule_cxl_region_remove_devm_actions(struct cxl_region *cxlr)
> +{
> +	return queue_work(cxl_bus_wq, &cxlr->remove_work);
> +}
> +EXPORT_SYMBOL_NS_GPL(schedule_cxl_region_remove_devm_actions, "CXL");
> +
>  static void add_latency(struct access_coordinate *c, long latency)
>  {
>  	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index e50dc716d4e8..b086ae88b5bb 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -39,6 +39,7 @@
>  static nodemask_t nodemask_region_seen = NODE_MASK_NONE;
>  
>  static struct cxl_region *to_cxl_region(struct device *dev);
> +static void remove_devm_actions_work(struct work_struct *work);
>  
>  #define __ACCESS_ATTR_RO(_level, _name) {				\
>  	.attr	= { .name = __stringify(_name), .mode = 0444 },		\
> @@ -2589,6 +2590,8 @@ static struct cxl_region *cxl_region_alloc(struct cxl_root_decoder *cxlrd, int i
>  	dev->type = &cxl_region_type;
>  	cxl_region_setup_flags(cxlr, &cxlrd->cxlsd.cxld);
>  
> +	INIT_WORK(&cxlr->remove_work, remove_devm_actions_work);
> +
>  	return cxlr;
>  }
>  
> @@ -2831,6 +2834,30 @@ cxl_find_region_by_name(struct cxl_root_decoder *cxlrd, const char *name)
>  	return to_cxl_region(region_dev);
>  }
>  
> +static bool remove_devm_actions(struct cxl_region *cxlr)
> +{
> +	return schedule_cxl_region_remove_devm_actions(cxlr);
> +}
> +
> +static void remove_devm_actions_work(struct work_struct *work)
> +{
> +	struct cxl_region *cxlr = container_of(work, typeof(*cxlr), remove_work);
> +	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
> +	struct cxl_port *port = to_cxl_port(cxlrd->cxlsd.cxld.dev.parent);
> +
> +	if (test_and_set_bit(CXL_REGION_F_DEVM_REMOVE, &cxlr->flags)) {
> +		put_device(&cxlr->dev);
> +		return;
> +	}
> +
> +	scoped_guard(device, port->uport_dev) {
> +		if (port->uport_dev->driver)
> +			devm_remove_action(port->uport_dev, unregister_region, cxlr);
> +	}
> +
> +	put_device(&cxlr->dev);
> +}
> +
>  static ssize_t delete_region_store(struct device *dev,
>  				   struct device_attribute *attr,
>  				   const char *buf, size_t len)
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 1297594beaec..31ca4e6676ed 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -447,6 +447,12 @@ struct cxl_region_params {
>   */
>  #define CXL_REGION_F_NORMALIZED_ADDRESSING 3
>  
> +/* Indicate that this region is being unregistered to prevent a race. */
> +#define CXL_REGION_F_UNREGISTER 4

I would flip the define of this with the one below and move this define to the second patch, since it is not being used here. Otherwise everything else LGTM.

DJ

> +
> +/* Indicate that this region called devm_remove_action. */
> +#define CXL_REGION_F_DEVM_REMOVE 5
> +
>  /**
>   * struct cxl_region - CXL region
>   * @dev: This region's device
> @@ -462,6 +468,7 @@ struct cxl_region_params {
>   * @coord: QoS access coordinates for the region
>   * @node_notifier: notifier for setting the access coordinates to node
>   * @adist_notifier: notifier for calculating the abstract distance of node
> + * @remove_work: trigger the remove action in a safe context to acquire locks
>   */
>  struct cxl_region {
>  	struct device dev;
> @@ -477,6 +484,7 @@ struct cxl_region {
>  	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
>  	struct notifier_block node_notifier;
>  	struct notifier_block adist_notifier;
> +	struct work_struct remove_work;
>  };
>  
>  struct cxl_nvdimm_bridge {
> @@ -733,6 +741,7 @@ struct cxl_port *cxl_pci_find_port(struct pci_dev *pdev,
>  struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd,
>  				   struct cxl_dport **dport);
>  bool schedule_cxl_memdev_detach(struct cxl_memdev *cxlmd);
> +bool schedule_cxl_region_remove_devm_actions(struct cxl_region *cxlr);
>  
>  struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
>  				     struct device *dport, int port_id,

