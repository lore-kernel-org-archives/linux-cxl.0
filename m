Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794933101;
	b=S9+YOdOs/8wRWG+otqb0ganaLfNKKup9yueTm1NSjeOV+/cs1H3LAwd1WtNJJqQ3lBgD
	 VwXS7Uw5Ahxz4hhPzMSyihdcQgHA4qwFvm5LA3qnZCJ7XGKhGy9XTlcQYZpJzWPh+aLRR
	 AKUZfYQ3t2+L8cLjwH8S6rnCvjH9yTCJ6my29acFmTwfrJfrU2lknNVy/1muCd88Q8EIh
	 qT22e0OlLTKpwCiYUz7j+/Z0UL+/c329QXkL47uT9TCpP+zqPGlNOxddTZOY+JQdexG4R
	 CamUhnehg5JZ6JPgDd1rSW4HY6sbpP3rGqbAannN7je5kK8eBCmA1y1aG9r7PxS22Xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794933101;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=klc70XDRhRALXW38BytkfWqdxOwY9GV3JkdolktdUCU=;
	b=slo3nflwYQVxjn/U47A4H62jjGJC4FJtvWW23bAr0TtJUkozgOlKHM/YPZPJsAg35GKj
	 W5Tp+iUnQhR+CqKyEN0PRRLYblP+0ZG1/0O+43oXolJsItep/Nv/ijVmfXsbyXe2Dd0NF
	 YvIoCCJJUJXWqkT9gaJq9C1DLFSEFwSM2XC7F/eziypwWLrSvKIUZ5ke1K7GlCvvlJvaQ
	 vfZFkBRw+38AgseqESbY83+8opawUZ/FVhnGKFo7FLtEKdubDTudh3H8g1dkxu9cs1RtI
	 5Sz+K05o3RPhUztBMJgK3atGqxfft5r+0RunLPALs7IJtF7jivRX9Fz1viACKJOXDmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=l87MFkth;
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB41C606A31C;
	Tue, 17 Nov 2026 16:31:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB41C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=l87MFkth
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794933101; x=1826469101;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hW4Sk03/s2YczAJvgqD+XV/7eqG5kWZ+LxAMp9ATzW8=;
  b=l87MFkthECsWEuxLtxsevsxHnii1VWx6YZ+z27X6lRgnBHDEcNmgjevy
   ASR+1S7vIHnZnNfK8dZ/INbBIn8JRmzgx6piudCcEcsC/LRUxXFVi3+X6
   3SboS3C7xz8uytGfSHWhfFlHkzuAo50HD8H36fPzcFxji+QilHPpXtGJF
   6qN9givipNH2+oJ1HnqMU+Og+9OeZHtmobFNp8GDuAEJtSxjiw0VBG9ow
   2372LmIOFkVjQAMZJF0bvb7YGvXWtwWplrWuaFOUEq9dn+VvWkkFMXw5W
   s1IVA9Qt8Gp4l1eP/VdysYZ0ZMgrEkNeB9e+YR0DeqQyA8XoTnhKWjP1A
   w==;
X-CSE-ConnectionGUID: YYtqWNG3Shqk5sMK8FAejA==
X-CSE-MsgGUID: Pq8YxYAkT/mmaa9V58Nsrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3753640"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3753640"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 08:31:39 -0800
X-CSE-ConnectionGUID: TybchLpBQJKS3KI53iQw3w==
X-CSE-MsgGUID: 2SIp/gisS8uXDx6fUEF6Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9739703"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.108.197]) ([10.125.108.197])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 08:31:38 -0800
Message-ID: <774e98a2-1b7c-479e-89b8-8672885f2fca@intel.com>
Date: Tue, 17 Nov 2026 09:31:37 -0700
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] cxl/mbox: Use mapped errno to determine command
 status
To: Li Ming <ming.li@zohomail.com>, dave@stgolabs.net, jic23@kernel.org,
 alison.schofield@intel.com, vishal.l.verma@intel.com, djbw@kernel.org,
 iweiny@kernel.org, icheng@nvidia.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261116070938.3675205-1-ming.li@zohomail.com>
 <20261116070938.3675205-2-ming.li@zohomail.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20261116070938.3675205-2-ming.li@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/16/26 12:09 AM, Li Ming wrote:
> cxl_mbox_cmd_rctable already maps all mailbox command return codes to
> errno values. Use the returned errno directly instead of checking
> mailbox return codes separately to determine whether a command succeeded
> or failed.
> 
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

Applied to cxl/next:
ecd99b9602b2

> ---
> v3:
> - No change.
> v2:
> - New patch.
> ---
>  drivers/cxl/core/mbox.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 55828a836c01..bd91b03c4d21 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -270,9 +270,9 @@ int cxl_internal_send_cmd(struct cxl_mailbox *cxl_mbox,
>  	if (rc)
>  		return rc;
>  
> -	if (mbox_cmd->return_code != CXL_MBOX_CMD_RC_SUCCESS &&
> -	    mbox_cmd->return_code != CXL_MBOX_CMD_RC_BACKGROUND)
> -		return cxl_mbox_cmd_rc2errno(mbox_cmd);
> +	rc = cxl_mbox_cmd_rc2errno(mbox_cmd);
> +	if (rc)
> +		return rc;
>  
>  	if (!out_size)
>  		return 0;

