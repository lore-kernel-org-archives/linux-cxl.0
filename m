Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8D82E2EF9;
	Tue, 24 Jun 2025 14:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750776202; cv=none; b=FriP7AC/Ybo10IcIvsUpNH/RRp5/kHEwjjDyLZXAoc+RJ0wkA/nlxwU/cdddL2L6Jib1Sh3EwR7xupI5+dV/ObtxKBu2zNI/J4ithti0kb77NiJVntu89C47MM18Dp1SQW0TKvR+86hQCL43Hot0MqTkJcEePg3O29/GctPFViU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750776202; c=relaxed/simple;
	bh=kBH2XMaNUtF536dyGQwy+MLisydRW31h9neokM1Na4w=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cTo7VavPhOKbDAY8EgeFPgvhHtzep4xddmdxQtYHcsUXPYD0ov3TGK1e+0YV12Z9eGpZeQDXc4hSV0f+kzCVT7ZKmwHmZfAP1ZK/snlrYO+3RrNm0ox9gJVlDa3E56n2v6Iko6sWCgwbI7OpldtdhXicfGMhqoioS0pkAFlUVQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bRSL63spBz6D9C5;
	Tue, 24 Jun 2025 22:40:46 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A5CB61402EA;
	Tue, 24 Jun 2025 22:43:16 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 24 Jun
 2025 16:43:16 +0200
Date: Tue, 24 Jun 2025 15:43:14 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Pranav Tyagi <pranav.tyagi03@gmail.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <ming.li@zohomail.com>, <rrichter@amd.com>,
	<peterz@infradead.org>, <skhan@linuxfoundation.org>,
	<linux-kernel-mentees@lists.linux.dev>
Subject: Re: [PATCH v2] cxl/memdev: automate cleanup with __free()
Message-ID: <20250624154314.00004fde@huawei.com>
In-Reply-To: <20250623083841.364002-1-pranav.tyagi03@gmail.com>
References: <20250623083841.364002-1-pranav.tyagi03@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 23 Jun 2025 14:08:41 +0530
Pranav Tyagi <pranav.tyagi03@gmail.com> wrote:

> Use the scope based resource management (defined in linux/cleanup.h) to
> automate the lifetime control of struct cxl_mbox_transfer_fw. This
> eliminates explicit kfree() calls and makes the code more robust and
> maintainable in presence of early returns.
> 
> Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>

Resend as I accidentally only sent 1st reply to Pranav.

> ---
>  drivers/cxl/core/memdev.c | 21 ++++++++-------------
>  1 file changed, 8 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index f88a13adf7fa..38f4449f9740 100644
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
> @@ -802,11 +803,10 @@ static int cxl_mem_activate_fw(struct cxl_memdev_state *mds, int slot)
>  static int cxl_mem_abort_fw_xfer(struct cxl_memdev_state *mds)
>  {
>  	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
> -	struct cxl_mbox_transfer_fw *transfer;
>  	struct cxl_mbox_cmd mbox_cmd;
> -	int rc;
> -
> -	transfer = kzalloc(struct_size(transfer, data, 0), GFP_KERNEL);
> +	
> +	struct cxl_mbox_transfer_fw *transfer __free(kfree) =
> +		kzalloc(struct_size(transfer, data, 0), GFP_KERNEL);

This one is fine.

>  	if (!transfer)
>  		return -ENOMEM;
>  
> @@ -821,9 +821,7 @@ static int cxl_mem_abort_fw_xfer(struct cxl_memdev_state *mds)
>  
>  	transfer->action = CXL_FW_TRANSFER_ACTION_ABORT;
>  
> -	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
> -	kfree(transfer);
> -	return rc;
> +	return cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>  }
>  
>  static void cxl_fw_cleanup(struct fw_upload *fwl)
> @@ -880,7 +878,7 @@ static enum fw_upload_err cxl_fw_write(struct fw_upload *fwl, const u8 *data,
>  	struct cxl_dev_state *cxlds = &mds->cxlds;
>  	struct cxl_mailbox *cxl_mbox = &cxlds->cxl_mbox;
>  	struct cxl_memdev *cxlmd = cxlds->cxlmd;
> -	struct cxl_mbox_transfer_fw *transfer;
> +	struct cxl_mbox_transfer_fw *transfer __free(kfree);

This one is not.

Look at the comments in cleanup.h and consider if this obeys the rules
on use of this feature that are laid out there.  As it stands you will have
kfree() of an uninitialized pointer with unpredictable results in some
of the error paths.

>  	struct cxl_mbox_cmd mbox_cmd;
>  	u32 cur_size, remaining;
>  	size_t size_in;
> @@ -949,7 +947,7 @@ static enum fw_upload_err cxl_fw_write(struct fw_upload *fwl, const u8 *data,
>  	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>  	if (rc < 0) {
>  		rc = FW_UPLOAD_ERR_RW_ERROR;
> -		goto out_free;
> +		return rc;
>  	}
>  
>  	*written = cur_size;
> @@ -963,14 +961,11 @@ static enum fw_upload_err cxl_fw_write(struct fw_upload *fwl, const u8 *data,
>  			dev_err(&cxlmd->dev, "Error activating firmware: %d\n",
>  				rc);
>  			rc = FW_UPLOAD_ERR_HW_ERROR;
> -			goto out_free;
> +			return rc;
>  		}
>  	}
>  
>  	rc = FW_UPLOAD_ERR_NONE;

return FW_UPLOAD_ERR_NONE;

> -
> -out_free:
> -	kfree(transfer);
>  	return rc;
>  }
>  

