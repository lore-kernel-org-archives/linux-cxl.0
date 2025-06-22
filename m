Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830283B280;
	Sun, 22 Jun 2025 12:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750595000; cv=pass; b=fh+ra8vKv0G4KHo2Zit0NbYtkqsKg5fWLt/JggZCZhco4iAjOJ+iFoOeQtZiwTLee3tlJE04NYzis7q1FlXegGjA5SN45Ovw/AeBxwftAi4SqN6lsZU4w9x8SpNTPojqcfQqLR7nZEzgbtED7yoFyhBVyx/3GKbIm63Q0yQZLp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750595000; c=relaxed/simple;
	bh=AMSOAWWVOFJvEDzxiAwPh2T23dWsgFRifbT3d9tqSzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SaFy6iLa6Ztw7MaHR99CUYXderc7d1KWe5qRSMkAaRzCotYWSPDz6WGl0ckHfWwNCF4GCbCiNs7LqOXhqOsd5n4XABRowQxWfpZNyzgE6lR5ekzOGkbMB5JzSiwHFujOaVqgRommWJOKMmqUi3Z1hB04r7A+5pZsSHMmrlZMCxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=ZevDwm0a; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="ZevDwm0a"
ARC-Seal: i=1; a=rsa-sha256; t=1750594971; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SX/V7OGFpGXcrF9vBbSLVZx7WjDemyvuBoU3piZ4RwxxF33LYBLd8wckUSjYHZQK+iTrUSDT7cMYat1Cvj14mDAmd4dLSHuncIEb87NMQPN+4iTMxcbP6bz3CJOpBaLBde5kESdHUu0czWzlvq7Zykf7pQTVC7fkb/IPhMlo5Ko=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1750594971; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=uSiG/3gBEYd1VHCUlyJol4GjDktqY17ZQKmr4r2esEU=; 
	b=lY72QQB1HIkkB+iHy+rPokaI9RBcIft+Svk29rTtWFxvccPChAvSL3emlv+zvidtFBvBwB18UsxST6xWnGi4/jqpUJrXapRNiX753hpq0eLrskk0hlVCnUUmUxIyTTYaO/Qwh+RuxOCW0kW+2s8uHdcS1Bb0FIwwouRaYiBVv5M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1750594971;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=uSiG/3gBEYd1VHCUlyJol4GjDktqY17ZQKmr4r2esEU=;
	b=ZevDwm0akhhOorhHDYOInARgaw2Phc4DXfPcBlFQZbwXyL4AN0d8HhjqKz0y29Xm
	AGvHZatK0koT1HbcV5rDlrBtXFD+HmoYL7kmagLt0txc0SSyErPBUjRLhXMjIfHq3Ds
	EPuDL18MC+cCSJPvy9kq7bGHOI6WorYG6zwYAbBo=
Received: by mx.zohomail.com with SMTPS id 1750594968815854.4851211512889;
	Sun, 22 Jun 2025 05:22:48 -0700 (PDT)
Message-ID: <50a01a17-4afc-415d-b5c8-9a84e3bdf191@zohomail.com>
Date: Sun, 22 Jun 2025 20:22:45 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/memdev: automate cleanup with __free()
To: Pranav Tyagi <pranav.tyagi03@gmail.com>
Cc: rrichter@amd.com, peterz@infradead.org, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250622120958.475765-1-pranav.tyagi03@gmail.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250622120958.475765-1-pranav.tyagi03@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr0801122797eaaf48ae49aa6da0c583de0000df12df7d2ad8da596ba8ec4e3a1be439638fbf2a1741c432f0:zu08011227a7ae67b27c69a00ec2136e3d000095794a72c15f733e2cfc4d4b1d3b203fa59acd848be5fb9c99:rf0801122d8ee8aa98ca620e132b75e91200004593d96275e5b9b74a185107a4616c8d67d80e2bdfd413a7446c77e2d3b3fe:ZohoMail
X-ZohoMailClient: External

On 6/22/2025 8:09 PM, Pranav Tyagi wrote:
> Use the scope based resource management (defined in linux/cleanup.h) to
> automate the lifetime control of struct cxl_mbox_transfer_fw. This
> eliminates explicit kfree() calls and makes the code more robust and
> maintainable in presence of early returns.
>
> Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
> ---
>  drivers/cxl/core/memdev.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index f88a13adf7fa..be73a6099cb6 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -7,6 +7,7 @@
>  #include <linux/slab.h>
>  #include <linux/idr.h>
>  #include <linux/pci.h>
> +#include <linux/cleanup.h>
>  #include <cxlmem.h>
>  #include "trace.h"
>  #include "core.h"
> @@ -802,11 +803,11 @@ static int cxl_mem_activate_fw(struct cxl_memdev_state *mds, int slot)
>  static int cxl_mem_abort_fw_xfer(struct cxl_memdev_state *mds)
>  {
>  	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
> -	struct cxl_mbox_transfer_fw *transfer;
>  	struct cxl_mbox_cmd mbox_cmd;
>  	int rc;
>  
> -	transfer = kzalloc(struct_size(transfer, data, 0), GFP_KERNEL);
> +	struct cxl_mbox_transfer_fw *transfer __free(kfree) =
> +		kzalloc(struct_size(transfer, data, 0), GFP_KERNEL);
>  	if (!transfer)
>  		return -ENOMEM;
>  
> @@ -822,7 +823,6 @@ static int cxl_mem_abort_fw_xfer(struct cxl_memdev_state *mds)
>  	transfer->action = CXL_FW_TRANSFER_ACTION_ABORT;
>  
>  	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
> -	kfree(transfer);
>  	return rc;
the rc can be removed with your change, can be "return cxl_internal_send_cmd(cxl_mbox, &mbox_cmd)".
>  }
>  
> @@ -880,7 +880,7 @@ static enum fw_upload_err cxl_fw_write(struct fw_upload *fwl, const u8 *data,
>  	struct cxl_dev_state *cxlds = &mds->cxlds;
>  	struct cxl_mailbox *cxl_mbox = &cxlds->cxl_mbox;
>  	struct cxl_memdev *cxlmd = cxlds->cxlmd;
> -	struct cxl_mbox_transfer_fw *transfer;
> +	struct cxl_mbox_transfer_fw *transfer __free(kfree);
>  	struct cxl_mbox_cmd mbox_cmd;
>  	u32 cur_size, remaining;
>  	size_t size_in;
> @@ -970,7 +970,6 @@ static enum fw_upload_err cxl_fw_write(struct fw_upload *fwl, const u8 *data,
>  	rc = FW_UPLOAD_ERR_NONE;
>  
>  out_free:
> -	kfree(transfer);
>  	return rc;
>  }
>  

I believe all "goto out_free" in the function are not needed with your change.


Ming

