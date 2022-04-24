Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C143FC433EF
	for <linux-cxl@archiver.kernel.org>; Sun, 24 Apr 2022 23:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239900AbiDXXdP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 24 Apr 2022 19:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239908AbiDXXdO (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 24 Apr 2022 19:33:14 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA47A0
        for <linux-cxl@vger.kernel.org>; Sun, 24 Apr 2022 16:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650843010; x=1682379010;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0CAbJtUc7XDbq6Yn9U3wpzXeAjyQ4oUgrOuSSEHobxQ=;
  b=nHwuJ34LxcEheGv9KGqFgnqQVN9MStg4p86hTFYAP/ZxItk9BucRcx+P
   YeTuNUZPYYDqzli6ILFDfz3LwRhOiy7qK4PVj9Xp92P0LqFBiRdl54xBC
   OzW5d4EsGszQzy83Y0wUTObe68ATuyORbs5avw6vANEhzirFNYCV5wDjb
   l6FkDZTgwzCrhvFiICrBUhmkq7ARhPDMjSCvIhYBzrVyvBGt1TjNtcf6I
   dSSOQoqhLfOQbzxQUTfGz90sv9fvCeCu02ySG01pclTeCvvR9sSMlF+sj
   aC4/1rw9HBtw6xiZnMH4jiuFqBIBWUXcv/6AEZQH/E/EsYLgKt2ZAgBXF
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10327"; a="252457089"
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="252457089"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2022 16:30:08 -0700
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="531836478"
Received: from hungyuan-mobl.amr.corp.intel.com (HELO localhost) ([10.212.88.155])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2022 16:30:07 -0700
Date:   Sun, 24 Apr 2022 16:30:07 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Subject: Re: [PATCH v4 8/8] nvdimm: Fix firmware activation deadlock scenarios
Message-ID: <YmXdf2zGuzNdOoPI@iweiny-desk3>
References: <165055523099.3745911.9091010720291846249.stgit@dwillia2-desk3.amr.corp.intel.com>
 <165074883800.4116052.10737040861825806582.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165074883800.4116052.10737040861825806582.stgit@dwillia2-desk3.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Sat, Apr 23, 2022 at 02:22:18PM -0700, Dan Williams wrote:
> Lockdep reports the following deadlock scenarios for CXL root device
> power-management, device_prepare(), operations, and device_shutdown()
> operations for 'nd_region' devices:
> 
> ---
>  Chain exists of:
>    &nvdimm_region_key --> &nvdimm_bus->reconfig_mutex --> system_transition_mutex
> 
>   Possible unsafe locking scenario:
> 
>         CPU0                    CPU1
>         ----                    ----
>    lock(system_transition_mutex);
>                                 lock(&nvdimm_bus->reconfig_mutex);
>                                 lock(system_transition_mutex);
>    lock(&nvdimm_region_key);
> 
> --
> 
>  Chain exists of:
>    &cxl_nvdimm_bridge_key --> acpi_scan_lock --> &cxl_root_key
> 
>   Possible unsafe locking scenario:
> 
>         CPU0                    CPU1
>         ----                    ----
>    lock(&cxl_root_key);
>                                 lock(acpi_scan_lock);
>                                 lock(&cxl_root_key);
>    lock(&cxl_nvdimm_bridge_key);
> 
> ---
> 
> These stem from holding nvdimm_bus_lock() over hibernate_quiet_exec()
> which walks the entire system device topology taking device_lock() along
> the way. The nvdimm_bus_lock() is protecting against unregistration,
> multiple simultaneous ops callers, and preventing activate_show() from
> racing activate_store(). For the first 2, the lock is redundant.
> Unregistration already flushes all ops users, and sysfs already prevents
> multiple threads to be active in an ops handler at the same time. For
> the last userspace should already be waiting for its last
> activate_store() to complete, and does not need activate_show() to flush
> the write side, so this lock usage can be deleted in these attributes.
> 
> Fixes: 48001ea50d17 ("PM, libnvdimm: Add runtime firmware activation support")
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
> Changes since v3:
> - Remove nvdimm_bus_lock() from all ->capability() invocations (Ira)
> 
>  drivers/nvdimm/core.c |    9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/drivers/nvdimm/core.c b/drivers/nvdimm/core.c
> index 144926b7451c..d91799b71d23 100644
> --- a/drivers/nvdimm/core.c
> +++ b/drivers/nvdimm/core.c
> @@ -368,9 +368,7 @@ static ssize_t capability_show(struct device *dev,
>  	if (!nd_desc->fw_ops)
>  		return -EOPNOTSUPP;
>  
> -	nvdimm_bus_lock(dev);
>  	cap = nd_desc->fw_ops->capability(nd_desc);
> -	nvdimm_bus_unlock(dev);
>  
>  	switch (cap) {
>  	case NVDIMM_FWA_CAP_QUIESCE:
> @@ -395,10 +393,8 @@ static ssize_t activate_show(struct device *dev,
>  	if (!nd_desc->fw_ops)
>  		return -EOPNOTSUPP;
>  
> -	nvdimm_bus_lock(dev);
>  	cap = nd_desc->fw_ops->capability(nd_desc);
>  	state = nd_desc->fw_ops->activate_state(nd_desc);
> -	nvdimm_bus_unlock(dev);
>  
>  	if (cap < NVDIMM_FWA_CAP_QUIESCE)
>  		return -EOPNOTSUPP;
> @@ -443,7 +439,6 @@ static ssize_t activate_store(struct device *dev,
>  	else
>  		return -EINVAL;
>  
> -	nvdimm_bus_lock(dev);
>  	state = nd_desc->fw_ops->activate_state(nd_desc);
>  
>  	switch (state) {
> @@ -461,7 +456,6 @@ static ssize_t activate_store(struct device *dev,
>  	default:
>  		rc = -ENXIO;
>  	}
> -	nvdimm_bus_unlock(dev);
>  
>  	if (rc == 0)
>  		rc = len;
> @@ -484,10 +478,7 @@ static umode_t nvdimm_bus_firmware_visible(struct kobject *kobj, struct attribut
>  	if (!nd_desc->fw_ops)
>  		return 0;
>  
> -	nvdimm_bus_lock(dev);
>  	cap = nd_desc->fw_ops->capability(nd_desc);
> -	nvdimm_bus_unlock(dev);
> -
>  	if (cap < NVDIMM_FWA_CAP_QUIESCE)
>  		return 0;
>  
> 
