Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687A61D618C;
	Thu, 30 Oct 2025 16:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761843383; cv=none; b=o8tv4F/3gus9fwCVoRD3vtRUAFTPk5hqrBuUmkU7wcybNdFFVQlsLFSauBhqILiEMmukA6Petxy6GcRqL3l2A/GE0MiaV4BSAEQLGB0JV/l6zX9loCjKH02UtV2w7luaaiTIGiWu/0dN3OzVqx9UB/IYmzRAfEYeyoplHc3Vqic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761843383; c=relaxed/simple;
	bh=Z7sOU0bbDMmS+MjdgUDB2NUz/zjHubwdouBstkH1zHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XMKMYjdupZLgVHZW+K5wyWhZBXekclD1NK7bKWK5VgKu1+wP3FhjCwKsbgJYD6kLx8d+TgswK+AUr4LlwkrjrI/rU/F5mWaroEB25viaTJXV4rUMlHCCoML7MDJKfePIulehGRFxF5nN811BzJ6LYJqtz8nqlhAG9eWy0VhuCDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BjBfTlHI; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BjBfTlHI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761843381; x=1793379381;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Z7sOU0bbDMmS+MjdgUDB2NUz/zjHubwdouBstkH1zHI=;
  b=BjBfTlHIFo81kZI07ZNUQJZlO+Xv1wCpF0v4fx6ZYB1h017ja3CwhA60
   cwd53q38l35MQPbU8I5aKuRVd/uGD1mjOZ1aT35kZ7JYoun3cJlVui3Ri
   Ykox43B2Wn2fMo9Y9x/EH8UvGxKVfKP7o/d6TvOQSeKvWwkngNJjcE0js
   z82o3QKtaCXSebflD6fKldMGJXfVanYHSuq3zms6gmCcyI5NZyoVEtXCb
   YDzlKE9QOPK/JXj4f4Y6hG4mHbtS2k+y1g34MepZNfGm0VZOmkVenIHBb
   wfF3Wg58HM4F51HtxchpZWZZIw0FaXMSX8pLMlSnExoObqDuWO1O7i1Hq
   w==;
X-CSE-ConnectionGUID: gJXKP5+QRaCiH9iZhfvbrA==
X-CSE-MsgGUID: eWPqo+5fS2+e6ZQ1bRZ1IA==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="64142949"
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="scan'208";a="64142949"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 09:56:21 -0700
X-CSE-ConnectionGUID: THjspqanTAqkPD84sDVyug==
X-CSE-MsgGUID: I0pdvgYXSCuF8LZtURSo9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="scan'208";a="186448828"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO [10.125.110.3]) ([10.125.110.3])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 09:56:19 -0700
Message-ID: <8d7e51d5-ab51-442a-a015-77653d0fb684@intel.com>
Date: Thu, 30 Oct 2025 09:56:17 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/pci: replace use of system_wq with system_percpu_wq
To: Marco Crivellari <marco.crivellari@suse.com>,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michal Hocko <mhocko@suse.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
References: <20251030163839.307752-1-marco.crivellari@suse.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251030163839.307752-1-marco.crivellari@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/30/25 9:38 AM, Marco Crivellari wrote:
> Currently if a user enqueue a work item using schedule_delayed_work() the
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
> 
> This lack of consistency cannot be addressed without refactoring the API.
> 
> system_wq should be the per-cpu workqueue, yet in this name nothing makes
> that clear, so replace system_wq with system_percpu_wq.
> 
> The old wq (system_wq) will be kept for a few release cycles.
> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>> ---
>  drivers/cxl/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index bd100ac31672..0be4e508affe 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -136,7 +136,7 @@ static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
>  	if (opcode == CXL_MBOX_OP_SANITIZE) {
>  		mutex_lock(&cxl_mbox->mbox_mutex);
>  		if (mds->security.sanitize_node)
> -			mod_delayed_work(system_wq, &mds->security.poll_dwork, 0);
> +			mod_delayed_work(system_percpu_wq, &mds->security.poll_dwork, 0);
>  		mutex_unlock(&cxl_mbox->mbox_mutex);
>  	} else {
>  		/* short-circuit the wait in __cxl_pci_mbox_send_cmd() */

