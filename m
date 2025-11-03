Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A022FE593;
	Mon,  3 Nov 2025 23:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762213465; cv=none; b=RiwMx9s0KVlUm2ZyU2fcj6OdIcwcyMeAfhXETRKBSSRox0y8RjFKooXrRBybyOByg5cWH7G8Qh3M0ONVDkahX5bnqE0NajeirstyHfosePVi4MGOivV/trcVTq/XUkiAcKU4tyWq3pPxYTIRZWi4Tf9X76EhDaMErEjKiKFEuEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762213465; c=relaxed/simple;
	bh=4p1XAIgil+xci6N2vO4OA62EVqXe4tJ+TRXALK+NU6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EGIXlW0W9Kr8eRMfF/cshB4jUDM6b5KINu8deiiIt/XoaYHKr7dXz5owMzrG1XA+vWvSNcGxoRj2toz+y7KGLILUF05CdUP3B5/oL39xcunPn7xR0PBMgYR6ON0KgqdZ1WBdBch0P85aGyd3MtvVE7xap45VucFx/XIlVoXGMWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DnhZdf1r; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DnhZdf1r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762213463; x=1793749463;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4p1XAIgil+xci6N2vO4OA62EVqXe4tJ+TRXALK+NU6g=;
  b=DnhZdf1rBH9GgJU8Q1/MSnKZgoq7FqGwlyEJ0v7CfCwsh+2Kn50iQA/u
   Bx8V+2aaUEoCtE9ILudoj/S+dKlahaEIeLyLI3CJbnWDhT4sA8OoKa254
   x+5os7wWTf2XnSSWeKZitRED3uomVavAwWC+5clNtKg4ihXlTKvHwilyJ
   mHQMfNwDzpAJl+5SL7jvfEyL3R/r2sWvBY7jVp0Mxk/WkGzQYX7zutb3P
   C5AYlNsc7kUFrLTH0vxNSzXWFz9uXBT9wluLdMHxL++DeZhzsb+fp87FZ
   CANoeJ0J1INQm/h1WX1o+6q4bohlzw9+eOqlYLOST7i24/1U/aIAGstNO
   g==;
X-CSE-ConnectionGUID: mZdyP9ocSyeM5GWUd/u+bg==
X-CSE-MsgGUID: fzYXH5AGQ0mrp5e8F/FYSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="81707363"
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="81707363"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 15:44:16 -0800
X-CSE-ConnectionGUID: Rhfyo2cgTZ+9jsGylf4fdg==
X-CSE-MsgGUID: CaywF8dgSwO88EnWyneC9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="186678565"
Received: from dwesterg-mobl1.amr.corp.intel.com (HELO [10.125.110.133]) ([10.125.110.133])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 15:44:15 -0800
Message-ID: <ce2f5f34-8855-41eb-9f4e-6bdaaaae90b4@intel.com>
Date: Mon, 3 Nov 2025 16:44:14 -0700
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

Applied to cxl/next
952e9057e66c17a9718232664368ffdaca468f93

> ---
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

