Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1502921B9C5;
	Thu,  8 Jan 2026 16:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767888523; cv=none; b=prGtMJhqcnFKMohh95jpXEuAp+ouYy7FZPeN4VcsuRiVMwYHPq4KbN4dOEMn459El45xdifcVnC5S5rqu6Bch+yeQ8TpjD/LkL6anKT0L0wa2ayA8lefy8rTXfEE5I1HO/k406Inj5ihI3yBDSE3uZT/Xm0mYu/OkvMdV33gTfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767888523; c=relaxed/simple;
	bh=Nt0nEjSdwh+7d6YTXB4uo25bCCuH25fYNI9EoLGB5UQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UMwxRfdProv2jeqc7azDZljqNKFY2ZRFeF17cA4um5g8JGe55A7MuzjjrVDWKZYsOweDy8GGAPuDdpY3wtYyiO6KgTk/7Wfk0y8FvdOnQ5D8+2J0HR74zfXaeAc4bhTR86xjrIXc/Bt3VrTlx8GMP2bhZeDGZCYdFSEwIiauZhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dn8w06hV0zJ46B9;
	Fri,  9 Jan 2026 00:08:32 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 0602540563;
	Fri,  9 Jan 2026 00:08:38 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 8 Jan
 2026 16:08:37 +0000
Date: Thu, 8 Jan 2026 16:08:35 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] cxl/port: Fix target list setup for multiple
 decoders sharing the same dport
Message-ID: <20260108160835.0000092e@huawei.com>
In-Reply-To: <20260108101324.509667-1-rrichter@amd.com>
References: <20260108101324.509667-1-rrichter@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu, 8 Jan 2026 11:13:23 +0100
Robert Richter <rrichter@amd.com> wrote:

> If a switch port has more than one decoder that is using the same
> downstream port, the enumeration of the target lists may fail with:
> 
>  # dmesg | grep target.list
>  update_decoder_targets: cxl decoder1.0: dport3 found in target list, index 3
>  update_decoder_targets: cxl decoder1.0: dport2 found in target list, index 2
>  update_decoder_targets: cxl decoder1.0: dport0 found in target list, index 0
>  update_decoder_targets: cxl decoder2.0: dport3 found in target list, index 1
>  update_decoder_targets: cxl decoder4.0: dport3 found in target list, index 1
>  cxl_mem mem6: failed to find endpoint12:0000:00:01.4 in target list of decoder2.1
>  cxl_mem mem8: failed to find endpoint13:0000:20:01.4 in target list of decoder4.1
> 
> The case, that the same downstream port can be used in multiple target
> lists, is allowed and possible.
> 
> Fix the update of the target list. Enumerate all children of the
> switch port and do not stop the iteration after the first matching
> target was found.
> 
> With the fix applied:
> 
>  # dmesg | grep target.list
>  update_decoder_targets: cxl decoder1.0: dport2 found in target list, index 2
>  update_decoder_targets: cxl decoder1.0: dport0 found in target list, index 0
>  update_decoder_targets: cxl decoder1.0: dport3 found in target list, index 3
>  update_decoder_targets: cxl decoder2.0: dport3 found in target list, index 1
>  update_decoder_targets: cxl decoder2.1: dport3 found in target list, index 1
>  update_decoder_targets: cxl decoder4.0: dport3 found in target list, index 1
>  update_decoder_targets: cxl decoder4.1: dport3 found in target list, index 1
> 
> Analyzing the conditions when this happens:
> 
> 1) A dport is shared by multiple decoders.
> 
> 2) The decoders have interleaving configured (ways > 1).
> 
> The configuration above has the following hierarchy details (fixed
> version):
> 
>  root0
>  |_
>  | |
>  | decoder0.1

Hi Robert,

I'm struggling a bit to align this with the above prints. Where is
decoder1.0 for example?  As it's below the root port, I think it's the
host bridge decoder, which might be this one on your diagram?

Fix makes sense to me.

Jonathan


>  | ways: 2
>  | target_list: 0,1
>  |_______________________________________
>  |                                       |
>  | dport0                                | dport1
>  |                                       |
>  port2                                   port4
>  |                                       |
>  |___________________                    |_____________________
>  | |                 |                   | |                   |
>  | decoder2.0        decoder2.1          | decoder4.0          decoder4.1
>  | ways: 2           ways: 2             | ways: 2             ways: 2
>  | target_list: 2,3  target_list: 2,3    | target_list: 2,3    target_list: 2,3
>  |___________________                    |___________________
>  |                   |                   |                   |
>  | dport2            | dport3            | dport2            | dport3
>  |                   |                   |                   |
>  endpoint7           endpoint12          endpoint9           endpoint13
>  |_                  |_                  |_                  |_
>  | |                 | |                 | |                 | |
>  | decoder7.0        | decoder12.0       | decoder9.0        | decoder13.0
>  | decoder7.2        | decoder12.2       | decoder9.2        | decoder13.2
>  |                   |                   |                   |
>  mem3                mem5                mem6                mem8
> 
> Note: Device numbers vary for every boot.
> 
> Current kernel fails to enumerate endpoint12 and endpoint13 as the
> target list is not updated for the second decoder.
> 
> Fixes: 4f06d81e7c6a ("cxl: Defer dport allocation for switch ports")
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
> v2:
>  * updated sob-chain,
>  * added fixes tag (Dave).
> ---
>  drivers/cxl/core/port.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index fef3aa0c6680..3310dbfae9d6 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1590,7 +1590,7 @@ static int update_decoder_targets(struct device *dev, void *data)
>  			cxlsd->target[i] = dport;
>  			dev_dbg(dev, "dport%d found in target list, index %d\n",
>  				dport->port_id, i);
> -			return 1;
> +			return 0;
>  		}
>  	}
>  
> 
> base-commit: 88c72bab77aaf389beccf762e112828253ca0564
> prerequisite-patch-id: f44102a7b095afa1588a5cac012ec2e0d852c021

